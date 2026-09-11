using System.Runtime.Serialization;

namespace System;

[Serializable]
public sealed class MulticastNotSupportedException : SystemException
{
	public MulticastNotSupportedException()
		: base("Attempted to add multiple callbacks to a delegate that does not support multicast.")
	{
		base.HResult = -2146233068;
	}

	public MulticastNotSupportedException(string message)
		: base(message)
	{
		base.HResult = -2146233068;
	}

	internal MulticastNotSupportedException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
