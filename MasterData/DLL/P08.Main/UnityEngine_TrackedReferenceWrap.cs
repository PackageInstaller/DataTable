using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_TrackedReferenceWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(TrackedReference), typeof(object));
		L.RegFunction("Equals", Equals);
		L.RegFunction("GetHashCode", GetHashCode);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int op_Equality(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			TrackedReference obj = (TrackedReference)ToLua.ToObject(L, 1);
			TrackedReference trackedReference = (TrackedReference)ToLua.ToObject(L, 2);
			bool value = obj == trackedReference;
			LuaDLL.lua_pushboolean(L, value);
			return 1;
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
			TrackedReference trackedReference = (TrackedReference)ToLua.CheckObject<TrackedReference>(L, 1);
			object obj = ToLua.ToVarObject(L, 2);
			bool value = ((trackedReference != null) ? trackedReference.Equals(obj) : (obj == null));
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
			int hashCode = ((TrackedReference)ToLua.CheckObject<TrackedReference>(L, 1)).GetHashCode();
			LuaDLL.lua_pushinteger(L, hashCode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
