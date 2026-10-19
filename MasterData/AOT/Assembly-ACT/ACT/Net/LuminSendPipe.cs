using System;
using System.Collections.Generic;

namespace ACT.Net;

internal sealed class LuminSendPipe
{
	private readonly Queue<ArraySegment<byte>> m_Queue = new Queue<ArraySegment<byte>>(1);

	private readonly LuminBufferPool m_Pool;

	public int Count
	{
		get
		{
			lock (this)
			{
				return m_Queue.Count;
			}
		}
	}

	public LuminSendPipe(int maxMessageSize)
	{
		m_Pool = new LuminBufferPool(maxMessageSize);
	}

	public void Enqueue(ArraySegment<byte> message)
	{
		lock (this)
		{
			byte[] array = m_Pool.Take(message.Count);
			Buffer.BlockCopy(message.Array, message.Offset, array, 0, message.Count);
			m_Queue.Enqueue(new ArraySegment<byte>(array, 0, message.Count));
		}
	}

	public bool DequeueAndSerializeAll(ref byte[] payload, out int packetSize)
	{
		lock (this)
		{
			packetSize = 0;
			foreach (ArraySegment<byte> item in m_Queue)
			{
				packetSize += item.Count;
			}
			if (packetSize == 0)
			{
				return false;
			}
			if (payload == null || payload.Length < packetSize)
			{
				payload = new byte[packetSize];
			}
			int num = 0;
			while (m_Queue.Count > 0)
			{
				ArraySegment<byte> arraySegment = m_Queue.Dequeue();
				Buffer.BlockCopy(arraySegment.Array, arraySegment.Offset, payload, num, arraySegment.Count);
				num += arraySegment.Count;
				m_Pool.Return(arraySegment.Array);
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
				m_Pool.Return(m_Queue.Dequeue().Array);
			}
			m_Pool.Clear();
		}
	}
}
