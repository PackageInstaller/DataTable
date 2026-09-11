using System;
using MessagePack.Formatters;
using UnityEngine;

namespace MessagePack.Unity;

public sealed class ColorFormatter : IMessagePackFormatter<Color>, IMessagePackFormatter
{
	public void Serialize(ref MessagePackWriter writer, Color value, MessagePackSerializerOptions options)
	{
		writer.WriteArrayHeader(4);
		writer.Write(value.r);
		writer.Write(value.g);
		writer.Write(value.b);
		writer.Write(value.a);
	}

	public Color Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.IsNil)
		{
			throw new InvalidOperationException("typecode is null, struct not supported");
		}
		int num = reader.ReadArrayHeader();
		float r = 0f;
		float g = 0f;
		float b = 0f;
		float a = 0f;
		for (int i = 0; i < num; i++)
		{
			switch (i)
			{
			case 0:
				r = reader.ReadSingle();
				break;
			case 1:
				g = reader.ReadSingle();
				break;
			case 2:
				b = reader.ReadSingle();
				break;
			case 3:
				a = reader.ReadSingle();
				break;
			default:
				reader.Skip();
				break;
			}
		}
		return new Color(r, g, b, a);
	}
}
