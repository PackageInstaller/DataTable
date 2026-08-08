using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.UI;

public class EmojiTextWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(EmojiText), typeof(MonoBehaviour));
		L.RegFunction("SetText", SetText);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("onProcessComplete", get_onProcessComplete, set_onProcessComplete);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetText(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			EmojiText obj = (EmojiText)ToLua.CheckObject<EmojiText>(L, 1);
			Text textToEdit = (Text)ToLua.CheckObject<Text>(L, 2);
			string inputString = ToLua.CheckString(L, 3);
			obj.SetText(textToEdit, inputString);
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
	private static int get_onProcessComplete(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Action<Image, string> onProcessComplete = ((EmojiText)obj).onProcessComplete;
			ToLua.Push(L, onProcessComplete);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onProcessComplete on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_onProcessComplete(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			EmojiText obj2 = (EmojiText)obj;
			Action<Image, string> onProcessComplete = (Action<Image, string>)ToLua.CheckDelegate<Action<Image, string>>(L, 2);
			obj2.onProcessComplete = onProcessComplete;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onProcessComplete on a nil value");
		}
	}
}
