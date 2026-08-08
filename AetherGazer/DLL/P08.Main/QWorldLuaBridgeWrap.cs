using System;
using LuaInterface;
using UnityEngine;

public class QWorldLuaBridgeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginStaticLibs("QWorldLuaBridge");
		L.RegFunction("StartSeeker", StartSeeker);
		L.RegFunction("GetPatrolPath", GetPatrolPath);
		L.RegFunction("StartStory", StartStory);
		L.RegFunction("StopStory", StopStory);
		L.RegFunction("EntraceLauncher", EntraceLauncher);
		L.RegFunction("Launcher", Launcher);
		L.RegFunction("Restart", Restart);
		L.RegFunction("GetBubbleMgr", GetBubbleMgr);
		L.RegFunction("CreateMapEntity", CreateMapEntity);
		L.RegFunction("RemoveMapEntity", RemoveMapEntity);
		L.RegFunction("GetMapEntityData", GetMapEntityData);
		L.RegFunction("CullingAllDynamic", CullingAllDynamic);
		L.RegFunction("HidePlayer", HidePlayer);
		L.RegFunction("HideHud", HideHud);
		L.RegFunction("CreateQWorlEffect", CreateQWorlEffect);
		L.RegFunction("DestroyQWorldAsset", DestroyQWorldAsset);
		L.RegFunction("TrackMapEntity", TrackMapEntity);
		L.RegFunction("GetFuniturePerformAction", GetFuniturePerformAction);
		L.RegFunction("GetFuniturePerformExitAction", GetFuniturePerformExitAction);
		L.RegFunction("GetFunitureNeedForceBack", GetFunitureNeedForceBack);
		L.RegFunction("GetFurnitureCanAutoExit", GetFurnitureCanAutoExit);
		L.RegFunction("GetFunitureFocusPoint", GetFunitureFocusPoint);
		L.RegFunction("GetFunitureExitPoint", GetFunitureExitPoint);
		L.RegFunction("HideBubble", HideBubble);
		L.RegFunction("StopControl", StopControl);
		L.RegFunction("StopControlFrame", StopControlFrame);
		L.RegFunction("PauseSceneDither", PauseSceneDither);
		L.RegFunction("CloseUI", CloseUI);
		L.RegFunction("ActiveMiniMap", ActiveMiniMap);
		L.RegFunction("EntityShowQuest", EntityShowQuest);
		L.RegFunction("EntityShowCommonHud", EntityShowCommonHud);
		L.RegFunction("Teleport", Teleport);
		L.RegFunction("TeleportToNearest", TeleportToNearest);
		L.RegFunction("TeleportToCachePos", TeleportToCachePos);
		L.RegFunction("TeleportToStageOrigin", TeleportToStageOrigin);
		L.RegFunction("GetPlayer", GetPlayer);
		L.RegFunction("EnableCamera", EnableCamera);
		L.RegFunction("ExitFocusCamera", ExitFocusCamera);
		L.RegFunction("ExitTopCustomCamera", ExitTopCustomCamera);
		L.RegFunction("ExitCustomCamera", ExitCustomCamera);
		L.RegFunction("SetCameraBlend", SetCameraBlend);
		L.RegFunction("SwitchControlCharacter", SwitchControlCharacter);
		L.RegFunction("EnterPlayerFocus", EnterPlayerFocus);
		L.RegFunction("ChangeInteractionMode", ChangeInteractionMode);
		L.RegFunction("GetInteractionMode", GetInteractionMode);
		L.RegFunction("ChangeSceneLodChangeRatio", ChangeSceneLodChangeRatio);
		L.RegFunction("RebuildSceneLodGroups", RebuildSceneLodGroups);
		L.RegFunction("EnableCameraCut", EnableCameraCut);
		L.RegVar("WalkingPeopleGlobleCull", get_WalkingPeopleGlobleCull, set_WalkingPeopleGlobleCull);
		L.RegVar("BirdsGlobleCull", get_BirdsGlobleCull, set_BirdsGlobleCull);
		L.RegVar("onEntityEnterInteractRange", get_onEntityEnterInteractRange, set_onEntityEnterInteractRange);
		L.RegVar("onEntityExitInteractRange", get_onEntityExitInteractRange, set_onEntityExitInteractRange);
		L.RegVar("onEntityEnterZone", get_onEntityEnterZone, set_onEntityEnterZone);
		L.RegVar("onEntityExitZone", get_onEntityExitZone, set_onEntityExitZone);
		L.EndStaticLibs();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StartSeeker(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 6:
			{
				QWorldMapEntity entity5 = (QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1);
				Vector3[] routes5 = ToLua.CheckStructArray<Vector3>(L, 2);
				float stopRange5 = (float)LuaDLL.luaL_checknumber(L, 3);
				bool isRun5 = LuaDLL.luaL_checkboolean(L, 4);
				Action stopCallback5 = (Action)ToLua.CheckDelegate<Action>(L, 5);
				Action<int> arriveCallback5 = (Action<int>)ToLua.CheckDelegate<Action<int>>(L, 6);
				QWorldLuaBridge.StartSeeker(entity5, routes5, stopRange5, isRun5, stopCallback5, arriveCallback5);
				return 0;
			}
			case 7:
			{
				QWorldMapEntity entity4 = (QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1);
				Vector3[] routes4 = ToLua.CheckStructArray<Vector3>(L, 2);
				float stopRange4 = (float)LuaDLL.luaL_checknumber(L, 3);
				bool isRun4 = LuaDLL.luaL_checkboolean(L, 4);
				Action stopCallback4 = (Action)ToLua.CheckDelegate<Action>(L, 5);
				Action<int> arriveCallback4 = (Action<int>)ToLua.CheckDelegate<Action<int>>(L, 6);
				float pauseRadius4 = (float)LuaDLL.luaL_checknumber(L, 7);
				QWorldLuaBridge.StartSeeker(entity4, routes4, stopRange4, isRun4, stopCallback4, arriveCallback4, pauseRadius4);
				return 0;
			}
			case 8:
			{
				QWorldMapEntity entity3 = (QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1);
				Vector3[] routes3 = ToLua.CheckStructArray<Vector3>(L, 2);
				float stopRange3 = (float)LuaDLL.luaL_checknumber(L, 3);
				bool isRun3 = LuaDLL.luaL_checkboolean(L, 4);
				Action stopCallback3 = (Action)ToLua.CheckDelegate<Action>(L, 5);
				Action<int> arriveCallback3 = (Action<int>)ToLua.CheckDelegate<Action<int>>(L, 6);
				float pauseRadius3 = (float)LuaDLL.luaL_checknumber(L, 7);
				Action pausAction3 = (Action)ToLua.CheckDelegate<Action>(L, 8);
				QWorldLuaBridge.StartSeeker(entity3, routes3, stopRange3, isRun3, stopCallback3, arriveCallback3, pauseRadius3, pausAction3);
				return 0;
			}
			case 9:
			{
				QWorldMapEntity entity2 = (QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1);
				Vector3[] routes2 = ToLua.CheckStructArray<Vector3>(L, 2);
				float stopRange2 = (float)LuaDLL.luaL_checknumber(L, 3);
				bool isRun2 = LuaDLL.luaL_checkboolean(L, 4);
				Action stopCallback2 = (Action)ToLua.CheckDelegate<Action>(L, 5);
				Action<int> arriveCallback2 = (Action<int>)ToLua.CheckDelegate<Action<int>>(L, 6);
				float pauseRadius2 = (float)LuaDLL.luaL_checknumber(L, 7);
				Action pausAction2 = (Action)ToLua.CheckDelegate<Action>(L, 8);
				bool enableInteract2 = LuaDLL.luaL_checkboolean(L, 9);
				QWorldLuaBridge.StartSeeker(entity2, routes2, stopRange2, isRun2, stopCallback2, arriveCallback2, pauseRadius2, pausAction2, enableInteract2);
				return 0;
			}
			case 10:
			{
				QWorldMapEntity entity = (QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1);
				Vector3[] routes = ToLua.CheckStructArray<Vector3>(L, 2);
				float stopRange = (float)LuaDLL.luaL_checknumber(L, 3);
				bool isRun = LuaDLL.luaL_checkboolean(L, 4);
				Action stopCallback = (Action)ToLua.CheckDelegate<Action>(L, 5);
				Action<int> arriveCallback = (Action<int>)ToLua.CheckDelegate<Action<int>>(L, 6);
				float pauseRadius = (float)LuaDLL.luaL_checknumber(L, 7);
				Action pausAction = (Action)ToLua.CheckDelegate<Action>(L, 8);
				bool enableInteract = LuaDLL.luaL_checkboolean(L, 9);
				int interactMode = (int)LuaDLL.luaL_checknumber(L, 10);
				QWorldLuaBridge.StartSeeker(entity, routes, stopRange, isRun, stopCallback, arriveCallback, pauseRadius, pausAction, enableInteract, interactMode);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: QWorldLuaBridge.StartSeeker");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetPatrolPath(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Vector3[] patrolPath = QWorldLuaBridge.GetPatrolPath((int)LuaDLL.luaL_checknumber(L, 1));
			ToLua.Push(L, patrolPath);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StartStory(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int talkId = (int)LuaDLL.luaL_checknumber(L, 1);
			QWorldMapEntity target = (QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 2);
			QWorldLuaBridge.StartStory(talkId, target);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StopStory(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			QWorldLuaBridge.StopStory();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EntraceLauncher(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			string map = ToLua.CheckString(L, 1);
			int heroId = (int)LuaDLL.luaL_checknumber(L, 2);
			QWorldLuaBridge.EntraceLauncher(map, heroId);
			return 0;
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
			QWorldLuaBridge.Launcher(ToLua.CheckString(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Restart(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			QWorldLuaBridge.Restart(ToLua.CheckString(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetBubbleMgr(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			QWorldBubbleManager bubbleMgr = QWorldLuaBridge.GetBubbleMgr();
			ToLua.PushObject(L, bubbleMgr);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CreateMapEntity(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int entityId = (int)LuaDLL.luaL_checknumber(L, 1);
			int type = (int)LuaDLL.luaL_checknumber(L, 2);
			QWorldMapEntity obj = QWorldLuaBridge.CreateMapEntity(entityId, type);
			ToLua.Push(L, obj);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RemoveMapEntity(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = QWorldLuaBridge.RemoveMapEntity((int)LuaDLL.luaL_checknumber(L, 1));
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetMapEntityData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			QWorldThingEntityData mapEntityData = QWorldLuaBridge.GetMapEntityData((int)LuaDLL.luaL_checknumber(L, 1));
			ToLua.PushObject(L, mapEntityData);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CullingAllDynamic(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				QWorldLuaBridge.CullingAllDynamic(LuaDLL.luaL_checkboolean(L, 1));
				return 0;
			case 2:
			{
				bool hideAll2 = LuaDLL.luaL_checkboolean(L, 1);
				int[] hiddenIds2 = ToLua.CheckNumberArray<int>(L, 2);
				QWorldLuaBridge.CullingAllDynamic(hideAll2, hiddenIds2);
				return 0;
			}
			case 3:
			{
				bool hideAll = LuaDLL.luaL_checkboolean(L, 1);
				int[] hiddenIds = ToLua.CheckNumberArray<int>(L, 2);
				int cullingLayer = (int)LuaDLL.luaL_checknumber(L, 3);
				QWorldLuaBridge.CullingAllDynamic(hideAll, hiddenIds, cullingLayer);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: QWorldLuaBridge.CullingAllDynamic");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int HidePlayer(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			QWorldLuaBridge.HidePlayer(LuaDLL.luaL_checkboolean(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int HideHud(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			QWorldLuaBridge.HideHud(LuaDLL.luaL_checkboolean(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CreateQWorlEffect(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			string path = ToLua.CheckString(L, 1);
			Vector3 position = ToLua.ToVector3(L, 2);
			Quaternion rotation = ToLua.ToQuaternion(L, 3);
			GameObject o = QWorldLuaBridge.CreateQWorlEffect(path, position, rotation);
			ToLua.PushSealed(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DestroyQWorldAsset(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				QWorldLuaBridge.DestroyQWorldAsset((GameObject)ToLua.CheckObject(L, 1, typeof(GameObject)));
				return 0;
			case 2:
			{
				GameObject obj = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
				float time = (float)LuaDLL.luaL_checknumber(L, 2);
				QWorldLuaBridge.DestroyQWorldAsset(obj, time);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: QWorldLuaBridge.DestroyQWorldAsset");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int TrackMapEntity(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = QWorldLuaBridge.TrackMapEntity(ToLua.CheckNumberArray<int>(L, 1));
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetFuniturePerformAction(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int funiturePerformAction = QWorldLuaBridge.GetFuniturePerformAction((QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1));
			LuaDLL.lua_pushinteger(L, funiturePerformAction);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetFuniturePerformExitAction(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int funiturePerformExitAction = QWorldLuaBridge.GetFuniturePerformExitAction((QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1));
			LuaDLL.lua_pushinteger(L, funiturePerformExitAction);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetFunitureNeedForceBack(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool funitureNeedForceBack = QWorldLuaBridge.GetFunitureNeedForceBack((QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1));
			LuaDLL.lua_pushboolean(L, funitureNeedForceBack);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetFurnitureCanAutoExit(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool furnitureCanAutoExit = QWorldLuaBridge.GetFurnitureCanAutoExit((QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1));
			LuaDLL.lua_pushboolean(L, furnitureCanAutoExit);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetFunitureFocusPoint(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Transform funitureFocusPoint = QWorldLuaBridge.GetFunitureFocusPoint((QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1));
			ToLua.Push(L, funitureFocusPoint);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetFunitureExitPoint(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Transform funitureExitPoint = QWorldLuaBridge.GetFunitureExitPoint((QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1));
			ToLua.Push(L, funitureExitPoint);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int HideBubble(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 0:
				QWorldLuaBridge.HideBubble();
				return 0;
			case 1:
				QWorldLuaBridge.HideBubble(LuaDLL.luaL_checkboolean(L, 1));
				return 0;
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: QWorldLuaBridge.HideBubble");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StopControl(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 0:
				QWorldLuaBridge.StopControl();
				return 0;
			case 1:
				QWorldLuaBridge.StopControl(LuaDLL.luaL_checkboolean(L, 1));
				return 0;
			case 2:
			{
				bool active = LuaDLL.luaL_checkboolean(L, 1);
				bool withCamera = LuaDLL.luaL_checkboolean(L, 2);
				QWorldLuaBridge.StopControl(active, withCamera);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: QWorldLuaBridge.StopControl");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StopControlFrame(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			QWorldLuaBridge.StopControlFrame((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PauseSceneDither(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			QWorldLuaBridge.PauseSceneDither(LuaDLL.luaL_checkboolean(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CloseUI(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 0:
				QWorldLuaBridge.CloseUI();
				return 0;
			case 1:
				QWorldLuaBridge.CloseUI(LuaDLL.luaL_checkboolean(L, 1));
				return 0;
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: QWorldLuaBridge.CloseUI");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ActiveMiniMap(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			QWorldLuaBridge.ActiveMiniMap(LuaDLL.luaL_checkboolean(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EntityShowQuest(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				QWorldMapEntity entity2 = (QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1);
				int questType2 = (int)LuaDLL.luaL_checknumber(L, 2);
				QWorldLuaBridge.EntityShowQuest(entity2, questType2);
				return 0;
			}
			case 3:
			{
				QWorldMapEntity entity = (QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1);
				int questType = (int)LuaDLL.luaL_checknumber(L, 2);
				bool isInTaskTracking = LuaDLL.luaL_checkboolean(L, 3);
				QWorldLuaBridge.EntityShowQuest(entity, questType, isInTaskTracking);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: QWorldLuaBridge.EntityShowQuest");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EntityShowCommonHud(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			QWorldMapEntity entity = (QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1);
			string commonHudPath = ToLua.CheckString(L, 2);
			string baseBoardPath = ToLua.CheckString(L, 3);
			string deputyName = ToLua.CheckString(L, 4);
			QWorldLuaBridge.EntityShowCommonHud(entity, commonHudPath, baseBoardPath, deputyName);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Teleport(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				QWorldLuaBridge.Teleport((int)LuaDLL.luaL_checknumber(L, 1));
				return 0;
			case 2:
			{
				int teleportId = (int)LuaDLL.luaL_checknumber(L, 1);
				bool needReset = LuaDLL.luaL_checkboolean(L, 2);
				QWorldLuaBridge.Teleport(teleportId, needReset);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: QWorldLuaBridge.Teleport");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int TeleportToNearest(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				QWorldLuaBridge.TeleportToNearest(ToLua.ToVector3(L, 1));
				return 0;
			case 2:
			{
				Vector3 positon = ToLua.ToVector3(L, 1);
				bool needReset = LuaDLL.luaL_checkboolean(L, 2);
				QWorldLuaBridge.TeleportToNearest(positon, needReset);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: QWorldLuaBridge.TeleportToNearest");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int TeleportToCachePos(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Vector3 position3 = ToLua.ToVector3(L, 1);
				Quaternion rotation3 = ToLua.ToQuaternion(L, 2);
				QWorldLuaBridge.TeleportToCachePos(position3, rotation3);
				return 0;
			}
			case 3:
			{
				Vector3 position2 = ToLua.ToVector3(L, 1);
				Quaternion rotation2 = ToLua.ToQuaternion(L, 2);
				bool needReset2 = LuaDLL.luaL_checkboolean(L, 3);
				QWorldLuaBridge.TeleportToCachePos(position2, rotation2, needReset2);
				return 0;
			}
			case 4:
			{
				Vector3 position = ToLua.ToVector3(L, 1);
				Quaternion rotation = ToLua.ToQuaternion(L, 2);
				bool needReset = LuaDLL.luaL_checkboolean(L, 3);
				bool ignoreCamera = LuaDLL.luaL_checkboolean(L, 4);
				QWorldLuaBridge.TeleportToCachePos(position, rotation, needReset, ignoreCamera);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: QWorldLuaBridge.TeleportToCachePos");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int TeleportToStageOrigin(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			QWorldLuaBridge.TeleportToStageOrigin();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetPlayer(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			QWCharacterAgent player = QWorldLuaBridge.GetPlayer();
			ToLua.Push(L, player);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EnableCamera(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			int flag = (int)LuaDLL.luaL_checknumber(L, 1);
			string path = ToLua.CheckString(L, 2);
			int layer = (int)LuaDLL.luaL_checknumber(L, 3);
			QWorldLuaBridge.EnableCamera(flag, path, layer);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ExitFocusCamera(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			QWorldLuaBridge.ExitFocusCamera();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ExitTopCustomCamera(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			QWorldLuaBridge.ExitTopCustomCamera();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ExitCustomCamera(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			QWorldLuaBridge.ExitCustomCamera(ToLua.CheckString(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetCameraBlend(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int style = (int)LuaDLL.luaL_checknumber(L, 1);
			float time = (float)LuaDLL.luaL_checknumber(L, 2);
			QWorldLuaBridge.SetCameraBlend(style, time);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SwitchControlCharacter(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			QWorldLuaBridge.SwitchControlCharacter((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EnterPlayerFocus(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			QWorldLuaBridge.EnterPlayerFocus(LuaDLL.luaL_checkboolean(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ChangeInteractionMode(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			QWorldLuaBridge.ChangeInteractionMode((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetInteractionMode(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			int interactionMode = QWorldLuaBridge.GetInteractionMode();
			LuaDLL.lua_pushinteger(L, interactionMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ChangeSceneLodChangeRatio(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			QWorldLuaBridge.ChangeSceneLodChangeRatio(ToLua.CheckNumberArray<float>(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RebuildSceneLodGroups(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			QWorldLuaBridge.RebuildSceneLodGroups();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EnableCameraCut(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			QWorldLuaBridge.EnableCameraCut(LuaDLL.luaL_checkboolean(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_WalkingPeopleGlobleCull(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, QWorldLuaBridge.WalkingPeopleGlobleCull);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_BirdsGlobleCull(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, QWorldLuaBridge.BirdsGlobleCull);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_onEntityEnterInteractRange(IntPtr L)
	{
		ToLua.Push(L, new EventObject(typeof(Action<object>)));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_onEntityExitInteractRange(IntPtr L)
	{
		ToLua.Push(L, new EventObject(typeof(Action<object>)));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_onEntityEnterZone(IntPtr L)
	{
		ToLua.Push(L, new EventObject(typeof(Action<int, int>)));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_onEntityExitZone(IntPtr L)
	{
		ToLua.Push(L, new EventObject(typeof(Action<int, int>)));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_WalkingPeopleGlobleCull(IntPtr L)
	{
		try
		{
			QWorldLuaBridge.WalkingPeopleGlobleCull = LuaDLL.luaL_checkboolean(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_BirdsGlobleCull(IntPtr L)
	{
		try
		{
			QWorldLuaBridge.BirdsGlobleCull = LuaDLL.luaL_checkboolean(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_onEntityEnterInteractRange(IntPtr L)
	{
		try
		{
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					QWorldLuaBridge.onEntityEnterInteractRange += (Action<object>)eventObject.func;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					QWorldLuaBridge.onEntityEnterInteractRange -= (Action<object>)eventObject.func;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'QWorldLuaBridge.onEntityEnterInteractRange' can only appear on the left hand side of += or -= when used outside of the type 'QWorldLuaBridge'");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_onEntityExitInteractRange(IntPtr L)
	{
		try
		{
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					QWorldLuaBridge.onEntityExitInteractRange += (Action<object>)eventObject.func;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					QWorldLuaBridge.onEntityExitInteractRange -= (Action<object>)eventObject.func;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'QWorldLuaBridge.onEntityExitInteractRange' can only appear on the left hand side of += or -= when used outside of the type 'QWorldLuaBridge'");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_onEntityEnterZone(IntPtr L)
	{
		try
		{
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					QWorldLuaBridge.onEntityEnterZone += (Action<int, int>)eventObject.func;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					QWorldLuaBridge.onEntityEnterZone -= (Action<int, int>)eventObject.func;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'QWorldLuaBridge.onEntityEnterZone' can only appear on the left hand side of += or -= when used outside of the type 'QWorldLuaBridge'");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_onEntityExitZone(IntPtr L)
	{
		try
		{
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					QWorldLuaBridge.onEntityExitZone += (Action<int, int>)eventObject.func;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					QWorldLuaBridge.onEntityExitZone -= (Action<int, int>)eventObject.func;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'QWorldLuaBridge.onEntityExitZone' can only appear on the left hand side of += or -= when used outside of the type 'QWorldLuaBridge'");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
