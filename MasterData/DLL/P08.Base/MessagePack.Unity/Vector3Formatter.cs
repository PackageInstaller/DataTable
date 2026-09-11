using System;
using MessagePack.Formatters;
using UnityEngine;

namespace MessagePack.Unity;

public sealed class Vector3Formatter : IMessagePackFormatter<Vector3>, IMessagePackFormatter
{
	public void Serialize(ref MessagePackWriter writer, Vector3 value, MessagePackSerializerOptions options)
	{
		writer.WriteArrayHeader(3);
		writer.Write(value.x);
		writer.Write(value.y);
		writer.Write(value.z);
	}

	public Vector3 Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.IsNil)
		{
			throw new InvalidOperationException("typecode is null, struct not supported");
		}
		int num = reader.ReadArrayHeader();
		float x = 0f;
		float y = 0f;
		float z = 0f;
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
			default:
				reader.Skip();
				break;
			}
		}
		return new Vector3(x, y, z);
	}
}
