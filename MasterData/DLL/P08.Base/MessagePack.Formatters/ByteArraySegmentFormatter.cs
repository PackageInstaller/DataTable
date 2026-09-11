using System;
using System.Buffers;

namespace MessagePack.Formatters;

public sealed class ByteArraySegmentFormatter : IMessagePackFormatter<ArraySegment<byte>>, IMessagePackFormatter
{
	public static readonly ByteArraySegmentFormatter Instance = new ByteArraySegmentFormatter();

	private ByteArraySegmentFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, ArraySegment<byte> value, MessagePackSerializerOptions options)
	{
		if (value.Array == null)
		{
			writer.WriteNil();
		}
		else
		{
			writer.Write(value);
		}
	}

	public ArraySegment<byte> Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		ReadOnlySequence<byte>? readOnlySequence = reader.ReadBytes();
		if (!readOnlySequence.HasValue)
		{
			return default(ArraySegment<byte>);
		}
		return new ArraySegment<byte>(readOnlySequence.GetValueOrDefault().ToArray<byte>());
	}
}
