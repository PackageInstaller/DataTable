using System;
using LuaInterface;
using P08.Quiz;

public class P08_Quiz_QuizPlayerInfoWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(QuizPlayerInfo), typeof(object));
		L.RegFunction("New", _CreateP08_Quiz_QuizPlayerInfo);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("playerUid", get_playerUid, set_playerUid);
		L.RegVar("roleId", get_roleId, set_roleId);
		L.RegVar("nickName", get_nickName, set_nickName);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateP08_Quiz_QuizPlayerInfo(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				QuizPlayerInfo o = new QuizPlayerInfo();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: P08.Quiz.QuizPlayerInfo.New");
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
			long playerUid = ((QuizPlayerInfo)obj).playerUid;
			LuaDLL.tolua_pushint64(L, playerUid);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index playerUid on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_roleId(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int roleId = ((QuizPlayerInfo)obj).roleId;
			LuaDLL.lua_pushinteger(L, roleId);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index roleId on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_nickName(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string nickName = ((QuizPlayerInfo)obj).nickName;
			LuaDLL.lua_pushstring(L, nickName);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index nickName on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_playerUid(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QuizPlayerInfo obj2 = (QuizPlayerInfo)obj;
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
	private static int set_roleId(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QuizPlayerInfo obj2 = (QuizPlayerInfo)obj;
			int roleId = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.roleId = roleId;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index roleId on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_nickName(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QuizPlayerInfo obj2 = (QuizPlayerInfo)obj;
			string nickName = ToLua.CheckString(L, 2);
			obj2.nickName = nickName;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index nickName on a nil value");
		}
	}
}
