using System;
using LuaInterface;
using UnityEngine.Pipelines.SimPipeline;

public class UnityEngine_Pipelines_SimPipeline_SimPipelineSettingsWrap
{
	public static void Register(LuaState L)
	{
		L.BeginStaticLibs("SimPipelineSettings");
		L.RegVar("AliasingEnable", get_AliasingEnable, set_AliasingEnable);
		L.EndStaticLibs();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_AliasingEnable(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, SimPipelineSettings.AliasingEnable);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_AliasingEnable(IntPtr L)
	{
		try
		{
			SimPipelineSettings.AliasingEnable = LuaDLL.luaL_checkboolean(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
