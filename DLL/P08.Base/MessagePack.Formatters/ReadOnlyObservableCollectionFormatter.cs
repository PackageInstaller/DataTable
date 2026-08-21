using System.Collections.ObjectModel;

namespace MessagePack.Formatters;

public sealed class ReadOnlyObservableCollectionFormatter<T> : CollectionFormatterBase<T, ObservableCollection<T>, ReadOnlyObservableCollection<T>>
{
	protected override void Add(ObservableCollection<T> collection, int index, T value, MessagePackSerializerOptions options)
	{
		collection.Add(value);
	}

	protected override ObservableCollection<T> Create(int count, MessagePackSerializerOptions options)
	{
		return new ObservableCollection<T>();
	}

	protected override ReadOnlyObservableCollection<T> Complete(ObservableCollection<T> intermediateCollection)
	{
		return new ReadOnlyObservableCollection<T>(intermediateCollection);
	}
}
