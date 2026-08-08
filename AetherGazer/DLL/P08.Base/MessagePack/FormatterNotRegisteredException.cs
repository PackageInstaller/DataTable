using System;
using System.Runtime.Serialization;

namespace MessagePack;

[Serializable]
public class FormatterNotRegisteredException : MessagePackSerializationException
{
	public FormatterNotRegisteredException(string message)
		: base(message)
	{
	}

	protected FormatterNotRegisteredException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
