using System;
using MessagePack.Formatters;
using UnityEngine;

namespace MessagePack.Unity;

public sealed class RectIntFormatter : IMessagePackFormatter<RectInt>, IMessagePackFormatter
{
	public void Serialize(ref MessagePackWriter writer, RectInt value, MessagePackSerializerOptions options)
	{
		writer.WriteArrayHeader(4);
		writer.WriteInt32(value.x);
		writer.WriteInt32(value.y);
		writer.WriteInt32(value.width);
		writer.WriteInt32(value.height);
	}

	public RectInt Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.IsNil)
		{
			throw new InvalidOperationException("typecode is null, struct not supported");
		}
		int num = reader.ReadArrayHeader();
		int num2 = 0;
		int num3 = 0;
		int width = 0;
		int height = 0;
		for (int i = 0; i < num; i++)
		{
			switch (i)
			{
			case 0:
				num2 = reader.ReadInt32();
				break;
			case 1:
				num3 = reader.ReadInt32();
				break;
			case 2:
				width = reader.ReadInt32();
				break;
			case 3:
				height = reader.ReadInt32();
				break;
			default:
				reader.Skip();
				break;
			}
		}
		RectInt result = new RectInt(num2, num3, width, height);
		result.x = num2;
		result.y = num3;
		result.width = width;
		result.height = height;
		return result;
	}
}
