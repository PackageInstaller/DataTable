using Com.ForbiddenByte.OSA.Core;

namespace Com.ForbiddenByte.OSA.DataHelpers;

public class BufferredDataSource<T>
{
	public delegate void ChunkReader(T[] into, int firstItemIndex, int countToRead);

	public int BUFFER_MAX_SIZE_DEFAULT = 100;

	private LazyList<T> _LazyList;

	private ChunkReader _ChunkReader;

	private int _BufferSize;

	private readonly bool _ExpectManualBufferUpdates;

	private T[] _ReadBuffer;

	public T this[int index] => _LazyList[index];

	public int Count => _LazyList.Count;

	public int ExistingCount => _LazyList.ExistingCount;

	public int BufferSize => _BufferSize;

	public BufferredDataSource(int totalCount, ChunkReader chunkReader, int bufferMaxSize, bool expectManualBufferUpdates)
	{
		if (bufferMaxSize < 1)
		{
			bufferMaxSize = BUFFER_MAX_SIZE_DEFAULT;
		}
		else if (bufferMaxSize > totalCount)
		{
			bufferMaxSize = totalCount;
		}
		_ChunkReader = chunkReader;
		_BufferSize = bufferMaxSize;
		_ExpectManualBufferUpdates = expectManualBufferUpdates;
		_ReadBuffer = new T[_BufferSize];
		_LazyList = new LazyList<T>(ValueCreator, totalCount);
	}

	public bool TryGetCachedValue(int index, out T tuple)
	{
		return _LazyList.TryGet(index, out tuple);
	}

	private T ValueCreator(int index)
	{
		if (!TryGetCachedValue(index, out var tuple))
		{
			int num = _BufferSize / 2;
			int num2 = index - num;
			int num3 = ((num2 >= 0) ? num2 : 0);
			int num4 = 0;
			if (num2 < 0)
			{
				num3 = 0;
				num4 = -num2;
			}
			long num5 = (long)index + (long)num + _BufferSize % 2;
			num5 += num4;
			if (num5 > int.MaxValue)
			{
				num5 = 2147483647L;
			}
			int num6 = (int)((num5 > Count) ? Count : num5);
			_LazyList.GetIndicesOfClosestExistingItems(index, out var prevIndex, out var nextIndex);
			if (prevIndex != -1 && num3 < prevIndex)
			{
				num3 = prevIndex + 1;
			}
			if (nextIndex != -1 && nextIndex < num6)
			{
				num6 = nextIndex;
			}
			int num7 = num6 - num3;
			_ChunkReader(_ReadBuffer, num3, num7);
			if (_ExpectManualBufferUpdates)
			{
				_LazyList.AllocateNullSlots(num3, num7);
			}
			else
			{
				_LazyList.SetOrUpdateManuallyCreatedValues(num3, _ReadBuffer, 0, num7);
			}
			return _LazyList.GetUnchecked(index);
		}
		return tuple;
	}

	public T GetValue(int index)
	{
		return _LazyList[index];
	}

	public T GetValueUnchecked(int index)
	{
		return _LazyList.GetUnchecked(index);
	}

	public void ManuallyUpdateCreatedValues(int firstItemIndex, T[] values, int readStartIndex, int readCount)
	{
		if (!_ExpectManualBufferUpdates)
		{
			throw new OSAException("Not supported because _ExpectManualBufferUpdates is false");
		}
		_LazyList.SetOrUpdateManuallyCreatedValues(firstItemIndex, values, readStartIndex, readCount);
	}
}
