using System.Runtime.Remoting.Messaging;

namespace System.Runtime.Remoting.Channels;

internal class AsyncRequest
{
	internal IMessageSink ReplySink;

	internal IMessage MsgRequest;

	public AsyncRequest(IMessage msgRequest, IMessageSink replySink)
	{
		ReplySink = replySink;
		MsgRequest = msgRequest;
	}
}
