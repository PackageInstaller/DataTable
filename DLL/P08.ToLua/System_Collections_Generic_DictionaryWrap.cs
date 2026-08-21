using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.Serialization;
using LuaInterface;

public class System_Collections_Generic_DictionaryWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Dictionary<, >), typeof(object), "Dictionary");
		L.RegFunction("get_Item", get_Item);
		L.RegFunction("set_Item", set_Item);
		L.RegFunction(".geti", _geti);
		L.RegFunction(".seti", _seti);
		L.RegFunction("Add", Add);
		L.RegFunction("Clear", Clear);
		L.RegFunction("ContainsKey", ContainsKey);
		L.RegFunction("ContainsValue", ContainsValue);
		L.RegFunction("GetObjectData", GetObjectData);
		L.RegFunction("OnDeserialization", OnDeserialization);
		L.RegFunction("Remove", Remove);
		L.RegFunction("TryGetValue", TryGetValue);
		L.RegFunction("GetEnumerator", GetEnumerator);
		L.RegVar("this", _this, null);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("Count", get_Count, null);
		L.RegVar("Comparer", get_Comparer, null);
		L.RegVar("Keys", get_Keys, null);
		L.RegVar("Values", get_Values, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _get_this(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Type ArgType = null;
			object obj = ToLua.CheckGenericObject(L, 1, typeof(Dictionary<, >), out ArgType);
			object obj2 = ToLua.CheckVarObject(L, 2, ArgType);
			object obj3 = LuaMethodCache.CallSingleMethod("get_Item", obj, obj2);
			ToLua.Push(L, obj3);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _set_this(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			object obj = ToLua.CheckGenericObject(L, 1, typeof(Dictionary<, >), out var t, out var t2);
			object obj2 = ToLua.CheckVarObject(L, 2, t);
			object obj3 = ToLua.CheckVarObject(L, 3, t2);
			LuaMethodCache.CallSingleMethod("set_Item", obj, obj2, obj3);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _this(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushvalue(L, 1);
			LuaDLL.tolua_bindthis(L, _get_this, _set_this);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Item(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Type ArgType = null;
			object obj = ToLua.CheckGenericObject(L, 1, typeof(Dictionary<, >), out ArgType);
			object obj2 = ToLua.CheckVarObject(L, 2, ArgType);
			object obj3 = LuaMethodCache.CallSingleMethod("get_Item", obj, obj2);
			ToLua.Push(L, obj3);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_Item(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			object obj = ToLua.CheckGenericObject(L, 1, typeof(Dictionary<, >), out var t, out var t2);
			object obj2 = ToLua.CheckVarObject(L, 2, t);
			object obj3 = ToLua.CheckVarObject(L, 3, t2);
			LuaMethodCache.CallSingleMethod("set_Item", obj, obj2, obj3);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _geti(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Type ArgType = null;
			object obj = ToLua.CheckGenericObject(L, 1, typeof(Dictionary<, >), out ArgType);
			if (ArgType != typeof(int))
			{
				LuaDLL.lua_pushnil(L);
			}
			else
			{
				object obj2 = ToLua.CheckVarObject(L, 2, ArgType);
				object obj3 = LuaMethodCache.CallSingleMethod("get_Item", obj, obj2);
				ToLua.Push(L, obj3);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _seti(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			object obj = ToLua.CheckGenericObject(L, 1, typeof(Dictionary<, >), out var t, out var t2);
			if (t == typeof(int))
			{
				object obj2 = ToLua.CheckVarObject(L, 2, t);
				object obj3 = ToLua.CheckVarObject(L, 3, t2);
				LuaMethodCache.CallSingleMethod("set_Item", obj, obj2, obj3);
			}
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Add(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			object obj = ToLua.CheckGenericObject(L, 1, typeof(Dictionary<, >), out var t, out var t2);
			object obj2 = ToLua.CheckVarObject(L, 2, t);
			object obj3 = ToLua.CheckVarObject(L, 3, t2);
			LuaMethodCache.CallSingleMethod("Add", obj, obj2, obj3);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Clear(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			object obj = ToLua.CheckGenericObject(L, 1, typeof(Dictionary<, >));
			LuaMethodCache.CallSingleMethod("Clear", obj);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ContainsKey(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			object obj = ToLua.CheckGenericObject(L, 1, typeof(Dictionary<, >), out var ArgType);
			object obj2 = ToLua.CheckVarObject(L, 2, ArgType);
			bool value = (bool)LuaMethodCache.CallSingleMethod("ContainsKey", obj, obj2);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ContainsValue(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			object obj = ToLua.CheckGenericObject(L, 1, typeof(Dictionary<, >), out var _, out var t2);
			object obj2 = ToLua.CheckVarObject(L, 2, t2);
			bool value = (bool)LuaMethodCache.CallSingleMethod("ContainsValue", obj, obj2);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetObjectData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			object obj = ToLua.CheckGenericObject(L, 1, typeof(Dictionary<, >));
			SerializationInfo serializationInfo = (SerializationInfo)ToLua.CheckObject(L, 2, typeof(SerializationInfo));
			StreamingContext streamingContext = (StreamingContext)ToLua.CheckObject(L, 3, typeof(StreamingContext));
			LuaMethodCache.CallSingleMethod("GetObjectData", obj, serializationInfo, streamingContext);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnDeserialization(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			object obj = ToLua.CheckGenericObject(L, 1, typeof(Dictionary<, >));
			object obj2 = ToLua.ToVarObject(L, 2);
			LuaMethodCache.CallSingleMethod("OnDeserialization", obj, obj2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Remove(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			object obj = ToLua.CheckGenericObject(L, 1, typeof(Dictionary<, >), out var ArgType);
			object obj2 = ToLua.CheckVarObject(L, 2, ArgType);
			bool value = (bool)LuaMethodCache.CallSingleMethod("Remove", obj, obj2);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int TryGetValue(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			object obj = ToLua.CheckGenericObject(L, 1, typeof(Dictionary<, >), out var ArgType);
			object obj2 = ToLua.CheckVarObject(L, 2, ArgType);
			object obj3 = null;
			object[] array = new object[2] { obj2, obj3 };
			bool value = (bool)LuaMethodCache.CallSingleMethod("TryGetValue", obj, array);
			LuaDLL.lua_pushboolean(L, value);
			ToLua.Push(L, array[1]);
			return 2;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetEnumerator(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			object obj = ToLua.CheckGenericObject(L, 1, typeof(Dictionary<, >));
			IEnumerator iter = (IEnumerator)LuaMethodCache.CallSingleMethod("GetEnumerator", obj);
			ToLua.Push(L, iter);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Count(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int n = (int)LuaMethodCache.CallSingleMethod("get_Count", obj);
			LuaDLL.lua_pushinteger(L, n);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Count on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Comparer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			object o = LuaMethodCache.CallSingleMethod("get_Comparer", obj);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Comparer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Keys(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			object o = LuaMethodCache.CallSingleMethod("get_Keys", obj);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Keys on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Values(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			object o = LuaMethodCache.CallSingleMethod("get_Values", obj);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Values on a nil value");
		}
	}
}
