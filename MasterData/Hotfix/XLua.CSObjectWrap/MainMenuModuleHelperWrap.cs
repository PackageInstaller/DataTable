using System;
using UnityEngine;
using XLua.LuaDLL;

namespace XLua.CSObjectWrap;

public class MainMenuModuleHelperWrap
{
	public static void __Register(IntPtr L)
	{
		ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
		Type typeFromHandle = typeof(MainMenuModuleHelper);
		Utils.BeginObjectRegister(typeFromHandle, L, translator, 0, 0, 0, 0);
		Utils.EndObjectRegister(typeFromHandle, L, translator, null, null, null, null, null);
		Utils.BeginClassRegister(typeFromHandle, L, __CreateInstance, 4, 0, 0);
		Utils.RegisterFunc(L, -4, "GetMainMenuSceneRoot", _m_GetMainMenuSceneRoot_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetActiveScene", _m_GetActiveScene_xlua_st_);
		Utils.RegisterFunc(L, -4, "DeActiveScene", _m_DeActiveScene_xlua_st_);
		Utils.EndClassRegister(typeFromHandle, L, translator);
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int __CreateInstance(IntPtr L)
	{
		return Lua.luaL_error(L, "MainMenuModuleHelper does not have a constructor!");
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetMainMenuSceneRoot_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			Transform mainMenuSceneRoot = MainMenuModuleHelper.GetMainMenuSceneRoot(Lua.lua_tostring(L, 1));
			objectTranslator.Push(L, mainMenuSceneRoot);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetActiveScene_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			string sceneConfigName = Lua.lua_tostring(L, 1);
			Action<bool> callback = objectTranslator.GetDelegate<Action<bool>>(L, 2);
			MainMenuModuleHelper.GetActiveScene(sceneConfigName, callback);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_DeActiveScene_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			string sceneConfigName = Lua.lua_tostring(L, 1);
			Action<bool> callback = objectTranslator.GetDelegate<Action<bool>>(L, 2);
			MainMenuModuleHelper.DeActiveScene(sceneConfigName, callback);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}
}
