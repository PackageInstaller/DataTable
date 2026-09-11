using MessagePack.Formatters;
using UnityEngine;

namespace MessagePack.Unity;

public sealed class GradientFormatter : IMessagePackFormatter<Gradient>, IMessagePackFormatter
{
	public void Serialize(ref MessagePackWriter writer, Gradient value, MessagePackSerializerOptions options)
	{
		if (value == null)
		{
			writer.WriteNil();
			return;
		}
		IFormatterResolver resolver = options.Resolver;
		writer.WriteArrayHeader(3);
		resolver.GetFormatterWithVerify<GradientColorKey[]>().Serialize(ref writer, value.colorKeys, options);
		resolver.GetFormatterWithVerify<GradientAlphaKey[]>().Serialize(ref writer, value.alphaKeys, options);
		resolver.GetFormatterWithVerify<GradientMode>().Serialize(ref writer, value.mode, options);
	}

	public Gradient Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.IsNil)
		{
			return null;
		}
		IFormatterResolver resolver = options.Resolver;
		int num = reader.ReadArrayHeader();
		GradientColorKey[] colorKeys = null;
		GradientAlphaKey[] alphaKeys = null;
		GradientMode mode = GradientMode.Blend;
		for (int i = 0; i < num; i++)
		{
			switch (i)
			{
			case 0:
				colorKeys = resolver.GetFormatterWithVerify<GradientColorKey[]>().Deserialize(ref reader, options);
				break;
			case 1:
				alphaKeys = resolver.GetFormatterWithVerify<GradientAlphaKey[]>().Deserialize(ref reader, options);
				break;
			case 2:
				mode = resolver.GetFormatterWithVerify<GradientMode>().Deserialize(ref reader, options);
				break;
			default:
				reader.Skip();
				break;
			}
		}
		return new Gradient
		{
			colorKeys = colorKeys,
			alphaKeys = alphaKeys,
			mode = mode
		};
	}
}
