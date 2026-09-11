using System;
using System.Collections;
using System.Collections.Generic;

namespace LuaInterface;

public class LuaArrayTable : IDisposable, IEnumerable<object>, IEnumerable
{
	private class Enumerator : IEnumerator<object>, IEnumerator, IDisposable
	{
		private LuaState state;

		private int index = 1;

		private object current;

		private int top = -1;

		public object Current => current;

		public Enumerator(LuaArrayTable list)
		{
			state = list.state;
			top = state.LuaGetTop();
			state.Push(list.table);
		}

		public bool MoveNext()
		{
			state.LuaRawGetI(-1, index);
			current = state.ToVariant(-1);
			state.LuaPop(1);
			index++;
			if (current != null)
			{
				return true;
			}
			return false;
		}

		public void Reset()
		{
			index = 1;
			current = null;
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

	public int Length => table.Length;

	public object this[int key]
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

	public LuaArrayTable(LuaTable table)
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

	public void ForEach(Action<object> action)
	{
		using IEnumerator<object> enumerator = GetEnumerator();
		while (enumerator.MoveNext())
		{
			action(enumerator.Current);
		}
	}

	public IEnumerator<object> GetEnumerator()
	{
		return new Enumerator(this);
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}
}
