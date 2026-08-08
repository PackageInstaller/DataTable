using System;
using System.Buffers;

namespace MessagePack.Formatters;

public sealed class ByteReadOnlySequenceFormatter : IMessagePackFormatter<ReadOnlySequence<byte>>, IMessagePackFormatter
{
	public static readonly ByteReadOnlySequenceFormatter Instance = new ByteReadOnlySequenceFormatter();

	private ByteReadOnlySequenceFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, ReadOnlySequence<byte> value, MessagePackSerializerOptions options)
	{
		writer.WriteBinHeader(checked((int)value.Length));
		foreach (ReadOnlyMemory<byte> item in value)
		{
			writer.WriteRaw(item.Span);
		}
	}

	public ReadOnlySequence<byte> Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		ReadOnlySequence<byte>? readOnlySequence = reader.ReadBytes();
		if (!readOnlySequence.HasValue)
		{
			return default(ReadOnlySequence<byte>);
		}
		return new ReadOnlySequence<byte>(readOnlySequence.GetValueOrDefault().ToArray<byte>());
	}
}
