using System.Runtime.Remoting.Messaging;

namespace System.Runtime.Remoting.Lifetime;

internal class LeaseSink : IMessageSink
{
	private IMessageSink _nextSink;

	public LeaseSink(IMessageSink nextSink)
	{
		_nextSink = nextSink;
	}

	public IMessage SyncProcessMessage(IMessage msg)
	{
		RenewLease(msg);
		return _nextSink.SyncProcessMessage(msg);
	}

	public IMessageCtrl AsyncProcessMessage(IMessage msg, IMessageSink replySink)
	{
		RenewLease(msg);
		return _nextSink.AsyncProcessMessage(msg, replySink);
	}

	private void RenewLease(IMessage msg)
	{
		ILease lease = ((ServerIdentity)RemotingServices.GetMessageTargetIdentity(msg)).Lease;
		if (lease != null && lease.CurrentLeaseTime < lease.RenewOnCallTime)
		{
			lease.Renew(lease.RenewOnCallTime);
		}
	}
}
