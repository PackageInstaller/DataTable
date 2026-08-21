using System;
using I18N;
using LuaInterface;
using UnityEngine;
using UnityEngine.UI;

public class I18N_I18NTextKeyToValueWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(I18NTextKeyToValue), typeof(MonoBehaviour));
		L.RegFunction("InitGuid", InitGuid);
		L.RegFunction("InitText", InitText);
		L.RegFunction("InitTextComponent", InitTextComponent);
		L.RegFunction("RefreshText", RefreshText);
		L.RegFunction("GetText", GetText);
		L.RegFunction("SetI18NKey", SetI18NKey);
		L.RegFunction("GetI18NKey", GetI18NKey);
		L.RegFunction("SetFontPath", SetFontPath);
		L.RegFunction("GetFontPath", GetFontPath);
		L.RegFunction("RefreshFont", RefreshFont);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("originI18NKey", get_originI18NKey, set_originI18NKey);
		L.RegVar("guid", get_guid, null);
		L.RegVar("needAutoTranslate", get_needAutoTranslate, set_needAutoTranslate);
		L.RegVar("disableAutoSpecialBestFit", get_disableAutoSpecialBestFit, set_disableAutoSpecialBestFit);
		L.RegVar("specialBestFit", get_specialBestFit, set_specialBestFit);
		L.RegVar("textCom", get_textCom, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InitGuid(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((I18NTextKeyToValue)ToLua.CheckObject<I18NTextKeyToValue>(L, 1)).InitGuid();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InitText(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				((I18NTextKeyToValue)ToLua.CheckObject<I18NTextKeyToValue>(L, 1)).InitText();
				return 0;
			case 2:
			{
				I18NTextKeyToValue obj = (I18NTextKeyToValue)ToLua.CheckObject<I18NTextKeyToValue>(L, 1);
				bool isNeedRefreshFont = LuaDLL.luaL_checkboolean(L, 2);
				obj.InitText(isNeedRefreshFont);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: I18N.I18NTextKeyToValue.InitText");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InitTextComponent(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((I18NTextKeyToValue)ToLua.CheckObject<I18NTextKeyToValue>(L, 1)).InitTextComponent();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RefreshText(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				I18NTextKeyToValue obj2 = (I18NTextKeyToValue)ToLua.CheckObject<I18NTextKeyToValue>(L, 1);
				string i18NKey2 = ToLua.CheckString(L, 2);
				obj2.RefreshText(i18NKey2);
				return 0;
			}
			case 3:
			{
				I18NTextKeyToValue obj = (I18NTextKeyToValue)ToLua.CheckObject<I18NTextKeyToValue>(L, 1);
				string i18NKey = ToLua.CheckString(L, 2);
				bool isReWrite = LuaDLL.luaL_checkboolean(L, 3);
				obj.RefreshText(i18NKey, isReWrite);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: I18N.I18NTextKeyToValue.RefreshText");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetText(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string text = ((I18NTextKeyToValue)ToLua.CheckObject<I18NTextKeyToValue>(L, 1)).GetText();
			LuaDLL.lua_pushstring(L, text);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetI18NKey(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			I18NTextKeyToValue obj = (I18NTextKeyToValue)ToLua.CheckObject<I18NTextKeyToValue>(L, 1);
			string i18NKey = ToLua.CheckString(L, 2);
			obj.SetI18NKey(i18NKey);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetI18NKey(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string i18NKey = ((I18NTextKeyToValue)ToLua.CheckObject<I18NTextKeyToValue>(L, 1)).GetI18NKey();
			LuaDLL.lua_pushstring(L, i18NKey);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetFontPath(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			I18NTextKeyToValue obj = (I18NTextKeyToValue)ToLua.CheckObject<I18NTextKeyToValue>(L, 1);
			string fontPath = ToLua.CheckString(L, 2);
			bool value = obj.SetFontPath(fontPath);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetFontPath(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string fontPath = ((I18NTextKeyToValue)ToLua.CheckObject<I18NTextKeyToValue>(L, 1)).GetFontPath();
			LuaDLL.lua_pushstring(L, fontPath);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RefreshFont(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((I18NTextKeyToValue)ToLua.CheckObject<I18NTextKeyToValue>(L, 1)).RefreshFont();
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
	private static int get_originI18NKey(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string originI18NKey = ((I18NTextKeyToValue)obj).originI18NKey;
			LuaDLL.lua_pushstring(L, originI18NKey);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index originI18NKey on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_guid(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string guid = ((I18NTextKeyToValue)obj).guid;
			LuaDLL.lua_pushstring(L, guid);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index guid on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_needAutoTranslate(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool needAutoTranslate = ((I18NTextKeyToValue)obj).needAutoTranslate;
			LuaDLL.lua_pushboolean(L, needAutoTranslate);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index needAutoTranslate on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_disableAutoSpecialBestFit(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool disableAutoSpecialBestFit = ((I18NTextKeyToValue)obj).disableAutoSpecialBestFit;
			LuaDLL.lua_pushboolean(L, disableAutoSpecialBestFit);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index disableAutoSpecialBestFit on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_specialBestFit(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool specialBestFit = ((I18NTextKeyToValue)obj).specialBestFit;
			LuaDLL.lua_pushboolean(L, specialBestFit);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index specialBestFit on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_textCom(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Text textCom = ((I18NTextKeyToValue)obj).textCom;
			ToLua.Push(L, textCom);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index textCom on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_originI18NKey(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			I18NTextKeyToValue obj2 = (I18NTextKeyToValue)obj;
			string originI18NKey = ToLua.CheckString(L, 2);
			obj2.originI18NKey = originI18NKey;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index originI18NKey on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_needAutoTranslate(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			I18NTextKeyToValue obj2 = (I18NTextKeyToValue)obj;
			bool needAutoTranslate = LuaDLL.luaL_checkboolean(L, 2);
			obj2.needAutoTranslate = needAutoTranslate;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index needAutoTranslate on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_disableAutoSpecialBestFit(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			I18NTextKeyToValue obj2 = (I18NTextKeyToValue)obj;
			bool disableAutoSpecialBestFit = LuaDLL.luaL_checkboolean(L, 2);
			obj2.disableAutoSpecialBestFit = disableAutoSpecialBestFit;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index disableAutoSpecialBestFit on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_specialBestFit(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			I18NTextKeyToValue obj2 = (I18NTextKeyToValue)obj;
			bool specialBestFit = LuaDLL.luaL_checkboolean(L, 2);
			obj2.specialBestFit = specialBestFit;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index specialBestFit on a nil value");
		}
	}
}
