using System;
using UnityEngine;
using XLua.LuaDLL;

namespace XLua.CSObjectWrap;

public class DormModuleHelper_HotFixWrap
{
	public static void __Register(IntPtr L)
	{
		ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
		Type typeFromHandle = typeof(DormModuleHelper_HotFix);
		Utils.BeginObjectRegister(typeFromHandle, L, translator, 0, 0, 0, 0);
		Utils.EndObjectRegister(typeFromHandle, L, translator, null, null, null, null, null);
		Utils.BeginClassRegister(typeFromHandle, L, __CreateInstance, 8, 0, 0);
		Utils.RegisterFunc(L, -4, "GetCurRoomUsedCellNum", _m_GetCurRoomUsedCellNum_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetFur_EntityId_RootBubbleTrans", _m_GetFur_EntityId_RootBubbleTrans_xlua_st_);
		Utils.RegisterFunc(L, -4, "TryPickActorAtLastPressDown", _m_TryPickActorAtLastPressDown_xlua_st_);
		Utils.RegisterFunc(L, -4, "CaptureSceneImage", _m_CaptureSceneImage_xlua_st_);
		Utils.RegisterFunc(L, -4, "LoadSceneCaptureImageSprite", _m_LoadSceneCaptureImageSprite_xlua_st_);
		Utils.RegisterFunc(L, -4, "ReleaseSceneCaptureImageSprite", _m_ReleaseSceneCaptureImageSprite_xlua_st_);
		Utils.RegisterFunc(L, -4, "CleanSceneCaptureImages", _m_CleanSceneCaptureImages_xlua_st_);
		Utils.EndClassRegister(typeFromHandle, L, translator);
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int __CreateInstance(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			if (Lua.lua_gettop(L) == 1)
			{
				DormModuleHelper_HotFix o = new DormModuleHelper_HotFix();
				objectTranslator.Push(L, o);
				return 1;
			}
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return Lua.luaL_error(L, "invalid arguments to DormModuleHelper_HotFix constructor!");
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetCurRoomUsedCellNum_xlua_st_(IntPtr L)
	{
		try
		{
			int curRoomUsedCellNum = DormModuleHelper_HotFix.GetCurRoomUsedCellNum();
			Lua.xlua_pushinteger(L, curRoomUsedCellNum);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetFur_EntityId_RootBubbleTrans_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			long[] fur_EntityId_RootBubbleTrans = DormModuleHelper_HotFix.GetFur_EntityId_RootBubbleTrans(Lua.xlua_tointeger(L, 1), out var arrBB);
			objectTranslator.Push(L, fur_EntityId_RootBubbleTrans);
			objectTranslator.Push(L, arrBB);
			return 2;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_TryPickActorAtLastPressDown_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			bool value = DormModuleHelper_HotFix.TryPickActorAtLastPressDown(out var rt, out var RoleId, out var entityId);
			Lua.lua_pushboolean(L, value);
			objectTranslator.Push(L, rt);
			Lua.xlua_pushinteger(L, RoleId);
			Lua.lua_pushint64(L, entityId);
			return 4;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_CaptureSceneImage_xlua_st_(IntPtr L)
	{
		try
		{
			string scope = Lua.lua_tostring(L, 1);
			string imageFileName = Lua.lua_tostring(L, 2);
			bool useOutdoorSceneCamera = Lua.lua_toboolean(L, 3);
			bool value = DormModuleHelper_HotFix.CaptureSceneImage(scope, imageFileName, useOutdoorSceneCamera);
			Lua.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_LoadSceneCaptureImageSprite_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			string scope = Lua.lua_tostring(L, 1);
			string imageFileName = Lua.lua_tostring(L, 2);
			Sprite o = DormModuleHelper_HotFix.LoadSceneCaptureImageSprite(scope, imageFileName);
			objectTranslator.Push(L, o);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_ReleaseSceneCaptureImageSprite_xlua_st_(IntPtr L)
	{
		try
		{
			DormModuleHelper_HotFix.ReleaseSceneCaptureImageSprite((Sprite)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(Sprite)));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_CleanSceneCaptureImages_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			string scope = Lua.lua_tostring(L, 1);
			string[] keepFileNames = (string[])objectTranslator.GetObject(L, 2, typeof(string[]));
			DormModuleHelper_HotFix.CleanSceneCaptureImages(scope, keepFileNames);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}
}
