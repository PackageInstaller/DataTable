namespace System.Runtime.Remoting.Messaging;

internal class ServerObjectReplySink : IMessageSink
{
	private IMessageSink _replySink;

	private ServerIdentity _identity;

	public ServerObjectReplySink(ServerIdentity identity, IMessageSink replySink)
	{
		_replySink = replySink;
		_identity = identity;
	}

	public IMessage SyncProcessMessage(IMessage msg)
	{
		_identity.NotifyServerDynamicSinks(start: false, msg, client_site: true, async: true);
		return _replySink.SyncProcessMessage(msg);
	}

	public IMessageCtrl AsyncProcessMessage(IMessage msg, IMessageSink replySink)
	{
		throw new NotSupportedException();
	}
}
