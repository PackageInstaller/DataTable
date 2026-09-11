using System;
using LuaInterface;
using Spine.Unity;
using UnityEngine;

public class SummerRaceLuaBridgeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginStaticLibs("SummerRaceLuaBridge");
		L.RegFunction("RequestUseWeaponSlot", RequestUseWeaponSlot);
		L.RegFunction("RequestUseEquipSlot", RequestUseEquipSlot);
		L.RegFunction("RequestOverloadWeaponSlot", RequestOverloadWeaponSlot);
		L.RegFunction("RequestToggleAds", RequestToggleAds);
		L.RegFunction("RequestSetManualAccelerationNormalized", RequestSetManualAccelerationNormalized);
		L.RegFunction("RequestSetPaused", RequestSetPaused);
		L.RegFunction("RequestGiveUpBattle", RequestGiveUpBattle);
		L.RegFunction("RequestNotifySpecialDefeatBlackoutFinished", RequestNotifySpecialDefeatBlackoutFinished);
		L.RegFunction("RequestNotifySpecialDefeatGuideFinished", RequestNotifySpecialDefeatGuideFinished);
		L.RegFunction("RequestNotifyEnemyDefeatGuideFinished", RequestNotifyEnemyDefeatGuideFinished);
		L.RegFunction("RequestUsePrimarySkill", RequestUsePrimarySkill);
		L.RegFunction("RequestUseEquipSkill", RequestUseEquipSkill);
		L.RegFunction("RequestPrepareBattleConfig", RequestPrepareBattleConfig);
		L.RegFunction("Launcher", Launcher);
		L.RegFunction("ExitScene", ExitScene);
		L.RegFunction("RequestPrepareOutGameStoryCamera", RequestPrepareOutGameStoryCamera);
		L.RegFunction("RequestApplyPreparedLaunchForStandaloneValidation", RequestApplyPreparedLaunchForStandaloneValidation);
		L.RegFunction("RequestGetBodyMountLayout", RequestGetBodyMountLayout);
		L.RegFunction("RequestGetOptionVisualLayout", RequestGetOptionVisualLayout);
		L.RegFunction("RequestApplySkeletonGraphicSkinStack", RequestApplySkeletonGraphicSkinStack);
		L.RegFunction("RequestSetDamageText", RequestSetDamageText);
		L.RegVar("RuntimeSnapshotEventName", get_RuntimeSnapshotEventName, null);
		L.RegVar("SettlementEventName", get_SettlementEventName, null);
		L.RegVar("StageResolvedEventName", get_StageResolvedEventName, null);
		L.RegVar("EnemyDefeatBeforeFxEventName", get_EnemyDefeatBeforeFxEventName, null);
		L.EndStaticLibs();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RequestSetDamageText(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			GameObject root = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
			string text = ToLua.CheckString(L, 2);
			bool value = SummerRaceLuaBridge.RequestSetDamageText(root, text);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RequestApplySkeletonGraphicSkinStack(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			SkeletonGraphic graphic = (SkeletonGraphic)ToLua.CheckObject(L, 1, typeof(SkeletonGraphic));
			string skinListText = ToLua.CheckString(L, 2);
			bool value = SummerRaceLuaBridge.RequestApplySkeletonGraphicSkinStack(graphic, skinListText);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RequestUseWeaponSlot(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = SummerRaceLuaBridge.RequestUseWeaponSlot((int)LuaDLL.luaL_checknumber(L, 1));
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RequestUseEquipSlot(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = SummerRaceLuaBridge.RequestUseEquipSlot((int)LuaDLL.luaL_checknumber(L, 1));
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RequestOverloadWeaponSlot(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = SummerRaceLuaBridge.RequestOverloadWeaponSlot((int)LuaDLL.luaL_checknumber(L, 1));
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RequestToggleAds(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			bool value = SummerRaceLuaBridge.RequestToggleAds();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RequestSetManualAccelerationNormalized(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = SummerRaceLuaBridge.RequestSetManualAccelerationNormalized((float)LuaDLL.luaL_checknumber(L, 1));
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RequestSetPaused(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = SummerRaceLuaBridge.RequestSetPaused(LuaDLL.luaL_checkboolean(L, 1));
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RequestGiveUpBattle(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			bool value = SummerRaceLuaBridge.RequestGiveUpBattle();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RequestNotifySpecialDefeatBlackoutFinished(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = SummerRaceLuaBridge.RequestNotifySpecialDefeatBlackoutFinished((int)LuaDLL.luaL_checknumber(L, 1));
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RequestNotifySpecialDefeatGuideFinished(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = SummerRaceLuaBridge.RequestNotifySpecialDefeatGuideFinished((int)LuaDLL.luaL_checknumber(L, 1));
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RequestNotifyEnemyDefeatGuideFinished(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = SummerRaceLuaBridge.RequestNotifyEnemyDefeatGuideFinished((int)LuaDLL.luaL_checknumber(L, 1));
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RequestUsePrimarySkill(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			bool value = SummerRaceLuaBridge.RequestUsePrimarySkill();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RequestUseEquipSkill(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			bool value = SummerRaceLuaBridge.RequestUseEquipSkill();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RequestPrepareBattleConfig(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = SummerRaceLuaBridge.RequestPrepareBattleConfig(ToLua.CheckString(L, 1));
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Launcher(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = SummerRaceLuaBridge.Launcher(ToLua.CheckString(L, 1));
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ExitScene(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = SummerRaceLuaBridge.ExitScene((Action)ToLua.CheckDelegate<Action>(L, 1));
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RequestPrepareOutGameStoryCamera(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = SummerRaceLuaBridge.RequestPrepareOutGameStoryCamera((float)LuaDLL.luaL_checknumber(L, 1));
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RequestApplyPreparedLaunchForStandaloneValidation(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			bool value = SummerRaceLuaBridge.RequestApplyPreparedLaunchForStandaloneValidation();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RequestGetBodyMountLayout(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string str = SummerRaceLuaBridge.RequestGetBodyMountLayout(ToLua.CheckString(L, 1));
			LuaDLL.lua_pushstring(L, str);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RequestGetOptionVisualLayout(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			string optionType = ToLua.CheckString(L, 1);
			string optionAssetName = ToLua.CheckString(L, 2);
			string str = SummerRaceLuaBridge.RequestGetOptionVisualLayout(optionType, optionAssetName);
			LuaDLL.lua_pushstring(L, str);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_RuntimeSnapshotEventName(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, "SummerRace.BattleSnapshot");
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_SettlementEventName(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, "SummerRace.BattleSettlement");
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_StageResolvedEventName(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, "SummerRace.StageResolved");
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_EnemyDefeatBeforeFxEventName(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, "SummerRace.EnemyDefeatBeforeFx");
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
