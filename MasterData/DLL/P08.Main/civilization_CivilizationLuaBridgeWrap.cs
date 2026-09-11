using System;
using LuaInterface;
using civilization;

public class civilization_CivilizationLuaBridgeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(CivilizationLuaBridge), typeof(object));
		L.RegFunction("PreLoadGame", PreLoadGame);
		L.RegFunction("PreLoadFactor", PreLoadFactor);
		L.RegFunction("PreLoadFactorLevel", PreLoadFactorLevel);
		L.RegFunction("PreLoadHero", PreLoadHero);
		L.RegFunction("PreLoadAge", PreLoadAge);
		L.RegFunction("PreLoadSkill", PreLoadSkill);
		L.RegFunction("PreLoadStage", PreLoadStage);
		L.RegFunction("PreLoadTeachStage", PreLoadTeachStage);
		L.RegFunction("StartGame", StartGame);
		L.RegFunction("ChooseTech", ChooseTech);
		L.RegFunction("ChooseHex", ChooseHex);
		L.RegFunction("EndGame", EndGame);
		L.RegFunction("GetTechUnlock", GetTechUnlock);
		L.RegFunction("GetTechSelect", GetTechSelect);
		L.RegFunction("GetInfoTips", GetInfoTips);
		L.RegFunction("OnCloseLuaPage", OnCloseLuaPage);
		L.RegFunction("SetGameCanDrag", SetGameCanDrag);
		L.RegFunction("CheckBlock", CheckBlock);
		L.RegFunction("CheckStage", CheckStage);
		L.RegFunction("New", _Createcivilization_CivilizationLuaBridge);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _Createcivilization_CivilizationLuaBridge(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				CivilizationLuaBridge o = new CivilizationLuaBridge();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: civilization.CivilizationLuaBridge.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PreLoadGame(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			CivilizationLuaBridge.PreLoadGame();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PreLoadFactor(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			int id = (int)LuaDLL.luaL_checknumber(L, 1);
			int type = (int)LuaDLL.luaL_checknumber(L, 2);
			int gainType = (int)LuaDLL.luaL_checknumber(L, 3);
			int[] nums = ToLua.CheckNumberArray<int>(L, 4);
			CivilizationLuaBridge.PreLoadFactor(id, type, gainType, nums);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PreLoadFactorLevel(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			int level = (int)LuaDLL.luaL_checknumber(L, 1);
			int cost = (int)LuaDLL.luaL_checknumber(L, 2);
			int[] techList = ToLua.CheckNumberArray<int>(L, 3);
			CivilizationLuaBridge.PreLoadFactorLevel(level, cost, techList);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PreLoadHero(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 5);
			int id = (int)LuaDLL.luaL_checknumber(L, 1);
			int startTech = (int)LuaDLL.luaL_checknumber(L, 2);
			int[] hex = ToLua.CheckNumberArray<int>(L, 3);
			int[] hex2 = ToLua.CheckNumberArray<int>(L, 4);
			int[] hex3 = ToLua.CheckNumberArray<int>(L, 5);
			CivilizationLuaBridge.PreLoadHero(id, startTech, hex, hex2, hex3);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PreLoadAge(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 7);
			int id = (int)LuaDLL.luaL_checknumber(L, 1);
			int startAge = (int)LuaDLL.luaL_checknumber(L, 2);
			int turnChange = (int)LuaDLL.luaL_checknumber(L, 3);
			int foodCostChange = (int)LuaDLL.luaL_checknumber(L, 4);
			bool mapExtension = LuaDLL.luaL_checkboolean(L, 5);
			bool hex = LuaDLL.luaL_checkboolean(L, 6);
			int[] sourceChange = ToLua.CheckNumberArray<int>(L, 7);
			CivilizationLuaBridge.PreLoadAge(id, startAge, turnChange, foodCostChange, mapExtension, hex, sourceChange);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PreLoadSkill(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			int id = (int)LuaDLL.luaL_checknumber(L, 1);
			int cost = (int)LuaDLL.luaL_checknumber(L, 2);
			int cd = (int)LuaDLL.luaL_checknumber(L, 3);
			string spritePath = ToLua.CheckString(L, 4);
			CivilizationLuaBridge.PreLoadSkill(id, cost, cd, spritePath);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PreLoadStage(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 6);
			int id = (int)LuaDLL.luaL_checknumber(L, 1);
			int activityID = (int)LuaDLL.luaL_checknumber(L, 2);
			int[] init_cell_list = ToLua.CheckNumberArray<int>(L, 3);
			int[] init_cells_location = ToLua.CheckNumberArray<int>(L, 4);
			int[] init_source = ToLua.CheckNumberArray<int>(L, 5);
			int[] init_factor = ToLua.CheckNumberArray<int>(L, 6);
			CivilizationLuaBridge.PreLoadStage(id, activityID, init_cell_list, init_cells_location, init_source, init_factor);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PreLoadTeachStage(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			int id = (int)LuaDLL.luaL_checknumber(L, 1);
			int[][] init_cells_location_list = ToLua.CheckObjectArray<int[]>(L, 2);
			int[][] create_cells_location = ToLua.CheckObjectArray<int[]>(L, 3);
			CivilizationLuaBridge.PreLoadTeachStage(id, init_cells_location_list, create_cells_location);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StartGame(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			int stageID = (int)LuaDLL.luaL_checknumber(L, 1);
			int heroID = (int)LuaDLL.luaL_checknumber(L, 2);
			int activityID = (int)LuaDLL.luaL_checknumber(L, 3);
			bool isTeach = LuaDLL.luaL_checkboolean(L, 4);
			CivilizationLuaBridge.StartGame(stageID, heroID, activityID, isTeach);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ChooseTech(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			CivilizationLuaBridge.ChooseTech((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ChooseHex(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			CivilizationLuaBridge.ChooseHex((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EndGame(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			CivilizationLuaBridge.EndGame();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetTechUnlock(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool techUnlock = CivilizationLuaBridge.GetTechUnlock((int)LuaDLL.luaL_checknumber(L, 1));
			LuaDLL.lua_pushboolean(L, techUnlock);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetTechSelect(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool techSelect = CivilizationLuaBridge.GetTechSelect((int)LuaDLL.luaL_checknumber(L, 1));
			LuaDLL.lua_pushboolean(L, techSelect);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetInfoTips(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			int[] infoTips = CivilizationLuaBridge.GetInfoTips();
			ToLua.Push(L, infoTips);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnCloseLuaPage(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			CivilizationLuaBridge.OnCloseLuaPage();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetGameCanDrag(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			bool canDrag = LuaDLL.luaL_checkboolean(L, 1);
			bool isTeach = LuaDLL.luaL_checkboolean(L, 2);
			CivilizationLuaBridge.SetGameCanDrag(canDrag, isTeach);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CheckBlock(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			int x = (int)LuaDLL.luaL_checknumber(L, 1);
			int y = (int)LuaDLL.luaL_checknumber(L, 2);
			int kind = (int)LuaDLL.luaL_checknumber(L, 3);
			bool value = CivilizationLuaBridge.CheckBlock(x, y, kind);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CheckStage(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			int n = CivilizationLuaBridge.CheckStage();
			LuaDLL.lua_pushinteger(L, n);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
