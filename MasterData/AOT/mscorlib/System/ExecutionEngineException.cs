using System.Runtime.Serialization;

namespace System;

[Serializable]
[Obsolete("This type previously indicated an unspecified fatal error in the runtime. The runtime no longer raises this exception so this type is obsolete.")]
public sealed class ExecutionEngineException : SystemException
{
	public ExecutionEngineException()
		: base("Internal error in the runtime.")
	{
		HResult = -2146233082;
	}

	public ExecutionEngineException(string message)
		: base(message)
	{
		HResult = -2146233082;
	}

	internal ExecutionEngineException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
