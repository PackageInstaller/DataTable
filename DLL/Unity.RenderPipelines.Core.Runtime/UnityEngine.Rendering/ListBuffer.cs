using System;
using Unity.Collections.LowLevel.Unsafe;

namespace UnityEngine.Rendering;

public struct ListBuffer<T> where T : unmanaged
{
	private unsafe T* m_BufferPtr;

	private int m_Capacity;

	private unsafe int* m_CountPtr;

	internal unsafe T* BufferPtr => m_BufferPtr;

	public unsafe int Count => *m_CountPtr;

	public int Capacity => m_Capacity;

	public unsafe ref T this[in int index]
	{
		get
		{
			if (index < 0 || index >= Count)
			{
				throw new IndexOutOfRangeException($"Expected a value between 0 and {Count}, but received {index}.");
			}
			return ref m_BufferPtr[index];
		}
	}

	public unsafe ListBuffer(T* bufferPtr, int* countPtr, int capacity)
	{
		m_BufferPtr = bufferPtr;
		m_Capacity = capacity;
		m_CountPtr = countPtr;
	}

	public unsafe ref T GetUnchecked(in int index)
	{
		return ref m_BufferPtr[index];
	}

	public unsafe bool TryAdd(in T value)
	{
		if (Count >= m_Capacity)
		{
			return false;
		}
		m_BufferPtr[Count] = value;
		(*m_CountPtr)++;
		return true;
	}

	public unsafe void CopyTo(T* dstBuffer, int startDstIndex, int copyCount)
	{
		UnsafeUtility.MemCpy(dstBuffer + startDstIndex, m_BufferPtr, UnsafeUtility.SizeOf<T>() * copyCount);
	}

	public unsafe bool TryCopyTo(ListBuffer<T> other)
	{
		if (other.Count + Count >= other.m_Capacity)
		{
			return false;
		}
		UnsafeUtility.MemCpy(other.m_BufferPtr + other.Count, m_BufferPtr, UnsafeUtility.SizeOf<T>() * Count);
		*other.m_CountPtr += Count;
		return true;
	}

	public unsafe bool TryCopyFrom(T* srcPtr, int count)
	{
		if (count + Count > m_Capacity)
		{
			return false;
		}
		UnsafeUtility.MemCpy(m_BufferPtr + Count, srcPtr, UnsafeUtility.SizeOf<T>() * count);
		*m_CountPtr += count;
		return true;
	}
}
