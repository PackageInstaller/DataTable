using System.Collections.Generic;
using System.Diagnostics;
using System.Runtime.InteropServices;
using System.Threading;

namespace System.Collections.Concurrent;

[Serializable]
[DebuggerDisplay("Count = {Count}")]
[DebuggerTypeProxy(typeof(IProducerConsumerCollectionDebugView<>))]
public class ConcurrentQueue<T> : IProducerConsumerCollection<T>, IEnumerable<T>, IEnumerable, ICollection, IReadOnlyCollection<T>
{
	[DebuggerDisplay("Capacity = {Capacity}")]
	internal sealed class Segment
	{
		[StructLayout(LayoutKind.Auto)]
		[DebuggerDisplay("Item = {Item}, SequenceNumber = {SequenceNumber}")]
		internal struct Slot
		{
			public T Item;

			public int SequenceNumber;
		}

		internal readonly Slot[] _slots;

		internal readonly int _slotsMask;

		internal PaddedHeadAndTail _headAndTail;

		internal bool _preservedForObservation;

		internal bool _frozenForEnqueues;

		internal Segment _nextSegment;

		internal int Capacity => _slots.Length;

		internal int FreezeOffset => _slots.Length * 2;

		public Segment(int boundedLength)
		{
			_slots = new Slot[boundedLength];
			_slotsMask = boundedLength - 1;
			for (int i = 0; i < _slots.Length; i++)
			{
				_slots[i].SequenceNumber = i;
			}
		}

		internal void EnsureFrozenForEnqueues()
		{
			if (_frozenForEnqueues)
			{
				return;
			}
			_frozenForEnqueues = true;
			SpinWait spinWait = default(SpinWait);
			while (true)
			{
				int num = Volatile.Read(ref _headAndTail.Tail);
				if (Interlocked.CompareExchange(ref _headAndTail.Tail, num + FreezeOffset, num) != num)
				{
					spinWait.SpinOnce();
					continue;
				}
				break;
			}
		}

		public bool TryDequeue(out T item)
		{
			SpinWait spinWait = default(SpinWait);
			while (true)
			{
				int num = Volatile.Read(ref _headAndTail.Head);
				int num2 = num & _slotsMask;
				int num3 = Volatile.Read(ref _slots[num2].SequenceNumber) - (num + 1);
				if (num3 == 0)
				{
					if (Interlocked.CompareExchange(ref _headAndTail.Head, num + 1, num) == num)
					{
						item = _slots[num2].Item;
						if (!Volatile.Read(ref _preservedForObservation))
						{
							_slots[num2].Item = default(T);
							Volatile.Write(ref _slots[num2].SequenceNumber, num + _slots.Length);
						}
						return true;
					}
				}
				else if (num3 < 0)
				{
					bool frozenForEnqueues = _frozenForEnqueues;
					int num4 = Volatile.Read(ref _headAndTail.Tail);
					if (num4 - num <= 0 || (frozenForEnqueues && num4 - FreezeOffset - num <= 0))
					{
						break;
					}
				}
				spinWait.SpinOnce();
			}
			item = default(T);
			return false;
		}

		public bool TryEnqueue(T item)
		{
			SpinWait spinWait = default(SpinWait);
			while (true)
			{
				int num = Volatile.Read(ref _headAndTail.Tail);
				int num2 = num & _slotsMask;
				int num3 = Volatile.Read(ref _slots[num2].SequenceNumber) - num;
				if (num3 == 0)
				{
					if (Interlocked.CompareExchange(ref _headAndTail.Tail, num + 1, num) == num)
					{
						_slots[num2].Item = item;
						Volatile.Write(ref _slots[num2].SequenceNumber, num + 1);
						return true;
					}
				}
				else if (num3 < 0)
				{
					break;
				}
				spinWait.SpinOnce();
			}
			return false;
		}
	}

	private object _crossSegmentLock;

	private volatile Segment _tail;

	private volatile Segment _head;

	bool ICollection.IsSynchronized => false;

	object ICollection.SyncRoot
	{
		get
		{
			throw new NotSupportedException("The SyncRoot property may not be used for the synchronization of concurrent collections.");
		}
	}

	public int Count
	{
		get
		{
			SpinWait spinWait = default(SpinWait);
			Segment head;
			Segment tail;
			int headHead;
			int tailTail;
			while (true)
			{
				head = _head;
				tail = _tail;
				headHead = Volatile.Read(ref head._headAndTail.Head);
				int num = Volatile.Read(ref head._headAndTail.Tail);
				if (head == tail)
				{
					if (head == _head && head == _tail && headHead == Volatile.Read(ref head._headAndTail.Head) && num == Volatile.Read(ref head._headAndTail.Tail))
					{
						return GetCount(head, headHead, num);
					}
				}
				else
				{
					if (head._nextSegment != tail)
					{
						break;
					}
					int num2 = Volatile.Read(ref tail._headAndTail.Head);
					tailTail = Volatile.Read(ref tail._headAndTail.Tail);
					if (head == _head && tail == _tail && headHead == Volatile.Read(ref head._headAndTail.Head) && num == Volatile.Read(ref head._headAndTail.Tail) && num2 == Volatile.Read(ref tail._headAndTail.Head) && tailTail == Volatile.Read(ref tail._headAndTail.Tail))
					{
						return GetCount(head, headHead, num) + GetCount(tail, num2, tailTail);
					}
				}
				spinWait.SpinOnce();
			}
			SnapForObservation(out head, out headHead, out tail, out tailTail);
			return (int)GetCount(head, headHead, tail, tailTail);
		}
	}

	public ConcurrentQueue()
	{
		_crossSegmentLock = new object();
		_tail = (_head = new Segment(32));
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
			throw new ArgumentNullException("array");
		}
		ToArray().CopyTo(array, index);
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return ((IEnumerable<T>)this).GetEnumerator();
	}

	bool IProducerConsumerCollection<T>.TryAdd(T item)
	{
		Enqueue(item);
		return true;
	}

	public T[] ToArray()
	{
		SnapForObservation(out var head, out var headHead, out var tail, out var tailTail);
		T[] array = new T[GetCount(head, headHead, tail, tailTail)];
		using IEnumerator<T> enumerator = Enumerate(head, headHead, tail, tailTail);
		int num = 0;
		while (enumerator.MoveNext())
		{
			array[num++] = enumerator.Current;
		}
		return array;
	}

	private static int GetCount(Segment s, int head, int tail)
	{
		if (head != tail && head != tail - s.FreezeOffset)
		{
			head &= s._slotsMask;
			tail &= s._slotsMask;
			if (head >= tail)
			{
				return s._slots.Length - head + tail;
			}
			return tail - head;
		}
		return 0;
	}

	private static long GetCount(Segment head, int headHead, Segment tail, int tailTail)
	{
		long num = 0L;
		int num2 = ((head == tail) ? tailTail : Volatile.Read(ref head._headAndTail.Tail)) - head.FreezeOffset;
		if (headHead < num2)
		{
			headHead &= head._slotsMask;
			num2 &= head._slotsMask;
			num += ((headHead < num2) ? (num2 - headHead) : (head._slots.Length - headHead + num2));
		}
		if (head != tail)
		{
			for (Segment nextSegment = head._nextSegment; nextSegment != tail; nextSegment = nextSegment._nextSegment)
			{
				num += nextSegment._headAndTail.Tail - nextSegment.FreezeOffset;
			}
			num += tailTail - tail.FreezeOffset;
		}
		return num;
	}

	public void CopyTo(T[] array, int index)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		if (index < 0)
		{
			throw new ArgumentOutOfRangeException("index", "The index argument must be greater than or equal zero.");
		}
		SnapForObservation(out var head, out var headHead, out var tail, out var tailTail);
		long count = GetCount(head, headHead, tail, tailTail);
		if (index > array.Length - count)
		{
			throw new ArgumentException("The number of elements in the collection is greater than the available space from index to the end of the destination array.");
		}
		int num = index;
		using IEnumerator<T> enumerator = Enumerate(head, headHead, tail, tailTail);
		while (enumerator.MoveNext())
		{
			array[num++] = enumerator.Current;
		}
	}

	public IEnumerator<T> GetEnumerator()
	{
		SnapForObservation(out var head, out var headHead, out var tail, out var tailTail);
		return Enumerate(head, headHead, tail, tailTail);
	}

	private void SnapForObservation(out Segment head, out int headHead, out Segment tail, out int tailTail)
	{
		lock (_crossSegmentLock)
		{
			head = _head;
			tail = _tail;
			Segment segment = head;
			while (true)
			{
				segment._preservedForObservation = true;
				if (segment == tail)
				{
					break;
				}
				segment = segment._nextSegment;
			}
			tail.EnsureFrozenForEnqueues();
			headHead = Volatile.Read(ref head._headAndTail.Head);
			tailTail = Volatile.Read(ref tail._headAndTail.Tail);
		}
	}

	private T GetItemWhenAvailable(Segment segment, int i)
	{
		int num = (i + 1) & segment._slotsMask;
		if ((segment._slots[i].SequenceNumber & segment._slotsMask) != num)
		{
			SpinWait spinWait = default(SpinWait);
			while ((Volatile.Read(ref segment._slots[i].SequenceNumber) & segment._slotsMask) != num)
			{
				spinWait.SpinOnce();
			}
		}
		return segment._slots[i].Item;
	}

	private IEnumerator<T> Enumerate(Segment head, int headHead, Segment tail, int tailTail)
	{
		int headTail = ((head == tail) ? tailTail : Volatile.Read(ref head._headAndTail.Tail)) - head.FreezeOffset;
		if (headHead < headTail)
		{
			headHead &= head._slotsMask;
			headTail &= head._slotsMask;
			if (headHead < headTail)
			{
				for (int i = headHead; i < headTail; i++)
				{
					yield return GetItemWhenAvailable(head, i);
				}
			}
			else
			{
				for (int i = headHead; i < head._slots.Length; i++)
				{
					yield return GetItemWhenAvailable(head, i);
				}
				for (int i = 0; i < headTail; i++)
				{
					yield return GetItemWhenAvailable(head, i);
				}
			}
		}
		if (head == tail)
		{
			yield break;
		}
		for (Segment s = head._nextSegment; s != tail; s = s._nextSegment)
		{
			int i = s._headAndTail.Tail - s.FreezeOffset;
			for (int j = 0; j < i; j++)
			{
				yield return GetItemWhenAvailable(s, j);
			}
		}
		tailTail -= tail.FreezeOffset;
		for (int i = 0; i < tailTail; i++)
		{
			yield return GetItemWhenAvailable(tail, i);
		}
	}

	public void Enqueue(T item)
	{
		if (!_tail.TryEnqueue(item))
		{
			EnqueueSlow(item);
		}
	}

	private void EnqueueSlow(T item)
	{
		while (true)
		{
			Segment tail = _tail;
			if (tail.TryEnqueue(item))
			{
				break;
			}
			lock (_crossSegmentLock)
			{
				if (tail == _tail)
				{
					tail.EnsureFrozenForEnqueues();
					_tail = (tail._nextSegment = new Segment(tail._preservedForObservation ? 32 : Math.Min(tail.Capacity * 2, 1048576)));
				}
			}
		}
	}

	public bool TryDequeue(out T result)
	{
		if (!_head.TryDequeue(out result))
		{
			return TryDequeueSlow(out result);
		}
		return true;
	}

	private bool TryDequeueSlow(out T item)
	{
		while (true)
		{
			Segment head = _head;
			if (head.TryDequeue(out item))
			{
				return true;
			}
			if (head._nextSegment == null)
			{
				item = default(T);
				return false;
			}
			if (head.TryDequeue(out item))
			{
				break;
			}
			lock (_crossSegmentLock)
			{
				if (head == _head)
				{
					_head = head._nextSegment;
				}
			}
		}
		return true;
	}

	public void Clear()
	{
		lock (_crossSegmentLock)
		{
			_tail.EnsureFrozenForEnqueues();
			_tail = (_head = new Segment(32));
		}
	}
}
