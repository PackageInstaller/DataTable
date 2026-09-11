using System;
using MessagePack.Formatters;
using UnityEngine;

namespace MessagePack.Unity;

public sealed class Vector3IntFormatter : IMessagePackFormatter<Vector3Int>, IMessagePackFormatter
{
	public void Serialize(ref MessagePackWriter writer, Vector3Int value, MessagePackSerializerOptions options)
	{
		writer.WriteArrayHeader(3);
		writer.WriteInt32(value.x);
		writer.WriteInt32(value.y);
		writer.WriteInt32(value.z);
	}

	public Vector3Int Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.IsNil)
		{
			throw new InvalidOperationException("typecode is null, struct not supported");
		}
		int num = reader.ReadArrayHeader();
		int x = 0;
		int y = 0;
		int z = 0;
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
			case 2:
				z = reader.ReadInt32();
				break;
			default:
				reader.Skip();
				break;
			}
		}
		Vector3Int result = new Vector3Int(x, y, z);
		result.x = x;
		result.y = y;
		result.z = z;
		return result;
	}
}
