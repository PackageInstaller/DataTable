using System;
using System.Collections;
using System.Collections.Generic;
using LuaInterface;

public class System_Collections_Generic_ListWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(List<>), typeof(object), "List");
		L.RegFunction("Add", Add);
		L.RegFunction("AddRange", AddRange);
		L.RegFunction("AsReadOnly", AsReadOnly);
		L.RegFunction("BinarySearch", BinarySearch);
		L.RegFunction("Clear", Clear);
		L.RegFunction("Contains", Contains);
		L.RegFunction("CopyTo", CopyTo);
		L.RegFunction("Exists", Exists);
		L.RegFunction("Find", Find);
		L.RegFunction("FindAll", FindAll);
		L.RegFunction("FindIndex", FindIndex);
		L.RegFunction("FindLast", FindLast);
		L.RegFunction("FindLastIndex", FindLastIndex);
		L.RegFunction("ForEach", ForEach);
		L.RegFunction("GetEnumerator", GetEnumerator);
		L.RegFunction("GetRange", GetRange);
		L.RegFunction("IndexOf", IndexOf);
		L.RegFunction("Insert", Insert);
		L.RegFunction("InsertRange", InsertRange);
		L.RegFunction("LastIndexOf", LastIndexOf);
		L.RegFunction("Remove", Remove);
		L.RegFunction("RemoveAll", RemoveAll);
		L.RegFunction("RemoveAt", RemoveAt);
		L.RegFunction("RemoveRange", RemoveRange);
		L.RegFunction("Reverse", Reverse);
		L.RegFunction("Sort", Sort);
		L.RegFunction("ToArray", ToArray);
		L.RegFunction("TrimExcess", TrimExcess);
		L.RegFunction("TrueForAll", TrueForAll);
		L.RegFunction("get_Item", get_Item);
		L.RegFunction("set_Item", set_Item);
		L.RegFunction(".geti", get_Item);
		L.RegFunction(".seti", set_Item);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("Capacity", get_Capacity, set_Capacity);
		L.RegVar("Count", get_Count, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Add(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Type ArgType = null;
			object obj = ToLua.CheckGenericObject(L, 1, typeof(List<>), out ArgType);
			object obj2 = ToLua.CheckVarObject(L, 2, ArgType);
			LuaMethodCache.CallSingleMethod("Add", obj, obj2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddRange(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Type ArgType = null;
			object obj = ToLua.CheckGenericObject(L, 1, typeof(List<>), out ArgType);
			object obj2 = ToLua.CheckObject(L, 2, typeof(IEnumerable<>).MakeGenericType(ArgType));
			LuaMethodCache.CallSingleMethod("AddRange", obj, obj2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AsReadOnly(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Type ArgType = null;
			object obj = ToLua.CheckGenericObject(L, 1, typeof(List<>), out ArgType);
			object obj2 = LuaMethodCache.CallSingleMethod("AsReadOnly", obj);
			ToLua.Push(L, obj2);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int BinarySearch(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			Type ArgType = null;
			object obj = ToLua.CheckGenericObject(L, 1, typeof(List<>), out ArgType);
			switch (num)
			{
			case 2:
			{
				object obj6 = ToLua.CheckVarObject(L, 2, ArgType);
				int n3 = (int)LuaMethodCache.CallMethod("BinarySearch", obj, obj6);
				LuaDLL.lua_pushinteger(L, n3);
				return 1;
			}
			case 3:
			{
				object obj4 = ToLua.CheckVarObject(L, 2, ArgType);
				object obj5 = ToLua.CheckObject(L, 3, typeof(IComparer<>).MakeGenericType(ArgType));
				int n2 = (int)LuaMethodCache.CallMethod("BinarySearch", obj, obj4, obj5);
				LuaDLL.lua_pushinteger(L, n2);
				return 1;
			}
			case 5:
			{
				int num2 = (int)LuaDLL.luaL_checknumber(L, 2);
				int num3 = (int)LuaDLL.luaL_checknumber(L, 3);
				object obj2 = ToLua.CheckVarObject(L, 4, ArgType);
				object obj3 = ToLua.CheckObject(L, 5, typeof(IComparer<>).MakeGenericType(ArgType));
				int n = (int)LuaMethodCache.CallMethod("BinarySearch", obj, num2, num3, obj2, obj3);
				LuaDLL.lua_pushinteger(L, n);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, $"invalid arguments to method: List<{LuaMisc.GetTypeName(ArgType)}>.BinarySearch");
			}
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
			object obj = ToLua.CheckGenericObject(L, 1, typeof(List<>));
			LuaMethodCache.CallSingleMethod("Clear", obj);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Contains(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Type ArgType = null;
			object obj = ToLua.CheckGenericObject(L, 1, typeof(List<>), out ArgType);
			object obj2 = ToLua.CheckVarObject(L, 2, ArgType);
			object obj3 = LuaMethodCache.CallSingleMethod("Contains", obj, obj2);
			LuaDLL.lua_pushboolean(L, (bool)obj3);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CopyTo(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			Type ArgType = null;
			object obj = ToLua.CheckGenericObject(L, 1, typeof(List<>), out ArgType);
			switch (num)
			{
			case 2:
			{
				object obj4 = ToLua.CheckObject(L, 2, ArgType.MakeArrayType());
				LuaMethodCache.CallMethod("CopyTo", obj, obj4);
				return 0;
			}
			case 3:
			{
				object obj3 = ToLua.CheckObject(L, 2, ArgType.MakeArrayType());
				int num5 = (int)LuaDLL.luaL_checknumber(L, 3);
				LuaMethodCache.CallMethod("CopyTo", obj, obj3, num5);
				return 0;
			}
			case 5:
			{
				int num2 = (int)LuaDLL.luaL_checknumber(L, 2);
				object obj2 = ToLua.CheckObject(L, 3, ArgType.MakeArrayType());
				int num3 = (int)LuaDLL.luaL_checknumber(L, 4);
				int num4 = (int)LuaDLL.luaL_checknumber(L, 5);
				LuaMethodCache.CallMethod("CopyTo", obj, num2, obj2, num3, num4);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, $"invalid arguments to method: List<{LuaMisc.GetTypeName(ArgType)}>.CopyTo");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Exists(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Type ArgType = null;
			object obj = ToLua.CheckGenericObject(L, 1, typeof(List<>), out ArgType);
			Delegate obj2 = ToLua.CheckDelegate(typeof(Predicate<>).MakeGenericType(ArgType), L, 2);
			bool value = (bool)LuaMethodCache.CallMethod("Exists", obj, obj2);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Find(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Type ArgType = null;
			object obj = ToLua.CheckGenericObject(L, 1, typeof(List<>), out ArgType);
			Delegate obj2 = ToLua.CheckDelegate(typeof(Predicate<>).MakeGenericType(ArgType), L, 2);
			object obj3 = LuaMethodCache.CallMethod("Find", obj, obj2);
			ToLua.Push(L, obj3);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int FindAll(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Type ArgType = null;
			object obj = ToLua.CheckGenericObject(L, 1, typeof(List<>), out ArgType);
			Delegate obj2 = ToLua.CheckDelegate(typeof(Predicate<>).MakeGenericType(ArgType), L, 2);
			object obj3 = LuaMethodCache.CallMethod("FindAll", obj, obj2);
			ToLua.Push(L, obj3);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int FindIndex(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			Type ArgType = null;
			object obj = ToLua.CheckGenericObject(L, 1, typeof(List<>), out ArgType);
			switch (num)
			{
			case 2:
			{
				Delegate obj4 = ToLua.CheckDelegate(typeof(Predicate<>).MakeGenericType(ArgType), L, 2);
				int n3 = (int)LuaMethodCache.CallMethod("FindIndex", obj, obj4);
				LuaDLL.lua_pushinteger(L, n3);
				return 1;
			}
			case 3:
			{
				int num4 = (int)LuaDLL.luaL_checknumber(L, 2);
				Delegate obj3 = ToLua.CheckDelegate(typeof(Predicate<>).MakeGenericType(ArgType), L, 3);
				int n2 = (int)LuaMethodCache.CallMethod("FindIndex", obj, num4, obj3);
				LuaDLL.lua_pushinteger(L, n2);
				return 1;
			}
			case 4:
			{
				int num2 = (int)LuaDLL.luaL_checknumber(L, 2);
				int num3 = (int)LuaDLL.luaL_checknumber(L, 3);
				Delegate obj2 = ToLua.CheckDelegate(typeof(Predicate<>).MakeGenericType(ArgType), L, 4);
				int n = (int)LuaMethodCache.CallMethod("FindIndex", obj, num2, num3, obj2);
				LuaDLL.lua_pushinteger(L, n);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, $"invalid arguments to method: List<{LuaMisc.GetTypeName(ArgType)}>.FindIndex");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int FindLast(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Type ArgType = null;
			object obj = ToLua.CheckGenericObject(L, 1, typeof(List<>), out ArgType);
			Delegate obj2 = ToLua.CheckDelegate(typeof(Predicate<>).MakeGenericType(ArgType), L, 2);
			object obj3 = LuaMethodCache.CallSingleMethod("FindLast", obj, obj2);
			ToLua.Push(L, obj3);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int FindLastIndex(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			Type ArgType = null;
			object obj = ToLua.CheckGenericObject(L, 1, typeof(List<>), out ArgType);
			switch (num)
			{
			case 2:
			{
				Delegate obj4 = (Delegate)ToLua.CheckObject(L, 2, typeof(Predicate<>).MakeGenericType(ArgType));
				int n3 = (int)LuaMethodCache.CallMethod("FindLastIndex", obj, obj4);
				LuaDLL.lua_pushinteger(L, n3);
				return 1;
			}
			case 3:
			{
				int num4 = (int)LuaDLL.luaL_checknumber(L, 2);
				Delegate obj3 = (Delegate)ToLua.CheckObject(L, 3, typeof(Predicate<>).MakeGenericType(ArgType));
				int n2 = (int)LuaMethodCache.CallMethod("FindLastIndex", obj, num4, obj3);
				LuaDLL.lua_pushinteger(L, n2);
				return 1;
			}
			case 4:
			{
				int num2 = (int)LuaDLL.luaL_checknumber(L, 2);
				int num3 = (int)LuaDLL.luaL_checknumber(L, 3);
				Delegate obj2 = (Delegate)ToLua.CheckObject(L, 4, typeof(Predicate<>).MakeGenericType(ArgType));
				int n = (int)LuaMethodCache.CallMethod("FindLastIndex", obj, num2, num3, obj2);
				LuaDLL.lua_pushinteger(L, n);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, $"invalid arguments to method: List<{LuaMisc.GetTypeName(ArgType)}>.FindLastIndex");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ForEach(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Type ArgType = null;
			object obj = ToLua.CheckGenericObject(L, 1, typeof(List<>), out ArgType);
			Delegate obj2 = ToLua.CheckDelegate(typeof(Action<>).MakeGenericType(ArgType), L, 2);
			LuaMethodCache.CallSingleMethod("ForEach", obj, obj2);
			return 0;
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
			object obj = ToLua.CheckGenericObject(L, 1, typeof(List<>));
			IEnumerator iter = LuaMethodCache.CallSingleMethod("GetEnumerator", obj) as IEnumerator;
			ToLua.Push(L, iter);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetRange(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			object obj = ToLua.CheckGenericObject(L, 1, typeof(List<>));
			int num = (int)LuaDLL.luaL_checknumber(L, 2);
			int num2 = (int)LuaDLL.luaL_checknumber(L, 3);
			object o = LuaMethodCache.CallSingleMethod("GetRange", obj, num, num2);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IndexOf(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			Type ArgType = null;
			object obj = ToLua.CheckGenericObject(L, 1, typeof(List<>), out ArgType);
			switch (num)
			{
			case 2:
			{
				object obj4 = ToLua.CheckVarObject(L, 2, ArgType);
				int n3 = (int)LuaMethodCache.CallMethod("IndexOf", obj, obj4);
				LuaDLL.lua_pushinteger(L, n3);
				return 1;
			}
			case 3:
			{
				object obj3 = ToLua.CheckVarObject(L, 2, ArgType);
				int num4 = (int)LuaDLL.luaL_checknumber(L, 3);
				int n2 = (int)LuaMethodCache.CallMethod("IndexOf", obj, obj3, num4);
				LuaDLL.lua_pushinteger(L, n2);
				return 1;
			}
			case 4:
			{
				object obj2 = ToLua.CheckVarObject(L, 2, ArgType);
				int num2 = (int)LuaDLL.luaL_checknumber(L, 3);
				int num3 = (int)LuaDLL.luaL_checknumber(L, 4);
				int n = (int)LuaMethodCache.CallMethod("IndexOf", obj, obj2, num2, num3);
				LuaDLL.lua_pushinteger(L, n);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, $"invalid arguments to method: List<{LuaMisc.GetTypeName(ArgType)}>.IndexOf");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Insert(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Type ArgType = null;
			object obj = ToLua.CheckGenericObject(L, 1, typeof(List<>), out ArgType);
			int num = (int)LuaDLL.luaL_checknumber(L, 2);
			object obj2 = ToLua.CheckVarObject(L, 3, ArgType);
			LuaMethodCache.CallSingleMethod("Insert", obj, num, obj2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InsertRange(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Type ArgType = null;
			object obj = ToLua.CheckGenericObject(L, 1, typeof(List<>), out ArgType);
			int num = (int)LuaDLL.luaL_checknumber(L, 2);
			IEnumerable enumerable = (IEnumerable)ToLua.CheckObject(L, 3, typeof(IEnumerable<>).MakeGenericType(ArgType));
			LuaMethodCache.CallSingleMethod("InsertRange", obj, num, enumerable);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LastIndexOf(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			Type ArgType = null;
			object obj = ToLua.CheckGenericObject(L, 1, typeof(List<>), out ArgType);
			switch (num)
			{
			case 2:
			{
				object obj4 = ToLua.CheckVarObject(L, 2, ArgType);
				int n3 = (int)LuaMethodCache.CallMethod("LastIndexOf", obj, obj4);
				LuaDLL.lua_pushinteger(L, n3);
				return 1;
			}
			case 3:
			{
				object obj3 = ToLua.CheckVarObject(L, 2, ArgType);
				int num4 = (int)LuaDLL.luaL_checknumber(L, 3);
				int n2 = (int)LuaMethodCache.CallMethod("LastIndexOf", obj, obj3, num4);
				LuaDLL.lua_pushinteger(L, n2);
				return 1;
			}
			case 4:
			{
				object obj2 = ToLua.CheckVarObject(L, 2, ArgType);
				int num2 = (int)LuaDLL.luaL_checknumber(L, 3);
				int num3 = (int)LuaDLL.luaL_checknumber(L, 4);
				int n = (int)LuaMethodCache.CallMethod("LastIndexOf", obj, obj2, num2, num3);
				LuaDLL.lua_pushinteger(L, n);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, $"invalid arguments to method: List<{LuaMisc.GetTypeName(ArgType)}>.LastIndexOf");
			}
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
			Type ArgType = null;
			object obj = ToLua.CheckGenericObject(L, 1, typeof(List<>), out ArgType);
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
	private static int RemoveAll(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Type ArgType = null;
			object obj = ToLua.CheckGenericObject(L, 1, typeof(List<>), out ArgType);
			Delegate obj2 = ToLua.CheckDelegate(typeof(Predicate<>).MakeGenericType(ArgType), L, 2);
			int n = (int)LuaMethodCache.CallSingleMethod("RemoveAll", obj, obj2);
			LuaDLL.lua_pushinteger(L, n);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RemoveAt(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			object obj = ToLua.CheckGenericObject(L, 1, typeof(List<>));
			int num = (int)LuaDLL.luaL_checknumber(L, 2);
			LuaMethodCache.CallSingleMethod("RemoveAt", obj, num);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RemoveRange(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			object obj = ToLua.CheckGenericObject(L, 1, typeof(List<>));
			int num = (int)LuaDLL.luaL_checknumber(L, 2);
			int num2 = (int)LuaDLL.luaL_checknumber(L, 3);
			LuaMethodCache.CallSingleMethod("RemoveRange", obj, num, num2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Reverse(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			Type ArgType = null;
			object obj = ToLua.CheckGenericObject(L, 1, typeof(List<>), out ArgType);
			switch (num)
			{
			case 1:
				LuaMethodCache.CallMethod("Reverse", obj);
				return 0;
			case 3:
			{
				int num2 = (int)LuaDLL.luaL_checknumber(L, 2);
				int num3 = (int)LuaDLL.luaL_checknumber(L, 3);
				LuaMethodCache.CallMethod("Reverse", obj, num2, num3);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, $"invalid arguments to method: List<{LuaMisc.GetTypeName(ArgType)}>.LastIndexOf");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Sort(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			Type ArgType = null;
			object obj = ToLua.CheckGenericObject(L, 1, typeof(List<>), out ArgType);
			switch (num)
			{
			case 1:
				LuaMethodCache.CallMethod("Sort", obj);
				return 0;
			case 2:
				if (TypeChecker.CheckTypes(L, 2, typeof(Comparison<>).MakeGenericType(ArgType)))
				{
					Delegate obj2 = (Delegate)ToLua.ToObject(L, 2);
					LuaMethodCache.CallMethod("Sort", obj, obj2);
					return 0;
				}
				break;
			}
			if (num == 2 && TypeChecker.CheckTypes(L, 2, typeof(IComparer<>).MakeGenericType(ArgType)))
			{
				object obj3 = ToLua.ToObject(L, 2);
				LuaMethodCache.CallMethod("Sort", obj, obj3);
				return 0;
			}
			if (num == 4)
			{
				int num2 = (int)LuaDLL.luaL_checknumber(L, 2);
				int num3 = (int)LuaDLL.luaL_checknumber(L, 3);
				object obj4 = ToLua.CheckObject(L, 4, typeof(IComparer<>).MakeGenericType(ArgType));
				LuaMethodCache.CallMethod("Sort", obj, num2, num3, obj4);
				return 0;
			}
			return LuaDLL.luaL_throw(L, $"invalid arguments to method: List<{LuaMisc.GetTypeName(ArgType)}>.LastIndexOf");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ToArray(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			object obj = ToLua.CheckGenericObject(L, 1, typeof(List<>));
			Array array = (Array)LuaMethodCache.CallSingleMethod("ToArray", obj);
			ToLua.Push(L, array);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int TrimExcess(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			object obj = ToLua.CheckGenericObject(L, 1, typeof(List<>));
			LuaMethodCache.CallSingleMethod("TrimExcess", obj);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int TrueForAll(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Type ArgType = null;
			object obj = ToLua.CheckGenericObject(L, 1, typeof(List<>), out ArgType);
			Delegate obj2 = ToLua.CheckDelegate(typeof(Predicate<>).MakeGenericType(ArgType), L, 2);
			bool value = (bool)LuaMethodCache.CallSingleMethod("TrueForAll", obj, obj2);
			LuaDLL.lua_pushboolean(L, value);
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
			object obj = ToLua.CheckGenericObject(L, 1, typeof(List<>));
			int num = (int)LuaDLL.luaL_checknumber(L, 2);
			object obj2 = LuaMethodCache.CallSingleMethod("get_Item", obj, num);
			ToLua.Push(L, obj2);
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
			Type ArgType = null;
			object obj = ToLua.CheckGenericObject(L, 1, typeof(List<>), out ArgType);
			int num = (int)LuaDLL.luaL_checknumber(L, 2);
			object obj2 = ToLua.CheckObject(L, 3, ArgType);
			LuaMethodCache.CallSingleMethod("set_Item", obj, num, obj2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Capacity(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int n = (int)LuaMethodCache.CallSingleMethod("get_Capacity", obj);
			LuaDLL.lua_pushinteger(L, n);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Capacity on a nil value");
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
	private static int set_Capacity(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int num = (int)LuaDLL.luaL_checknumber(L, 2);
			LuaMethodCache.CallSingleMethod("set_Capacity", obj, num);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Capacity on a nil value");
		}
	}
}
