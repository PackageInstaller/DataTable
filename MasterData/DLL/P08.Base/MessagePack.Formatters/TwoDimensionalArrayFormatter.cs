namespace MessagePack.Formatters;

public sealed class TwoDimensionalArrayFormatter<T> : IMessagePackFormatter<T[,]>, IMessagePackFormatter
{
	private const int ArrayLength = 3;

	public void Serialize(ref MessagePackWriter writer, T[,] value, MessagePackSerializerOptions options)
	{
		if (value == null)
		{
			writer.WriteNil();
			return;
		}
		int length = value.GetLength(0);
		int length2 = value.GetLength(1);
		IMessagePackFormatter<T> formatterWithVerify = options.Resolver.GetFormatterWithVerify<T>();
		writer.WriteArrayHeader(3);
		writer.Write(length);
		writer.Write(length2);
		writer.WriteArrayHeader(value.Length);
		foreach (T value2 in value)
		{
			writer.CancellationToken.ThrowIfCancellationRequested();
			formatterWithVerify.Serialize(ref writer, value2, options);
		}
	}

	public T[,] Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		IMessagePackFormatter<T> formatterWithVerify = options.Resolver.GetFormatterWithVerify<T>();
		if (reader.ReadArrayHeader() != 3)
		{
			throw new MessagePackSerializationException("Invalid T[,] format");
		}
		int num = reader.ReadInt32();
		int num2 = reader.ReadInt32();
		int num3 = reader.ReadArrayHeader();
		T[,] array = new T[num, num2];
		int num4 = 0;
		int num5 = -1;
		options.Security.DepthStep(ref reader);
		try
		{
			for (int i = 0; i < num3; i++)
			{
				reader.CancellationToken.ThrowIfCancellationRequested();
				if (num5 < num2 - 1)
				{
					num5++;
				}
				else
				{
					num5 = 0;
					num4++;
				}
				array[num4, num5] = formatterWithVerify.Deserialize(ref reader, options);
			}
			return array;
		}
		finally
		{
			reader.Depth--;
		}
	}
}
