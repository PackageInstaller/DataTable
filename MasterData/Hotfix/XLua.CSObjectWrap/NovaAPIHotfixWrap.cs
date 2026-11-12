using System;
using Cinemachine;
using Spine.Unity;
using UnityEngine;
using XLua.LuaDLL;

namespace XLua.CSObjectWrap;

public class NovaAPIHotfixWrap
{
	public static void __Register(IntPtr L)
	{
		ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
		Type typeFromHandle = typeof(NovaAPIHotfix);
		Utils.BeginObjectRegister(typeFromHandle, L, translator, 0, 0, 0, 0);
		Utils.EndObjectRegister(typeFromHandle, L, translator, null, null, null, null, null);
		Utils.BeginClassRegister(typeFromHandle, L, __CreateInstance, 17, 0, 0);
		Utils.RegisterFunc(L, -4, "BindTimelineCameraBrain", _m_BindTimelineCameraBrain_xlua_st_);
		Utils.RegisterFunc(L, -4, "PlayTimeline", _m_PlayTimeline_xlua_st_);
		Utils.RegisterFunc(L, -4, "PlayL2DAnim", _m_PlayL2DAnim_xlua_st_);
		Utils.RegisterFunc(L, -4, "SkipL2DCGAnim", _m_SkipL2DCGAnim_xlua_st_);
		Utils.RegisterFunc(L, -4, "CheckL2DAnimEventCount", _m_CheckL2DAnimEventCount_xlua_st_);
		Utils.RegisterFunc(L, -4, "PlayAnimInUI", _m_PlayAnimInUI_xlua_st_);
		Utils.RegisterFunc(L, -4, "PlayAnim_Graphic", _m_PlayAnim_Graphic_xlua_st_);
		Utils.RegisterFunc(L, -4, "AddAnim_Graphic", _m_AddAnim_Graphic_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetTimeScale_Graphic", _m_GetTimeScale_Graphic_xlua_st_);
		Utils.RegisterFunc(L, -4, "SetTimeScale_Graphic", _m_SetTimeScale_Graphic_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetAnimDuration", _m_GetAnimDuration_xlua_st_);
		Utils.RegisterFunc(L, -4, "GetSoldierLevelController", _m_GetSoldierLevelController_xlua_st_);
		Utils.RegisterFunc(L, -4, "MoveSoldier", _m_MoveSoldier_xlua_st_);
		Utils.RegisterFunc(L, -4, "ChangeUIDissolveTarget", _m_ChangeUIDissolveTarget_xlua_st_);
		Utils.RegisterFunc(L, -4, "CompressString", _m_CompressString_xlua_st_);
		Utils.RegisterFunc(L, -4, "DecompressString", _m_DecompressString_xlua_st_);
		Utils.EndClassRegister(typeFromHandle, L, translator);
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int __CreateInstance(IntPtr L)
	{
		return Lua.luaL_error(L, "NovaAPIHotfix does not have a constructor!");
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_BindTimelineCameraBrain_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			GameObject obj = (GameObject)objectTranslator.GetObject(L, 1, typeof(GameObject));
			CinemachineBrain cameraBrain = (CinemachineBrain)objectTranslator.GetObject(L, 2, typeof(CinemachineBrain));
			NovaAPIHotfix.BindTimelineCameraBrain(obj, cameraBrain);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_PlayTimeline_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPIHotfix.PlayTimeline((GameObject)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(GameObject)));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_PlayL2DAnim_xlua_st_(IntPtr L)
	{
		try
		{
			Transform tr = (Transform)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(Transform));
			string sAnimClipName = Lua.lua_tostring(L, 2);
			bool bLoop = Lua.lua_toboolean(L, 3);
			bool bForcePlay = Lua.lua_toboolean(L, 4);
			NovaAPIHotfix.PlayL2DAnim(tr, sAnimClipName, bLoop, bForcePlay);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SkipL2DCGAnim_xlua_st_(IntPtr L)
	{
		try
		{
			NovaAPIHotfix.SkipL2DCGAnim((Transform)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(Transform)));
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_CheckL2DAnimEventCount_xlua_st_(IntPtr L)
	{
		try
		{
			GameObject goL2D = (GameObject)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(GameObject));
			string sAnimName = Lua.lua_tostring(L, 2);
			int value = NovaAPIHotfix.CheckL2DAnimEventCount(goL2D, sAnimName);
			Lua.xlua_pushinteger(L, value);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_PlayAnimInUI_xlua_st_(IntPtr L)
	{
		try
		{
			GameObject go = (GameObject)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(GameObject));
			string sClipName = Lua.lua_tostring(L, 2);
			bool bLoop = Lua.lua_toboolean(L, 3);
			bool bForcePlay = Lua.lua_toboolean(L, 4);
			NovaAPIHotfix.PlayAnimInUI(go, sClipName, bLoop, bForcePlay);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_PlayAnim_Graphic_xlua_st_(IntPtr L)
	{
		try
		{
			SkeletonGraphic skeletonGraphic = (SkeletonGraphic)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(SkeletonGraphic));
			int trackIndex = Lua.xlua_tointeger(L, 2);
			string animName = Lua.lua_tostring(L, 3);
			bool loop = Lua.lua_toboolean(L, 4);
			NovaAPIHotfix.PlayAnim_Graphic(skeletonGraphic, trackIndex, animName, loop);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_AddAnim_Graphic_xlua_st_(IntPtr L)
	{
		try
		{
			SkeletonGraphic skeletonGraphic = (SkeletonGraphic)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(SkeletonGraphic));
			int trackIndex = Lua.xlua_tointeger(L, 2);
			string animName = Lua.lua_tostring(L, 3);
			bool loop = Lua.lua_toboolean(L, 4);
			float delay = (float)Lua.lua_tonumber(L, 5);
			NovaAPIHotfix.AddAnim_Graphic(skeletonGraphic, trackIndex, animName, loop, delay);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetTimeScale_Graphic_xlua_st_(IntPtr L)
	{
		try
		{
			float timeScale_Graphic = NovaAPIHotfix.GetTimeScale_Graphic((SkeletonGraphic)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(SkeletonGraphic)));
			Lua.lua_pushnumber(L, timeScale_Graphic);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetTimeScale_Graphic_xlua_st_(IntPtr L)
	{
		try
		{
			SkeletonGraphic skeletonGraphic = (SkeletonGraphic)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(SkeletonGraphic));
			float scale = (float)Lua.lua_tonumber(L, 2);
			NovaAPIHotfix.SetTimeScale_Graphic(skeletonGraphic, scale);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetAnimDuration_xlua_st_(IntPtr L)
	{
		try
		{
			SkeletonGraphic skeletonGraphic = (SkeletonGraphic)ObjectTranslatorPool.Instance.Find(L).GetObject(L, 1, typeof(SkeletonGraphic));
			string animName = Lua.lua_tostring(L, 2);
			float animDuration = NovaAPIHotfix.GetAnimDuration(skeletonGraphic, animName);
			Lua.lua_pushnumber(L, animDuration);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetSoldierLevelController_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			SoldierLevelController soldierLevelController = NovaAPIHotfix.GetSoldierLevelController();
			objectTranslator.Push(L, soldierLevelController);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_MoveSoldier_xlua_st_(IntPtr L)
	{
		try
		{
			long actorId = Lua.lua_toint64(L, 1);
			double x = Lua.lua_tonumber(L, 2);
			double z = Lua.lua_tonumber(L, 3);
			bool value = NovaAPIHotfix.MoveSoldier(actorId, x, z);
			Lua.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_ChangeUIDissolveTarget_xlua_st_(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			GameObject targetObj = (GameObject)objectTranslator.GetObject(L, 1, typeof(GameObject));
			Texture targetTex = (Texture)objectTranslator.GetObject(L, 2, typeof(Texture));
			NovaAPIHotfix.ChangeUIDissolveTarget(targetObj, targetTex);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_CompressString_xlua_st_(IntPtr L)
	{
		try
		{
			string str = NovaAPIHotfix.CompressString(Lua.lua_tostring(L, 1));
			Lua.lua_pushstring(L, str);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_DecompressString_xlua_st_(IntPtr L)
	{
		try
		{
			string str = NovaAPIHotfix.DecompressString(Lua.lua_tostring(L, 1));
			Lua.lua_pushstring(L, str);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}
}
