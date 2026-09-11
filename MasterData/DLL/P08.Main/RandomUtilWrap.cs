using System;
using LuaInterface;

public class RandomUtilWrap
{
	public static void Register(LuaState L)
	{
		L.BeginStaticLibs("RandomUtil");
		L.RegFunction("GenRandom", GenRandom);
		L.EndStaticLibs();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GenRandom(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			RandomEx o = RandomUtil.GenRandom((int)LuaDLL.luaL_checknumber(L, 1));
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
