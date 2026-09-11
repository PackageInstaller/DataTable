using System;
using LuaInterface;

public class I18NRuntimeManagerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(I18NRuntimeManager), typeof(object));
		L.RegFunction("Init", Init);
		L.RegFunction("Clear", Clear);
		L.RegFunction("ClearTranslate", ClearTranslate);
		L.RegFunction("LoadDefaultLanguage", LoadDefaultLanguage);
		L.RegFunction("ChangeLanguage", ChangeLanguage);
		L.RegFunction("GetI18NText", GetI18NText);
		L.RegFunction("InitFileIdData", InitFileIdData);
		L.RegFunction("InitTranslateFile", InitTranslateFile);
		L.RegFunction("New", _CreateI18NRuntimeManager);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("Instance", get_Instance, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateI18NRuntimeManager(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				I18NRuntimeManager o = new I18NRuntimeManager();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: I18NRuntimeManager.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Init(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((I18NRuntimeManager)ToLua.CheckObject<I18NRuntimeManager>(L, 1)).Init();
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
			((I18NRuntimeManager)ToLua.CheckObject<I18NRuntimeManager>(L, 1)).Clear();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearTranslate(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((I18NRuntimeManager)ToLua.CheckObject<I18NRuntimeManager>(L, 1)).ClearTranslate();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LoadDefaultLanguage(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((I18NRuntimeManager)ToLua.CheckObject<I18NRuntimeManager>(L, 1)).LoadDefaultLanguage();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ChangeLanguage(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			I18NRuntimeManager obj = (I18NRuntimeManager)ToLua.CheckObject<I18NRuntimeManager>(L, 1);
			string languageKey = ToLua.CheckString(L, 2);
			obj.ChangeLanguage(languageKey);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetI18NText(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			I18NRuntimeManager obj = (I18NRuntimeManager)ToLua.CheckObject<I18NRuntimeManager>(L, 1);
			string i18nKey = ToLua.CheckString(L, 2);
			string i18NText = obj.GetI18NText(i18nKey);
			LuaDLL.lua_pushstring(L, i18NText);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InitFileIdData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((I18NRuntimeManager)ToLua.CheckObject<I18NRuntimeManager>(L, 1)).InitFileIdData();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InitTranslateFile(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			I18NRuntimeManager obj = (I18NRuntimeManager)ToLua.CheckObject<I18NRuntimeManager>(L, 1);
			string translateFileName = ToLua.CheckString(L, 2);
			obj.InitTranslateFile(translateFileName);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Instance(IntPtr L)
	{
		try
		{
			ToLua.PushObject(L, I18NRuntimeManager.Instance);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
