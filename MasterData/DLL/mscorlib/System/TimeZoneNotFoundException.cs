using System.Runtime.CompilerServices;
using System.Runtime.Serialization;

namespace System;

[Serializable]
[TypeForwardedFrom("System.Core, Version=2.0.5.0, Culture=Neutral, PublicKeyToken=7cec85d7bea7798e")]
public class TimeZoneNotFoundException : Exception
{
	public TimeZoneNotFoundException()
	{
	}

	protected TimeZoneNotFoundException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
