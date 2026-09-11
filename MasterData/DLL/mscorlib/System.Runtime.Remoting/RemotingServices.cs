using System.Collections;
using System.IO;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.ConstrainedExecution;
using System.Runtime.InteropServices;
using System.Runtime.Remoting.Activation;
using System.Runtime.Remoting.Channels;
using System.Runtime.Remoting.Contexts;
using System.Runtime.Remoting.Lifetime;
using System.Runtime.Remoting.Messaging;
using System.Runtime.Remoting.Proxies;
using System.Runtime.Remoting.Services;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Formatters;
using System.Runtime.Serialization.Formatters.Binary;
using System.Threading;

namespace System.Runtime.Remoting;

[ComVisible(true)]
public static class RemotingServices
{
	[Serializable]
	private class CACD
	{
		public object d;

		public object c;
	}

	private static Hashtable uri_hash;

	private static BinaryFormatter _serializationFormatter;

	private static BinaryFormatter _deserializationFormatter;

	private static string app_id;

	private static readonly object app_id_lock;

	private static int next_id;

	private static readonly MethodInfo FieldSetterMethod;

	private static readonly MethodInfo FieldGetterMethod;

	static RemotingServices()
	{
		uri_hash = new Hashtable();
		app_id_lock = new object();
		next_id = 1;
		RemotingSurrogateSelector selector = new RemotingSurrogateSelector();
		StreamingContext context = new StreamingContext(StreamingContextStates.Remoting, null);
		_serializationFormatter = new BinaryFormatter(selector, context);
		_deserializationFormatter = new BinaryFormatter(null, context);
		_serializationFormatter.AssemblyFormat = FormatterAssemblyStyle.Full;
		_deserializationFormatter.AssemblyFormat = FormatterAssemblyStyle.Full;
		RegisterInternalChannels();
		CreateWellKnownServerIdentity(typeof(RemoteActivator), "RemoteActivationService.rem", WellKnownObjectMode.Singleton);
		FieldSetterMethod = typeof(object).GetMethod("FieldSetter", BindingFlags.Instance | BindingFlags.NonPublic);
		FieldGetterMethod = typeof(object).GetMethod("FieldGetter", BindingFlags.Instance | BindingFlags.NonPublic);
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern object InternalExecute(MethodBase method, object obj, object[] parameters, out object[] out_args);

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern MethodBase GetVirtualMethod(Type type, MethodBase method);

	public static bool IsTransparentProxy(object proxy)
	{
		throw new NotSupportedException();
	}

	internal static IMethodReturnMessage InternalExecuteMessage(MarshalByRefObject target, IMethodCallMessage reqMsg)
	{
		Type type = target.GetType();
		MethodBase methodBase;
		if (reqMsg.MethodBase.DeclaringType == type || reqMsg.MethodBase == FieldSetterMethod || reqMsg.MethodBase == FieldGetterMethod)
		{
			methodBase = reqMsg.MethodBase;
		}
		else
		{
			methodBase = GetVirtualMethod(type, reqMsg.MethodBase);
			if (methodBase == null)
			{
				throw new RemotingException($"Cannot resolve method {type}:{reqMsg.MethodName}");
			}
		}
		if (reqMsg.MethodBase.IsGenericMethod)
		{
			Type[] genericArguments = reqMsg.MethodBase.GetGenericArguments();
			methodBase = ((MethodInfo)methodBase).GetGenericMethodDefinition().MakeGenericMethod(genericArguments);
		}
		LogicalCallContext logicalCallContext = CallContext.SetLogicalCallContext(reqMsg.LogicalCallContext);
		ReturnMessage result;
		try
		{
			object ret = InternalExecute(methodBase, target, reqMsg.Args, out var out_args);
			ParameterInfo[] parameters = methodBase.GetParameters();
			object[] array = new object[parameters.Length];
			int outArgsCount = 0;
			int num = 0;
			ParameterInfo[] array2 = parameters;
			foreach (ParameterInfo parameterInfo in array2)
			{
				if (parameterInfo.IsOut && !parameterInfo.ParameterType.IsByRef)
				{
					array[outArgsCount++] = reqMsg.GetArg(parameterInfo.Position);
				}
				else if (parameterInfo.ParameterType.IsByRef)
				{
					array[outArgsCount++] = out_args[num++];
				}
				else
				{
					array[outArgsCount++] = null;
				}
			}
			LogicalCallContext logicalCallContext2 = Thread.CurrentThread.GetMutableExecutionContext().LogicalCallContext;
			result = new ReturnMessage(ret, array, outArgsCount, logicalCallContext2, reqMsg);
		}
		catch (Exception e)
		{
			result = new ReturnMessage(e, reqMsg);
		}
		CallContext.SetLogicalCallContext(logicalCallContext);
		return result;
	}

	[ComVisible(true)]
	public static object Connect(Type classToProxy, string url)
	{
		return GetRemoteObject(new ObjRef(classToProxy, url, null), classToProxy);
	}

	[ComVisible(true)]
	public static object Connect(Type classToProxy, string url, object data)
	{
		return GetRemoteObject(new ObjRef(classToProxy, url, data), classToProxy);
	}

	public static Type GetServerTypeForUri(string URI)
	{
		if (!(GetIdentityForUri(URI) is ServerIdentity serverIdentity))
		{
			return null;
		}
		return serverIdentity.ObjectType;
	}

	public static object Unmarshal(ObjRef objectRef)
	{
		return Unmarshal(objectRef, fRefine: true);
	}

	public static object Unmarshal(ObjRef objectRef, bool fRefine)
	{
		Type type = (fRefine ? objectRef.ServerType : typeof(MarshalByRefObject));
		if (type == null)
		{
			type = typeof(MarshalByRefObject);
		}
		if (objectRef.IsReferenceToWellKnow)
		{
			object remoteObject = GetRemoteObject(objectRef, type);
			TrackingServices.NotifyUnmarshaledObject(remoteObject, objectRef);
			return remoteObject;
		}
		if (type.IsContextful)
		{
			ProxyAttribute proxyAttribute = (ProxyAttribute)Attribute.GetCustomAttribute(type, typeof(ProxyAttribute), inherit: true);
			if (proxyAttribute != null)
			{
				object transparentProxy = proxyAttribute.CreateProxy(objectRef, type, null, null).GetTransparentProxy();
				TrackingServices.NotifyUnmarshaledObject(transparentProxy, objectRef);
				return transparentProxy;
			}
		}
		object proxyForRemoteObject = GetProxyForRemoteObject(objectRef, type);
		TrackingServices.NotifyUnmarshaledObject(proxyForRemoteObject, objectRef);
		return proxyForRemoteObject;
	}

	public static ObjRef Marshal(MarshalByRefObject Obj)
	{
		return Marshal(Obj, null, null);
	}

	public static ObjRef Marshal(MarshalByRefObject Obj, string ObjURI, Type RequestedType)
	{
		if (IsTransparentProxy(Obj))
		{
			RealProxy realProxy = GetRealProxy(Obj);
			Identity objectIdentity = realProxy.ObjectIdentity;
			if (objectIdentity != null)
			{
				if (realProxy.GetProxiedType().IsContextful && !objectIdentity.IsConnected)
				{
					ClientActivatedIdentity obj = (ClientActivatedIdentity)objectIdentity;
					if (ObjURI == null)
					{
						ObjURI = NewUri();
					}
					obj.ObjectUri = ObjURI;
					RegisterServerIdentity(obj);
					obj.StartTrackingLifetime((ILease)Obj.InitializeLifetimeService());
					return obj.CreateObjRef(RequestedType);
				}
				if (ObjURI != null)
				{
					throw new RemotingException("It is not possible marshal a proxy of a remote object.");
				}
				ObjRef objRef = realProxy.ObjectIdentity.CreateObjRef(RequestedType);
				TrackingServices.NotifyMarshaledObject(Obj, objRef);
				return objRef;
			}
		}
		if (RequestedType == null)
		{
			RequestedType = Obj.GetType();
		}
		if (ObjURI == null)
		{
			if (Obj.ObjectIdentity == null)
			{
				ObjURI = NewUri();
				CreateClientActivatedServerIdentity(Obj, RequestedType, ObjURI);
			}
		}
		else if (!(GetIdentityForUri("/" + ObjURI) is ClientActivatedIdentity clientActivatedIdentity) || Obj != clientActivatedIdentity.GetServerObject())
		{
			CreateClientActivatedServerIdentity(Obj, RequestedType, ObjURI);
		}
		ObjRef objRef2 = ((!IsTransparentProxy(Obj)) ? Obj.CreateObjRef(RequestedType) : GetRealProxy(Obj).ObjectIdentity.CreateObjRef(RequestedType));
		TrackingServices.NotifyMarshaledObject(Obj, objRef2);
		return objRef2;
	}

	private static string NewUri()
	{
		if (app_id == null)
		{
			lock (app_id_lock)
			{
				if (app_id == null)
				{
					app_id = Guid.NewGuid().ToString().Replace('-', '_') + "/";
				}
			}
		}
		int num = Interlocked.Increment(ref next_id);
		return app_id + Environment.TickCount.ToString("x") + "_" + num + ".rem";
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public static RealProxy GetRealProxy(object proxy)
	{
		if (!IsTransparentProxy(proxy))
		{
			throw new RemotingException("Cannot get the real proxy from an object that is not a transparent proxy.");
		}
		return ((TransparentProxy)proxy)._rp;
	}

	public static MethodBase GetMethodBaseFromMethodMessage(IMethodMessage msg)
	{
		Type type = Type.GetType(msg.TypeName);
		if (type == null)
		{
			throw new RemotingException("Type '" + msg.TypeName + "' not found.");
		}
		return GetMethodBaseFromName(type, msg.MethodName, (Type[])msg.MethodSignature);
	}

	internal static MethodBase GetMethodBaseFromName(Type type, string methodName, Type[] signature)
	{
		if (type.IsInterface)
		{
			return FindInterfaceMethod(type, methodName, signature);
		}
		MethodBase methodBase = null;
		methodBase = ((signature != null) ? type.GetMethod(methodName, BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic, null, signature, null) : type.GetMethod(methodName, BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic));
		if (methodBase != null)
		{
			return methodBase;
		}
		if (methodName == "FieldSetter")
		{
			return FieldSetterMethod;
		}
		if (methodName == "FieldGetter")
		{
			return FieldGetterMethod;
		}
		if (signature == null)
		{
			return type.GetConstructor(BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic, null, Type.EmptyTypes, null);
		}
		return type.GetConstructor(BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic, null, signature, null);
	}

	private static MethodBase FindInterfaceMethod(Type type, string methodName, Type[] signature)
	{
		MethodBase methodBase = null;
		methodBase = ((signature != null) ? type.GetMethod(methodName, BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic, null, signature, null) : type.GetMethod(methodName, BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic));
		if (methodBase != null)
		{
			return methodBase;
		}
		Type[] interfaces = type.GetInterfaces();
		for (int i = 0; i < interfaces.Length; i++)
		{
			methodBase = FindInterfaceMethod(interfaces[i], methodName, signature);
			if (methodBase != null)
			{
				return methodBase;
			}
		}
		return null;
	}

	public static void GetObjectData(object obj, SerializationInfo info, StreamingContext context)
	{
		if (obj == null)
		{
			throw new ArgumentNullException("obj");
		}
		Marshal((MarshalByRefObject)obj).GetObjectData(info, context);
	}

	public static bool IsOneWay(MethodBase method)
	{
		return method.IsDefined(typeof(OneWayAttribute), inherit: false);
	}

	internal static object CreateClientProxy(ActivatedClientTypeEntry entry, object[] activationAttributes)
	{
		if (entry.ContextAttributes != null || activationAttributes != null)
		{
			ArrayList arrayList = new ArrayList();
			if (entry.ContextAttributes != null)
			{
				arrayList.AddRange(entry.ContextAttributes);
			}
			if (activationAttributes != null)
			{
				arrayList.AddRange(activationAttributes);
			}
			return CreateClientProxy(entry.ObjectType, entry.ApplicationUrl, arrayList.ToArray());
		}
		return CreateClientProxy(entry.ObjectType, entry.ApplicationUrl, null);
	}

	internal static object CreateClientProxy(Type objectType, string url, object[] activationAttributes)
	{
		string text = url;
		if (!text.EndsWith("/"))
		{
			text += "/";
		}
		text += "RemoteActivationService.rem";
		GetClientChannelSinkChain(text, null, out var _);
		return new RemotingProxy(objectType, text, activationAttributes).GetTransparentProxy();
	}

	internal static object CreateClientProxy(WellKnownClientTypeEntry entry)
	{
		return Connect(entry.ObjectType, entry.ObjectUrl, null);
	}

	internal static object CreateClientProxyForContextBound(Type type, object[] activationAttributes)
	{
		if (type.IsContextful)
		{
			ProxyAttribute proxyAttribute = (ProxyAttribute)Attribute.GetCustomAttribute(type, typeof(ProxyAttribute), inherit: true);
			if (proxyAttribute != null)
			{
				return proxyAttribute.CreateInstance(type);
			}
		}
		return new RemotingProxy(type, ChannelServices.CrossContextUrl, activationAttributes).GetTransparentProxy();
	}

	internal static Identity GetIdentityForUri(string uri)
	{
		string normalizedUri = GetNormalizedUri(uri);
		lock (uri_hash)
		{
			Identity identity = (Identity)uri_hash[normalizedUri];
			if (identity == null)
			{
				normalizedUri = RemoveAppNameFromUri(uri);
				if (normalizedUri != null)
				{
					identity = (Identity)uri_hash[normalizedUri];
				}
			}
			return identity;
		}
	}

	private static string RemoveAppNameFromUri(string uri)
	{
		string applicationName = RemotingConfiguration.ApplicationName;
		if (applicationName == null)
		{
			return null;
		}
		applicationName = "/" + applicationName + "/";
		if (uri.StartsWith(applicationName))
		{
			return uri.Substring(applicationName.Length);
		}
		return null;
	}

	internal static ClientIdentity GetOrCreateClientIdentity(ObjRef objRef, Type proxyType, out object clientProxy)
	{
		object channelData = ((objRef.ChannelInfo != null) ? objRef.ChannelInfo.ChannelData : null);
		IMessageSink clientChannelSinkChain = GetClientChannelSinkChain(objRef.URI, channelData, out var objectUri);
		if (objectUri == null)
		{
			objectUri = objRef.URI;
		}
		lock (uri_hash)
		{
			clientProxy = null;
			string normalizedUri = GetNormalizedUri(objRef.URI);
			if (uri_hash[normalizedUri] is ClientIdentity clientIdentity)
			{
				clientProxy = clientIdentity.ClientProxy;
				if (clientProxy != null)
				{
					return clientIdentity;
				}
				DisposeIdentity(clientIdentity);
			}
			ClientIdentity clientIdentity2 = new ClientIdentity(objectUri, objRef);
			clientIdentity2.ChannelSink = clientChannelSinkChain;
			uri_hash[normalizedUri] = clientIdentity2;
			if (proxyType != null)
			{
				RemotingProxy remotingProxy = new RemotingProxy(proxyType, clientIdentity2);
				if (clientChannelSinkChain is CrossAppDomainSink crossAppDomainSink)
				{
					remotingProxy.SetTargetDomain(crossAppDomainSink.TargetDomainId);
				}
				clientProxy = remotingProxy.GetTransparentProxy();
				clientIdentity2.ClientProxy = (MarshalByRefObject)clientProxy;
			}
			return clientIdentity2;
		}
	}

	private static IMessageSink GetClientChannelSinkChain(string url, object channelData, out string objectUri)
	{
		IMessageSink messageSink = ChannelServices.CreateClientChannelSinkChain(url, channelData, out objectUri);
		if (messageSink == null)
		{
			if (url != null)
			{
				throw new RemotingException($"Cannot create channel sink to connect to URL {url}. An appropriate channel has probably not been registered.");
			}
			throw new RemotingException(string.Format("Cannot create channel sink to connect to the remote object. An appropriate channel has probably not been registered.", url));
		}
		return messageSink;
	}

	internal static ClientActivatedIdentity CreateContextBoundObjectIdentity(Type objectType)
	{
		return new ClientActivatedIdentity(null, objectType)
		{
			ChannelSink = ChannelServices.CrossContextChannel
		};
	}

	internal static ClientActivatedIdentity CreateClientActivatedServerIdentity(MarshalByRefObject realObject, Type objectType, string objectUri)
	{
		ClientActivatedIdentity clientActivatedIdentity = new ClientActivatedIdentity(objectUri, objectType);
		clientActivatedIdentity.AttachServerObject(realObject, Context.DefaultContext);
		RegisterServerIdentity(clientActivatedIdentity);
		clientActivatedIdentity.StartTrackingLifetime((ILease)realObject.InitializeLifetimeService());
		return clientActivatedIdentity;
	}

	internal static ServerIdentity CreateWellKnownServerIdentity(Type objectType, string objectUri, WellKnownObjectMode mode)
	{
		ServerIdentity serverIdentity = ((mode != WellKnownObjectMode.SingleCall) ? ((ServerIdentity)new SingletonIdentity(objectUri, Context.DefaultContext, objectType)) : ((ServerIdentity)new SingleCallIdentity(objectUri, Context.DefaultContext, objectType)));
		RegisterServerIdentity(serverIdentity);
		return serverIdentity;
	}

	private static void RegisterServerIdentity(ServerIdentity identity)
	{
		lock (uri_hash)
		{
			if (uri_hash.ContainsKey(identity.ObjectUri))
			{
				throw new RemotingException("Uri already in use: " + identity.ObjectUri + ".");
			}
			uri_hash[identity.ObjectUri] = identity;
		}
	}

	internal static object GetProxyForRemoteObject(ObjRef objref, Type classToProxy)
	{
		if (GetIdentityForUri(objref.URI) is ClientActivatedIdentity clientActivatedIdentity)
		{
			return clientActivatedIdentity.GetServerObject();
		}
		return GetRemoteObject(objref, classToProxy);
	}

	internal static object GetRemoteObject(ObjRef objRef, Type proxyType)
	{
		GetOrCreateClientIdentity(objRef, proxyType, out var clientProxy);
		return clientProxy;
	}

	internal static byte[] SerializeCallData(object obj)
	{
		LogicalCallContext.Reader logicalCallContext = Thread.CurrentThread.GetExecutionContextReader().LogicalCallContext;
		if (!logicalCallContext.IsNull)
		{
			obj = new CACD
			{
				d = obj,
				c = logicalCallContext.Clone()
			};
		}
		if (obj == null)
		{
			return null;
		}
		MemoryStream memoryStream = new MemoryStream();
		lock (_serializationFormatter)
		{
			_serializationFormatter.Serialize(memoryStream, obj);
		}
		return memoryStream.ToArray();
	}

	internal static object DeserializeCallData(byte[] array)
	{
		if (array == null)
		{
			return null;
		}
		MemoryStream serializationStream = new MemoryStream(array);
		object obj;
		lock (_deserializationFormatter)
		{
			obj = _deserializationFormatter.Deserialize(serializationStream);
		}
		if (obj is CACD)
		{
			CACD obj2 = (CACD)obj;
			obj = obj2.d;
			LogicalCallContext logicalCallContext = (LogicalCallContext)obj2.c;
			if (logicalCallContext.HasInfo)
			{
				Thread.CurrentThread.GetMutableExecutionContext().LogicalCallContext.Merge(logicalCallContext);
			}
		}
		return obj;
	}

	internal static byte[] SerializeExceptionData(Exception ex)
	{
		byte[] array = null;
		try
		{
		}
		finally
		{
			MemoryStream memoryStream = new MemoryStream();
			lock (_serializationFormatter)
			{
				_serializationFormatter.Serialize(memoryStream, ex);
			}
			array = memoryStream.ToArray();
		}
		return array;
	}

	internal static object GetDomainProxy(AppDomain domain)
	{
		byte[] array = null;
		Context currentContext = Thread.CurrentContext;
		try
		{
			array = (byte[])AppDomain.InvokeInDomain(domain, typeof(AppDomain).GetMethod("GetMarshalledDomainObjRef", BindingFlags.Instance | BindingFlags.NonPublic), domain, null);
		}
		finally
		{
			AppDomain.InternalSetContext(currentContext);
		}
		byte[] array2 = new byte[array.Length];
		array.CopyTo(array2, 0);
		return (AppDomain)Unmarshal((ObjRef)CADSerializer.DeserializeObject(new MemoryStream(array2)));
	}

	private static void RegisterInternalChannels()
	{
		CrossAppDomainChannel.RegisterCrossAppDomainChannel();
	}

	internal static void DisposeIdentity(Identity ident)
	{
		lock (uri_hash)
		{
			if (!ident.Disposed)
			{
				if (ident is ClientIdentity clientIdentity)
				{
					uri_hash.Remove(GetNormalizedUri(clientIdentity.TargetUri));
				}
				else
				{
					uri_hash.Remove(ident.ObjectUri);
				}
				ident.Disposed = true;
			}
		}
	}

	internal static Identity GetMessageTargetIdentity(IMessage msg)
	{
		if (msg is IInternalMessage)
		{
			return ((IInternalMessage)msg).TargetIdentity;
		}
		lock (uri_hash)
		{
			string normalizedUri = GetNormalizedUri(((IMethodMessage)msg).Uri);
			return uri_hash[normalizedUri] as ServerIdentity;
		}
	}

	internal static void SetMessageTargetIdentity(IMessage msg, Identity ident)
	{
		if (msg is IInternalMessage)
		{
			((IInternalMessage)msg).TargetIdentity = ident;
		}
	}

	internal static bool UpdateOutArgObject(ParameterInfo pi, object local, object remote)
	{
		if (pi.ParameterType.IsArray && ((Array)local).Rank == 1)
		{
			Array array = (Array)local;
			if (array.Rank == 1)
			{
				Array.Copy((Array)remote, array, array.Length);
				return true;
			}
		}
		return false;
	}

	private static string GetNormalizedUri(string uri)
	{
		if (uri.StartsWith("/"))
		{
			return uri.Substring(1);
		}
		return uri;
	}
}
