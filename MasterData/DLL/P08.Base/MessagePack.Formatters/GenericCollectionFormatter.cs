using System.Collections.Generic;

namespace MessagePack.Formatters;

public sealed class GenericCollectionFormatter<TElement, TCollection> : CollectionFormatterBase<TElement, TCollection> where TCollection : ICollection<TElement>, new()
{
	protected override TCollection Create(int count, MessagePackSerializerOptions options)
	{
		return new TCollection();
	}

	protected override void Add(TCollection collection, int index, TElement value, MessagePackSerializerOptions options)
	{
		collection.Add(value);
	}
}
