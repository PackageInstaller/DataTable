using System;
using LuaInterface;
using NewChess;
using UnityEngine;

public class NewChessLuaBridgeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(NewChessLuaBridge), typeof(object));
		L.RegFunction("InitNewChessConfigData", InitNewChessConfigData);
		L.RegFunction("Launcher", Launcher);
		L.RegFunction("GetCameraLookNearestNode", GetCameraLookNearestNode);
		L.RegFunction("LookAtPlayer", LookAtPlayer);
		L.RegFunction("MoveToCachePos", MoveToCachePos);
		L.RegFunction("ClearCachePath", ClearCachePath);
		L.RegFunction("RoleStopMove", RoleStopMove);
		L.RegFunction("ShowGridSelectEffect", ShowGridSelectEffect);
		L.RegFunction("ClearGridSelectEffect", ClearGridSelectEffect);
		L.RegFunction("ClearAllSelectEffect", ClearAllSelectEffect);
		L.RegFunction("SetChessInputEnable", SetChessInputEnable);
		L.RegFunction("GetNewGridData", GetNewGridData);
		L.RegFunction("MoveTargetSmooth", MoveTargetSmooth);
		L.RegFunction("ChangeGridByIndex", ChangeGridByIndex);
		L.RegFunction("ChangeGrid", ChangeGrid);
		L.RegFunction("ChangeObjectByIndex", ChangeObjectByIndex);
		L.RegFunction("ChangeObject", ChangeObject);
		L.RegFunction("DeleteObject", DeleteObject);
		L.RegFunction("ChangeGridStatus", ChangeGridStatus);
		L.RegFunction("OpenAreaFog", OpenAreaFog);
		L.RegFunction("TelePortRoleToPosition", TelePortRoleToPosition);
		L.RegFunction("MoveConveyor", MoveConveyor);
		L.RegFunction("JumpBoard", JumpBoard);
		L.RegFunction("SetCameraControlEnable", SetCameraControlEnable);
		L.RegFunction("GetPlayerDirection", GetPlayerDirection);
		L.RegFunction("PlayGridAnimation", PlayGridAnimation);
		L.RegFunction("ExitNewWarChess", ExitNewWarChess);
		L.RegFunction("FixRolePositon", FixRolePositon);
		L.RegFunction("MoveRoleLogicPosition", MoveRoleLogicPosition);
		L.RegFunction("OpenBarFog", OpenBarFog);
		L.RegFunction("FixRoleY", FixRoleY);
		L.RegFunction("StopRoleMoving", StopRoleMoving);
		L.RegFunction("MoveByDir", MoveByDir);
		L.RegFunction("RotateGrid", RotateGrid);
		L.RegFunction("New", _CreateNewChessLuaBridge);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateNewChessLuaBridge(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				NewChessLuaBridge o = new NewChessLuaBridge();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: NewChessLuaBridge.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InitNewChessConfigData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			NewChessLuaBridge.InitNewChessConfigData((NewChessConfigData)ToLua.CheckObject<NewChessConfigData>(L, 1));
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
			NewChessDataForExchange chessDataForExchange = (NewChessDataForExchange)ToLua.CheckObject<NewChessDataForExchange>(L, 1);
			Action callback = (Action)ToLua.CheckDelegate<Action>(L, 2);
			NewChessLuaBridge.Launcher(chessDataForExchange, callback);
			return 0;
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
			Vector2 cameraLookNearestNode = NewChessLuaBridge.GetCameraLookNearestNode();
			ToLua.Push(L, cameraLookNearestNode);
			return 1;
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
				NewChessLuaBridge.LookAtPlayer();
				return 0;
			case 1:
				NewChessLuaBridge.LookAtPlayer((Action)ToLua.CheckDelegate<Action>(L, 1));
				return 0;
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: NewChessLuaBridge.LookAtPlayer");
			}
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
			NewChessLuaBridge.MoveToCachePos();
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
			NewChessLuaBridge.ClearCachePath();
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
			NewChessLuaBridge.RoleStopMove();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ShowGridSelectEffect(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			NewChessLuaBridge.ShowGridSelectEffect();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearGridSelectEffect(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int x = (int)LuaDLL.luaL_checknumber(L, 1);
			int z = (int)LuaDLL.luaL_checknumber(L, 2);
			NewChessLuaBridge.ClearGridSelectEffect(x, z);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearAllSelectEffect(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			NewChessLuaBridge.ClearAllSelectEffect();
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
			NewChessLuaBridge.SetChessInputEnable(LuaDLL.luaL_checkboolean(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetNewGridData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int x = (int)LuaDLL.luaL_checknumber(L, 1);
			int z = (int)LuaDLL.luaL_checknumber(L, 2);
			NewGridData newGridData = NewChessLuaBridge.GetNewGridData(x, z);
			ToLua.PushObject(L, newGridData);
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
				NewChessLuaBridge.MoveTargetSmooth(x5, z5);
				return 0;
			}
			case 3:
			{
				int x4 = (int)LuaDLL.luaL_checknumber(L, 1);
				int z4 = (int)LuaDLL.luaL_checknumber(L, 2);
				Action callBack4 = (Action)ToLua.CheckDelegate<Action>(L, 3);
				NewChessLuaBridge.MoveTargetSmooth(x4, z4, callBack4);
				return 0;
			}
			case 4:
			{
				int x3 = (int)LuaDLL.luaL_checknumber(L, 1);
				int z3 = (int)LuaDLL.luaL_checknumber(L, 2);
				Action callBack3 = (Action)ToLua.CheckDelegate<Action>(L, 3);
				bool isUniform3 = LuaDLL.luaL_checkboolean(L, 4);
				NewChessLuaBridge.MoveTargetSmooth(x3, z3, callBack3, isUniform3);
				return 0;
			}
			case 5:
			{
				int x2 = (int)LuaDLL.luaL_checknumber(L, 1);
				int z2 = (int)LuaDLL.luaL_checknumber(L, 2);
				Action callBack2 = (Action)ToLua.CheckDelegate<Action>(L, 3);
				bool isUniform2 = LuaDLL.luaL_checkboolean(L, 4);
				float speed2 = (float)LuaDLL.luaL_checknumber(L, 5);
				NewChessLuaBridge.MoveTargetSmooth(x2, z2, callBack2, isUniform2, speed2);
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
				NewChessLuaBridge.MoveTargetSmooth(x, z, callBack, isUniform, speed, force);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: NewChessLuaBridge.MoveTargetSmooth");
			}
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
				NewChessLuaBridge.ChangeGridByIndex(x2, z2, extendIndex2, isInheritDir2);
				return 0;
			}
			case 5:
			{
				int x = (int)LuaDLL.luaL_checknumber(L, 1);
				int z = (int)LuaDLL.luaL_checknumber(L, 2);
				int extendIndex = (int)LuaDLL.luaL_checknumber(L, 3);
				bool isInheritDir = LuaDLL.luaL_checkboolean(L, 4);
				Action callBack = (Action)ToLua.CheckDelegate<Action>(L, 5);
				NewChessLuaBridge.ChangeGridByIndex(x, z, extendIndex, isInheritDir, callBack);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: NewChessLuaBridge.ChangeGridByIndex");
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
				NewGridData gridData2 = (NewGridData)ToLua.CheckObject<NewGridData>(L, 3);
				NewChessLuaBridge.ChangeGrid(x2, z2, gridData2);
				return 0;
			}
			case 4:
			{
				int x = (int)LuaDLL.luaL_checknumber(L, 1);
				int z = (int)LuaDLL.luaL_checknumber(L, 2);
				NewGridData gridData = (NewGridData)ToLua.CheckObject<NewGridData>(L, 3);
				Action callBack = (Action)ToLua.CheckDelegate<Action>(L, 4);
				NewChessLuaBridge.ChangeGrid(x, z, gridData, callBack);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: NewChessLuaBridge.ChangeGrid");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ChangeObjectByIndex(IntPtr L)
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
				NewChessLuaBridge.ChangeObjectByIndex(x2, z2, extendIndex2);
				return 0;
			}
			case 4:
			{
				int x = (int)LuaDLL.luaL_checknumber(L, 1);
				int z = (int)LuaDLL.luaL_checknumber(L, 2);
				int extendIndex = (int)LuaDLL.luaL_checknumber(L, 3);
				Action callBack = (Action)ToLua.CheckDelegate<Action>(L, 4);
				NewChessLuaBridge.ChangeObjectByIndex(x, z, extendIndex, callBack);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: NewChessLuaBridge.ChangeObjectByIndex");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ChangeObject(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				int x2 = (int)LuaDLL.luaL_checknumber(L, 1);
				int z2 = (int)LuaDLL.luaL_checknumber(L, 2);
				NewGridData gridData2 = (NewGridData)ToLua.CheckObject<NewGridData>(L, 3);
				NewChessLuaBridge.ChangeObject(x2, z2, gridData2);
				return 0;
			}
			case 4:
			{
				int x = (int)LuaDLL.luaL_checknumber(L, 1);
				int z = (int)LuaDLL.luaL_checknumber(L, 2);
				NewGridData gridData = (NewGridData)ToLua.CheckObject<NewGridData>(L, 3);
				Action callBack = (Action)ToLua.CheckDelegate<Action>(L, 4);
				NewChessLuaBridge.ChangeObject(x, z, gridData, callBack);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: NewChessLuaBridge.ChangeObject");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DeleteObject(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				int x2 = (int)LuaDLL.luaL_checknumber(L, 1);
				int z2 = (int)LuaDLL.luaL_checknumber(L, 2);
				NewChessLuaBridge.DeleteObject(x2, z2);
				return 0;
			}
			case 3:
			{
				int x = (int)LuaDLL.luaL_checknumber(L, 1);
				int z = (int)LuaDLL.luaL_checknumber(L, 2);
				Action callBack = (Action)ToLua.CheckDelegate<Action>(L, 3);
				NewChessLuaBridge.DeleteObject(x, z, callBack);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: NewChessLuaBridge.DeleteObject");
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
				NewChessLuaBridge.ChangeGridStatus(x2, z2, status2);
				return 0;
			}
			case 4:
			{
				int x = (int)LuaDLL.luaL_checknumber(L, 1);
				int z = (int)LuaDLL.luaL_checknumber(L, 2);
				int status = (int)LuaDLL.luaL_checknumber(L, 3);
				Action func = (Action)ToLua.CheckDelegate<Action>(L, 4);
				NewChessLuaBridge.ChangeGridStatus(x, z, status, func);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: NewChessLuaBridge.ChangeGridStatus");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OpenAreaFog(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				int x2 = (int)LuaDLL.luaL_checknumber(L, 1);
				int z2 = (int)LuaDLL.luaL_checknumber(L, 2);
				int length2 = (int)LuaDLL.luaL_checknumber(L, 3);
				NewChessLuaBridge.OpenAreaFog(x2, z2, length2);
				return 0;
			}
			case 4:
			{
				int x = (int)LuaDLL.luaL_checknumber(L, 1);
				int z = (int)LuaDLL.luaL_checknumber(L, 2);
				int length = (int)LuaDLL.luaL_checknumber(L, 3);
				Action func = (Action)ToLua.CheckDelegate<Action>(L, 4);
				NewChessLuaBridge.OpenAreaFog(x, z, length, func);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: NewChessLuaBridge.OpenAreaFog");
			}
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
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				int x2 = (int)LuaDLL.luaL_checknumber(L, 1);
				int z2 = (int)LuaDLL.luaL_checknumber(L, 2);
				NewChessLuaBridge.TelePortRoleToPosition(x2, z2);
				return 0;
			}
			case 3:
			{
				int x = (int)LuaDLL.luaL_checknumber(L, 1);
				int z = (int)LuaDLL.luaL_checknumber(L, 2);
				Action func = (Action)ToLua.CheckDelegate<Action>(L, 3);
				NewChessLuaBridge.TelePortRoleToPosition(x, z, func);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: NewChessLuaBridge.TelePortRoleToPosition");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int MoveConveyor(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				int x2 = (int)LuaDLL.luaL_checknumber(L, 1);
				int z2 = (int)LuaDLL.luaL_checknumber(L, 2);
				bool isReverse2 = LuaDLL.luaL_checkboolean(L, 3);
				NewChessLuaBridge.MoveConveyor(x2, z2, isReverse2);
				return 0;
			}
			case 4:
			{
				int x = (int)LuaDLL.luaL_checknumber(L, 1);
				int z = (int)LuaDLL.luaL_checknumber(L, 2);
				bool isReverse = LuaDLL.luaL_checkboolean(L, 3);
				Action func = (Action)ToLua.CheckDelegate<Action>(L, 4);
				NewChessLuaBridge.MoveConveyor(x, z, isReverse, func);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: NewChessLuaBridge.MoveConveyor");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int JumpBoard(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 4:
			{
				int x2 = (int)LuaDLL.luaL_checknumber(L, 1);
				int z2 = (int)LuaDLL.luaL_checknumber(L, 2);
				int length2 = (int)LuaDLL.luaL_checknumber(L, 3);
				int dir2 = (int)LuaDLL.luaL_checknumber(L, 4);
				NewChessLuaBridge.JumpBoard(x2, z2, length2, dir2);
				return 0;
			}
			case 5:
			{
				int x = (int)LuaDLL.luaL_checknumber(L, 1);
				int z = (int)LuaDLL.luaL_checknumber(L, 2);
				int length = (int)LuaDLL.luaL_checknumber(L, 3);
				int dir = (int)LuaDLL.luaL_checknumber(L, 4);
				Action func = (Action)ToLua.CheckDelegate<Action>(L, 5);
				NewChessLuaBridge.JumpBoard(x, z, length, dir, func);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: NewChessLuaBridge.JumpBoard");
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
			NewChessLuaBridge.SetCameraControlEnable(LuaDLL.luaL_checkboolean(L, 1));
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
			int playerDirection = NewChessLuaBridge.GetPlayerDirection();
			LuaDLL.lua_pushinteger(L, playerDirection);
			return 1;
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
				NewChessLuaBridge.PlayGridAnimation(x2, z2, ani2, target2);
				return 0;
			}
			case 5:
			{
				int x = (int)LuaDLL.luaL_checknumber(L, 1);
				int z = (int)LuaDLL.luaL_checknumber(L, 2);
				string ani = ToLua.CheckString(L, 3);
				int target = (int)LuaDLL.luaL_checknumber(L, 4);
				Action func = (Action)ToLua.CheckDelegate<Action>(L, 5);
				NewChessLuaBridge.PlayGridAnimation(x, z, ani, target, func);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: NewChessLuaBridge.PlayGridAnimation");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ExitNewWarChess(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			NewChessLuaBridge.ExitNewWarChess();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int FixRolePositon(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			NewChessLuaBridge.FixRolePositon();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int MoveRoleLogicPosition(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int x = (int)LuaDLL.luaL_checknumber(L, 1);
			int z = (int)LuaDLL.luaL_checknumber(L, 2);
			NewChessLuaBridge.MoveRoleLogicPosition(x, z);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OpenBarFog(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 4:
			{
				int x2 = (int)LuaDLL.luaL_checknumber(L, 1);
				int z2 = (int)LuaDLL.luaL_checknumber(L, 2);
				int dir2 = (int)LuaDLL.luaL_checknumber(L, 3);
				int length2 = (int)LuaDLL.luaL_checknumber(L, 4);
				NewChessLuaBridge.OpenBarFog(x2, z2, dir2, length2);
				return 0;
			}
			case 5:
			{
				int x = (int)LuaDLL.luaL_checknumber(L, 1);
				int z = (int)LuaDLL.luaL_checknumber(L, 2);
				int dir = (int)LuaDLL.luaL_checknumber(L, 3);
				int length = (int)LuaDLL.luaL_checknumber(L, 4);
				Action callBack = (Action)ToLua.CheckDelegate<Action>(L, 5);
				NewChessLuaBridge.OpenBarFog(x, z, dir, length, callBack);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: NewChessLuaBridge.OpenBarFog");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int FixRoleY(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int subLayer = (int)LuaDLL.luaL_checknumber(L, 1);
			int fixtime = (int)LuaDLL.luaL_checknumber(L, 2);
			NewChessLuaBridge.FixRoleY(subLayer, fixtime);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StopRoleMoving(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			NewChessLuaBridge.StopRoleMoving();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int MoveByDir(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				int x2 = (int)LuaDLL.luaL_checknumber(L, 1);
				int z2 = (int)LuaDLL.luaL_checknumber(L, 2);
				int dir2 = (int)LuaDLL.luaL_checknumber(L, 3);
				NewChessLuaBridge.MoveByDir(x2, z2, dir2);
				return 0;
			}
			case 4:
			{
				int x = (int)LuaDLL.luaL_checknumber(L, 1);
				int z = (int)LuaDLL.luaL_checknumber(L, 2);
				int dir = (int)LuaDLL.luaL_checknumber(L, 3);
				Action func = (Action)ToLua.CheckDelegate<Action>(L, 4);
				NewChessLuaBridge.MoveByDir(x, z, dir, func);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: NewChessLuaBridge.MoveByDir");
			}
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
				NewChessLuaBridge.RotateGrid(x3, z3, angle3);
				return 0;
			}
			case 4:
			{
				int x2 = (int)LuaDLL.luaL_checknumber(L, 1);
				int z2 = (int)LuaDLL.luaL_checknumber(L, 2);
				float angle2 = (float)LuaDLL.luaL_checknumber(L, 3);
				float time2 = (float)LuaDLL.luaL_checknumber(L, 4);
				NewChessLuaBridge.RotateGrid(x2, z2, angle2, time2);
				return 0;
			}
			case 5:
			{
				int x = (int)LuaDLL.luaL_checknumber(L, 1);
				int z = (int)LuaDLL.luaL_checknumber(L, 2);
				float angle = (float)LuaDLL.luaL_checknumber(L, 3);
				float time = (float)LuaDLL.luaL_checknumber(L, 4);
				Action callBack = (Action)ToLua.CheckDelegate<Action>(L, 5);
				NewChessLuaBridge.RotateGrid(x, z, angle, time, callBack);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: NewChessLuaBridge.RotateGrid");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
