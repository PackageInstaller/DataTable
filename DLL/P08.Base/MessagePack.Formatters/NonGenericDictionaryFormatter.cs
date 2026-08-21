using System.Collections;

namespace MessagePack.Formatters;

public sealed class NonGenericDictionaryFormatter<T> : IMessagePackFormatter<T>, IMessagePackFormatter where T : class, IDictionary, new()
{
	public void Serialize(ref MessagePackWriter writer, T value, MessagePackSerializerOptions options)
	{
		if (value == null)
		{
			writer.WriteNil();
			return;
		}
		IMessagePackFormatter<object> formatterWithVerify = options.Resolver.GetFormatterWithVerify<object>();
		writer.WriteMapHeader(value.Count);
		foreach (DictionaryEntry item in value)
		{
			writer.CancellationToken.ThrowIfCancellationRequested();
			formatterWithVerify.Serialize(ref writer, item.Key, options);
			formatterWithVerify.Serialize(ref writer, item.Value, options);
		}
	}

	public T Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		IMessagePackFormatter<object> formatterWithVerify = options.Resolver.GetFormatterWithVerify<object>();
		int num = reader.ReadMapHeader();
		T val = CollectionHelpers<T, IEqualityComparer>.CreateHashCollection(num, options.Security.GetEqualityComparer());
		options.Security.DepthStep(ref reader);
		try
		{
			for (int i = 0; i < num; i++)
			{
				reader.CancellationToken.ThrowIfCancellationRequested();
				object key = formatterWithVerify.Deserialize(ref reader, options);
				object value = formatterWithVerify.Deserialize(ref reader, options);
				val.Add(key, value);
			}
			return val;
		}
		finally
		{
			reader.Depth--;
		}
	}
}
