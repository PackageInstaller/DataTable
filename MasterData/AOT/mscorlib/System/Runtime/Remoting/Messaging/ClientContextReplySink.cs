using System.Runtime.Remoting.Contexts;

namespace System.Runtime.Remoting.Messaging;

internal class ClientContextReplySink : IMessageSink
{
	private IMessageSink _replySink;

	private Context _context;

	public ClientContextReplySink(Context ctx, IMessageSink replySink)
	{
		_replySink = replySink;
		_context = ctx;
	}

	public IMessage SyncProcessMessage(IMessage msg)
	{
		Context.NotifyGlobalDynamicSinks(start: false, msg, client_site: true, async: true);
		_context.NotifyDynamicSinks(start: false, msg, client_site: true, async: true);
		return _replySink.SyncProcessMessage(msg);
	}

	public IMessageCtrl AsyncProcessMessage(IMessage msg, IMessageSink replySink)
	{
		throw new NotSupportedException();
	}
}
