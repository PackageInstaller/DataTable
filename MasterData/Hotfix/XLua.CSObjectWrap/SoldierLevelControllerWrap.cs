using System;
using System.Collections;
using System.Collections.Generic;
using Nova.Hotfix;
using TrueSync;
using XLua.LuaDLL;

namespace XLua.CSObjectWrap;

public class SoldierLevelControllerWrap
{
	public static void __Register(IntPtr L)
	{
		ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
		Type typeFromHandle = typeof(SoldierLevelController);
		Utils.BeginObjectRegister(typeFromHandle, L, translator, 0, 35, 8, 6);
		Utils.RegisterFunc(L, -3, "GetMainControlActor", _m_GetMainControlActor);
		Utils.RegisterFunc(L, -3, "Load", _m_Load);
		Utils.RegisterFunc(L, -3, "LevelStart", _m_LevelStart);
		Utils.RegisterFunc(L, -3, "UpdateLogic", _m_UpdateLogic);
		Utils.RegisterFunc(L, -3, "LevelEnd", _m_LevelEnd);
		Utils.RegisterFunc(L, -3, "NotifySupportPromoted", _m_NotifySupportPromoted);
		Utils.RegisterFunc(L, -3, "CanCastSupportSkill", _m_CanCastSupportSkill);
		Utils.RegisterFunc(L, -3, "MarkSupportCast", _m_MarkSupportCast);
		Utils.RegisterFunc(L, -3, "SpawnSupport", _m_SpawnSupport);
		Utils.RegisterFunc(L, -3, "DecodeData", _m_DecodeData);
		Utils.RegisterFunc(L, -3, "IsCoroutineAlive", _m_IsCoroutineAlive);
		Utils.RegisterFunc(L, -3, "IsCoroutineRunning", _m_IsCoroutineRunning);
		Utils.RegisterFunc(L, -3, "GetCoroutineDeltaTime", _m_GetCoroutineDeltaTime);
		Utils.RegisterFunc(L, -3, "StartLogicCoroutine", _m_StartLogicCoroutine);
		Utils.RegisterFunc(L, -3, "StopLogicCoroutine", _m_StopLogicCoroutine);
		Utils.RegisterFunc(L, -3, "SetSoldierDamageID", _m_SetSoldierDamageID);
		Utils.RegisterFunc(L, -3, "GetBattleActors", _m_GetBattleActors);
		Utils.RegisterFunc(L, -3, "GetSupportActors", _m_GetSupportActors);
		Utils.RegisterFunc(L, -3, "GetAllActors", _m_GetAllActors);
		Utils.RegisterFunc(L, -3, "GetAllActorsAllCamp", _m_GetAllActorsAllCamp);
		Utils.RegisterFunc(L, -3, "GetBattlePartnerCount", _m_GetBattlePartnerCount);
		Utils.RegisterFunc(L, -3, "GetSupportPartnerCount", _m_GetSupportPartnerCount);
		Utils.RegisterFunc(L, -3, "GetAllPartnerCount", _m_GetAllPartnerCount);
		Utils.RegisterFunc(L, -3, "GetPartnerLv", _m_GetPartnerLv);
		Utils.RegisterFunc(L, -3, "GetSoldierPartner", _m_GetSoldierPartner);
		Utils.RegisterFunc(L, -3, "AddItem", _m_AddItem);
		Utils.RegisterFunc(L, -3, "GetHarvestCount", _m_GetHarvestCount);
		Utils.RegisterFunc(L, -3, "SpawnSoldierSummon", _m_SpawnSoldierSummon);
		Utils.RegisterFunc(L, -3, "AddSoldierSummon", _m_AddSoldierSummon);
		Utils.RegisterFunc(L, -3, "MarkSoldierSummonDead", _m_MarkSoldierSummonDead);
		Utils.RegisterFunc(L, -3, "RemoveSoldierSummon", _m_RemoveSoldierSummon);
		Utils.RegisterFunc(L, -3, "RemoveSoldierSummonsBySummoner", _m_RemoveSoldierSummonsBySummoner);
		Utils.RegisterFunc(L, -3, "GetSoldierSummonCount", _m_GetSoldierSummonCount);
		Utils.RegisterFunc(L, -3, "GetSoldierSummonInfos", _m_GetSoldierSummonInfos);
		Utils.RegisterFunc(L, -3, "ClearSoldierSummonData", _m_ClearSoldierSummonData);
		Utils.RegisterFunc(L, -2, "mainControlActor", _g_get_mainControlActor);
		Utils.RegisterFunc(L, -2, "enemyMainControlActor", _g_get_enemyMainControlActor);
		Utils.RegisterFunc(L, -2, "PartnerDic", _g_get_PartnerDic);
		Utils.RegisterFunc(L, -2, "dicSoldierMsg", _g_get_dicSoldierMsg);
		Utils.RegisterFunc(L, -2, "dicSoldierAttr", _g_get_dicSoldierAttr);
		Utils.RegisterFunc(L, -2, "EnemyAmendLv", _g_get_EnemyAmendLv);
		Utils.RegisterFunc(L, -2, "RatioStage", _g_get_RatioStage);
		Utils.RegisterFunc(L, -2, "shopLv", _g_get_shopLv);
		Utils.RegisterFunc(L, -1, "PartnerDic", _s_set_PartnerDic);
		Utils.RegisterFunc(L, -1, "dicSoldierMsg", _s_set_dicSoldierMsg);
		Utils.RegisterFunc(L, -1, "dicSoldierAttr", _s_set_dicSoldierAttr);
		Utils.RegisterFunc(L, -1, "EnemyAmendLv", _s_set_EnemyAmendLv);
		Utils.RegisterFunc(L, -1, "RatioStage", _s_set_RatioStage);
		Utils.RegisterFunc(L, -1, "shopLv", _s_set_shopLv);
		Utils.EndObjectRegister(typeFromHandle, L, translator, null, null, null, null, null);
		Utils.BeginClassRegister(typeFromHandle, L, __CreateInstance, 1, 0, 0);
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
				SoldierLevelController o = new SoldierLevelController();
				objectTranslator.Push(L, o);
				return 1;
			}
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return Lua.luaL_error(L, "invalid arguments to SoldierLevelController constructor!");
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetMainControlActor(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			SoldierLevelController soldierLevelController = (SoldierLevelController)objectTranslator.FastGetCSObj(L, 1);
			bool isEnemyCamp = Lua.lua_toboolean(L, 2);
			SoldierActor mainControlActor = soldierLevelController.GetMainControlActor(isEnemyCamp);
			objectTranslator.Push(L, mainControlActor);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_Load(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			SoldierLevelController soldierLevelController = (SoldierLevelController)objectTranslator.FastGetCSObj(L, 1);
			int num = Lua.lua_gettop(L);
			if (num == 3 && objectTranslator.Assignable<AdventureModuleLevelLoadParams>(L, 2) && objectTranslator.Assignable<Action>(L, 3))
			{
				AdventureModuleLevelLoadParams param = (AdventureModuleLevelLoadParams)objectTranslator.GetObject(L, 2, typeof(AdventureModuleLevelLoadParams));
				Action callback = objectTranslator.GetDelegate<Action>(L, 3);
				soldierLevelController.Load(param, callback);
				return 0;
			}
			if (num == 2 && objectTranslator.Assignable<AdventureModuleLevelLoadParams>(L, 2))
			{
				AdventureModuleLevelLoadParams param2 = (AdventureModuleLevelLoadParams)objectTranslator.GetObject(L, 2, typeof(AdventureModuleLevelLoadParams));
				soldierLevelController.Load(param2);
				return 0;
			}
			if (num == 1)
			{
				soldierLevelController.Load();
				return 0;
			}
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return Lua.luaL_error(L, "invalid arguments to SoldierLevelController.Load!");
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_LevelStart(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			SoldierLevelController soldierLevelController = (SoldierLevelController)objectTranslator.FastGetCSObj(L, 1);
			int num = Lua.lua_gettop(L);
			if (num == 2 && objectTranslator.Assignable<Action>(L, 2))
			{
				Action callback = objectTranslator.GetDelegate<Action>(L, 2);
				soldierLevelController.LevelStart(callback);
				return 0;
			}
			if (num == 1)
			{
				soldierLevelController.LevelStart();
				return 0;
			}
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return Lua.luaL_error(L, "invalid arguments to SoldierLevelController.LevelStart!");
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_UpdateLogic(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			SoldierLevelController soldierLevelController = (SoldierLevelController)objectTranslator.FastGetCSObj(L, 1);
			objectTranslator.Get(L, 2, out FP v);
			soldierLevelController.UpdateLogic(v);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_LevelEnd(IntPtr L)
	{
		try
		{
			((SoldierLevelController)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1)).LevelEnd();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_NotifySupportPromoted(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			SoldierLevelController soldierLevelController = (SoldierLevelController)objectTranslator.FastGetCSObj(L, 1);
			SoldierActor actor = (SoldierActor)objectTranslator.GetObject(L, 2, typeof(SoldierActor));
			soldierLevelController.NotifySupportPromoted(actor);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_CanCastSupportSkill(IntPtr L)
	{
		try
		{
			SoldierLevelController soldierLevelController = (SoldierLevelController)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1);
			int actorId = Lua.xlua_tointeger(L, 2);
			bool isEnemyCamp = Lua.lua_toboolean(L, 3);
			bool value = soldierLevelController.CanCastSupportSkill(actorId, isEnemyCamp);
			Lua.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_MarkSupportCast(IntPtr L)
	{
		try
		{
			SoldierLevelController soldierLevelController = (SoldierLevelController)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1);
			int actorId = Lua.xlua_tointeger(L, 2);
			bool isEnemyCamp = Lua.lua_toboolean(L, 3);
			soldierLevelController.MarkSupportCast(actorId, isEnemyCamp);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SpawnSupport(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			SoldierLevelController soldierLevelController = (SoldierLevelController)objectTranslator.FastGetCSObj(L, 1);
			int num = Lua.lua_gettop(L);
			if (num == 7 && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 2) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 3) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 4) && LuaTypes.LUA_TBOOLEAN == Lua.lua_type(L, 5) && objectTranslator.Assignable<TSVector2>(L, 6) && objectTranslator.Assignable<FP>(L, 7))
			{
				int chessId = Lua.xlua_tointeger(L, 2);
				int potentialLv = Lua.xlua_tointeger(L, 3);
				int enemyCampLv = Lua.xlua_tointeger(L, 4);
				bool isEnemyCamp = Lua.lua_toboolean(L, 5);
				objectTranslator.Get(L, 6, out TSVector2 v);
				objectTranslator.Get(L, 7, out FP v2);
				SoldierActor o = soldierLevelController.SpawnSupport(chessId, potentialLv, enemyCampLv, isEnemyCamp, v, v2);
				objectTranslator.Push(L, o);
				return 1;
			}
			if (num == 6 && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 2) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 3) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 4) && LuaTypes.LUA_TBOOLEAN == Lua.lua_type(L, 5) && objectTranslator.Assignable<TSVector2>(L, 6))
			{
				int chessId2 = Lua.xlua_tointeger(L, 2);
				int potentialLv2 = Lua.xlua_tointeger(L, 3);
				int enemyCampLv2 = Lua.xlua_tointeger(L, 4);
				bool isEnemyCamp2 = Lua.lua_toboolean(L, 5);
				objectTranslator.Get(L, 6, out TSVector2 v3);
				SoldierActor o2 = soldierLevelController.SpawnSupport(chessId2, potentialLv2, enemyCampLv2, isEnemyCamp2, v3);
				objectTranslator.Push(L, o2);
				return 1;
			}
			if (num == 5 && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 2) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 3) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 4) && LuaTypes.LUA_TBOOLEAN == Lua.lua_type(L, 5))
			{
				int chessId3 = Lua.xlua_tointeger(L, 2);
				int potentialLv3 = Lua.xlua_tointeger(L, 3);
				int enemyCampLv3 = Lua.xlua_tointeger(L, 4);
				bool isEnemyCamp3 = Lua.lua_toboolean(L, 5);
				SoldierActor o3 = soldierLevelController.SpawnSupport(chessId3, potentialLv3, enemyCampLv3, isEnemyCamp3);
				objectTranslator.Push(L, o3);
				return 1;
			}
			if (num == 4 && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 2) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 3) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 4))
			{
				int chessId4 = Lua.xlua_tointeger(L, 2);
				int potentialLv4 = Lua.xlua_tointeger(L, 3);
				int enemyCampLv4 = Lua.xlua_tointeger(L, 4);
				SoldierActor o4 = soldierLevelController.SpawnSupport(chessId4, potentialLv4, enemyCampLv4);
				objectTranslator.Push(L, o4);
				return 1;
			}
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return Lua.luaL_error(L, "invalid arguments to SoldierLevelController.SpawnSupport!");
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_DecodeData(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			SoldierLevelController soldierLevelController = (SoldierLevelController)objectTranslator.FastGetCSObj(L, 1);
			string str = Lua.lua_tostring(L, 2);
			SoldierLevelController.SoldierLevelMsg soldierLevelMsg = soldierLevelController.DecodeData(str);
			objectTranslator.Push(L, soldierLevelMsg);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_IsCoroutineAlive(IntPtr L)
	{
		try
		{
			bool value = ((SoldierLevelController)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1)).IsCoroutineAlive();
			Lua.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_IsCoroutineRunning(IntPtr L)
	{
		try
		{
			bool value = ((SoldierLevelController)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1)).IsCoroutineRunning();
			Lua.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetCoroutineDeltaTime(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			FP coroutineDeltaTime = ((SoldierLevelController)objectTranslator.FastGetCSObj(L, 1)).GetCoroutineDeltaTime();
			objectTranslator.Push(L, coroutineDeltaTime);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_StartLogicCoroutine(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			SoldierLevelController soldierLevelController = (SoldierLevelController)objectTranslator.FastGetCSObj(L, 1);
			int num = Lua.lua_gettop(L);
			if (num == 3 && objectTranslator.Assignable<IEnumerator>(L, 2) && LuaTypes.LUA_TBOOLEAN == Lua.lua_type(L, 3))
			{
				IEnumerator routine = (IEnumerator)objectTranslator.GetObject(L, 2, typeof(IEnumerator));
				bool runImmediately = Lua.lua_toboolean(L, 3);
				CoroutineNode o = soldierLevelController.StartLogicCoroutine(routine, runImmediately);
				objectTranslator.Push(L, o);
				return 1;
			}
			if (num == 2 && objectTranslator.Assignable<IEnumerator>(L, 2))
			{
				IEnumerator routine2 = (IEnumerator)objectTranslator.GetObject(L, 2, typeof(IEnumerator));
				CoroutineNode o2 = soldierLevelController.StartLogicCoroutine(routine2);
				objectTranslator.Push(L, o2);
				return 1;
			}
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return Lua.luaL_error(L, "invalid arguments to SoldierLevelController.StartLogicCoroutine!");
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_StopLogicCoroutine(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			SoldierLevelController soldierLevelController = (SoldierLevelController)objectTranslator.FastGetCSObj(L, 1);
			CoroutineNode coroutine = (CoroutineNode)objectTranslator.GetObject(L, 2, typeof(CoroutineNode));
			soldierLevelController.StopLogicCoroutine(coroutine);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetSoldierDamageID(IntPtr L)
	{
		try
		{
			SoldierLevelController soldierLevelController = (SoldierLevelController)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1);
			long soldierDamageID = Lua.lua_toint64(L, 2);
			soldierLevelController.SetSoldierDamageID(soldierDamageID);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetBattleActors(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			SoldierLevelController soldierLevelController = (SoldierLevelController)objectTranslator.FastGetCSObj(L, 1);
			int num = Lua.lua_gettop(L);
			if (num == 3 && objectTranslator.Assignable<AdventureActor>(L, 2) && objectTranslator.Assignable<List<SoldierActor>>(L, 3))
			{
				AdventureActor self = (AdventureActor)objectTranslator.GetObject(L, 2, typeof(AdventureActor));
				List<SoldierActor> buffer = (List<SoldierActor>)objectTranslator.GetObject(L, 3, typeof(List<SoldierActor>));
				List<SoldierActor> battleActors = soldierLevelController.GetBattleActors(self, buffer);
				objectTranslator.Push(L, battleActors);
				return 1;
			}
			if (num == 2 && objectTranslator.Assignable<AdventureActor>(L, 2))
			{
				AdventureActor self2 = (AdventureActor)objectTranslator.GetObject(L, 2, typeof(AdventureActor));
				List<SoldierActor> battleActors2 = soldierLevelController.GetBattleActors(self2);
				objectTranslator.Push(L, battleActors2);
				return 1;
			}
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return Lua.luaL_error(L, "invalid arguments to SoldierLevelController.GetBattleActors!");
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetSupportActors(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			SoldierLevelController soldierLevelController = (SoldierLevelController)objectTranslator.FastGetCSObj(L, 1);
			int num = Lua.lua_gettop(L);
			if (num == 3 && objectTranslator.Assignable<AdventureActor>(L, 2) && objectTranslator.Assignable<List<SoldierActor>>(L, 3))
			{
				AdventureActor self = (AdventureActor)objectTranslator.GetObject(L, 2, typeof(AdventureActor));
				List<SoldierActor> buffer = (List<SoldierActor>)objectTranslator.GetObject(L, 3, typeof(List<SoldierActor>));
				List<SoldierActor> supportActors = soldierLevelController.GetSupportActors(self, buffer);
				objectTranslator.Push(L, supportActors);
				return 1;
			}
			if (num == 2 && objectTranslator.Assignable<AdventureActor>(L, 2))
			{
				AdventureActor self2 = (AdventureActor)objectTranslator.GetObject(L, 2, typeof(AdventureActor));
				List<SoldierActor> supportActors2 = soldierLevelController.GetSupportActors(self2);
				objectTranslator.Push(L, supportActors2);
				return 1;
			}
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return Lua.luaL_error(L, "invalid arguments to SoldierLevelController.GetSupportActors!");
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetAllActors(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			SoldierLevelController soldierLevelController = (SoldierLevelController)objectTranslator.FastGetCSObj(L, 1);
			int num = Lua.lua_gettop(L);
			if (num == 3 && objectTranslator.Assignable<AdventureActor>(L, 2) && objectTranslator.Assignable<List<SoldierActor>>(L, 3))
			{
				AdventureActor self = (AdventureActor)objectTranslator.GetObject(L, 2, typeof(AdventureActor));
				List<SoldierActor> buffer = (List<SoldierActor>)objectTranslator.GetObject(L, 3, typeof(List<SoldierActor>));
				List<SoldierActor> allActors = soldierLevelController.GetAllActors(self, buffer);
				objectTranslator.Push(L, allActors);
				return 1;
			}
			if (num == 2 && objectTranslator.Assignable<AdventureActor>(L, 2))
			{
				AdventureActor self2 = (AdventureActor)objectTranslator.GetObject(L, 2, typeof(AdventureActor));
				List<SoldierActor> allActors2 = soldierLevelController.GetAllActors(self2);
				objectTranslator.Push(L, allActors2);
				return 1;
			}
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return Lua.luaL_error(L, "invalid arguments to SoldierLevelController.GetAllActors!");
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetAllActorsAllCamp(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			SoldierLevelController soldierLevelController = (SoldierLevelController)objectTranslator.FastGetCSObj(L, 1);
			int num = Lua.lua_gettop(L);
			if (num == 2 && objectTranslator.Assignable<List<SoldierActor>>(L, 2))
			{
				List<SoldierActor> buffer = (List<SoldierActor>)objectTranslator.GetObject(L, 2, typeof(List<SoldierActor>));
				List<SoldierActor> allActorsAllCamp = soldierLevelController.GetAllActorsAllCamp(buffer);
				objectTranslator.Push(L, allActorsAllCamp);
				return 1;
			}
			if (num == 1)
			{
				List<SoldierActor> allActorsAllCamp2 = soldierLevelController.GetAllActorsAllCamp();
				objectTranslator.Push(L, allActorsAllCamp2);
				return 1;
			}
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return Lua.luaL_error(L, "invalid arguments to SoldierLevelController.GetAllActorsAllCamp!");
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetBattlePartnerCount(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			SoldierLevelController soldierLevelController = (SoldierLevelController)objectTranslator.FastGetCSObj(L, 1);
			AdventureActor self = (AdventureActor)objectTranslator.GetObject(L, 2, typeof(AdventureActor));
			objectTranslator.Get(L, 3, out HotfixEnum.ChessPartnerType v);
			int battlePartnerCount = soldierLevelController.GetBattlePartnerCount(self, v);
			Lua.xlua_pushinteger(L, battlePartnerCount);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetSupportPartnerCount(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			SoldierLevelController soldierLevelController = (SoldierLevelController)objectTranslator.FastGetCSObj(L, 1);
			AdventureActor self = (AdventureActor)objectTranslator.GetObject(L, 2, typeof(AdventureActor));
			objectTranslator.Get(L, 3, out HotfixEnum.ChessPartnerType v);
			int supportPartnerCount = soldierLevelController.GetSupportPartnerCount(self, v);
			Lua.xlua_pushinteger(L, supportPartnerCount);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetAllPartnerCount(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			SoldierLevelController soldierLevelController = (SoldierLevelController)objectTranslator.FastGetCSObj(L, 1);
			AdventureActor self = (AdventureActor)objectTranslator.GetObject(L, 2, typeof(AdventureActor));
			objectTranslator.Get(L, 3, out HotfixEnum.ChessPartnerType v);
			int allPartnerCount = soldierLevelController.GetAllPartnerCount(self, v);
			Lua.xlua_pushinteger(L, allPartnerCount);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetPartnerLv(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			SoldierLevelController soldierLevelController = (SoldierLevelController)objectTranslator.FastGetCSObj(L, 1);
			objectTranslator.Get(L, 2, out HotfixEnum.ChessPartnerType v);
			int partnerLv = soldierLevelController.GetPartnerLv(v);
			Lua.xlua_pushinteger(L, partnerLv);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetSoldierPartner(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			SoldierLevelController soldierLevelController = (SoldierLevelController)objectTranslator.FastGetCSObj(L, 1);
			objectTranslator.Get(L, 2, out HotfixEnum.ChessPartnerType v);
			SoldierPartner o = soldierLevelController.GetSoldierPartner(lv: Lua.xlua_tointeger(L, 3), type: v);
			objectTranslator.Push(L, o);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_AddItem(IntPtr L)
	{
		try
		{
			SoldierLevelController soldierLevelController = (SoldierLevelController)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1);
			int itemId = Lua.xlua_tointeger(L, 2);
			int itemCount = Lua.xlua_tointeger(L, 3);
			soldierLevelController.AddItem(itemId, itemCount);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetHarvestCount(IntPtr L)
	{
		try
		{
			int harvestCount = ((SoldierLevelController)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1)).GetHarvestCount();
			Lua.xlua_pushinteger(L, harvestCount);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SpawnSoldierSummon(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			SoldierLevelController soldierLevelController = (SoldierLevelController)objectTranslator.FastGetCSObj(L, 1);
			int num = Lua.lua_gettop(L);
			if (num == 8 && objectTranslator.Assignable<SoldierActor>(L, 2) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 3) && objectTranslator.Assignable<TSVector2>(L, 4) && objectTranslator.Assignable<FP>(L, 5) && LuaTypes.LUA_TBOOLEAN == Lua.lua_type(L, 6) && LuaTypes.LUA_TBOOLEAN == Lua.lua_type(L, 7) && objectTranslator.Assignable<SoldierActor.SoldierRole>(L, 8))
			{
				SoldierActor summoner = (SoldierActor)objectTranslator.GetObject(L, 2, typeof(SoldierActor));
				int chessId = Lua.xlua_tointeger(L, 3);
				objectTranslator.Get(L, 4, out TSVector2 v);
				objectTranslator.Get(L, 5, out FP v2);
				bool isClearSelf = Lua.lua_toboolean(L, 6);
				bool inheritAttr = Lua.lua_toboolean(L, 7);
				objectTranslator.Get(L, 8, out SoldierActor.SoldierRole v3);
				SoldierActor o = soldierLevelController.SpawnSoldierSummon(summoner, chessId, v, v2, isClearSelf, inheritAttr, v3);
				objectTranslator.Push(L, o);
				return 1;
			}
			if (num == 7 && objectTranslator.Assignable<SoldierActor>(L, 2) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 3) && objectTranslator.Assignable<TSVector2>(L, 4) && objectTranslator.Assignable<FP>(L, 5) && LuaTypes.LUA_TBOOLEAN == Lua.lua_type(L, 6) && LuaTypes.LUA_TBOOLEAN == Lua.lua_type(L, 7))
			{
				SoldierActor summoner2 = (SoldierActor)objectTranslator.GetObject(L, 2, typeof(SoldierActor));
				int chessId2 = Lua.xlua_tointeger(L, 3);
				objectTranslator.Get(L, 4, out TSVector2 v4);
				objectTranslator.Get(L, 5, out FP v5);
				bool isClearSelf2 = Lua.lua_toboolean(L, 6);
				bool inheritAttr2 = Lua.lua_toboolean(L, 7);
				SoldierActor o2 = soldierLevelController.SpawnSoldierSummon(summoner2, chessId2, v4, v5, isClearSelf2, inheritAttr2);
				objectTranslator.Push(L, o2);
				return 1;
			}
			if (num == 6 && objectTranslator.Assignable<SoldierActor>(L, 2) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 3) && objectTranslator.Assignable<TSVector2>(L, 4) && objectTranslator.Assignable<FP>(L, 5) && LuaTypes.LUA_TBOOLEAN == Lua.lua_type(L, 6))
			{
				SoldierActor summoner3 = (SoldierActor)objectTranslator.GetObject(L, 2, typeof(SoldierActor));
				int chessId3 = Lua.xlua_tointeger(L, 3);
				objectTranslator.Get(L, 4, out TSVector2 v6);
				objectTranslator.Get(L, 5, out FP v7);
				bool isClearSelf3 = Lua.lua_toboolean(L, 6);
				SoldierActor o3 = soldierLevelController.SpawnSoldierSummon(summoner3, chessId3, v6, v7, isClearSelf3);
				objectTranslator.Push(L, o3);
				return 1;
			}
			if (num == 5 && objectTranslator.Assignable<SoldierActor>(L, 2) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 3) && objectTranslator.Assignable<TSVector2>(L, 4) && objectTranslator.Assignable<FP>(L, 5))
			{
				SoldierActor summoner4 = (SoldierActor)objectTranslator.GetObject(L, 2, typeof(SoldierActor));
				int chessId4 = Lua.xlua_tointeger(L, 3);
				objectTranslator.Get(L, 4, out TSVector2 v8);
				objectTranslator.Get(L, 5, out FP v9);
				SoldierActor o4 = soldierLevelController.SpawnSoldierSummon(summoner4, chessId4, v8, v9);
				objectTranslator.Push(L, o4);
				return 1;
			}
			if (num == 4 && objectTranslator.Assignable<SoldierActor>(L, 2) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 3) && objectTranslator.Assignable<TSVector2>(L, 4))
			{
				SoldierActor summoner5 = (SoldierActor)objectTranslator.GetObject(L, 2, typeof(SoldierActor));
				int chessId5 = Lua.xlua_tointeger(L, 3);
				objectTranslator.Get(L, 4, out TSVector2 v10);
				SoldierActor o5 = soldierLevelController.SpawnSoldierSummon(summoner5, chessId5, v10);
				objectTranslator.Push(L, o5);
				return 1;
			}
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return Lua.luaL_error(L, "invalid arguments to SoldierLevelController.SpawnSoldierSummon!");
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_AddSoldierSummon(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			SoldierLevelController soldierLevelController = (SoldierLevelController)objectTranslator.FastGetCSObj(L, 1);
			int num = Lua.lua_gettop(L);
			if (num == 3 && objectTranslator.Assignable<SoldierActor>(L, 2) && objectTranslator.Assignable<SoldierActor>(L, 3))
			{
				SoldierActor summoner = (SoldierActor)objectTranslator.GetObject(L, 2, typeof(SoldierActor));
				SoldierActor summoned = (SoldierActor)objectTranslator.GetObject(L, 3, typeof(SoldierActor));
				soldierLevelController.AddSoldierSummon(summoner, summoned);
				return 0;
			}
			if (num == 5 && objectTranslator.Assignable<SoldierActor>(L, 2) && objectTranslator.Assignable<SoldierActor>(L, 3) && (LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 4) || Lua.lua_isint64(L, 4)) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 5))
			{
				SoldierActor summoner2 = (SoldierActor)objectTranslator.GetObject(L, 2, typeof(SoldierActor));
				SoldierActor summoned2 = (SoldierActor)objectTranslator.GetObject(L, 3, typeof(SoldierActor));
				long entityId = Lua.lua_toint64(L, 4);
				int dataId = Lua.xlua_tointeger(L, 5);
				soldierLevelController.AddSoldierSummon(summoner2, summoned2, entityId, dataId);
				return 0;
			}
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return Lua.luaL_error(L, "invalid arguments to SoldierLevelController.AddSoldierSummon!");
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_MarkSoldierSummonDead(IntPtr L)
	{
		try
		{
			SoldierLevelController soldierLevelController = (SoldierLevelController)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1);
			long entityId = Lua.lua_toint64(L, 2);
			soldierLevelController.MarkSoldierSummonDead(entityId);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_RemoveSoldierSummon(IntPtr L)
	{
		try
		{
			SoldierLevelController soldierLevelController = (SoldierLevelController)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1);
			long entityId = Lua.lua_toint64(L, 2);
			soldierLevelController.RemoveSoldierSummon(entityId);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_RemoveSoldierSummonsBySummoner(IntPtr L)
	{
		try
		{
			SoldierLevelController soldierLevelController = (SoldierLevelController)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1);
			long summonerId = Lua.lua_toint64(L, 2);
			soldierLevelController.RemoveSoldierSummonsBySummoner(summonerId);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetSoldierSummonCount(IntPtr L)
	{
		try
		{
			SoldierLevelController soldierLevelController = (SoldierLevelController)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1);
			int num = Lua.lua_gettop(L);
			if (num == 4 && (LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 2) || Lua.lua_isint64(L, 2)) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 3) && LuaTypes.LUA_TBOOLEAN == Lua.lua_type(L, 4))
			{
				long summonerId = Lua.lua_toint64(L, 2);
				int dataId = Lua.xlua_tointeger(L, 3);
				bool aliveOnly = Lua.lua_toboolean(L, 4);
				int soldierSummonCount = soldierLevelController.GetSoldierSummonCount(summonerId, dataId, aliveOnly);
				Lua.xlua_pushinteger(L, soldierSummonCount);
				return 1;
			}
			if (num == 3 && (LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 2) || Lua.lua_isint64(L, 2)) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 3))
			{
				long summonerId2 = Lua.lua_toint64(L, 2);
				int dataId2 = Lua.xlua_tointeger(L, 3);
				int soldierSummonCount2 = soldierLevelController.GetSoldierSummonCount(summonerId2, dataId2);
				Lua.xlua_pushinteger(L, soldierSummonCount2);
				return 1;
			}
			if (num == 2 && (LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 2) || Lua.lua_isint64(L, 2)))
			{
				long summonerId3 = Lua.lua_toint64(L, 2);
				int soldierSummonCount3 = soldierLevelController.GetSoldierSummonCount(summonerId3);
				Lua.xlua_pushinteger(L, soldierSummonCount3);
				return 1;
			}
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return Lua.luaL_error(L, "invalid arguments to SoldierLevelController.GetSoldierSummonCount!");
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetSoldierSummonInfos(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			List<SoldierLevelController.SoldierSummonData> soldierSummonInfos = ((SoldierLevelController)objectTranslator.FastGetCSObj(L, 1)).GetSoldierSummonInfos();
			objectTranslator.Push(L, soldierSummonInfos);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_ClearSoldierSummonData(IntPtr L)
	{
		try
		{
			((SoldierLevelController)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1)).ClearSoldierSummonData();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_mainControlActor(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			SoldierLevelController soldierLevelController = (SoldierLevelController)objectTranslator.FastGetCSObj(L, 1);
			objectTranslator.Push(L, soldierLevelController.mainControlActor);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_enemyMainControlActor(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			SoldierLevelController soldierLevelController = (SoldierLevelController)objectTranslator.FastGetCSObj(L, 1);
			objectTranslator.Push(L, soldierLevelController.enemyMainControlActor);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_PartnerDic(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			SoldierLevelController soldierLevelController = (SoldierLevelController)objectTranslator.FastGetCSObj(L, 1);
			objectTranslator.Push(L, soldierLevelController.PartnerDic);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_dicSoldierMsg(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			SoldierLevelController soldierLevelController = (SoldierLevelController)objectTranslator.FastGetCSObj(L, 1);
			objectTranslator.Push(L, soldierLevelController.dicSoldierMsg);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_dicSoldierAttr(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			SoldierLevelController soldierLevelController = (SoldierLevelController)objectTranslator.FastGetCSObj(L, 1);
			objectTranslator.Push(L, soldierLevelController.dicSoldierAttr);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_EnemyAmendLv(IntPtr L)
	{
		try
		{
			SoldierLevelController soldierLevelController = (SoldierLevelController)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1);
			Lua.xlua_pushinteger(L, soldierLevelController.EnemyAmendLv);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_RatioStage(IntPtr L)
	{
		try
		{
			SoldierLevelController soldierLevelController = (SoldierLevelController)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1);
			Lua.xlua_pushinteger(L, soldierLevelController.RatioStage);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_shopLv(IntPtr L)
	{
		try
		{
			SoldierLevelController soldierLevelController = (SoldierLevelController)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1);
			Lua.xlua_pushinteger(L, soldierLevelController.shopLv);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_PartnerDic(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			((SoldierLevelController)objectTranslator.FastGetCSObj(L, 1)).PartnerDic = (Dictionary<int, List<int>>)objectTranslator.GetObject(L, 2, typeof(Dictionary<int, List<int>>));
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_dicSoldierMsg(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			((SoldierLevelController)objectTranslator.FastGetCSObj(L, 1)).dicSoldierMsg = (Dictionary<int, SoldierLevelController.SoldierMsg>)objectTranslator.GetObject(L, 2, typeof(Dictionary<int, SoldierLevelController.SoldierMsg>));
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_dicSoldierAttr(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			((SoldierLevelController)objectTranslator.FastGetCSObj(L, 1)).dicSoldierAttr = (Dictionary<int, SoldierLevelController.SoldierAttr>)objectTranslator.GetObject(L, 2, typeof(Dictionary<int, SoldierLevelController.SoldierAttr>));
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_EnemyAmendLv(IntPtr L)
	{
		try
		{
			((SoldierLevelController)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1)).EnemyAmendLv = Lua.xlua_tointeger(L, 2);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_RatioStage(IntPtr L)
	{
		try
		{
			((SoldierLevelController)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1)).RatioStage = Lua.xlua_tointeger(L, 2);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_shopLv(IntPtr L)
	{
		try
		{
			((SoldierLevelController)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1)).shopLv = Lua.xlua_tointeger(L, 2);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}
}
