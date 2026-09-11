using System;
using MessagePack.Formatters;
using UnityEngine;

namespace MessagePack.Unity;

public sealed class RectFormatter : IMessagePackFormatter<Rect>, IMessagePackFormatter
{
	public void Serialize(ref MessagePackWriter writer, Rect value, MessagePackSerializerOptions options)
	{
		writer.WriteArrayHeader(4);
		writer.Write(value.x);
		writer.Write(value.y);
		writer.Write(value.width);
		writer.Write(value.height);
	}

	public Rect Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.IsNil)
		{
			throw new InvalidOperationException("typecode is null, struct not supported");
		}
		int num = reader.ReadArrayHeader();
		float x = 0f;
		float y = 0f;
		float width = 0f;
		float height = 0f;
		for (int i = 0; i < num; i++)
		{
			switch (i)
			{
			case 0:
				x = reader.ReadSingle();
				break;
			case 1:
				y = reader.ReadSingle();
				break;
			case 2:
				width = reader.ReadSingle();
				break;
			case 3:
				height = reader.ReadSingle();
				break;
			default:
				reader.Skip();
				break;
			}
		}
		return new Rect(x, y, width, height);
	}
}
