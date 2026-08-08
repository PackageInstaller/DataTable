using System.Collections;
using System.Collections.Generic;

namespace MessagePack.Formatters;

public sealed class NonGenericInterfaceDictionaryFormatter : IMessagePackFormatter<IDictionary>, IMessagePackFormatter
{
	public static readonly IMessagePackFormatter<IDictionary> Instance = new NonGenericInterfaceDictionaryFormatter();

	private NonGenericInterfaceDictionaryFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, IDictionary value, MessagePackSerializerOptions options)
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

	public IDictionary Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		IMessagePackFormatter<object> formatterWithVerify = options.Resolver.GetFormatterWithVerify<object>();
		int num = reader.ReadMapHeader();
		Dictionary<object, object> dictionary = new Dictionary<object, object>(num, options.Security.GetEqualityComparer<object>());
		options.Security.DepthStep(ref reader);
		try
		{
			for (int i = 0; i < num; i++)
			{
				reader.CancellationToken.ThrowIfCancellationRequested();
				object key = formatterWithVerify.Deserialize(ref reader, options);
				object value = formatterWithVerify.Deserialize(ref reader, options);
				dictionary.Add(key, value);
			}
			return dictionary;
		}
		finally
		{
			reader.Depth--;
		}
	}
}
