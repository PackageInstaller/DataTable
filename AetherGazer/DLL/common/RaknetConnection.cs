using System;
using System.Runtime.InteropServices;
using AOT;

public class RaknetConnection
{
	public delegate void OnReceived(int len, IntPtr data);

	public delegate void OnConnected();

	public delegate void OnDisconnected(int reason);

	public delegate void OnLog(IntPtr lostr, int len);

	private const string mPluginName = "RakNet";

	private static RaknetConnection sInstance;

	private ConnectState mState;

	private Action mConnectedCallback;

	public static RaknetConnection Instance
	{
		get
		{
			if (sInstance == null)
			{
				sInstance = new RaknetConnection();
				init(onConnected, onDisconnected, onReceived, onLog);
			}
			return sInstance;
		}
	}

	public void connect(string host, int port, Action connectedcb)
	{
		Close();
		mConnectedCallback = connectedcb;
		if (dlConnect(host, port))
		{
			mState = ConnectState.CS_CONNECTING;
		}
		else
		{
			mState = ConnectState.CS_DISCONNECTED;
		}
		XLogger.Debug("try to connect raknet:{0}:{1}({2})", host, port, mState);
	}

	public void sendMsg(byte[] buffers)
	{
		if (mState == ConnectState.CS_CONNECTED && !dlSendData((uint)buffers.Length, buffers))
		{
			Close();
		}
	}

	public void handleMsgs()
	{
		if (mState != ConnectState.CS_DISCONNECTED)
		{
			dlUpdate();
		}
	}

	[MonoPInvokeCallback(typeof(OnConnected))]
	private static void onConnected()
	{
		sInstance.mState = ConnectState.CS_CONNECTED;
		if (sInstance.mConnectedCallback != null)
		{
			sInstance.mConnectedCallback();
		}
	}

	[MonoPInvokeCallback(typeof(OnDisconnected))]
	private static void onDisconnected(int reason)
	{
		sInstance.mState = ConnectState.CS_DISCONNECTED;
	}

	[MonoPInvokeCallback(typeof(OnLog))]
	private static void onLog(IntPtr lostr, int len)
	{
		byte[] array = new byte[len];
		Marshal.Copy(lostr, array, 0, len);
		string text = BitConverter.ToString(array);
		for (int i = 0; i <= text.Length / 100; i++)
		{
			XLogger.Debug(text.Substring(i * 100, Math.Min(100, text.Length - i * 100)));
		}
	}

	[MonoPInvokeCallback(typeof(OnReceived))]
	private static void onReceived(int len, IntPtr data)
	{
		byte[] array = new byte[len];
		Marshal.Copy(data, array, 0, len);
		array = XNetworkManager.Instance.decrypt(array);
		XNetworkManager.Instance.receivedUdpMsg(array);
	}

	public void Close()
	{
		dlClose(-1);
	}

	public void destroy()
	{
		dlDestroy();
	}

	[DllImport("RakNet")]
	private static extern bool dlConnect(string host, int port);

	[DllImport("RakNet")]
	private static extern bool dlSendData(uint len, byte[] data);

	[DllImport("RakNet")]
	private static extern void dlDestroy();

	[DllImport("RakNet")]
	private static extern void dlUpdate();

	[DllImport("RakNet")]
	private static extern void dlClose(int reason);

	[DllImport("RakNet")]
	private static extern bool init(OnConnected oc, OnDisconnected odc, OnReceived received, OnLog loged);
}
