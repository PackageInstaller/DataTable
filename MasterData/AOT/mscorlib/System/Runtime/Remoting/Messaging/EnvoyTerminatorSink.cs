using System.Threading;

namespace System.Runtime.Remoting.Messaging;

[Serializable]
internal class EnvoyTerminatorSink : IMessageSink
{
	public static EnvoyTerminatorSink Instance = new EnvoyTerminatorSink();

	public IMessage SyncProcessMessage(IMessage msg)
	{
		return Thread.CurrentContext.GetClientContextSinkChain().SyncProcessMessage(msg);
	}

	public IMessageCtrl AsyncProcessMessage(IMessage msg, IMessageSink replySink)
	{
		return Thread.CurrentContext.GetClientContextSinkChain().AsyncProcessMessage(msg, replySink);
	}
}
