using System.Runtime.Serialization;

namespace System;

[Serializable]
public class PlatformNotSupportedException : NotSupportedException
{
	public PlatformNotSupportedException()
		: base("Operation is not supported on this platform.")
	{
		base.HResult = -2146233031;
	}

	public PlatformNotSupportedException(string message)
		: base(message)
	{
		base.HResult = -2146233031;
	}

	protected PlatformNotSupportedException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
