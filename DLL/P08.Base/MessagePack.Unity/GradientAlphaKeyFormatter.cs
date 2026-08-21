using System;
using MessagePack.Formatters;
using UnityEngine;

namespace MessagePack.Unity;

public sealed class GradientAlphaKeyFormatter : IMessagePackFormatter<GradientAlphaKey>, IMessagePackFormatter
{
	public void Serialize(ref MessagePackWriter writer, GradientAlphaKey value, MessagePackSerializerOptions options)
	{
		writer.WriteArrayHeader(2);
		writer.Write(value.alpha);
		writer.Write(value.time);
	}

	public GradientAlphaKey Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.IsNil)
		{
			throw new InvalidOperationException("typecode is null, struct not supported");
		}
		int num = reader.ReadArrayHeader();
		float alpha = 0f;
		float time = 0f;
		for (int i = 0; i < num; i++)
		{
			switch (i)
			{
			case 0:
				alpha = reader.ReadSingle();
				break;
			case 1:
				time = reader.ReadSingle();
				break;
			default:
				reader.Skip();
				break;
			}
		}
		GradientAlphaKey result = new GradientAlphaKey(alpha, time);
		result.alpha = alpha;
		result.time = time;
		return result;
	}
}
