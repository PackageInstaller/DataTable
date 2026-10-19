using System;
using System.Collections.Generic;

namespace ACT.Net;

internal sealed class LuminBufferPool
{
	public const int MIN_BUFFER_SIZE = 1024;

	private const int MAX_RETAINED_PER_BUCKET = 4;

	private readonly Stack<byte[]>[] m_Buckets;

	private readonly int m_MaxBufferSize;

	public LuminBufferPool(int maxBufferSize)
	{
		if (maxBufferSize < 1024 || (maxBufferSize & (maxBufferSize - 1)) != 0)
		{
			throw new ArgumentOutOfRangeException("maxBufferSize");
		}
		m_MaxBufferSize = maxBufferSize;
		int num = 1;
		for (int num2 = 1024; num2 < maxBufferSize; num2 <<= 1)
		{
			num++;
		}
		m_Buckets = new Stack<byte[]>[num];
	}

	public byte[] Take(int requiredSize)
	{
		int bucketIndex = GetBucketIndex(requiredSize, out var bucketSize);
		Stack<byte[]> stack = m_Buckets[bucketIndex];
		if (stack == null || stack.Count <= 0)
		{
			return new byte[bucketSize];
		}
		return stack.Pop();
	}

	public void Return(byte[] buffer)
	{
		if (buffer == null || buffer.Length < 1024 || buffer.Length > m_MaxBufferSize)
		{
			return;
		}
		int bucketIndex = GetBucketIndex(buffer.Length, out var bucketSize);
		if (bucketSize == buffer.Length)
		{
			Stack<byte[]> stack = m_Buckets[bucketIndex];
			if (stack == null)
			{
				stack = new Stack<byte[]>(1);
				m_Buckets[bucketIndex] = stack;
			}
			if (stack.Count < 4)
			{
				stack.Push(buffer);
			}
		}
	}

	public void Clear()
	{
		for (int i = 0; i < m_Buckets.Length; i++)
		{
			m_Buckets[i]?.Clear();
		}
	}

	private int GetBucketIndex(int requiredSize, out int bucketSize)
	{
		if (requiredSize <= 0 || requiredSize > m_MaxBufferSize)
		{
			throw new ArgumentOutOfRangeException("requiredSize");
		}
		int num = 0;
		bucketSize = 1024;
		while (bucketSize < requiredSize)
		{
			bucketSize <<= 1;
			num++;
		}
		return num;
	}
}
