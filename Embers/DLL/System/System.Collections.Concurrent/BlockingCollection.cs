using System.Collections.Generic;
using System.Diagnostics;
using System.Threading;

namespace System.Collections.Concurrent;

[DebuggerTypeProxy(typeof(BlockingCollectionDebugView<>))]
[DebuggerDisplay("Count = {Count}, Type = {_collection}")]
public class BlockingCollection<T> : IEnumerable<T>, IEnumerable, ICollection, IDisposable, IReadOnlyCollection<T>
{
	private IProducerConsumerCollection<T> _collection;

	private int _boundedCapacity;

	private SemaphoreSlim _freeNodes;

	private SemaphoreSlim _occupiedNodes;

	private bool _isDisposed;

	private CancellationTokenSource _consumersCancellationTokenSource;

	private CancellationTokenSource _producersCancellationTokenSource;

	private volatile int _currentAdders;

	public bool IsAddingCompleted
	{
		get
		{
			CheckDisposed();
			return _currentAdders == int.MinValue;
		}
	}

	public int Count
	{
		get
		{
			CheckDisposed();
			return _occupiedNodes.CurrentCount;
		}
	}

	bool ICollection.IsSynchronized
	{
		get
		{
			CheckDisposed();
			return false;
		}
	}

	object ICollection.SyncRoot
	{
		get
		{
			throw new NotSupportedException("The SyncRoot property may not be used for the synchronization of concurrent collections.");
		}
	}

	public BlockingCollection()
		: this((IProducerConsumerCollection<T>)new ConcurrentQueue<T>())
	{
	}

	public BlockingCollection(IProducerConsumerCollection<T> collection)
	{
		if (collection == null)
		{
			throw new ArgumentNullException("collection");
		}
		Initialize(collection, -1, collection.Count);
	}

	private void Initialize(IProducerConsumerCollection<T> collection, int boundedCapacity, int collectionCount)
	{
		_collection = collection;
		_boundedCapacity = boundedCapacity;
		_isDisposed = false;
		_consumersCancellationTokenSource = new CancellationTokenSource();
		_producersCancellationTokenSource = new CancellationTokenSource();
		if (boundedCapacity == -1)
		{
			_freeNodes = null;
		}
		else
		{
			_freeNodes = new SemaphoreSlim(boundedCapacity - collectionCount);
		}
		_occupiedNodes = new SemaphoreSlim(collectionCount);
	}

	public void Add(T item)
	{
		TryAddWithNoTimeValidation(item, -1, default(CancellationToken));
	}

	private bool TryAddWithNoTimeValidation(T item, int millisecondsTimeout, CancellationToken cancellationToken)
	{
		CheckDisposed();
		if (cancellationToken.IsCancellationRequested)
		{
			throw new OperationCanceledException("The operation was canceled.", cancellationToken);
		}
		if (IsAddingCompleted)
		{
			throw new InvalidOperationException("The collection has been marked as complete with regards to additions.");
		}
		bool flag = true;
		if (_freeNodes != null)
		{
			CancellationTokenSource cancellationTokenSource = null;
			try
			{
				flag = _freeNodes.Wait(0);
				if (!flag && millisecondsTimeout != 0)
				{
					cancellationTokenSource = CancellationTokenSource.CreateLinkedTokenSource(cancellationToken, _producersCancellationTokenSource.Token);
					flag = _freeNodes.Wait(millisecondsTimeout, cancellationTokenSource.Token);
				}
			}
			catch (OperationCanceledException)
			{
				if (cancellationToken.IsCancellationRequested)
				{
					throw new OperationCanceledException("The operation was canceled.", cancellationToken);
				}
				throw new InvalidOperationException("CompleteAdding may not be used concurrently with additions to the collection.");
			}
			finally
			{
				cancellationTokenSource?.Dispose();
			}
		}
		if (flag)
		{
			SpinWait spinWait = default(SpinWait);
			while (true)
			{
				int currentAdders = _currentAdders;
				if ((currentAdders & int.MinValue) != 0)
				{
					spinWait.Reset();
					while (_currentAdders != int.MinValue)
					{
						spinWait.SpinOnce();
					}
					throw new InvalidOperationException("The collection has been marked as complete with regards to additions.");
				}
				if (Interlocked.CompareExchange(ref _currentAdders, currentAdders + 1, currentAdders) == currentAdders)
				{
					break;
				}
				spinWait.SpinOnce();
			}
			try
			{
				bool flag2 = false;
				try
				{
					cancellationToken.ThrowIfCancellationRequested();
					flag2 = _collection.TryAdd(item);
				}
				catch
				{
					if (_freeNodes != null)
					{
						_freeNodes.Release();
					}
					throw;
				}
				if (!flag2)
				{
					throw new InvalidOperationException("The underlying collection didn't accept the item.");
				}
				_occupiedNodes.Release();
			}
			finally
			{
				Interlocked.Decrement(ref _currentAdders);
			}
		}
		return flag;
	}

	public void Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}

	protected virtual void Dispose(bool disposing)
	{
		if (!_isDisposed)
		{
			if (_freeNodes != null)
			{
				_freeNodes.Dispose();
			}
			_occupiedNodes.Dispose();
			_isDisposed = true;
		}
	}

	void ICollection.CopyTo(Array array, int index)
	{
		CheckDisposed();
		T[] array2 = _collection.ToArray();
		try
		{
			Array.Copy(array2, 0, array, index, array2.Length);
		}
		catch (ArgumentNullException)
		{
			throw new ArgumentNullException("array");
		}
		catch (ArgumentOutOfRangeException)
		{
			throw new ArgumentOutOfRangeException("index", index, "The index argument must be greater than or equal zero.");
		}
		catch (ArgumentException)
		{
			throw new ArgumentException("The number of elements in the collection is greater than the available space from index to the end of the destination array.", "index");
		}
		catch (RankException)
		{
			throw new ArgumentException("The array argument is multidimensional.", "array");
		}
		catch (InvalidCastException)
		{
			throw new ArgumentException("The array argument is of the incorrect type.", "array");
		}
		catch (ArrayTypeMismatchException)
		{
			throw new ArgumentException("The array argument is of the incorrect type.", "array");
		}
	}

	IEnumerator<T> IEnumerable<T>.GetEnumerator()
	{
		CheckDisposed();
		return _collection.GetEnumerator();
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return ((IEnumerable<T>)this).GetEnumerator();
	}

	private void CheckDisposed()
	{
		if (_isDisposed)
		{
			throw new ObjectDisposedException("BlockingCollection", "The collection has been disposed.");
		}
	}
}
