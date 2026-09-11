using System;
using System.Collections.Generic;
using System.Net;

public class XNetworkManager
{
	public const int SOCKET_CLOSE_REASON_NO_REASON = -1;

	public const int SOCKET_CLOSE_REASON_EXCEPTION = -2;

	private static XNetworkManager sInstance;

	private SocketConnection mSocket;

	private Queue<SocketMsg> mMsgQueues = new Queue<SocketMsg>();

	private IEncrypt mEncrypt;

	public int MsgCount => mMsgQueues.Count;

	public static XNetworkManager Instance
	{
		get
		{
			if (sInstance == null)
			{
				sInstance = new XNetworkManager();
			}
			return sInstance;
		}
	}

	public IEncrypt Encrypt
	{
		get
		{
			return mEncrypt;
		}
		set
		{
			mEncrypt = value;
		}
	}

	public byte[] encrypt(byte[] data)
	{
		if (mEncrypt == null)
		{
			XLogger.Error("please set encrypt first");
		}
		return mEncrypt.Encrypt(data);
	}

	public byte[] decrypt(byte[] data)
	{
		if (mEncrypt == null)
		{
			XLogger.Error("please set encrypt first");
		}
		return mEncrypt.Decrypt(data);
	}

	public SocketMsg dequeueMsg()
	{
		lock (mMsgQueues)
		{
			return mMsgQueues.Dequeue();
		}
	}

	public XNetworkManager()
	{
		mSocket = new SocketConnection(tcpConnected, tcpClosed);
	}

	private void tcpClosed(int reason)
	{
	}

	private void tcpConnected()
	{
	}

	public void receivedTcpMsg(byte[] buffer)
	{
		receivedMsg(buffer);
	}

	public void receivedUdpMsg(byte[] buffer)
	{
		receivedMsg(buffer);
	}

	private void receivedMsg(byte[] buffer)
	{
		int msgtp = IPAddress.NetworkToHostOrder(BitConverter.ToInt16(buffer, 0));
		byte[] array = new byte[buffer.Length - 2];
		Array.Copy(buffer, 2, array, 0, array.Length);
		SocketMsg item = new SocketMsg(msgtp, array);
		lock (mMsgQueues)
		{
			mMsgQueues.Enqueue(item);
		}
	}

	public void handleMsg()
	{
		mSocket.handleMsg();
		RaknetConnection.Instance.handleMsgs();
	}
}
