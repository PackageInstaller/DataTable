using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;

public class BattleUIAdapterWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(BattleUIAdapter), typeof(MonoBehaviour));
		L.RegFunction("DecodeData", DecodeData);
		L.RegFunction("Set", Set);
		L.RegFunction("SetData", SetData);
		L.RegFunction("Save", Save);
		L.RegFunction("ResetToDefault", ResetToDefault);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("listToChange", get_listToChange, set_listToChange);
		L.RegVar("m_alphaList", get_m_alphaList, set_m_alphaList);
		L.RegVar("m_alphaValue", get_m_alphaValue, set_m_alphaValue);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DecodeData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			BattleUIAdapter obj = (BattleUIAdapter)ToLua.CheckObject<BattleUIAdapter>(L, 1);
			string s = ToLua.CheckString(L, 2);
			BattleUIAdapterData o = obj.DecodeData(s);
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Set(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			BattleUIAdapter obj = (BattleUIAdapter)ToLua.CheckObject<BattleUIAdapter>(L, 1);
			string s = ToLua.CheckString(L, 2);
			float alpha = (float)LuaDLL.luaL_checknumber(L, 3);
			obj.Set(s, alpha);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			BattleUIAdapter obj = (BattleUIAdapter)ToLua.CheckObject<BattleUIAdapter>(L, 1);
			BattleUIAdapterData adapterData = (BattleUIAdapterData)ToLua.CheckObject<BattleUIAdapterData>(L, 2);
			float alpha = (float)LuaDLL.luaL_checknumber(L, 3);
			obj.SetData(adapterData, alpha);
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
			ToLua.CheckArgsCount(L, 1);
			string str = ((BattleUIAdapter)ToLua.CheckObject<BattleUIAdapter>(L, 1)).Save();
			LuaDLL.lua_pushstring(L, str);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ResetToDefault(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((BattleUIAdapter)ToLua.CheckObject<BattleUIAdapter>(L, 1)).ResetToDefault();
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
	private static int get_listToChange(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<string> listToChange = ((BattleUIAdapter)obj).listToChange;
			ToLua.PushSealed(L, listToChange);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index listToChange on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_m_alphaList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<string> alphaList = ((BattleUIAdapter)obj).m_alphaList;
			ToLua.PushSealed(L, alphaList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_alphaList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_m_alphaValue(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float alphaValue = ((BattleUIAdapter)obj).m_alphaValue;
			LuaDLL.lua_pushnumber(L, alphaValue);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_alphaValue on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_listToChange(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BattleUIAdapter obj2 = (BattleUIAdapter)obj;
			List<string> listToChange = (List<string>)ToLua.CheckObject(L, 2, typeof(List<string>));
			obj2.listToChange = listToChange;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index listToChange on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_m_alphaList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BattleUIAdapter obj2 = (BattleUIAdapter)obj;
			List<string> alphaList = (List<string>)ToLua.CheckObject(L, 2, typeof(List<string>));
			obj2.m_alphaList = alphaList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_alphaList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_m_alphaValue(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			BattleUIAdapter obj2 = (BattleUIAdapter)obj;
			float alphaValue = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.m_alphaValue = alphaValue;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_alphaValue on a nil value");
		}
	}
}
