using System.Runtime.Serialization;

namespace System;

[Serializable]
public class MethodAccessException : MemberAccessException
{
	public MethodAccessException()
		: base("Attempt to access the method failed.")
	{
		base.HResult = -2146233072;
	}

	public MethodAccessException(string message)
		: base(message)
	{
		base.HResult = -2146233072;
	}

	protected MethodAccessException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
