namespace MessagePack.Formatters;

public sealed class FourDimensionalArrayFormatter<T> : IMessagePackFormatter<T[,,,]>, IMessagePackFormatter
{
	private const int ArrayLength = 5;

	public void Serialize(ref MessagePackWriter writer, T[,,,] value, MessagePackSerializerOptions options)
	{
		if (value == null)
		{
			writer.WriteNil();
			return;
		}
		int length = value.GetLength(0);
		int length2 = value.GetLength(1);
		int length3 = value.GetLength(2);
		int length4 = value.GetLength(3);
		IMessagePackFormatter<T> formatterWithVerify = options.Resolver.GetFormatterWithVerify<T>();
		writer.WriteArrayHeader(5);
		writer.Write(length);
		writer.Write(length2);
		writer.Write(length3);
		writer.Write(length4);
		writer.WriteArrayHeader(value.Length);
		foreach (T value2 in value)
		{
			writer.CancellationToken.ThrowIfCancellationRequested();
			formatterWithVerify.Serialize(ref writer, value2, options);
		}
	}

	public T[,,,] Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		IMessagePackFormatter<T> formatterWithVerify = options.Resolver.GetFormatterWithVerify<T>();
		if (reader.ReadArrayHeader() != 5)
		{
			throw new MessagePackSerializationException("Invalid T[,,,] format");
		}
		int num = reader.ReadInt32();
		int num2 = reader.ReadInt32();
		int num3 = reader.ReadInt32();
		int num4 = reader.ReadInt32();
		int num5 = reader.ReadArrayHeader();
		T[,,,] array = new T[num, num2, num3, num4];
		int num6 = 0;
		int num7 = 0;
		int num8 = 0;
		int num9 = -1;
		options.Security.DepthStep(ref reader);
		try
		{
			for (int i = 0; i < num5; i++)
			{
				reader.CancellationToken.ThrowIfCancellationRequested();
				if (num9 < num4 - 1)
				{
					num9++;
				}
				else if (num8 < num3 - 1)
				{
					num9 = 0;
					num8++;
				}
				else if (num7 < num2 - 1)
				{
					num9 = 0;
					num8 = 0;
					num7++;
				}
				else
				{
					num9 = 0;
					num8 = 0;
					num7 = 0;
					num6++;
				}
				array[num6, num7, num8, num9] = formatterWithVerify.Deserialize(ref reader, options);
			}
			return array;
		}
		finally
		{
			reader.Depth--;
		}
	}
}
