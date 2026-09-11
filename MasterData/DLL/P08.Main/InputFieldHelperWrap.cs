using System;
using LuaInterface;
using UnityEngine;

public class InputFieldHelperWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(InputFieldHelper), typeof(MonoBehaviour));
		L.RegFunction("TextLimit", TextLimit);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int TextLimit(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			InputFieldHelper obj = (InputFieldHelper)ToLua.CheckObject<InputFieldHelper>(L, 1);
			string text = ToLua.CheckString(L, 2);
			int num = (int)LuaDLL.luaL_checknumber(L, 3);
			string str = obj.TextLimit(text, num);
			LuaDLL.lua_pushstring(L, str);
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
