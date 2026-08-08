using System;
using LuaInterface;
using P08.Quiz;

public class P08_Quiz_Singleton_P08_Quiz_PlayerManagerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Singleton<PlayerManager>), typeof(object), "Singleton_P08_Quiz_PlayerManager");
		L.RegFunction("New", _CreateP08_Quiz_Singleton_P08_Quiz_PlayerManager);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("Instance", get_Instance, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateP08_Quiz_Singleton_P08_Quiz_PlayerManager(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				Singleton<PlayerManager> o = new Singleton<PlayerManager>();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: P08.Quiz.Singleton<P08.Quiz.PlayerManager>.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Instance(IntPtr L)
	{
		try
		{
			ToLua.PushSealed(L, Singleton<PlayerManager>.Instance);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
