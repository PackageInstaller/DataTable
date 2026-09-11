using System.Runtime.Serialization;

namespace System;

[Serializable]
public class MemberAccessException : SystemException
{
	public MemberAccessException()
		: base("Cannot access member.")
	{
		base.HResult = -2146233062;
	}

	public MemberAccessException(string message)
		: base(message)
	{
		base.HResult = -2146233062;
	}

	public MemberAccessException(string message, Exception inner)
		: base(message, inner)
	{
		base.HResult = -2146233062;
	}

	protected MemberAccessException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
