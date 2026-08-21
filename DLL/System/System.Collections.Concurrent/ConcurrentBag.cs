using System.Collections.Generic;
using System.Diagnostics;
using System.Threading;

namespace System.Collections.Concurrent;

[Serializable]
[DebuggerDisplay("Count = {Count}")]
[DebuggerTypeProxy(typeof(System.Collections.Concurrent.IProducerConsumerCollectionDebugView<>))]
public class ConcurrentBag<T> : IProducerConsumerCollection<T>, IEnumerable<T>, IEnumerable, ICollection, IReadOnlyCollection<T>
{
	private sealed class WorkStealingQueue
	{
		private volatile int _headIndex;

		private volatile int _tailIndex;

		private volatile T[] _array = new T[32];

		private volatile int _mask = 31;

		private int _addTakeCount;

		private int _stealCount;

		internal volatile int _currentOp;

		internal bool _frozen;

		internal readonly WorkStealingQueue _nextQueue;

		internal readonly int _ownerThreadId;

		internal int DangerousCount => _addTakeCount - _stealCount;

		internal WorkStealingQueue(WorkStealingQueue nextQueue)
		{
			_ownerThreadId = Environment.CurrentManagedThreadId;
			_nextQueue = nextQueue;
		}

		internal void LocalPush(T item, ref long emptyToNonEmptyListTransitionCount)
		{
			bool lockTaken = false;
			try
			{
				Interlocked.Exchange(ref _currentOp, 1);
				int num = _tailIndex;
				if (num == int.MaxValue)
				{
					_currentOp = 0;
					lock (this)
					{
						_headIndex &= _mask;
						num = (_tailIndex = num & _mask);
						Interlocked.Exchange(ref _currentOp, 1);
					}
				}
				int headIndex = _headIndex;
				if (!_frozen && ((headIndex < num - 1) & (num < headIndex + _mask)))
				{
					_array[num & _mask] = item;
					_tailIndex = num + 1;
				}
				else
				{
					_currentOp = 0;
					Monitor.Enter(this, ref lockTaken);
					headIndex = _headIndex;
					int num2 = num - headIndex;
					if (num2 >= _mask)
					{
						T[] array = new T[_array.Length << 1];
						int num3 = headIndex & _mask;
						if (num3 == 0)
						{
							Array.Copy(_array, 0, array, 0, _array.Length);
						}
						else
						{
							Array.Copy(_array, num3, array, 0, _array.Length - num3);
							Array.Copy(_array, 0, array, _array.Length - num3, num3);
						}
						_array = array;
						_headIndex = 0;
						num = (_tailIndex = num2);
						_mask = (_mask << 1) | 1;
					}
					_array[num & _mask] = item;
					_tailIndex = num + 1;
					if (num2 == 0)
					{
						Interlocked.Increment(ref emptyToNonEmptyListTransitionCount);
					}
					_addTakeCount -= _stealCount;
					_stealCount = 0;
				}
				checked
				{
					_addTakeCount++;
				}
			}
			finally
			{
				_currentOp = 0;
				if (lockTaken)
				{
					Monitor.Exit(this);
				}
			}
		}

		internal void LocalClear()
		{
			lock (this)
			{
				if (_headIndex < _tailIndex)
				{
					_headIndex = (_tailIndex = 0);
					_addTakeCount = (_stealCount = 0);
					Array.Clear(_array, 0, _array.Length);
				}
			}
		}

		internal bool TrySteal(out T result, bool take)
		{
			lock (this)
			{
				int headIndex = _headIndex;
				if (take)
				{
					if (headIndex < _tailIndex - 1 && _currentOp != 1)
					{
						SpinWait spinWait = default(SpinWait);
						do
						{
							spinWait.SpinOnce();
						}
						while (_currentOp == 1);
					}
					Interlocked.Exchange(ref _headIndex, headIndex + 1);
					if (headIndex < _tailIndex)
					{
						int num = headIndex & _mask;
						result = _array[num];
						_array[num] = default(T);
						_stealCount++;
						return true;
					}
					_headIndex = headIndex;
				}
				else if (headIndex < _tailIndex)
				{
					result = _array[headIndex & _mask];
					return true;
				}
			}
			result = default(T);
			return false;
		}

		internal int DangerousCopyTo(T[] array, int arrayIndex)
		{
			int headIndex = _headIndex;
			int dangerousCount = DangerousCount;
			for (int num = arrayIndex + dangerousCount - 1; num >= arrayIndex; num--)
			{
				array[num] = _array[headIndex++ & _mask];
			}
			return dangerousCount;
		}
	}

	[Serializable]
	private sealed class Enumerator : IEnumerator<T>, IDisposable, IEnumerator
	{
		private readonly T[] _array;

		private T _current;

		private int _index;

		public T Current => _current;

		object IEnumerator.Current
		{
			get
			{
				if (_index == 0 || _index == _array.Length + 1)
				{
					throw new InvalidOperationException("Enumeration has either not started or has already finished.");
				}
				return Current;
			}
		}

		public Enumerator(T[] array)
		{
			_array = array;
		}

		public bool MoveNext()
		{
			if (_index < _array.Length)
			{
				_current = _array[_index++];
				return true;
			}
			_index = _array.Length + 1;
			return false;
		}

		public void Reset()
		{
			_index = 0;
			_current = default(T);
		}

		public void Dispose()
		{
		}
	}

	private readonly ThreadLocal<WorkStealingQueue> _locals;

	private volatile WorkStealingQueue _workStealingQueues;

	private long _emptyToNonEmptyListTransitionCount;

	public int Count
	{
		get
		{
			if (_workStealingQueues == null)
			{
				return 0;
			}
			bool lockTaken = false;
			try
			{
				FreezeBag(ref lockTaken);
				return DangerousCount;
			}
			finally
			{
				UnfreezeBag(lockTaken);
			}
		}
	}

	private int DangerousCount
	{
		get
		{
			int num = 0;
			for (WorkStealingQueue workStealingQueue = _workStealingQueues; workStealingQueue != null; workStealingQueue = workStealingQueue._nextQueue)
			{
				num = checked(num + workStealingQueue.DangerousCount);
			}
			return num;
		}
	}

	bool ICollection.IsSynchronized => false;

	object ICollection.SyncRoot
	{
		get
		{
			throw new NotSupportedException("The SyncRoot property may not be used for the synchronization of concurrent collections.");
		}
	}

	private object GlobalQueuesLock => _locals;

	public ConcurrentBag()
	{
		_locals = new ThreadLocal<WorkStealingQueue>();
	}

	public void Add(T item)
	{
		GetCurrentThreadWorkStealingQueue(forceCreate: true).LocalPush(item, ref _emptyToNonEmptyListTransitionCount);
	}

	bool IProducerConsumerCollection<T>.TryAdd(T item)
	{
		Add(item);
		return true;
	}

	private WorkStealingQueue GetCurrentThreadWorkStealingQueue(bool forceCreate)
	{
		WorkStealingQueue workStealingQueue = _locals.Value;
		if (workStealingQueue == null)
		{
			if (!forceCreate)
			{
				return null;
			}
			workStealingQueue = CreateWorkStealingQueueForCurrentThread();
		}
		return workStealingQueue;
	}

	private WorkStealingQueue CreateWorkStealingQueueForCurrentThread()
	{
		lock (GlobalQueuesLock)
		{
			WorkStealingQueue workStealingQueues = _workStealingQueues;
			WorkStealingQueue workStealingQueue = ((workStealingQueues != null) ? GetUnownedWorkStealingQueue() : null);
			if (workStealingQueue == null)
			{
				workStealingQueue = (_workStealingQueues = new WorkStealingQueue(workStealingQueues));
			}
			_locals.Value = workStealingQueue;
			return workStealingQueue;
		}
	}

	private WorkStealingQueue GetUnownedWorkStealingQueue()
	{
		int currentManagedThreadId = Environment.CurrentManagedThreadId;
		for (WorkStealingQueue workStealingQueue = _workStealingQueues; workStealingQueue != null; workStealingQueue = workStealingQueue._nextQueue)
		{
			if (workStealingQueue._ownerThreadId == currentManagedThreadId)
			{
				return workStealingQueue;
			}
		}
		return null;
	}

	public void CopyTo(T[] array, int index)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array", "The array argument is null.");
		}
		if (index < 0)
		{
			throw new ArgumentOutOfRangeException("index", "The index argument must be greater than or equal zero.");
		}
		if (_workStealingQueues == null)
		{
			return;
		}
		bool lockTaken = false;
		try
		{
			FreezeBag(ref lockTaken);
			int dangerousCount = DangerousCount;
			if (index > array.Length - dangerousCount)
			{
				throw new ArgumentException("The number of elements in the collection is greater than the available space from index to the end of the destination array.", "index");
			}
			try
			{
				CopyFromEachQueueToArray(array, index);
			}
			catch (ArrayTypeMismatchException ex)
			{
				throw new InvalidCastException(ex.Message, ex);
			}
		}
		finally
		{
			UnfreezeBag(lockTaken);
		}
	}

	private int CopyFromEachQueueToArray(T[] array, int index)
	{
		int num = index;
		for (WorkStealingQueue workStealingQueue = _workStealingQueues; workStealingQueue != null; workStealingQueue = workStealingQueue._nextQueue)
		{
			num += workStealingQueue.DangerousCopyTo(array, num);
		}
		return num - index;
	}

	void ICollection.CopyTo(Array array, int index)
	{
		if (array is T[] array2)
		{
			CopyTo(array2, index);
			return;
		}
		if (array == null)
		{
			throw new ArgumentNullException("array", "The array argument is null.");
		}
		ToArray().CopyTo(array, index);
	}

	public T[] ToArray()
	{
		if (_workStealingQueues != null)
		{
			bool lockTaken = false;
			try
			{
				FreezeBag(ref lockTaken);
				int dangerousCount = DangerousCount;
				if (dangerousCount > 0)
				{
					T[] array = new T[dangerousCount];
					CopyFromEachQueueToArray(array, 0);
					return array;
				}
			}
			finally
			{
				UnfreezeBag(lockTaken);
			}
		}
		return Array.Empty<T>();
	}

	public void Clear()
	{
		if (_workStealingQueues == null)
		{
			return;
		}
		WorkStealingQueue currentThreadWorkStealingQueue = GetCurrentThreadWorkStealingQueue(forceCreate: false);
		if (currentThreadWorkStealingQueue != null)
		{
			currentThreadWorkStealingQueue.LocalClear();
			if (currentThreadWorkStealingQueue._nextQueue == null && currentThreadWorkStealingQueue == _workStealingQueues)
			{
				return;
			}
		}
		bool lockTaken = false;
		try
		{
			FreezeBag(ref lockTaken);
			for (WorkStealingQueue workStealingQueue = _workStealingQueues; workStealingQueue != null; workStealingQueue = workStealingQueue._nextQueue)
			{
				T result;
				while (workStealingQueue.TrySteal(out result, take: true))
				{
				}
			}
		}
		finally
		{
			UnfreezeBag(lockTaken);
		}
	}

	public IEnumerator<T> GetEnumerator()
	{
		return new Enumerator(ToArray());
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}

	private void FreezeBag(ref bool lockTaken)
	{
		Monitor.Enter(GlobalQueuesLock, ref lockTaken);
		WorkStealingQueue workStealingQueues = _workStealingQueues;
		for (WorkStealingQueue workStealingQueue = workStealingQueues; workStealingQueue != null; workStealingQueue = workStealingQueue._nextQueue)
		{
			Monitor.Enter(workStealingQueue, ref workStealingQueue._frozen);
		}
		Interlocked.MemoryBarrier();
		for (WorkStealingQueue workStealingQueue2 = workStealingQueues; workStealingQueue2 != null; workStealingQueue2 = workStealingQueue2._nextQueue)
		{
			if (workStealingQueue2._currentOp != 0)
			{
				SpinWait spinWait = default(SpinWait);
				do
				{
					spinWait.SpinOnce();
				}
				while (workStealingQueue2._currentOp != 0);
			}
		}
	}

	private void UnfreezeBag(bool lockTaken)
	{
		if (!lockTaken)
		{
			return;
		}
		for (WorkStealingQueue workStealingQueue = _workStealingQueues; workStealingQueue != null; workStealingQueue = workStealingQueue._nextQueue)
		{
			if (workStealingQueue._frozen)
			{
				workStealingQueue._frozen = false;
				Monitor.Exit(workStealingQueue);
			}
		}
		Monitor.Exit(GlobalQueuesLock);
	}
}
