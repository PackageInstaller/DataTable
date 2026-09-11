using System;
using System.Collections.Generic;

namespace Pathfinding.Util;

public class GridLookup<T> where T : class
{
	internal class Item
	{
		public Root root;

		public Item prev;

		public Item next;
	}

	public class Root
	{
		public T obj;

		public Root next;

		internal Root prev;

		internal IntRect previousBounds = new IntRect(0, 0, -1, -1);

		internal List<Item> items = new List<Item>();

		internal bool flag;
	}

	private Int2 size;

	private Item[] cells;

	private Root all = new Root();

	private Dictionary<T, Root> rootLookup = new Dictionary<T, Root>();

	private Stack<Item> itemPool = new Stack<Item>();

	public Root AllItems => all.next;

	public GridLookup(Int2 size)
	{
		this.size = size;
		cells = new Item[size.x * size.y];
		for (int i = 0; i < cells.Length; i++)
		{
			cells[i] = new Item();
		}
	}

	public Root GetRoot(T item)
	{
		rootLookup.TryGetValue(item, out var value);
		return value;
	}

	public Root Add(T item, IntRect bounds)
	{
		Root root = new Root
		{
			obj = item,
			prev = all,
			next = all.next
		};
		all.next = root;
		if (root.next != null)
		{
			root.next.prev = root;
		}
		rootLookup.Add(item, root);
		Move(item, bounds);
		return root;
	}

	public void Remove(T item)
	{
		if (rootLookup.TryGetValue(item, out var value))
		{
			Move(item, new IntRect(0, 0, -1, -1));
			rootLookup.Remove(item);
			value.prev.next = value.next;
			if (value.next != null)
			{
				value.next.prev = value.prev;
			}
		}
	}

	public void Move(T item, IntRect bounds)
	{
		if (!rootLookup.TryGetValue(item, out var value))
		{
			throw new ArgumentException("The item has not been added to this object");
		}
		IntRect previousBounds = value.previousBounds;
		if (previousBounds == bounds)
		{
			return;
		}
		for (int i = 0; i < value.items.Count; i++)
		{
			Item item2 = value.items[i];
			item2.prev.next = item2.next;
			if (item2.next != null)
			{
				item2.next.prev = item2.prev;
			}
		}
		value.previousBounds = bounds;
		int num = 0;
		for (int j = bounds.ymin; j <= bounds.ymax; j++)
		{
			for (int k = bounds.xmin; k <= bounds.xmax; k++)
			{
				Item item3;
				if (num < value.items.Count)
				{
					item3 = value.items[num];
				}
				else
				{
					item3 = ((itemPool.Count > 0) ? itemPool.Pop() : new Item());
					item3.root = value;
					value.items.Add(item3);
				}
				num++;
				item3.prev = cells[k + j * size.x];
				item3.next = item3.prev.next;
				item3.prev.next = item3;
				if (item3.next != null)
				{
					item3.next.prev = item3;
				}
			}
		}
		for (int num2 = value.items.Count - 1; num2 >= num; num2--)
		{
			Item item4 = value.items[num2];
			item4.root = null;
			item4.next = null;
			item4.prev = null;
			value.items.RemoveAt(num2);
			itemPool.Push(item4);
		}
	}

	public List<U> QueryRect<U>(IntRect r) where U : class, T
	{
		List<U> list = ListPool<U>.Claim();
		for (int i = r.ymin; i <= r.ymax; i++)
		{
			int num = i * size.x;
			for (int j = r.xmin; j <= r.xmax; j++)
			{
				Item item = cells[j + num];
				while (item.next != null)
				{
					item = item.next;
					U val = item.root.obj as U;
					if (!item.root.flag && val != null)
					{
						item.root.flag = true;
						list.Add(val);
					}
				}
			}
		}
		for (int k = r.ymin; k <= r.ymax; k++)
		{
			int num2 = k * size.x;
			for (int l = r.xmin; l <= r.xmax; l++)
			{
				Item item2 = cells[l + num2];
				while (item2.next != null)
				{
					item2 = item2.next;
					item2.root.flag = false;
				}
			}
		}
		return list;
	}
}
