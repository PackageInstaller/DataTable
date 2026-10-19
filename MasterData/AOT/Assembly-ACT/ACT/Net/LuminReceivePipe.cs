using System;
using System.Collections.Generic;
using Telepathy;

namespace ACT.Net;

internal sealed class LuminReceivePipe
{
	private readonly struct Entry(EventType eventType, ArraySegment<byte> data)
	{
		public readonly EventType EventType = eventType;

		public readonly ArraySegment<byte> Data = data;
	}

	private readonly Queue<Entry> m_Queue = new Queue<Entry>(1);

	private readonly LuminBufferPool m_Pool;

	public int TotalCount
	{
		get
		{
			lock (this)
			{
				return m_Queue.Count;
			}
		}
	}

	public LuminReceivePipe(int maxMessageSize)
	{
		m_Pool = new LuminBufferPool(maxMessageSize);
	}

	public byte[] Take(int requiredSize)
	{
		lock (this)
		{
			return m_Pool.Take(requiredSize);
		}
	}

	public void Return(byte[] buffer)
	{
		lock (this)
		{
			m_Pool.Return(buffer);
		}
	}

	public void EnqueueEvent(EventType eventType)
	{
		lock (this)
		{
			m_Queue.Enqueue(new Entry(eventType, default));
		}
	}

	public void EnqueueData(ArraySegment<byte> data)
	{
		lock (this)
		{
			m_Queue.Enqueue(new Entry(EventType.Data, data));
		}
	}

	public bool TryPeek(out int connectionId, out EventType eventType, out ArraySegment<byte> data)
	{
		lock (this)
		{
			connectionId = 0;
			if (m_Queue.Count == 0)
			{
				eventType = EventType.Disconnected;
				data = default;
				return false;
			}
			Entry entry = m_Queue.Peek();
			eventType = entry.EventType;
			data = entry.Data;
			return true;
		}
	}

	public bool TryDequeue()
	{
		lock (this)
		{
			if (m_Queue.Count == 0)
			{
				return false;
			}
			Entry entry = m_Queue.Dequeue();
			ArraySegment<byte> data = entry.Data;
			if (data.Array != null)
			{
				LuminBufferPool pool = m_Pool;
				data = entry.Data;
				pool.Return(data.Array);
			}
			return true;
		}
	}

	public void Clear()
	{
		lock (this)
		{
			while (m_Queue.Count > 0)
			{
				Entry entry = m_Queue.Dequeue();
				ArraySegment<byte> data = entry.Data;
				if (data.Array != null)
				{
					LuminBufferPool pool = m_Pool;
					data = entry.Data;
					pool.Return(data.Array);
				}
			}
			m_Pool.Clear();
		}
	}
}
