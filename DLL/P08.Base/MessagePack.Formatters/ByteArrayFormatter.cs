using System.Buffers;

namespace MessagePack.Formatters;

public sealed class ByteArrayFormatter : IMessagePackFormatter<byte[]>, IMessagePackFormatter
{
	public static readonly ByteArrayFormatter Instance = new ByteArrayFormatter();

	private ByteArrayFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, byte[] value, MessagePackSerializerOptions options)
	{
		writer.Write(value);
	}

	public byte[] Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		ReadOnlySequence<byte>? readOnlySequence = reader.ReadBytes();
		if (!readOnlySequence.HasValue)
		{
			return null;
		}
		return readOnlySequence.GetValueOrDefault().ToArray<byte>();
	}
}
