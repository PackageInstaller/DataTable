using System;
using System.Net.Sockets;
using System.Threading;

namespace Telepathy;

public class Client : Common
{
	public Action OnConnected;

	public Action<ArraySegment<byte>> OnData;

	public Action OnDisconnected;

	public int SendQueueLimit = 10000;

	public int ReceiveQueueLimit = 10000;

	private ClientConnectionState state;

	public bool Connected
	{
		get
		{
			if (state != null)
			{
				return state.Connected;
			}
			return false;
		}
	}

	public bool Connecting
	{
		get
		{
			if (state != null)
			{
				return state.Connecting;
			}
			return false;
		}
	}

	public int ReceivePipeCount
	{
		get
		{
			if (state == null)
			{
				return 0;
			}
			return state.receivePipe.TotalCount;
		}
	}

	public Client(int MaxMessageSize)
		: base(MaxMessageSize)
	{
	}

	private static void ReceiveThreadFunction(ClientConnectionState state, string ip, int port, int MaxMessageSize, bool NoDelay, int SendTimeout, int ReceiveTimeout, int ReceiveQueueLimit)
	{
		Thread thread = null;
		try
		{
			state.client.Connect(ip, port);
			state.Connecting = false;
			state.client.NoDelay = NoDelay;
			state.client.SendTimeout = SendTimeout;
			state.client.ReceiveTimeout = ReceiveTimeout;
			thread = new Thread(() =>
			{
				ThreadFunctions.SendLoop(0, state.client, state.sendPipe, state.sendPending);
			});
			thread.IsBackground = true;
			thread.Start();
			ThreadFunctions.ReceiveLoop(0, state.client, MaxMessageSize, state.receivePipe, ReceiveQueueLimit);
		}
		catch (SocketException ex)
		{
			Log.Info("[Telepathy] Client Recv: failed to connect to ip=" + ip + " port=" + port + " reason=" + ex);
		}
		catch (ThreadInterruptedException)
		{
		}
		catch (ThreadAbortException)
		{
		}
		catch (ObjectDisposedException)
		{
		}
		catch (Exception ex5)
		{
			Log.Error("[Telepathy] Client Recv Exception: " + ex5);
		}
		state.receivePipe.Enqueue(0, EventType.Disconnected, default);
		thread?.Interrupt();
		state.Connecting = false;
		state.client?.Close();
	}

	public void Connect(string ip, int port)
	{
		if (Connecting || Connected)
		{
			Log.Warning("[Telepathy] Client can not create connection because an existing connection is connecting or connected");
			return;
		}
		state = new ClientConnectionState(MaxMessageSize);
		state.Connecting = true;
		state.client.Client = null;
		state.receiveThread = new Thread(() =>
		{
			ReceiveThreadFunction(state, ip, port, MaxMessageSize, NoDelay, SendTimeout, ReceiveTimeout, ReceiveQueueLimit);
		});
		state.receiveThread.IsBackground = true;
		state.receiveThread.Start();
	}

	public void Disconnect()
	{
		if (Connecting || Connected)
		{
			state.Dispose();
		}
	}

	public bool Send(ArraySegment<byte> message)
	{
		if (Connected)
		{
			if (message.Count <= MaxMessageSize)
			{
				if (state.sendPipe.Count < SendQueueLimit)
				{
					state.sendPipe.Enqueue(message);
					state.sendPending.Set();
					return true;
				}
				Log.Warning($"[Telepathy] Client.Send: sendPipe reached limit of {SendQueueLimit}. This can happen if we call send faster than the network can process messages. Disconnecting to avoid ever growing memory & latency.");
				state.client.Close();
				return false;
			}
			Action<string> error = Log.Error;
			string text = message.Count.ToString();
			int maxMessageSize = MaxMessageSize;
			error("[Telepathy] Client.Send: message too big: " + text + ". Limit: " + maxMessageSize);
			return false;
		}
		Log.Warning("[Telepathy] Client.Send: not connected!");
		return false;
	}

	public int Tick(int processLimit, Func<bool> checkEnabled = null)
	{
		if (state == null)
		{
			return 0;
		}
		for (int i = 0; i < processLimit; i++)
		{
			if (checkEnabled != null && !checkEnabled())
			{
				break;
			}
			if (!state.receivePipe.TryPeek(out var _, out var eventType, out var data))
			{
				break;
			}
			switch (eventType)
			{
			case EventType.Connected:
				OnConnected?.Invoke();
				break;
			case EventType.Data:
				OnData?.Invoke(data);
				break;
			case EventType.Disconnected:
				OnDisconnected?.Invoke();
				break;
			}
			state.receivePipe.TryDequeue();
		}
		return state.receivePipe.TotalCount;
	}
}
