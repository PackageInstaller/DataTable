using System;
using System.Buffers;
using MessagePack.Internal;

namespace MessagePack.Formatters;

public sealed class GuidFormatter : IMessagePackFormatter<Guid>, IMessagePackFormatter
{
	public static readonly IMessagePackFormatter<Guid> Instance = new GuidFormatter();

	private GuidFormatter()
	{
	}

	public unsafe void Serialize(ref MessagePackWriter writer, Guid value, MessagePackSerializerOptions options)
	{
		byte* pointer = stackalloc byte[36];
		Span<byte> span = new Span<byte>(pointer, 36);
		new GuidBits(ref value).Write(span);
		writer.WriteString(span);
	}

	public Guid Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		ReadOnlySequence<byte> source = reader.ReadStringSequence().Value;
		if (source.Length != 36)
		{
			throw new MessagePackSerializationException("Unexpected length of string.");
		}
		GuidBits guidBits;
		if (source.IsSingleSegment)
		{
			guidBits = new GuidBits(source.First.Span);
		}
		else
		{
			Span<byte> span = stackalloc byte[36];
			source.CopyTo(span);
			guidBits = new GuidBits(span);
		}
		return guidBits.Value;
	}
}
