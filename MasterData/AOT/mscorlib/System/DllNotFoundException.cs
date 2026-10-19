using System.Runtime.Serialization;

namespace System;

[Serializable]
public class DllNotFoundException : TypeLoadException
{
	public DllNotFoundException()
		: base("Dll was not found.")
	{
		HResult = -2146233052;
	}

	public DllNotFoundException(string message)
		: base(message)
	{
		HResult = -2146233052;
	}

	protected DllNotFoundException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
