namespace MessagePack;

internal static class MessagePackCompressionExtensions
{
	public static bool IsCompression(this MessagePackCompression compression)
	{
		return compression != MessagePackCompression.None;
	}
}
