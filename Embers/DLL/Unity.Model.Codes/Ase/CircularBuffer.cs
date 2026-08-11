#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.IO;
using GameFramework;

namespace Ase;

public class CircularBuffer : Stream
{
	public int ChunkSize = 8192;

	private readonly Queue<byte[]> bufferQueue = new Queue<byte[]>();

	private readonly Queue<byte[]> bufferCache = new Queue<byte[]>();

	private byte[] lastBuffer;

	public int LastIndex { get; set; }

	public int FirstIndex { get; set; }

	public override long Length
	{
		get
		{
			int num = 0;
			num = ((bufferQueue.Count != 0) ? ((bufferQueue.Count - 1) * ChunkSize + LastIndex - FirstIndex) : 0);
			if (num < 0)
			{
				Log.Error($"CircularBuffer count < 0: {bufferQueue.Count}, {LastIndex}, {FirstIndex}");
			}
			return num;
		}
	}

	public byte[] First
	{
		get
		{
			if (bufferQueue.Count == 0)
			{
				AddLast();
			}
			return bufferQueue.Peek();
		}
	}

	public byte[] Last
	{
		get
		{
			if (bufferQueue.Count == 0)
			{
				AddLast();
			}
			return lastBuffer;
		}
	}

	public override bool CanRead => true;

	public override bool CanSeek => false;

	public override bool CanWrite => true;

	public override long Position { get; set; }

	public CircularBuffer()
	{
		AddLast();
	}

	public void AddLast()
	{
		byte[] item = ((bufferCache.Count <= 0) ? new byte[ChunkSize] : bufferCache.Dequeue());
		bufferQueue.Enqueue(item);
		lastBuffer = item;
	}

	public void RemoveFirst()
	{
		bufferCache.Enqueue(bufferQueue.Dequeue());
	}

	public void Read(Stream stream, int count)
	{
		if (count > Length)
		{
			throw new Exception($"bufferList length < count, {Length} {count}");
		}
		int num = 0;
		while (num < count)
		{
			int num2 = count - num;
			if (ChunkSize - FirstIndex > num2)
			{
				stream.Write(First, FirstIndex, num2);
				FirstIndex += num2;
				num += num2;
			}
			else
			{
				stream.Write(First, FirstIndex, ChunkSize - FirstIndex);
				num += ChunkSize - FirstIndex;
				FirstIndex = 0;
				RemoveFirst();
			}
		}
	}

	public void Write(Stream stream)
	{
		int num = (int)(stream.Length - stream.Position);
		int num2 = 0;
		while (num2 < num)
		{
			if (LastIndex == ChunkSize)
			{
				AddLast();
				LastIndex = 0;
			}
			int num3 = num - num2;
			if (ChunkSize - LastIndex > num3)
			{
				stream.Read(lastBuffer, LastIndex, num3);
				LastIndex += num - num2;
				num2 += num3;
			}
			else
			{
				stream.Read(lastBuffer, LastIndex, ChunkSize - LastIndex);
				num2 += ChunkSize - LastIndex;
				LastIndex = ChunkSize;
			}
		}
	}

	public override int Read(byte[] buffer, int offset, int count)
	{
		if (buffer.Length < offset + count)
		{
			throw new Exception($"bufferList length < coutn, buffer length: {buffer.Length} {offset} {count}");
		}
		long length = Length;
		if (length < count)
		{
			count = (int)length;
		}
		int num = 0;
		while (num < count)
		{
			int num2 = count - num;
			if (ChunkSize - FirstIndex > num2)
			{
				Array.Copy(First, FirstIndex, buffer, num + offset, num2);
				FirstIndex += num2;
				num += num2;
			}
			else
			{
				Array.Copy(First, FirstIndex, buffer, num + offset, ChunkSize - FirstIndex);
				num += ChunkSize - FirstIndex;
				FirstIndex = 0;
				RemoveFirst();
			}
		}
		return count;
	}

	public override void Write(byte[] buffer, int offset, int count)
	{
		int num = 0;
		while (num < count)
		{
			if (LastIndex == ChunkSize)
			{
				AddLast();
				LastIndex = 0;
			}
			int num2 = count - num;
			if (ChunkSize - LastIndex > num2)
			{
				Array.Copy(buffer, num + offset, lastBuffer, LastIndex, num2);
				LastIndex += count - num;
				num += num2;
			}
			else
			{
				Array.Copy(buffer, num + offset, lastBuffer, LastIndex, ChunkSize - LastIndex);
				num += ChunkSize - LastIndex;
				LastIndex = ChunkSize;
			}
		}
	}

	public override void Flush()
	{
		throw new NotImplementedException();
	}

	public override long Seek(long offset, SeekOrigin origin)
	{
		throw new NotImplementedException();
	}

	public override void SetLength(long value)
	{
		throw new NotImplementedException();
	}
}
