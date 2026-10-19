using System;
using System.Collections;
using System.Collections.Generic;

namespace Unity.VisualScripting;

public sealed class GraphElementCollection<TElement> : GuidCollection<TElement>, IGraphElementCollection<TElement>, IKeyedCollection<Guid, TElement>, ICollection<TElement>, IEnumerable<TElement>, IEnumerable, INotifyCollectionChanged<TElement>, IProxyableNotifyCollectionChanged<TElement> where TElement : IGraphElement
{
	public IGraph graph { get; }

	public bool ProxyCollectionChange { get; set; }

	public event Action<TElement> ItemAdded;

	public event Action<TElement> ItemRemoved;

	public event Action CollectionChanged;

	public GraphElementCollection(IGraph graph)
	{
		Ensure.That("graph").IsNotNull(graph);
		this.graph = graph;
	}

	public void BeforeAdd(TElement element)
	{
		if (element.graph != null)
		{
			if (element.graph == this.graph)
			{
				throw new InvalidOperationException("Graph elements cannot be added multiple time into the same graph.");
			}
			throw new InvalidOperationException("Graph elements cannot be shared across graphs.");
		}
		IGraph graph = this.graph;
		element.graph = graph;
		element.BeforeAdd();
	}

	public void AfterAdd(TElement element)
	{
		element.AfterAdd();
		ItemAdded?.Invoke(element);
		CollectionChanged?.Invoke();
	}

	public void BeforeRemove(TElement element)
	{
		element.BeforeRemove();
	}

	public void AfterRemove(TElement element)
	{
		element.graph = null;
		element.AfterRemove();
		ItemRemoved?.Invoke(element);
		CollectionChanged?.Invoke();
	}

	protected override void InsertItem(int index, TElement element)
	{
		Ensure.That("element").IsNotNull(element);
		if (!ProxyCollectionChange)
		{
			BeforeAdd(element);
		}
		base.InsertItem(index, element);
		if (!ProxyCollectionChange)
		{
			AfterAdd(element);
		}
	}

	protected override void RemoveItem(int index)
	{
		TElement val = base[index];
		if (!Contains(val))
		{
			throw new ArgumentOutOfRangeException("element");
		}
		if (!ProxyCollectionChange)
		{
			BeforeRemove(val);
		}
		base.RemoveItem(index);
		if (!ProxyCollectionChange)
		{
			AfterRemove(val);
		}
	}

	protected override void ClearItems()
	{
		List<TElement> list = ListPool<TElement>.New();
		using (NoAllocEnumerator<TElement> noAllocEnumerator = GetEnumerator())
		{
			while (noAllocEnumerator.MoveNext())
			{
				TElement current = noAllocEnumerator.Current;
				list.Add(current);
			}
		}
		list.Sort((TElement a, TElement b) => b.dependencyOrder.CompareTo(a.dependencyOrder));
		foreach (TElement item in list)
		{
			Remove(item);
		}
		ListPool<TElement>.Free(list);
	}

	protected override void SetItem(int index, TElement item)
	{
		throw new NotSupportedException();
	}

	public new NoAllocEnumerator<TElement> GetEnumerator()
	{
		return new NoAllocEnumerator<TElement>(this);
	}

	TElement IKeyedCollection<Guid, TElement>.get_Item(Guid key)
	{
		return base[key];
	}

	bool IKeyedCollection<Guid, TElement>.Contains(Guid key)
	{
		return Contains(key);
	}

	bool IKeyedCollection<Guid, TElement>.Remove(Guid key)
	{
		return Remove(key);
	}
}
