using System.Collections.Generic;

namespace MessagePack.Formatters;

public sealed class KeyValuePairFormatter<TKey, TValue> : IMessagePackFormatter<KeyValuePair<TKey, TValue>>, IMessagePackFormatter
{
	public void Serialize(ref MessagePackWriter writer, KeyValuePair<TKey, TValue> value, MessagePackSerializerOptions options)
	{
		writer.WriteArrayHeader(2);
		IFormatterResolver resolver = options.Resolver;
		resolver.GetFormatterWithVerify<TKey>().Serialize(ref writer, value.Key, options);
		resolver.GetFormatterWithVerify<TValue>().Serialize(ref writer, value.Value, options);
	}

	public KeyValuePair<TKey, TValue> Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.ReadArrayHeader() != 2)
		{
			throw new MessagePackSerializationException("Invalid KeyValuePair format.");
		}
		IFormatterResolver resolver = options.Resolver;
		options.Security.DepthStep(ref reader);
		try
		{
			TKey key = resolver.GetFormatterWithVerify<TKey>().Deserialize(ref reader, options);
			TValue value = resolver.GetFormatterWithVerify<TValue>().Deserialize(ref reader, options);
			return new KeyValuePair<TKey, TValue>(key, value);
		}
		finally
		{
			reader.Depth--;
		}
	}
}
