using System;
using MessagePack.Formatters;
using UnityEngine;

namespace MessagePack.Unity;

public sealed class RangeIntFormatter : IMessagePackFormatter<RangeInt>, IMessagePackFormatter
{
	public void Serialize(ref MessagePackWriter writer, RangeInt value, MessagePackSerializerOptions options)
	{
		writer.WriteArrayHeader(2);
		writer.WriteInt32(value.start);
		writer.WriteInt32(value.length);
	}

	public RangeInt Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.IsNil)
		{
			throw new InvalidOperationException("typecode is null, struct not supported");
		}
		int num = reader.ReadArrayHeader();
		int start = 0;
		int length = 0;
		for (int i = 0; i < num; i++)
		{
			switch (i)
			{
			case 0:
				start = reader.ReadInt32();
				break;
			case 1:
				length = reader.ReadInt32();
				break;
			default:
				reader.Skip();
				break;
			}
		}
		RangeInt result = new RangeInt(start, length);
		result.start = start;
		result.length = length;
		return result;
	}
}
