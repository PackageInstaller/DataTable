using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Net;
using System.Net.Sockets;
using System.Threading;

namespace Telepathy;

public class Server : Common
{
	public Action<int, string> OnConnected;

	public Action<int, ArraySegment<byte>> OnData;

	public Action<int> OnDisconnected;

	public TcpListener listener;

	private Thread listenerThread;

	public int SendQueueLimit = 10000;

	public int ReceiveQueueLimit = 10000;

	protected MagnificentReceivePipe receivePipe;

	private readonly ConcurrentDictionary<int, ConnectionState> clients = new ConcurrentDictionary<int, ConnectionState>();

	private int counter;

	public int ReceivePipeTotalCount => receivePipe.TotalCount;

	public bool Active
	{
		get
		{
			if (listenerThread != null)
			{
				return listenerThread.IsAlive;
			}
			return false;
		}
	}

	public int NextConnectionId()
	{
		int num = Interlocked.Increment(ref counter);
		if (num == int.MaxValue)
		{
			throw new Exception("connection id limit reached: " + num);
		}
		return num;
	}

	public Server(int MaxMessageSize)
		: base(MaxMessageSize)
	{
	}

	private void Listen(int port)
	{
		try
		{
			listener = TcpListener.Create(port);
			listener.Server.NoDelay = NoDelay;
			listener.Start();
			Log.Info("Server: listening port=" + port);
			while (true)
			{
				TcpClient client = listener.AcceptTcpClient();
				client.NoDelay = NoDelay;
				client.SendTimeout = SendTimeout;
				client.ReceiveTimeout = ReceiveTimeout;
				int connectionId = NextConnectionId();
				ConnectionState connection = new ConnectionState(client, MaxMessageSize);
				clients[connectionId] = connection;
				Thread sendThread = new Thread(() =>
				{
					try
					{
						ThreadFunctions.SendLoop(connectionId, client, connection.sendPipe, connection.sendPending);
					}
					catch (ThreadAbortException)
					{
					}
					catch (Exception ex5)
					{
						Log.Error("Server send thread exception: " + ex5);
					}
				});
				sendThread.IsBackground = true;
				sendThread.Start();
				Thread thread = new Thread(() =>
				{
					try
					{
						ThreadFunctions.ReceiveLoop(connectionId, client, MaxMessageSize, receivePipe, ReceiveQueueLimit);
						sendThread.Interrupt();
					}
					catch (Exception ex4)
					{
						Log.Error("Server client thread exception: " + ex4);
					}
				});
				thread.IsBackground = true;
				thread.Start();
			}
		}
		catch (ThreadAbortException ex)
		{
			Log.Info("Server thread aborted. That's okay. " + ex);
		}
		catch (SocketException ex2)
		{
			Log.Info("Server Thread stopped. That's okay. " + ex2);
		}
		catch (Exception ex3)
		{
			Log.Error("Server Exception: " + ex3);
		}
	}

	public bool Start(int port)
	{
		if (Active)
		{
			return false;
		}
		receivePipe = new MagnificentReceivePipe(MaxMessageSize);
		Log.Info("Server: Start port=" + port);
		listenerThread = new Thread(() =>
		{
			Listen(port);
		});
		listenerThread.IsBackground = true;
		listenerThread.Priority = ThreadPriority.BelowNormal;
		listenerThread.Start();
		return true;
	}

	public void Stop()
	{
		if (!Active)
		{
			return;
		}
		Log.Info("Server: stopping...");
		listener?.Stop();
		listenerThread?.Interrupt();
		listenerThread = null;
		foreach (KeyValuePair<int, ConnectionState> client2 in clients)
		{
			TcpClient client = client2.Value.client;
			try
			{
				client.GetStream().Close();
			}
			catch
			{
			}
			client.Close();
		}
		clients.Clear();
		counter = 0;
	}

	public bool Send(int connectionId, ArraySegment<byte> message)
	{
		if (message.Count <= MaxMessageSize)
		{
			if (clients.TryGetValue(connectionId, out var value))
			{
				if (value.sendPipe.Count < SendQueueLimit)
				{
					value.sendPipe.Enqueue(message);
					value.sendPending.Set();
					return true;
				}
				Log.Warning($"Server.Send: sendPipe for connection {connectionId} reached limit of {SendQueueLimit}. This can happen if we call send faster than the network can process messages. Disconnecting this connection for load balancing.");
				value.client.Close();
				return false;
			}
			return false;
		}
		Action<string> error = Log.Error;
		string text = message.Count.ToString();
		int maxMessageSize = MaxMessageSize;
		error("Server.Send: message too big: " + text + ". Limit: " + maxMessageSize);
		return false;
	}

	public string GetClientAddress(int connectionId)
	{
		try
		{
			if (clients.TryGetValue(connectionId, out var value))
			{
				return ((IPEndPoint)value.client.Client.RemoteEndPoint).Address.ToString();
			}
			return "";
		}
		catch (SocketException)
		{
			return "unknown";
		}
		catch (ObjectDisposedException)
		{
			return "Disposed";
		}
		catch (Exception)
		{
			return "";
		}
	}

	public bool Disconnect(int connectionId)
	{
		if (clients.TryGetValue(connectionId, out var value))
		{
			value.client.Close();
			Log.Info("Server.Disconnect connectionId:" + connectionId);
			return true;
		}
		return false;
	}

	public int Tick(int processLimit, Func<bool> checkEnabled = null)
	{
		if (receivePipe == null)
		{
			return 0;
		}
		for (int i = 0; i < processLimit; i++)
		{
			if (checkEnabled != null && !checkEnabled())
			{
				break;
			}
			if (!receivePipe.TryPeek(out var connectionId, out var eventType, out var data))
			{
				break;
			}
			switch (eventType)
			{
			case EventType.Connected:
				OnConnected?.Invoke(connectionId, GetClientAddress(connectionId));
				break;
			case EventType.Data:
				OnData?.Invoke(connectionId, data);
				break;
			case EventType.Disconnected:
			{
				OnDisconnected?.Invoke(connectionId);
				clients.TryRemove(connectionId, out var _);
				break;
			}
			}
			receivePipe.TryDequeue();
		}
		return receivePipe.TotalCount;
	}
}
