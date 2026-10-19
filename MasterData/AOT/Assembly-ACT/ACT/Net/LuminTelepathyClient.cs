using System;
using System.Net.Sockets;
using System.Threading;
using Telepathy;
using UnityEngine;

namespace ACT.Net;

internal sealed class LuminTelepathyClient
{
	private sealed class ConnectionState
	{
		public TcpClient Client;

		public Thread ReceiveThread;

		public volatile bool Connecting;

		public readonly LuminReceivePipe ReceivePipe;

		public readonly LuminSendPipe SendPipe;

		public readonly ManualResetEvent SendPending = new ManualResetEvent(initialState: false);

		public bool Connected
		{
			get
			{
				if (Client?.Client != null)
				{
					return Client.Client.Connected;
				}
				return false;
			}
		}

		public ConnectionState(int maxMessageSize)
		{
			Client = new TcpClient();
			ReceivePipe = new LuminReceivePipe(maxMessageSize);
			SendPipe = new LuminSendPipe(maxMessageSize);
		}

		public void Dispose()
		{
			Client?.Close();
			ReceiveThread?.Interrupt();
			Connecting = false;
			ReceivePipe.Clear();
			SendPipe.Clear();
			Client = null;
		}
	}

	private readonly int m_MaxMessageSize;

	private ConnectionState m_State;

	public Action OnConnected;

	public Action<ArraySegment<byte>> OnData;

	public Action OnDisconnected;

	public int SendQueueLimit = 10000;

	public int ReceiveQueueLimit = 10000;

	public bool NoDelay = true;

	public int SendTimeout = 5000;

	public int ReceiveTimeout;

	public bool Connected
	{
		get
		{
			if (m_State != null)
			{
				return m_State.Connected;
			}
			return false;
		}
	}

	public bool Connecting
	{
		get
		{
			if (m_State != null)
			{
				return m_State.Connecting;
			}
			return false;
		}
	}

	public bool ReceiveThreadAlive
	{
		get
		{
			ConnectionState state = m_State;
			if (state == null)
			{
				return false;
			}
			return state.ReceiveThread?.IsAlive == true;
		}
	}

	public int ReceivePipeCount => m_State?.ReceivePipe.TotalCount ?? 0;

	public LuminTelepathyClient(int maxMessageSize)
	{
		m_MaxMessageSize = maxMessageSize;
	}

	public void Connect(string host, int port)
	{
		if (!Connecting && !Connected)
		{
			ConnectionState state = new ConnectionState(m_MaxMessageSize);
			m_State = state;
			state.Connecting = true;
			state.Client.Client = null;
			state.ReceiveThread = new Thread(() =>
			{
				ReceiveThreadFunction(state, host, port);
			})
			{
				IsBackground = true,
				Name = "LuminTelepathyReceive"
			};
			state.ReceiveThread.Start();
		}
	}

	public void Disconnect()
	{
		Interlocked.Exchange(ref m_State, null)?.Dispose();
	}

	public bool Send(ArraySegment<byte> message)
	{
		ConnectionState state = m_State;
		if (state == null || !state.Connected || message.Array == null || message.Count <= 0)
		{
			return false;
		}
		if (message.Count > m_MaxMessageSize)
		{
			NetThreadLog.Enqueue($"[NetFailure] [Telepathy] send packet exceeds {m_MaxMessageSize} bytes: {message.Count}", LogType.Error);
			return false;
		}
		if (state.SendPipe.Count >= SendQueueLimit)
		{
			NetThreadLog.Enqueue($"[NetFailure] [Telepathy] send queue reached limit {SendQueueLimit}", LogType.Error);
			state.Client.Close();
			return false;
		}
		state.SendPipe.Enqueue(message);
		state.SendPending.Set();
		return true;
	}

	public int Tick(int processLimit)
	{
		ConnectionState state = m_State;
		if (state == null)
		{
			return 0;
		}
		for (int i = 0; i < processLimit; i++)
		{
			if (!state.ReceivePipe.TryPeek(out var _, out var eventType, out var data))
			{
				break;
			}
			try
			{
				switch (eventType)
				{
				case Telepathy.EventType.Connected:
					OnConnected?.Invoke();
					break;
				case Telepathy.EventType.Data:
					OnData?.Invoke(data);
					break;
				case Telepathy.EventType.Disconnected:
					OnDisconnected?.Invoke();
					break;
				}
			}
			finally
			{
				state.ReceivePipe.TryDequeue();
			}
		}
		return state.ReceivePipe.TotalCount;
	}

	private void ReceiveThreadFunction(ConnectionState state, string host, int port)
	{
		Thread thread = null;
		TcpClient client = state.Client;
		try
		{
			client.Connect(host, port);
			state.Connecting = false;
			client.NoDelay = NoDelay;
			client.SendTimeout = SendTimeout;
			client.ReceiveTimeout = ReceiveTimeout;
			thread = new Thread(() =>
			{
				SendLoop(client, state.SendPipe, state.SendPending);
			})
			{
				IsBackground = true,
				Name = "LuminTelepathySend"
			};
			thread.Start();
			state.ReceivePipe.EnqueueEvent(Telepathy.EventType.Connected);
			ReceiveLoop(client, state.ReceivePipe);
		}
		catch (ThreadInterruptedException)
		{
		}
		catch (ObjectDisposedException)
		{
		}
		catch (Exception ex3)
		{
			NetThreadLog.Enqueue("[NetFailure] [Telepathy] receive thread exception: " + ex3, LogType.Error);
		}
		finally
		{
			state.Connecting = false;
			client.Close();
			state.ReceivePipe.EnqueueEvent(Telepathy.EventType.Disconnected);
			thread?.Interrupt();
		}
	}

	private void ReceiveLoop(TcpClient client, LuminReceivePipe receivePipe)
	{
		NetworkStream stream = client.GetStream();
		byte[] array = new byte[10];
		while (ReadExactly(stream, array, 0, array.Length))
		{
			int num = (int)NetUtils.BigEndianToUint(array, 6);
			if (num < 10 || num > m_MaxMessageSize)
			{
				NetThreadLog.Enqueue($"[NetFailure] [Telepathy] invalid Lumin packet length: {num}", LogType.Error);
				break;
			}
			byte[] array2 = receivePipe.Take(num);
			Buffer.BlockCopy(array, 0, array2, 0, array.Length);
			int length = num - array.Length;
			if (!ReadExactly(stream, array2, array.Length, length))
			{
				receivePipe.Return(array2);
				break;
			}
			receivePipe.EnqueueData(new ArraySegment<byte>(array2, 0, num));
			if (receivePipe.TotalCount >= ReceiveQueueLimit)
			{
				NetThreadLog.Enqueue($"[NetFailure] [Telepathy] receive queue reached limit {ReceiveQueueLimit}", LogType.Error);
				break;
			}
		}
	}

	private static bool ReadExactly(NetworkStream stream, byte[] buffer, int offset, int length)
	{
		int num;
		for (int i = 0; i < length; i += num)
		{
			num = stream.ReadSafely(buffer, offset + i, length - i);
			if (num == 0)
			{
				return false;
			}
		}
		return true;
	}

	private static void SendLoop(TcpClient client, LuminSendPipe sendPipe, ManualResetEvent sendPending)
	{
		NetworkStream networkStream = null;
		byte[] payload = null;
		try
		{
			networkStream = client.GetStream();
			while (client.Connected)
			{
				sendPending.Reset();
				if (!sendPipe.DequeueAndSerializeAll(ref payload, out var packetSize) || ThreadFunctions.SendMessagesBlocking(networkStream, payload, packetSize))
				{
					sendPending.WaitOne();
					continue;
				}
				break;
			}
		}
		catch (ThreadInterruptedException)
		{
		}
		catch (ObjectDisposedException)
		{
		}
		finally
		{
			networkStream?.Close();
			client.Close();
		}
	}
}
