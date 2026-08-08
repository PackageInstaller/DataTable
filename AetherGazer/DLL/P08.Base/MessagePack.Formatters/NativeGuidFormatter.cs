using System;
using System.Buffers;

namespace MessagePack.Formatters;

public sealed class NativeGuidFormatter : IMessagePackFormatter<Guid>, IMessagePackFormatter
{
	public static readonly IMessagePackFormatter<Guid> Instance = new NativeGuidFormatter();

	private NativeGuidFormatter()
	{
	}

	public unsafe void Serialize(ref MessagePackWriter writer, Guid value, MessagePackSerializerOptions options)
	{
		if (!BitConverter.IsLittleEndian)
		{
			throw new InvalidOperationException("NativeGuidFormatter only allows on little endian env.");
		}
		ReadOnlySpan<byte> src = new ReadOnlySpan<byte>(&value, sizeof(Guid));
		writer.Write(src);
	}

	public unsafe Guid Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (!BitConverter.IsLittleEndian)
		{
			throw new InvalidOperationException("NativeGuidFormatter only allows on little endian env.");
		}
		ReadOnlySequence<byte> source = reader.ReadBytes().Value;
		if (source.Length != sizeof(Guid))
		{
			throw new MessagePackSerializationException("Invalid Guid Size.");
		}
		Guid result = default(Guid);
		Span<byte> destination = new Span<byte>(&result, sizeof(Guid));
		source.CopyTo(destination);
		return result;
	}
}
