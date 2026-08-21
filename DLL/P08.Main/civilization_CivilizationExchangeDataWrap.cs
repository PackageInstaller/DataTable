using System;
using System.Collections.Generic;
using LuaInterface;
using civilization;

public class civilization_CivilizationExchangeDataWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(CivilizationExchangeData), typeof(object));
		L.RegFunction("SetTech", SetTech);
		L.RegFunction("SetBlock", SetBlock);
		L.RegFunction("New", _Createcivilization_CivilizationExchangeData);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("activityID", get_activityID, set_activityID);
		L.RegVar("stageID", get_stageID, set_stageID);
		L.RegVar("result", get_result, set_result);
		L.RegVar("heroID", get_heroID, set_heroID);
		L.RegVar("age", get_age, set_age);
		L.RegVar("turn", get_turn, set_turn);
		L.RegVar("seconds", get_seconds, set_seconds);
		L.RegVar("gridList", get_gridList, set_gridList);
		L.RegVar("gridTypeList", get_gridTypeList, set_gridTypeList);
		L.RegVar("techList", get_techList, set_techList);
		L.RegVar("hexList", get_hexList, set_hexList);
		L.RegVar("source", get_source, set_source);
		L.RegVar("useSkillID", get_useSkillID, set_useSkillID);
		L.RegVar("useSkillNum", get_useSkillNum, set_useSkillNum);
		L.RegVar("unlockSkill", get_unlockSkill, set_unlockSkill);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _Createcivilization_CivilizationExchangeData(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 3)
			{
				int activityID = (int)LuaDLL.luaL_checknumber(L, 1);
				int stageID = (int)LuaDLL.luaL_checknumber(L, 2);
				int heroID = (int)LuaDLL.luaL_checknumber(L, 3);
				CivilizationExchangeData o = new CivilizationExchangeData(activityID, stageID, heroID);
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: civilization.CivilizationExchangeData.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetTech(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			CivilizationExchangeData obj = (CivilizationExchangeData)ToLua.CheckObject<CivilizationExchangeData>(L, 1);
			int techID = (int)LuaDLL.luaL_checknumber(L, 2);
			bool isHex = LuaDLL.luaL_checkboolean(L, 3);
			obj.SetTech(techID, isHex);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetBlock(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			CivilizationExchangeData obj = (CivilizationExchangeData)ToLua.CheckObject<CivilizationExchangeData>(L, 1);
			int block = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.SetBlock(block);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_activityID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int activityID = ((CivilizationExchangeData)obj).activityID;
			LuaDLL.lua_pushinteger(L, activityID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index activityID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_stageID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int stageID = ((CivilizationExchangeData)obj).stageID;
			LuaDLL.lua_pushinteger(L, stageID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stageID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_result(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int result = ((CivilizationExchangeData)obj).result;
			LuaDLL.lua_pushinteger(L, result);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index result on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_heroID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int heroID = ((CivilizationExchangeData)obj).heroID;
			LuaDLL.lua_pushinteger(L, heroID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index heroID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_age(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int age = ((CivilizationExchangeData)obj).age;
			LuaDLL.lua_pushinteger(L, age);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index age on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_turn(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int turn = ((CivilizationExchangeData)obj).turn;
			LuaDLL.lua_pushinteger(L, turn);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index turn on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_seconds(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int seconds = ((CivilizationExchangeData)obj).seconds;
			LuaDLL.lua_pushinteger(L, seconds);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index seconds on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_gridList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<int> gridList = ((CivilizationExchangeData)obj).gridList;
			ToLua.PushSealed(L, gridList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index gridList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_gridTypeList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<int> gridTypeList = ((CivilizationExchangeData)obj).gridTypeList;
			ToLua.PushSealed(L, gridTypeList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index gridTypeList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_techList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<int> techList = ((CivilizationExchangeData)obj).techList;
			ToLua.PushSealed(L, techList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index techList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_hexList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<int> hexList = ((CivilizationExchangeData)obj).hexList;
			ToLua.PushSealed(L, hexList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index hexList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_source(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<int> source = ((CivilizationExchangeData)obj).source;
			ToLua.PushSealed(L, source);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index source on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_useSkillID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<int> useSkillID = ((CivilizationExchangeData)obj).useSkillID;
			ToLua.PushSealed(L, useSkillID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useSkillID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_useSkillNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<int> useSkillNum = ((CivilizationExchangeData)obj).useSkillNum;
			ToLua.PushSealed(L, useSkillNum);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useSkillNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_unlockSkill(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<int> unlockSkill = ((CivilizationExchangeData)obj).unlockSkill;
			ToLua.PushSealed(L, unlockSkill);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index unlockSkill on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_activityID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CivilizationExchangeData obj2 = (CivilizationExchangeData)obj;
			int activityID = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.activityID = activityID;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index activityID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_stageID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CivilizationExchangeData obj2 = (CivilizationExchangeData)obj;
			int stageID = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.stageID = stageID;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stageID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_result(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CivilizationExchangeData obj2 = (CivilizationExchangeData)obj;
			int result = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.result = result;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index result on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_heroID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CivilizationExchangeData obj2 = (CivilizationExchangeData)obj;
			int heroID = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.heroID = heroID;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index heroID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_age(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CivilizationExchangeData obj2 = (CivilizationExchangeData)obj;
			int age = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.age = age;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index age on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_turn(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CivilizationExchangeData obj2 = (CivilizationExchangeData)obj;
			int turn = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.turn = turn;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index turn on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_seconds(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CivilizationExchangeData obj2 = (CivilizationExchangeData)obj;
			int seconds = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.seconds = seconds;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index seconds on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_gridList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CivilizationExchangeData obj2 = (CivilizationExchangeData)obj;
			List<int> gridList = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
			obj2.gridList = gridList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index gridList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_gridTypeList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CivilizationExchangeData obj2 = (CivilizationExchangeData)obj;
			List<int> gridTypeList = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
			obj2.gridTypeList = gridTypeList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index gridTypeList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_techList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CivilizationExchangeData obj2 = (CivilizationExchangeData)obj;
			List<int> techList = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
			obj2.techList = techList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index techList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_hexList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CivilizationExchangeData obj2 = (CivilizationExchangeData)obj;
			List<int> hexList = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
			obj2.hexList = hexList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index hexList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_source(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CivilizationExchangeData obj2 = (CivilizationExchangeData)obj;
			List<int> source = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
			obj2.source = source;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index source on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_useSkillID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CivilizationExchangeData obj2 = (CivilizationExchangeData)obj;
			List<int> useSkillID = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
			obj2.useSkillID = useSkillID;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useSkillID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_useSkillNum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CivilizationExchangeData obj2 = (CivilizationExchangeData)obj;
			List<int> useSkillNum = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
			obj2.useSkillNum = useSkillNum;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useSkillNum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_unlockSkill(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CivilizationExchangeData obj2 = (CivilizationExchangeData)obj;
			List<int> unlockSkill = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
			obj2.unlockSkill = unlockSkill;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index unlockSkill on a nil value");
		}
	}
}
