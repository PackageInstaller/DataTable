using System;
using AIScript.Monster.Soldier;
using Nova.Hotfix;
using TrueSync;
using XLua.LuaDLL;

namespace XLua.CSObjectWrap;

public class SoldierActorWrap
{
	public static void __Register(IntPtr L)
	{
		ObjectTranslator translator = ObjectTranslatorPool.Instance.Find(L);
		Type typeFromHandle = typeof(SoldierActor);
		Utils.BeginObjectRegister(typeFromHandle, L, translator, 0, 21, 24, 18);
		Utils.RegisterFunc(L, -3, "LoadData", _m_LoadData);
		Utils.RegisterFunc(L, -3, "GetPotentialLv", _m_GetPotentialLv);
		Utils.RegisterFunc(L, -3, "FindNearestConfrontTarget", _m_FindNearestConfrontTarget);
		Utils.RegisterFunc(L, -3, "HasPartnerType", _m_HasPartnerType);
		Utils.RegisterFunc(L, -3, "GetTotalCost", _m_GetTotalCost);
		Utils.RegisterFunc(L, -3, "ConsumeEnergy", _m_ConsumeEnergy);
		Utils.RegisterFunc(L, -3, "BeginEnergyRegenSuspend", _m_BeginEnergyRegenSuspend);
		Utils.RegisterFunc(L, -3, "EndEnergyRegenSuspend", _m_EndEnergyRegenSuspend);
		Utils.RegisterFunc(L, -3, "SetEnergy", _m_SetEnergy);
		Utils.RegisterFunc(L, -3, "SetMaxEnergy", _m_SetMaxEnergy);
		Utils.RegisterFunc(L, -3, "SetEnergyRecoverRate", _m_SetEnergyRecoverRate);
		Utils.RegisterFunc(L, -3, "SetEnergyRecoverRateFP", _m_SetEnergyRecoverRateFP);
		Utils.RegisterFunc(L, -3, "SetEnergyRecoverRatePercent", _m_SetEnergyRecoverRatePercent);
		Utils.RegisterFunc(L, -3, "ModifyEnergyRecoverRatePercent", _m_ModifyEnergyRecoverRatePercent);
		Utils.RegisterFunc(L, -3, "SetupPrimeFSM", _m_SetupPrimeFSM);
		Utils.RegisterFunc(L, -3, "LevelStart", _m_LevelStart);
		Utils.RegisterFunc(L, -3, "Despawn", _m_Despawn);
		Utils.RegisterFunc(L, -3, "OnShowHud", _m_OnShowHud);
		Utils.RegisterFunc(L, -3, "EnterSupportCastStance", _m_EnterSupportCastStance);
		Utils.RegisterFunc(L, -3, "ExitSupportCastStance", _m_ExitSupportCastStance);
		Utils.RegisterFunc(L, -3, "PromoteToBattle", _m_PromoteToBattle);
		Utils.RegisterFunc(L, -2, "UseInheritElementOnHit", _g_get_UseInheritElementOnHit);
		Utils.RegisterFunc(L, -2, "monsterInfo", _g_get_monsterInfo);
		Utils.RegisterFunc(L, -2, "soldierChessAI", _g_get_soldierChessAI);
		Utils.RegisterFunc(L, -2, "isSupport", _g_get_isSupport);
		Utils.RegisterFunc(L, -2, "energyRecoverRate", _g_get_energyRecoverRate);
		Utils.RegisterFunc(L, -2, "EnergyRecoverRateFP", _g_get_EnergyRecoverRateFP);
		Utils.RegisterFunc(L, -2, "isEnergyFull", _g_get_isEnergyFull);
		Utils.RegisterFunc(L, -2, "soldierRole", _g_get_soldierRole);
		Utils.RegisterFunc(L, -2, "gridIndex", _g_get_gridIndex);
		Utils.RegisterFunc(L, -2, "isEnemyCamp", _g_get_isEnemyCamp);
		Utils.RegisterFunc(L, -2, "soldierAI", _g_get_soldierAI);
		Utils.RegisterFunc(L, -2, "isCastingSupport", _g_get_isCastingSupport);
		Utils.RegisterFunc(L, -2, "onStageType", _g_get_onStageType);
		Utils.RegisterFunc(L, -2, "normalSkillId", _g_get_normalSkillId);
		Utils.RegisterFunc(L, -2, "mainSkillId", _g_get_mainSkillId);
		Utils.RegisterFunc(L, -2, "supportSkillId", _g_get_supportSkillId);
		Utils.RegisterFunc(L, -2, "normalAttackRadius", _g_get_normalAttackRadius);
		Utils.RegisterFunc(L, -2, "skillRadius", _g_get_skillRadius);
		Utils.RegisterFunc(L, -2, "stopNormalAttack", _g_get_stopNormalAttack);
		Utils.RegisterFunc(L, -2, "spawnSkillSkillId", _g_get_spawnSkillSkillId);
		Utils.RegisterFunc(L, -2, "isAimAtTarget", _g_get_isAimAtTarget);
		Utils.RegisterFunc(L, -2, "energy", _g_get_energy);
		Utils.RegisterFunc(L, -2, "maxEnergy", _g_get_maxEnergy);
		Utils.RegisterFunc(L, -2, "isSkillEndStartRecover", _g_get_isSkillEndStartRecover);
		Utils.RegisterFunc(L, -1, "energyRecoverRate", _s_set_energyRecoverRate);
		Utils.RegisterFunc(L, -1, "soldierRole", _s_set_soldierRole);
		Utils.RegisterFunc(L, -1, "gridIndex", _s_set_gridIndex);
		Utils.RegisterFunc(L, -1, "isEnemyCamp", _s_set_isEnemyCamp);
		Utils.RegisterFunc(L, -1, "soldierAI", _s_set_soldierAI);
		Utils.RegisterFunc(L, -1, "isCastingSupport", _s_set_isCastingSupport);
		Utils.RegisterFunc(L, -1, "onStageType", _s_set_onStageType);
		Utils.RegisterFunc(L, -1, "normalSkillId", _s_set_normalSkillId);
		Utils.RegisterFunc(L, -1, "mainSkillId", _s_set_mainSkillId);
		Utils.RegisterFunc(L, -1, "supportSkillId", _s_set_supportSkillId);
		Utils.RegisterFunc(L, -1, "normalAttackRadius", _s_set_normalAttackRadius);
		Utils.RegisterFunc(L, -1, "skillRadius", _s_set_skillRadius);
		Utils.RegisterFunc(L, -1, "stopNormalAttack", _s_set_stopNormalAttack);
		Utils.RegisterFunc(L, -1, "spawnSkillSkillId", _s_set_spawnSkillSkillId);
		Utils.RegisterFunc(L, -1, "isAimAtTarget", _s_set_isAimAtTarget);
		Utils.RegisterFunc(L, -1, "energy", _s_set_energy);
		Utils.RegisterFunc(L, -1, "maxEnergy", _s_set_maxEnergy);
		Utils.RegisterFunc(L, -1, "isSkillEndStartRecover", _s_set_isSkillEndStartRecover);
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
				SoldierActor o = new SoldierActor();
				objectTranslator.Push(L, o);
				return 1;
			}
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return Lua.luaL_error(L, "invalid arguments to SoldierActor constructor!");
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_LoadData(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			SoldierActor soldierActor = (SoldierActor)objectTranslator.FastGetCSObj(L, 1);
			int num = Lua.lua_gettop(L);
			if (num == 8 && objectTranslator.Assignable<SoldierCharacter>(L, 2) && objectTranslator.Assignable<SoldierSkin>(L, 3) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 4) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 5) && objectTranslator.Assignable<SoldierActor.SoldierRole>(L, 6) && objectTranslator.Assignable<SoldierActor>(L, 7) && LuaTypes.LUA_TBOOLEAN == Lua.lua_type(L, 8))
			{
				SoldierCharacter data = (SoldierCharacter)objectTranslator.GetObject(L, 2, typeof(SoldierCharacter));
				SoldierSkin skin = (SoldierSkin)objectTranslator.GetObject(L, 3, typeof(SoldierSkin));
				int potentialLv = Lua.xlua_tointeger(L, 4);
				int enemyCampLv = Lua.xlua_tointeger(L, 5);
				objectTranslator.Get(L, 6, out SoldierActor.SoldierRole v);
				SoldierActor summoner = (SoldierActor)objectTranslator.GetObject(L, 7, typeof(SoldierActor));
				bool inheritAttr = Lua.lua_toboolean(L, 8);
				soldierActor.LoadData(data, skin, potentialLv, enemyCampLv, v, summoner, inheritAttr);
				return 0;
			}
			if (num == 7 && objectTranslator.Assignable<SoldierCharacter>(L, 2) && objectTranslator.Assignable<SoldierSkin>(L, 3) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 4) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 5) && objectTranslator.Assignable<SoldierActor.SoldierRole>(L, 6) && objectTranslator.Assignable<SoldierActor>(L, 7))
			{
				SoldierCharacter data2 = (SoldierCharacter)objectTranslator.GetObject(L, 2, typeof(SoldierCharacter));
				SoldierSkin skin2 = (SoldierSkin)objectTranslator.GetObject(L, 3, typeof(SoldierSkin));
				int potentialLv2 = Lua.xlua_tointeger(L, 4);
				int enemyCampLv2 = Lua.xlua_tointeger(L, 5);
				objectTranslator.Get(L, 6, out SoldierActor.SoldierRole v2);
				SoldierActor summoner2 = (SoldierActor)objectTranslator.GetObject(L, 7, typeof(SoldierActor));
				soldierActor.LoadData(data2, skin2, potentialLv2, enemyCampLv2, v2, summoner2);
				return 0;
			}
			if (num == 6 && objectTranslator.Assignable<SoldierCharacter>(L, 2) && objectTranslator.Assignable<SoldierSkin>(L, 3) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 4) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 5) && objectTranslator.Assignable<SoldierActor.SoldierRole>(L, 6))
			{
				SoldierCharacter data3 = (SoldierCharacter)objectTranslator.GetObject(L, 2, typeof(SoldierCharacter));
				SoldierSkin skin3 = (SoldierSkin)objectTranslator.GetObject(L, 3, typeof(SoldierSkin));
				int potentialLv3 = Lua.xlua_tointeger(L, 4);
				int enemyCampLv3 = Lua.xlua_tointeger(L, 5);
				objectTranslator.Get(L, 6, out SoldierActor.SoldierRole v3);
				soldierActor.LoadData(data3, skin3, potentialLv3, enemyCampLv3, v3);
				return 0;
			}
			if (num == 5 && objectTranslator.Assignable<SoldierCharacter>(L, 2) && objectTranslator.Assignable<SoldierSkin>(L, 3) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 4) && LuaTypes.LUA_TNUMBER == Lua.lua_type(L, 5))
			{
				SoldierCharacter data4 = (SoldierCharacter)objectTranslator.GetObject(L, 2, typeof(SoldierCharacter));
				SoldierSkin skin4 = (SoldierSkin)objectTranslator.GetObject(L, 3, typeof(SoldierSkin));
				int potentialLv4 = Lua.xlua_tointeger(L, 4);
				int enemyCampLv4 = Lua.xlua_tointeger(L, 5);
				soldierActor.LoadData(data4, skin4, potentialLv4, enemyCampLv4);
				return 0;
			}
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return Lua.luaL_error(L, "invalid arguments to SoldierActor.LoadData!");
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetPotentialLv(IntPtr L)
	{
		try
		{
			int potentialLv = ((SoldierActor)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1)).GetPotentialLv();
			Lua.xlua_pushinteger(L, potentialLv);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_FindNearestConfrontTarget(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			LogicEntity o = ((SoldierActor)objectTranslator.FastGetCSObj(L, 1)).FindNearestConfrontTarget();
			objectTranslator.Push(L, o);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_HasPartnerType(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			SoldierActor soldierActor = (SoldierActor)objectTranslator.FastGetCSObj(L, 1);
			objectTranslator.Get(L, 2, out HotfixEnum.ChessPartnerType v);
			bool value = soldierActor.HasPartnerType(v);
			Lua.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_GetTotalCost(IntPtr L)
	{
		try
		{
			int totalCost = ((SoldierActor)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1)).GetTotalCost();
			Lua.xlua_pushinteger(L, totalCost);
			return 1;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_ConsumeEnergy(IntPtr L)
	{
		try
		{
			((SoldierActor)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1)).ConsumeEnergy();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_BeginEnergyRegenSuspend(IntPtr L)
	{
		try
		{
			((SoldierActor)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1)).BeginEnergyRegenSuspend();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_EndEnergyRegenSuspend(IntPtr L)
	{
		try
		{
			((SoldierActor)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1)).EndEnergyRegenSuspend();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetEnergy(IntPtr L)
	{
		try
		{
			SoldierActor soldierActor = (SoldierActor)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1);
			int energy = Lua.xlua_tointeger(L, 2);
			soldierActor.SetEnergy(energy);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetMaxEnergy(IntPtr L)
	{
		try
		{
			SoldierActor soldierActor = (SoldierActor)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1);
			int maxEnergy = Lua.xlua_tointeger(L, 2);
			soldierActor.SetMaxEnergy(maxEnergy);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetEnergyRecoverRate(IntPtr L)
	{
		try
		{
			SoldierActor soldierActor = (SoldierActor)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1);
			float energyRecoverRate = (float)Lua.lua_tonumber(L, 2);
			soldierActor.SetEnergyRecoverRate(energyRecoverRate);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetEnergyRecoverRateFP(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			SoldierActor soldierActor = (SoldierActor)objectTranslator.FastGetCSObj(L, 1);
			objectTranslator.Get(L, 2, out FP v);
			soldierActor.SetEnergyRecoverRateFP(v);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetEnergyRecoverRatePercent(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			SoldierActor soldierActor = (SoldierActor)objectTranslator.FastGetCSObj(L, 1);
			objectTranslator.Get(L, 2, out FP v);
			soldierActor.SetEnergyRecoverRatePercent(v);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_ModifyEnergyRecoverRatePercent(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			SoldierActor soldierActor = (SoldierActor)objectTranslator.FastGetCSObj(L, 1);
			objectTranslator.Get(L, 2, out FP v);
			soldierActor.ModifyEnergyRecoverRatePercent(v);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_SetupPrimeFSM(IntPtr L)
	{
		try
		{
			SoldierActor soldierActor = (SoldierActor)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1);
			int aiId = Lua.xlua_tointeger(L, 2);
			soldierActor.SetupPrimeFSM(aiId);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_LevelStart(IntPtr L)
	{
		try
		{
			((SoldierActor)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1)).LevelStart();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_Despawn(IntPtr L)
	{
		try
		{
			((SoldierActor)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1)).Despawn();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_OnShowHud(IntPtr L)
	{
		try
		{
			SoldierActor soldierActor = (SoldierActor)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1);
			bool show = Lua.lua_toboolean(L, 2);
			soldierActor.OnShowHud(show);
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_EnterSupportCastStance(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			SoldierActor soldierActor = (SoldierActor)objectTranslator.FastGetCSObj(L, 1);
			int num = Lua.lua_gettop(L);
			if (num == 3 && objectTranslator.Assignable<TSVector2>(L, 2) && objectTranslator.Assignable<TSVector2>(L, 3))
			{
				objectTranslator.Get(L, 2, out TSVector2 v);
				objectTranslator.Get(L, 3, out TSVector2 v2);
				soldierActor.EnterSupportCastStance(v, v2);
				return 0;
			}
			if (num == 2 && objectTranslator.Assignable<TSVector2>(L, 2))
			{
				objectTranslator.Get(L, 2, out TSVector2 v3);
				soldierActor.EnterSupportCastStance(v3);
				return 0;
			}
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return Lua.luaL_error(L, "invalid arguments to SoldierActor.EnterSupportCastStance!");
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_ExitSupportCastStance(IntPtr L)
	{
		try
		{
			((SoldierActor)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1)).ExitSupportCastStance();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _m_PromoteToBattle(IntPtr L)
	{
		try
		{
			((SoldierActor)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1)).PromoteToBattle();
			return 0;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_UseInheritElementOnHit(IntPtr L)
	{
		try
		{
			SoldierActor soldierActor = (SoldierActor)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1);
			Lua.lua_pushboolean(L, soldierActor.UseInheritElementOnHit);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_monsterInfo(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			SoldierActor soldierActor = (SoldierActor)objectTranslator.FastGetCSObj(L, 1);
			objectTranslator.Push(L, soldierActor.monsterInfo);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_soldierChessAI(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			SoldierActor soldierActor = (SoldierActor)objectTranslator.FastGetCSObj(L, 1);
			objectTranslator.Push(L, soldierActor.soldierChessAI);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_isSupport(IntPtr L)
	{
		try
		{
			SoldierActor soldierActor = (SoldierActor)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1);
			Lua.lua_pushboolean(L, soldierActor.isSupport);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_energyRecoverRate(IntPtr L)
	{
		try
		{
			SoldierActor soldierActor = (SoldierActor)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1);
			Lua.lua_pushnumber(L, soldierActor.energyRecoverRate);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_EnergyRecoverRateFP(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			SoldierActor soldierActor = (SoldierActor)objectTranslator.FastGetCSObj(L, 1);
			objectTranslator.Push(L, soldierActor.EnergyRecoverRateFP);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_isEnergyFull(IntPtr L)
	{
		try
		{
			SoldierActor soldierActor = (SoldierActor)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1);
			Lua.lua_pushboolean(L, soldierActor.isEnergyFull);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_soldierRole(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			SoldierActor soldierActor = (SoldierActor)objectTranslator.FastGetCSObj(L, 1);
			objectTranslator.Push(L, soldierActor.soldierRole);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_gridIndex(IntPtr L)
	{
		try
		{
			SoldierActor soldierActor = (SoldierActor)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1);
			Lua.xlua_pushinteger(L, soldierActor.gridIndex);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_isEnemyCamp(IntPtr L)
	{
		try
		{
			SoldierActor soldierActor = (SoldierActor)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1);
			Lua.lua_pushboolean(L, soldierActor.isEnemyCamp);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_soldierAI(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			SoldierActor soldierActor = (SoldierActor)objectTranslator.FastGetCSObj(L, 1);
			objectTranslator.Push(L, soldierActor.soldierAI);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_isCastingSupport(IntPtr L)
	{
		try
		{
			SoldierActor soldierActor = (SoldierActor)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1);
			Lua.lua_pushboolean(L, soldierActor.isCastingSupport);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_onStageType(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			SoldierActor soldierActor = (SoldierActor)objectTranslator.FastGetCSObj(L, 1);
			objectTranslator.Push(L, soldierActor.onStageType);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_normalSkillId(IntPtr L)
	{
		try
		{
			SoldierActor soldierActor = (SoldierActor)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1);
			Lua.xlua_pushinteger(L, soldierActor.normalSkillId);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_mainSkillId(IntPtr L)
	{
		try
		{
			SoldierActor soldierActor = (SoldierActor)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1);
			Lua.xlua_pushinteger(L, soldierActor.mainSkillId);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_supportSkillId(IntPtr L)
	{
		try
		{
			SoldierActor soldierActor = (SoldierActor)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1);
			Lua.xlua_pushinteger(L, soldierActor.supportSkillId);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_normalAttackRadius(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			SoldierActor soldierActor = (SoldierActor)objectTranslator.FastGetCSObj(L, 1);
			objectTranslator.Push(L, soldierActor.normalAttackRadius);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_skillRadius(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			SoldierActor soldierActor = (SoldierActor)objectTranslator.FastGetCSObj(L, 1);
			objectTranslator.Push(L, soldierActor.skillRadius);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_stopNormalAttack(IntPtr L)
	{
		try
		{
			SoldierActor soldierActor = (SoldierActor)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1);
			Lua.lua_pushboolean(L, soldierActor.stopNormalAttack);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_spawnSkillSkillId(IntPtr L)
	{
		try
		{
			SoldierActor soldierActor = (SoldierActor)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1);
			Lua.xlua_pushinteger(L, soldierActor.spawnSkillSkillId);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_isAimAtTarget(IntPtr L)
	{
		try
		{
			SoldierActor soldierActor = (SoldierActor)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1);
			Lua.lua_pushboolean(L, soldierActor.isAimAtTarget);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_energy(IntPtr L)
	{
		try
		{
			SoldierActor soldierActor = (SoldierActor)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1);
			Lua.xlua_pushinteger(L, soldierActor.energy);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_maxEnergy(IntPtr L)
	{
		try
		{
			SoldierActor soldierActor = (SoldierActor)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1);
			Lua.xlua_pushinteger(L, soldierActor.maxEnergy);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _g_get_isSkillEndStartRecover(IntPtr L)
	{
		try
		{
			SoldierActor soldierActor = (SoldierActor)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1);
			Lua.lua_pushboolean(L, soldierActor.isSkillEndStartRecover);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_energyRecoverRate(IntPtr L)
	{
		try
		{
			((SoldierActor)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1)).energyRecoverRate = (float)Lua.lua_tonumber(L, 2);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_soldierRole(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			SoldierActor soldierActor = (SoldierActor)objectTranslator.FastGetCSObj(L, 1);
			objectTranslator.Get(L, 2, out SoldierActor.SoldierRole v);
			soldierActor.soldierRole = v;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_gridIndex(IntPtr L)
	{
		try
		{
			((SoldierActor)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1)).gridIndex = Lua.xlua_tointeger(L, 2);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_isEnemyCamp(IntPtr L)
	{
		try
		{
			((SoldierActor)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1)).isEnemyCamp = Lua.lua_toboolean(L, 2);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_soldierAI(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			((SoldierActor)objectTranslator.FastGetCSObj(L, 1)).soldierAI = (SoldierBaseAI)objectTranslator.GetObject(L, 2, typeof(SoldierBaseAI));
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_isCastingSupport(IntPtr L)
	{
		try
		{
			((SoldierActor)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1)).isCastingSupport = Lua.lua_toboolean(L, 2);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_onStageType(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			SoldierActor soldierActor = (SoldierActor)objectTranslator.FastGetCSObj(L, 1);
			objectTranslator.Get(L, 2, out HotfixEnum.ChessAssistOnStageType v);
			soldierActor.onStageType = v;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_normalSkillId(IntPtr L)
	{
		try
		{
			((SoldierActor)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1)).normalSkillId = Lua.xlua_tointeger(L, 2);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_mainSkillId(IntPtr L)
	{
		try
		{
			((SoldierActor)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1)).mainSkillId = Lua.xlua_tointeger(L, 2);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_supportSkillId(IntPtr L)
	{
		try
		{
			((SoldierActor)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1)).supportSkillId = Lua.xlua_tointeger(L, 2);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_normalAttackRadius(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			SoldierActor soldierActor = (SoldierActor)objectTranslator.FastGetCSObj(L, 1);
			objectTranslator.Get(L, 2, out FP v);
			soldierActor.normalAttackRadius = v;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_skillRadius(IntPtr L)
	{
		try
		{
			ObjectTranslator objectTranslator = ObjectTranslatorPool.Instance.Find(L);
			SoldierActor soldierActor = (SoldierActor)objectTranslator.FastGetCSObj(L, 1);
			objectTranslator.Get(L, 2, out FP v);
			soldierActor.skillRadius = v;
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_stopNormalAttack(IntPtr L)
	{
		try
		{
			((SoldierActor)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1)).stopNormalAttack = Lua.lua_toboolean(L, 2);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_spawnSkillSkillId(IntPtr L)
	{
		try
		{
			((SoldierActor)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1)).spawnSkillSkillId = Lua.xlua_tointeger(L, 2);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_isAimAtTarget(IntPtr L)
	{
		try
		{
			((SoldierActor)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1)).isAimAtTarget = Lua.lua_toboolean(L, 2);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_energy(IntPtr L)
	{
		try
		{
			((SoldierActor)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1)).energy = Lua.xlua_tointeger(L, 2);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_maxEnergy(IntPtr L)
	{
		try
		{
			((SoldierActor)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1)).maxEnergy = Lua.xlua_tointeger(L, 2);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}

	[MonoPInvokeCallback(typeof(lua_CSFunction))]
	private static int _s_set_isSkillEndStartRecover(IntPtr L)
	{
		try
		{
			((SoldierActor)ObjectTranslatorPool.Instance.Find(L).FastGetCSObj(L, 1)).isSkillEndStartRecover = Lua.lua_toboolean(L, 2);
		}
		catch (Exception ex)
		{
			return Lua.luaL_error(L, "c# exception:" + ex);
		}
		return 0;
	}
}
