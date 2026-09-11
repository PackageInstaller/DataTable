using System;
using LuaInterface;
using P08.Quiz;
using UnityEngine;

public class P08_Quiz_QuizPlayerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(QuizPlayer), typeof(object));
		L.RegFunction("LoadRoot", LoadRoot);
		L.RegFunction("LoadModel", LoadModel);
		L.RegFunction("ScaleModel", ScaleModel);
		L.RegFunction("DestroyPlayerRoot", DestroyPlayerRoot);
		L.RegFunction("SyncRemoteGesture", SyncRemoteGesture);
		L.RegFunction("GetLocalPlayerPos", GetLocalPlayerPos);
		L.RegFunction("PlayLocalGesture", PlayLocalGesture);
		L.RegFunction("CreateNickName", CreateNickName);
		L.RegFunction("SetNickNameVisible", SetNickNameVisible);
		L.RegFunction("SetRemotePos", SetRemotePos);
		L.RegFunction("GetChoose", GetChoose);
		L.RegFunction("GetAttachEmoji", GetAttachEmoji);
		L.RegFunction("SetPlayerPosForce", SetPlayerPosForce);
		L.RegFunction("GetPlayerModelGo", GetPlayerModelGo);
		L.RegFunction("New", _CreateP08_Quiz_QuizPlayer);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("playerUid", get_playerUid, set_playerUid);
		L.RegVar("isLocalPlayer", get_isLocalPlayer, set_isLocalPlayer);
		L.RegVar("nickName", get_nickName, set_nickName);
		L.RegVar("curRoleId", get_curRoleId, set_curRoleId);
		L.RegVar("lastRoleId", get_lastRoleId, set_lastRoleId);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateP08_Quiz_QuizPlayer(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				QuizPlayer o = new QuizPlayer();
				ToLua.PushSealed(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: P08.Quiz.QuizPlayer.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LoadRoot(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((QuizPlayer)ToLua.CheckObject(L, 1, typeof(QuizPlayer))).LoadRoot();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LoadModel(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			QuizPlayer obj = (QuizPlayer)ToLua.CheckObject(L, 1, typeof(QuizPlayer));
			int roleId = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.LoadModel(roleId);
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
			ToLua.CheckArgsCount(L, 2);
			QuizPlayer obj = (QuizPlayer)ToLua.CheckObject(L, 1, typeof(QuizPlayer));
			float scale = (float)LuaDLL.luaL_checknumber(L, 2);
			obj.ScaleModel(scale);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DestroyPlayerRoot(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((QuizPlayer)ToLua.CheckObject(L, 1, typeof(QuizPlayer))).DestroyPlayerRoot();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SyncRemoteGesture(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				QuizPlayer obj2 = (QuizPlayer)ToLua.CheckObject(L, 1, typeof(QuizPlayer));
				int gestureId2 = (int)LuaDLL.luaL_checknumber(L, 2);
				obj2.SyncRemoteGesture(gestureId2);
				return 0;
			}
			case 3:
			{
				QuizPlayer obj = (QuizPlayer)ToLua.CheckObject(L, 1, typeof(QuizPlayer));
				int gestureId = (int)LuaDLL.luaL_checknumber(L, 2);
				float crossFade = (float)LuaDLL.luaL_checknumber(L, 3);
				obj.SyncRemoteGesture(gestureId, crossFade);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: P08.Quiz.QuizPlayer.SyncRemoteGesture");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetLocalPlayerPos(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Vector2 localPlayerPos = ((QuizPlayer)ToLua.CheckObject(L, 1, typeof(QuizPlayer))).GetLocalPlayerPos();
			ToLua.Push(L, localPlayerPos);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlayLocalGesture(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				QuizPlayer obj2 = (QuizPlayer)ToLua.CheckObject(L, 1, typeof(QuizPlayer));
				int gestureId2 = (int)LuaDLL.luaL_checknumber(L, 2);
				obj2.PlayLocalGesture(gestureId2);
				return 0;
			}
			case 3:
			{
				QuizPlayer obj = (QuizPlayer)ToLua.CheckObject(L, 1, typeof(QuizPlayer));
				int gestureId = (int)LuaDLL.luaL_checknumber(L, 2);
				float crossFade = (float)LuaDLL.luaL_checknumber(L, 3);
				obj.PlayLocalGesture(gestureId, crossFade);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: P08.Quiz.QuizPlayer.PlayLocalGesture");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CreateNickName(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			QuizPlayer obj = (QuizPlayer)ToLua.CheckObject(L, 1, typeof(QuizPlayer));
			string uiPath = ToLua.CheckString(L, 2);
			string nickName = ToLua.CheckString(L, 3);
			GameObject o = obj.CreateNickName(uiPath, nickName);
			ToLua.PushSealed(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetNickNameVisible(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			QuizPlayer obj = (QuizPlayer)ToLua.CheckObject(L, 1, typeof(QuizPlayer));
			bool nickNameVisible = LuaDLL.luaL_checkboolean(L, 2);
			obj.SetNickNameVisible(nickNameVisible);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetRemotePos(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			QuizPlayer obj = (QuizPlayer)ToLua.CheckObject(L, 1, typeof(QuizPlayer));
			Vector2 remotePos = ToLua.ToVector2(L, 2);
			obj.SetRemotePos(remotePos);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetChoose(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int choose = ((QuizPlayer)ToLua.CheckObject(L, 1, typeof(QuizPlayer))).GetChoose();
			LuaDLL.lua_pushinteger(L, choose);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetAttachEmoji(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Transform attachEmoji = ((QuizPlayer)ToLua.CheckObject(L, 1, typeof(QuizPlayer))).GetAttachEmoji();
			ToLua.Push(L, attachEmoji);
			return 1;
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
			ToLua.CheckArgsCount(L, 3);
			QuizPlayer obj = (QuizPlayer)ToLua.CheckObject(L, 1, typeof(QuizPlayer));
			Vector2 position = ToLua.ToVector2(L, 2);
			Quaternion rotation = ToLua.ToQuaternion(L, 3);
			obj.SetPlayerPosForce(position, rotation);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetPlayerModelGo(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			GameObject playerModelGo = ((QuizPlayer)ToLua.CheckObject(L, 1, typeof(QuizPlayer))).GetPlayerModelGo();
			ToLua.PushSealed(L, playerModelGo);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_playerUid(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			long playerUid = ((QuizPlayer)obj).playerUid;
			LuaDLL.tolua_pushint64(L, playerUid);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index playerUid on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isLocalPlayer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isLocalPlayer = ((QuizPlayer)obj).isLocalPlayer;
			LuaDLL.lua_pushboolean(L, isLocalPlayer);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isLocalPlayer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_nickName(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string nickName = ((QuizPlayer)obj).nickName;
			LuaDLL.lua_pushstring(L, nickName);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index nickName on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_curRoleId(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int curRoleId = ((QuizPlayer)obj).curRoleId;
			LuaDLL.lua_pushinteger(L, curRoleId);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index curRoleId on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_lastRoleId(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int lastRoleId = ((QuizPlayer)obj).lastRoleId;
			LuaDLL.lua_pushinteger(L, lastRoleId);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lastRoleId on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_playerUid(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QuizPlayer obj2 = (QuizPlayer)obj;
			long playerUid = LuaDLL.tolua_checkint64(L, 2);
			obj2.playerUid = playerUid;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index playerUid on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isLocalPlayer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QuizPlayer obj2 = (QuizPlayer)obj;
			bool isLocalPlayer = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isLocalPlayer = isLocalPlayer;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isLocalPlayer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_nickName(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QuizPlayer obj2 = (QuizPlayer)obj;
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
	private static int set_curRoleId(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QuizPlayer obj2 = (QuizPlayer)obj;
			int curRoleId = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.curRoleId = curRoleId;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index curRoleId on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_lastRoleId(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QuizPlayer obj2 = (QuizPlayer)obj;
			int lastRoleId = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.lastRoleId = lastRoleId;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lastRoleId on a nil value");
		}
	}
}
