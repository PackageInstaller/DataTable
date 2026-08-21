using System;
using MessagePack.Internal;

namespace MessagePack.Formatters;

public sealed class AAAAAFormatter : IMessagePackFormatter<AAAAA>, IMessagePackFormatter
{
	private static ReadOnlySpan<byte> GetSpan_str()
	{
		return "Mess"u8;
	}

	public void Serialize(ref MessagePackWriter writer, AAAAA value, MessagePackSerializerOptions options)
	{
		if (value == null)
		{
			writer.WriteNil();
			return;
		}
		IFormatterResolver resolver = options.Resolver;
		writer.WriteMapHeader(1);
		writer.WriteRaw(GetSpan_str());
		resolver.GetFormatterWithVerify<string>().Serialize(ref writer, value.str, options);
	}

	public AAAAA Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		options.Security.DepthStep(ref reader);
		IFormatterResolver resolver = options.Resolver;
		int num = reader.ReadMapHeader();
		AAAAA aAAAA = new AAAAA();
		for (int i = 0; i < num; i++)
		{
			ReadOnlySpan<byte> span = CodeGenHelpers.ReadStringSpan(ref reader);
			if (span.Length != 3 || AutomataKeyGen.GetKey(ref span) != 7500915)
			{
				reader.Skip();
			}
			else
			{
				aAAAA.str = resolver.GetFormatterWithVerify<string>().Deserialize(ref reader, options);
			}
		}
		reader.Depth--;
		return aAAAA;
	}
}
