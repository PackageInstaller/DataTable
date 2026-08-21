using System;
using System.Buffers;
using System.Buffers.Text;
using System.Globalization;

namespace MessagePack.Formatters;

public sealed class DecimalFormatter : IMessagePackFormatter<decimal>, IMessagePackFormatter
{
	public static readonly DecimalFormatter Instance = new DecimalFormatter();

	private DecimalFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, decimal value, MessagePackSerializerOptions options)
	{
		Span<byte> span = writer.GetSpan(31);
		if (Utf8Formatter.TryFormat(value, span.Slice(1), out var bytesWritten))
		{
			span[0] = (byte)(0xA0 | bytesWritten);
			writer.Advance(bytesWritten + 1);
		}
		else
		{
			writer.Advance(0);
			writer.Write(value.ToString(CultureInfo.InvariantCulture));
		}
	}

	public decimal Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		ReadOnlySequence<byte> source = reader.ReadStringSequence() ?? throw new MessagePackSerializationException($"Unexpected msgpack code {(byte)192} ({MessagePackCode.ToFormatName(192)}) encountered.");
		if (source.IsSingleSegment)
		{
			ReadOnlySpan<byte> span = source.First.Span;
			if (Utf8Parser.TryParse(span, out var value, out var bytesConsumed))
			{
				if (span.Length != bytesConsumed)
				{
					throw new MessagePackSerializationException("Unexpected length of string.");
				}
				return value;
			}
		}
		else
		{
			int num = (int)source.Length;
			if (num < 128)
			{
				Span<byte> span2 = stackalloc byte[num];
				source.CopyTo(span2);
				if (Utf8Parser.TryParse(span2, out var value2, out var bytesConsumed2))
				{
					if (num != bytesConsumed2)
					{
						throw new MessagePackSerializationException("Unexpected length of string.");
					}
					return value2;
				}
			}
			else
			{
				byte[] array = ArrayPool<byte>.Shared.Rent(num);
				try
				{
					source.CopyTo(array);
					if (Utf8Parser.TryParse(array.AsSpan(0, num), out var value3, out var bytesConsumed3))
					{
						if (num != bytesConsumed3)
						{
							throw new MessagePackSerializationException("Unexpected length of string.");
						}
						return value3;
					}
				}
				finally
				{
					ArrayPool<byte>.Shared.Return(array);
				}
			}
		}
		throw new MessagePackSerializationException("Can't parse to decimal, input string was not in a correct format.");
	}
}
