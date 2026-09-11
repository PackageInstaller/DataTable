using System.Buffers;
using System.Numerics;

namespace MessagePack.Formatters;

public sealed class BigIntegerFormatter : IMessagePackFormatter<BigInteger>, IMessagePackFormatter
{
	public static readonly IMessagePackFormatter<BigInteger> Instance = new BigIntegerFormatter();

	private BigIntegerFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, BigInteger value, MessagePackSerializerOptions options)
	{
		writer.Write(value.ToByteArray());
	}

	public BigInteger Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		return new BigInteger(reader.ReadBytes().Value.ToArray<byte>());
	}
}
