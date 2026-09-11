using System;
using MessagePack.Internal;

namespace MessagePack.Formatters;

public sealed class DDDDDFormatter : IMessagePackFormatter<DDDDD>, IMessagePackFormatter
{
	private static ReadOnlySpan<byte> GetSpan_b()
	{
		return "ag"u8;
	}

	private static ReadOnlySpan<byte> GetSpan_c()
	{
		return new byte[2] { 0, 45 };
	}

	public void Serialize(ref MessagePackWriter writer, DDDDD value, MessagePackSerializerOptions options)
	{
		if (value == null)
		{
			writer.WriteNil();
			return;
		}
		IFormatterResolver resolver = options.Resolver;
		writer.WriteMapHeader(2);
		writer.WriteRaw(GetSpan_b());
		resolver.GetFormatterWithVerify<BBBBB>().Serialize(ref writer, value.b, options);
		writer.WriteRaw(GetSpan_c());
		resolver.GetFormatterWithVerify<CCCCC>().Serialize(ref writer, value.c, options);
	}

	public DDDDD Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		options.Security.DepthStep(ref reader);
		IFormatterResolver resolver = options.Resolver;
		int num = reader.ReadMapHeader();
		DDDDD dDDDD = new DDDDD();
		for (int i = 0; i < num; i++)
		{
			ReadOnlySpan<byte> span = CodeGenHelpers.ReadStringSpan(ref reader);
			if (span.Length == 1)
			{
				switch (AutomataKeyGen.GetKey(ref span))
				{
				case 98uL:
					dDDDD.b = resolver.GetFormatterWithVerify<BBBBB>().Deserialize(ref reader, options);
					continue;
				case 99uL:
					dDDDD.c = resolver.GetFormatterWithVerify<CCCCC>().Deserialize(ref reader, options);
					continue;
				}
			}
			reader.Skip();
		}
		reader.Depth--;
		return dDDDD;
	}
}
