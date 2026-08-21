using System.Numerics;

namespace MessagePack.Formatters;

public sealed class ComplexFormatter : IMessagePackFormatter<Complex>, IMessagePackFormatter
{
	public static readonly IMessagePackFormatter<Complex> Instance = new ComplexFormatter();

	private ComplexFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, Complex value, MessagePackSerializerOptions options)
	{
		writer.WriteArrayHeader(2);
		writer.Write(value.Real);
		writer.Write(value.Imaginary);
	}

	public Complex Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.ReadArrayHeader() != 2)
		{
			throw new MessagePackSerializationException("Invalid Complex format.");
		}
		double real = reader.ReadDouble();
		double imaginary = reader.ReadDouble();
		return new Complex(real, imaginary);
	}
}
