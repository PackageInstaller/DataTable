using System.Runtime.Serialization;

namespace System;

[Serializable]
public class AccessViolationException : SystemException
{
	public AccessViolationException()
		: base("Attempted to read or write protected memory. This is often an indication that other memory is corrupt.")
	{
		base.HResult = -2147467261;
	}

	protected AccessViolationException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
