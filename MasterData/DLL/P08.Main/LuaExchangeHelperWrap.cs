using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;

public class LuaExchangeHelperWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(LuaExchangeHelper), typeof(object));
		L.RegFunction("Launcher", Launcher);
		L.RegFunction("Reload", Reload);
		L.RegFunction("GoToMain", GoToMain);
		L.RegFunction("GetSceneIsHanding", GetSceneIsHanding);
		L.RegFunction("ReloadBattleRecordData", ReloadBattleRecordData);
		L.RegFunction("ContinueGame", ContinueGame);
		L.RegFunction("PauseGame", PauseGame);
		L.RegFunction("GameOver", GameOver);
		L.RegFunction("SetIPAndPort", SetIPAndPort);
		L.RegFunction("SetNewbie", SetNewbie);
		L.RegFunction("SetPlayerQuality", SetPlayerQuality);
		L.RegFunction("SetAIQuality", SetAIQuality);
		L.RegFunction("SetFriendQuality", SetFriendQuality);
		L.RegFunction("GetBattleStatisticsData", GetBattleStatisticsData);
		L.RegFunction("GetBattleStatisticsDataBeforeBattleEnd", GetBattleStatisticsDataBeforeBattleEnd);
		L.RegFunction("ClearDownloadAssetsFolder", ClearDownloadAssetsFolder);
		L.RegFunction("GetCurrentAffixInScene", GetCurrentAffixInScene);
		L.RegFunction("ApplyBattleSetting", ApplyBattleSetting);
		L.RegFunction("ActionInvoke", ActionInvoke);
		L.RegFunction("SetRoleData", SetRoleData);
		L.RegFunction("EndWaitReadyAck", EndWaitReadyAck);
		L.RegFunction("GetDescription", GetDescription);
		L.RegFunction("SetCooperateUniqueSkillPlayControlledType", SetCooperateUniqueSkillPlayControlledType);
		L.RegFunction("SetCacheSize", SetCacheSize);
		L.RegFunction("EnableATrigger", EnableATrigger);
		L.RegFunction("GetBattleModuleBuffEnum", GetBattleModuleBuffEnum);
		L.RegFunction("LoadEmpty", LoadEmpty);
		L.RegFunction("New", _CreateLuaExchangeHelper);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("data", get_data, set_data);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateLuaExchangeHelper(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				LuaExchangeHelper o = new LuaExchangeHelper();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: LuaExchangeHelper.New");
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
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				SceneDataForExcehange sceneDataForExcehange2 = (SceneDataForExcehange)ToLua.CheckObject<SceneDataForExcehange>(L, 1);
				Action callback2 = (Action)ToLua.CheckDelegate<Action>(L, 2);
				LuaExchangeHelper.Launcher(sceneDataForExcehange2, callback2);
				return 0;
			}
			case 3:
			{
				SceneDataForExcehange sceneDataForExcehange = (SceneDataForExcehange)ToLua.CheckObject<SceneDataForExcehange>(L, 1);
				Action callback = (Action)ToLua.CheckDelegate<Action>(L, 2);
				Action onSceneReadyCallback = (Action)ToLua.CheckDelegate<Action>(L, 3);
				LuaExchangeHelper.Launcher(sceneDataForExcehange, callback, onSceneReadyCallback);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: LuaExchangeHelper.Launcher");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Reload(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			LuaExchangeHelper.Reload();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GoToMain(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 0:
				LuaExchangeHelper.GoToMain();
				return 0;
			case 1:
				LuaExchangeHelper.GoToMain((int)LuaDLL.luaL_checknumber(L, 1));
				return 0;
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: LuaExchangeHelper.GoToMain");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetSceneIsHanding(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			bool sceneIsHanding = LuaExchangeHelper.GetSceneIsHanding();
			LuaDLL.lua_pushboolean(L, sceneIsHanding);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ReloadBattleRecordData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			LuaExchangeHelper.ReloadBattleRecordData();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ContinueGame(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			LuaExchangeHelper.ContinueGame();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PauseGame(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			LuaExchangeHelper.PauseGame();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GameOver(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				LuaExchangeHelper.GameOver((int)LuaDLL.luaL_checknumber(L, 1));
				return 0;
			case 2:
			{
				int result = (int)LuaDLL.luaL_checknumber(L, 1);
				int customSceneID = (int)LuaDLL.luaL_checknumber(L, 2);
				LuaExchangeHelper.GameOver(result, customSceneID);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: LuaExchangeHelper.GameOver");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetIPAndPort(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			string ip = ToLua.CheckString(L, 1);
			string port = ToLua.CheckString(L, 2);
			LuaExchangeHelper.SetIPAndPort(ip, port);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetNewbie(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LuaExchangeHelper.SetNewbie(LuaDLL.luaL_checkboolean(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetPlayerQuality(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LuaExchangeHelper.SetPlayerQuality((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetAIQuality(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LuaExchangeHelper.SetAIQuality((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetFriendQuality(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LuaExchangeHelper.SetFriendQuality(LuaDLL.luaL_checkboolean(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetBattleStatisticsData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			StatisticsData battleStatisticsData = LuaExchangeHelper.GetBattleStatisticsData();
			ToLua.PushObject(L, battleStatisticsData);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetBattleStatisticsDataBeforeBattleEnd(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			StatisticsData battleStatisticsDataBeforeBattleEnd = LuaExchangeHelper.GetBattleStatisticsDataBeforeBattleEnd();
			ToLua.PushObject(L, battleStatisticsDataBeforeBattleEnd);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearDownloadAssetsFolder(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			bool value = LuaExchangeHelper.ClearDownloadAssetsFolder();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCurrentAffixInScene(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			List<Vector3> currentAffixInScene = LuaExchangeHelper.GetCurrentAffixInScene();
			ToLua.PushSealed(L, currentAffixInScene);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ApplyBattleSetting(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			LuaExchangeHelper.ApplyBattleSetting();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ActionInvoke(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LuaExchangeHelper.ActionInvoke((Action)ToLua.CheckDelegate<Action>(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetRoleData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LuaExchangeHelper.SetRoleData((SceneDataForExcehange)ToLua.CheckObject<SceneDataForExcehange>(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EndWaitReadyAck(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			LuaExchangeHelper.EndWaitReadyAck();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetDescription(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			string templete = ToLua.CheckString(L, 1);
			object[] param = ToLua.CheckObjectArray(L, 2);
			string description = LuaExchangeHelper.GetDescription(templete, param);
			LuaDLL.lua_pushstring(L, description);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetCooperateUniqueSkillPlayControlledType(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LuaExchangeHelper.SetCooperateUniqueSkillPlayControlledType((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetCacheSize(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LuaExchangeHelper.SetCacheSize((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EnableATrigger(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int oriID = (int)LuaDLL.luaL_checknumber(L, 1);
			int targetID = (int)LuaDLL.luaL_checknumber(L, 2);
			LuaExchangeHelper.EnableATrigger(oriID, targetID);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetBattleModuleBuffEnum(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			int battleModuleBuffEnum = LuaExchangeHelper.GetBattleModuleBuffEnum();
			LuaDLL.lua_pushinteger(L, battleModuleBuffEnum);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LoadEmpty(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LuaExchangeHelper.LoadEmpty((Action)ToLua.CheckDelegate<Action>(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_data(IntPtr L)
	{
		try
		{
			ToLua.PushObject(L, LuaExchangeHelper.data);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_data(IntPtr L)
	{
		try
		{
			LuaExchangeHelper.data = (StatisticsData)ToLua.CheckObject<StatisticsData>(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
