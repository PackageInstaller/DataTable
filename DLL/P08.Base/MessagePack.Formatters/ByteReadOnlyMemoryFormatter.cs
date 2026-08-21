using System;
using System.Buffers;

namespace MessagePack.Formatters;

public sealed class ByteReadOnlyMemoryFormatter : IMessagePackFormatter<ReadOnlyMemory<byte>>, IMessagePackFormatter
{
	public static readonly ByteReadOnlyMemoryFormatter Instance = new ByteReadOnlyMemoryFormatter();

	private ByteReadOnlyMemoryFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, ReadOnlyMemory<byte> value, MessagePackSerializerOptions options)
	{
		writer.Write(value.Span);
	}

	public ReadOnlyMemory<byte> Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		ReadOnlySequence<byte>? readOnlySequence = reader.ReadBytes();
		if (!readOnlySequence.HasValue)
		{
			return default(ReadOnlyMemory<byte>);
		}
		return new ReadOnlyMemory<byte>(readOnlySequence.GetValueOrDefault().ToArray<byte>());
	}
}
