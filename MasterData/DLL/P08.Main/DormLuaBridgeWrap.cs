using System;
using System.Collections.Generic;
using Cinemachine;
using Dorm;
using Dorm.Furniture;
using LuaInterface;
using UnityEngine;

public class DormLuaBridgeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginStaticLibs("DormLuaBridge");
		L.RegFunction("Launcher", Launcher);
		L.RegFunction("ChangeDormScene", ChangeDormScene);
		L.RegFunction("RefreshIsCanPlace", RefreshIsCanPlace);
		L.RegFunction("ChangeFurnitureState", ChangeFurnitureState);
		L.RegFunction("BeginDragFurniture", BeginDragFurniture);
		L.RegFunction("GenerateFurniture", GenerateFurniture);
		L.RegFunction("SnapWallMountFurniture", SnapWallMountFurniture);
		L.RegFunction("RemoveFurniture", RemoveFurniture);
		L.RegFunction("BeginGrabPlayerEntity", BeginGrabPlayerEntity);
		L.RegFunction("EndGrabPlayerEntity", EndGrabPlayerEntity);
		L.RegFunction("TryGrabPlayerOutOfStuck", TryGrabPlayerOutOfStuck);
		L.RegFunction("ChangeRoomState", ChangeRoomState);
		L.RegFunction("InDormSpawnBounds", InDormSpawnBounds);
		L.RegFunction("CalcDormSpawnBounds", CalcDormSpawnBounds);
		L.RegFunction("FindSpawnPos", FindSpawnPos);
		L.RegFunction("FindSpawnPosNearBy", FindSpawnPosNearBy);
		L.RegFunction("TestCanSpawn", TestCanSpawn);
		L.RegFunction("SaveChange", SaveChange);
		L.RegFunction("GetIsCanPlace", GetIsCanPlace);
		L.RegFunction("ClearEditingFurniture", ClearEditingFurniture);
		L.RegFunction("CancelChange", CancelChange);
		L.RegFunction("ClearFurnitureOccupy", ClearFurnitureOccupy);
		L.RegFunction("RecoverRoomFurnitureOccupy", RecoverRoomFurnitureOccupy);
		L.RegFunction("RecoverRoomFurnitureOccupyByLua", RecoverRoomFurnitureOccupyByLua);
		L.RegFunction("ReleaseRoomFurnitureOccupyByLua", ReleaseRoomFurnitureOccupyByLua);
		L.RegFunction("ClearCurrentRoom", ClearCurrentRoom);
		L.RegFunction("SyncRoomFurniture", SyncRoomFurniture);
		L.RegFunction("StorageFurniture", StorageFurniture);
		L.RegFunction("CheckFurnitureConnectReady", CheckFurnitureConnectReady);
		L.RegFunction("RotateFurniture", RotateFurniture);
		L.RegFunction("UpdateAllFurnitureInteractAreaEnabled", UpdateAllFurnitureInteractAreaEnabled);
		L.RegFunction("UpdateWallMountDitherAlphaControl", UpdateWallMountDitherAlphaControl);
		L.RegFunction("GetCurFurnitureTileType", GetCurFurnitureTileType);
		L.RegFunction("UpdateAllWallMountDitherAlphaControl", UpdateAllWallMountDitherAlphaControl);
		L.RegFunction("AddFurnitureToWallDitherAlphaControl", AddFurnitureToWallDitherAlphaControl);
		L.RegFunction("RemoveFurnitureFromWallDitherAlphaControl", RemoveFurnitureFromWallDitherAlphaControl);
		L.RegFunction("GetPlacedFurnitureInfo", GetPlacedFurnitureInfo);
		L.RegFunction("GetAllPlaceFurSuitInfo", GetAllPlaceFurSuitInfo);
		L.RegFunction("SetIsCanEditTag", SetIsCanEditTag);
		L.RegFunction("ChangeCameraMode", ChangeCameraMode);
		L.RegFunction("SetRoomThemeWall", SetRoomThemeWall);
		L.RegFunction("SetRoomThemeFloor", SetRoomThemeFloor);
		L.RegFunction("SetRoomThemeBG", SetRoomThemeBG);
		L.RegFunction("InitJoystick", InitJoystick);
		L.RegFunction("ResetJoystick", ResetJoystick);
		L.RegFunction("TryGetJoytickInput", TryGetJoytickInput);
		L.RegFunction("SetUIFollow", SetUIFollow);
		L.RegFunction("DisableUIFollow", DisableUIFollow);
		L.RegFunction("SetUIPosByWorldPos", SetUIPosByWorldPos);
		L.RegFunction("GetCamFadeOtherCharaParam", GetCamFadeOtherCharaParam);
		L.RegFunction("RecordInfoFromDormTag", RecordInfoFromDormTag);
		L.RegFunction("ActAsClickToEntity", ActAsClickToEntity);
		L.RegFunction("PlayDormStory", PlayDormStory);
		L.RegFunction("DisposeDormStory", DisposeDormStory);
		L.RegFunction("MergeConnectFurniturePath", MergeConnectFurniturePath);
		L.RegFunction("ShiftConnectPath", ShiftConnectPath);
		L.RegFunction("FindClosestPointOnPath", FindClosestPointOnPath);
		L.RegFunction("SetupFurnitureTileEntity", SetupFurnitureTileEntity);
		L.RegFunction("CheckSuitEditModeAvailabel", CheckSuitEditModeAvailabel);
		L.RegFunction("EnterSuitEditMode", EnterSuitEditMode);
		L.RegFunction("ExitSuitEditMode", ExitSuitEditMode);
		L.RegFunction("GenerateSuitPrefab", GenerateSuitPrefab);
		L.RegFunction("SetFurniturePosition", SetFurniturePosition);
		L.RegFunction("FillFurnitureOccupy", FillFurnitureOccupy);
		L.RegFunction("SetSuitFurTrsFather", SetSuitFurTrsFather);
		L.RegFunction("RefreshSuitLenAndWid", RefreshSuitLenAndWid);
		L.RegFunction("DisassembleFurSuit", DisassembleFurSuit);
		L.RegFunction("SetFurInSuitChild", SetFurInSuitChild);
		L.RegFunction("SaveSuitChange", SaveSuitChange);
		L.RegFunction("GetCustomSuitFurInfo", GetCustomSuitFurInfo);
		L.RegFunction("RotateSuitFurniture", RotateSuitFurniture);
		L.RegFunction("RotateFurnitureSuit", RotateFurnitureSuit);
		L.RegFunction("SetFurnitureSuitOccupy", SetFurnitureSuitOccupy);
		L.RegFunction("ChangeSuitColliderState", ChangeSuitColliderState);
		L.RegFunction("ChangeFurnitureSuitState", ChangeFurnitureSuitState);
		L.RegFunction("CheckFurnitureBelongSuit", CheckFurnitureBelongSuit);
		L.RegFunction("CancelSuitChange", CancelSuitChange);
		L.RegFunction("StorageSuitFurniture", StorageSuitFurniture);
		L.RegFunction("ChangeAllFurColliderState", ChangeAllFurColliderState);
		L.RegFunction("ClearAllSuitEntity", ClearAllSuitEntity);
		L.RegFunction("GetFurnitureSuitPosAndRotate", GetFurnitureSuitPosAndRotate);
		L.RegFunction("GetSuitFurInfoList", GetSuitFurInfoList);
		L.RegFunction("GetSuitFurEidList", GetSuitFurEidList);
		L.RegFunction("ChangeEditSuit", ChangeEditSuit);
		L.RegFunction("GetSuitOrFurnitureCanPlace", GetSuitOrFurnitureCanPlace);
		L.RegFunction("GetCanRestoreFur", GetCanRestoreFur);
		L.RegFunction("EnterCustomeEditMode", EnterCustomeEditMode);
		L.RegFunction("SavePhotoToWebServer", SavePhotoToWebServer);
		L.RegVar("DormStickController", get_DormStickController, null);
		L.EndStaticLibs();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Launcher(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			DormDataForExchange dormDataForExchange = (DormDataForExchange)ToLua.CheckObject<DormDataForExchange>(L, 1);
			Action callback = (Action)ToLua.CheckDelegate<Action>(L, 2);
			DormLuaBridge.Launcher(dormDataForExchange, callback);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ChangeDormScene(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			DormDataForExchange dormDataForExchange = (DormDataForExchange)ToLua.CheckObject<DormDataForExchange>(L, 1);
			Action callback = (Action)ToLua.CheckDelegate<Action>(L, 2);
			DormLuaBridge.ChangeDormScene(dormDataForExchange, callback);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RefreshIsCanPlace(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int furnitureEntityID = (int)LuaDLL.luaL_checknumber(L, 1);
			bool canPlace = LuaDLL.luaL_checkboolean(L, 2);
			DormLuaBridge.RefreshIsCanPlace(furnitureEntityID, canPlace);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ChangeFurnitureState(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				int furnitureEntityID2 = (int)LuaDLL.luaL_checknumber(L, 1);
				int state2 = (int)LuaDLL.luaL_checknumber(L, 2);
				DormLuaBridge.ChangeFurnitureState(furnitureEntityID2, state2);
				return 0;
			}
			case 3:
			{
				int furnitureEntityID = (int)LuaDLL.luaL_checknumber(L, 1);
				int state = (int)LuaDLL.luaL_checknumber(L, 2);
				bool ignoreCheckCanPlace = LuaDLL.luaL_checkboolean(L, 3);
				DormLuaBridge.ChangeFurnitureState(furnitureEntityID, state, ignoreCheckCanPlace);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: DormLuaBridge.ChangeFurnitureState");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int BeginDragFurniture(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			DormLuaBridge.BeginDragFurniture((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GenerateFurniture(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 7:
			{
				int cfgID2 = (int)LuaDLL.luaL_checknumber(L, 1);
				uint state2 = (uint)LuaDLL.luaL_checknumber(L, 2);
				string path2 = ToLua.CheckString(L, 3);
				int width2 = (int)LuaDLL.luaL_checknumber(L, 4);
				int height2 = (int)LuaDLL.luaL_checknumber(L, 5);
				int depth2 = (int)LuaDLL.luaL_checknumber(L, 6);
				bool mustTouchGround2 = LuaDLL.luaL_checkboolean(L, 7);
				int n2 = DormLuaBridge.GenerateFurniture(cfgID2, state2, path2, width2, height2, depth2, mustTouchGround2);
				LuaDLL.lua_pushinteger(L, n2);
				return 1;
			}
			case 8:
			{
				int cfgID = (int)LuaDLL.luaL_checknumber(L, 1);
				uint state = (uint)LuaDLL.luaL_checknumber(L, 2);
				string path = ToLua.CheckString(L, 3);
				int width = (int)LuaDLL.luaL_checknumber(L, 4);
				int height = (int)LuaDLL.luaL_checknumber(L, 5);
				int depth = (int)LuaDLL.luaL_checknumber(L, 6);
				bool mustTouchGround = LuaDLL.luaL_checkboolean(L, 7);
				bool complex = LuaDLL.luaL_checkboolean(L, 8);
				int n = DormLuaBridge.GenerateFurniture(cfgID, state, path, width, height, depth, mustTouchGround, complex);
				LuaDLL.lua_pushinteger(L, n);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: DormLuaBridge.GenerateFurniture");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SnapWallMountFurniture(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			DormLuaBridge.SnapWallMountFurniture((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RemoveFurniture(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				bool value2 = DormLuaBridge.RemoveFurniture((int)LuaDLL.luaL_checknumber(L, 1));
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			case 2:
			{
				int furnitrueEntityID = (int)LuaDLL.luaL_checknumber(L, 1);
				bool needRemoveFootPrint = LuaDLL.luaL_checkboolean(L, 2);
				bool value = DormLuaBridge.RemoveFurniture(furnitrueEntityID, needRemoveFootPrint);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: DormLuaBridge.RemoveFurniture");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int BeginGrabPlayerEntity(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
			int? followPointer = ToLua.CheckNullable<int>(L, 2);
			DormLuaBridge.BeginGrabPlayerEntity(entityID, followPointer);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EndGrabPlayerEntity(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			DormLuaBridge.EndGrabPlayerEntity((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int TryGrabPlayerOutOfStuck(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				DormLuaBridge.TryGrabPlayerOutOfStuck((int)LuaDLL.luaL_checknumber(L, 1));
				return 0;
			case 2:
			{
				int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
				bool queue = LuaDLL.luaL_checkboolean(L, 2);
				DormLuaBridge.TryGrabPlayerOutOfStuck(entityID, queue);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: DormLuaBridge.TryGrabPlayerOutOfStuck");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ChangeRoomState(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			DormLuaBridge.ChangeRoomState(LuaDLL.luaL_checkboolean(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InDormSpawnBounds(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = DormLuaBridge.InDormSpawnBounds(ToLua.ToVector3(L, 1));
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CalcDormSpawnBounds(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			DormLuaBridge.CalcDormSpawnBounds();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int FindSpawnPos(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				Vector3? v3 = DormLuaBridge.FindSpawnPos((float)LuaDLL.luaL_checknumber(L, 1));
				ToLua.PusNullable(L, v3);
				return 1;
			}
			case 2:
			{
				float entityRadius2 = (float)LuaDLL.luaL_checknumber(L, 1);
				int maxTry2 = (int)LuaDLL.luaL_checknumber(L, 2);
				Vector3? v2 = DormLuaBridge.FindSpawnPos(entityRadius2, maxTry2);
				ToLua.PusNullable(L, v2);
				return 1;
			}
			case 3:
			{
				float entityRadius = (float)LuaDLL.luaL_checknumber(L, 1);
				int maxTry = (int)LuaDLL.luaL_checknumber(L, 2);
				bool ignoreGroundTest = LuaDLL.luaL_checkboolean(L, 3);
				Vector3? v = DormLuaBridge.FindSpawnPos(entityRadius, maxTry, ignoreGroundTest);
				ToLua.PusNullable(L, v);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: DormLuaBridge.FindSpawnPos");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int FindSpawnPosNearBy(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				Vector3? v2 = DormLuaBridge.FindSpawnPosNearBy((int)LuaDLL.luaL_checknumber(L, 1));
				ToLua.PusNullable(L, v2);
				return 1;
			}
			case 2:
			{
				int eid = (int)LuaDLL.luaL_checknumber(L, 1);
				float range = (float)LuaDLL.luaL_checknumber(L, 2);
				Vector3? v = DormLuaBridge.FindSpawnPosNearBy(eid, range);
				ToLua.PusNullable(L, v);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: DormLuaBridge.FindSpawnPosNearBy");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int TestCanSpawn(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				Vector3 pos2 = ToLua.ToVector3(L, 1);
				float radius2 = (float)LuaDLL.luaL_checknumber(L, 2);
				bool ignoreGroundTest2 = LuaDLL.luaL_checkboolean(L, 3);
				bool value2 = DormLuaBridge.TestCanSpawn(pos2, radius2, ignoreGroundTest2);
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			case 4:
			{
				Vector3 pos = ToLua.ToVector3(L, 1);
				float radius = (float)LuaDLL.luaL_checknumber(L, 2);
				bool ignoreGroundTest = LuaDLL.luaL_checkboolean(L, 3);
				bool value = DormLuaBridge.TestCanSpawn(pos, radius, ignoreGroundTest, out var groundHeight);
				LuaDLL.lua_pushboolean(L, value);
				LuaDLL.lua_pushnumber(L, groundHeight);
				return 2;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: DormLuaBridge.TestCanSpawn");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SaveChange(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			bool value = DormLuaBridge.SaveChange();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetIsCanPlace(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			bool isCanPlace = DormLuaBridge.GetIsCanPlace();
			LuaDLL.lua_pushboolean(L, isCanPlace);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearEditingFurniture(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			DormLuaBridge.ClearEditingFurniture();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CancelChange(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = DormLuaBridge.CancelChange(out var cancledEditing);
			LuaDLL.lua_pushboolean(L, value);
			LuaDLL.lua_pushinteger(L, cancledEditing);
			return 2;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearFurnitureOccupy(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			DormLuaBridge.ClearFurnitureOccupy();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RecoverRoomFurnitureOccupy(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int idx = (int)LuaDLL.luaL_checknumber(L, 1);
			int entityID = (int)LuaDLL.luaL_checknumber(L, 2);
			DormLuaBridge.RecoverRoomFurnitureOccupy(idx, entityID);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RecoverRoomFurnitureOccupyByLua(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			DormLuaBridge.RecoverRoomFurnitureOccupyByLua((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ReleaseRoomFurnitureOccupyByLua(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			DormLuaBridge.ReleaseRoomFurnitureOccupyByLua((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearCurrentRoom(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			DormLuaBridge.ClearCurrentRoom();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SyncRoomFurniture(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			DormLuaBridge.SyncRoomFurniture(ToLua.CheckObjectArray<FurnitureInfo>(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StorageFurniture(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			int n = DormLuaBridge.StorageFurniture();
			LuaDLL.lua_pushinteger(L, n);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CheckFurnitureConnectReady(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int furniture = (int)LuaDLL.luaL_checknumber(L, 1);
			int otherFurniture = (int)LuaDLL.luaL_checknumber(L, 2);
			bool value = DormLuaBridge.CheckFurnitureConnectReady(furniture, otherFurniture);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RotateFurniture(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 0:
			{
				bool value2 = DormLuaBridge.RotateFurniture();
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			case 2:
			{
				FurnitureEntity furnitureEntity = (FurnitureEntity)ToLua.CheckObject<FurnitureEntity>(L, 1);
				Vector3 rotateAxis = ToLua.ToVector3(L, 2);
				bool value = DormLuaBridge.RotateFurniture(furnitureEntity, rotateAxis);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: DormLuaBridge.RotateFurniture");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UpdateAllFurnitureInteractAreaEnabled(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			DormLuaBridge.UpdateAllFurnitureInteractAreaEnabled();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UpdateWallMountDitherAlphaControl(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			DormLuaBridge.UpdateWallMountDitherAlphaControl((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCurFurnitureTileType(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			TileType curFurnitureTileType = DormLuaBridge.GetCurFurnitureTileType((int)LuaDLL.luaL_checknumber(L, 1));
			ToLua.Push(L, curFurnitureTileType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UpdateAllWallMountDitherAlphaControl(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			DormLuaBridge.UpdateAllWallMountDitherAlphaControl();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddFurnitureToWallDitherAlphaControl(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			DormLuaBridge.AddFurnitureToWallDitherAlphaControl((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RemoveFurnitureFromWallDitherAlphaControl(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			DormLuaBridge.RemoveFurnitureFromWallDitherAlphaControl((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetPlacedFurnitureInfo(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 0:
			{
				FurnitureInfo[] placedFurnitureInfo2 = DormLuaBridge.GetPlacedFurnitureInfo();
				ToLua.Push(L, placedFurnitureInfo2);
				return 1;
			}
			case 1:
			{
				FurnitureInfo[] placedFurnitureInfo = DormLuaBridge.GetPlacedFurnitureInfo(LuaDLL.luaL_checkboolean(L, 1));
				ToLua.Push(L, placedFurnitureInfo);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: DormLuaBridge.GetPlacedFurnitureInfo");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetAllPlaceFurSuitInfo(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			FurnitureInfo[] allPlaceFurSuitInfo = DormLuaBridge.GetAllPlaceFurSuitInfo();
			ToLua.Push(L, allPlaceFurSuitInfo);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetIsCanEditTag(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			DormLuaBridge.SetIsCanEditTag(LuaDLL.luaL_checkboolean(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ChangeCameraMode(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				DormLuaBridge.ChangeCameraMode((int)LuaDLL.luaL_checknumber(L, 1));
				return 0;
			case 2:
			{
				int status = (int)LuaDLL.luaL_checknumber(L, 1);
				bool isNeedInit = LuaDLL.luaL_checkboolean(L, 2);
				DormLuaBridge.ChangeCameraMode(status, isNeedInit);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: DormLuaBridge.ChangeCameraMode");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetRoomThemeWall(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				DormLuaBridge.SetRoomThemeWall(ToLua.CheckString(L, 1));
				return 0;
			case 2:
			{
				string materialPath = ToLua.CheckString(L, 1);
				string meshPath = ToLua.CheckString(L, 2);
				DormLuaBridge.SetRoomThemeWall(materialPath, meshPath);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: DormLuaBridge.SetRoomThemeWall");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetRoomThemeFloor(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			string gameObjectPath = ToLua.CheckString(L, 1);
			string extendPath = ToLua.CheckString(L, 2);
			DormLuaBridge.SetRoomThemeFloor(gameObjectPath, extendPath);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetRoomThemeBG(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			string bgPath = ToLua.CheckString(L, 1);
			string lightPath = ToLua.CheckString(L, 2);
			DormLuaBridge.SetRoomThemeBG(bgPath, lightPath);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InitJoystick(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			DormLuaBridge.InitJoystick((GameObject)ToLua.CheckObject(L, 1, typeof(GameObject)));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ResetJoystick(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			DormLuaBridge.ResetJoystick(LuaDLL.luaL_checkboolean(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int TryGetJoytickInput(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			Vector3? v = DormLuaBridge.TryGetJoytickInput();
			ToLua.PusNullable(L, v);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetUIFollow(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			RectTransform uiFollow = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			int entityID = (int)LuaDLL.luaL_checknumber(L, 2);
			string attachPoint = ToLua.CheckString(L, 3);
			DormLuaBridge.SetUIFollow(uiFollow, entityID, attachPoint);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DisableUIFollow(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			DormLuaBridge.DisableUIFollow((RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform)));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetUIPosByWorldPos(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			RectTransform ui = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			Vector3 pos = ToLua.ToVector3(L, 2);
			DormLuaBridge.SetUIPosByWorldPos(ui, pos);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCamFadeOtherCharaParam(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			DormLuaBridge.GetCamFadeOtherCharaParam(out var start, out var end);
			LuaDLL.lua_pushnumber(L, start);
			LuaDLL.lua_pushnumber(L, end);
			return 2;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RecordInfoFromDormTag(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			DormLuaBridge.RecordInfoFromDormTag();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ActAsClickToEntity(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = DormLuaBridge.ActAsClickToEntity((int)LuaDLL.luaL_checknumber(L, 1));
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlayDormStory(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			string timelinePath = ToLua.CheckString(L, 1);
			int[] actors = ToLua.CheckNumberArray<int>(L, 2);
			DormLuaBridge.PlayDormStory(timelinePath, actors);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DisposeDormStory(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			DormLuaBridge.DisposeDormStory();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int MergeConnectFurniturePath(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 4:
			{
				int pathStartNode3 = (int)LuaDLL.luaL_checknumber(L, 1);
				int[] connectFurnitures3 = ToLua.CheckNumberArray<int>(L, 2);
				bool isRing3 = LuaDLL.luaL_checkboolean(L, 3);
				string pathTagNamespace3 = ToLua.CheckString(L, 4);
				CinemachinePathBase obj3 = DormLuaBridge.MergeConnectFurniturePath(pathStartNode3, connectFurnitures3, isRing3, pathTagNamespace3);
				ToLua.Push(L, obj3);
				return 1;
			}
			case 5:
			{
				int pathStartNode2 = (int)LuaDLL.luaL_checknumber(L, 1);
				int[] connectFurnitures2 = ToLua.CheckNumberArray<int>(L, 2);
				bool isRing2 = LuaDLL.luaL_checkboolean(L, 3);
				string pathTagNamespace2 = ToLua.CheckString(L, 4);
				float wieldPointRange2 = (float)LuaDLL.luaL_checknumber(L, 5);
				CinemachinePathBase obj2 = DormLuaBridge.MergeConnectFurniturePath(pathStartNode2, connectFurnitures2, isRing2, pathTagNamespace2, wieldPointRange2);
				ToLua.Push(L, obj2);
				return 1;
			}
			case 6:
			{
				int pathStartNode = (int)LuaDLL.luaL_checknumber(L, 1);
				int[] connectFurnitures = ToLua.CheckNumberArray<int>(L, 2);
				bool isRing = LuaDLL.luaL_checkboolean(L, 3);
				string pathTagNamespace = ToLua.CheckString(L, 4);
				float wieldPointRange = (float)LuaDLL.luaL_checknumber(L, 5);
				int resolution = (int)LuaDLL.luaL_checknumber(L, 6);
				CinemachinePathBase obj = DormLuaBridge.MergeConnectFurniturePath(pathStartNode, connectFurnitures, isRing, pathTagNamespace, wieldPointRange, resolution);
				ToLua.Push(L, obj);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: DormLuaBridge.MergeConnectFurniturePath");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ShiftConnectPath(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				IEnumerable<Transform> path2 = (IEnumerable<Transform>)ToLua.CheckObject<IEnumerable<Transform>>(L, 1);
				int shift2 = (int)LuaDLL.luaL_checknumber(L, 2);
				IEnumerable<Transform> o2 = DormLuaBridge.ShiftConnectPath(path2, shift2);
				ToLua.PushObject(L, o2);
				return 1;
			}
			case 3:
			{
				IEnumerable<Transform> path = (IEnumerable<Transform>)ToLua.CheckObject<IEnumerable<Transform>>(L, 1);
				int shift = (int)LuaDLL.luaL_checknumber(L, 2);
				bool ringShift = LuaDLL.luaL_checkboolean(L, 3);
				IEnumerable<Transform> o = DormLuaBridge.ShiftConnectPath(path, shift, ringShift);
				ToLua.PushObject(L, o);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: DormLuaBridge.ShiftConnectPath");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int FindClosestPointOnPath(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Vector3 worldPos = ToLua.ToVector3(L, 1);
			CinemachinePathBase path = (CinemachinePathBase)ToLua.CheckObject<CinemachinePathBase>(L, 2);
			float num = DormLuaBridge.FindClosestPointOnPath(worldPos, path);
			LuaDLL.lua_pushnumber(L, num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetupFurnitureTileEntity(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			DormLuaBridge.SetupFurnitureTileEntity((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CheckSuitEditModeAvailabel(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = DormLuaBridge.CheckSuitEditModeAvailabel((int)LuaDLL.luaL_checknumber(L, 1));
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EnterSuitEditMode(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
			bool isSuitChangePosition = LuaDLL.luaL_checkboolean(L, 2);
			DormLuaBridge.EnterSuitEditMode(entityID, isSuitChangePosition);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ExitSuitEditMode(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			DormLuaBridge.ExitSuitEditMode((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GenerateSuitPrefab(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				int id2 = (int)LuaDLL.luaL_checknumber(L, 1);
				bool isPartSuit2 = LuaDLL.luaL_checkboolean(L, 2);
				int n2 = DormLuaBridge.GenerateSuitPrefab(id2, isPartSuit2);
				LuaDLL.lua_pushinteger(L, n2);
				return 1;
			}
			case 3:
			{
				int id = (int)LuaDLL.luaL_checknumber(L, 1);
				bool isPartSuit = LuaDLL.luaL_checkboolean(L, 2);
				int tileType = (int)LuaDLL.luaL_checknumber(L, 3);
				int n = DormLuaBridge.GenerateSuitPrefab(id, isPartSuit, tileType);
				LuaDLL.lua_pushinteger(L, n);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: DormLuaBridge.GenerateSuitPrefab");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetFurniturePosition(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
			int tileType = (int)LuaDLL.luaL_checknumber(L, 2);
			Vector2 pos = ToLua.ToVector2(L, 3);
			float rotation = (float)LuaDLL.luaL_checknumber(L, 4);
			DormLuaBridge.SetFurniturePosition(entityID, tileType, pos, rotation);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int FillFurnitureOccupy(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
			int tileType = (int)LuaDLL.luaL_checknumber(L, 2);
			DormLuaBridge.FillFurnitureOccupy(entityID, tileType);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetSuitFurTrsFather(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				DormLuaBridge.SetSuitFurTrsFather((int)LuaDLL.luaL_checknumber(L, 1));
				return 0;
			case 2:
			{
				int suitID = (int)LuaDLL.luaL_checknumber(L, 1);
				bool flag = LuaDLL.luaL_checkboolean(L, 2);
				DormLuaBridge.SetSuitFurTrsFather(suitID, flag);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: DormLuaBridge.SetSuitFurTrsFather");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RefreshSuitLenAndWid(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			DormLuaBridge.RefreshSuitLenAndWid((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DisassembleFurSuit(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			DormLuaBridge.DisassembleFurSuit((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetFurInSuitChild(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int suitEid = (int)LuaDLL.luaL_checknumber(L, 1);
			int furEid = (int)LuaDLL.luaL_checknumber(L, 2);
			DormLuaBridge.SetFurInSuitChild(suitEid, furEid);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SaveSuitChange(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			bool value = DormLuaBridge.SaveSuitChange();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCustomSuitFurInfo(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			FurnitureInfo[] customSuitFurInfo = DormLuaBridge.GetCustomSuitFurInfo((int)LuaDLL.luaL_checknumber(L, 1));
			ToLua.Push(L, customSuitFurInfo);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RotateSuitFurniture(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			bool value = DormLuaBridge.RotateSuitFurniture();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RotateFurnitureSuit(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
			float suitRotation = (float)LuaDLL.luaL_checknumber(L, 2);
			bool value = DormLuaBridge.RotateFurnitureSuit(entityID, suitRotation);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetFurnitureSuitOccupy(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
			bool isOccupy = LuaDLL.luaL_checkboolean(L, 2);
			DormLuaBridge.SetFurnitureSuitOccupy(entityID, isOccupy);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ChangeSuitColliderState(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int suitID = (int)LuaDLL.luaL_checknumber(L, 1);
			bool flag = LuaDLL.luaL_checkboolean(L, 2);
			DormLuaBridge.ChangeSuitColliderState(suitID, flag);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ChangeFurnitureSuitState(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				int furnitureEntityID2 = (int)LuaDLL.luaL_checknumber(L, 1);
				int state2 = (int)LuaDLL.luaL_checknumber(L, 2);
				DormLuaBridge.ChangeFurnitureSuitState(furnitureEntityID2, state2);
				return 0;
			}
			case 3:
			{
				int furnitureEntityID = (int)LuaDLL.luaL_checknumber(L, 1);
				int state = (int)LuaDLL.luaL_checknumber(L, 2);
				bool controlOccupy = LuaDLL.luaL_checkboolean(L, 3);
				DormLuaBridge.ChangeFurnitureSuitState(furnitureEntityID, state, controlOccupy);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: DormLuaBridge.ChangeFurnitureSuitState");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CheckFurnitureBelongSuit(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				bool value2 = DormLuaBridge.CheckFurnitureBelongSuit((int)LuaDLL.luaL_checknumber(L, 1));
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			case 2:
			{
				bool value = DormLuaBridge.CheckFurnitureBelongSuit((int)LuaDLL.luaL_checknumber(L, 1), out var suitEID);
				LuaDLL.lua_pushboolean(L, value);
				LuaDLL.lua_pushinteger(L, suitEID);
				return 2;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: DormLuaBridge.CheckFurnitureBelongSuit");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CancelSuitChange(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = DormLuaBridge.CancelSuitChange(out var cancledEditing);
			LuaDLL.lua_pushboolean(L, value);
			LuaDLL.lua_pushinteger(L, cancledEditing);
			return 2;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StorageSuitFurniture(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int n = DormLuaBridge.StorageSuitFurniture(ToLua.CheckNumberArray<int>(L, 1));
			LuaDLL.lua_pushinteger(L, n);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ChangeAllFurColliderState(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			DormLuaBridge.ChangeAllFurColliderState(LuaDLL.luaL_checkboolean(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearAllSuitEntity(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			DormLuaBridge.ClearAllSuitEntity();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetFurnitureSuitPosAndRotate(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Vector2 furnitureSuitPosAndRotate = DormLuaBridge.GetFurnitureSuitPosAndRotate((int)LuaDLL.luaL_checknumber(L, 1), out var suitRotation);
			ToLua.Push(L, furnitureSuitPosAndRotate);
			LuaDLL.lua_pushnumber(L, suitRotation);
			return 2;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetSuitFurInfoList(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			FurnitureInfo[] suitFurInfoList = DormLuaBridge.GetSuitFurInfoList((int)LuaDLL.luaL_checknumber(L, 1), out var changeFlag);
			ToLua.Push(L, suitFurInfoList);
			LuaDLL.lua_pushboolean(L, changeFlag);
			return 2;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetSuitFurEidList(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int[] suitFurEidList = DormLuaBridge.GetSuitFurEidList((int)LuaDLL.luaL_checknumber(L, 1));
			ToLua.Push(L, suitFurEidList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ChangeEditSuit(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			DormLuaBridge.ChangeEditSuit((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetSuitOrFurnitureCanPlace(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool suitOrFurnitureCanPlace = DormLuaBridge.GetSuitOrFurnitureCanPlace((int)LuaDLL.luaL_checknumber(L, 1));
			LuaDLL.lua_pushboolean(L, suitOrFurnitureCanPlace);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCanRestoreFur(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int furID = (int)LuaDLL.luaL_checknumber(L, 1);
			int num = (int)LuaDLL.luaL_checknumber(L, 2);
			int[] canRestoreFur = DormLuaBridge.GetCanRestoreFur(furID, num);
			ToLua.Push(L, canRestoreFur);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EnterCustomeEditMode(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				DormLuaBridge.EnterCustomeEditMode((int)LuaDLL.luaL_checknumber(L, 1));
				return 0;
			case 2:
			{
				int furnitureEntityID = (int)LuaDLL.luaL_checknumber(L, 1);
				int suitID = (int)LuaDLL.luaL_checknumber(L, 2);
				DormLuaBridge.EnterCustomeEditMode(furnitureEntityID, suitID);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: DormLuaBridge.EnterCustomeEditMode");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SavePhotoToWebServer(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			Sprite sprite = (Sprite)ToLua.CheckObject(L, 1, typeof(Sprite));
			string path = ToLua.CheckString(L, 2);
			string uidSign = ToLua.CheckString(L, 3);
			Action<string> func = (Action<string>)ToLua.CheckDelegate<Action<string>>(L, 4);
			DormLuaBridge.SavePhotoToWebServer(sprite, path, uidSign, func);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_DormStickController(IntPtr L)
	{
		try
		{
			ToLua.PushObject(L, DormLuaBridge.DormStickController);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
