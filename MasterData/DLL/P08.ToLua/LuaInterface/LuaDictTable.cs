using System;
using System.Collections;
using System.Collections.Generic;

namespace LuaInterface;

public class LuaDictTable : IDisposable, IEnumerable<DictionaryEntry>, IEnumerable
{
	private class Enumerator : IEnumerator<DictionaryEntry>, IEnumerator, IDisposable
	{
		private LuaState state;

		private DictionaryEntry current;

		private int top = -1;

		public DictionaryEntry Current => current;

		object IEnumerator.Current => Current;

		public Enumerator(LuaDictTable list)
		{
			state = list.state;
			top = state.LuaGetTop();
			state.Push(list.table);
			state.LuaPushNil();
		}

		public bool MoveNext()
		{
			if (state.LuaNext(-2))
			{
				current = default(DictionaryEntry);
				current.Key = state.ToVariant(-2);
				current.Value = state.ToVariant(-1);
				state.LuaPop(1);
				return true;
			}
			current = default(DictionaryEntry);
			return false;
		}

		public void Reset()
		{
			current = default(DictionaryEntry);
		}

		public void Dispose()
		{
			if (state != null)
			{
				state.LuaSetTop(top);
				state = null;
			}
		}
	}

	private LuaTable table;

	private LuaState state;

	public object this[string key]
	{
		get
		{
			return table[key];
		}
		set
		{
			table[key] = value;
		}
	}

	public LuaDictTable(LuaTable table)
	{
		table.AddRef();
		this.table = table;
		state = table.GetLuaState();
	}

	public void Dispose()
	{
		if (table != null)
		{
			table.Dispose();
			table = null;
		}
	}

	public Hashtable ToHashtable()
	{
		Hashtable hashtable = new Hashtable();
		IEnumerator<DictionaryEntry> enumerator = GetEnumerator();
		while (enumerator.MoveNext())
		{
			hashtable.Add(enumerator.Current.Key, enumerator.Current.Value);
		}
		enumerator.Dispose();
		return hashtable;
	}

	public IEnumerator<DictionaryEntry> GetEnumerator()
	{
		return new Enumerator(this);
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}
}
public class LuaDictTable<K, V> : IDisposable, IEnumerable<LuaDictEntry<K, V>>, IEnumerable
{
	private class Enumerator : IEnumerator<LuaDictEntry<K, V>>, IEnumerator, IDisposable
	{
		private LuaState state;

		private LuaDictEntry<K, V> current;

		private int top = -1;

		public LuaDictEntry<K, V> Current => current;

		object IEnumerator.Current => Current;

		public Enumerator(LuaDictTable<K, V> list)
		{
			state = list.state;
			top = state.LuaGetTop();
			state.Push(list.table);
			state.LuaPushNil();
		}

		public bool MoveNext()
		{
			if (state.LuaNext(-2))
			{
				current = default(LuaDictEntry<K, V>);
				current.Key = state.CheckValue<K>(-2);
				current.Value = state.CheckValue<V>(-1);
				state.LuaPop(1);
				return true;
			}
			current = default(LuaDictEntry<K, V>);
			return false;
		}

		public void Reset()
		{
			current = default(LuaDictEntry<K, V>);
		}

		public void Dispose()
		{
			if (state != null)
			{
				state.LuaSetTop(top);
				state = null;
			}
		}
	}

	private LuaTable table;

	private LuaState state;

	public V this[K key]
	{
		get
		{
			return table.RawGet<K, V>(key);
		}
		set
		{
			table.RawSet(key, value);
		}
	}

	public LuaDictTable(LuaTable table)
	{
		table.AddRef();
		this.table = table;
		state = table.GetLuaState();
	}

	public void Dispose()
	{
		if (table != null)
		{
			table.Dispose();
			table = null;
		}
	}

	public Dictionary<K, V> ToDictionary()
	{
		Dictionary<K, V> dictionary = new Dictionary<K, V>();
		IEnumerator<LuaDictEntry<K, V>> enumerator = GetEnumerator();
		while (enumerator.MoveNext())
		{
			dictionary.Add(enumerator.Current.Key, enumerator.Current.Value);
		}
		enumerator.Dispose();
		return dictionary;
	}

	public IEnumerator<LuaDictEntry<K, V>> GetEnumerator()
	{
		return new Enumerator(this);
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}
}
