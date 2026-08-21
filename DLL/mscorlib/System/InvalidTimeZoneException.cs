using System.Runtime.CompilerServices;
using System.Runtime.Serialization;

namespace System;

[Serializable]
[TypeForwardedFrom("System.Core, Version=2.0.5.0, Culture=Neutral, PublicKeyToken=7cec85d7bea7798e")]
public class InvalidTimeZoneException : Exception
{
	public InvalidTimeZoneException()
	{
	}

	public InvalidTimeZoneException(string message)
		: base(message)
	{
	}

	public InvalidTimeZoneException(string message, Exception innerException)
		: base(message, innerException)
	{
	}

	protected InvalidTimeZoneException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
