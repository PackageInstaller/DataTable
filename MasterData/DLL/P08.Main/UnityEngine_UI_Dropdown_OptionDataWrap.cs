using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.UI;

public class UnityEngine_UI_Dropdown_OptionDataWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Dropdown.OptionData), typeof(object));
		L.RegFunction("New", _CreateUnityEngine_UI_Dropdown_OptionData);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("text", get_text, set_text);
		L.RegVar("image", get_image, set_image);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_UI_Dropdown_OptionData(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			switch (num)
			{
			case 0:
			{
				Dropdown.OptionData o2 = new Dropdown.OptionData();
				ToLua.PushObject(L, o2);
				return 1;
			}
			case 1:
				if (TypeChecker.CheckTypes<Sprite>(L, 1))
				{
					Dropdown.OptionData o = new Dropdown.OptionData((Sprite)ToLua.ToObject(L, 1));
					ToLua.PushObject(L, o);
					return 1;
				}
				break;
			}
			if (num == 1 && TypeChecker.CheckTypes<string>(L, 1))
			{
				Dropdown.OptionData o3 = new Dropdown.OptionData(ToLua.ToString(L, 1));
				ToLua.PushObject(L, o3);
				return 1;
			}
			if (num == 2)
			{
				string text = ToLua.CheckString(L, 1);
				Sprite image = (Sprite)ToLua.CheckObject(L, 2, typeof(Sprite));
				Dropdown.OptionData o4 = new Dropdown.OptionData(text, image);
				ToLua.PushObject(L, o4);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.UI.Dropdown.OptionData.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_text(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string text = ((Dropdown.OptionData)obj).text;
			LuaDLL.lua_pushstring(L, text);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index text on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_image(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Sprite image = ((Dropdown.OptionData)obj).image;
			ToLua.PushSealed(L, image);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index image on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_text(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Dropdown.OptionData obj2 = (Dropdown.OptionData)obj;
			string text = ToLua.CheckString(L, 2);
			obj2.text = text;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index text on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_image(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Dropdown.OptionData obj2 = (Dropdown.OptionData)obj;
			Sprite image = (Sprite)ToLua.CheckObject(L, 2, typeof(Sprite));
			obj2.image = image;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index image on a nil value");
		}
	}
}
