using System.Runtime.Remoting.Contexts;
using System.Runtime.Remoting.Lifetime;
using System.Runtime.Remoting.Messaging;

namespace System.Runtime.Remoting;

internal class SingletonIdentity : ServerIdentity
{
	public SingletonIdentity(string objectUri, Context context, Type objectType)
		: base(objectUri, context, objectType)
	{
	}

	public MarshalByRefObject GetServerObject()
	{
		if (_serverObject != null)
		{
			return _serverObject;
		}
		lock (this)
		{
			if (_serverObject == null)
			{
				MarshalByRefObject marshalByRefObject = (MarshalByRefObject)Activator.CreateInstance(_objectType, nonPublic: true);
				AttachServerObject(marshalByRefObject, Context.DefaultContext);
				StartTrackingLifetime((ILease)marshalByRefObject.InitializeLifetimeService());
			}
		}
		return _serverObject;
	}

	public override IMessage SyncObjectProcessMessage(IMessage msg)
	{
		MarshalByRefObject serverObject = GetServerObject();
		if (_serverSink == null)
		{
			_serverSink = _context.CreateServerObjectSinkChain(serverObject, forceInternalExecute: false);
		}
		return _serverSink.SyncProcessMessage(msg);
	}

	public override IMessageCtrl AsyncObjectProcessMessage(IMessage msg, IMessageSink replySink)
	{
		MarshalByRefObject serverObject = GetServerObject();
		if (_serverSink == null)
		{
			_serverSink = _context.CreateServerObjectSinkChain(serverObject, forceInternalExecute: false);
		}
		return _serverSink.AsyncProcessMessage(msg, replySink);
	}
}
