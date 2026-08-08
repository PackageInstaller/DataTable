using System;
using LuaInterface;
using P08.Quiz;

public class P08_Quiz_QuizDataForExchangeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(QuizDataForExchange), typeof(object));
		L.RegFunction("New", _CreateP08_Quiz_QuizDataForExchange);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("sceneName", get_sceneName, set_sceneName);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateP08_Quiz_QuizDataForExchange(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				QuizDataForExchange o = new QuizDataForExchange();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: P08.Quiz.QuizDataForExchange.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_sceneName(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string sceneName = ((QuizDataForExchange)obj).sceneName;
			LuaDLL.lua_pushstring(L, sceneName);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sceneName on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_sceneName(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QuizDataForExchange obj2 = (QuizDataForExchange)obj;
			string sceneName = ToLua.CheckString(L, 2);
			obj2.sceneName = sceneName;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sceneName on a nil value");
		}
	}
}
