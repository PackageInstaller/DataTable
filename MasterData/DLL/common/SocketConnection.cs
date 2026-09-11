using System;
using System.IO;
using System.Net;
using System.Net.Sockets;

public class SocketConnection
{
	public TcpClient client;

	private const int MAX_READ = 1048576;

	private byte[] byteBuffer = new byte[1048576];

	private int mUndealOffset;

	private int mReceiveOffset;

	private ConnectState mState = ConnectState.CS_DISCONNECTED;

	private NetworkStream mStream;

	public bool debug;

	private const int HEAD_LEN = 6;

	private Action mConnnectedCallback;

	private Action<int> mDisconnectedCallback;

	public ConnectState State => mState;

	public SocketConnection(Action connectedCb, Action<int> disconnectedCb)
	{
		mConnnectedCallback = connectedCb;
		mDisconnectedCallback = disconnectedCb;
	}

	public void connectServer(string host, int port)
	{
		client = null;
		client = new TcpClient();
		client.SendTimeout = 1000;
		client.ReceiveTimeout = 1000;
		client.NoDelay = true;
		try
		{
			if (mState == ConnectState.CS_CONNECTING || mState == ConnectState.CS_CONNECTED)
			{
				close(-1);
			}
			mState = ConnectState.CS_CONNECTING;
			client.BeginConnect(host, port, onConnect, null);
		}
		catch (Exception)
		{
			close(-2);
		}
	}

	private void onConnect(IAsyncResult asr)
	{
		mState = ConnectState.CS_CONNECTED;
		mStream = client.GetStream();
		if (mConnnectedCallback != null)
		{
			mConnnectedCallback();
		}
	}

	public void sendMessage(byte[] message)
	{
		try
		{
			MemoryStream memoryStream = null;
			using (memoryStream = new MemoryStream())
			{
				memoryStream.Position = 0L;
				BinaryWriter binaryWriter = new BinaryWriter(memoryStream);
				binaryWriter.Write(message);
				binaryWriter.Flush();
				if (client != null && client.Connected)
				{
					byte[] array = memoryStream.ToArray();
					mStream.BeginWrite(array, 0, array.Length, onWrite, null);
				}
			}
		}
		catch (Exception)
		{
			close(-2);
		}
	}

	private void onWrite(IAsyncResult r)
	{
		try
		{
			mStream.EndWrite(r);
		}
		catch (Exception)
		{
			close(-2);
		}
	}

	public void handleMsg()
	{
		if (mState != ConnectState.CS_CONNECTED)
		{
			return;
		}
		readBuffers();
		int num = mReceiveOffset - mUndealOffset;
		if (num < 0)
		{
			num = 1048576 - mUndealOffset + mReceiveOffset;
		}
		while (num >= 6)
		{
			int num2 = mUndealOffset;
			int num3 = IPAddress.NetworkToHostOrder(BitConverter.ToInt32(getBuffer(4), 0));
			if (num < num3 || num3 <= 0)
			{
				mUndealOffset = num2;
				break;
			}
			byte[] array = getBuffer(num3 - 6 + 2);
			if (EncryptTools.sGodBts != null)
			{
				array = XNetworkManager.Instance.decrypt(array);
			}
			XNetworkManager.Instance.receivedTcpMsg(array);
			num = mReceiveOffset - mUndealOffset;
			if (num < 0)
			{
				num = 1048576 - mUndealOffset + mReceiveOffset;
			}
		}
	}

	private byte[] getBuffer(int len, byte[] bf = null, int offset = 0)
	{
		if (bf == null)
		{
			bf = new byte[len];
		}
		if (len <= 0)
		{
			return bf;
		}
		int val = 1048576 - mUndealOffset;
		int num = Math.Min(val, len);
		Array.Copy(byteBuffer, mUndealOffset, bf, offset, num);
		offset += num;
		mUndealOffset += num;
		if (mUndealOffset == 1048576)
		{
			mUndealOffset = 0;
		}
		if (offset != bf.Length)
		{
			return getBuffer(len - offset, bf, offset);
		}
		return bf;
	}

	private void readBuffers()
	{
		try
		{
			int available = client.Available;
			if (available > 0)
			{
				int num = Math.Min(1048576 - mReceiveOffset, available);
				mStream.Read(byteBuffer, mReceiveOffset, num);
				mReceiveOffset += num;
				if (1048576 - mReceiveOffset == 0)
				{
					mReceiveOffset = 0;
				}
				if (client.Available > 0)
				{
					readBuffers();
				}
			}
		}
		catch (Exception)
		{
			close(-2);
		}
	}

	public void close(int reason)
	{
		mState = ConnectState.CS_DISCONNECTED;
		if (client != null)
		{
			if (client.Connected)
			{
				client.Close();
			}
			client = null;
		}
		mReceiveOffset = 0;
		mUndealOffset = 0;
		if (mStream != null)
		{
			mStream.Close();
		}
		if (mDisconnectedCallback != null)
		{
			mDisconnectedCallback(reason);
		}
	}
}
