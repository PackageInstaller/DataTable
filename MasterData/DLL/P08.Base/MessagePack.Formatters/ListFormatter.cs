using System.Collections.Generic;

namespace MessagePack.Formatters;

public sealed class ListFormatter<T> : IMessagePackFormatter<List<T>>, IMessagePackFormatter
{
	public void Serialize(ref MessagePackWriter writer, List<T> value, MessagePackSerializerOptions options)
	{
		if (value == null)
		{
			writer.WriteNil();
			return;
		}
		IMessagePackFormatter<T> formatterWithVerify = options.Resolver.GetFormatterWithVerify<T>();
		int count = value.Count;
		writer.WriteArrayHeader(count);
		for (int i = 0; i < count; i++)
		{
			writer.CancellationToken.ThrowIfCancellationRequested();
			formatterWithVerify.Serialize(ref writer, value[i], options);
		}
	}

	public List<T> Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		IMessagePackFormatter<T> formatterWithVerify = options.Resolver.GetFormatterWithVerify<T>();
		int num = reader.ReadArrayHeader();
		List<T> list = new List<T>(num);
		options.Security.DepthStep(ref reader);
		try
		{
			for (int i = 0; i < num; i++)
			{
				reader.CancellationToken.ThrowIfCancellationRequested();
				list.Add(formatterWithVerify.Deserialize(ref reader, options));
			}
			return list;
		}
		finally
		{
			reader.Depth--;
		}
	}
}
