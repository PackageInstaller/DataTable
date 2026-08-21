using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine.UI;

public class UnityEngine_UI_Dropdown_OptionDataListWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Dropdown.OptionDataList), typeof(object));
		L.RegFunction("New", _CreateUnityEngine_UI_Dropdown_OptionDataList);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("options", get_options, set_options);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_UI_Dropdown_OptionDataList(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				Dropdown.OptionDataList o = new Dropdown.OptionDataList();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.UI.Dropdown.OptionDataList.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_options(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<Dropdown.OptionData> options = ((Dropdown.OptionDataList)obj).options;
			ToLua.PushSealed(L, options);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index options on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_options(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Dropdown.OptionDataList obj2 = (Dropdown.OptionDataList)obj;
			List<Dropdown.OptionData> options = (List<Dropdown.OptionData>)ToLua.CheckObject(L, 2, typeof(List<Dropdown.OptionData>));
			obj2.options = options;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index options on a nil value");
		}
	}
}
