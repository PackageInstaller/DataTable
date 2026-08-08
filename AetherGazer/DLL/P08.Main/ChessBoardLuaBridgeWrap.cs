using System;
using System.Collections.Generic;
using ChessBoard;
using LuaInterface;
using UnityEngine;

public class ChessBoardLuaBridgeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(ChessBoardLuaBridge), typeof(object));
		L.RegFunction("InitChessBoardConfigData", InitChessBoardConfigData);
		L.RegFunction("Launcher", Launcher);
		L.RegFunction("SetInputEnable", SetInputEnable);
		L.RegFunction("LookAtPlayer", LookAtPlayer);
		L.RegFunction("FindNextMovePos", FindNextMovePos);
		L.RegFunction("ExitChessBoard", ExitChessBoard);
		L.RegFunction("MoveHeroToPos", MoveHeroToPos);
		L.RegFunction("GetGridData", GetGridData);
		L.RegFunction("SetSelectingMovePos", SetSelectingMovePos);
		L.RegFunction("SetSelectingNPCMovePos", SetSelectingNPCMovePos);
		L.RegFunction("SetSelectingMapPos", SetSelectingMapPos);
		L.RegFunction("ChangeGridByIndex", ChangeGridByIndex);
		L.RegFunction("ChangeThingByIndex", ChangeThingByIndex);
		L.RegFunction("DeleteThing", DeleteThing);
		L.RegFunction("SetCameraControlEnable", SetCameraControlEnable);
		L.RegFunction("AddNPC", AddNPC);
		L.RegFunction("DeleteNPC", DeleteNPC);
		L.RegFunction("NPCMoveTo", NPCMoveTo);
		L.RegFunction("PlayGridAnimation", PlayGridAnimation);
		L.RegFunction("ShowArrowEffect", ShowArrowEffect);
		L.RegFunction("ShowMultArrowEffect", ShowMultArrowEffect);
		L.RegFunction("ShowChoiceEffect", ShowChoiceEffect);
		L.RegFunction("ShowTranferEffect", ShowTranferEffect);
		L.RegFunction("ClearMoveEffect", ClearMoveEffect);
		L.RegFunction("ClearChoiceEffect", ClearChoiceEffect);
		L.RegFunction("ClearTranferEffect", ClearTranferEffect);
		L.RegFunction("PlayEntityAction", PlayEntityAction);
		L.RegFunction("PlayEntityOverlap", PlayEntityOverlap);
		L.RegFunction("SetHeroPosAndDir", SetHeroPosAndDir);
		L.RegFunction("SetNPCPosAndDir", SetNPCPosAndDir);
		L.RegFunction("GetHeroTransPos", GetHeroTransPos);
		L.RegFunction("GetNPCTransPos", GetNPCTransPos);
		L.RegFunction("GetHeroTrans", GetHeroTrans);
		L.RegFunction("ChangeCameraToDiceCamera", ChangeCameraToDiceCamera);
		L.RegFunction("ChangeCameraToCloseCamera", ChangeCameraToCloseCamera);
		L.RegFunction("GetCurSmallMapData", GetCurSmallMapData);
		L.RegFunction("MoveTargetSmooth", MoveTargetSmooth);
		L.RegFunction("SetNPCToCameraTarget", SetNPCToCameraTarget);
		L.RegFunction("SetStepEffectActive", SetStepEffectActive);
		L.RegFunction("ShowNPCDestoryEffectActive", ShowNPCDestoryEffectActive);
		L.RegFunction("ClearNPCDestoryEffect", ClearNPCDestoryEffect);
		L.RegFunction("ShowAllThingChoiceEffect", ShowAllThingChoiceEffect);
		L.RegFunction("ShowAllNoThingGridChoiceEffect", ShowAllNoThingGridChoiceEffect);
		L.RegFunction("ChangeSpeedModule", ChangeSpeedModule);
		L.RegFunction("CheckHaveThingCanDestory", CheckHaveThingCanDestory);
		L.RegFunction("New", _CreateChessBoardLuaBridge);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateChessBoardLuaBridge(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				ChessBoardLuaBridge o = new ChessBoardLuaBridge();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: ChessBoardLuaBridge.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InitChessBoardConfigData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			ChessBoardLuaBridge.InitChessBoardConfigData((ChessBoardConfigData)ToLua.CheckObject<ChessBoardConfigData>(L, 1));
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
			ToLua.CheckArgsCount(L, 2);
			ChessBoardDataForExchange chessDataForExchange = (ChessBoardDataForExchange)ToLua.CheckObject<ChessBoardDataForExchange>(L, 1);
			Action callback = (Action)ToLua.CheckDelegate<Action>(L, 2);
			ChessBoardLuaBridge.Launcher(chessDataForExchange, callback);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetInputEnable(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			ChessBoardLuaBridge.SetInputEnable(LuaDLL.luaL_checkboolean(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LookAtPlayer(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 0:
				ChessBoardLuaBridge.LookAtPlayer();
				return 0;
			case 1:
				ChessBoardLuaBridge.LookAtPlayer((Action)ToLua.CheckDelegate<Action>(L, 1));
				return 0;
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: ChessBoardLuaBridge.LookAtPlayer");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int FindNextMovePos(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			int x = (int)LuaDLL.luaL_checknumber(L, 1);
			int z = (int)LuaDLL.luaL_checknumber(L, 2);
			int dir = (int)LuaDLL.luaL_checknumber(L, 3);
			List<ChessBoardGridData> o = ChessBoardLuaBridge.FindNextMovePos(x, z, dir);
			ToLua.PushSealed(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ExitChessBoard(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			ChessBoardLuaBridge.ExitChessBoard();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int MoveHeroToPos(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			int x = (int)LuaDLL.luaL_checknumber(L, 1);
			int z = (int)LuaDLL.luaL_checknumber(L, 2);
			Action callBack = (Action)ToLua.CheckDelegate<Action>(L, 3);
			ChessBoardLuaBridge.MoveHeroToPos(x, z, callBack);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetGridData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int x = (int)LuaDLL.luaL_checknumber(L, 1);
			int z = (int)LuaDLL.luaL_checknumber(L, 2);
			ChessBoardGridData gridData = ChessBoardLuaBridge.GetGridData(x, z);
			ToLua.PushObject(L, gridData);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetSelectingMovePos(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			ChessBoardLuaBridge.SetSelectingMovePos(LuaDLL.luaL_checkboolean(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetSelectingNPCMovePos(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			ChessBoardLuaBridge.SetSelectingNPCMovePos(LuaDLL.luaL_checkboolean(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetSelectingMapPos(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			ChessBoardLuaBridge.SetSelectingMapPos(LuaDLL.luaL_checkboolean(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ChangeGridByIndex(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 4:
			{
				int x2 = (int)LuaDLL.luaL_checknumber(L, 1);
				int z2 = (int)LuaDLL.luaL_checknumber(L, 2);
				int extendIndex2 = (int)LuaDLL.luaL_checknumber(L, 3);
				bool isInheritDir2 = LuaDLL.luaL_checkboolean(L, 4);
				ChessBoardLuaBridge.ChangeGridByIndex(x2, z2, extendIndex2, isInheritDir2);
				return 0;
			}
			case 5:
			{
				int x = (int)LuaDLL.luaL_checknumber(L, 1);
				int z = (int)LuaDLL.luaL_checknumber(L, 2);
				int extendIndex = (int)LuaDLL.luaL_checknumber(L, 3);
				bool isInheritDir = LuaDLL.luaL_checkboolean(L, 4);
				Action callBack = (Action)ToLua.CheckDelegate<Action>(L, 5);
				ChessBoardLuaBridge.ChangeGridByIndex(x, z, extendIndex, isInheritDir, callBack);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: ChessBoardLuaBridge.ChangeGridByIndex");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ChangeThingByIndex(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				int x2 = (int)LuaDLL.luaL_checknumber(L, 1);
				int z2 = (int)LuaDLL.luaL_checknumber(L, 2);
				int extendIndex2 = (int)LuaDLL.luaL_checknumber(L, 3);
				ChessBoardLuaBridge.ChangeThingByIndex(x2, z2, extendIndex2);
				return 0;
			}
			case 4:
			{
				int x = (int)LuaDLL.luaL_checknumber(L, 1);
				int z = (int)LuaDLL.luaL_checknumber(L, 2);
				int extendIndex = (int)LuaDLL.luaL_checknumber(L, 3);
				Action callBack = (Action)ToLua.CheckDelegate<Action>(L, 4);
				ChessBoardLuaBridge.ChangeThingByIndex(x, z, extendIndex, callBack);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: ChessBoardLuaBridge.ChangeThingByIndex");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DeleteThing(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				int x2 = (int)LuaDLL.luaL_checknumber(L, 1);
				int z2 = (int)LuaDLL.luaL_checknumber(L, 2);
				ChessBoardLuaBridge.DeleteThing(x2, z2);
				return 0;
			}
			case 3:
			{
				int x = (int)LuaDLL.luaL_checknumber(L, 1);
				int z = (int)LuaDLL.luaL_checknumber(L, 2);
				Action callBack = (Action)ToLua.CheckDelegate<Action>(L, 3);
				ChessBoardLuaBridge.DeleteThing(x, z, callBack);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: ChessBoardLuaBridge.DeleteThing");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetCameraControlEnable(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			ChessBoardLuaBridge.SetCameraControlEnable(LuaDLL.luaL_checkboolean(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddNPC(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 6);
			int nPCID = (int)LuaDLL.luaL_checknumber(L, 1);
			int x = (int)LuaDLL.luaL_checknumber(L, 2);
			int z = (int)LuaDLL.luaL_checknumber(L, 3);
			int dir = (int)LuaDLL.luaL_checknumber(L, 4);
			string prefab = ToLua.CheckString(L, 5);
			int actionType = (int)LuaDLL.luaL_checknumber(L, 6);
			ChessBoardLuaBridge.AddNPC(nPCID, x, z, dir, prefab, actionType);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DeleteNPC(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			ChessBoardLuaBridge.DeleteNPC((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int NPCMoveTo(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				int nPCID2 = (int)LuaDLL.luaL_checknumber(L, 1);
				int x2 = (int)LuaDLL.luaL_checknumber(L, 2);
				int z2 = (int)LuaDLL.luaL_checknumber(L, 3);
				ChessBoardLuaBridge.NPCMoveTo(nPCID2, x2, z2);
				return 0;
			}
			case 4:
			{
				int nPCID = (int)LuaDLL.luaL_checknumber(L, 1);
				int x = (int)LuaDLL.luaL_checknumber(L, 2);
				int z = (int)LuaDLL.luaL_checknumber(L, 3);
				Action callBack = (Action)ToLua.CheckDelegate<Action>(L, 4);
				ChessBoardLuaBridge.NPCMoveTo(nPCID, x, z, callBack);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: ChessBoardLuaBridge.NPCMoveTo");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlayGridAnimation(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 4:
			{
				int x2 = (int)LuaDLL.luaL_checknumber(L, 1);
				int z2 = (int)LuaDLL.luaL_checknumber(L, 2);
				string ani2 = ToLua.CheckString(L, 3);
				int target2 = (int)LuaDLL.luaL_checknumber(L, 4);
				ChessBoardLuaBridge.PlayGridAnimation(x2, z2, ani2, target2);
				return 0;
			}
			case 5:
			{
				int x = (int)LuaDLL.luaL_checknumber(L, 1);
				int z = (int)LuaDLL.luaL_checknumber(L, 2);
				string ani = ToLua.CheckString(L, 3);
				int target = (int)LuaDLL.luaL_checknumber(L, 4);
				Action func = (Action)ToLua.CheckDelegate<Action>(L, 5);
				ChessBoardLuaBridge.PlayGridAnimation(x, z, ani, target, func);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: ChessBoardLuaBridge.PlayGridAnimation");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ShowArrowEffect(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			int x = (int)LuaDLL.luaL_checknumber(L, 1);
			int z = (int)LuaDLL.luaL_checknumber(L, 2);
			int dir = (int)LuaDLL.luaL_checknumber(L, 3);
			ChessBoardLuaBridge.ShowArrowEffect(x, z, dir);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ShowMultArrowEffect(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			int x = (int)LuaDLL.luaL_checknumber(L, 1);
			int z = (int)LuaDLL.luaL_checknumber(L, 2);
			int dir = (int)LuaDLL.luaL_checknumber(L, 3);
			ChessBoardLuaBridge.ShowMultArrowEffect(x, z, dir);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ShowChoiceEffect(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int x = (int)LuaDLL.luaL_checknumber(L, 1);
			int z = (int)LuaDLL.luaL_checknumber(L, 2);
			ChessBoardLuaBridge.ShowChoiceEffect(x, z);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ShowTranferEffect(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int x = (int)LuaDLL.luaL_checknumber(L, 1);
			int z = (int)LuaDLL.luaL_checknumber(L, 2);
			ChessBoardLuaBridge.ShowTranferEffect(x, z);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearMoveEffect(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			ChessBoardLuaBridge.ClearMoveEffect();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearChoiceEffect(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			ChessBoardLuaBridge.ClearChoiceEffect();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearTranferEffect(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			ChessBoardLuaBridge.ClearTranferEffect();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlayEntityAction(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
			int actionType = (int)LuaDLL.luaL_checknumber(L, 2);
			ChessBoardLuaBridge.PlayEntityAction(entityID, actionType);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlayEntityOverlap(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int entityID = (int)LuaDLL.luaL_checknumber(L, 1);
			bool isShow = LuaDLL.luaL_checkboolean(L, 2);
			ChessBoardLuaBridge.PlayEntityOverlap(entityID, isShow);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetHeroPosAndDir(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			int x = (int)LuaDLL.luaL_checknumber(L, 1);
			int z = (int)LuaDLL.luaL_checknumber(L, 2);
			int dir = (int)LuaDLL.luaL_checknumber(L, 3);
			ChessBoardLuaBridge.SetHeroPosAndDir(x, z, dir);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetNPCPosAndDir(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			int nPCID = (int)LuaDLL.luaL_checknumber(L, 1);
			int x = (int)LuaDLL.luaL_checknumber(L, 2);
			int z = (int)LuaDLL.luaL_checknumber(L, 3);
			int dir = (int)LuaDLL.luaL_checknumber(L, 4);
			ChessBoardLuaBridge.SetNPCPosAndDir(nPCID, x, z, dir);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetHeroTransPos(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			Vector3 heroTransPos = ChessBoardLuaBridge.GetHeroTransPos();
			ToLua.Push(L, heroTransPos);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetNPCTransPos(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Vector3 nPCTransPos = ChessBoardLuaBridge.GetNPCTransPos((int)LuaDLL.luaL_checknumber(L, 1));
			ToLua.Push(L, nPCTransPos);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetHeroTrans(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			Transform heroTrans = ChessBoardLuaBridge.GetHeroTrans();
			ToLua.Push(L, heroTrans);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ChangeCameraToDiceCamera(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			ChessBoardLuaBridge.ChangeCameraToDiceCamera();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ChangeCameraToCloseCamera(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			ChessBoardLuaBridge.ChangeCameraToCloseCamera();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCurSmallMapData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			ChessBoardSmallMapData curSmallMapData = ChessBoardLuaBridge.GetCurSmallMapData();
			ToLua.PushObject(L, curSmallMapData);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int MoveTargetSmooth(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				int x5 = (int)LuaDLL.luaL_checknumber(L, 1);
				int z5 = (int)LuaDLL.luaL_checknumber(L, 2);
				ChessBoardLuaBridge.MoveTargetSmooth(x5, z5);
				return 0;
			}
			case 3:
			{
				int x4 = (int)LuaDLL.luaL_checknumber(L, 1);
				int z4 = (int)LuaDLL.luaL_checknumber(L, 2);
				Action callBack4 = (Action)ToLua.CheckDelegate<Action>(L, 3);
				ChessBoardLuaBridge.MoveTargetSmooth(x4, z4, callBack4);
				return 0;
			}
			case 4:
			{
				int x3 = (int)LuaDLL.luaL_checknumber(L, 1);
				int z3 = (int)LuaDLL.luaL_checknumber(L, 2);
				Action callBack3 = (Action)ToLua.CheckDelegate<Action>(L, 3);
				bool isUniform3 = LuaDLL.luaL_checkboolean(L, 4);
				ChessBoardLuaBridge.MoveTargetSmooth(x3, z3, callBack3, isUniform3);
				return 0;
			}
			case 5:
			{
				int x2 = (int)LuaDLL.luaL_checknumber(L, 1);
				int z2 = (int)LuaDLL.luaL_checknumber(L, 2);
				Action callBack2 = (Action)ToLua.CheckDelegate<Action>(L, 3);
				bool isUniform2 = LuaDLL.luaL_checkboolean(L, 4);
				float speed2 = (float)LuaDLL.luaL_checknumber(L, 5);
				ChessBoardLuaBridge.MoveTargetSmooth(x2, z2, callBack2, isUniform2, speed2);
				return 0;
			}
			case 6:
			{
				int x = (int)LuaDLL.luaL_checknumber(L, 1);
				int z = (int)LuaDLL.luaL_checknumber(L, 2);
				Action callBack = (Action)ToLua.CheckDelegate<Action>(L, 3);
				bool isUniform = LuaDLL.luaL_checkboolean(L, 4);
				float speed = (float)LuaDLL.luaL_checknumber(L, 5);
				bool force = LuaDLL.luaL_checkboolean(L, 6);
				ChessBoardLuaBridge.MoveTargetSmooth(x, z, callBack, isUniform, speed, force);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: ChessBoardLuaBridge.MoveTargetSmooth");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetNPCToCameraTarget(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			ChessBoardLuaBridge.SetNPCToCameraTarget((int)LuaDLL.luaL_checknumber(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetStepEffectActive(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			int x = (int)LuaDLL.luaL_checknumber(L, 1);
			int z = (int)LuaDLL.luaL_checknumber(L, 2);
			bool active = LuaDLL.luaL_checkboolean(L, 3);
			ChessBoardLuaBridge.SetStepEffectActive(x, z, active);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ShowNPCDestoryEffectActive(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int x = (int)LuaDLL.luaL_checknumber(L, 1);
			int z = (int)LuaDLL.luaL_checknumber(L, 2);
			ChessBoardLuaBridge.ShowNPCDestoryEffectActive(x, z);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearNPCDestoryEffect(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			ChessBoardLuaBridge.ClearNPCDestoryEffect();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ShowAllThingChoiceEffect(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			ChessBoardLuaBridge.ShowAllThingChoiceEffect();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ShowAllNoThingGridChoiceEffect(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int curX = (int)LuaDLL.luaL_checknumber(L, 1);
			int curZ = (int)LuaDLL.luaL_checknumber(L, 2);
			ChessBoardLuaBridge.ShowAllNoThingGridChoiceEffect(curX, curZ);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ChangeSpeedModule(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			ChessBoardLuaBridge.ChangeSpeedModule(LuaDLL.luaL_checkboolean(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CheckHaveThingCanDestory(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			bool value = ChessBoardLuaBridge.CheckHaveThingCanDestory();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
