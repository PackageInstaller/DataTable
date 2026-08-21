using System.Runtime.Serialization;

namespace System;

[Serializable]
public class FieldAccessException : MemberAccessException
{
	public FieldAccessException()
		: base("Attempted to access a field that is not accessible by the caller.")
	{
		base.HResult = -2146233081;
	}

	public FieldAccessException(string message)
		: base(message)
	{
		base.HResult = -2146233081;
	}

	protected FieldAccessException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
