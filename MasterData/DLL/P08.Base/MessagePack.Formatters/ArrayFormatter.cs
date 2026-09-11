using System;

namespace MessagePack.Formatters;

public sealed class ArrayFormatter<T> : IMessagePackFormatter<T[]>, IMessagePackFormatter
{
	public void Serialize(ref MessagePackWriter writer, T[] value, MessagePackSerializerOptions options)
	{
		if (value == null)
		{
			writer.WriteNil();
			return;
		}
		IMessagePackFormatter<T> formatterWithVerify = options.Resolver.GetFormatterWithVerify<T>();
		writer.WriteArrayHeader(value.Length);
		for (int i = 0; i < value.Length; i++)
		{
			writer.CancellationToken.ThrowIfCancellationRequested();
			formatterWithVerify.Serialize(ref writer, value[i], options);
		}
	}

	public T[] Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		int num = reader.ReadArrayHeader();
		if (num == 0)
		{
			return Array.Empty<T>();
		}
		IMessagePackFormatter<T> formatterWithVerify = options.Resolver.GetFormatterWithVerify<T>();
		T[] array = new T[num];
		options.Security.DepthStep(ref reader);
		try
		{
			for (int i = 0; i < array.Length; i++)
			{
				reader.CancellationToken.ThrowIfCancellationRequested();
				array[i] = formatterWithVerify.Deserialize(ref reader, options);
			}
			return array;
		}
		finally
		{
			reader.Depth--;
		}
	}
}
