using System;
using MessagePack.Formatters;
using UnityEngine;

namespace MessagePack.Unity;

public sealed class LayerMaskFormatter : IMessagePackFormatter<LayerMask>, IMessagePackFormatter
{
	public void Serialize(ref MessagePackWriter writer, LayerMask value, MessagePackSerializerOptions options)
	{
		writer.WriteArrayHeader(1);
		writer.Write(value.value);
	}

	public LayerMask Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.IsNil)
		{
			throw new InvalidOperationException("typecode is null, struct not supported");
		}
		int num = reader.ReadArrayHeader();
		int value = 0;
		for (int i = 0; i < num; i++)
		{
			if (i == 0)
			{
				value = reader.ReadInt32();
			}
			else
			{
				reader.Skip();
			}
		}
		return new LayerMask
		{
			value = value
		};
	}
}
