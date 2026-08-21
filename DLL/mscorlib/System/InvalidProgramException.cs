using System.Runtime.Serialization;

namespace System;

[Serializable]
public sealed class InvalidProgramException : SystemException
{
	public InvalidProgramException()
		: base("Common Language Runtime detected an invalid program.")
	{
		base.HResult = -2146233030;
	}

	public InvalidProgramException(string message)
		: base(message)
	{
		base.HResult = -2146233030;
	}

	internal InvalidProgramException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
