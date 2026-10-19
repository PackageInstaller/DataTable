using System.Runtime.Remoting.Contexts;
using System.Runtime.Remoting.Lifetime;
using System.Runtime.Remoting.Messaging;
using System.Runtime.Remoting.Proxies;
using System.Runtime.Remoting.Services;

namespace System.Runtime.Remoting;

internal abstract class ServerIdentity : Identity
{
	protected Type _objectType;

	protected MarshalByRefObject _serverObject;

	protected IMessageSink _serverSink;

	protected Context _context;

	protected Lease _lease;

	public Type ObjectType => _objectType;

	public Lease Lease => _lease;

	public Context Context
	{
		get
		{
			return _context;
		}
		set
		{
			_context = value;
		}
	}

	public ServerIdentity(string objectUri, Context context, Type objectType)
		: base(objectUri)
	{
		_objectType = objectType;
		_context = context;
	}

	public void StartTrackingLifetime(ILease lease)
	{
		if (lease != null && lease.CurrentState == LeaseState.Null)
		{
			lease = null;
		}
		if (lease != null)
		{
			if (!(lease is Lease))
			{
				lease = new Lease();
			}
			_lease = (Lease)lease;
			LifetimeServices.TrackLifetime(this);
		}
	}

	public virtual void OnLifetimeExpired()
	{
		DisposeServerObject();
	}

	public override ObjRef CreateObjRef(Type requestedType)
	{
		if (_objRef != null)
		{
			_objRef.UpdateChannelInfo();
			return _objRef;
		}
		if (requestedType == null)
		{
			requestedType = _objectType;
		}
		_objRef = new ObjRef();
		_objRef.TypeInfo = new TypeInfo(requestedType);
		_objRef.URI = _objectUri;
		if (_envoySink != null && !(_envoySink is EnvoyTerminatorSink))
		{
			_objRef.EnvoyInfo = new EnvoyInfo(_envoySink);
		}
		return _objRef;
	}

	public void AttachServerObject(MarshalByRefObject serverObject, Context context)
	{
		DisposeServerObject();
		_context = context;
		_serverObject = serverObject;
		if (RemotingServices.IsTransparentProxy(serverObject))
		{
			RealProxy realProxy = RemotingServices.GetRealProxy(serverObject);
			if (realProxy.ObjectIdentity == null)
			{
				realProxy.ObjectIdentity = this;
			}
		}
		else
		{
			if (_objectType.IsContextful)
			{
				_envoySink = context.CreateEnvoySink(serverObject);
			}
			_serverObject.ObjectIdentity = this;
		}
	}

	public abstract IMessage SyncObjectProcessMessage(IMessage msg);

	public abstract IMessageCtrl AsyncObjectProcessMessage(IMessage msg, IMessageSink replySink);

	protected void DisposeServerObject()
	{
		if (_serverObject != null)
		{
			MarshalByRefObject serverObject = _serverObject;
			_serverObject.ObjectIdentity = null;
			_serverObject = null;
			_serverSink = null;
			TrackingServices.NotifyDisconnectedObject(serverObject);
		}
	}
}
