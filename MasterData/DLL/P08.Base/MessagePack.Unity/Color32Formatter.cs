using System;
using MessagePack.Formatters;
using UnityEngine;

namespace MessagePack.Unity;

public sealed class Color32Formatter : IMessagePackFormatter<Color32>, IMessagePackFormatter
{
	public void Serialize(ref MessagePackWriter writer, Color32 value, MessagePackSerializerOptions options)
	{
		writer.WriteArrayHeader(4);
		writer.Write(value.r);
		writer.Write(value.g);
		writer.Write(value.b);
		writer.Write(value.a);
	}

	public Color32 Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.IsNil)
		{
			throw new InvalidOperationException("typecode is null, struct not supported");
		}
		int num = reader.ReadArrayHeader();
		byte r = 0;
		byte g = 0;
		byte b = 0;
		byte a = 0;
		for (int i = 0; i < num; i++)
		{
			switch (i)
			{
			case 0:
				r = reader.ReadByte();
				break;
			case 1:
				g = reader.ReadByte();
				break;
			case 2:
				b = reader.ReadByte();
				break;
			case 3:
				a = reader.ReadByte();
				break;
			default:
				reader.Skip();
				break;
			}
		}
		Color32 result = new Color32(r, g, b, a);
		result.r = r;
		result.g = g;
		result.b = b;
		result.a = a;
		return result;
	}
}
