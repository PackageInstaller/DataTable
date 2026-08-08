using System;
using Chess;
using LuaInterface;
using UnityEngine;

public class ChessLuaBridgeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(ChessLuaBridge), typeof(object));
		L.RegFunction("Launcher", Launcher);
		L.RegFunction("MoveToCachePos", MoveToCachePos);
		L.RegFunction("ClearCachePath", ClearCachePath);
		L.RegFunction("SlideByDirection", SlideByDirection);
		L.RegFunction("ChangeGridByIndex", ChangeGridByIndex);
		L.RegFunction("ChangeGrid", ChangeGrid);
		L.RegFunction("ChangeGridStatus", ChangeGridStatus);
		L.RegFunction("PlayGridAnimation", PlayGridAnimation);
		L.RegFunction("GetGridData", GetGridData);
		L.RegFunction("TelePortRoleToPosition", TelePortRoleToPosition);
		L.RegFunction("RoleStopMove", RoleStopMove);
		L.RegFunction("LookAtPlayer", LookAtPlayer);
		L.RegFunction("MoveTarget", MoveTarget);
		L.RegFunction("MoveTargetSmooth", MoveTargetSmooth);
		L.RegFunction("LookAtTargetS", LookAtTargetS);
		L.RegFunction("LookAtTarget", LookAtTarget);
		L.RegFunction("SetCameraControlEnable", SetCameraControlEnable);
		L.RegFunction("SetChessInputEnable", SetChessInputEnable);
		L.RegFunction("SetGridSelectOutline", SetGridSelectOutline);
		L.RegFunction("InitGuider", InitGuider);
		L.RegFunction("MoveGuiderAlongPath", MoveGuiderAlongPath);
		L.RegFunction("MoveGuider", MoveGuider);
		L.RegFunction("SetCountText", SetCountText);
		L.RegFunction("FireByPlayer", FireByPlayer);
		L.RegFunction("GetPlayerDirection", GetPlayerDirection);
		L.RegFunction("FireBullet", FireBullet);
		L.RegFunction("RotateGrid", RotateGrid);
		L.RegFunction("GetCameraLookNearestNode", GetCameraLookNearestNode);
		L.RegFunction("ResetCameraYAxis", ResetCameraYAxis);
		L.RegFunction("LayDownChildBoat", LayDownChildBoat);
		L.RegFunction("PutUpChildBoat", PutUpChildBoat);
		L.RegFunction("LayDownChildBoatWithoutAnimation", LayDownChildBoatWithoutAnimation);
		L.RegFunction("PlayRoleAnimation", PlayRoleAnimation);
		L.RegFunction("StoneMove", StoneMove);
		L.RegFunction("StoneContinueMove", StoneContinueMove);
		L.RegFunction("ClearStoneCache", ClearStoneCache);
		L.RegFunction("New", _CreateChessLuaBridge);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("roleTmp", get_roleTmp, set_roleTmp);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateChessLuaBridge(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				ChessLuaBridge o = new ChessLuaBridge();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: ChessLuaBridge.New");
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
			ChessDataForExchange chessDataForExchange = (ChessDataForExchange)ToLua.CheckObject<ChessDataForExchange>(L, 1);
			Action callback = (Action)ToLua.CheckDelegate<Action>(L, 2);
			ChessLuaBridge.Launcher(chessDataForExchange, callback);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int MoveToCachePos(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			ChessLuaBridge.MoveToCachePos();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearCachePath(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			ChessLuaBridge.ClearCachePath();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SlideByDirection(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int direction = (int)LuaDLL.luaL_checknumber(L, 1);
			float speed = (float)LuaDLL.luaL_checknumber(L, 2);
			ChessLuaBridge.SlideByDirection(direction, speed);
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
			case 3:
			{
				int x2 = (int)LuaDLL.luaL_checknumber(L, 1);
				int z2 = (int)LuaDLL.luaL_checknumber(L, 2);
				int extendIndex2 = (int)LuaDLL.luaL_checknumber(L, 3);
				ChessLuaBridge.ChangeGridByIndex(x2, z2, extendIndex2);
				return 0;
			}
			case 4:
			{
				int x = (int)LuaDLL.luaL_checknumber(L, 1);
				int z = (int)LuaDLL.luaL_checknumber(L, 2);
				int extendIndex = (int)LuaDLL.luaL_checknumber(L, 3);
				Action callBack = (Action)ToLua.CheckDelegate<Action>(L, 4);
				ChessLuaBridge.ChangeGridByIndex(x, z, extendIndex, callBack);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: ChessLuaBridge.ChangeGridByIndex");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ChangeGrid(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				int x2 = (int)LuaDLL.luaL_checknumber(L, 1);
				int z2 = (int)LuaDLL.luaL_checknumber(L, 2);
				GridData gridData2 = (GridData)ToLua.CheckObject<GridData>(L, 3);
				ChessLuaBridge.ChangeGrid(x2, z2, gridData2);
				return 0;
			}
			case 4:
			{
				int x = (int)LuaDLL.luaL_checknumber(L, 1);
				int z = (int)LuaDLL.luaL_checknumber(L, 2);
				GridData gridData = (GridData)ToLua.CheckObject<GridData>(L, 3);
				Action callBack = (Action)ToLua.CheckDelegate<Action>(L, 4);
				ChessLuaBridge.ChangeGrid(x, z, gridData, callBack);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: ChessLuaBridge.ChangeGrid");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ChangeGridStatus(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				int x2 = (int)LuaDLL.luaL_checknumber(L, 1);
				int z2 = (int)LuaDLL.luaL_checknumber(L, 2);
				int status2 = (int)LuaDLL.luaL_checknumber(L, 3);
				ChessLuaBridge.ChangeGridStatus(x2, z2, status2);
				return 0;
			}
			case 4:
			{
				int x = (int)LuaDLL.luaL_checknumber(L, 1);
				int z = (int)LuaDLL.luaL_checknumber(L, 2);
				int status = (int)LuaDLL.luaL_checknumber(L, 3);
				Action func = (Action)ToLua.CheckDelegate<Action>(L, 4);
				ChessLuaBridge.ChangeGridStatus(x, z, status, func);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: ChessLuaBridge.ChangeGridStatus");
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
			case 3:
			{
				int x2 = (int)LuaDLL.luaL_checknumber(L, 1);
				int z2 = (int)LuaDLL.luaL_checknumber(L, 2);
				string ani2 = ToLua.CheckString(L, 3);
				ChessLuaBridge.PlayGridAnimation(x2, z2, ani2);
				return 0;
			}
			case 4:
			{
				int x = (int)LuaDLL.luaL_checknumber(L, 1);
				int z = (int)LuaDLL.luaL_checknumber(L, 2);
				string ani = ToLua.CheckString(L, 3);
				Action func = (Action)ToLua.CheckDelegate<Action>(L, 4);
				ChessLuaBridge.PlayGridAnimation(x, z, ani, func);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: ChessLuaBridge.PlayGridAnimation");
			}
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
			GridData gridData = ChessLuaBridge.GetGridData(x, z);
			ToLua.PushObject(L, gridData);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int TelePortRoleToPosition(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int x = (int)LuaDLL.luaL_checknumber(L, 1);
			int z = (int)LuaDLL.luaL_checknumber(L, 2);
			ChessLuaBridge.TelePortRoleToPosition(x, z);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RoleStopMove(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			ChessLuaBridge.RoleStopMove();
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
				ChessLuaBridge.LookAtPlayer();
				return 0;
			case 1:
				ChessLuaBridge.LookAtPlayer((Action)ToLua.CheckDelegate<Action>(L, 1));
				return 0;
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: ChessLuaBridge.LookAtPlayer");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int MoveTarget(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				int x2 = (int)LuaDLL.luaL_checknumber(L, 1);
				int z2 = (int)LuaDLL.luaL_checknumber(L, 2);
				ChessLuaBridge.MoveTarget(x2, z2);
				return 0;
			}
			case 3:
			{
				int x = (int)LuaDLL.luaL_checknumber(L, 1);
				int z = (int)LuaDLL.luaL_checknumber(L, 2);
				bool force = LuaDLL.luaL_checkboolean(L, 3);
				ChessLuaBridge.MoveTarget(x, z, force);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: ChessLuaBridge.MoveTarget");
			}
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
				ChessLuaBridge.MoveTargetSmooth(x5, z5);
				return 0;
			}
			case 3:
			{
				int x4 = (int)LuaDLL.luaL_checknumber(L, 1);
				int z4 = (int)LuaDLL.luaL_checknumber(L, 2);
				Action callBack4 = (Action)ToLua.CheckDelegate<Action>(L, 3);
				ChessLuaBridge.MoveTargetSmooth(x4, z4, callBack4);
				return 0;
			}
			case 4:
			{
				int x3 = (int)LuaDLL.luaL_checknumber(L, 1);
				int z3 = (int)LuaDLL.luaL_checknumber(L, 2);
				Action callBack3 = (Action)ToLua.CheckDelegate<Action>(L, 3);
				bool isUniform3 = LuaDLL.luaL_checkboolean(L, 4);
				ChessLuaBridge.MoveTargetSmooth(x3, z3, callBack3, isUniform3);
				return 0;
			}
			case 5:
			{
				int x2 = (int)LuaDLL.luaL_checknumber(L, 1);
				int z2 = (int)LuaDLL.luaL_checknumber(L, 2);
				Action callBack2 = (Action)ToLua.CheckDelegate<Action>(L, 3);
				bool isUniform2 = LuaDLL.luaL_checkboolean(L, 4);
				float speed2 = (float)LuaDLL.luaL_checknumber(L, 5);
				ChessLuaBridge.MoveTargetSmooth(x2, z2, callBack2, isUniform2, speed2);
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
				ChessLuaBridge.MoveTargetSmooth(x, z, callBack, isUniform, speed, force);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: ChessLuaBridge.MoveTargetSmooth");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LookAtTargetS(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				ChessLuaBridge.LookAtTargetS(ToLua.CheckObjectArray<Transform>(L, 1));
				return 0;
			case 2:
			{
				Transform[] targetS3 = ToLua.CheckObjectArray<Transform>(L, 1);
				float speed3 = (float)LuaDLL.luaL_checknumber(L, 2);
				ChessLuaBridge.LookAtTargetS(targetS3, speed3);
				return 0;
			}
			case 3:
			{
				Transform[] targetS2 = ToLua.CheckObjectArray<Transform>(L, 1);
				float speed2 = (float)LuaDLL.luaL_checknumber(L, 2);
				Action callBack2 = (Action)ToLua.CheckDelegate<Action>(L, 3);
				ChessLuaBridge.LookAtTargetS(targetS2, speed2, callBack2);
				return 0;
			}
			case 4:
			{
				Transform[] targetS = ToLua.CheckObjectArray<Transform>(L, 1);
				float speed = (float)LuaDLL.luaL_checknumber(L, 2);
				Action callBack = (Action)ToLua.CheckDelegate<Action>(L, 3);
				bool isUniform = LuaDLL.luaL_checkboolean(L, 4);
				ChessLuaBridge.LookAtTargetS(targetS, speed, callBack, isUniform);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: ChessLuaBridge.LookAtTargetS");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LookAtTarget(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				int[] x5 = ToLua.CheckNumberArray<int>(L, 1);
				int[] z5 = ToLua.CheckNumberArray<int>(L, 2);
				ChessLuaBridge.LookAtTarget(x5, z5);
				return 0;
			}
			case 3:
			{
				int[] x4 = ToLua.CheckNumberArray<int>(L, 1);
				int[] z4 = ToLua.CheckNumberArray<int>(L, 2);
				Action callBack4 = (Action)ToLua.CheckDelegate<Action>(L, 3);
				ChessLuaBridge.LookAtTarget(x4, z4, callBack4);
				return 0;
			}
			case 4:
			{
				int[] x3 = ToLua.CheckNumberArray<int>(L, 1);
				int[] z3 = ToLua.CheckNumberArray<int>(L, 2);
				Action callBack3 = (Action)ToLua.CheckDelegate<Action>(L, 3);
				bool isUniform3 = LuaDLL.luaL_checkboolean(L, 4);
				ChessLuaBridge.LookAtTarget(x3, z3, callBack3, isUniform3);
				return 0;
			}
			case 5:
			{
				int[] x2 = ToLua.CheckNumberArray<int>(L, 1);
				int[] z2 = ToLua.CheckNumberArray<int>(L, 2);
				Action callBack2 = (Action)ToLua.CheckDelegate<Action>(L, 3);
				bool isUniform2 = LuaDLL.luaL_checkboolean(L, 4);
				float speed2 = (float)LuaDLL.luaL_checknumber(L, 5);
				ChessLuaBridge.LookAtTarget(x2, z2, callBack2, isUniform2, speed2);
				return 0;
			}
			case 6:
			{
				int[] x = ToLua.CheckNumberArray<int>(L, 1);
				int[] z = ToLua.CheckNumberArray<int>(L, 2);
				Action callBack = (Action)ToLua.CheckDelegate<Action>(L, 3);
				bool isUniform = LuaDLL.luaL_checkboolean(L, 4);
				float speed = (float)LuaDLL.luaL_checknumber(L, 5);
				bool force = LuaDLL.luaL_checkboolean(L, 6);
				ChessLuaBridge.LookAtTarget(x, z, callBack, isUniform, speed, force);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: ChessLuaBridge.LookAtTarget");
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
			ChessLuaBridge.SetCameraControlEnable(LuaDLL.luaL_checkboolean(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetChessInputEnable(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			ChessLuaBridge.SetChessInputEnable(LuaDLL.luaL_checkboolean(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetGridSelectOutline(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			int x = (int)LuaDLL.luaL_checknumber(L, 1);
			int z = (int)LuaDLL.luaL_checknumber(L, 2);
			bool isSelect = LuaDLL.luaL_checkboolean(L, 3);
			ChessLuaBridge.SetGridSelectOutline(x, z, isSelect);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InitGuider(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			string path = ToLua.CheckString(L, 1);
			int x = (int)LuaDLL.luaL_checknumber(L, 2);
			int z = (int)LuaDLL.luaL_checknumber(L, 3);
			ChessLuaBridge.InitGuider(path, x, z);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int MoveGuiderAlongPath(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				int[] x3 = ToLua.CheckNumberArray<int>(L, 1);
				int[] z3 = ToLua.CheckNumberArray<int>(L, 2);
				ChessLuaBridge.MoveGuiderAlongPath(x3, z3);
				return 0;
			}
			case 3:
			{
				int[] x2 = ToLua.CheckNumberArray<int>(L, 1);
				int[] z2 = ToLua.CheckNumberArray<int>(L, 2);
				float speed2 = (float)LuaDLL.luaL_checknumber(L, 3);
				ChessLuaBridge.MoveGuiderAlongPath(x2, z2, speed2);
				return 0;
			}
			case 4:
			{
				int[] x = ToLua.CheckNumberArray<int>(L, 1);
				int[] z = ToLua.CheckNumberArray<int>(L, 2);
				float speed = (float)LuaDLL.luaL_checknumber(L, 3);
				Action callBack = (Action)ToLua.CheckDelegate<Action>(L, 4);
				ChessLuaBridge.MoveGuiderAlongPath(x, z, speed, callBack);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: ChessLuaBridge.MoveGuiderAlongPath");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int MoveGuider(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int x = (int)LuaDLL.luaL_checknumber(L, 1);
			int z = (int)LuaDLL.luaL_checknumber(L, 2);
			ChessLuaBridge.MoveGuider(x, z);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetCountText(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				ChessLuaBridge.SetCountText((int)LuaDLL.luaL_checknumber(L, 1));
				return 0;
			case 2:
			{
				int num = (int)LuaDLL.luaL_checknumber(L, 1);
				bool isActive = LuaDLL.luaL_checkboolean(L, 2);
				ChessLuaBridge.SetCountText(num, isActive);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: ChessLuaBridge.SetCountText");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int FireByPlayer(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			ChessLuaBridge.FireByPlayer();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetPlayerDirection(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			int playerDirection = ChessLuaBridge.GetPlayerDirection();
			LuaDLL.lua_pushinteger(L, playerDirection);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int FireBullet(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			int x = (int)LuaDLL.luaL_checknumber(L, 1);
			int z = (int)LuaDLL.luaL_checknumber(L, 2);
			int direction = (int)LuaDLL.luaL_checknumber(L, 3);
			ChessLuaBridge.FireBullet(x, z, direction);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RotateGrid(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				int x3 = (int)LuaDLL.luaL_checknumber(L, 1);
				int z3 = (int)LuaDLL.luaL_checknumber(L, 2);
				float angle3 = (float)LuaDLL.luaL_checknumber(L, 3);
				ChessLuaBridge.RotateGrid(x3, z3, angle3);
				return 0;
			}
			case 4:
			{
				int x2 = (int)LuaDLL.luaL_checknumber(L, 1);
				int z2 = (int)LuaDLL.luaL_checknumber(L, 2);
				float angle2 = (float)LuaDLL.luaL_checknumber(L, 3);
				float time2 = (float)LuaDLL.luaL_checknumber(L, 4);
				ChessLuaBridge.RotateGrid(x2, z2, angle2, time2);
				return 0;
			}
			case 5:
			{
				int x = (int)LuaDLL.luaL_checknumber(L, 1);
				int z = (int)LuaDLL.luaL_checknumber(L, 2);
				float angle = (float)LuaDLL.luaL_checknumber(L, 3);
				float time = (float)LuaDLL.luaL_checknumber(L, 4);
				Action callBack = (Action)ToLua.CheckDelegate<Action>(L, 5);
				ChessLuaBridge.RotateGrid(x, z, angle, time, callBack);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: ChessLuaBridge.RotateGrid");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCameraLookNearestNode(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			Vector2 cameraLookNearestNode = ChessLuaBridge.GetCameraLookNearestNode();
			ToLua.Push(L, cameraLookNearestNode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ResetCameraYAxis(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			ChessLuaBridge.ResetCameraYAxis();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LayDownChildBoat(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 0:
			{
				bool value3 = ChessLuaBridge.LayDownChildBoat();
				LuaDLL.lua_pushboolean(L, value3);
				return 1;
			}
			case 1:
			{
				bool value2 = ChessLuaBridge.LayDownChildBoat((int)LuaDLL.luaL_checknumber(L, 1));
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			case 2:
			{
				int range = (int)LuaDLL.luaL_checknumber(L, 1);
				Action callBack = (Action)ToLua.CheckDelegate<Action>(L, 2);
				bool value = ChessLuaBridge.LayDownChildBoat(range, callBack);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: ChessLuaBridge.LayDownChildBoat");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PutUpChildBoat(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 0:
			{
				bool value2 = ChessLuaBridge.PutUpChildBoat();
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			case 1:
			{
				bool value = ChessLuaBridge.PutUpChildBoat((Action)ToLua.CheckDelegate<Action>(L, 1));
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: ChessLuaBridge.PutUpChildBoat");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LayDownChildBoatWithoutAnimation(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				int x2 = (int)LuaDLL.luaL_checknumber(L, 1);
				int z2 = (int)LuaDLL.luaL_checknumber(L, 2);
				ChessLuaBridge.LayDownChildBoatWithoutAnimation(x2, z2);
				return 0;
			}
			case 3:
			{
				int x = (int)LuaDLL.luaL_checknumber(L, 1);
				int z = (int)LuaDLL.luaL_checknumber(L, 2);
				int range = (int)LuaDLL.luaL_checknumber(L, 3);
				ChessLuaBridge.LayDownChildBoatWithoutAnimation(x, z, range);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: ChessLuaBridge.LayDownChildBoatWithoutAnimation");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlayRoleAnimation(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				ChessLuaBridge.PlayRoleAnimation(ToLua.CheckString(L, 1));
				return 0;
			case 2:
			{
				string ani = ToLua.CheckString(L, 1);
				Action func = (Action)ToLua.CheckDelegate<Action>(L, 2);
				ChessLuaBridge.PlayRoleAnimation(ani, func);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: ChessLuaBridge.PlayRoleAnimation");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StoneMove(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int curx = (int)LuaDLL.luaL_checknumber(L, 1);
			int curz = (int)LuaDLL.luaL_checknumber(L, 2);
			ChessLuaBridge.StoneMove(curx, curz);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StoneContinueMove(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			ChessLuaBridge.StoneContinueMove();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearStoneCache(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			ChessLuaBridge.ClearStoneCache();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_roleTmp(IntPtr L)
	{
		try
		{
			ToLua.Push(L, ChessLuaBridge.roleTmp);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_roleTmp(IntPtr L)
	{
		try
		{
			ChessLuaBridge.roleTmp = (HexAnimatorExtendBoat)ToLua.CheckObject<HexAnimatorExtendBoat>(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
