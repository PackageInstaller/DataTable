using System;
using LuaInterface;
using UnityEngine;

public class LoadingUIManagerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(LoadingUIManager), typeof(object));
		L.RegFunction("GetLoadingSprite", GetLoadingSprite);
		L.RegFunction("ShowLoadUI", ShowLoadUI);
		L.RegFunction("CloseLoadUI", CloseLoadUI);
		L.RegFunction("UpdateLoadingInfo", UpdateLoadingInfo);
		L.RegFunction("SetUIText", SetUIText);
		L.RegFunction("SetUIProgress", SetUIProgress);
		L.RegFunction("SetLoadingShowAction", SetLoadingShowAction);
		L.RegFunction("SetBackground", SetBackground);
		L.RegFunction("UpdateLoadingInfo2", UpdateLoadingInfo2);
		L.RegFunction("SetBackground2", SetBackground2);
		L.RegFunction("DontShowAnything", DontShowAnything);
		L.RegFunction("New", _CreateLoadingUIManager);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("inst", get_inst, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateLoadingUIManager(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				LoadingUIManager o = new LoadingUIManager();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: LoadingUIManager.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetLoadingSprite(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				Sprite loadingSprite2 = ((LoadingUIManager)ToLua.CheckObject<LoadingUIManager>(L, 1)).GetLoadingSprite();
				ToLua.PushSealed(L, loadingSprite2);
				return 1;
			}
			case 2:
			{
				LoadingUIManager obj = (LoadingUIManager)ToLua.CheckObject<LoadingUIManager>(L, 1);
				string path = ToLua.CheckString(L, 2);
				Sprite loadingSprite = obj.GetLoadingSprite(path);
				ToLua.PushSealed(L, loadingSprite);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: LoadingUIManager.GetLoadingSprite");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ShowLoadUI(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				((LoadingUIManager)ToLua.CheckObject<LoadingUIManager>(L, 1)).ShowLoadUI();
				return 0;
			case 2:
			{
				LoadingUIManager obj = (LoadingUIManager)ToLua.CheckObject<LoadingUIManager>(L, 1);
				LoadingUIType type = (LoadingUIType)ToLua.CheckObject(L, 2, typeof(LoadingUIType));
				obj.ShowLoadUI(type);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: LoadingUIManager.ShowLoadUI");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CloseLoadUI(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((LoadingUIManager)ToLua.CheckObject<LoadingUIManager>(L, 1)).CloseLoadUI();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UpdateLoadingInfo(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			LoadingUIManager obj = (LoadingUIManager)ToLua.CheckObject<LoadingUIManager>(L, 1);
			string title = ToLua.CheckString(L, 2);
			string tip = ToLua.CheckString(L, 3);
			string spriteName = ToLua.CheckString(L, 4);
			obj.UpdateLoadingInfo(title, tip, spriteName);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetUIText(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LoadingUIManager obj = (LoadingUIManager)ToLua.CheckObject<LoadingUIManager>(L, 1);
			string uIText = ToLua.CheckString(L, 2);
			obj.SetUIText(uIText);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetUIProgress(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LoadingUIManager obj = (LoadingUIManager)ToLua.CheckObject<LoadingUIManager>(L, 1);
			float uIProgress = (float)LuaDLL.luaL_checknumber(L, 2);
			obj.SetUIProgress(uIProgress);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLoadingShowAction(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LoadingUIManager obj = (LoadingUIManager)ToLua.CheckObject<LoadingUIManager>(L, 1);
			Action<LoadingUIType> loadingShowAction = (Action<LoadingUIType>)ToLua.CheckDelegate<Action<LoadingUIType>>(L, 2);
			obj.SetLoadingShowAction(loadingShowAction);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetBackground(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				((LoadingUIManager)ToLua.CheckObject<LoadingUIManager>(L, 1)).SetBackground();
				return 0;
			case 2:
			{
				LoadingUIManager obj = (LoadingUIManager)ToLua.CheckObject<LoadingUIManager>(L, 1);
				string background = ToLua.CheckString(L, 2);
				obj.SetBackground(background);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: LoadingUIManager.SetBackground");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UpdateLoadingInfo2(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			LoadingUIManager obj = (LoadingUIManager)ToLua.CheckObject<LoadingUIManager>(L, 1);
			string title = ToLua.CheckString(L, 2);
			string tip = ToLua.CheckString(L, 3);
			string spriteName = ToLua.CheckString(L, 4);
			obj.UpdateLoadingInfo2(title, tip, spriteName);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetBackground2(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				((LoadingUIManager)ToLua.CheckObject<LoadingUIManager>(L, 1)).SetBackground2();
				return 0;
			case 2:
			{
				LoadingUIManager obj = (LoadingUIManager)ToLua.CheckObject<LoadingUIManager>(L, 1);
				string background = ToLua.CheckString(L, 2);
				obj.SetBackground2(background);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: LoadingUIManager.SetBackground2");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DontShowAnything(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			LoadingUIManager obj = (LoadingUIManager)ToLua.CheckObject<LoadingUIManager>(L, 1);
			bool flag = LuaDLL.luaL_checkboolean(L, 2);
			obj.DontShowAnything(flag);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_inst(IntPtr L)
	{
		try
		{
			ToLua.PushObject(L, LoadingUIManager.inst);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
