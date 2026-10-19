using System;
using System.Collections.Generic;

namespace Telepathy;

public class MagnificentReceivePipe
{
	private struct Entry(int connectionId, EventType eventType, ArraySegment<byte> data)
	{
		public int connectionId = connectionId;

		public EventType eventType = eventType;

		public ArraySegment<byte> data = data;
	}

	private readonly Queue<Entry> queue = new Queue<Entry>();

	private Pool<byte[]> pool;

	private Dictionary<int, int> queueCounter = new Dictionary<int, int>();

	public int TotalCount
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

	public MagnificentReceivePipe(int MaxMessageSize)
	{
		pool = new Pool<byte[]>(() => new byte[MaxMessageSize]);
	}

	public int Count(int connectionId)
	{
		lock (this)
		{
			int value;
			return queueCounter.TryGetValue(connectionId, out value) ? value : 0;
		}
	}

	public void Enqueue(int connectionId, EventType eventType, ArraySegment<byte> message)
	{
		lock (this)
		{
			ArraySegment<byte> data = default;
			if (message != default(ArraySegment<byte>))
			{
				byte[] array = pool.Take();
				Buffer.BlockCopy(message.Array, message.Offset, array, 0, message.Count);
				data = new ArraySegment<byte>(array, 0, message.Count);
			}
			Entry item = new Entry(connectionId, eventType, data);
			queue.Enqueue(item);
			int num = Count(connectionId);
			queueCounter[connectionId] = num + 1;
		}
	}

	public bool TryPeek(out int connectionId, out EventType eventType, out ArraySegment<byte> data)
	{
		connectionId = 0;
		eventType = EventType.Disconnected;
		data = default;
		lock (this)
		{
			if (queue.Count > 0)
			{
				Entry entry = queue.Peek();
				connectionId = entry.connectionId;
				eventType = entry.eventType;
				data = entry.data;
				return true;
			}
			return false;
		}
	}

	public bool TryDequeue()
	{
		lock (this)
		{
			if (queue.Count > 0)
			{
				Entry entry = queue.Dequeue();
				if (entry.data != default(ArraySegment<byte>))
				{
					pool.Return(entry.data.Array);
				}
				queueCounter[entry.connectionId]--;
				if (queueCounter[entry.connectionId] == 0)
				{
					queueCounter.Remove(entry.connectionId);
				}
				return true;
			}
			return false;
		}
	}

	public void Clear()
	{
		lock (this)
		{
			while (queue.Count > 0)
			{
				Entry entry = queue.Dequeue();
				if (entry.data != default(ArraySegment<byte>))
				{
					pool.Return(entry.data.Array);
				}
			}
			queueCounter.Clear();
		}
	}
}
