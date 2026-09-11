using System.Collections.Generic;
using Nerdbank.Streams;

namespace MessagePack.Formatters;

public abstract class CollectionFormatterBase<TElement, TIntermediate, TEnumerator, TCollection> : IMessagePackFormatter<TCollection>, IMessagePackFormatter where TEnumerator : IEnumerator<TElement> where TCollection : IEnumerable<TElement>
{
	public void Serialize(ref MessagePackWriter writer, TCollection value, MessagePackSerializerOptions options)
	{
		if (value == null)
		{
			writer.WriteNil();
			return;
		}
		IMessagePackFormatter<TElement> formatterWithVerify = options.Resolver.GetFormatterWithVerify<TElement>();
		if (value is TElement[] array)
		{
			writer.WriteArrayHeader(array.Length);
			TElement[] array2 = array;
			foreach (TElement value2 in array2)
			{
				writer.CancellationToken.ThrowIfCancellationRequested();
				formatterWithVerify.Serialize(ref writer, value2, options);
			}
			return;
		}
		int? count = GetCount(value);
		if (count.HasValue)
		{
			writer.WriteArrayHeader(count.Value);
			using TEnumerator val = GetSourceEnumerator(value);
			while (val.MoveNext())
			{
				writer.CancellationToken.ThrowIfCancellationRequested();
				formatterWithVerify.Serialize(ref writer, val.Current, options);
			}
			return;
		}
		using SequencePool.Rental rental = options.SequencePool.Rent();
		Sequence<byte> value3 = rental.Value;
		MessagePackWriter writer2 = writer.Clone(value3);
		int num = 0;
		using (TEnumerator val2 = GetSourceEnumerator(value))
		{
			while (val2.MoveNext())
			{
				writer.CancellationToken.ThrowIfCancellationRequested();
				num++;
				formatterWithVerify.Serialize(ref writer2, val2.Current, options);
			}
		}
		writer2.Flush();
		writer.WriteArrayHeader(num);
		writer.WriteRaw(value3.AsReadOnlySequence);
	}

	public TCollection Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return default(TCollection);
		}
		IMessagePackFormatter<TElement> formatterWithVerify = options.Resolver.GetFormatterWithVerify<TElement>();
		int num = reader.ReadArrayHeader();
		TIntermediate val = Create(num, options);
		options.Security.DepthStep(ref reader);
		try
		{
			for (int i = 0; i < num; i++)
			{
				reader.CancellationToken.ThrowIfCancellationRequested();
				Add(val, i, formatterWithVerify.Deserialize(ref reader, options), options);
			}
		}
		finally
		{
			reader.Depth--;
		}
		return Complete(val);
	}

	protected virtual int? GetCount(TCollection sequence)
	{
		if (sequence is ICollection<TElement> collection)
		{
			return collection.Count;
		}
		if (sequence is IReadOnlyCollection<TElement> readOnlyCollection)
		{
			return readOnlyCollection.Count;
		}
		return null;
	}

	protected abstract TEnumerator GetSourceEnumerator(TCollection source);

	protected abstract TIntermediate Create(int count, MessagePackSerializerOptions options);

	protected abstract void Add(TIntermediate collection, int index, TElement value, MessagePackSerializerOptions options);

	protected abstract TCollection Complete(TIntermediate intermediateCollection);
}
public abstract class CollectionFormatterBase<TElement, TIntermediate, TCollection> : CollectionFormatterBase<TElement, TIntermediate, IEnumerator<TElement>, TCollection> where TCollection : IEnumerable<TElement>
{
	protected override IEnumerator<TElement> GetSourceEnumerator(TCollection source)
	{
		return source.GetEnumerator();
	}
}
public abstract class CollectionFormatterBase<TElement, TCollection> : CollectionFormatterBase<TElement, TCollection, TCollection> where TCollection : IEnumerable<TElement>
{
	protected sealed override TCollection Complete(TCollection intermediateCollection)
	{
		return intermediateCollection;
	}
}
