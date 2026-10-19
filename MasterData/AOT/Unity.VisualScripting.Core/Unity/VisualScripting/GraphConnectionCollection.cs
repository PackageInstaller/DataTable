using System;
using System.Collections;
using System.Collections.Generic;

namespace Unity.VisualScripting;

public class GraphConnectionCollection<TConnection, TSource, TDestination> : ConnectionCollectionBase<TConnection, TSource, TDestination, GraphElementCollection<TConnection>>, IGraphElementCollection<TConnection>, IKeyedCollection<Guid, TConnection>, ICollection<TConnection>, IEnumerable<TConnection>, IEnumerable, INotifyCollectionChanged<TConnection> where TConnection : IConnection<TSource, TDestination>, IGraphElement
{
	TConnection IKeyedCollection<Guid, TConnection>.this[Guid key] => collection[key];

	TConnection IKeyedCollection<Guid, TConnection>.this[int index] => collection[index];

	public event Action<TConnection> ItemAdded
	{
		add
		{
			collection.ItemAdded += value;
		}
		remove
		{
			collection.ItemAdded -= value;
		}
	}

	public event Action<TConnection> ItemRemoved
	{
		add
		{
			collection.ItemRemoved += value;
		}
		remove
		{
			collection.ItemRemoved -= value;
		}
	}

	public event Action CollectionChanged
	{
		add
		{
			collection.CollectionChanged += value;
		}
		remove
		{
			collection.CollectionChanged -= value;
		}
	}

	public GraphConnectionCollection(IGraph graph)
		: base(new GraphElementCollection<TConnection>(graph))
	{
		collection.ProxyCollectionChange = true;
	}

	public bool TryGetValue(Guid key, out TConnection value)
	{
		return collection.TryGetValue(key, out value);
	}

	public bool Contains(Guid key)
	{
		return collection.Contains(key);
	}

	public bool Remove(Guid key)
	{
		if (Contains(key))
		{
			return Remove(collection[key]);
		}
		return false;
	}

	protected override void BeforeAdd(TConnection item)
	{
		collection.BeforeAdd(item);
	}

	protected override void AfterAdd(TConnection item)
	{
		collection.AfterAdd(item);
	}

	protected override void BeforeRemove(TConnection item)
	{
		collection.BeforeRemove(item);
	}

	protected override void AfterRemove(TConnection item)
	{
		collection.AfterRemove(item);
	}
}
