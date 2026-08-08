using System;
using MessagePack.Formatters;
using UnityEngine;

namespace MessagePack.Unity;

public sealed class KeyframeFormatter : IMessagePackFormatter<Keyframe>, IMessagePackFormatter
{
	public void Serialize(ref MessagePackWriter writer, Keyframe value, MessagePackSerializerOptions options)
	{
		writer.WriteArrayHeader(4);
		writer.Write(value.time);
		writer.Write(value.value);
		writer.Write(value.inTangent);
		writer.Write(value.outTangent);
	}

	public Keyframe Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.IsNil)
		{
			throw new InvalidOperationException("typecode is null, struct not supported");
		}
		int num = reader.ReadArrayHeader();
		float time = 0f;
		float value = 0f;
		float inTangent = 0f;
		float outTangent = 0f;
		for (int i = 0; i < num; i++)
		{
			switch (i)
			{
			case 0:
				time = reader.ReadSingle();
				break;
			case 1:
				value = reader.ReadSingle();
				break;
			case 2:
				inTangent = reader.ReadSingle();
				break;
			case 3:
				outTangent = reader.ReadSingle();
				break;
			default:
				reader.Skip();
				break;
			}
		}
		Keyframe result = new Keyframe(time, value, inTangent, outTangent);
		result.time = time;
		result.value = value;
		result.inTangent = inTangent;
		result.outTangent = outTangent;
		return result;
	}
}
