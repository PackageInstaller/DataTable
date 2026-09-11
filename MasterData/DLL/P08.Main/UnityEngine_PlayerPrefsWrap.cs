using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_PlayerPrefsWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(PlayerPrefs), typeof(object));
		L.RegFunction("SetInt", SetInt);
		L.RegFunction("GetInt", GetInt);
		L.RegFunction("SetFloat", SetFloat);
		L.RegFunction("GetFloat", GetFloat);
		L.RegFunction("SetString", SetString);
		L.RegFunction("GetString", GetString);
		L.RegFunction("HasKey", HasKey);
		L.RegFunction("DeleteKey", DeleteKey);
		L.RegFunction("DeleteAll", DeleteAll);
		L.RegFunction("Save", Save);
		L.RegFunction("New", _CreateUnityEngine_PlayerPrefs);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_PlayerPrefs(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				PlayerPrefs o = new PlayerPrefs();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.PlayerPrefs.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetInt(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			string key = ToLua.CheckString(L, 1);
			int value = (int)LuaDLL.luaL_checknumber(L, 2);
			PlayerPrefs.SetInt(key, value);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetInt(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				int n2 = PlayerPrefs.GetInt(ToLua.CheckString(L, 1));
				LuaDLL.lua_pushinteger(L, n2);
				return 1;
			}
			case 2:
			{
				string key = ToLua.CheckString(L, 1);
				int defaultValue = (int)LuaDLL.luaL_checknumber(L, 2);
				int n = PlayerPrefs.GetInt(key, defaultValue);
				LuaDLL.lua_pushinteger(L, n);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.PlayerPrefs.GetInt");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetFloat(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			string key = ToLua.CheckString(L, 1);
			float value = (float)LuaDLL.luaL_checknumber(L, 2);
			PlayerPrefs.SetFloat(key, value);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetFloat(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				float num2 = PlayerPrefs.GetFloat(ToLua.CheckString(L, 1));
				LuaDLL.lua_pushnumber(L, num2);
				return 1;
			}
			case 2:
			{
				string key = ToLua.CheckString(L, 1);
				float defaultValue = (float)LuaDLL.luaL_checknumber(L, 2);
				float num = PlayerPrefs.GetFloat(key, defaultValue);
				LuaDLL.lua_pushnumber(L, num);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.PlayerPrefs.GetFloat");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetString(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			string key = ToLua.CheckString(L, 1);
			string value = ToLua.CheckString(L, 2);
			PlayerPrefs.SetString(key, value);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetString(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				string str2 = PlayerPrefs.GetString(ToLua.CheckString(L, 1));
				LuaDLL.lua_pushstring(L, str2);
				return 1;
			}
			case 2:
			{
				string key = ToLua.CheckString(L, 1);
				string defaultValue = ToLua.CheckString(L, 2);
				string str = PlayerPrefs.GetString(key, defaultValue);
				LuaDLL.lua_pushstring(L, str);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.PlayerPrefs.GetString");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int HasKey(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = PlayerPrefs.HasKey(ToLua.CheckString(L, 1));
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DeleteKey(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			PlayerPrefs.DeleteKey(ToLua.CheckString(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DeleteAll(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			PlayerPrefs.DeleteAll();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Save(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			PlayerPrefs.Save();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
