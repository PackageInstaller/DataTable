using System.Runtime.Remoting.Messaging;

namespace System.Runtime.Remoting;

internal class ClientActivatedIdentity : ServerIdentity
{
	private MarshalByRefObject _targetThis;

	public ClientActivatedIdentity(string objectUri, Type objectType)
		: base(objectUri, null, objectType)
	{
	}

	public MarshalByRefObject GetServerObject()
	{
		return _serverObject;
	}

	public void SetClientProxy(MarshalByRefObject obj)
	{
		_targetThis = obj;
	}

	public override void OnLifetimeExpired()
	{
		base.OnLifetimeExpired();
		RemotingServices.DisposeIdentity(this);
	}

	public override IMessage SyncObjectProcessMessage(IMessage msg)
	{
		if (_serverSink == null)
		{
			bool flag = _targetThis != null;
			_serverSink = _context.CreateServerObjectSinkChain(flag ? _targetThis : _serverObject, flag);
		}
		return _serverSink.SyncProcessMessage(msg);
	}

	public override IMessageCtrl AsyncObjectProcessMessage(IMessage msg, IMessageSink replySink)
	{
		if (_serverSink == null)
		{
			bool flag = _targetThis != null;
			_serverSink = _context.CreateServerObjectSinkChain(flag ? _targetThis : _serverObject, flag);
		}
		return _serverSink.AsyncProcessMessage(msg, replySink);
	}
}
