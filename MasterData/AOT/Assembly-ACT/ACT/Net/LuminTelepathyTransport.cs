using System;
using System.Diagnostics;
using System.Threading;
using System.Threading.Tasks;
using UnityEngine;

namespace ACT.Net;

internal sealed class LuminTelepathyTransport : INetTransport
{
	internal const int TICK_LIMIT = 100;

	private const int QUEUE_LIMIT = 10000;

	private readonly LuminTelepathyClient m_Client = new LuminTelepathyClient(131072)
	{
		NoDelay = true,
		SendTimeout = 5000,
		ReceiveTimeout = 0,
		SendQueueLimit = 10000,
		ReceiveQueueLimit = 10000
	};

	private TaskCompletionSource<bool> m_ConnectCompletion;

	private long m_ConnectDeadlineTimestamp;

	private int m_DisconnectPending;

	private bool m_ConnectionEstablished;

	public bool Connected
	{
		get
		{
			if (m_ConnectionEstablished)
			{
				return m_Client.Connected;
			}
			return false;
		}
	}

	public bool CanSend => Connected;

	public bool IsDisconnectNotificationPending
	{
		get
		{
			if (!Connected)
			{
				if (!m_Client.ReceiveThreadAlive && m_Client.ReceivePipeCount <= 0)
				{
					return Volatile.Read(ref m_DisconnectPending) != 0;
				}
				return true;
			}
			return false;
		}
	}

	public event Action<ArraySegment<byte>> DataReceived;

	public event Action Disconnected;

	public LuminTelepathyTransport()
	{
		m_Client.OnConnected = OnConnected;
		m_Client.OnData = OnData;
		m_Client.OnDisconnected = OnDisconnected;
	}

	public Task<bool> ConnectAsync(string host, int port, int timeoutMilliseconds)
	{
		if (m_ConnectCompletion != null || m_Client.Connecting || m_Client.Connected)
		{
			return Task.FromResult(result: false);
		}
		m_ConnectionEstablished = false;
		Interlocked.Exchange(ref m_DisconnectPending, 0);
		m_ConnectCompletion = new TaskCompletionSource<bool>(TaskCreationOptions.RunContinuationsAsynchronously);
		m_ConnectDeadlineTimestamp = Stopwatch.GetTimestamp() + (long)((double)timeoutMilliseconds / 1000.0 * (double)Stopwatch.Frequency);
		m_Client.Connect(host, port);
		return m_ConnectCompletion.Task;
	}

	public bool Send(ArraySegment<byte> data)
	{
		if (CanSend)
		{
			return m_Client.Send(data);
		}
		return false;
	}

	public void Disconnect()
	{
		m_ConnectionEstablished = false;
		Interlocked.Exchange(ref m_DisconnectPending, 0);
		TaskCompletionSource<bool> connectCompletion = m_ConnectCompletion;
		m_ConnectCompletion = null;
		m_Client.Disconnect();
		connectCompletion?.TrySetResult(result: false);
	}

	public void Tick()
	{
		NetThreadLog.Flush();
		m_Client.Tick(100);
		if (m_ConnectCompletion != null && Stopwatch.GetTimestamp() >= m_ConnectDeadlineTimestamp)
		{
			TaskCompletionSource<bool> connectCompletion = m_ConnectCompletion;
			m_ConnectCompletion = null;
			Debug.LogError("[NetFailure] [Telepathy] TCP connect deadline exceeded");
			m_Client.Disconnect();
			connectCompletion.TrySetResult(result: false);
		}
		if (Interlocked.Exchange(ref m_DisconnectPending, 0) != 0)
		{
			Disconnected?.Invoke();
		}
	}

	public void DebugLog()
	{
	}

	private void OnConnected()
	{
		m_ConnectionEstablished = true;
		TaskCompletionSource<bool> connectCompletion = m_ConnectCompletion;
		m_ConnectCompletion = null;
		connectCompletion?.TrySetResult(result: true);
	}

	private void OnData(ArraySegment<byte> data)
	{
		if (Volatile.Read(ref m_DisconnectPending) != 0)
		{
			return;
		}
		try
		{
			DataReceived?.Invoke(data);
		}
		catch (Exception ex)
		{
			ReportDisconnected("process received packet failed\n" + ex);
		}
	}

	private void OnDisconnected()
	{
		bool connectionEstablished = m_ConnectionEstablished;
		m_ConnectionEstablished = false;
		TaskCompletionSource<bool> connectCompletion = m_ConnectCompletion;
		m_ConnectCompletion = null;
		connectCompletion?.TrySetResult(result: false);
		if (connectionEstablished)
		{
			ReportDisconnected();
		}
	}

	private void ReportDisconnected(string message = null)
	{
		if (Interlocked.Exchange(ref m_DisconnectPending, 1) == 0 && !string.IsNullOrEmpty(message))
		{
			NetThreadLog.Enqueue("[NetFailure] [Telepathy] " + message, LogType.Error);
		}
	}
}
