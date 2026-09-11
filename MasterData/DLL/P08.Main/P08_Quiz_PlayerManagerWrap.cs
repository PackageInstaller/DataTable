using System;
using System.Collections.Generic;
using LuaInterface;
using P08.Quiz;
using UnityEngine;

public class P08_Quiz_PlayerManagerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(PlayerManager), typeof(Singleton<PlayerManager>));
		L.RegFunction("AddLocalPlayer", AddLocalPlayer);
		L.RegFunction("AddRemotePlayer", AddRemotePlayer);
		L.RegFunction("ChangeModel", ChangeModel);
		L.RegFunction("ScaleModel", ScaleModel);
		L.RegFunction("RestoreLastModel", RestoreLastModel);
		L.RegFunction("FindByPlayerId", FindByPlayerId);
		L.RegFunction("RemovePlayerById", RemovePlayerById);
		L.RegFunction("SetRemotePlayerPos", SetRemotePlayerPos);
		L.RegFunction("SetPlayerPosForce", SetPlayerPosForce);
		L.RegFunction("SetAllPlayersNickNameVisible", SetAllPlayersNickNameVisible);
		L.RegFunction("DoDestroy", DoDestroy);
		L.RegFunction("New", _CreateP08_Quiz_PlayerManager);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("LocalPlayer", get_LocalPlayer, set_LocalPlayer);
		L.RegVar("PlayerList", get_PlayerList, set_PlayerList);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateP08_Quiz_PlayerManager(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				PlayerManager o = new PlayerManager();
				ToLua.PushSealed(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: P08.Quiz.PlayerManager.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddLocalPlayer(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PlayerManager obj = (PlayerManager)ToLua.CheckObject(L, 1, typeof(PlayerManager));
			QuizPlayerInfo playerInfo = (QuizPlayerInfo)ToLua.CheckObject<QuizPlayerInfo>(L, 2);
			obj.AddLocalPlayer(playerInfo);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddRemotePlayer(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PlayerManager obj = (PlayerManager)ToLua.CheckObject(L, 1, typeof(PlayerManager));
			QuizPlayerInfo playerInfo = (QuizPlayerInfo)ToLua.CheckObject<QuizPlayerInfo>(L, 2);
			obj.AddRemotePlayer(playerInfo);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ChangeModel(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			PlayerManager obj = (PlayerManager)ToLua.CheckObject(L, 1, typeof(PlayerManager));
			long playerId = LuaDLL.tolua_checkint64(L, 2);
			int roleId = (int)LuaDLL.luaL_checknumber(L, 3);
			obj.ChangeModel(playerId, roleId);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ScaleModel(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			PlayerManager obj = (PlayerManager)ToLua.CheckObject(L, 1, typeof(PlayerManager));
			long playerId = LuaDLL.tolua_checkint64(L, 2);
			float scale = (float)LuaDLL.luaL_checknumber(L, 3);
			obj.ScaleModel(playerId, scale);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RestoreLastModel(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PlayerManager obj = (PlayerManager)ToLua.CheckObject(L, 1, typeof(PlayerManager));
			long playerId = LuaDLL.tolua_checkint64(L, 2);
			obj.RestoreLastModel(playerId);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int FindByPlayerId(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PlayerManager obj = (PlayerManager)ToLua.CheckObject(L, 1, typeof(PlayerManager));
			long playerId = LuaDLL.tolua_checkint64(L, 2);
			QuizPlayer o = obj.FindByPlayerId(playerId);
			ToLua.PushSealed(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RemovePlayerById(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PlayerManager obj = (PlayerManager)ToLua.CheckObject(L, 1, typeof(PlayerManager));
			long playerId = LuaDLL.tolua_checkint64(L, 2);
			obj.RemovePlayerById(playerId);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetRemotePlayerPos(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			PlayerManager obj = (PlayerManager)ToLua.CheckObject(L, 1, typeof(PlayerManager));
			long playerId = LuaDLL.tolua_checkint64(L, 2);
			float x = (float)LuaDLL.luaL_checknumber(L, 3);
			float z = (float)LuaDLL.luaL_checknumber(L, 4);
			obj.SetRemotePlayerPos(playerId, x, z);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetPlayerPosForce(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			PlayerManager obj = (PlayerManager)ToLua.CheckObject(L, 1, typeof(PlayerManager));
			long playerId = LuaDLL.tolua_checkint64(L, 2);
			Vector3 position = ToLua.ToVector3(L, 3);
			Quaternion rotation = ToLua.ToQuaternion(L, 4);
			obj.SetPlayerPosForce(playerId, position, rotation);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetAllPlayersNickNameVisible(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PlayerManager obj = (PlayerManager)ToLua.CheckObject(L, 1, typeof(PlayerManager));
			bool allPlayersNickNameVisible = LuaDLL.luaL_checkboolean(L, 2);
			obj.SetAllPlayersNickNameVisible(allPlayersNickNameVisible);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DoDestroy(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((PlayerManager)ToLua.CheckObject(L, 1, typeof(PlayerManager))).DoDestroy();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_LocalPlayer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QuizPlayer localPlayer = ((PlayerManager)obj).LocalPlayer;
			ToLua.PushSealed(L, localPlayer);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index LocalPlayer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_PlayerList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<QuizPlayer> playerList = ((PlayerManager)obj).PlayerList;
			ToLua.PushSealed(L, playerList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index PlayerList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_LocalPlayer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PlayerManager obj2 = (PlayerManager)obj;
			QuizPlayer localPlayer = (QuizPlayer)ToLua.CheckObject(L, 2, typeof(QuizPlayer));
			obj2.LocalPlayer = localPlayer;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index LocalPlayer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_PlayerList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PlayerManager obj2 = (PlayerManager)obj;
			List<QuizPlayer> playerList = (List<QuizPlayer>)ToLua.CheckObject(L, 2, typeof(List<QuizPlayer>));
			obj2.PlayerList = playerList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index PlayerList on a nil value");
		}
	}
}
