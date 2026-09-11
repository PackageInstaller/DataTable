using System;
using System.Buffers;

namespace MessagePack.Formatters;

public sealed class ByteMemoryFormatter : IMessagePackFormatter<Memory<byte>>, IMessagePackFormatter
{
	public static readonly ByteMemoryFormatter Instance = new ByteMemoryFormatter();

	private ByteMemoryFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, Memory<byte> value, MessagePackSerializerOptions options)
	{
		writer.Write(value.Span);
	}

	public Memory<byte> Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		ReadOnlySequence<byte>? readOnlySequence = reader.ReadBytes();
		if (!readOnlySequence.HasValue)
		{
			return default(Memory<byte>);
		}
		return new Memory<byte>(readOnlySequence.GetValueOrDefault().ToArray<byte>());
	}
}
