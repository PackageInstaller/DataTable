using System;
using LuaInterface;
using UnityEngine;

public class TextTypeWriteWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(TextTypeWrite), typeof(MonoBehaviour));
		L.RegFunction("StartTyping", StartTyping);
		L.RegFunction("ClearLinePrefixSymbol", ClearLinePrefixSymbol);
		L.RegFunction("isTypeing", isTypeing);
		L.RegFunction("ShowAllText", ShowAllText);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("velocity", get_velocity, set_velocity);
		L.RegVar("textToShow", get_textToShow, set_textToShow);
		L.RegVar("finishDelegate", get_finishDelegate, set_finishDelegate);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StartTyping(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				TextTypeWrite obj2 = (TextTypeWrite)ToLua.CheckObject<TextTypeWrite>(L, 1);
				string text2 = ToLua.CheckString(L, 2);
				obj2.StartTyping(text2);
				return 0;
			}
			case 3:
			{
				TextTypeWrite obj = (TextTypeWrite)ToLua.CheckObject<TextTypeWrite>(L, 1);
				string text = ToLua.CheckString(L, 2);
				Action callBack = (Action)ToLua.CheckDelegate<Action>(L, 3);
				obj.StartTyping(text, callBack);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: TextTypeWrite.StartTyping");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearLinePrefixSymbol(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((TextTypeWrite)ToLua.CheckObject<TextTypeWrite>(L, 1)).ClearLinePrefixSymbol();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int isTypeing(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((TextTypeWrite)ToLua.CheckObject<TextTypeWrite>(L, 1)).isTypeing();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ShowAllText(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((TextTypeWrite)ToLua.CheckObject<TextTypeWrite>(L, 1)).ShowAllText();
			return 0;
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
	private static int get_velocity(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float velocity = ((TextTypeWrite)obj).velocity;
			LuaDLL.lua_pushnumber(L, velocity);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index velocity on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_textToShow(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string textToShow = ((TextTypeWrite)obj).textToShow;
			LuaDLL.lua_pushstring(L, textToShow);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index textToShow on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_finishDelegate(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Action finishDelegate = ((TextTypeWrite)obj).finishDelegate;
			ToLua.Push(L, finishDelegate);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index finishDelegate on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_velocity(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TextTypeWrite obj2 = (TextTypeWrite)obj;
			float velocity = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.velocity = velocity;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index velocity on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_textToShow(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TextTypeWrite obj2 = (TextTypeWrite)obj;
			string textToShow = ToLua.CheckString(L, 2);
			obj2.textToShow = textToShow;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index textToShow on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_finishDelegate(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TextTypeWrite obj2 = (TextTypeWrite)obj;
			Action finishDelegate = (Action)ToLua.CheckDelegate<Action>(L, 2);
			obj2.finishDelegate = finishDelegate;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index finishDelegate on a nil value");
		}
	}
}
