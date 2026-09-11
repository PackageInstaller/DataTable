using System;
using System.Buffers;

namespace MessagePack.Formatters;

public sealed class NativeDecimalFormatter : IMessagePackFormatter<decimal>, IMessagePackFormatter
{
	public static readonly IMessagePackFormatter<decimal> Instance = new NativeDecimalFormatter();

	private NativeDecimalFormatter()
	{
	}

	public unsafe void Serialize(ref MessagePackWriter writer, decimal value, MessagePackSerializerOptions options)
	{
		if (!BitConverter.IsLittleEndian)
		{
			throw new InvalidOperationException("NativeDecimalFormatter only allows on little endian env.");
		}
		ReadOnlySpan<byte> src = new ReadOnlySpan<byte>(&value, 16);
		writer.Write(src);
	}

	public unsafe decimal Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (!BitConverter.IsLittleEndian)
		{
			throw new InvalidOperationException("NativeDecimalFormatter only allows on little endian env.");
		}
		ReadOnlySequence<byte> source = reader.ReadBytes().Value;
		if (source.Length != 16)
		{
			throw new MessagePackSerializationException("Invalid decimal Size.");
		}
		decimal result = default(decimal);
		Span<byte> destination = new Span<byte>(&result, 16);
		source.CopyTo(destination);
		return result;
	}
}
