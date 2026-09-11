using MessagePack.Formatters;
using UnityEngine;

namespace MessagePack.Unity;

public sealed class RectOffsetFormatter : IMessagePackFormatter<RectOffset>, IMessagePackFormatter
{
	public void Serialize(ref MessagePackWriter writer, RectOffset value, MessagePackSerializerOptions options)
	{
		if (value == null)
		{
			writer.WriteNil();
			return;
		}
		writer.WriteArrayHeader(4);
		writer.Write(value.left);
		writer.Write(value.right);
		writer.Write(value.top);
		writer.Write(value.bottom);
	}

	public RectOffset Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.IsNil)
		{
			return null;
		}
		int num = reader.ReadArrayHeader();
		int left = 0;
		int right = 0;
		int top = 0;
		int bottom = 0;
		for (int i = 0; i < num; i++)
		{
			switch (i)
			{
			case 0:
				left = reader.ReadInt32();
				break;
			case 1:
				right = reader.ReadInt32();
				break;
			case 2:
				top = reader.ReadInt32();
				break;
			case 3:
				bottom = reader.ReadInt32();
				break;
			default:
				reader.Skip();
				break;
			}
		}
		return new RectOffset
		{
			left = left,
			right = right,
			top = top,
			bottom = bottom
		};
	}
}
