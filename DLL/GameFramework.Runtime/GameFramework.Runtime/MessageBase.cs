using System;

namespace GameFramework.Runtime;

public class MessageBase : EventArgs
{
	public object Sender { get; protected set; }

	public MessageBase(object sender)
	{
		Sender = sender;
	}
}
