namespace MessagePack.Internal;

internal class MessagePackDynamicObjectResolverException : MessagePackSerializationException
{
	public MessagePackDynamicObjectResolverException(string message)
		: base(message)
	{
	}
}
