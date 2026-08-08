using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_ScriptableObjectWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(ScriptableObject), typeof(UnityEngine.Object));
		L.RegFunction("CreateInstance", CreateInstance);
		L.RegFunction("New", _CreateUnityEngine_ScriptableObject);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_ScriptableObject(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				ScriptableObject obj = new ScriptableObject();
				ToLua.Push(L, obj);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.ScriptableObject.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CreateInstance(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 1 && TypeChecker.CheckTypes<string>(L, 1))
			{
				ScriptableObject obj = ScriptableObject.CreateInstance(ToLua.ToString(L, 1));
				ToLua.Push(L, obj);
				return 1;
			}
			if (num == 1 && TypeChecker.CheckTypes<Type>(L, 1))
			{
				ScriptableObject obj2 = ScriptableObject.CreateInstance((Type)ToLua.ToObject(L, 1));
				ToLua.Push(L, obj2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.ScriptableObject.CreateInstance");
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
}
