using System;
using MessagePack.Formatters;
using UnityEngine;

namespace MessagePack.Unity;

public sealed class BoundsFormatter : IMessagePackFormatter<Bounds>, IMessagePackFormatter
{
	public void Serialize(ref MessagePackWriter writer, Bounds value, MessagePackSerializerOptions options)
	{
		IFormatterResolver resolver = options.Resolver;
		writer.WriteArrayHeader(2);
		resolver.GetFormatterWithVerify<Vector3>().Serialize(ref writer, value.center, options);
		resolver.GetFormatterWithVerify<Vector3>().Serialize(ref writer, value.size, options);
	}

	public Bounds Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.IsNil)
		{
			throw new InvalidOperationException("typecode is null, struct not supported");
		}
		IFormatterResolver resolver = options.Resolver;
		int num = reader.ReadArrayHeader();
		Vector3 center = default(Vector3);
		Vector3 size = default(Vector3);
		for (int i = 0; i < num; i++)
		{
			switch (i)
			{
			case 0:
				center = resolver.GetFormatterWithVerify<Vector3>().Deserialize(ref reader, options);
				break;
			case 1:
				size = resolver.GetFormatterWithVerify<Vector3>().Deserialize(ref reader, options);
				break;
			default:
				reader.Skip();
				break;
			}
		}
		return new Bounds(center, size);
	}
}
