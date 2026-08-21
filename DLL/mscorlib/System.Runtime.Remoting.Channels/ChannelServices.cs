using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Runtime.Remoting.Contexts;
using System.Runtime.Remoting.Messaging;

namespace System.Runtime.Remoting.Channels;

[ComVisible(true)]
public sealed class ChannelServices
{
	private static ArrayList registeredChannels = new ArrayList();

	private static ArrayList delayedClientChannels = new ArrayList();

	private static CrossContextChannel _crossContextSink = new CrossContextChannel();

	internal static string CrossContextUrl = "__CrossContext";

	private static IList oldStartModeTypes = new string[2] { "Novell.Zenworks.Zmd.Public.UnixServerChannel", "Novell.Zenworks.Zmd.Public.UnixChannel" };

	internal static CrossContextChannel CrossContextChannel => _crossContextSink;

	internal static IMessageSink CreateClientChannelSinkChain(string url, object remoteChannelData, out string objectUri)
	{
		object[] channelDataArray = (object[])remoteChannelData;
		lock (registeredChannels.SyncRoot)
		{
			foreach (IChannel registeredChannel in registeredChannels)
			{
				if (registeredChannel is IChannelSender sender)
				{
					IMessageSink messageSink = CreateClientChannelSinkChain(sender, url, channelDataArray, out objectUri);
					if (messageSink != null)
					{
						return messageSink;
					}
				}
			}
			RemotingConfiguration.LoadDefaultDelayedChannels();
			foreach (IChannelSender delayedClientChannel in delayedClientChannels)
			{
				IMessageSink messageSink2 = CreateClientChannelSinkChain(delayedClientChannel, url, channelDataArray, out objectUri);
				if (messageSink2 != null)
				{
					delayedClientChannels.Remove(delayedClientChannel);
					RegisterChannel(delayedClientChannel);
					return messageSink2;
				}
			}
		}
		objectUri = null;
		return null;
	}

	internal static IMessageSink CreateClientChannelSinkChain(IChannelSender sender, string url, object[] channelDataArray, out string objectUri)
	{
		objectUri = null;
		if (channelDataArray == null)
		{
			return sender.CreateMessageSink(url, null, out objectUri);
		}
		foreach (object obj in channelDataArray)
		{
			IMessageSink messageSink = ((!(obj is IChannelDataStore)) ? sender.CreateMessageSink(url, obj, out objectUri) : sender.CreateMessageSink(null, obj, out objectUri));
			if (messageSink != null)
			{
				return messageSink;
			}
		}
		return null;
	}

	[Obsolete("Use RegisterChannel(IChannel,Boolean)")]
	public static void RegisterChannel(IChannel chnl)
	{
		RegisterChannel(chnl, ensureSecurity: false);
	}

	public static void RegisterChannel(IChannel chnl, bool ensureSecurity)
	{
		if (chnl == null)
		{
			throw new ArgumentNullException("chnl");
		}
		if (ensureSecurity)
		{
			((chnl as ISecurableChannel) ?? throw new RemotingException($"Channel {chnl.ChannelName} is not securable while ensureSecurity is specified as true")).IsSecured = true;
		}
		lock (registeredChannels.SyncRoot)
		{
			int num = -1;
			for (int i = 0; i < registeredChannels.Count; i++)
			{
				IChannel channel = (IChannel)registeredChannels[i];
				if (channel.ChannelName == chnl.ChannelName && chnl.ChannelName != "")
				{
					throw new RemotingException("Channel " + channel.ChannelName + " already registered");
				}
				if (channel.ChannelPriority < chnl.ChannelPriority && num == -1)
				{
					num = i;
				}
			}
			if (num != -1)
			{
				registeredChannels.Insert(num, chnl);
			}
			else
			{
				registeredChannels.Add(chnl);
			}
			if (chnl is IChannelReceiver channelReceiver && oldStartModeTypes.Contains(chnl.GetType().ToString()))
			{
				channelReceiver.StartListening(null);
			}
		}
	}

	internal static void RegisterChannelConfig(ChannelData channel)
	{
		IServerChannelSinkProvider serverChannelSinkProvider = null;
		IClientChannelSinkProvider clientChannelSinkProvider = null;
		for (int num = channel.ServerProviders.Count - 1; num >= 0; num--)
		{
			IServerChannelSinkProvider obj = (IServerChannelSinkProvider)CreateProvider(channel.ServerProviders[num] as ProviderData);
			obj.Next = serverChannelSinkProvider;
			serverChannelSinkProvider = obj;
		}
		for (int num2 = channel.ClientProviders.Count - 1; num2 >= 0; num2--)
		{
			IClientChannelSinkProvider obj2 = (IClientChannelSinkProvider)CreateProvider(channel.ClientProviders[num2] as ProviderData);
			obj2.Next = clientChannelSinkProvider;
			clientChannelSinkProvider = obj2;
		}
		Type type = Type.GetType(channel.Type);
		if (type == null)
		{
			throw new RemotingException("Type '" + channel.Type + "' not found");
		}
		bool flag = typeof(IChannelSender).IsAssignableFrom(type);
		bool flag2 = typeof(IChannelReceiver).IsAssignableFrom(type);
		Type[] types;
		object[] parameters;
		if (flag & flag2)
		{
			types = new Type[3]
			{
				typeof(IDictionary),
				typeof(IClientChannelSinkProvider),
				typeof(IServerChannelSinkProvider)
			};
			parameters = new object[3] { channel.CustomProperties, clientChannelSinkProvider, serverChannelSinkProvider };
		}
		else if (flag)
		{
			types = new Type[2]
			{
				typeof(IDictionary),
				typeof(IClientChannelSinkProvider)
			};
			parameters = new object[2] { channel.CustomProperties, clientChannelSinkProvider };
		}
		else
		{
			if (!flag2)
			{
				throw new RemotingException(type?.ToString() + " is not a valid channel type");
			}
			types = new Type[2]
			{
				typeof(IDictionary),
				typeof(IServerChannelSinkProvider)
			};
			parameters = new object[2] { channel.CustomProperties, serverChannelSinkProvider };
		}
		ConstructorInfo constructor = type.GetConstructor(types);
		if (constructor == null)
		{
			throw new RemotingException(type?.ToString() + " does not have a valid constructor");
		}
		IChannel channel2;
		try
		{
			channel2 = (IChannel)constructor.Invoke(parameters);
		}
		catch (TargetInvocationException ex)
		{
			throw ex.InnerException;
		}
		lock (registeredChannels.SyncRoot)
		{
			if (channel.DelayLoadAsClientChannel == "true" && !(channel2 is IChannelReceiver))
			{
				delayedClientChannels.Add(channel2);
			}
			else
			{
				RegisterChannel(channel2);
			}
		}
	}

	private static object CreateProvider(ProviderData prov)
	{
		Type type = Type.GetType(prov.Type);
		if (type == null)
		{
			throw new RemotingException("Type '" + prov.Type + "' not found");
		}
		object[] args = new object[2] { prov.CustomProperties, prov.CustomData };
		try
		{
			return Activator.CreateInstance(type, args);
		}
		catch (Exception innerException)
		{
			if (innerException is TargetInvocationException)
			{
				innerException = ((TargetInvocationException)innerException).InnerException;
			}
			throw new RemotingException("An instance of provider '" + type?.ToString() + "' could not be created: " + innerException.Message);
		}
	}

	public static IMessage SyncDispatchMessage(IMessage msg)
	{
		IMessage message = CheckIncomingMessage(msg);
		if (message != null)
		{
			return CheckReturnMessage(msg, message);
		}
		message = _crossContextSink.SyncProcessMessage(msg);
		return CheckReturnMessage(msg, message);
	}

	private static ReturnMessage CheckIncomingMessage(IMessage msg)
	{
		IMethodMessage methodMessage = (IMethodMessage)msg;
		if (!(RemotingServices.GetIdentityForUri(methodMessage.Uri) is ServerIdentity ident))
		{
			return new ReturnMessage(new RemotingException("No receiver for uri " + methodMessage.Uri), (IMethodCallMessage)msg);
		}
		RemotingServices.SetMessageTargetIdentity(msg, ident);
		return null;
	}

	internal static IMessage CheckReturnMessage(IMessage callMsg, IMessage retMsg)
	{
		if (retMsg is IMethodReturnMessage { Exception: not null } && RemotingConfiguration.CustomErrorsEnabled(IsLocalCall(callMsg)))
		{
			retMsg = new MethodResponse(new Exception("Server encountered an internal error. For more information, turn off customErrors in the server's .config file."), (IMethodCallMessage)callMsg);
		}
		return retMsg;
	}

	private static bool IsLocalCall(IMessage callMsg)
	{
		return true;
	}

	internal static object[] GetCurrentChannelInfo()
	{
		List<object> list = new List<object>();
		lock (registeredChannels.SyncRoot)
		{
			foreach (object registeredChannel in registeredChannels)
			{
				if (registeredChannel is IChannelReceiver { ChannelData: { } channelData })
				{
					list.Add(channelData);
				}
			}
		}
		return list.ToArray();
	}
}
