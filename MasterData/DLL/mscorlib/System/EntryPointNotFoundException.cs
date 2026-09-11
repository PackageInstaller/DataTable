using System.Runtime.Serialization;

namespace System;

[Serializable]
public class EntryPointNotFoundException : TypeLoadException
{
	public EntryPointNotFoundException()
		: base("Entry point was not found.")
	{
		base.HResult = -2146233053;
	}

	public EntryPointNotFoundException(string message)
		: base(message)
	{
		base.HResult = -2146233053;
	}

	protected EntryPointNotFoundException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
