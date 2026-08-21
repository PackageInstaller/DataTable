using System;
using LuaInterface;
using UnityEngine;

public class DormItemTagWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(DormItemTag), typeof(DormTagBase));
		L.RegFunction("Equals", Equals);
		L.RegFunction("GetHashCode", GetHashCode);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("entityID", get_entityID, set_entityID);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Equals(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<DormItemTag>(L, 2))
			{
				DormItemTag dormItemTag = (DormItemTag)ToLua.CheckObject<DormItemTag>(L, 1);
				DormItemTag dormItemTag2 = (DormItemTag)ToLua.ToObject(L, 2);
				bool value = ((dormItemTag != null) ? dormItemTag.Equals(dormItemTag2) : (dormItemTag2 == null));
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<object>(L, 2))
			{
				DormItemTag dormItemTag3 = (DormItemTag)ToLua.CheckObject<DormItemTag>(L, 1);
				object obj = ToLua.ToVarObject(L, 2);
				bool value2 = ((dormItemTag3 != null) ? dormItemTag3.Equals(obj) : (obj == null));
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: DormItemTag.Equals");
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
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				int hashCode2 = ((DormItemTag)ToLua.CheckObject<DormItemTag>(L, 1)).GetHashCode();
				LuaDLL.lua_pushinteger(L, hashCode2);
				return 1;
			}
			case 2:
			{
				DormItemTag obj = (DormItemTag)ToLua.CheckObject<DormItemTag>(L, 1);
				DormItemTag obj2 = (DormItemTag)ToLua.CheckObject<DormItemTag>(L, 2);
				int hashCode = obj.GetHashCode(obj2);
				LuaDLL.lua_pushinteger(L, hashCode);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: DormItemTag.GetHashCode");
			}
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
			UnityEngine.Object obj = (UnityEngine.Object)ToLua.ToObject(L, 1);
			UnityEngine.Object obj2 = (UnityEngine.Object)ToLua.ToObject(L, 2);
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
	private static int get_entityID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int entityID = ((DormItemTag)obj).entityID;
			LuaDLL.lua_pushinteger(L, entityID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index entityID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_entityID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			DormItemTag obj2 = (DormItemTag)obj;
			int entityID = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.entityID = entityID;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index entityID on a nil value");
		}
	}
}
