using System;
using LuaInterface;

public class System_ObjectWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(object), null);
		L.RegFunction("Equals", Equals);
		L.RegFunction("GetHashCode", GetHashCode);
		L.RegFunction("GetType", GetType);
		L.RegFunction("ToString", ToString);
		L.RegFunction("ReferenceEquals", ReferenceEquals);
		L.RegFunction("Destroy", Destroy);
		L.RegFunction("New", _CreateSystem_Object);
		L.RegFunction("__eq", op_Equality);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateSystem_Object(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				object obj = new object();
				ToLua.Push(L, obj);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: System.Object.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Equals(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			object obj = ToLua.CheckObject(L, 1);
			object obj2 = ToLua.ToVarObject(L, 2);
			bool value = obj?.Equals(obj2) ?? (obj2 == null);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetHashCode(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int hashCode = ToLua.CheckObject(L, 1).GetHashCode();
			LuaDLL.lua_pushinteger(L, hashCode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetType(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Type type = ToLua.CheckObject(L, 1).GetType();
			ToLua.Push(L, type);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ToString(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string str = ToLua.CheckObject(L, 1).ToString();
			LuaDLL.lua_pushstring(L, str);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ReferenceEquals(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			object obj = ToLua.ToVarObject(L, 1);
			object obj2 = ToLua.ToVarObject(L, 2);
			bool value = obj == obj2;
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int op_Equality(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			object obj = ToLua.ToVarObject(L, 1);
			object obj2 = ToLua.ToVarObject(L, 2);
			bool value = obj == obj2;
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Destroy(IntPtr L)
	{
		return ToLua.Destroy(L);
	}
}
