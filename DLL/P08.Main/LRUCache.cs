using System.Collections.Generic;

public class LRUCache<K, V>
{
	public class Cache
	{
		public K key;

		public V value;

		public Cache(K x, V y)
		{
			key = x;
			value = y;
		}
	}

	private int capacity;

	private Dictionary<K, LinkedListNode<Cache>> map;

	private LinkedList<Cache> list;

	public int Count => map.Count;

	public IEnumerable<V> Values
	{
		get
		{
			foreach (LinkedListNode<Cache> value in map.Values)
			{
				yield return value.Value.value;
			}
		}
	}

	public IEnumerable<KeyValuePair<K, V>> Entries
	{
		get
		{
			foreach (KeyValuePair<K, LinkedListNode<Cache>> item in map)
			{
				yield return new KeyValuePair<K, V>(item.Key, item.Value.Value.value);
			}
		}
	}

	public LRUCache(int capacity)
	{
		this.capacity = capacity;
		map = new Dictionary<K, LinkedListNode<Cache>>();
		list = new LinkedList<Cache>();
	}

	public bool Get(K key, out V val)
	{
		if (map.ContainsKey(key))
		{
			Remove(key, out val);
			AddNode(key, val);
			return true;
		}
		val = default(V);
		return false;
	}

	public K Put(K key, V value, out V removed)
	{
		K rmvKey;
		if (!map.ContainsKey(key) && map.Count == capacity)
		{
			removed = RemoveLast(out rmvKey);
		}
		else
		{
			Remove(key, out removed);
			rmvKey = key;
		}
		AddNode(key, value);
		return rmvKey;
	}

	public bool Remove(K key, out V value)
	{
		if (map.TryGetValue(key, out var value2))
		{
			map.Remove(key);
			list.Remove(value2);
			value = value2.Value.value;
			return true;
		}
		value = default(V);
		return false;
	}

	public void AddNode(K key, V value)
	{
		LinkedListNode<Cache> linkedListNode = new LinkedListNode<Cache>(new Cache(key, value));
		map[key] = linkedListNode;
		list.AddFirst(linkedListNode);
	}

	public V RemoveLast(out K rmvKey)
	{
		rmvKey = default(K);
		if (list.Last == null)
		{
			return default(V);
		}
		LinkedListNode<Cache> last = list.Last;
		list.RemoveLast();
		K key = last.Value.key;
		map.Remove(key);
		rmvKey = last.Value.key;
		return last.Value.value;
	}
}
