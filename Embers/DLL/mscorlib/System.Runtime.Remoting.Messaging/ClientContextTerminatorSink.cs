using System.Runtime.Remoting.Activation;
using System.Runtime.Remoting.Contexts;

namespace System.Runtime.Remoting.Messaging;

internal class ClientContextTerminatorSink : IMessageSink
{
	private Context _context;

	public ClientContextTerminatorSink(Context ctx)
	{
		_context = ctx;
	}

	public IMessage SyncProcessMessage(IMessage msg)
	{
		Context.NotifyGlobalDynamicSinks(start: true, msg, client_site: true, async: false);
		_context.NotifyDynamicSinks(start: true, msg, client_site: true, async: false);
		IMessage result = ((!(msg is IConstructionCallMessage)) ? RemotingServices.GetMessageTargetIdentity(msg).ChannelSink.SyncProcessMessage(msg) : ActivationServices.RemoteActivate((IConstructionCallMessage)msg));
		Context.NotifyGlobalDynamicSinks(start: false, msg, client_site: true, async: false);
		_context.NotifyDynamicSinks(start: false, msg, client_site: true, async: false);
		return result;
	}

	public IMessageCtrl AsyncProcessMessage(IMessage msg, IMessageSink replySink)
	{
		if (_context.HasDynamicSinks || Context.HasGlobalDynamicSinks)
		{
			Context.NotifyGlobalDynamicSinks(start: true, msg, client_site: true, async: true);
			_context.NotifyDynamicSinks(start: true, msg, client_site: true, async: true);
			if (replySink != null)
			{
				replySink = new ClientContextReplySink(_context, replySink);
			}
		}
		IMessageCtrl result = RemotingServices.GetMessageTargetIdentity(msg).ChannelSink.AsyncProcessMessage(msg, replySink);
		if (replySink == null && (_context.HasDynamicSinks || Context.HasGlobalDynamicSinks))
		{
			Context.NotifyGlobalDynamicSinks(start: false, msg, client_site: true, async: true);
			_context.NotifyDynamicSinks(start: false, msg, client_site: true, async: true);
		}
		return result;
	}
}
