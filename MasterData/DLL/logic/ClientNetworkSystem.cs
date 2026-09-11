using System;
using System.Collections.Generic;
using System.Net;
using Google.Protobuf;
using NetProcol;
using UnityEngine;
using XServer;
using XServer.Util;

public class ClientNetworkSystem
{
	public enum ENetStatus
	{
		None,
		Connecting,
		Connected,
		Disconnect,
		Timeout,
		Error
	}

	private long mLastPingTime;

	private int mRequestTick = 250;

	private bool mIsMultiMode;

	public long sDiffCSTime;

	public long sSyncCount;

	public int ping;

	public int lastPing;

	public int averagePing;

	private ENetStatus mStatus;

	private byte[] mSendBuffer = new byte[4096];

	private INetCallback mCallback;

	private IMessagePacker msgPacker = new ProtobufPacker();

	private ClientOpcode mClientCode = new ClientOpcode();

	private KService mKcpService;

	private XChannel mChannel;

	private NetPool<Packet> mPaketPool = new NetPool<Packet>();

	private IPEndPoint mIPAdrress;

	private int mTimeout;

	private bool isConnected;

	public ClientNetworkSystem()
	{
		LoadOpcode();
		mKcpService = new KService();
		mKcpService.Start();
	}

	public void Connect(string ip, int port, INetCallback callback)
	{
		mCallback = callback;
		mTimeout = 0;
		if (mStatus != ENetStatus.Connecting)
		{
			Connect(ip, port);
		}
	}

	public void Disconnect()
	{
		mStatus = ENetStatus.Disconnect;
		StopHost();
	}

	private void OnDisconnectHandler(XChannel channel, int code)
	{
		Debug.LogError((object)("disconnect: " + code));
		mStatus = ENetStatus.Disconnect;
		if (mCallback != null)
		{
			mCallback.OnDisconnectHandler(channel, code);
		}
		if (mCallback != null)
		{
			mCallback.OnError(202002);
		}
	}

	private void OnConnectHandler(XChannel channel, int code)
	{
		Debug.Log((object)("client connect battle server: " + code));
		isConnected = true;
		mStatus = ENetStatus.Connected;
		if (mCallback != null)
		{
			mCallback.OnConnectHandler(channel, code);
		}
	}

	private void OnSessionDispatchHandler(Session session, Packet pkg)
	{
		if (pkg == null)
		{
			XLogger.Error("opcode: {0}没有得到正确的消息!", pkg.Opcode);
			return;
		}
		if (mCallback.mRouter != null && pkg.Opcode == 124)
		{
			mIsMultiMode = true;
			int serverFrame = pkg.ReadInt32();
			mCallback.mRouter.SetServerFrame((uint)serverFrame, averagePing);
			while (pkg.Pos < pkg.Len)
			{
				int num = pkg.ReadInt32();
				int offset = (int)pkg.Pos;
				using (CodedInputStream codedInputStream = new CodedInputStream(pkg.Bytes, offset, num))
				{
					int num2 = codedInputStream.ReadInt32();
					Command command = CommandFactory.Create((NetprotoOperationCode)num2);
					if (command != null)
					{
						command.Read(codedInputStream);
						mCallback.mRouter.InputServerCommand((uint)serverFrame, command);
					}
					else
					{
						XLogger.Debug("opcode: {0} 没有对应的命令处理", num2);
					}
				}
				pkg.GetStream().Position += num;
			}
			return;
		}
		object message = null;
		if (!ReadProtobuff(pkg, out message))
		{
			return;
		}
		if (!mClientCode.GetHandler(pkg.Opcode, out var handlerList))
		{
			XLogger.Error("ClientNetworkSystem 消息 " + pkg.GetType().FullName + " 没有处理");
			return;
		}
		foreach (IClientHandler item in handlerList)
		{
			try
			{
				if (item.mCallback == null)
				{
					item.mCallback = mCallback;
				}
				item.Handle(message);
			}
			catch (Exception e)
			{
				XLogger.Error(e);
			}
		}
	}

	private void OnChannelErrorHandler(XChannel channel, int errorCode)
	{
		mStatus = ENetStatus.Error;
		if (202003 != errorCode && 202002 != errorCode)
		{
			_ = 202004;
		}
		if (mCallback != null)
		{
			mCallback.OnError(errorCode);
		}
	}

	public void StopHost()
	{
		if (mKcpService != null)
		{
			mKcpService.Dispose();
			mKcpService = null;
		}
	}

	private XChannel Connect(string ip, int port)
	{
		IPEndPoint ipEndPoint = NetworkHelper.ToIPEndPoint(ip + ":" + port);
		mChannel = mKcpService.ConnectChannel(ipEndPoint, OnSessionDispatchHandler);
		mChannel.ConnectCallback += OnConnectHandler;
		mChannel.DisconnectCallback += OnDisconnectHandler;
		mChannel.ErrorCallback += OnChannelErrorHandler;
		mIPAdrress = ipEndPoint;
		return mChannel;
	}

	private void LoadOpcode()
	{
		AppType b = ~AppType.Client;
		List<Type> list = typeof(MessageAttribute).Assembly.GetTypes().toList<Type>();
		foreach (Type item in list)
		{
			object[] customAttributes = item.GetCustomAttributes(typeof(MessageAttribute), inherit: false);
			if (customAttributes.Length != 0 && customAttributes[0] is MessageAttribute messageAttribute)
			{
				XLogger.Debug("添加Opcode:{0}({1})", messageAttribute.Opcode, item);
				mClientCode.AddOpcodeType(messageAttribute.Opcode, item);
			}
		}
		list = typeof(ClientNetworkSystem).Assembly.GetTypes().toList<Type>();
		foreach (Type item2 in list)
		{
			object[] customAttributes2 = item2.GetCustomAttributes(typeof(MessageHandlerAttribute), inherit: false);
			if (customAttributes2.Length == 0)
			{
				continue;
			}
			MessageHandlerAttribute messageHandlerAttribute = (MessageHandlerAttribute)customAttributes2[0];
			if (messageHandlerAttribute.Type.Is(b))
			{
				object obj = Activator.CreateInstance(item2);
				if (!(obj is IClientHandler handler))
				{
					throw new Exception("msg handler not inherit IMHandler: " + obj.GetType().FullName);
				}
				mClientCode.AddHandler(messageHandlerAttribute.Opcode, handler);
				XLogger.Debug("添加处理器: {0}", obj.GetType().FullName);
			}
		}
	}

	public void PullEvents()
	{
		mKcpService.Pull();
		if (mIsMultiMode)
		{
			ReqSyncTime(mRequestTick);
		}
		else
		{
			ReqSyncTime(mRequestTick * 4);
		}
	}

	public void PushEvents()
	{
		mKcpService.Push();
	}

	public void SyncTime(long clientTime, long serverTime)
	{
		long num = TimeHelper.ClientNow();
		long num2 = num - clientTime;
		ping = (int)((float)num2 * 0.5f);
		if (mIsMultiMode)
		{
			if (averagePing == 0)
			{
				averagePing = ping;
			}
			int num3 = 1000 / mRequestTick;
			num3 = ((num3 <= 0) ? 1 : num3);
			averagePing = (averagePing * (num3 - 1) + ping) / num3;
		}
		else
		{
			if (lastPing == 0)
			{
				lastPing = ping;
			}
			averagePing = (lastPing + ping) / 2;
		}
		long num4 = num - (num2 / 2 + serverTime);
		if (sDiffCSTime == 0L)
		{
			sDiffCSTime = num4;
			sSyncCount = 0L;
		}
		if (sDiffCSTime < num4)
		{
			sDiffCSTime = num4;
		}
		sSyncCount++;
		_ = sSyncCount;
		_ = 2;
	}

	public void ReqSyncTime(long period)
	{
		if (!isConnected || mChannel == null || mChannel.IsDisposed)
		{
			return;
		}
		long num = TimeHelper.Now();
		if (num - mLastPingTime > period)
		{
			mLastPingTime = num;
			Packet packet = mPaketPool.Allocate();
			long value = TimeHelper.ClientNow();
			packet.WriteInt64(value);
			mTimeout++;
			if (mTimeout > 1)
			{
				ping = (int)period * (mTimeout - 1);
			}
			mChannel.mSession.Call(100, packet, delegate(Packet pkg)
			{
				mTimeout = 0;
				long clientTime = pkg.ReadInt64();
				long serverTime = pkg.ReadInt64();
				SyncTime(clientTime, serverTime);
			});
			mPaketPool.Deallocate(packet);
			if (mTimeout > 5)
			{
				Debug.LogError((object)"ping battle server time out!!!, try waiting or reconnect!!");
				mKcpService.CreateSocket();
			}
		}
	}

	public void SendNetCommand(Command command, uint frameNum)
	{
		if (mChannel == null || mChannel.IsDisposed)
		{
			return;
		}
		command.mFrameCount = frameNum;
		using CodedOutputStream codedOutputStream = new CodedOutputStream(mSendBuffer);
		command.Write(codedOutputStream);
		mChannel.mSession.Send(123, mSendBuffer, (int)codedOutputStream.Position);
	}

	public void SendLocalMsg(ushort opcode, object msg, Action<Packet> callback)
	{
		if (mChannel != null && !mChannel.IsDisposed)
		{
			mChannel.mSession.Call(opcode, (IMessage)msg, callback);
		}
	}

	public void SendRawPkg(ushort opcode, Packet pkg, Action<Packet> callback)
	{
		if (mChannel != null && !mChannel.IsDisposed)
		{
			mChannel.mSession.Call(opcode, pkg, callback);
		}
	}

	public bool ReadProtobuff(Packet packet, out object message)
	{
		message = null;
		try
		{
			Type opcodeType = mClientCode.GetOpcodeType(packet.Opcode);
			if (opcodeType == null)
			{
				XLogger.Warn("Opcode: {0} 未定义类型", packet.Opcode);
				return false;
			}
			message = msgPacker.DeserializeFrom(opcodeType, packet.GetStream());
		}
		catch (Exception e)
		{
			XLogger.Error(e);
			return false;
		}
		return true;
	}
}
