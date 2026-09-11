namespace MessagePack.Formatters;

public sealed class ThreeDimensionalArrayFormatter<T> : IMessagePackFormatter<T[,,]>, IMessagePackFormatter
{
	private const int ArrayLength = 4;

	public void Serialize(ref MessagePackWriter writer, T[,,] value, MessagePackSerializerOptions options)
	{
		if (value == null)
		{
			writer.WriteNil();
			return;
		}
		int length = value.GetLength(0);
		int length2 = value.GetLength(1);
		int length3 = value.GetLength(2);
		IMessagePackFormatter<T> formatterWithVerify = options.Resolver.GetFormatterWithVerify<T>();
		writer.WriteArrayHeader(4);
		writer.Write(length);
		writer.Write(length2);
		writer.Write(length3);
		writer.WriteArrayHeader(value.Length);
		foreach (T value2 in value)
		{
			writer.CancellationToken.ThrowIfCancellationRequested();
			formatterWithVerify.Serialize(ref writer, value2, options);
		}
	}

	public T[,,] Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		IMessagePackFormatter<T> formatterWithVerify = options.Resolver.GetFormatterWithVerify<T>();
		if (reader.ReadArrayHeader() != 4)
		{
			throw new MessagePackSerializationException("Invalid T[,,] format");
		}
		int num = reader.ReadInt32();
		int num2 = reader.ReadInt32();
		int num3 = reader.ReadInt32();
		int num4 = reader.ReadArrayHeader();
		T[,,] array = new T[num, num2, num3];
		int num5 = 0;
		int num6 = 0;
		int num7 = -1;
		options.Security.DepthStep(ref reader);
		try
		{
			for (int i = 0; i < num4; i++)
			{
				reader.CancellationToken.ThrowIfCancellationRequested();
				if (num7 < num3 - 1)
				{
					num7++;
				}
				else if (num6 < num2 - 1)
				{
					num7 = 0;
					num6++;
				}
				else
				{
					num7 = 0;
					num6 = 0;
					num5++;
				}
				array[num5, num6, num7] = formatterWithVerify.Deserialize(ref reader, options);
			}
			return array;
		}
		finally
		{
			reader.Depth--;
		}
	}
}
