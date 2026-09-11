using System;
using System.Runtime.Serialization;

namespace MessagePack.Internal;

[Serializable]
internal class InitAccessorInGenericClassNotSupportedException : NotSupportedException
{
	public InitAccessorInGenericClassNotSupportedException()
	{
	}

	public InitAccessorInGenericClassNotSupportedException(string message)
		: base(message)
	{
	}

	public InitAccessorInGenericClassNotSupportedException(string message, Exception inner)
		: base(message, inner)
	{
	}

	protected InitAccessorInGenericClassNotSupportedException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
