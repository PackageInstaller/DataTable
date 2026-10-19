using System;
using System.Collections.Generic;

namespace Telepathy;

public class MagnificentSendPipe
{
	private readonly Queue<ArraySegment<byte>> queue = new Queue<ArraySegment<byte>>();

	private Pool<byte[]> pool;

	public int Count
	{
		get
		{
			lock (this)
			{
				return queue.Count;
			}
		}
	}

	public int PoolCount
	{
		get
		{
			lock (this)
			{
				return pool.Count();
			}
		}
	}

	public MagnificentSendPipe(int MaxMessageSize)
	{
		pool = new Pool<byte[]>(() => new byte[MaxMessageSize]);
	}

	public void Enqueue(ArraySegment<byte> message)
	{
		lock (this)
		{
			byte[] array = pool.Take();
			Buffer.BlockCopy(message.Array, message.Offset, array, 0, message.Count);
			ArraySegment<byte> item = new ArraySegment<byte>(array, 0, message.Count);
			queue.Enqueue(item);
		}
	}

	public bool DequeueAndSerializeAll(ref byte[] payload, out int packetSize)
	{
		lock (this)
		{
			packetSize = 0;
			if (queue.Count == 0)
			{
				return false;
			}
			packetSize = 0;
			foreach (ArraySegment<byte> item in queue)
			{
				packetSize += 4 + item.Count;
			}
			if (payload == null || payload.Length < packetSize)
			{
				payload = new byte[packetSize];
			}
			int num = 0;
			while (queue.Count > 0)
			{
				ArraySegment<byte> arraySegment = queue.Dequeue();
				Utils.IntToBytesBigEndianNonAlloc(arraySegment.Count, payload, num);
				num += 4;
				Buffer.BlockCopy(arraySegment.Array, arraySegment.Offset, payload, num, arraySegment.Count);
				num += arraySegment.Count;
				pool.Return(arraySegment.Array);
			}
			return true;
		}
	}

	public void Clear()
	{
		lock (this)
		{
			while (queue.Count > 0)
			{
				pool.Return(queue.Dequeue().Array);
			}
		}
	}
}
