using System;
using MessagePack.Formatters;
using UnityEngine;

namespace MessagePack.Unity;

public sealed class Vector2IntFormatter : IMessagePackFormatter<Vector2Int>, IMessagePackFormatter
{
	public void Serialize(ref MessagePackWriter writer, Vector2Int value, MessagePackSerializerOptions options)
	{
		writer.WriteArrayHeader(2);
		writer.WriteInt32(value.x);
		writer.WriteInt32(value.y);
	}

	public Vector2Int Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.IsNil)
		{
			throw new InvalidOperationException("typecode is null, struct not supported");
		}
		int num = reader.ReadArrayHeader();
		int x = 0;
		int y = 0;
		for (int i = 0; i < num; i++)
		{
			switch (i)
			{
			case 0:
				x = reader.ReadInt32();
				break;
			case 1:
				y = reader.ReadInt32();
				break;
			default:
				reader.Skip();
				break;
			}
		}
		Vector2Int result = new Vector2Int(x, y);
		result.x = x;
		result.y = y;
		return result;
	}
}
