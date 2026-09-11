using System;
using Dorm;
using LuaInterface;

public class Dorm_SubtitleWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Subtitle), null);
		L.RegFunction("New", _CreateDorm_Subtitle);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("time", get_time, set_time);
		L.RegVar("subtitleID", get_subtitleID, set_subtitleID);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateDorm_Subtitle(IntPtr L)
	{
		ToLua.PushValue(L, default(Subtitle));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_time(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float time = ((Subtitle)obj).time;
			LuaDLL.lua_pushnumber(L, time);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index time on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_subtitleID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int subtitleID = ((Subtitle)obj).subtitleID;
			LuaDLL.lua_pushinteger(L, subtitleID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index subtitleID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_time(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Subtitle subtitle = (Subtitle)obj;
			float time = (float)LuaDLL.luaL_checknumber(L, 2);
			subtitle.time = time;
			ToLua.SetBack(L, 1, subtitle);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index time on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_subtitleID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Subtitle subtitle = (Subtitle)obj;
			int subtitleID = (int)LuaDLL.luaL_checknumber(L, 2);
			subtitle.subtitleID = subtitleID;
			ToLua.SetBack(L, 1, subtitle);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index subtitleID on a nil value");
		}
	}
}
