using System;
using LuaInterface;

public class StatUtilWrap
{
	public static void Register(LuaState L)
	{
		L.BeginStaticLibs("StatUtil");
		L.RegFunction("GetAndClearCombatOperations", GetAndClearCombatOperations);
		L.EndStaticLibs();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetAndClearCombatOperations(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			int[] andClearCombatOperations = StatUtil.GetAndClearCombatOperations();
			ToLua.Push(L, andClearCombatOperations);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
