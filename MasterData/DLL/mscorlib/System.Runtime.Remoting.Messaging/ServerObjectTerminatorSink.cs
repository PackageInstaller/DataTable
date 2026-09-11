namespace System.Runtime.Remoting.Messaging;

internal class ServerObjectTerminatorSink : IMessageSink
{
	private IMessageSink _nextSink;

	public ServerObjectTerminatorSink(IMessageSink nextSink)
	{
		_nextSink = nextSink;
	}

	public IMessage SyncProcessMessage(IMessage msg)
	{
		ServerIdentity serverIdentity = (ServerIdentity)RemotingServices.GetMessageTargetIdentity(msg);
		serverIdentity.NotifyServerDynamicSinks(start: true, msg, client_site: false, async: false);
		IMessage result = _nextSink.SyncProcessMessage(msg);
		serverIdentity.NotifyServerDynamicSinks(start: false, msg, client_site: false, async: false);
		return result;
	}

	public IMessageCtrl AsyncProcessMessage(IMessage msg, IMessageSink replySink)
	{
		ServerIdentity serverIdentity = (ServerIdentity)RemotingServices.GetMessageTargetIdentity(msg);
		if (serverIdentity.HasServerDynamicSinks)
		{
			serverIdentity.NotifyServerDynamicSinks(start: true, msg, client_site: false, async: true);
			if (replySink != null)
			{
				replySink = new ServerObjectReplySink(serverIdentity, replySink);
			}
		}
		IMessageCtrl result = _nextSink.AsyncProcessMessage(msg, replySink);
		if (replySink == null)
		{
			serverIdentity.NotifyServerDynamicSinks(start: false, msg, client_site: true, async: true);
		}
		return result;
	}
}
