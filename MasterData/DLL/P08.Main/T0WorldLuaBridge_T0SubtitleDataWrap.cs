using System;
using LuaInterface;

public class T0WorldLuaBridge_T0SubtitleDataWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(T0WorldLuaBridge.T0SubtitleData), typeof(object));
		L.RegFunction("IsWaiting", IsWaiting);
		L.RegFunction("IsShow", IsShow);
		L.RegFunction("OnEndDisplay", OnEndDisplay);
		L.RegFunction("OnDispose", OnDispose);
		L.RegFunction("GetKey", GetKey);
		L.RegFunction("GetContent", GetContent);
		L.RegFunction("New", _CreateT0WorldLuaBridge_T0SubtitleData);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("formID", get_formID, set_formID);
		L.RegVar("file", get_file, set_file);
		L.RegVar("wait", get_wait, set_wait);
		L.RegVar("show", get_show, set_show);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateT0WorldLuaBridge_T0SubtitleData(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				T0WorldLuaBridge.T0SubtitleData o = new T0WorldLuaBridge.T0SubtitleData();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: T0WorldLuaBridge.T0SubtitleData.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsWaiting(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((T0WorldLuaBridge.T0SubtitleData)ToLua.CheckObject<T0WorldLuaBridge.T0SubtitleData>(L, 1)).IsWaiting();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsShow(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((T0WorldLuaBridge.T0SubtitleData)ToLua.CheckObject<T0WorldLuaBridge.T0SubtitleData>(L, 1)).IsShow();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnEndDisplay(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((T0WorldLuaBridge.T0SubtitleData)ToLua.CheckObject<T0WorldLuaBridge.T0SubtitleData>(L, 1)).OnEndDisplay();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnDispose(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((T0WorldLuaBridge.T0SubtitleData)ToLua.CheckObject<T0WorldLuaBridge.T0SubtitleData>(L, 1)).OnDispose();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetKey(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string key = ((T0WorldLuaBridge.T0SubtitleData)ToLua.CheckObject<T0WorldLuaBridge.T0SubtitleData>(L, 1)).GetKey();
			LuaDLL.lua_pushstring(L, key);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetContent(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string content = ((T0WorldLuaBridge.T0SubtitleData)ToLua.CheckObject<T0WorldLuaBridge.T0SubtitleData>(L, 1)).GetContent();
			LuaDLL.lua_pushstring(L, content);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_formID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int formID = ((T0WorldLuaBridge.T0SubtitleData)obj).formID;
			LuaDLL.lua_pushinteger(L, formID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index formID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_file(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string file = ((T0WorldLuaBridge.T0SubtitleData)obj).file;
			LuaDLL.lua_pushstring(L, file);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index file on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_wait(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool wait = ((T0WorldLuaBridge.T0SubtitleData)obj).wait;
			LuaDLL.lua_pushboolean(L, wait);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wait on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_show(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool show = ((T0WorldLuaBridge.T0SubtitleData)obj).show;
			LuaDLL.lua_pushboolean(L, show);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index show on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_formID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			T0WorldLuaBridge.T0SubtitleData obj2 = (T0WorldLuaBridge.T0SubtitleData)obj;
			int formID = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.formID = formID;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index formID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_file(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			T0WorldLuaBridge.T0SubtitleData obj2 = (T0WorldLuaBridge.T0SubtitleData)obj;
			string file = ToLua.CheckString(L, 2);
			obj2.file = file;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index file on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_wait(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			T0WorldLuaBridge.T0SubtitleData obj2 = (T0WorldLuaBridge.T0SubtitleData)obj;
			bool wait = LuaDLL.luaL_checkboolean(L, 2);
			obj2.wait = wait;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wait on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_show(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			T0WorldLuaBridge.T0SubtitleData obj2 = (T0WorldLuaBridge.T0SubtitleData)obj;
			bool show = LuaDLL.luaL_checkboolean(L, 2);
			obj2.show = show;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index show on a nil value");
		}
	}
}
