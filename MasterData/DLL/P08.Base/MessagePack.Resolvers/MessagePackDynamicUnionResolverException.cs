namespace MessagePack.Resolvers;

internal class MessagePackDynamicUnionResolverException : MessagePackSerializationException
{
	public MessagePackDynamicUnionResolverException(string message)
		: base(message)
	{
	}
}
