using System.Collections;

namespace MessagePack.Formatters;

public sealed class NonGenericListFormatter<T> : IMessagePackFormatter<T>, IMessagePackFormatter where T : class, IList, new()
{
	public void Serialize(ref MessagePackWriter writer, T value, MessagePackSerializerOptions options)
	{
		if (value == null)
		{
			writer.WriteNil();
			return;
		}
		IMessagePackFormatter<object> formatterWithVerify = options.Resolver.GetFormatterWithVerify<object>();
		writer.WriteArrayHeader(value.Count);
		foreach (object item in value)
		{
			writer.CancellationToken.ThrowIfCancellationRequested();
			formatterWithVerify.Serialize(ref writer, item, options);
		}
	}

	public T Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		IMessagePackFormatter<object> formatterWithVerify = options.Resolver.GetFormatterWithVerify<object>();
		int num = reader.ReadArrayHeader();
		T val = new T();
		options.Security.DepthStep(ref reader);
		try
		{
			for (int i = 0; i < num; i++)
			{
				reader.CancellationToken.ThrowIfCancellationRequested();
				val.Add(formatterWithVerify.Deserialize(ref reader, options));
			}
			return val;
		}
		finally
		{
			reader.Depth--;
		}
	}
}
