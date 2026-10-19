using System;

namespace Unity.VisualScripting;

public sealed class MergedGraphElementCollection : MergedKeyedCollection<Guid, IGraphElement>, INotifyCollectionChanged<IGraphElement>
{
	public event Action<IGraphElement> ItemAdded;

	public event Action<IGraphElement> ItemRemoved;

	public event Action CollectionChanged;

	public override void Include<TSubItem>(IKeyedCollection<Guid, TSubItem> collection)
	{
		base.Include(collection);
		if (collection is IGraphElementCollection<TSubItem> graphElementCollection)
		{
			graphElementCollection.ItemAdded += (TSubItem element) =>
			{
				ItemAdded?.Invoke(element);
			};
			graphElementCollection.ItemRemoved += (TSubItem element) =>
			{
				ItemRemoved?.Invoke(element);
			};
			graphElementCollection.CollectionChanged += () =>
			{
				CollectionChanged?.Invoke();
			};
		}
	}
}
