using System.Collections.Generic;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Runtime.Remoting.Activation;
using System.Runtime.Remoting.Lifetime;
using System.Runtime.Remoting.Messaging;
using System.Threading;

namespace System.Runtime.Remoting.Contexts;

[StructLayout(LayoutKind.Sequential)]
[ComVisible(true)]
public class Context
{
	private int domain_id;

	private int context_id;

	private UIntPtr static_data;

	private UIntPtr data;

	[ContextStatic]
	private static object[] local_slots;

	private static IMessageSink default_server_context_sink;

	private IMessageSink server_context_sink_chain;

	private IMessageSink client_context_sink_chain;

	private List<IContextProperty> context_properties;

	private static int global_count;

	private volatile LocalDataStoreHolder _localDataStore;

	private static LocalDataStoreMgr _localDataStoreMgr = new LocalDataStoreMgr();

	private static DynamicPropertyCollection global_dynamic_properties;

	private DynamicPropertyCollection context_dynamic_properties;

	private ContextCallbackObject callback_object;

	public static Context DefaultContext => AppDomain.InternalGetDefaultContext();

	public virtual int ContextID => context_id;

	public virtual IContextProperty[] ContextProperties
	{
		get
		{
			if (context_properties == null)
			{
				return new IContextProperty[0];
			}
			return context_properties.ToArray();
		}
	}

	internal bool IsDefaultContext => context_id == 0;

	internal bool NeedsContextSink
	{
		get
		{
			if (context_id == 0 && (global_dynamic_properties == null || !global_dynamic_properties.HasProperties))
			{
				if (context_dynamic_properties != null)
				{
					return context_dynamic_properties.HasProperties;
				}
				return false;
			}
			return true;
		}
	}

	internal static bool HasGlobalDynamicSinks
	{
		get
		{
			if (global_dynamic_properties != null)
			{
				return global_dynamic_properties.HasProperties;
			}
			return false;
		}
	}

	internal bool HasDynamicSinks
	{
		get
		{
			if (context_dynamic_properties != null)
			{
				return context_dynamic_properties.HasProperties;
			}
			return false;
		}
	}

	internal bool HasExitSinks
	{
		get
		{
			if (GetClientContextSinkChain() is ClientContextTerminatorSink && !HasDynamicSinks)
			{
				return HasGlobalDynamicSinks;
			}
			return true;
		}
	}

	private LocalDataStore MyLocalStore
	{
		get
		{
			if (_localDataStore == null)
			{
				lock (_localDataStoreMgr)
				{
					if (_localDataStore == null)
					{
						_localDataStore = _localDataStoreMgr.CreateLocalDataStore();
					}
				}
			}
			return _localDataStore.Store;
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void RegisterContext(Context ctx);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void ReleaseContext(Context ctx);

	public Context()
	{
		domain_id = Thread.GetDomainID();
		context_id = Interlocked.Increment(ref global_count);
		RegisterContext(this);
	}

	~Context()
	{
		ReleaseContext(this);
	}

	public static bool RegisterDynamicProperty(IDynamicProperty prop, ContextBoundObject obj, Context ctx)
	{
		return GetDynamicPropertyCollection(obj, ctx).RegisterDynamicProperty(prop);
	}

	public static bool UnregisterDynamicProperty(string name, ContextBoundObject obj, Context ctx)
	{
		return GetDynamicPropertyCollection(obj, ctx).UnregisterDynamicProperty(name);
	}

	private static DynamicPropertyCollection GetDynamicPropertyCollection(ContextBoundObject obj, Context ctx)
	{
		if (ctx == null && obj != null)
		{
			if (RemotingServices.IsTransparentProxy(obj))
			{
				return RemotingServices.GetRealProxy(obj).ObjectIdentity.ClientDynamicProperties;
			}
			throw new NotSupportedException();
		}
		if (ctx != null && obj == null)
		{
			if (ctx.context_dynamic_properties == null)
			{
				ctx.context_dynamic_properties = new DynamicPropertyCollection();
			}
			return ctx.context_dynamic_properties;
		}
		if (ctx == null && obj == null)
		{
			if (global_dynamic_properties == null)
			{
				global_dynamic_properties = new DynamicPropertyCollection();
			}
			return global_dynamic_properties;
		}
		throw new ArgumentException("Either obj or ctx must be null");
	}

	internal static void NotifyGlobalDynamicSinks(bool start, IMessage req_msg, bool client_site, bool async)
	{
		if (global_dynamic_properties != null && global_dynamic_properties.HasProperties)
		{
			global_dynamic_properties.NotifyMessage(start, req_msg, client_site, async);
		}
	}

	internal void NotifyDynamicSinks(bool start, IMessage req_msg, bool client_site, bool async)
	{
		if (context_dynamic_properties != null && context_dynamic_properties.HasProperties)
		{
			context_dynamic_properties.NotifyMessage(start, req_msg, client_site, async);
		}
	}

	public virtual IContextProperty GetProperty(string name)
	{
		if (context_properties == null)
		{
			return null;
		}
		foreach (IContextProperty context_property in context_properties)
		{
			if (context_property.Name == name)
			{
				return context_property;
			}
		}
		return null;
	}

	public virtual void SetProperty(IContextProperty prop)
	{
		if (prop == null)
		{
			throw new ArgumentNullException("IContextProperty");
		}
		if (this == DefaultContext)
		{
			throw new InvalidOperationException("Can not add properties to default context");
		}
		if (context_properties == null)
		{
			context_properties = new List<IContextProperty>();
		}
		context_properties.Add(prop);
	}

	public virtual void Freeze()
	{
		if (context_properties == null)
		{
			return;
		}
		foreach (IContextProperty context_property in context_properties)
		{
			context_property.Freeze(this);
		}
	}

	public override string ToString()
	{
		return "ContextID: " + context_id;
	}

	internal IMessageSink GetServerContextSinkChain()
	{
		if (server_context_sink_chain == null)
		{
			if (default_server_context_sink == null)
			{
				default_server_context_sink = new ServerContextTerminatorSink();
			}
			server_context_sink_chain = default_server_context_sink;
			if (context_properties != null)
			{
				for (int num = context_properties.Count - 1; num >= 0; num--)
				{
					if (context_properties[num] is IContributeServerContextSink contributeServerContextSink)
					{
						server_context_sink_chain = contributeServerContextSink.GetServerContextSink(server_context_sink_chain);
					}
				}
			}
		}
		return server_context_sink_chain;
	}

	internal IMessageSink GetClientContextSinkChain()
	{
		if (client_context_sink_chain == null)
		{
			client_context_sink_chain = new ClientContextTerminatorSink(this);
			if (context_properties != null)
			{
				foreach (IContextProperty context_property in context_properties)
				{
					if (context_property is IContributeClientContextSink contributeClientContextSink)
					{
						client_context_sink_chain = contributeClientContextSink.GetClientContextSink(client_context_sink_chain);
					}
				}
			}
		}
		return client_context_sink_chain;
	}

	internal IMessageSink CreateServerObjectSinkChain(MarshalByRefObject obj, bool forceInternalExecute)
	{
		IMessageSink nextSink = new StackBuilderSink(obj, forceInternalExecute);
		nextSink = new ServerObjectTerminatorSink(nextSink);
		nextSink = new LeaseSink(nextSink);
		if (context_properties != null)
		{
			for (int num = context_properties.Count - 1; num >= 0; num--)
			{
				if (context_properties[num] is IContributeObjectSink contributeObjectSink)
				{
					nextSink = contributeObjectSink.GetObjectSink(obj, nextSink);
				}
			}
		}
		return nextSink;
	}

	internal IMessageSink CreateEnvoySink(MarshalByRefObject serverObject)
	{
		IMessageSink messageSink = EnvoyTerminatorSink.Instance;
		if (context_properties != null)
		{
			foreach (IContextProperty context_property in context_properties)
			{
				if (context_property is IContributeEnvoySink contributeEnvoySink)
				{
					messageSink = contributeEnvoySink.GetEnvoySink(serverObject, messageSink);
				}
			}
		}
		return messageSink;
	}

	internal static Context SwitchToContext(Context newContext)
	{
		return AppDomain.InternalSetContext(newContext);
	}

	internal static Context CreateNewContext(IConstructionCallMessage msg)
	{
		Context context = new Context();
		foreach (IContextProperty contextProperty in msg.ContextProperties)
		{
			if (context.GetProperty(contextProperty.Name) == null)
			{
				context.SetProperty(contextProperty);
			}
		}
		context.Freeze();
		foreach (IContextProperty contextProperty2 in msg.ContextProperties)
		{
			if (!contextProperty2.IsNewContextOK(context))
			{
				throw new RemotingException("A context property did not approve the candidate context for activating the object");
			}
		}
		return context;
	}

	public void DoCallBack(CrossContextDelegate deleg)
	{
		lock (this)
		{
			if (callback_object == null)
			{
				Context newContext = SwitchToContext(this);
				callback_object = new ContextCallbackObject();
				SwitchToContext(newContext);
			}
		}
		callback_object.DoCallBack(deleg);
	}

	public static LocalDataStoreSlot AllocateDataSlot()
	{
		return _localDataStoreMgr.AllocateDataSlot();
	}

	public static LocalDataStoreSlot AllocateNamedDataSlot(string name)
	{
		return _localDataStoreMgr.AllocateNamedDataSlot(name);
	}

	public static void FreeNamedDataSlot(string name)
	{
		_localDataStoreMgr.FreeNamedDataSlot(name);
	}

	public static LocalDataStoreSlot GetNamedDataSlot(string name)
	{
		return _localDataStoreMgr.GetNamedDataSlot(name);
	}

	public static object GetData(LocalDataStoreSlot slot)
	{
		return Thread.CurrentContext.MyLocalStore.GetData(slot);
	}

	public static void SetData(LocalDataStoreSlot slot, object data)
	{
		Thread.CurrentContext.MyLocalStore.SetData(slot, data);
	}
}
