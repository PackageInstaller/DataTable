using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;

public class CombineGameWorldWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(CombineGameWorld), typeof(MonoBehaviour));
		L.RegFunction("SetNextAction", SetNextAction);
		L.RegFunction("StartGame", StartGame);
		L.RegFunction("ResetGame", ResetGame);
		L.RegFunction("UpdateSkill", UpdateSkill);
		L.RegFunction("NewBlock", NewBlock);
		L.RegFunction("RefreshAllBlock", RefreshAllBlock);
		L.RegFunction("DetailBuryPointNeedData", DetailBuryPointNeedData);
		L.RegFunction("NextYear", NextYear);
		L.RegFunction("StartDrag", StartDrag);
		L.RegFunction("CheckBlock", CheckBlock);
		L.RegFunction("AddInitList", AddInitList);
		L.RegFunction("RefreshSkillStage", RefreshSkillStage);
		L.RegFunction("EndDrag", EndDrag);
		L.RegFunction("NewPoor", NewPoor);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("speed", get_speed, set_speed);
		L.RegVar("freeBlocks", get_freeBlocks, set_freeBlocks);
		L.RegVar("blockCells", get_blockCells, set_blockCells);
		L.RegVar("hightLimit", get_hightLimit, set_hightLimit);
		L.RegVar("wideLimit", get_wideLimit, set_wideLimit);
		L.RegVar("rock", get_rock, set_rock);
		L.RegVar("appearBlocks", get_appearBlocks, set_appearBlocks);
		L.RegVar("movingBlocks", get_movingBlocks, set_movingBlocks);
		L.RegVar("combiningBlocks", get_combiningBlocks, set_combiningBlocks);
		L.RegVar("wars", get_wars, set_wars);
		L.RegVar("buildings", get_buildings, set_buildings);
		L.RegVar("skillBlocks", get_skillBlocks, set_skillBlocks);
		L.RegVar("showingBlock", get_showingBlock, set_showingBlock);
		L.RegVar("movingBlock", get_movingBlock, set_movingBlock);
		L.RegVar("mouse", get_mouse, set_mouse);
		L.RegVar("nextYearAction", get_nextYearAction, set_nextYearAction);
		L.RegVar("mapExtensionAction", get_mapExtensionAction, set_mapExtensionAction);
		L.RegVar("startGameAction", get_startGameAction, set_startGameAction);
		L.RegVar("newTechAction", get_newTechAction, set_newTechAction);
		L.RegVar("newResourceAction", get_newResourceAction, set_newResourceAction);
		L.RegVar("buildResourceAction", get_buildResourceAction, set_buildResourceAction);
		L.RegVar("informationAction", get_informationAction, set_informationAction);
		L.RegVar("maxLevel", get_maxLevel, set_maxLevel);
		L.RegVar("minLevel", get_minLevel, set_minLevel);
		L.RegVar("mapExtension", get_mapExtension, set_mapExtension);
		L.RegVar("skillUseCount", get_skillUseCount, set_skillUseCount);
		L.RegVar("spriteList", get_spriteList, set_spriteList);
		L.RegVar("skillSprites", get_skillSprites, set_skillSprites);
		L.RegVar("gailv", get_gailv, set_gailv);
		L.RegVar("isTeach", get_isTeach, set_isTeach);
		L.RegVar("beastDestoryCount", get_beastDestoryCount, set_beastDestoryCount);
		L.RegVar("canDrag", get_canDrag, set_canDrag);
		L.RegVar("initPoolList", get_initPoolList, set_initPoolList);
		L.RegVar("Instance", get_Instance, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetNextAction(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			CombineGameWorld obj = (CombineGameWorld)ToLua.CheckObject<CombineGameWorld>(L, 1);
			Action nextAction = (Action)ToLua.CheckDelegate<Action>(L, 2);
			obj.SetNextAction(nextAction);
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
			ToLua.CheckArgsCount(L, 1);
			((CombineGameWorld)ToLua.CheckObject<CombineGameWorld>(L, 1)).StartGame();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ResetGame(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((CombineGameWorld)ToLua.CheckObject<CombineGameWorld>(L, 1)).ResetGame();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UpdateSkill(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 5);
			CombineGameWorld obj = (CombineGameWorld)ToLua.CheckObject<CombineGameWorld>(L, 1);
			int index = (int)LuaDLL.luaL_checknumber(L, 2);
			int type = (int)LuaDLL.luaL_checknumber(L, 3);
			int cost = (int)LuaDLL.luaL_checknumber(L, 4);
			int cd = (int)LuaDLL.luaL_checknumber(L, 5);
			obj.UpdateSkill(index, type, cost, cd);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int NewBlock(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				((CombineGameWorld)ToLua.CheckObject<CombineGameWorld>(L, 1)).NewBlock();
				return 0;
			case 5:
			{
				CombineGameWorld obj = (CombineGameWorld)ToLua.CheckObject<CombineGameWorld>(L, 1);
				int x = (int)LuaDLL.luaL_checknumber(L, 2);
				int y = (int)LuaDLL.luaL_checknumber(L, 3);
				int kind = (int)LuaDLL.luaL_checknumber(L, 4);
				int level = (int)LuaDLL.luaL_checknumber(L, 5);
				obj.NewBlock(x, y, kind, level);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: CombineGameWorld.NewBlock");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RefreshAllBlock(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((CombineGameWorld)ToLua.CheckObject<CombineGameWorld>(L, 1)).RefreshAllBlock();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DetailBuryPointNeedData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			List<int> o = ((CombineGameWorld)ToLua.CheckObject<CombineGameWorld>(L, 1)).DetailBuryPointNeedData();
			ToLua.PushSealed(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int NextYear(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((CombineGameWorld)ToLua.CheckObject<CombineGameWorld>(L, 1)).NextYear();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StartDrag(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			CombineGameWorld obj = (CombineGameWorld)ToLua.CheckObject<CombineGameWorld>(L, 1);
			CombineGameBlock b = (CombineGameBlock)ToLua.CheckObject<CombineGameBlock>(L, 2);
			obj.StartDrag(b);
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
			ToLua.CheckArgsCount(L, 4);
			CombineGameWorld obj = (CombineGameWorld)ToLua.CheckObject<CombineGameWorld>(L, 1);
			int x = (int)LuaDLL.luaL_checknumber(L, 2);
			int y = (int)LuaDLL.luaL_checknumber(L, 3);
			int kind = (int)LuaDLL.luaL_checknumber(L, 4);
			bool value = obj.CheckBlock(x, y, kind);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddInitList(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			CombineGameWorld obj = (CombineGameWorld)ToLua.CheckObject<CombineGameWorld>(L, 1);
			int x = (int)LuaDLL.luaL_checknumber(L, 2);
			int y = (int)LuaDLL.luaL_checknumber(L, 3);
			int kind = (int)LuaDLL.luaL_checknumber(L, 4);
			obj.AddInitList(x, y, kind);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RefreshSkillStage(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((CombineGameWorld)ToLua.CheckObject<CombineGameWorld>(L, 1)).RefreshSkillStage();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EndDrag(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((CombineGameWorld)ToLua.CheckObject<CombineGameWorld>(L, 1)).EndDrag();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int NewPoor(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((CombineGameWorld)ToLua.CheckObject<CombineGameWorld>(L, 1)).NewPoor();
			return 0;
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
	private static int get_speed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int speed = ((CombineGameWorld)obj).speed;
			LuaDLL.lua_pushinteger(L, speed);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index speed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_freeBlocks(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<CombineGameBlock> freeBlocks = ((CombineGameWorld)obj).freeBlocks;
			ToLua.PushSealed(L, freeBlocks);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index freeBlocks on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_blockCells(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CombineGameBlock[,] blockCells = ((CombineGameWorld)obj).blockCells;
			ToLua.Push(L, blockCells);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index blockCells on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_hightLimit(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int hightLimit = ((CombineGameWorld)obj).hightLimit;
			LuaDLL.lua_pushinteger(L, hightLimit);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index hightLimit on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_wideLimit(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int wideLimit = ((CombineGameWorld)obj).wideLimit;
			LuaDLL.lua_pushinteger(L, wideLimit);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wideLimit on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_rock(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int rock = ((CombineGameWorld)obj).rock;
			LuaDLL.lua_pushinteger(L, rock);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rock on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_appearBlocks(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<CombineGameWorld.WaitingBlock> appearBlocks = ((CombineGameWorld)obj).appearBlocks;
			ToLua.PushSealed(L, appearBlocks);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index appearBlocks on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_movingBlocks(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<CombineGameBlock> movingBlocks = ((CombineGameWorld)obj).movingBlocks;
			ToLua.PushSealed(L, movingBlocks);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index movingBlocks on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_combiningBlocks(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<CombineGameBlock> combiningBlocks = ((CombineGameWorld)obj).combiningBlocks;
			ToLua.PushSealed(L, combiningBlocks);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index combiningBlocks on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_wars(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<CombineGameBlock> wars = ((CombineGameWorld)obj).wars;
			ToLua.PushSealed(L, wars);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wars on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_buildings(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<CombineGameBlock> buildings = ((CombineGameWorld)obj).buildings;
			ToLua.PushSealed(L, buildings);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index buildings on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_skillBlocks(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<CombineGameBlock> skillBlocks = ((CombineGameWorld)obj).skillBlocks;
			ToLua.PushSealed(L, skillBlocks);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index skillBlocks on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_showingBlock(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CombineGameBlock showingBlock = ((CombineGameWorld)obj).showingBlock;
			ToLua.Push(L, showingBlock);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index showingBlock on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_movingBlock(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CombineGameBlock movingBlock = ((CombineGameWorld)obj).movingBlock;
			ToLua.Push(L, movingBlock);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index movingBlock on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mouse(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CombineGameMouse mouse = ((CombineGameWorld)obj).mouse;
			ToLua.Push(L, mouse);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mouse on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_nextYearAction(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Action nextYearAction = ((CombineGameWorld)obj).nextYearAction;
			ToLua.Push(L, nextYearAction);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index nextYearAction on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mapExtensionAction(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Action mapExtensionAction = ((CombineGameWorld)obj).mapExtensionAction;
			ToLua.Push(L, mapExtensionAction);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mapExtensionAction on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_startGameAction(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Action startGameAction = ((CombineGameWorld)obj).startGameAction;
			ToLua.Push(L, startGameAction);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startGameAction on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_newTechAction(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Action newTechAction = ((CombineGameWorld)obj).newTechAction;
			ToLua.Push(L, newTechAction);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index newTechAction on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_newResourceAction(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Action<int, int> newResourceAction = ((CombineGameWorld)obj).newResourceAction;
			ToLua.Push(L, newResourceAction);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index newResourceAction on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_buildResourceAction(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Action<int, int> buildResourceAction = ((CombineGameWorld)obj).buildResourceAction;
			ToLua.Push(L, buildResourceAction);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index buildResourceAction on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_informationAction(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Action<int, int, Transform> informationAction = ((CombineGameWorld)obj).informationAction;
			ToLua.Push(L, informationAction);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index informationAction on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maxLevel(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int maxLevel = ((CombineGameWorld)obj).maxLevel;
			LuaDLL.lua_pushinteger(L, maxLevel);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maxLevel on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_minLevel(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int minLevel = ((CombineGameWorld)obj).minLevel;
			LuaDLL.lua_pushinteger(L, minLevel);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index minLevel on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mapExtension(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool mapExtension = ((CombineGameWorld)obj).mapExtension;
			LuaDLL.lua_pushboolean(L, mapExtension);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mapExtension on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_skillUseCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Dictionary<int, int> skillUseCount = ((CombineGameWorld)obj).skillUseCount;
			ToLua.PushSealed(L, skillUseCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index skillUseCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_spriteList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<Sprite> spriteList = ((CombineGameWorld)obj).spriteList;
			ToLua.PushSealed(L, spriteList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index spriteList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_skillSprites(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Dictionary<int, Sprite> skillSprites = ((CombineGameWorld)obj).skillSprites;
			ToLua.PushSealed(L, skillSprites);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index skillSprites on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_gailv(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<int> gailv = ((CombineGameWorld)obj).gailv;
			ToLua.PushSealed(L, gailv);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index gailv on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isTeach(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isTeach = ((CombineGameWorld)obj).isTeach;
			LuaDLL.lua_pushboolean(L, isTeach);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isTeach on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_beastDestoryCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int beastDestoryCount = ((CombineGameWorld)obj).beastDestoryCount;
			LuaDLL.lua_pushinteger(L, beastDestoryCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index beastDestoryCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_canDrag(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool canDrag = ((CombineGameWorld)obj).canDrag;
			LuaDLL.lua_pushboolean(L, canDrag);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index canDrag on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_initPoolList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<List<int>> initPoolList = ((CombineGameWorld)obj).initPoolList;
			ToLua.PushSealed(L, initPoolList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index initPoolList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Instance(IntPtr L)
	{
		try
		{
			ToLua.Push(L, CombineGameWorld.Instance);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_speed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CombineGameWorld obj2 = (CombineGameWorld)obj;
			int speed = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.speed = speed;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index speed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_freeBlocks(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CombineGameWorld obj2 = (CombineGameWorld)obj;
			List<CombineGameBlock> freeBlocks = (List<CombineGameBlock>)ToLua.CheckObject(L, 2, typeof(List<CombineGameBlock>));
			obj2.freeBlocks = freeBlocks;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index freeBlocks on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_blockCells(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CombineGameWorld obj2 = (CombineGameWorld)obj;
			CombineGameBlock[,] blockCells = (CombineGameBlock[,])ToLua.CheckObject(L, 2, typeof(CombineGameBlock[,]));
			obj2.blockCells = blockCells;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index blockCells on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_hightLimit(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CombineGameWorld obj2 = (CombineGameWorld)obj;
			int hightLimit = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.hightLimit = hightLimit;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index hightLimit on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_wideLimit(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CombineGameWorld obj2 = (CombineGameWorld)obj;
			int wideLimit = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.wideLimit = wideLimit;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wideLimit on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_rock(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CombineGameWorld obj2 = (CombineGameWorld)obj;
			int rock = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.rock = rock;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rock on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_appearBlocks(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CombineGameWorld obj2 = (CombineGameWorld)obj;
			List<CombineGameWorld.WaitingBlock> appearBlocks = (List<CombineGameWorld.WaitingBlock>)ToLua.CheckObject(L, 2, typeof(List<CombineGameWorld.WaitingBlock>));
			obj2.appearBlocks = appearBlocks;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index appearBlocks on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_movingBlocks(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CombineGameWorld obj2 = (CombineGameWorld)obj;
			List<CombineGameBlock> movingBlocks = (List<CombineGameBlock>)ToLua.CheckObject(L, 2, typeof(List<CombineGameBlock>));
			obj2.movingBlocks = movingBlocks;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index movingBlocks on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_combiningBlocks(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CombineGameWorld obj2 = (CombineGameWorld)obj;
			List<CombineGameBlock> combiningBlocks = (List<CombineGameBlock>)ToLua.CheckObject(L, 2, typeof(List<CombineGameBlock>));
			obj2.combiningBlocks = combiningBlocks;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index combiningBlocks on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_wars(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CombineGameWorld obj2 = (CombineGameWorld)obj;
			List<CombineGameBlock> wars = (List<CombineGameBlock>)ToLua.CheckObject(L, 2, typeof(List<CombineGameBlock>));
			obj2.wars = wars;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wars on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_buildings(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CombineGameWorld obj2 = (CombineGameWorld)obj;
			List<CombineGameBlock> buildings = (List<CombineGameBlock>)ToLua.CheckObject(L, 2, typeof(List<CombineGameBlock>));
			obj2.buildings = buildings;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index buildings on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_skillBlocks(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CombineGameWorld obj2 = (CombineGameWorld)obj;
			List<CombineGameBlock> skillBlocks = (List<CombineGameBlock>)ToLua.CheckObject(L, 2, typeof(List<CombineGameBlock>));
			obj2.skillBlocks = skillBlocks;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index skillBlocks on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_showingBlock(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CombineGameWorld obj2 = (CombineGameWorld)obj;
			CombineGameBlock showingBlock = (CombineGameBlock)ToLua.CheckObject<CombineGameBlock>(L, 2);
			obj2.showingBlock = showingBlock;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index showingBlock on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_movingBlock(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CombineGameWorld obj2 = (CombineGameWorld)obj;
			CombineGameBlock movingBlock = (CombineGameBlock)ToLua.CheckObject<CombineGameBlock>(L, 2);
			obj2.movingBlock = movingBlock;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index movingBlock on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mouse(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CombineGameWorld obj2 = (CombineGameWorld)obj;
			CombineGameMouse mouse = (CombineGameMouse)ToLua.CheckObject<CombineGameMouse>(L, 2);
			obj2.mouse = mouse;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mouse on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_nextYearAction(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CombineGameWorld obj2 = (CombineGameWorld)obj;
			Action nextYearAction = (Action)ToLua.CheckDelegate<Action>(L, 2);
			obj2.nextYearAction = nextYearAction;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index nextYearAction on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mapExtensionAction(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CombineGameWorld obj2 = (CombineGameWorld)obj;
			Action mapExtensionAction = (Action)ToLua.CheckDelegate<Action>(L, 2);
			obj2.mapExtensionAction = mapExtensionAction;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mapExtensionAction on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_startGameAction(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CombineGameWorld obj2 = (CombineGameWorld)obj;
			Action startGameAction = (Action)ToLua.CheckDelegate<Action>(L, 2);
			obj2.startGameAction = startGameAction;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startGameAction on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_newTechAction(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CombineGameWorld obj2 = (CombineGameWorld)obj;
			Action newTechAction = (Action)ToLua.CheckDelegate<Action>(L, 2);
			obj2.newTechAction = newTechAction;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index newTechAction on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_newResourceAction(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CombineGameWorld obj2 = (CombineGameWorld)obj;
			Action<int, int> newResourceAction = (Action<int, int>)ToLua.CheckDelegate<Action<int, int>>(L, 2);
			obj2.newResourceAction = newResourceAction;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index newResourceAction on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_buildResourceAction(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CombineGameWorld obj2 = (CombineGameWorld)obj;
			Action<int, int> buildResourceAction = (Action<int, int>)ToLua.CheckDelegate<Action<int, int>>(L, 2);
			obj2.buildResourceAction = buildResourceAction;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index buildResourceAction on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_informationAction(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CombineGameWorld obj2 = (CombineGameWorld)obj;
			Action<int, int, Transform> informationAction = (Action<int, int, Transform>)ToLua.CheckDelegate<Action<int, int, Transform>>(L, 2);
			obj2.informationAction = informationAction;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index informationAction on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_maxLevel(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CombineGameWorld obj2 = (CombineGameWorld)obj;
			int maxLevel = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.maxLevel = maxLevel;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maxLevel on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_minLevel(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CombineGameWorld obj2 = (CombineGameWorld)obj;
			int minLevel = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.minLevel = minLevel;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index minLevel on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mapExtension(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CombineGameWorld obj2 = (CombineGameWorld)obj;
			bool mapExtension = LuaDLL.luaL_checkboolean(L, 2);
			obj2.mapExtension = mapExtension;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mapExtension on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_skillUseCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CombineGameWorld obj2 = (CombineGameWorld)obj;
			Dictionary<int, int> skillUseCount = (Dictionary<int, int>)ToLua.CheckObject(L, 2, typeof(Dictionary<int, int>));
			obj2.skillUseCount = skillUseCount;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index skillUseCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_spriteList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CombineGameWorld obj2 = (CombineGameWorld)obj;
			List<Sprite> spriteList = (List<Sprite>)ToLua.CheckObject(L, 2, typeof(List<Sprite>));
			obj2.spriteList = spriteList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index spriteList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_skillSprites(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CombineGameWorld obj2 = (CombineGameWorld)obj;
			Dictionary<int, Sprite> skillSprites = (Dictionary<int, Sprite>)ToLua.CheckObject(L, 2, typeof(Dictionary<int, Sprite>));
			obj2.skillSprites = skillSprites;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index skillSprites on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_gailv(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CombineGameWorld obj2 = (CombineGameWorld)obj;
			List<int> gailv = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
			obj2.gailv = gailv;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index gailv on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isTeach(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CombineGameWorld obj2 = (CombineGameWorld)obj;
			bool isTeach = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isTeach = isTeach;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isTeach on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_beastDestoryCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CombineGameWorld obj2 = (CombineGameWorld)obj;
			int beastDestoryCount = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.beastDestoryCount = beastDestoryCount;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index beastDestoryCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_canDrag(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CombineGameWorld obj2 = (CombineGameWorld)obj;
			bool canDrag = LuaDLL.luaL_checkboolean(L, 2);
			obj2.canDrag = canDrag;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index canDrag on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_initPoolList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CombineGameWorld obj2 = (CombineGameWorld)obj;
			List<List<int>> initPoolList = (List<List<int>>)ToLua.CheckObject(L, 2, typeof(List<List<int>>));
			obj2.initPoolList = initPoolList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index initPoolList on a nil value");
		}
	}
}
