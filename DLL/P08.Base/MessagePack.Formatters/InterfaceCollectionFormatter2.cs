using System.Collections.Generic;

namespace MessagePack.Formatters;

public sealed class InterfaceCollectionFormatter2<T> : CollectionFormatterBase<T, List<T>, ICollection<T>>
{
	protected override void Add(List<T> collection, int index, T value, MessagePackSerializerOptions options)
	{
		collection.Add(value);
	}

	protected override List<T> Create(int count, MessagePackSerializerOptions options)
	{
		return new List<T>(count);
	}

	protected override ICollection<T> Complete(List<T> intermediateCollection)
	{
		return intermediateCollection;
	}
}
