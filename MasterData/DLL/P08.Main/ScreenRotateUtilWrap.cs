using System;
using LuaInterface;
using UnityEngine;

public class ScreenRotateUtilWrap
{
	public static void Register(LuaState L)
	{
		L.BeginStaticLibs("ScreenRotateUtil");
		L.RegFunction("ChangeScreenOrientation", ChangeScreenOrientation);
		L.EndStaticLibs();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ChangeScreenOrientation(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			ScreenRotateUtil.ChangeScreenOrientation((ScreenOrientation)ToLua.CheckObject(L, 1, typeof(ScreenOrientation)));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
