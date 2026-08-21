using System.Collections;

namespace MessagePack.Formatters;

public sealed class BitArrayFormatter : IMessagePackFormatter<BitArray>, IMessagePackFormatter
{
	public static readonly IMessagePackFormatter<BitArray> Instance = new BitArrayFormatter();

	private BitArrayFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, BitArray value, MessagePackSerializerOptions options)
	{
		if (value == null)
		{
			writer.WriteNil();
			return;
		}
		int length = value.Length;
		writer.WriteArrayHeader(length);
		for (int i = 0; i < length; i++)
		{
			writer.Write(value.Get(i));
		}
	}

	public BitArray Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		int num = reader.ReadArrayHeader();
		BitArray bitArray = new BitArray(num);
		for (int i = 0; i < num; i++)
		{
			bitArray[i] = reader.ReadBoolean();
		}
		return bitArray;
	}
}
