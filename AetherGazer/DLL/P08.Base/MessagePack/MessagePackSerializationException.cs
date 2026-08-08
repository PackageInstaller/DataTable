using System;
using System.Runtime.Serialization;

namespace MessagePack;

[Serializable]
public class MessagePackSerializationException : Exception
{
	public MessagePackSerializationException()
	{
	}

	public MessagePackSerializationException(string message)
		: base(message)
	{
	}

	public MessagePackSerializationException(string message, Exception inner)
		: base(message, inner)
	{
	}

	protected MessagePackSerializationException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
