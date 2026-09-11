using System;
using MessagePack.Formatters;
using UnityEngine;

namespace MessagePack.Unity;

public sealed class BoundsIntFormatter : IMessagePackFormatter<BoundsInt>, IMessagePackFormatter
{
	public void Serialize(ref MessagePackWriter writer, BoundsInt value, MessagePackSerializerOptions options)
	{
		writer.WriteArrayHeader(2);
		options.Resolver.GetFormatterWithVerify<Vector3Int>().Serialize(ref writer, value.position, options);
		options.Resolver.GetFormatterWithVerify<Vector3Int>().Serialize(ref writer, value.size, options);
	}

	public BoundsInt Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.IsNil)
		{
			throw new InvalidOperationException("typecode is null, struct not supported");
		}
		int num = reader.ReadArrayHeader();
		Vector3Int position = default(Vector3Int);
		Vector3Int size = default(Vector3Int);
		for (int i = 0; i < num; i++)
		{
			switch (i)
			{
			case 0:
				position = options.Resolver.GetFormatterWithVerify<Vector3Int>().Deserialize(ref reader, options);
				break;
			case 1:
				size = options.Resolver.GetFormatterWithVerify<Vector3Int>().Deserialize(ref reader, options);
				break;
			default:
				reader.Skip();
				break;
			}
		}
		BoundsInt result = new BoundsInt(position, size);
		result.position = position;
		result.size = size;
		return result;
	}
}
