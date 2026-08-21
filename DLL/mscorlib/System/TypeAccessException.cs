using System.Runtime.Serialization;

namespace System;

[Serializable]
public class TypeAccessException : TypeLoadException
{
	public TypeAccessException()
		: base("Attempt to access the type failed.")
	{
		base.HResult = -2146233021;
	}

	public TypeAccessException(string message)
		: base(message)
	{
		base.HResult = -2146233021;
	}

	protected TypeAccessException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
