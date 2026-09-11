using System;
using LuaInterface;

public class SailGameDataForExchangeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(SailGameDataForExchange), typeof(object));
		L.RegFunction("New", _CreateSailGameDataForExchange);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("curStageIndex", get_curStageIndex, set_curStageIndex);
		L.RegVar("startTime", get_startTime, set_startTime);
		L.RegVar("maxTime", get_maxTime, set_maxTime);
		L.RegVar("eventTimeList", get_eventTimeList, set_eventTimeList);
		L.RegVar("tipsTimeList", get_tipsTimeList, set_tipsTimeList);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateSailGameDataForExchange(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				SailGameDataForExchange o = new SailGameDataForExchange();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: SailGameDataForExchange.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_curStageIndex(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int curStageIndex = ((SailGameDataForExchange)obj).curStageIndex;
			LuaDLL.lua_pushinteger(L, curStageIndex);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index curStageIndex on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_startTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float startTime = ((SailGameDataForExchange)obj).startTime;
			LuaDLL.lua_pushnumber(L, startTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maxTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int maxTime = ((SailGameDataForExchange)obj).maxTime;
			LuaDLL.lua_pushinteger(L, maxTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maxTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_eventTimeList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int[] eventTimeList = ((SailGameDataForExchange)obj).eventTimeList;
			ToLua.Push(L, eventTimeList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index eventTimeList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_tipsTimeList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int[] tipsTimeList = ((SailGameDataForExchange)obj).tipsTimeList;
			ToLua.Push(L, tipsTimeList);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index tipsTimeList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_curStageIndex(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SailGameDataForExchange obj2 = (SailGameDataForExchange)obj;
			int curStageIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.curStageIndex = curStageIndex;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index curStageIndex on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_startTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SailGameDataForExchange obj2 = (SailGameDataForExchange)obj;
			float startTime = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.startTime = startTime;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_maxTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SailGameDataForExchange obj2 = (SailGameDataForExchange)obj;
			int maxTime = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.maxTime = maxTime;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maxTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_eventTimeList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SailGameDataForExchange obj2 = (SailGameDataForExchange)obj;
			int[] eventTimeList = ToLua.CheckNumberArray<int>(L, 2);
			obj2.eventTimeList = eventTimeList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index eventTimeList on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_tipsTimeList(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SailGameDataForExchange obj2 = (SailGameDataForExchange)obj;
			int[] tipsTimeList = ToLua.CheckNumberArray<int>(L, 2);
			obj2.tipsTimeList = tipsTimeList;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index tipsTimeList on a nil value");
		}
	}
}
