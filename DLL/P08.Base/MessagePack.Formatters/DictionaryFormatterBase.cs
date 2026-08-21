using System.Collections.Generic;

namespace MessagePack.Formatters;

public abstract class DictionaryFormatterBase<TKey, TValue, TIntermediate, TEnumerator, TDictionary> : IMessagePackFormatter<TDictionary>, IMessagePackFormatter where TEnumerator : IEnumerator<KeyValuePair<TKey, TValue>> where TDictionary : IEnumerable<KeyValuePair<TKey, TValue>>
{
	public void Serialize(ref MessagePackWriter writer, TDictionary value, MessagePackSerializerOptions options)
	{
		if (value == null)
		{
			writer.WriteNil();
			return;
		}
		IFormatterResolver resolver = options.Resolver;
		IMessagePackFormatter<TKey> formatterWithVerify = resolver.GetFormatterWithVerify<TKey>();
		IMessagePackFormatter<TValue> formatterWithVerify2 = resolver.GetFormatterWithVerify<TValue>();
		int count;
		if (value is ICollection<KeyValuePair<TKey, TValue>> collection)
		{
			count = collection.Count;
		}
		else
		{
			if (!(value is IReadOnlyCollection<KeyValuePair<TKey, TValue>> readOnlyCollection))
			{
				throw new MessagePackSerializationException("DictionaryFormatterBase's TDictionary supports only ICollection<KVP> or IReadOnlyCollection<KVP>");
			}
			count = readOnlyCollection.Count;
		}
		writer.WriteMapHeader(count);
		TEnumerator sourceEnumerator = GetSourceEnumerator(value);
		try
		{
			while (sourceEnumerator.MoveNext())
			{
				writer.CancellationToken.ThrowIfCancellationRequested();
				KeyValuePair<TKey, TValue> current = sourceEnumerator.Current;
				formatterWithVerify.Serialize(ref writer, current.Key, options);
				formatterWithVerify2.Serialize(ref writer, current.Value, options);
			}
		}
		finally
		{
			sourceEnumerator.Dispose();
		}
	}

	public TDictionary Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return default(TDictionary);
		}
		IFormatterResolver resolver = options.Resolver;
		IMessagePackFormatter<TKey> formatterWithVerify = resolver.GetFormatterWithVerify<TKey>();
		IMessagePackFormatter<TValue> formatterWithVerify2 = resolver.GetFormatterWithVerify<TValue>();
		int num = reader.ReadMapHeader();
		TIntermediate val = Create(num, options);
		options.Security.DepthStep(ref reader);
		try
		{
			for (int i = 0; i < num; i++)
			{
				reader.CancellationToken.ThrowIfCancellationRequested();
				TKey key = formatterWithVerify.Deserialize(ref reader, options);
				TValue value = formatterWithVerify2.Deserialize(ref reader, options);
				Add(val, i, key, value, options);
			}
		}
		finally
		{
			reader.Depth--;
		}
		return Complete(val);
	}

	protected abstract TEnumerator GetSourceEnumerator(TDictionary source);

	protected abstract TIntermediate Create(int count, MessagePackSerializerOptions options);

	protected abstract void Add(TIntermediate collection, int index, TKey key, TValue value, MessagePackSerializerOptions options);

	protected abstract TDictionary Complete(TIntermediate intermediateCollection);
}
public abstract class DictionaryFormatterBase<TKey, TValue, TIntermediate, TDictionary> : DictionaryFormatterBase<TKey, TValue, TIntermediate, IEnumerator<KeyValuePair<TKey, TValue>>, TDictionary> where TDictionary : IEnumerable<KeyValuePair<TKey, TValue>>
{
	protected override IEnumerator<KeyValuePair<TKey, TValue>> GetSourceEnumerator(TDictionary source)
	{
		return source.GetEnumerator();
	}
}
public abstract class DictionaryFormatterBase<TKey, TValue, TDictionary> : DictionaryFormatterBase<TKey, TValue, TDictionary, TDictionary> where TDictionary : IDictionary<TKey, TValue>
{
	protected override TDictionary Complete(TDictionary intermediateCollection)
	{
		return intermediateCollection;
	}
}
