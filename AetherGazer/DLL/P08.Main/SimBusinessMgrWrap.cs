using System;
using System.Collections.Generic;
using Cinemachine;
using Dorm;
using LuaInterface;
using P08.SimBusiness;
using Sirenix.OdinInspector;
using UnityEngine;

public class SimBusinessMgrWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(SimBusinessMgr), typeof(SerializedMonoBehaviour));
		L.RegFunction("InitFloor", InitFloor);
		L.RegFunction("SetupSimBusinessEntity", SetupSimBusinessEntity);
		L.RegFunction("ResetEntityInteractScaner", ResetEntityInteractScaner);
		L.RegFunction("SendMoveToExitMoveCMD", SendMoveToExitMoveCMD);
		L.RegFunction("LoadNavGraph", LoadNavGraph);
		L.RegFunction("TryRefreshShelfCanPlace", TryRefreshShelfCanPlace);
		L.RegFunction("GenerateShelfEntity", GenerateShelfEntity);
		L.RegFunction("OnStartEditShelf", OnStartEditShelf);
		L.RegFunction("OnStopEditShelf", OnStopEditShelf);
		L.RegFunction("SetShelfIsCanPlace", SetShelfIsCanPlace);
		L.RegFunction("RotateCurEditingShelf", RotateCurEditingShelf);
		L.RegFunction("FillObstacleOccupy", FillObstacleOccupy);
		L.RegFunction("FillCustomOccupy", FillCustomOccupy);
		L.RegFunction("RemoveObstacleOccupy", RemoveObstacleOccupy);
		L.RegFunction("RemoveCustomOccupy", RemoveCustomOccupy);
		L.RegFunction("ShowOccupyRectVfx", ShowOccupyRectVfx);
		L.RegFunction("RemoveOccupyRectVfx", RemoveOccupyRectVfx);
		L.RegFunction("CalcPreviewPathToTarget", CalcPreviewPathToTarget);
		L.RegFunction("SendSafeMove", SendSafeMove);
		L.RegFunction("SetupCameraEventTriggerAtMainCamFarClip", SetupCameraEventTriggerAtMainCamFarClip);
		L.RegFunction("CheckShelfAnyInteractAreaAvailable", CheckShelfAnyInteractAreaAvailable);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("instance", get_instance, set_instance);
		L.RegVar("navSurface", get_navSurface, set_navSurface);
		L.RegVar("freeLookCam", get_freeLookCam, set_freeLookCam);
		L.RegVar("rotateRateX", get_rotateRateX, set_rotateRateX);
		L.RegVar("rotateRateY", get_rotateRateY, set_rotateRateY);
		L.RegVar("limitX", get_limitX, set_limitX);
		L.RegVar("limitY", get_limitY, set_limitY);
		L.RegVar("wallHide", get_wallHide, set_wallHide);
		L.RegVar("roomWallTagList", get_roomWallTagList, set_roomWallTagList);
		L.RegVar("farClipCamTrigger", get_farClipCamTrigger, set_farClipCamTrigger);
		L.RegVar("previewPathPoints", get_previewPathPoints, set_previewPathPoints);
		L.RegVar("previewPathLength", get_previewPathLength, set_previewPathLength);
		L.RegVar("IsCalculatingPreviewPath", get_IsCalculatingPreviewPath, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InitFloor(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((SimBusinessMgr)ToLua.CheckObject<SimBusinessMgr>(L, 1)).InitFloor();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetupSimBusinessEntity(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			SimBusinessMgr.SetupSimBusinessEntity((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ResetEntityInteractScaner(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			SimBusinessMgr.ResetEntityInteractScaner((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SendMoveToExitMoveCMD(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				int entityID2 = (int)LuaDLL.luaL_checknumber(L, 1);
				Transform target2 = (Transform)ToLua.CheckObject<Transform>(L, 2);
				SimBusinessMgr.SendMoveToExitMoveCMD(entityID2, target2);
				return 0;
			}
			case 3:
			{
				int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
				Transform target = (Transform)ToLua.CheckObject<Transform>(L, 2);
				bool queue = LuaDLL.luaL_checkboolean(L, 3);
				SimBusinessMgr.SendMoveToExitMoveCMD(entityID, target, queue);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: SimBusinessMgr.SendMoveToExitMoveCMD");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LoadNavGraph(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			SimBusinessMgr.LoadNavGraph(ToLua.CheckString(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int TryRefreshShelfCanPlace(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = SimBusinessMgr.TryRefreshShelfCanPlace((int)LuaDLL.luaL_checknumber(L, 1));
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GenerateShelfEntity(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			string path = ToLua.CheckString(L, 1);
			int cfgID = (int)LuaDLL.luaL_checknumber(L, 2);
			int width = (int)LuaDLL.luaL_checknumber(L, 3);
			int height = (int)LuaDLL.luaL_checknumber(L, 4);
			int n = SimBusinessMgr.GenerateShelfEntity(path, cfgID, width, height);
			LuaDLL.lua_pushinteger(L, n);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnStartEditShelf(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((SimBusinessMgr)ToLua.CheckObject<SimBusinessMgr>(L, 1)).OnStartEditShelf();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnStopEditShelf(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((SimBusinessMgr)ToLua.CheckObject<SimBusinessMgr>(L, 1)).OnStopEditShelf();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetShelfIsCanPlace(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			SimBusinessMgr obj = (SimBusinessMgr)ToLua.CheckObject<SimBusinessMgr>(L, 1);
			int eid = (int)LuaDLL.luaL_checknumber(L, 2);
			bool value = LuaDLL.luaL_checkboolean(L, 3);
			obj.SetShelfIsCanPlace(eid, value);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RotateCurEditingShelf(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			SimBusinessMgr.RotateCurEditingShelf();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int FillObstacleOccupy(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			SimBusinessMgr.FillObstacleOccupy((Collider)ToLua.CheckObject<Collider>(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int FillCustomOccupy(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			object obj = ToLua.ToVarObject(L, 1);
			Bounds occupy = ToLua.ToBounds(L, 2);
			SimBusinessMgr.FillCustomOccupy(obj, occupy);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RemoveObstacleOccupy(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			SimBusinessMgr.RemoveObstacleOccupy((BoxCollider)ToLua.CheckObject<BoxCollider>(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RemoveCustomOccupy(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			SimBusinessMgr.RemoveCustomOccupy(ToLua.ToVarObject(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ShowOccupyRectVfx(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			SimBusinessMgr obj = (SimBusinessMgr)ToLua.CheckObject<SimBusinessMgr>(L, 1);
			object obj2 = ToLua.ToVarObject(L, 2);
			obj.ShowOccupyRectVfx(obj2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RemoveOccupyRectVfx(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			SimBusinessMgr obj = (SimBusinessMgr)ToLua.CheckObject<SimBusinessMgr>(L, 1);
			object obj2 = ToLua.ToVarObject(L, 2);
			obj.RemoveOccupyRectVfx(obj2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CalcPreviewPathToTarget(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 3 && TypeChecker.CheckTypes<Vector3, Action>(L, 2))
			{
				Vector3 start = ToLua.ToVector3(L, 1);
				Vector3 target = ToLua.ToVector3(L, 2);
				Action callback = (Action)ToLua.ToObject(L, 3);
				SimBusinessMgr.CalcPreviewPathToTarget(start, target, callback);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<Transform, Action>(L, 2))
			{
				Vector3 start2 = ToLua.ToVector3(L, 1);
				Transform target2 = (Transform)ToLua.ToObject(L, 2);
				Action callback2 = (Action)ToLua.ToObject(L, 3);
				SimBusinessMgr.CalcPreviewPathToTarget(start2, target2, callback2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: SimBusinessMgr.CalcPreviewPathToTarget");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SendSafeMove(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				int entityID2 = (int)LuaDLL.luaL_checknumber(L, 1);
				bool queue2 = LuaDLL.luaL_checkboolean(L, 2);
				SimBusinessMgr.SendSafeMove(entityID2, queue2);
				return 0;
			}
			case 3:
			{
				int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
				Vector3 pos = ToLua.ToVector3(L, 2);
				bool queue = LuaDLL.luaL_checkboolean(L, 3);
				SimBusinessMgr.SendSafeMove(entityID, pos, queue);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: SimBusinessMgr.SendSafeMove");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetupCameraEventTriggerAtMainCamFarClip(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			SimBusinessMgr.SetupCameraEventTriggerAtMainCamFarClip();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CheckShelfAnyInteractAreaAvailable(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = SimBusinessMgr.CheckShelfAnyInteractAreaAvailable((int)LuaDLL.luaL_checknumber(L, 1));
			LuaDLL.lua_pushboolean(L, value);
			return 1;
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
	private static int get_instance(IntPtr L)
	{
		try
		{
			ToLua.Push(L, SimBusinessMgr.instance);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_navSurface(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneNavSurface navSurface = ((SimBusinessMgr)obj).navSurface;
			ToLua.Push(L, navSurface);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index navSurface on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_freeLookCam(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CinemachineFreeLook freeLookCam = ((SimBusinessMgr)obj).freeLookCam;
			ToLua.Push(L, freeLookCam);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index freeLookCam on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_rotateRateX(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float rotateRateX = ((SimBusinessMgr)obj).rotateRateX;
			LuaDLL.lua_pushnumber(L, rotateRateX);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rotateRateX on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_rotateRateY(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float rotateRateY = ((SimBusinessMgr)obj).rotateRateY;
			LuaDLL.lua_pushnumber(L, rotateRateY);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rotateRateY on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_limitX(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float limitX = ((SimBusinessMgr)obj).limitX;
			LuaDLL.lua_pushnumber(L, limitX);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index limitX on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_limitY(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float limitY = ((SimBusinessMgr)obj).limitY;
			LuaDLL.lua_pushnumber(L, limitY);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index limitY on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_wallHide(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float wallHide = ((SimBusinessMgr)obj).wallHide;
			LuaDLL.lua_pushnumber(L, wallHide);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wallHide on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_roomWallTagList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<RoomWallTag> roomWallTagList = ((SimBusinessMgr)obj).roomWallTagList;
			ToLua.PushSealed(L, roomWallTagList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index roomWallTagList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_farClipCamTrigger(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject farClipCamTrigger = ((SimBusinessMgr)obj).farClipCamTrigger;
			ToLua.PushSealed(L, farClipCamTrigger);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index farClipCamTrigger on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_previewPathPoints(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<Vector3> previewPathPoints = ((SimBusinessMgr)obj).previewPathPoints;
			ToLua.PushSealed(L, previewPathPoints);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index previewPathPoints on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_previewPathLength(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float previewPathLength = ((SimBusinessMgr)obj).previewPathLength;
			LuaDLL.lua_pushnumber(L, previewPathLength);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index previewPathLength on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsCalculatingPreviewPath(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isCalculatingPreviewPath = ((SimBusinessMgr)obj).IsCalculatingPreviewPath;
			LuaDLL.lua_pushboolean(L, isCalculatingPreviewPath);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsCalculatingPreviewPath on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_instance(IntPtr L)
	{
		try
		{
			SimBusinessMgr.instance = (SimBusinessMgr)ToLua.CheckObject<SimBusinessMgr>(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_navSurface(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SimBusinessMgr obj2 = (SimBusinessMgr)obj;
			SceneNavSurface navSurface = (SceneNavSurface)ToLua.CheckObject<SceneNavSurface>(L, 2);
			obj2.navSurface = navSurface;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index navSurface on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_freeLookCam(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SimBusinessMgr obj2 = (SimBusinessMgr)obj;
			CinemachineFreeLook freeLookCam = (CinemachineFreeLook)ToLua.CheckObject<CinemachineFreeLook>(L, 2);
			obj2.freeLookCam = freeLookCam;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index freeLookCam on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_rotateRateX(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SimBusinessMgr obj2 = (SimBusinessMgr)obj;
			float rotateRateX = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.rotateRateX = rotateRateX;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rotateRateX on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_rotateRateY(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SimBusinessMgr obj2 = (SimBusinessMgr)obj;
			float rotateRateY = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.rotateRateY = rotateRateY;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rotateRateY on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_limitX(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SimBusinessMgr obj2 = (SimBusinessMgr)obj;
			float limitX = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.limitX = limitX;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index limitX on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_limitY(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SimBusinessMgr obj2 = (SimBusinessMgr)obj;
			float limitY = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.limitY = limitY;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index limitY on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_wallHide(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SimBusinessMgr obj2 = (SimBusinessMgr)obj;
			float wallHide = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.wallHide = wallHide;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wallHide on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_roomWallTagList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SimBusinessMgr obj2 = (SimBusinessMgr)obj;
			List<RoomWallTag> roomWallTagList = (List<RoomWallTag>)ToLua.CheckObject(L, 2, typeof(List<RoomWallTag>));
			obj2.roomWallTagList = roomWallTagList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index roomWallTagList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_farClipCamTrigger(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SimBusinessMgr obj2 = (SimBusinessMgr)obj;
			GameObject farClipCamTrigger = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj2.farClipCamTrigger = farClipCamTrigger;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index farClipCamTrigger on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_previewPathPoints(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SimBusinessMgr obj2 = (SimBusinessMgr)obj;
			List<Vector3> previewPathPoints = (List<Vector3>)ToLua.CheckObject(L, 2, typeof(List<Vector3>));
			obj2.previewPathPoints = previewPathPoints;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index previewPathPoints on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_previewPathLength(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SimBusinessMgr obj2 = (SimBusinessMgr)obj;
			float previewPathLength = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.previewPathLength = previewPathLength;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index previewPathLength on a nil value");
		}
	}
}
