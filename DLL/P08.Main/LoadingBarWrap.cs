using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class LoadingBarWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(LoadingBar), typeof(UIBehaviour));
		L.RegFunction("SetProgress", SetProgress);
		L.RegFunction("SetDescription", SetDescription);
		L.RegFunction("Validate", Validate);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("slider", get_slider, set_slider);
		L.RegVar("progressTxt", get_progressTxt, set_progressTxt);
		L.RegVar("descriptTxt", get_descriptTxt, set_descriptTxt);
		L.RegVar("barType", get_barType, set_barType);
		L.RegVar("progressType", get_progressType, set_progressType);
		L.RegVar("isUseHangdler", get_isUseHangdler, set_isUseHangdler);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetProgress(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				LoadingBar obj2 = (LoadingBar)ToLua.CheckObject<LoadingBar>(L, 1);
				float value2 = (float)LuaDLL.luaL_checknumber(L, 2);
				obj2.SetProgress(value2);
				return 0;
			}
			case 3:
			{
				LoadingBar obj = (LoadingBar)ToLua.CheckObject<LoadingBar>(L, 1);
				float value = (float)LuaDLL.luaL_checknumber(L, 2);
				string str = ToLua.CheckString(L, 3);
				obj.SetProgress(value, str);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: LoadingBar.SetProgress");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetDescription(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				((LoadingBar)ToLua.CheckObject<LoadingBar>(L, 1)).SetDescription();
				return 0;
			case 2:
			{
				LoadingBar obj = (LoadingBar)ToLua.CheckObject<LoadingBar>(L, 1);
				string description = ToLua.CheckString(L, 2);
				obj.SetDescription(description);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: LoadingBar.SetDescription");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Validate(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((LoadingBar)ToLua.CheckObject<LoadingBar>(L, 1)).Validate();
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
	private static int get_slider(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Slider slider = ((LoadingBar)obj).slider;
			ToLua.Push(L, slider);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index slider on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_progressTxt(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Text progressTxt = ((LoadingBar)obj).progressTxt;
			ToLua.Push(L, progressTxt);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index progressTxt on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_descriptTxt(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Text descriptTxt = ((LoadingBar)obj).descriptTxt;
			ToLua.Push(L, descriptTxt);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index descriptTxt on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_barType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LoadingBar.BarType barType = ((LoadingBar)obj).barType;
			ToLua.Push(L, barType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index barType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_progressType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LoadingBar.ProgressType progressType = ((LoadingBar)obj).progressType;
			ToLua.Push(L, progressType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index progressType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isUseHangdler(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isUseHangdler = ((LoadingBar)obj).isUseHangdler;
			LuaDLL.lua_pushboolean(L, isUseHangdler);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isUseHangdler on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_slider(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LoadingBar obj2 = (LoadingBar)obj;
			Slider slider = (Slider)ToLua.CheckObject<Slider>(L, 2);
			obj2.slider = slider;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index slider on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_progressTxt(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LoadingBar obj2 = (LoadingBar)obj;
			Text progressTxt = (Text)ToLua.CheckObject<Text>(L, 2);
			obj2.progressTxt = progressTxt;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index progressTxt on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_descriptTxt(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LoadingBar obj2 = (LoadingBar)obj;
			Text descriptTxt = (Text)ToLua.CheckObject<Text>(L, 2);
			obj2.descriptTxt = descriptTxt;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index descriptTxt on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_barType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LoadingBar obj2 = (LoadingBar)obj;
			LoadingBar.BarType barType = (LoadingBar.BarType)ToLua.CheckObject(L, 2, typeof(LoadingBar.BarType));
			obj2.barType = barType;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index barType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_progressType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LoadingBar obj2 = (LoadingBar)obj;
			LoadingBar.ProgressType progressType = (LoadingBar.ProgressType)ToLua.CheckObject(L, 2, typeof(LoadingBar.ProgressType));
			obj2.progressType = progressType;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index progressType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isUseHangdler(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			LoadingBar obj2 = (LoadingBar)obj;
			bool isUseHangdler = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isUseHangdler = isUseHangdler;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isUseHangdler on a nil value");
		}
	}
}
