using System;
using UnityEngine;
using XServer;

namespace Packages.P08Base.Net;

public class ClientUDPNet : MonoBehaviour, IClientNet, INetCallback
{
	private Action mConnectCallback;

	private Action<int> mOnError;

	public ClientNetworkSystem mUDPClientNet { get; set; }

	public SimContext mSimContext { get; set; }

	public CommandRouter mRouter { get; set; }

	private void Awake()
	{
		if (mUDPClientNet == null)
		{
			mUDPClientNet = new ClientNetworkSystem();
		}
	}

	private void Update()
	{
		PullEvent();
	}

	private void LateUpdate()
	{
		PushEvent();
	}

	private void OnDestroy()
	{
		Shutdown();
	}

	public void Connect(string ip, int port, Action callback, Action<int> onError = null)
	{
		mConnectCallback = callback;
		mOnError = onError;
		mUDPClientNet.Connect(ip, port, this);
	}

	public void Disconnect()
	{
		mUDPClientNet.Disconnect();
	}

	public void Init()
	{
	}

	public void PullEvent()
	{
		if (mUDPClientNet != null)
		{
			mUDPClientNet.PullEvents();
		}
	}

	public void PushEvent()
	{
		if (mUDPClientNet != null)
		{
			mUDPClientNet.PushEvents();
		}
	}

	public void Shutdown()
	{
		if (mUDPClientNet != null)
		{
			mUDPClientNet.Disconnect();
			mUDPClientNet = null;
		}
	}

	public void OnConnectHandler(XChannel channel, int code)
	{
		Debug.Log("连接战斗服务器成功！");
		if (mConnectCallback != null)
		{
			mConnectCallback();
		}
	}

	public void OnDisconnectHandler(XChannel channel, int code)
	{
		Debug.LogError("拉起断线，退出战斗 todo: 沈介培  拉个界面呗");
	}

	public void OnError(int code)
	{
		Debug.LogError("与战斗服网络连接出现错误 code: " + code);
		if (mOnError != null && code >= 100000)
		{
			mOnError(code);
		}
	}
}
