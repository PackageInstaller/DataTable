using System;
using System.Collections.Generic;

namespace LuaInterface;

public class LuaTable : LuaBaseRef
{
	public object this[string key]
	{
		get
		{
			int num = luaState.LuaGetTop();
			try
			{
				luaState.Push(this);
				luaState.Push(key);
				luaState.LuaGetTable(num + 1);
				object result = luaState.ToVariant(num + 2);
				luaState.LuaSetTop(num);
				return result;
			}
			catch (Exception ex)
			{
				luaState.LuaSetTop(num);
				throw ex;
			}
		}
		set
		{
			int num = luaState.LuaGetTop();
			try
			{
				luaState.Push(this);
				luaState.Push(key);
				luaState.PushVariant(value);
				luaState.LuaSetTable(num + 1);
				luaState.LuaSetTop(num);
			}
			catch (Exception ex)
			{
				luaState.LuaSetTop(num);
				throw ex;
			}
		}
	}

	public object this[int key]
	{
		get
		{
			int num = luaState.LuaGetTop();
			try
			{
				luaState.Push(this);
				luaState.LuaRawGetI(num + 1, key);
				object result = luaState.ToVariant(num + 2);
				luaState.LuaSetTop(num);
				return result;
			}
			catch (Exception ex)
			{
				luaState.LuaSetTop(num);
				throw ex;
			}
		}
		set
		{
			int num = luaState.LuaGetTop();
			try
			{
				luaState.Push(this);
				luaState.PushVariant(value);
				luaState.LuaRawSetI(num + 1, key);
				luaState.LuaSetTop(num);
			}
			catch (Exception ex)
			{
				luaState.LuaSetTop(num);
				throw ex;
			}
		}
	}

	public int Length
	{
		get
		{
			luaState.Push(this);
			int result = luaState.LuaObjLen(-1);
			luaState.LuaPop(1);
			return result;
		}
	}

	public LuaTable(int reference, LuaState state)
	{
		base.reference = reference;
		luaState = state;
	}

	public T RawGetIndex<T>(int index)
	{
		int num = luaState.LuaGetTop();
		try
		{
			luaState.Push(this);
			luaState.LuaRawGetI(num + 1, index);
			T result = luaState.CheckValue<T>(num + 2);
			luaState.LuaSetTop(num);
			return result;
		}
		catch (Exception ex)
		{
			luaState.LuaSetTop(num);
			throw ex;
		}
	}

	public void RawSetIndex<T>(int index, T value)
	{
		int num = luaState.LuaGetTop();
		try
		{
			luaState.Push(this);
			luaState.PushGeneric(value);
			luaState.LuaRawSetI(num + 1, index);
			luaState.LuaSetTop(num);
		}
		catch (Exception ex)
		{
			luaState.LuaSetTop(num);
			throw ex;
		}
	}

	public V RawGet<K, V>(K key)
	{
		int num = luaState.LuaGetTop();
		try
		{
			luaState.Push(this);
			luaState.PushGeneric(key);
			luaState.LuaRawGet(num + 1);
			V result = luaState.CheckValue<V>(num + 2);
			luaState.LuaSetTop(num);
			return result;
		}
		catch (Exception ex)
		{
			luaState.LuaSetTop(num);
			throw ex;
		}
	}

	public void RawSet<K, V>(K key, V arg)
	{
		int num = luaState.LuaGetTop();
		try
		{
			luaState.Push(this);
			luaState.PushGeneric(key);
			luaState.PushGeneric(arg);
			luaState.LuaRawSet(num + 1);
			luaState.LuaSetTop(num);
		}
		catch (Exception ex)
		{
			luaState.LuaSetTop(num);
			throw ex;
		}
	}

	public T GetTable<T>(string key)
	{
		int num = luaState.LuaGetTop();
		try
		{
			luaState.Push(this);
			luaState.Push(key);
			luaState.LuaGetTable(num + 1);
			T result = luaState.CheckValue<T>(num + 2);
			luaState.LuaSetTop(num);
			return result;
		}
		catch (Exception ex)
		{
			luaState.LuaSetTop(num);
			throw ex;
		}
	}

	public void SetTable<T>(string key, T arg)
	{
		int num = luaState.LuaGetTop();
		try
		{
			luaState.Push(this);
			luaState.Push(key);
			luaState.PushGeneric(arg);
			luaState.LuaSetTable(num + 1);
			luaState.LuaSetTop(num);
		}
		catch (Exception ex)
		{
			luaState.LuaSetTop(num);
			throw ex;
		}
	}

	public LuaFunction RawGetLuaFunction(string key)
	{
		int num = luaState.LuaGetTop();
		try
		{
			luaState.Push(this);
			luaState.Push(key);
			luaState.LuaRawGet(num + 1);
			LuaFunction result = luaState.CheckLuaFunction(num + 2);
			luaState.LuaSetTop(num);
			return result;
		}
		catch (Exception ex)
		{
			luaState.LuaSetTop(num);
			throw ex;
		}
	}

	public LuaFunction GetLuaFunction(string key)
	{
		int num = luaState.LuaGetTop();
		try
		{
			luaState.Push(this);
			luaState.Push(key);
			luaState.LuaGetTable(num + 1);
			LuaFunction result = luaState.CheckLuaFunction(num + 2);
			luaState.LuaSetTop(num);
			return result;
		}
		catch (Exception ex)
		{
			luaState.LuaSetTop(num);
			throw ex;
		}
	}

	private bool BeginCall(string name, int top)
	{
		luaState.Push(this);
		luaState.ToLuaPushTraceback();
		luaState.Push(name);
		luaState.LuaGetTable(top + 1);
		return luaState.LuaType(top + 3) == LuaTypes.LUA_TFUNCTION;
	}

	public void Call(string name)
	{
		int num = luaState.LuaGetTop();
		try
		{
			if (BeginCall(name, num))
			{
				luaState.Call(0, num + 2, num);
			}
			luaState.LuaSetTop(num);
		}
		catch (Exception ex)
		{
			luaState.LuaSetTop(num);
			throw ex;
		}
	}

	public void Call<T1>(string name, T1 arg1)
	{
		int num = luaState.LuaGetTop();
		try
		{
			if (BeginCall(name, num))
			{
				luaState.PushGeneric(arg1);
				luaState.Call(1, num + 2, num);
			}
			luaState.LuaSetTop(num);
		}
		catch (Exception ex)
		{
			luaState.LuaSetTop(num);
			throw ex;
		}
	}

	public void Call<T1, T2>(string name, T1 arg1, T2 arg2)
	{
		int num = luaState.LuaGetTop();
		try
		{
			if (BeginCall(name, num))
			{
				luaState.PushGeneric(arg1);
				luaState.PushGeneric(arg2);
				luaState.Call(2, num + 2, num);
			}
			luaState.LuaSetTop(num);
		}
		catch (Exception ex)
		{
			luaState.LuaSetTop(num);
			throw ex;
		}
	}

	public void Call<T1, T2, T3>(string name, T1 arg1, T2 arg2, T3 arg3)
	{
		int num = luaState.LuaGetTop();
		try
		{
			if (BeginCall(name, num))
			{
				luaState.PushGeneric(arg1);
				luaState.PushGeneric(arg2);
				luaState.PushGeneric(arg3);
				luaState.Call(3, num + 2, num);
			}
			luaState.LuaSetTop(num);
		}
		catch (Exception ex)
		{
			luaState.LuaSetTop(num);
			throw ex;
		}
	}

	public void Call<T1, T2, T3, T4>(string name, T1 arg1, T2 arg2, T3 arg3, T4 arg4)
	{
		int num = luaState.LuaGetTop();
		try
		{
			if (BeginCall(name, num))
			{
				luaState.PushGeneric(arg1);
				luaState.PushGeneric(arg2);
				luaState.PushGeneric(arg3);
				luaState.PushGeneric(arg4);
				luaState.Call(4, num + 2, num);
			}
			luaState.LuaSetTop(num);
		}
		catch (Exception ex)
		{
			luaState.LuaSetTop(num);
			throw ex;
		}
	}

	public void Call<T1, T2, T3, T4, T5>(string name, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5)
	{
		int num = luaState.LuaGetTop();
		try
		{
			if (BeginCall(name, num))
			{
				luaState.PushGeneric(arg1);
				luaState.PushGeneric(arg2);
				luaState.PushGeneric(arg3);
				luaState.PushGeneric(arg4);
				luaState.PushGeneric(arg5);
				luaState.Call(5, num + 2, num);
			}
			luaState.LuaSetTop(num);
		}
		catch (Exception ex)
		{
			luaState.LuaSetTop(num);
			throw ex;
		}
	}

	public void Call<T1, T2, T3, T4, T5, T6>(string name, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6)
	{
		int num = luaState.LuaGetTop();
		try
		{
			if (BeginCall(name, num))
			{
				luaState.PushGeneric(arg1);
				luaState.PushGeneric(arg2);
				luaState.PushGeneric(arg3);
				luaState.PushGeneric(arg4);
				luaState.PushGeneric(arg5);
				luaState.PushGeneric(arg6);
				luaState.Call(6, num + 2, num);
			}
			luaState.LuaSetTop(num);
		}
		catch (Exception ex)
		{
			luaState.LuaSetTop(num);
			throw ex;
		}
	}

	public R1 Invoke<R1>(string name)
	{
		int num = luaState.LuaGetTop();
		try
		{
			R1 result = default(R1);
			if (BeginCall(name, num))
			{
				luaState.Call(0, num + 2, num);
				result = luaState.CheckValue<R1>(num + 3);
			}
			luaState.LuaSetTop(num);
			return result;
		}
		catch (Exception ex)
		{
			luaState.LuaSetTop(num);
			throw ex;
		}
	}

	public R1 Invoke<T1, R1>(string name, T1 arg1)
	{
		int num = luaState.LuaGetTop();
		try
		{
			R1 result = default(R1);
			if (BeginCall(name, num))
			{
				luaState.PushGeneric(arg1);
				luaState.Call(1, num + 2, num);
				result = luaState.CheckValue<R1>(num + 3);
			}
			luaState.LuaSetTop(num);
			return result;
		}
		catch (Exception ex)
		{
			luaState.LuaSetTop(num);
			throw ex;
		}
	}

	public R1 Invoke<T1, T2, R1>(string name, T1 arg1, T2 arg2)
	{
		int num = luaState.LuaGetTop();
		try
		{
			R1 result = default(R1);
			if (BeginCall(name, num))
			{
				luaState.PushGeneric(arg1);
				luaState.PushGeneric(arg2);
				luaState.Call(2, num + 2, num);
				result = luaState.CheckValue<R1>(num + 3);
			}
			luaState.LuaSetTop(num);
			return result;
		}
		catch (Exception ex)
		{
			luaState.LuaSetTop(num);
			throw ex;
		}
	}

	public R1 Invoke<T1, T2, T3, R1>(string name, T1 arg1, T2 arg2, T3 arg3)
	{
		int num = luaState.LuaGetTop();
		try
		{
			R1 result = default(R1);
			if (BeginCall(name, num))
			{
				luaState.PushGeneric(arg1);
				luaState.PushGeneric(arg2);
				luaState.PushGeneric(arg3);
				luaState.Call(3, num + 2, num);
				result = luaState.CheckValue<R1>(num + 3);
			}
			luaState.LuaSetTop(num);
			return result;
		}
		catch (Exception ex)
		{
			luaState.LuaSetTop(num);
			throw ex;
		}
	}

	public R1 Invoke<T1, T2, T3, T4, R1>(string name, T1 arg1, T2 arg2, T3 arg3, T4 arg4)
	{
		int num = luaState.LuaGetTop();
		try
		{
			R1 result = default(R1);
			if (BeginCall(name, num))
			{
				luaState.PushGeneric(arg1);
				luaState.PushGeneric(arg2);
				luaState.PushGeneric(arg3);
				luaState.PushGeneric(arg4);
				luaState.Call(4, num + 2, num);
				result = luaState.CheckValue<R1>(num + 3);
			}
			luaState.LuaSetTop(num);
			return result;
		}
		catch (Exception ex)
		{
			luaState.LuaSetTop(num);
			throw ex;
		}
	}

	public R1 Invoke<T1, T2, T3, T4, T5, R1>(string name, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5)
	{
		int num = luaState.LuaGetTop();
		try
		{
			R1 result = default(R1);
			if (BeginCall(name, num))
			{
				luaState.PushGeneric(arg1);
				luaState.PushGeneric(arg2);
				luaState.PushGeneric(arg3);
				luaState.PushGeneric(arg4);
				luaState.PushGeneric(arg5);
				luaState.Call(5, num + 2, num);
				result = luaState.CheckValue<R1>(num + 3);
			}
			luaState.LuaSetTop(num);
			return result;
		}
		catch (Exception ex)
		{
			luaState.LuaSetTop(num);
			throw ex;
		}
	}

	public R1 Invoke<T1, T2, T3, T4, T5, T6, R1>(string name, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6)
	{
		int num = luaState.LuaGetTop();
		try
		{
			R1 result = default(R1);
			if (BeginCall(name, num))
			{
				luaState.PushGeneric(arg1);
				luaState.PushGeneric(arg2);
				luaState.PushGeneric(arg3);
				luaState.PushGeneric(arg4);
				luaState.PushGeneric(arg5);
				luaState.PushGeneric(arg6);
				luaState.Call(6, num + 2, num);
				result = luaState.CheckValue<R1>(num + 3);
			}
			luaState.LuaSetTop(num);
			return result;
		}
		catch (Exception ex)
		{
			luaState.LuaSetTop(num);
			throw ex;
		}
	}

	public string GetStringField(string name)
	{
		int num = luaState.LuaGetTop();
		try
		{
			luaState.Push(this);
			luaState.LuaGetField(num + 1, name);
			string result = luaState.CheckString(-1);
			luaState.LuaSetTop(num);
			return result;
		}
		catch (LuaException ex)
		{
			luaState.LuaSetTop(num);
			throw ex;
		}
	}

	public void AddTable(string name)
	{
		int num = luaState.LuaGetTop();
		try
		{
			luaState.Push(this);
			luaState.Push(name);
			luaState.LuaCreateTable();
			luaState.LuaRawSet(num + 1);
			luaState.LuaSetTop(num);
		}
		catch (Exception ex)
		{
			luaState.LuaSetTop(num);
			throw ex;
		}
	}

	public object[] ToArray()
	{
		int newTop = luaState.LuaGetTop();
		try
		{
			luaState.Push(this);
			int num = luaState.LuaObjLen(-1);
			List<object> list = new List<object>(num + 1);
			int num2 = 1;
			object obj = null;
			while (num2 <= num)
			{
				luaState.LuaRawGetI(-1, num2++);
				obj = luaState.ToVariant(-1);
				luaState.LuaPop(1);
				list.Add(obj);
			}
			luaState.LuaSetTop(newTop);
			return list.ToArray();
		}
		catch (Exception ex)
		{
			luaState.LuaSetTop(newTop);
			throw ex;
		}
	}

	public override string ToString()
	{
		luaState.Push(this);
		IntPtr intPtr = luaState.LuaToPointer(-1);
		luaState.LuaPop(1);
		return string.Format("table:0x{0}", intPtr.ToString("X"));
	}

	public LuaArrayTable ToArrayTable()
	{
		return new LuaArrayTable(this);
	}

	public LuaDictTable ToDictTable()
	{
		return new LuaDictTable(this);
	}

	public LuaDictTable<K, V> ToDictTable<K, V>()
	{
		return new LuaDictTable<K, V>(this);
	}

	public LuaTable GetMetaTable()
	{
		int newTop = luaState.LuaGetTop();
		try
		{
			LuaTable result = null;
			luaState.Push(this);
			if (luaState.LuaGetMetaTable(-1) != 0)
			{
				result = luaState.CheckLuaTable(-1);
			}
			luaState.LuaSetTop(newTop);
			return result;
		}
		catch (Exception ex)
		{
			luaState.LuaSetTop(newTop);
			throw ex;
		}
	}
}
