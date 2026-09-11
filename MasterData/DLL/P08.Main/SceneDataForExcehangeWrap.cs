using System;
using LuaInterface;

public class SceneDataForExcehangeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(SceneDataForExcehange), typeof(object));
		L.RegFunction("New", _CreateSceneDataForExcehange);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("customLoading", get_customLoading, set_customLoading);
		L.RegVar("mSceneID", get_mSceneID, set_mSceneID);
		L.RegVar("mMissionClearTimes", get_mMissionClearTimes, set_mMissionClearTimes);
		L.RegVar("typeIDListAffix", get_typeIDListAffix, set_typeIDListAffix);
		L.RegVar("levelList", get_levelList, set_levelList);
		L.RegVar("enemyTypes", get_enemyTypes, set_enemyTypes);
		L.RegVar("roleDataInLua", get_roleDataInLua, set_roleDataInLua);
		L.RegVar("challengeFactor", get_challengeFactor, set_challengeFactor);
		L.RegVar("adaptiveEnemyLevel", get_adaptiveEnemyLevel, set_adaptiveEnemyLevel);
		L.RegVar("difficulty", get_difficulty, set_difficulty);
		L.RegVar("needResurrect", get_needResurrect, set_needResurrect);
		L.RegVar("coinNumber", get_coinNumber, set_coinNumber);
		L.RegVar("maxCoinNumber", get_maxCoinNumber, set_maxCoinNumber);
		L.RegVar("coinConsume", get_coinConsume, set_coinConsume);
		L.RegVar("resurrectHP", get_resurrectHP, set_resurrectHP);
		L.RegVar("resurrectImmediately", get_resurrectImmediately, set_resurrectImmediately);
		L.RegVar("cooperateUniqueSkillID", get_cooperateUniqueSkillID, set_cooperateUniqueSkillID);
		L.RegVar("cooperateUniqueSkillLevel", get_cooperateUniqueSkillLevel, set_cooperateUniqueSkillLevel);
		L.RegVar("maxRaceID", get_maxRaceID, set_maxRaceID);
		L.RegVar("maxRacePlayerCount", get_maxRacePlayerCount, set_maxRacePlayerCount);
		L.RegVar("attributeFactor", get_attributeFactor, set_attributeFactor);
		L.RegVar("battleID", get_battleID, set_battleID);
		L.RegVar("Uuid", get_Uuid, set_Uuid);
		L.RegVar("isMultiplayer", get_isMultiplayer, set_isMultiplayer);
		L.RegVar("leftTime", get_leftTime, set_leftTime);
		L.RegVar("targetEnemyID", get_targetEnemyID, set_targetEnemyID);
		L.RegVar("nickName", get_nickName, set_nickName);
		L.RegVar("VHLSkillID", get_VHLSkillID, set_VHLSkillID);
		L.RegVar("VHLResult", get_VHLResult, set_VHLResult);
		L.RegVar("masterSkill", get_masterSkill, set_masterSkill);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateSceneDataForExcehange(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				SceneDataForExcehange o = new SceneDataForExcehange();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: SceneDataForExcehange.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_customLoading(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int customLoading = ((SceneDataForExcehange)obj).customLoading;
			LuaDLL.lua_pushinteger(L, customLoading);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index customLoading on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mSceneID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int mSceneID = ((SceneDataForExcehange)obj).mSceneID;
			LuaDLL.lua_pushinteger(L, mSceneID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mSceneID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mMissionClearTimes(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int mMissionClearTimes = ((SceneDataForExcehange)obj).mMissionClearTimes;
			LuaDLL.lua_pushinteger(L, mMissionClearTimes);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mMissionClearTimes on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_typeIDListAffix(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int[] typeIDListAffix = ((SceneDataForExcehange)obj).typeIDListAffix;
			ToLua.Push(L, typeIDListAffix);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index typeIDListAffix on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_levelList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int[] levelList = ((SceneDataForExcehange)obj).levelList;
			ToLua.Push(L, levelList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index levelList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_enemyTypes(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int[] enemyTypes = ((SceneDataForExcehange)obj).enemyTypes;
			ToLua.Push(L, enemyTypes);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enemyTypes on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_roleDataInLua(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RoleDataForExchange[] roleDataInLua = ((SceneDataForExcehange)obj).roleDataInLua;
			ToLua.Push(L, roleDataInLua);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index roleDataInLua on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_challengeFactor(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int challengeFactor = ((SceneDataForExcehange)obj).challengeFactor;
			LuaDLL.lua_pushinteger(L, challengeFactor);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index challengeFactor on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_adaptiveEnemyLevel(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int adaptiveEnemyLevel = ((SceneDataForExcehange)obj).adaptiveEnemyLevel;
			LuaDLL.lua_pushinteger(L, adaptiveEnemyLevel);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index adaptiveEnemyLevel on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_difficulty(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int difficulty = ((SceneDataForExcehange)obj).difficulty;
			LuaDLL.lua_pushinteger(L, difficulty);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index difficulty on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_needResurrect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool needResurrect = ((SceneDataForExcehange)obj).needResurrect;
			LuaDLL.lua_pushboolean(L, needResurrect);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index needResurrect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_coinNumber(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			long coinNumber = ((SceneDataForExcehange)obj).coinNumber;
			LuaDLL.tolua_pushint64(L, coinNumber);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index coinNumber on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maxCoinNumber(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			long maxCoinNumber = ((SceneDataForExcehange)obj).maxCoinNumber;
			LuaDLL.tolua_pushint64(L, maxCoinNumber);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maxCoinNumber on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_coinConsume(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			long coinConsume = ((SceneDataForExcehange)obj).coinConsume;
			LuaDLL.tolua_pushint64(L, coinConsume);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index coinConsume on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_resurrectHP(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int resurrectHP = ((SceneDataForExcehange)obj).resurrectHP;
			LuaDLL.lua_pushinteger(L, resurrectHP);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index resurrectHP on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_resurrectImmediately(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool resurrectImmediately = ((SceneDataForExcehange)obj).resurrectImmediately;
			LuaDLL.lua_pushboolean(L, resurrectImmediately);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index resurrectImmediately on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cooperateUniqueSkillID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int cooperateUniqueSkillID = ((SceneDataForExcehange)obj).cooperateUniqueSkillID;
			LuaDLL.lua_pushinteger(L, cooperateUniqueSkillID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cooperateUniqueSkillID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cooperateUniqueSkillLevel(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int cooperateUniqueSkillLevel = ((SceneDataForExcehange)obj).cooperateUniqueSkillLevel;
			LuaDLL.lua_pushinteger(L, cooperateUniqueSkillLevel);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cooperateUniqueSkillLevel on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maxRaceID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int maxRaceID = ((SceneDataForExcehange)obj).maxRaceID;
			LuaDLL.lua_pushinteger(L, maxRaceID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maxRaceID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maxRacePlayerCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int maxRacePlayerCount = ((SceneDataForExcehange)obj).maxRacePlayerCount;
			LuaDLL.lua_pushinteger(L, maxRacePlayerCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maxRacePlayerCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_attributeFactor(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Int3 attributeFactor = ((SceneDataForExcehange)obj).attributeFactor;
			ToLua.PushValue(L, attributeFactor);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index attributeFactor on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_battleID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			long battleID = ((SceneDataForExcehange)obj).battleID;
			LuaDLL.tolua_pushint64(L, battleID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index battleID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Uuid(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ulong uuid = ((SceneDataForExcehange)obj).Uuid;
			LuaDLL.tolua_pushuint64(L, uuid);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Uuid on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isMultiplayer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isMultiplayer = ((SceneDataForExcehange)obj).isMultiplayer;
			LuaDLL.lua_pushboolean(L, isMultiplayer);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isMultiplayer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_leftTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int leftTime = ((SceneDataForExcehange)obj).leftTime;
			LuaDLL.lua_pushinteger(L, leftTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index leftTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_targetEnemyID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int targetEnemyID = ((SceneDataForExcehange)obj).targetEnemyID;
			LuaDLL.lua_pushinteger(L, targetEnemyID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index targetEnemyID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_nickName(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string nickName = ((SceneDataForExcehange)obj).nickName;
			LuaDLL.lua_pushstring(L, nickName);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index nickName on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_VHLSkillID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int[] vHLSkillID = ((SceneDataForExcehange)obj).VHLSkillID;
			ToLua.Push(L, vHLSkillID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index VHLSkillID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_VHLResult(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int vHLResult = ((SceneDataForExcehange)obj).VHLResult;
			LuaDLL.lua_pushinteger(L, vHLResult);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index VHLResult on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_masterSkill(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MasterSkillDataForExchange masterSkill = ((SceneDataForExcehange)obj).masterSkill;
			ToLua.PushObject(L, masterSkill);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index masterSkill on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_customLoading(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneDataForExcehange obj2 = (SceneDataForExcehange)obj;
			int customLoading = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.customLoading = customLoading;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index customLoading on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mSceneID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneDataForExcehange obj2 = (SceneDataForExcehange)obj;
			int mSceneID = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.mSceneID = mSceneID;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mSceneID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mMissionClearTimes(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneDataForExcehange obj2 = (SceneDataForExcehange)obj;
			int mMissionClearTimes = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.mMissionClearTimes = mMissionClearTimes;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mMissionClearTimes on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_typeIDListAffix(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneDataForExcehange obj2 = (SceneDataForExcehange)obj;
			int[] typeIDListAffix = ToLua.CheckNumberArray<int>(L, 2);
			obj2.typeIDListAffix = typeIDListAffix;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index typeIDListAffix on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_levelList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneDataForExcehange obj2 = (SceneDataForExcehange)obj;
			int[] levelList = ToLua.CheckNumberArray<int>(L, 2);
			obj2.levelList = levelList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index levelList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_enemyTypes(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneDataForExcehange obj2 = (SceneDataForExcehange)obj;
			int[] enemyTypes = ToLua.CheckNumberArray<int>(L, 2);
			obj2.enemyTypes = enemyTypes;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enemyTypes on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_roleDataInLua(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneDataForExcehange obj2 = (SceneDataForExcehange)obj;
			RoleDataForExchange[] roleDataInLua = ToLua.CheckObjectArray<RoleDataForExchange>(L, 2);
			obj2.roleDataInLua = roleDataInLua;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index roleDataInLua on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_challengeFactor(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneDataForExcehange obj2 = (SceneDataForExcehange)obj;
			int challengeFactor = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.challengeFactor = challengeFactor;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index challengeFactor on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_adaptiveEnemyLevel(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneDataForExcehange obj2 = (SceneDataForExcehange)obj;
			int adaptiveEnemyLevel = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.adaptiveEnemyLevel = adaptiveEnemyLevel;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index adaptiveEnemyLevel on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_difficulty(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneDataForExcehange obj2 = (SceneDataForExcehange)obj;
			int difficulty = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.difficulty = difficulty;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index difficulty on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_needResurrect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneDataForExcehange obj2 = (SceneDataForExcehange)obj;
			bool needResurrect = LuaDLL.luaL_checkboolean(L, 2);
			obj2.needResurrect = needResurrect;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index needResurrect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_coinNumber(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneDataForExcehange obj2 = (SceneDataForExcehange)obj;
			long coinNumber = LuaDLL.tolua_checkint64(L, 2);
			obj2.coinNumber = coinNumber;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index coinNumber on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_maxCoinNumber(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneDataForExcehange obj2 = (SceneDataForExcehange)obj;
			long maxCoinNumber = LuaDLL.tolua_checkint64(L, 2);
			obj2.maxCoinNumber = maxCoinNumber;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maxCoinNumber on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_coinConsume(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneDataForExcehange obj2 = (SceneDataForExcehange)obj;
			long coinConsume = LuaDLL.tolua_checkint64(L, 2);
			obj2.coinConsume = coinConsume;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index coinConsume on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_resurrectHP(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneDataForExcehange obj2 = (SceneDataForExcehange)obj;
			int resurrectHP = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.resurrectHP = resurrectHP;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index resurrectHP on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_resurrectImmediately(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneDataForExcehange obj2 = (SceneDataForExcehange)obj;
			bool resurrectImmediately = LuaDLL.luaL_checkboolean(L, 2);
			obj2.resurrectImmediately = resurrectImmediately;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index resurrectImmediately on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_cooperateUniqueSkillID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneDataForExcehange obj2 = (SceneDataForExcehange)obj;
			int cooperateUniqueSkillID = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.cooperateUniqueSkillID = cooperateUniqueSkillID;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cooperateUniqueSkillID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_cooperateUniqueSkillLevel(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneDataForExcehange obj2 = (SceneDataForExcehange)obj;
			int cooperateUniqueSkillLevel = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.cooperateUniqueSkillLevel = cooperateUniqueSkillLevel;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cooperateUniqueSkillLevel on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_maxRaceID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneDataForExcehange obj2 = (SceneDataForExcehange)obj;
			int maxRaceID = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.maxRaceID = maxRaceID;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maxRaceID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_maxRacePlayerCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneDataForExcehange obj2 = (SceneDataForExcehange)obj;
			int maxRacePlayerCount = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.maxRacePlayerCount = maxRacePlayerCount;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maxRacePlayerCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_attributeFactor(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneDataForExcehange obj2 = (SceneDataForExcehange)obj;
			Int3 attributeFactor = StackTraits<Int3>.Check(L, 2);
			obj2.attributeFactor = attributeFactor;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index attributeFactor on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_battleID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneDataForExcehange obj2 = (SceneDataForExcehange)obj;
			long battleID = LuaDLL.tolua_checkint64(L, 2);
			obj2.battleID = battleID;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index battleID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_Uuid(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneDataForExcehange obj2 = (SceneDataForExcehange)obj;
			ulong uuid = LuaDLL.tolua_checkuint64(L, 2);
			obj2.Uuid = uuid;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Uuid on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isMultiplayer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneDataForExcehange obj2 = (SceneDataForExcehange)obj;
			bool isMultiplayer = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isMultiplayer = isMultiplayer;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isMultiplayer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_leftTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneDataForExcehange obj2 = (SceneDataForExcehange)obj;
			int leftTime = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.leftTime = leftTime;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index leftTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_targetEnemyID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneDataForExcehange obj2 = (SceneDataForExcehange)obj;
			int targetEnemyID = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.targetEnemyID = targetEnemyID;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index targetEnemyID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_nickName(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneDataForExcehange obj2 = (SceneDataForExcehange)obj;
			string nickName = ToLua.CheckString(L, 2);
			obj2.nickName = nickName;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index nickName on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_VHLSkillID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneDataForExcehange obj2 = (SceneDataForExcehange)obj;
			int[] vHLSkillID = ToLua.CheckNumberArray<int>(L, 2);
			obj2.VHLSkillID = vHLSkillID;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index VHLSkillID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_VHLResult(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneDataForExcehange obj2 = (SceneDataForExcehange)obj;
			int vHLResult = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.VHLResult = vHLResult;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index VHLResult on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_masterSkill(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SceneDataForExcehange obj2 = (SceneDataForExcehange)obj;
			MasterSkillDataForExchange masterSkill = (MasterSkillDataForExchange)ToLua.CheckObject<MasterSkillDataForExchange>(L, 2);
			obj2.masterSkill = masterSkill;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index masterSkill on a nil value");
		}
	}
}
