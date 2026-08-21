using System.Runtime.Remoting.Messaging;

namespace System.Runtime.Remoting;

internal class DisposerReplySink : IMessageSink
{
	private IMessageSink _next;

	private IDisposable _disposable;

	public DisposerReplySink(IMessageSink next, IDisposable disposable)
	{
		_next = next;
		_disposable = disposable;
	}

	public IMessage SyncProcessMessage(IMessage msg)
	{
		_disposable.Dispose();
		return _next.SyncProcessMessage(msg);
	}

	public IMessageCtrl AsyncProcessMessage(IMessage msg, IMessageSink replySink)
	{
		throw new NotSupportedException();
	}
}
