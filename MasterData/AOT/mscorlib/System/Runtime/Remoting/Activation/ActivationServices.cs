using System.Collections;
using System.Runtime.CompilerServices;
using System.Runtime.Remoting.Channels;
using System.Runtime.Remoting.Contexts;
using System.Runtime.Remoting.Messaging;
using System.Runtime.Remoting.Proxies;
using System.Threading;

namespace System.Runtime.Remoting.Activation;

internal class ActivationServices
{
	private static IActivator _constructionActivator;

	private static IActivator ConstructionActivator
	{
		get
		{
			if (_constructionActivator == null)
			{
				_constructionActivator = new ConstructionLevelActivator();
			}
			return _constructionActivator;
		}
	}

	public static IMessage Activate(RemotingProxy proxy, ConstructionCall ctorCall)
	{
		ctorCall.SourceProxy = proxy;
		IMessage message = ((!Thread.CurrentContext.HasExitSinks || ctorCall.IsContextOk) ? RemoteActivate(ctorCall) : Thread.CurrentContext.GetClientContextSinkChain().SyncProcessMessage(ctorCall));
		if (message is IConstructionReturnMessage && ((IConstructionReturnMessage)message).Exception == null && proxy.ObjectIdentity == null)
		{
			Identity messageTargetIdentity = RemotingServices.GetMessageTargetIdentity(ctorCall);
			proxy.AttachIdentity(messageTargetIdentity);
		}
		return message;
	}

	public static IMessage RemoteActivate(IConstructionCallMessage ctorCall)
	{
		try
		{
			return ctorCall.Activator.Activate(ctorCall);
		}
		catch (Exception e)
		{
			return new ReturnMessage(e, ctorCall);
		}
	}

	public static ConstructionCall CreateConstructionCall(Type type, string activationUrl, object[] activationAttributes)
	{
		ConstructionCall constructionCall = new ConstructionCall(type);
		if (!type.IsContextful)
		{
			constructionCall.Activator = new AppDomainLevelActivator(activationUrl, ConstructionActivator);
			constructionCall.IsContextOk = false;
			return constructionCall;
		}
		IActivator constructionActivator = ConstructionActivator;
		constructionActivator = new ContextLevelActivator(constructionActivator);
		ArrayList arrayList = new ArrayList();
		if (activationAttributes != null)
		{
			arrayList.AddRange(activationAttributes);
		}
		bool flag = activationUrl == ChannelServices.CrossContextUrl;
		Context currentContext = Thread.CurrentContext;
		if (flag)
		{
			foreach (IContextAttribute item in arrayList)
			{
				if (!item.IsContextOK(currentContext, constructionCall))
				{
					flag = false;
					break;
				}
			}
		}
		object[] customAttributes = type.GetCustomAttributes(inherit: true);
		foreach (object obj in customAttributes)
		{
			if (obj is IContextAttribute)
			{
				flag = flag && ((IContextAttribute)obj).IsContextOK(currentContext, constructionCall);
				arrayList.Add(obj);
			}
		}
		if (!flag)
		{
			constructionCall.SetActivationAttributes(arrayList.ToArray());
			foreach (IContextAttribute item2 in arrayList)
			{
				item2.GetPropertiesForNewContext(constructionCall);
			}
		}
		if (activationUrl != ChannelServices.CrossContextUrl)
		{
			constructionActivator = new AppDomainLevelActivator(activationUrl, constructionActivator);
		}
		constructionCall.Activator = constructionActivator;
		constructionCall.IsContextOk = flag;
		return constructionCall;
	}

	public static IMessage CreateInstanceFromMessage(IConstructionCallMessage ctorCall)
	{
		object obj = AllocateUninitializedClassInstance(ctorCall.ActivationType);
		ServerIdentity serverIdentity = (ServerIdentity)RemotingServices.GetMessageTargetIdentity(ctorCall);
		serverIdentity.AttachServerObject((MarshalByRefObject)obj, Thread.CurrentContext);
		ConstructionCall constructionCall = ctorCall as ConstructionCall;
		if (ctorCall.ActivationType.IsContextful && constructionCall != null && constructionCall.SourceProxy != null)
		{
			constructionCall.SourceProxy.AttachIdentity(serverIdentity);
			RemotingServices.InternalExecuteMessage((MarshalByRefObject)constructionCall.SourceProxy.GetTransparentProxy(), ctorCall);
		}
		else
		{
			ctorCall.MethodBase.Invoke(obj, ctorCall.Args);
		}
		return new ConstructionResponse(obj, null, ctorCall);
	}

	public static object CreateProxyForType(Type type)
	{
		ActivatedClientTypeEntry activatedClientTypeEntry = RemotingConfiguration.IsRemotelyActivatedClientType(type);
		if (activatedClientTypeEntry != null)
		{
			return RemotingServices.CreateClientProxy(activatedClientTypeEntry, null);
		}
		WellKnownClientTypeEntry wellKnownClientTypeEntry = RemotingConfiguration.IsWellKnownClientType(type);
		if (wellKnownClientTypeEntry != null)
		{
			return RemotingServices.CreateClientProxy(wellKnownClientTypeEntry);
		}
		if (type.IsContextful)
		{
			return RemotingServices.CreateClientProxyForContextBound(type, null);
		}
		return null;
	}

	[MethodImpl((MethodImplOptions)4096)]
	public static extern object AllocateUninitializedClassInstance(Type type);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern void EnableProxyActivation(Type type, bool enable);
}
