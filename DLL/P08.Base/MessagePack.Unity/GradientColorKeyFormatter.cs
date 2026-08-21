using System;
using MessagePack.Formatters;
using UnityEngine;

namespace MessagePack.Unity;

public sealed class GradientColorKeyFormatter : IMessagePackFormatter<GradientColorKey>, IMessagePackFormatter
{
	public void Serialize(ref MessagePackWriter writer, GradientColorKey value, MessagePackSerializerOptions options)
	{
		writer.WriteArrayHeader(2);
		options.Resolver.GetFormatterWithVerify<Color>().Serialize(ref writer, value.color, options);
		writer.Write(value.time);
	}

	public GradientColorKey Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.IsNil)
		{
			throw new InvalidOperationException("typecode is null, struct not supported");
		}
		int num = reader.ReadArrayHeader();
		Color color = default(Color);
		float time = 0f;
		IFormatterResolver resolver = options.Resolver;
		for (int i = 0; i < num; i++)
		{
			switch (i)
			{
			case 0:
				color = resolver.GetFormatterWithVerify<Color>().Deserialize(ref reader, options);
				break;
			case 1:
				time = reader.ReadSingle();
				break;
			default:
				reader.Skip();
				break;
			}
		}
		GradientColorKey result = new GradientColorKey(color, time);
		result.color = color;
		result.time = time;
		return result;
	}
}
