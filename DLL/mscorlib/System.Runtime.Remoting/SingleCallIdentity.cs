using System.Runtime.Remoting.Contexts;
using System.Runtime.Remoting.Messaging;

namespace System.Runtime.Remoting;

internal class SingleCallIdentity : ServerIdentity
{
	public SingleCallIdentity(string objectUri, Context context, Type objectType)
		: base(objectUri, context, objectType)
	{
	}

	public override IMessage SyncObjectProcessMessage(IMessage msg)
	{
		MarshalByRefObject marshalByRefObject = (MarshalByRefObject)Activator.CreateInstance(_objectType, nonPublic: true);
		if (marshalByRefObject.ObjectIdentity == null)
		{
			marshalByRefObject.ObjectIdentity = this;
		}
		IMessage result = _context.CreateServerObjectSinkChain(marshalByRefObject, forceInternalExecute: false).SyncProcessMessage(msg);
		if (marshalByRefObject is IDisposable)
		{
			((IDisposable)marshalByRefObject).Dispose();
		}
		return result;
	}

	public override IMessageCtrl AsyncObjectProcessMessage(IMessage msg, IMessageSink replySink)
	{
		MarshalByRefObject marshalByRefObject = (MarshalByRefObject)Activator.CreateInstance(_objectType, nonPublic: true);
		IMessageSink messageSink = _context.CreateServerObjectSinkChain(marshalByRefObject, forceInternalExecute: false);
		if (marshalByRefObject is IDisposable)
		{
			replySink = new DisposerReplySink(replySink, (IDisposable)marshalByRefObject);
		}
		return messageSink.AsyncProcessMessage(msg, replySink);
	}
}
