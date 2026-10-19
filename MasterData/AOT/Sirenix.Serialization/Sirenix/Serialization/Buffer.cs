using System;
using System.Collections.Generic;

namespace Sirenix.Serialization;

public sealed class Buffer<T> : IDisposable
{
	private static readonly object LOCK = new object();

	private static readonly List<Buffer<T>> FreeBuffers = new List<Buffer<T>>();

	private int count;

	private T[] array;

	private volatile bool isFree;

	public int Count
	{
		get
		{
			if (isFree)
			{
				throw new InvalidOperationException("Cannot access a buffer while it is freed.");
			}
			return count;
		}
	}

	public T[] Array
	{
		get
		{
			if (isFree)
			{
				throw new InvalidOperationException("Cannot access a buffer while it is freed.");
			}
			return array;
		}
	}

	public bool IsFree => isFree;

	private Buffer(int count)
	{
		array = new T[count];
		this.count = count;
		isFree = false;
	}

	public static Buffer<T> Claim(int minimumCapacity)
	{
		if (minimumCapacity < 0)
		{
			throw new ArgumentException("Requested size of buffer must be larger than or equal to 0.");
		}
		if (minimumCapacity < 256)
		{
			minimumCapacity = 256;
		}
		Buffer<T> buffer = null;
		lock (LOCK)
		{
			for (int i = 0; i < FreeBuffers.Count; i++)
			{
				Buffer<T> buffer2 = FreeBuffers[i];
				if (buffer2 != null && buffer2.count >= minimumCapacity)
				{
					buffer = buffer2;
					buffer.isFree = false;
					FreeBuffers[i] = null;
					break;
				}
			}
		}
		if (buffer == null)
		{
			buffer = new Buffer<T>(NextPowerOfTwo(minimumCapacity));
		}
		return buffer;
	}

	public static void Free(Buffer<T> buffer)
	{
		if (buffer == null)
		{
			throw new ArgumentNullException("buffer");
		}
		if (buffer.isFree)
		{
			return;
		}
		lock (LOCK)
		{
			if (buffer.isFree)
			{
				return;
			}
			buffer.isFree = true;
			bool flag = false;
			for (int i = 0; i < FreeBuffers.Count; i++)
			{
				if (FreeBuffers[i] == null)
				{
					FreeBuffers[i] = buffer;
					flag = true;
					break;
				}
			}
			if (!flag)
			{
				FreeBuffers.Add(buffer);
			}
		}
	}

	public void Free()
	{
		Free(this);
	}

	public void Dispose()
	{
		Free(this);
	}

	private static int NextPowerOfTwo(int v)
	{
		v--;
		v |= v >> 1;
		v |= v >> 2;
		v |= v >> 4;
		v |= v >> 8;
		v |= v >> 16;
		v++;
		return v;
	}
}
