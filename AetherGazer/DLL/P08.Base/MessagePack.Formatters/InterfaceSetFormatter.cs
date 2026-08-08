using System.Collections.Generic;

namespace MessagePack.Formatters;

public sealed class InterfaceSetFormatter<T> : CollectionFormatterBase<T, HashSet<T>, ISet<T>>
{
	protected override void Add(HashSet<T> collection, int index, T value, MessagePackSerializerOptions options)
	{
		collection.Add(value);
	}

	protected override ISet<T> Complete(HashSet<T> intermediateCollection)
	{
		return intermediateCollection;
	}

	protected override HashSet<T> Create(int count, MessagePackSerializerOptions options)
	{
		return new HashSet<T>(options.Security.GetEqualityComparer<T>());
	}
}
