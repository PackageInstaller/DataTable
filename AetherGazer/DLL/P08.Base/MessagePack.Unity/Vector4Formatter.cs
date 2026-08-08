using System;
using MessagePack.Formatters;
using UnityEngine;

namespace MessagePack.Unity;

public sealed class Vector4Formatter : IMessagePackFormatter<Vector4>, IMessagePackFormatter
{
	public void Serialize(ref MessagePackWriter writer, Vector4 value, MessagePackSerializerOptions options)
	{
		writer.WriteArrayHeader(4);
		writer.Write(value.x);
		writer.Write(value.y);
		writer.Write(value.z);
		writer.Write(value.w);
	}

	public Vector4 Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.IsNil)
		{
			throw new InvalidOperationException("typecode is null, struct not supported");
		}
		int num = reader.ReadArrayHeader();
		float x = 0f;
		float y = 0f;
		float z = 0f;
		float w = 0f;
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
				z = reader.ReadSingle();
				break;
			case 3:
				w = reader.ReadSingle();
				break;
			default:
				reader.Skip();
				break;
			}
		}
		return new Vector4(x, y, z, w);
	}
}
