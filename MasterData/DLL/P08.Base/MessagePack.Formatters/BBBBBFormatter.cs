using System;
using MessagePack.Internal;

namespace MessagePack.Formatters;

public sealed class BBBBBFormatter : IMessagePackFormatter<BBBBB>, IMessagePackFormatter
{
	private static ReadOnlySpan<byte> GetSpan_a()
	{
		return "Ba"u8;
	}

	public void Serialize(ref MessagePackWriter writer, BBBBB value, MessagePackSerializerOptions options)
	{
		if (value == null)
		{
			writer.WriteNil();
			return;
		}
		IFormatterResolver resolver = options.Resolver;
		writer.WriteMapHeader(1);
		writer.WriteRaw(GetSpan_a());
		resolver.GetFormatterWithVerify<AAAAA>().Serialize(ref writer, value.a, options);
	}

	public BBBBB Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		options.Security.DepthStep(ref reader);
		IFormatterResolver resolver = options.Resolver;
		int num = reader.ReadMapHeader();
		BBBBB bBBBB = new BBBBB();
		for (int i = 0; i < num; i++)
		{
			ReadOnlySpan<byte> readOnlySpan = CodeGenHelpers.ReadStringSpan(ref reader);
			if (readOnlySpan.Length != 1 || readOnlySpan[0] != 97)
			{
				reader.Skip();
			}
			else
			{
				bBBBB.a = resolver.GetFormatterWithVerify<AAAAA>().Deserialize(ref reader, options);
			}
		}
		reader.Depth--;
		return bBBBB;
	}
}
