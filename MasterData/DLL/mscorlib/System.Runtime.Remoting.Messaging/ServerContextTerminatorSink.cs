using System.Runtime.Remoting.Activation;

namespace System.Runtime.Remoting.Messaging;

internal class ServerContextTerminatorSink : IMessageSink
{
	public IMessage SyncProcessMessage(IMessage msg)
	{
		if (msg is IConstructionCallMessage)
		{
			return ActivationServices.CreateInstanceFromMessage((IConstructionCallMessage)msg);
		}
		return ((ServerIdentity)RemotingServices.GetMessageTargetIdentity(msg)).SyncObjectProcessMessage(msg);
	}

	public IMessageCtrl AsyncProcessMessage(IMessage msg, IMessageSink replySink)
	{
		return ((ServerIdentity)RemotingServices.GetMessageTargetIdentity(msg)).AsyncObjectProcessMessage(msg, replySink);
	}
}
