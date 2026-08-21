using System;
using Cinemachine;
using Dorm;
using LuaInterface;
using Sirenix.OdinInspector;
using UnityEngine;

public class Dorm_DormEntityManagerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(DormEntityManager), typeof(SerializedMonoBehaviour));
		L.RegFunction("IsValidEntityID", IsValidEntityID);
		L.RegFunction("QueryForwardDir", QueryForwardDir);
		L.RegFunction("QueryPosition", QueryPosition);
		L.RegFunction("QueryEntityAttachPointWorldPos", QueryEntityAttachPointWorldPos);
		L.RegFunction("GetEntityInteractPoint", GetEntityInteractPoint);
		L.RegFunction("GetFurnitureInteractID", GetFurnitureInteractID);
		L.RegFunction("QueryGridPos", QueryGridPos);
		L.RegFunction("QueryRadius", QueryRadius);
		L.RegFunction("QueryProvideInteraction", QueryProvideInteraction);
		L.RegFunction("QueryMobility", QueryMobility);
		L.RegFunction("QuerySpeed", QuerySpeed);
		L.RegFunction("GetGridIndex", GetGridIndex);
		L.RegFunction("GetGridPos", GetGridPos);
		L.RegFunction("GetRelativePointWorldPos", GetRelativePointWorldPos);
		L.RegFunction("KeepAsInteractNotEnd", KeepAsInteractNotEnd);
		L.RegFunction("TestDuringInteract", TestDuringInteract);
		L.RegFunction("SetCurInteractToLowPriority", SetCurInteractToLowPriority);
		L.RegFunction("PutEntityAtWithRot", PutEntityAtWithRot);
		L.RegFunction("PutEntityAtWithScale", PutEntityAtWithScale);
		L.RegFunction("PutEntityAt", PutEntityAt);
		L.RegFunction("PutEntityLookToDir", PutEntityLookToDir);
		L.RegFunction("PutEntityLookAt", PutEntityLookAt);
		L.RegFunction("IlluSetWallMaterial", IlluSetWallMaterial);
		L.RegFunction("GetTransform", GetTransform);
		L.RegFunction("PlayerControlEntity", PlayerControlEntity);
		L.RegFunction("TryTriggerResetAnimeDuringMove", TryTriggerResetAnimeDuringMove);
		L.RegFunction("StopAllCmd", StopAllCmd);
		L.RegFunction("StopCurRunningCmd", StopCurRunningCmd);
		L.RegFunction("SendMoveCMD", SendMoveCMD);
		L.RegFunction("SendMoveLookAtCMD", SendMoveLookAtCMD);
		L.RegFunction("SendMoveLookToDirCMD", SendMoveLookToDirCMD);
		L.RegFunction("SendRndWanderMoveCMD", SendRndWanderMoveCMD);
		L.RegFunction("SendRndResumeWanderCMD", SendRndResumeWanderCMD);
		L.RegFunction("SendPatrolCMD", SendPatrolCMD);
		L.RegFunction("SendInteractToEntityCMD", SendInteractToEntityCMD);
		L.RegFunction("TryExecuteInteractToEntityImmediate", TryExecuteInteractToEntityImmediate);
		L.RegFunction("SendDoActionCMD", SendDoActionCMD);
		L.RegFunction("PlayAnimeDuringInteract", PlayAnimeDuringInteract);
		L.RegFunction("IsSameAnimeAction", IsSameAnimeAction);
		L.RegFunction("IsStandAnime", IsStandAnime);
		L.RegFunction("IsIdleAnime", IsIdleAnime);
		L.RegFunction("IsMoveAnime", IsMoveAnime);
		L.RegFunction("AttachToEntityCMD", AttachToEntityCMD);
		L.RegFunction("DetachFromEntityCMD", DetachFromEntityCMD);
		L.RegFunction("GrabItemPartCMD", GrabItemPartCMD);
		L.RegFunction("RestoreItemPartCMD", RestoreItemPartCMD);
		L.RegFunction("SetPartVisible", SetPartVisible);
		L.RegFunction("SetEntityMobility", SetEntityMobility);
		L.RegFunction("SetEntitySpeed", SetEntitySpeed);
		L.RegFunction("SetNextIdleNoCrossFade", SetNextIdleNoCrossFade);
		L.RegFunction("SetResumeWanderIgnoreScan", SetResumeWanderIgnoreScan);
		L.RegFunction("SetFadeCMD", SetFadeCMD);
		L.RegFunction("StartFadeInCMD", StartFadeInCMD);
		L.RegFunction("StartFadeOutCMD", StartFadeOutCMD);
		L.RegFunction("SetFlashColor", SetFlashColor);
		L.RegFunction("SetFlashRatio", SetFlashRatio);
		L.RegFunction("StartFlash", StartFlash);
		L.RegFunction("SetDefaultMouth", SetDefaultMouth);
		L.RegFunction("RestoreFacialExpression", RestoreFacialExpression);
		L.RegFunction("SetFacialExpression", SetFacialExpression);
		L.RegFunction("PlaySpacialFacileExpression", PlaySpacialFacileExpression);
		L.RegFunction("PlayNormalFacileExpression", PlayNormalFacileExpression);
		L.RegFunction("PlayEffect", PlayEffect);
		L.RegFunction("PlayEffectDetached", PlayEffectDetached);
		L.RegFunction("CheckIsVariant", CheckIsVariant);
		L.RegFunction("ClearAllEffect", ClearAllEffect);
		L.RegFunction("ClearAllEffectOnAttachPoint", ClearAllEffectOnAttachPoint);
		L.RegFunction("ClearInteractEffectOnAttachPoint", ClearInteractEffectOnAttachPoint);
		L.RegFunction("FadeOutNearPoint", FadeOutNearPoint);
		L.RegFunction("ClearFadeOutPoint", ClearFadeOutPoint);
		L.RegFunction("SetEntityVisible", SetEntityVisible);
		L.RegFunction("ChangeEntityAnimeScheme", ChangeEntityAnimeScheme);
		L.RegFunction("RestoreEntityAnimeScheme", RestoreEntityAnimeScheme);
		L.RegFunction("SetEntityDefaultAnimeScheme", SetEntityDefaultAnimeScheme);
		L.RegFunction("SetHighlighted", SetHighlighted);
		L.RegFunction("SendCmd", SendCmd);
		L.RegFunction("SetPlayerEntityFaceToCam", SetPlayerEntityFaceToCam);
		L.RegFunction("SetPlayerMainColliderEnabled", SetPlayerMainColliderEnabled);
		L.RegFunction("SpawnPlayerEntity", SpawnPlayerEntity);
		L.RegFunction("SpawnEntity", SpawnEntity);
		L.RegFunction("SpawnEntityAndReplace", SpawnEntityAndReplace);
		L.RegFunction("MakeModelEntity", MakeModelEntity);
		L.RegFunction("ClearEntity", ClearEntity);
		L.RegFunction("RemoveEntity", RemoveEntity);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegConstant("INVALID_ENTITY_ID", 0.0);
		L.RegConstant("ENTITY_ID_START", 1.0);
		L.RegVar("INTERACT_TYPE_VFX", get_INTERACT_TYPE_VFX, null);
		L.RegVar("Instance", get_Instance, null);
		L.RegVar("GlobalPlayerInteractChance", get_GlobalPlayerInteractChance, set_GlobalPlayerInteractChance);
		L.RegVar("EnablePlayerInput", get_EnablePlayerInput, set_EnablePlayerInput);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsValidEntityID(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = DormEntityManager.IsValidEntityID((int)LuaDLL.luaL_checknumber(L, 1));
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int QueryForwardDir(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Vector3 v = DormEntityManager.QueryForwardDir((int)LuaDLL.luaL_checknumber(L, 1));
			ToLua.Push(L, v);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int QueryPosition(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Vector3 v = DormEntityManager.QueryPosition((int)LuaDLL.luaL_checknumber(L, 1));
			ToLua.Push(L, v);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int QueryEntityAttachPointWorldPos(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
			string attachPoint = ToLua.CheckString(L, 2);
			Vector3 v = DormEntityManager.QueryEntityAttachPointWorldPos(entityID, attachPoint);
			ToLua.Push(L, v);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetEntityInteractPoint(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
			int interactID = (int)LuaDLL.luaL_checknumber(L, 2);
			Transform entityInteractPoint = DormEntityManager.GetEntityInteractPoint(entityID, interactID);
			ToLua.Push(L, entityInteractPoint);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetFurnitureInteractID(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int furnitureInteractID = DormEntityManager.GetFurnitureInteractID((int)LuaDLL.luaL_checknumber(L, 1));
			LuaDLL.lua_pushinteger(L, furnitureInteractID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int QueryGridPos(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Vector3 v = DormEntityManager.QueryGridPos((int)LuaDLL.luaL_checknumber(L, 1));
			ToLua.Push(L, v);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int QueryRadius(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float num = DormEntityManager.QueryRadius((int)LuaDLL.luaL_checknumber(L, 1));
			LuaDLL.lua_pushnumber(L, num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int QueryProvideInteraction(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int hostID = (int)LuaDLL.luaL_checknumber(L, 1);
			int entityID = (int)LuaDLL.luaL_checknumber(L, 2);
			bool value = DormEntityManager.QueryProvideInteraction(hostID, entityID);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int QueryMobility(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = DormEntityManager.QueryMobility((int)LuaDLL.luaL_checknumber(L, 1));
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int QuerySpeed(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float num = DormEntityManager.QuerySpeed((int)LuaDLL.luaL_checknumber(L, 1));
			LuaDLL.lua_pushnumber(L, num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetGridIndex(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int gridIndex = DormEntityManager.GetGridIndex(ToLua.ToVector3(L, 1));
			LuaDLL.lua_pushinteger(L, gridIndex);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetGridPos(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Vector3Int gridPos = DormEntityManager.GetGridPos(ToLua.ToVector3(L, 1));
			ToLua.PushValue(L, gridPos);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetRelativePointWorldPos(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Vector3 pos = ToLua.ToVector3(L, 1);
			int entityID = (int)LuaDLL.luaL_checknumber(L, 2);
			Vector3 relativePointWorldPos = DormEntityManager.GetRelativePointWorldPos(pos, entityID);
			ToLua.Push(L, relativePointWorldPos);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int KeepAsInteractNotEnd(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
			int targetID = (int)LuaDLL.luaL_checknumber(L, 2);
			bool value = LuaDLL.luaL_checkboolean(L, 3);
			DormEntityManager.KeepAsInteractNotEnd(entityID, targetID, value);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int TestDuringInteract(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				bool value2 = DormEntityManager.TestDuringInteract((int)LuaDLL.luaL_checknumber(L, 1));
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			case 2:
			{
				int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
				bool considerKeepAsInteract = LuaDLL.luaL_checkboolean(L, 2);
				bool value = DormEntityManager.TestDuringInteract(entityID, considerKeepAsInteract);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Dorm.DormEntityManager.TestDuringInteract");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetCurInteractToLowPriority(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			DormEntityManager.SetCurInteractToLowPriority((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PutEntityAtWithRot(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
			Vector3 position = ToLua.ToVector3(L, 2);
			Quaternion rotation = ToLua.ToQuaternion(L, 3);
			DormEntityManager.PutEntityAtWithRot(entityID, position, rotation);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PutEntityAtWithScale(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
			Vector3 position = ToLua.ToVector3(L, 2);
			Vector3 scale = ToLua.ToVector3(L, 3);
			DormEntityManager.PutEntityAtWithScale(entityID, position, scale);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PutEntityAt(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<Vector3>(L, 2))
			{
				int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
				Vector3 referancePoint = ToLua.ToVector3(L, 2);
				DormEntityManager.PutEntityAt(entityID, referancePoint);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<Transform>(L, 2))
			{
				int entityID2 = (int)LuaDLL.luaL_checknumber(L, 1);
				Transform referancePoint2 = (Transform)ToLua.ToObject(L, 2);
				DormEntityManager.PutEntityAt(entityID2, referancePoint2);
				return 0;
			}
			if (num == 3)
			{
				int entityID3 = (int)LuaDLL.luaL_checknumber(L, 1);
				int referaceTarget = (int)LuaDLL.luaL_checknumber(L, 2);
				string attachPoint = ToLua.CheckString(L, 3);
				DormEntityManager.PutEntityAt(entityID3, referaceTarget, attachPoint);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: Dorm.DormEntityManager.PutEntityAt");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PutEntityLookToDir(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
			Vector3 position = ToLua.ToVector3(L, 2);
			Vector3 lookDir = ToLua.ToVector3(L, 3);
			DormEntityManager.PutEntityLookToDir(entityID, position, lookDir);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PutEntityLookAt(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
			Vector3 position = ToLua.ToVector3(L, 2);
			Vector3 lookAt = ToLua.ToVector3(L, 3);
			DormEntityManager.PutEntityLookAt(entityID, position, lookAt);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IlluSetWallMaterial(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
			string path = ToLua.CheckString(L, 2);
			DormEntityManager.IlluSetWallMaterial(entityID, path);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetTransform(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Transform transform = DormEntityManager.GetTransform((int)LuaDLL.luaL_checknumber(L, 1));
			ToLua.Push(L, transform);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlayerControlEntity(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			switch (num)
			{
			case 1:
				DormEntityManager.PlayerControlEntity((int)LuaDLL.luaL_checknumber(L, 1));
				return 0;
			case 2:
				if (TypeChecker.CheckTypes<Vector3>(L, 2))
				{
					int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
					Vector3 fixedLookingDir = ToLua.ToVector3(L, 2);
					DormEntityManager.PlayerControlEntity(entityID, fixedLookingDir);
					return 0;
				}
				break;
			}
			if (num == 2 && TypeChecker.CheckTypes<Transform>(L, 2))
			{
				int entityID2 = (int)LuaDLL.luaL_checknumber(L, 1);
				Transform lookingTarget = (Transform)ToLua.ToObject(L, 2);
				DormEntityManager.PlayerControlEntity(entityID2, lookingTarget);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: Dorm.DormEntityManager.PlayerControlEntity");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int TryTriggerResetAnimeDuringMove(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			DormEntityManager.TryTriggerResetAnimeDuringMove((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StopAllCmd(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			DormEntityManager.StopAllCmd((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StopCurRunningCmd(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			DormEntityManager.StopCurRunningCmd((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SendMoveCMD(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				int entityID3 = (int)LuaDLL.luaL_checknumber(L, 1);
				Vector3 targetPos3 = ToLua.ToVector3(L, 2);
				bool value3 = DormEntityManager.SendMoveCMD(entityID3, targetPos3);
				LuaDLL.lua_pushboolean(L, value3);
				return 1;
			}
			case 3:
			{
				int entityID2 = (int)LuaDLL.luaL_checknumber(L, 1);
				Vector3 targetPos2 = ToLua.ToVector3(L, 2);
				bool ignorePathFinding2 = LuaDLL.luaL_checkboolean(L, 3);
				bool value2 = DormEntityManager.SendMoveCMD(entityID2, targetPos2, ignorePathFinding2);
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			case 4:
			{
				int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
				Vector3 targetPos = ToLua.ToVector3(L, 2);
				bool ignorePathFinding = LuaDLL.luaL_checkboolean(L, 3);
				bool queue = LuaDLL.luaL_checkboolean(L, 4);
				bool value = DormEntityManager.SendMoveCMD(entityID, targetPos, ignorePathFinding, queue);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Dorm.DormEntityManager.SendMoveCMD");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SendMoveLookAtCMD(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				int entityID3 = (int)LuaDLL.luaL_checknumber(L, 1);
				Vector3 targetPos3 = ToLua.ToVector3(L, 2);
				Vector3 lookAt3 = ToLua.ToVector3(L, 3);
				bool value3 = DormEntityManager.SendMoveLookAtCMD(entityID3, targetPos3, lookAt3);
				LuaDLL.lua_pushboolean(L, value3);
				return 1;
			}
			case 4:
			{
				int entityID2 = (int)LuaDLL.luaL_checknumber(L, 1);
				Vector3 targetPos2 = ToLua.ToVector3(L, 2);
				Vector3 lookAt2 = ToLua.ToVector3(L, 3);
				bool ignorePathFinding2 = LuaDLL.luaL_checkboolean(L, 4);
				bool value2 = DormEntityManager.SendMoveLookAtCMD(entityID2, targetPos2, lookAt2, ignorePathFinding2);
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			case 5:
			{
				int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
				Vector3 targetPos = ToLua.ToVector3(L, 2);
				Vector3 lookAt = ToLua.ToVector3(L, 3);
				bool ignorePathFinding = LuaDLL.luaL_checkboolean(L, 4);
				bool queue = LuaDLL.luaL_checkboolean(L, 5);
				bool value = DormEntityManager.SendMoveLookAtCMD(entityID, targetPos, lookAt, ignorePathFinding, queue);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Dorm.DormEntityManager.SendMoveLookAtCMD");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SendMoveLookToDirCMD(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			switch (num)
			{
			case 2:
			{
				int entityID2 = (int)LuaDLL.luaL_checknumber(L, 1);
				Transform target = (Transform)ToLua.CheckObject<Transform>(L, 2);
				bool value2 = DormEntityManager.SendMoveLookToDirCMD(entityID2, target);
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			case 3:
				if (TypeChecker.CheckTypes<Vector3, Vector3>(L, 2))
				{
					int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
					Vector3 targetPos = ToLua.ToVector3(L, 2);
					Vector3 lookToDir = ToLua.ToVector3(L, 3);
					bool value = DormEntityManager.SendMoveLookToDirCMD(entityID, targetPos, lookToDir);
					LuaDLL.lua_pushboolean(L, value);
					return 1;
				}
				break;
			}
			if (num == 3 && TypeChecker.CheckTypes<Transform, bool>(L, 2))
			{
				int entityID3 = (int)LuaDLL.luaL_checknumber(L, 1);
				Transform target2 = (Transform)ToLua.ToObject(L, 2);
				bool ignorePathFinding = LuaDLL.lua_toboolean(L, 3);
				bool value3 = DormEntityManager.SendMoveLookToDirCMD(entityID3, target2, ignorePathFinding);
				LuaDLL.lua_pushboolean(L, value3);
				return 1;
			}
			if (num == 4 && TypeChecker.CheckTypes<Vector3, Vector3, bool>(L, 2))
			{
				int entityID4 = (int)LuaDLL.luaL_checknumber(L, 1);
				Vector3 targetPos2 = ToLua.ToVector3(L, 2);
				Vector3 lookToDir2 = ToLua.ToVector3(L, 3);
				bool ignorePathFinding2 = LuaDLL.lua_toboolean(L, 4);
				bool value4 = DormEntityManager.SendMoveLookToDirCMD(entityID4, targetPos2, lookToDir2, ignorePathFinding2);
				LuaDLL.lua_pushboolean(L, value4);
				return 1;
			}
			if (num == 4 && TypeChecker.CheckTypes<Transform, bool, bool>(L, 2))
			{
				int entityID5 = (int)LuaDLL.luaL_checknumber(L, 1);
				Transform target3 = (Transform)ToLua.ToObject(L, 2);
				bool ignorePathFinding3 = LuaDLL.lua_toboolean(L, 3);
				bool queue = LuaDLL.lua_toboolean(L, 4);
				bool value5 = DormEntityManager.SendMoveLookToDirCMD(entityID5, target3, ignorePathFinding3, queue);
				LuaDLL.lua_pushboolean(L, value5);
				return 1;
			}
			if (num == 5)
			{
				int entityID6 = (int)LuaDLL.luaL_checknumber(L, 1);
				Vector3 targetPos3 = ToLua.ToVector3(L, 2);
				Vector3 lookToDir3 = ToLua.ToVector3(L, 3);
				bool ignorePathFinding4 = LuaDLL.luaL_checkboolean(L, 4);
				bool queue2 = LuaDLL.luaL_checkboolean(L, 5);
				bool value6 = DormEntityManager.SendMoveLookToDirCMD(entityID6, targetPos3, lookToDir3, ignorePathFinding4, queue2);
				LuaDLL.lua_pushboolean(L, value6);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: Dorm.DormEntityManager.SendMoveLookToDirCMD");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SendRndWanderMoveCMD(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				int entityID2 = (int)LuaDLL.luaL_checknumber(L, 1);
				float maxDistance2 = (float)LuaDLL.luaL_checknumber(L, 2);
				bool value2 = DormEntityManager.SendRndWanderMoveCMD(entityID2, maxDistance2);
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			case 3:
			{
				int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
				float maxDistance = (float)LuaDLL.luaL_checknumber(L, 2);
				bool queue = LuaDLL.luaL_checkboolean(L, 3);
				bool value = DormEntityManager.SendRndWanderMoveCMD(entityID, maxDistance, queue);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Dorm.DormEntityManager.SendRndWanderMoveCMD");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SendRndResumeWanderCMD(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				int entityID2 = (int)LuaDLL.luaL_checknumber(L, 1);
				float maxDistance2 = (float)LuaDLL.luaL_checknumber(L, 2);
				bool value2 = DormEntityManager.SendRndResumeWanderCMD(entityID2, maxDistance2);
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			case 3:
			{
				int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
				float maxDistance = (float)LuaDLL.luaL_checknumber(L, 2);
				bool queue = LuaDLL.luaL_checkboolean(L, 3);
				bool value = DormEntityManager.SendRndResumeWanderCMD(entityID, maxDistance, queue);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Dorm.DormEntityManager.SendRndResumeWanderCMD");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SendPatrolCMD(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 4:
			{
				int entityID2 = (int)LuaDLL.luaL_checknumber(L, 1);
				CinemachinePathBase path2 = (CinemachinePathBase)ToLua.CheckObject<CinemachinePathBase>(L, 2);
				bool reverse2 = LuaDLL.luaL_checkboolean(L, 3);
				bool queue2 = LuaDLL.luaL_checkboolean(L, 4);
				bool value2 = DormEntityManager.SendPatrolCMD(entityID2, path2, reverse2, queue2);
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			case 5:
			{
				int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
				CinemachinePathBase path = (CinemachinePathBase)ToLua.CheckObject<CinemachinePathBase>(L, 2);
				bool reverse = LuaDLL.luaL_checkboolean(L, 3);
				float offset = (float)LuaDLL.luaL_checknumber(L, 4);
				bool queue = LuaDLL.luaL_checkboolean(L, 5);
				bool value = DormEntityManager.SendPatrolCMD(entityID, path, reverse, offset, queue);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Dorm.DormEntityManager.SendPatrolCMD");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SendInteractToEntityCMD(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				int entityID2 = (int)LuaDLL.luaL_checknumber(L, 1);
				int otherEntity2 = (int)LuaDLL.luaL_checknumber(L, 2);
				bool queue2 = LuaDLL.luaL_checkboolean(L, 3);
				bool value2 = DormEntityManager.SendInteractToEntityCMD(entityID2, otherEntity2, queue2);
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			case 4:
			{
				int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
				int otherEntity = (int)LuaDLL.luaL_checknumber(L, 2);
				int action = (int)LuaDLL.luaL_checknumber(L, 3);
				bool queue = LuaDLL.luaL_checkboolean(L, 4);
				bool value = DormEntityManager.SendInteractToEntityCMD(entityID, otherEntity, action, queue);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Dorm.DormEntityManager.SendInteractToEntityCMD");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int TryExecuteInteractToEntityImmediate(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				int entityID2 = (int)LuaDLL.luaL_checknumber(L, 1);
				int otherEntity2 = (int)LuaDLL.luaL_checknumber(L, 2);
				bool value2 = DormEntityManager.TryExecuteInteractToEntityImmediate(entityID2, otherEntity2);
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			case 3:
			{
				int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
				int otherEntity = (int)LuaDLL.luaL_checknumber(L, 2);
				int action = (int)LuaDLL.luaL_checknumber(L, 3);
				bool value = DormEntityManager.TryExecuteInteractToEntityImmediate(entityID, otherEntity, action);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Dorm.DormEntityManager.TryExecuteInteractToEntityImmediate");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SendDoActionCMD(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				int entityID4 = (int)LuaDLL.luaL_checknumber(L, 1);
				string animeName4 = ToLua.CheckString(L, 2);
				bool queue4 = LuaDLL.luaL_checkboolean(L, 3);
				bool value4 = DormEntityManager.SendDoActionCMD(entityID4, animeName4, queue4);
				LuaDLL.lua_pushboolean(L, value4);
				return 1;
			}
			case 4:
			{
				int entityID3 = (int)LuaDLL.luaL_checknumber(L, 1);
				string animeName3 = ToLua.CheckString(L, 2);
				string animeSubType3 = ToLua.CheckString(L, 3);
				bool queue3 = LuaDLL.luaL_checkboolean(L, 4);
				bool value3 = DormEntityManager.SendDoActionCMD(entityID3, animeName3, animeSubType3, queue3);
				LuaDLL.lua_pushboolean(L, value3);
				return 1;
			}
			case 5:
			{
				int entityID2 = (int)LuaDLL.luaL_checknumber(L, 1);
				string animeName2 = ToLua.CheckString(L, 2);
				string animeSubType2 = ToLua.CheckString(L, 3);
				bool loop2 = LuaDLL.luaL_checkboolean(L, 4);
				bool queue2 = LuaDLL.luaL_checkboolean(L, 5);
				bool value2 = DormEntityManager.SendDoActionCMD(entityID2, animeName2, animeSubType2, loop2, queue2);
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			case 6:
			{
				int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
				string animeName = ToLua.CheckString(L, 2);
				string animeSubType = ToLua.CheckString(L, 3);
				bool loop = LuaDLL.luaL_checkboolean(L, 4);
				float crossFade = (float)LuaDLL.luaL_checknumber(L, 5);
				bool queue = LuaDLL.luaL_checkboolean(L, 6);
				bool value = DormEntityManager.SendDoActionCMD(entityID, animeName, animeSubType, loop, crossFade, queue);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Dorm.DormEntityManager.SendDoActionCMD");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlayAnimeDuringInteract(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				int entityID3 = (int)LuaDLL.luaL_checknumber(L, 1);
				string animeName3 = ToLua.CheckString(L, 2);
				DormEntityManager.PlayAnimeDuringInteract(entityID3, animeName3);
				return 0;
			}
			case 3:
			{
				int entityID2 = (int)LuaDLL.luaL_checknumber(L, 1);
				string animeName2 = ToLua.CheckString(L, 2);
				string animeSubName2 = ToLua.CheckString(L, 3);
				DormEntityManager.PlayAnimeDuringInteract(entityID2, animeName2, animeSubName2);
				return 0;
			}
			case 4:
			{
				int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
				string animeName = ToLua.CheckString(L, 2);
				string animeSubName = ToLua.CheckString(L, 3);
				float transDuration = (float)LuaDLL.luaL_checknumber(L, 4);
				DormEntityManager.PlayAnimeDuringInteract(entityID, animeName, animeSubName, transDuration);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Dorm.DormEntityManager.PlayAnimeDuringInteract");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsSameAnimeAction(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			string action = ToLua.CheckString(L, 1);
			string action2 = ToLua.CheckString(L, 2);
			bool value = DormEntityManager.IsSameAnimeAction(action, action2);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsStandAnime(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
			string action = ToLua.CheckString(L, 2);
			bool value = DormEntityManager.IsStandAnime(entityID, action);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsIdleAnime(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
			string action = ToLua.CheckString(L, 2);
			bool value = DormEntityManager.IsIdleAnime(entityID, action);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsMoveAnime(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
			string action = ToLua.CheckString(L, 2);
			bool value = DormEntityManager.IsMoveAnime(entityID, action);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AttachToEntityCMD(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				int child2 = (int)LuaDLL.luaL_checknumber(L, 1);
				int parent2 = (int)LuaDLL.luaL_checknumber(L, 2);
				string attachPoint2 = ToLua.CheckString(L, 3);
				DormEntityManager.AttachToEntityCMD(child2, parent2, attachPoint2);
				return 0;
			}
			case 4:
			{
				int child = (int)LuaDLL.luaL_checknumber(L, 1);
				int parent = (int)LuaDLL.luaL_checknumber(L, 2);
				string attachPoint = ToLua.CheckString(L, 3);
				bool setAsChild = LuaDLL.luaL_checkboolean(L, 4);
				DormEntityManager.AttachToEntityCMD(child, parent, attachPoint, setAsChild);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Dorm.DormEntityManager.AttachToEntityCMD");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DetachFromEntityCMD(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			DormEntityManager.DetachFromEntityCMD((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GrabItemPartCMD(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				int entity2 = (int)LuaDLL.luaL_checknumber(L, 1);
				int itemHost2 = (int)LuaDLL.luaL_checknumber(L, 2);
				string itemPart2 = ToLua.CheckString(L, 3);
				DormEntityManager.GrabItemPartCMD(entity2, itemHost2, itemPart2);
				return 0;
			}
			case 4:
			{
				int entity = (int)LuaDLL.luaL_checknumber(L, 1);
				int itemHost = (int)LuaDLL.luaL_checknumber(L, 2);
				string itemPart = ToLua.CheckString(L, 3);
				string attachPoint = ToLua.CheckString(L, 4);
				DormEntityManager.GrabItemPartCMD(entity, itemHost, itemPart, attachPoint);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Dorm.DormEntityManager.GrabItemPartCMD");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RestoreItemPartCMD(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int itemHost = (int)LuaDLL.luaL_checknumber(L, 1);
			string itemPart = ToLua.CheckString(L, 2);
			DormEntityManager.RestoreItemPartCMD(itemHost, itemPart);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetPartVisible(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				int itemHost2 = (int)LuaDLL.luaL_checknumber(L, 1);
				string itemPart2 = ToLua.CheckString(L, 2);
				bool value2 = LuaDLL.luaL_checkboolean(L, 3);
				DormEntityManager.SetPartVisible(itemHost2, itemPart2, value2);
				return 0;
			}
			case 4:
			{
				int itemHost = (int)LuaDLL.luaL_checknumber(L, 1);
				string itemPart = ToLua.CheckString(L, 2);
				bool value = LuaDLL.luaL_checkboolean(L, 3);
				bool modifyRenderer = LuaDLL.luaL_checkboolean(L, 4);
				DormEntityManager.SetPartVisible(itemHost, itemPart, value, modifyRenderer);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Dorm.DormEntityManager.SetPartVisible");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetEntityMobility(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
			bool movable = LuaDLL.luaL_checkboolean(L, 2);
			DormEntityManager.SetEntityMobility(entityID, movable);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetEntitySpeed(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
			float speed = (float)LuaDLL.luaL_checknumber(L, 2);
			DormEntityManager.SetEntitySpeed(entityID, speed);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetNextIdleNoCrossFade(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
			bool value = LuaDLL.luaL_checkboolean(L, 2);
			DormEntityManager.SetNextIdleNoCrossFade(entityID, value);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetResumeWanderIgnoreScan(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
			int ignore = (int)LuaDLL.luaL_checknumber(L, 2);
			DormEntityManager.SetResumeWanderIgnoreScan(entityID, ignore);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetFadeCMD(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
			float value = (float)LuaDLL.luaL_checknumber(L, 2);
			DormEntityManager.SetFadeCMD(entityID, value);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StartFadeInCMD(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				int entityID2 = (int)LuaDLL.luaL_checknumber(L, 1);
				float duration2 = (float)LuaDLL.luaL_checknumber(L, 2);
				DormEntityManager.StartFadeInCMD(entityID2, duration2);
				return 0;
			}
			case 3:
			{
				int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
				float duration = (float)LuaDLL.luaL_checknumber(L, 2);
				Action afterFadeIn = (Action)ToLua.CheckDelegate<Action>(L, 3);
				DormEntityManager.StartFadeInCMD(entityID, duration, afterFadeIn);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Dorm.DormEntityManager.StartFadeInCMD");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StartFadeOutCMD(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				int entityID2 = (int)LuaDLL.luaL_checknumber(L, 1);
				float duration2 = (float)LuaDLL.luaL_checknumber(L, 2);
				DormEntityManager.StartFadeOutCMD(entityID2, duration2);
				return 0;
			}
			case 3:
			{
				int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
				float duration = (float)LuaDLL.luaL_checknumber(L, 2);
				Action afterFadeOut = (Action)ToLua.CheckDelegate<Action>(L, 3);
				DormEntityManager.StartFadeOutCMD(entityID, duration, afterFadeOut);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Dorm.DormEntityManager.StartFadeOutCMD");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetFlashColor(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
			Color outer = ToLua.ToColor(L, 2);
			Color inner = ToLua.ToColor(L, 3);
			float soft = (float)LuaDLL.luaL_checknumber(L, 4);
			DormEntityManager.SetFlashColor(entityID, outer, inner, soft);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetFlashRatio(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
			float ratio = (float)LuaDLL.luaL_checknumber(L, 2);
			DormEntityManager.SetFlashRatio(entityID, ratio);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StartFlash(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				int entityID2 = (int)LuaDLL.luaL_checknumber(L, 1);
				float duration2 = (float)LuaDLL.luaL_checknumber(L, 2);
				DormEntityManager.StartFlash(entityID2, duration2);
				return 0;
			}
			case 3:
			{
				int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
				float duration = (float)LuaDLL.luaL_checknumber(L, 2);
				AnimationCurve curve = (AnimationCurve)ToLua.CheckObject<AnimationCurve>(L, 3);
				DormEntityManager.StartFlash(entityID, duration, curve);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Dorm.DormEntityManager.StartFlash");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetDefaultMouth(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
			int mouth = (int)LuaDLL.luaL_checknumber(L, 2);
			DormEntityManager.SetDefaultMouth(entityID, mouth);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RestoreFacialExpression(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = DormEntityManager.RestoreFacialExpression((int)LuaDLL.luaL_checknumber(L, 1));
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetFacialExpression(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int? entityID = ToLua.CheckNullable<int>(L, 1);
			int faceExprID = (int)LuaDLL.luaL_checknumber(L, 2);
			bool value = DormEntityManager.SetFacialExpression(entityID, faceExprID);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlaySpacialFacileExpression(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
			string faceFxPath = ToLua.CheckString(L, 2);
			float duration = (float)LuaDLL.luaL_checknumber(L, 3);
			DormEntityManager.PlaySpacialFacileExpression(entityID, faceFxPath, duration);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlayNormalFacileExpression(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
			string faceEmoteState = ToLua.CheckString(L, 2);
			string faceEmoteSubState = ToLua.CheckString(L, 3);
			float crossFade = (float)LuaDLL.luaL_checknumber(L, 4);
			DormEntityManager.PlayNormalFacileExpression(entityID, faceEmoteState, faceEmoteSubState, crossFade);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlayEffect(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 4:
			{
				int entityID4 = (int)LuaDLL.luaL_checknumber(L, 1);
				string attachPoint4 = ToLua.CheckString(L, 2);
				string efxPath4 = ToLua.CheckString(L, 3);
				float duration4 = (float)LuaDLL.luaL_checknumber(L, 4);
				DormEntityManager.PlayEffect(entityID4, attachPoint4, efxPath4, duration4);
				return 0;
			}
			case 5:
			{
				int entityID3 = (int)LuaDLL.luaL_checknumber(L, 1);
				string attachPoint3 = ToLua.CheckString(L, 2);
				string vfxType2 = ToLua.CheckString(L, 3);
				string efxPath3 = ToLua.CheckString(L, 4);
				float duration3 = (float)LuaDLL.luaL_checknumber(L, 5);
				DormEntityManager.PlayEffect(entityID3, attachPoint3, vfxType2, efxPath3, duration3);
				return 0;
			}
			case 7:
			{
				int entityID2 = (int)LuaDLL.luaL_checknumber(L, 1);
				string attachPoint2 = ToLua.CheckString(L, 2);
				string efxPath2 = ToLua.CheckString(L, 3);
				Vector3 offset2 = ToLua.ToVector3(L, 4);
				Quaternion rotation2 = ToLua.ToQuaternion(L, 5);
				Vector3 localScale2 = ToLua.ToVector3(L, 6);
				float duration2 = (float)LuaDLL.luaL_checknumber(L, 7);
				DormEntityManager.PlayEffect(entityID2, attachPoint2, efxPath2, offset2, rotation2, localScale2, duration2);
				return 0;
			}
			case 8:
			{
				int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
				string attachPoint = ToLua.CheckString(L, 2);
				string vfxType = ToLua.CheckString(L, 3);
				string efxPath = ToLua.CheckString(L, 4);
				Vector3 offset = ToLua.ToVector3(L, 5);
				Quaternion rotation = ToLua.ToQuaternion(L, 6);
				Vector3 localScale = ToLua.ToVector3(L, 7);
				float duration = (float)LuaDLL.luaL_checknumber(L, 8);
				DormEntityManager.PlayEffect(entityID, attachPoint, vfxType, efxPath, offset, rotation, localScale, duration);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Dorm.DormEntityManager.PlayEffect");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlayEffectDetached(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
			string attachPoint = ToLua.CheckString(L, 2);
			string efxPath = ToLua.CheckString(L, 3);
			float duration = (float)LuaDLL.luaL_checknumber(L, 4);
			DormEntityManager.PlayEffectDetached(entityID, attachPoint, efxPath, duration);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CheckIsVariant(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = DormEntityManager.CheckIsVariant((int)LuaDLL.luaL_checknumber(L, 1));
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearAllEffect(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
			string vfxType = ToLua.CheckString(L, 2);
			DormEntityManager.ClearAllEffect(entityID, vfxType);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearAllEffectOnAttachPoint(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
			string attachPoint = ToLua.CheckString(L, 2);
			DormEntityManager.ClearAllEffectOnAttachPoint(entityID, attachPoint);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearInteractEffectOnAttachPoint(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
			string attachPoint = ToLua.CheckString(L, 2);
			DormEntityManager.ClearInteractEffectOnAttachPoint(entityID, attachPoint);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int FadeOutNearPoint(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<Transform>(L, 2))
			{
				int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
				Transform point = (Transform)ToLua.ToObject(L, 2);
				DormEntityManager.FadeOutNearPoint(entityID, point);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<Vector3>(L, 2))
			{
				int entityID2 = (int)LuaDLL.luaL_checknumber(L, 1);
				Vector3 point2 = ToLua.ToVector3(L, 2);
				DormEntityManager.FadeOutNearPoint(entityID2, point2);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<Transform, float>(L, 2))
			{
				int entityID3 = (int)LuaDLL.luaL_checknumber(L, 1);
				Transform point3 = (Transform)ToLua.ToObject(L, 2);
				float fadeStart = (float)LuaDLL.lua_tonumber(L, 3);
				DormEntityManager.FadeOutNearPoint(entityID3, point3, fadeStart);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<Vector3, float>(L, 2))
			{
				int entityID4 = (int)LuaDLL.luaL_checknumber(L, 1);
				Vector3 point4 = ToLua.ToVector3(L, 2);
				float fadeStart2 = (float)LuaDLL.lua_tonumber(L, 3);
				DormEntityManager.FadeOutNearPoint(entityID4, point4, fadeStart2);
				return 0;
			}
			if (num == 4 && TypeChecker.CheckTypes<Transform, float, float>(L, 2))
			{
				int entityID5 = (int)LuaDLL.luaL_checknumber(L, 1);
				Transform point5 = (Transform)ToLua.ToObject(L, 2);
				float fadeStart3 = (float)LuaDLL.lua_tonumber(L, 3);
				float fadeEnd = (float)LuaDLL.lua_tonumber(L, 4);
				DormEntityManager.FadeOutNearPoint(entityID5, point5, fadeStart3, fadeEnd);
				return 0;
			}
			if (num == 4 && TypeChecker.CheckTypes<Vector3, float, float>(L, 2))
			{
				int entityID6 = (int)LuaDLL.luaL_checknumber(L, 1);
				Vector3 point6 = ToLua.ToVector3(L, 2);
				float fadeStart4 = (float)LuaDLL.lua_tonumber(L, 3);
				float fadeEnd2 = (float)LuaDLL.lua_tonumber(L, 4);
				DormEntityManager.FadeOutNearPoint(entityID6, point6, fadeStart4, fadeEnd2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: Dorm.DormEntityManager.FadeOutNearPoint");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearFadeOutPoint(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			DormEntityManager.ClearFadeOutPoint((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetEntityVisible(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
			bool visible = LuaDLL.luaL_checkboolean(L, 2);
			DormEntityManager.SetEntityVisible(entityID, visible);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ChangeEntityAnimeScheme(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
			string scheme = ToLua.CheckString(L, 2);
			DormEntityManager.ChangeEntityAnimeScheme(entityID, scheme);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RestoreEntityAnimeScheme(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			DormEntityManager.RestoreEntityAnimeScheme((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetEntityDefaultAnimeScheme(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
			string scheme = ToLua.CheckString(L, 2);
			DormEntityManager.SetEntityDefaultAnimeScheme(entityID, scheme);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetHighlighted(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				int entityID2 = (int)LuaDLL.luaL_checknumber(L, 1);
				bool highlight2 = LuaDLL.luaL_checkboolean(L, 2);
				DormEntityManager.SetHighlighted(entityID2, highlight2);
				return 0;
			}
			case 3:
			{
				int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
				bool highlight = LuaDLL.luaL_checkboolean(L, 2);
				int highlightLayer = (int)LuaDLL.luaL_checknumber(L, 3);
				DormEntityManager.SetHighlighted(entityID, highlight, highlightLayer);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Dorm.DormEntityManager.SetHighlighted");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SendCmd(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			DormEntityManager obj = (DormEntityManager)ToLua.CheckObject<DormEntityManager>(L, 1);
			int entityID = (int)LuaDLL.luaL_checknumber(L, 2);
			CmdTask cmd = (CmdTask)ToLua.CheckObject<CmdTask>(L, 3);
			bool queue = LuaDLL.luaL_checkboolean(L, 4);
			obj.SendCmd(entityID, cmd, queue);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetPlayerEntityFaceToCam(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
			bool value = LuaDLL.luaL_checkboolean(L, 2);
			DormEntityManager.SetPlayerEntityFaceToCam(entityID, value);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetPlayerMainColliderEnabled(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
			bool value = LuaDLL.luaL_checkboolean(L, 2);
			DormEntityManager.SetPlayerMainColliderEnabled(entityID, value);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SpawnPlayerEntity(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				DormEntityManager obj2 = (DormEntityManager)ToLua.CheckObject<DormEntityManager>(L, 1);
				string modelPath2 = ToLua.CheckString(L, 2);
				int n2 = obj2.SpawnPlayerEntity(modelPath2);
				LuaDLL.lua_pushinteger(L, n2);
				return 1;
			}
			case 3:
			{
				DormEntityManager obj = (DormEntityManager)ToLua.CheckObject<DormEntityManager>(L, 1);
				string modelPath = ToLua.CheckString(L, 2);
				Transform spawn = (Transform)ToLua.CheckObject<Transform>(L, 3);
				int n = obj.SpawnPlayerEntity(modelPath, spawn);
				LuaDLL.lua_pushinteger(L, n);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Dorm.DormEntityManager.SpawnPlayerEntity");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SpawnEntity(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 5);
			DormEntityManager obj = (DormEntityManager)ToLua.CheckObject<DormEntityManager>(L, 1);
			string modelPath = ToLua.CheckString(L, 2);
			Transform spawn = (Transform)ToLua.CheckObject<Transform>(L, 3);
			bool complex = LuaDLL.luaL_checkboolean(L, 4);
			bool pooled = LuaDLL.luaL_checkboolean(L, 5);
			int n = obj.SpawnEntity(modelPath, spawn, complex, pooled);
			LuaDLL.lua_pushinteger(L, n);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SpawnEntityAndReplace(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 5);
			DormEntityManager obj = (DormEntityManager)ToLua.CheckObject<DormEntityManager>(L, 1);
			int eid = (int)LuaDLL.luaL_checknumber(L, 2);
			string modelPath = ToLua.CheckString(L, 3);
			bool complex = LuaDLL.luaL_checkboolean(L, 4);
			bool pooled = LuaDLL.luaL_checkboolean(L, 5);
			obj.SpawnEntityAndReplace(eid, modelPath, complex, pooled);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int MakeModelEntity(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			DormEntityManager obj = (DormEntityManager)ToLua.CheckObject<DormEntityManager>(L, 1);
			Transform dstModel = (Transform)ToLua.CheckObject<Transform>(L, 2);
			int n = obj.MakeModelEntity(dstModel);
			LuaDLL.lua_pushinteger(L, n);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearEntity(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((DormEntityManager)ToLua.CheckObject<DormEntityManager>(L, 1)).ClearEntity();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RemoveEntity(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<int>(L, 2))
			{
				DormEntityManager obj = (DormEntityManager)ToLua.CheckObject<DormEntityManager>(L, 1);
				int entityID = (int)LuaDLL.lua_tonumber(L, 2);
				obj.RemoveEntity(entityID);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<int[]>(L, 2))
			{
				DormEntityManager obj2 = (DormEntityManager)ToLua.CheckObject<DormEntityManager>(L, 1);
				int[] entityArray = ToLua.ToNumberArray<int>(L, 2);
				obj2.RemoveEntity(entityArray);
				return 0;
			}
			if (num == 3)
			{
				DormEntityManager obj3 = (DormEntityManager)ToLua.CheckObject<DormEntityManager>(L, 1);
				int entityID2 = (int)LuaDLL.luaL_checknumber(L, 2);
				float delay = (float)LuaDLL.luaL_checknumber(L, 3);
				obj3.RemoveEntity(entityID2, delay);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: Dorm.DormEntityManager.RemoveEntity");
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
	private static int get_INTERACT_TYPE_VFX(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, "interact");
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Instance(IntPtr L)
	{
		try
		{
			ToLua.Push(L, DormEntityManager.Instance);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_GlobalPlayerInteractChance(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, DormEntityManager.GlobalPlayerInteractChance);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_EnablePlayerInput(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, DormEntityManager.EnablePlayerInput);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_GlobalPlayerInteractChance(IntPtr L)
	{
		try
		{
			DormEntityManager.GlobalPlayerInteractChance = (float)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_EnablePlayerInput(IntPtr L)
	{
		try
		{
			DormEntityManager.EnablePlayerInput = LuaDLL.luaL_checkboolean(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
