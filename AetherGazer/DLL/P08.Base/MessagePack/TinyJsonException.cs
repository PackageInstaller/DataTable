using System;
using System.Runtime.Serialization;

namespace MessagePack;

[Serializable]
public class TinyJsonException : MessagePackSerializationException
{
	public TinyJsonException(string message)
		: base(message)
	{
	}

	protected TinyJsonException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
