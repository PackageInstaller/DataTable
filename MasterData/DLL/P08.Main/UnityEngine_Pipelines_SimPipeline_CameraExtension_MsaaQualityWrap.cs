using System;
using LuaInterface;
using UnityEngine.Pipelines.SimPipeline;

public class UnityEngine_Pipelines_SimPipeline_CameraExtension_MsaaQualityWrap
{
	public static void Register(LuaState L)
	{
		L.BeginEnum(typeof(CameraExtension.MsaaQuality));
		L.RegVar("Disabled", get_Disabled, null);
		L.RegVar("MSAA2x", get_MSAA2x, null);
		L.RegVar("MSAA4x", get_MSAA4x, null);
		L.RegFunction("IntToEnum", IntToEnum);
		L.EndEnum();
		TypeTraits<CameraExtension.MsaaQuality>.Check = CheckType;
		StackTraits<CameraExtension.MsaaQuality>.Push = Push;
	}

	private static void Push(IntPtr L, CameraExtension.MsaaQuality arg)
	{
		ToLua.Push(L, arg);
	}

	private static bool CheckType(IntPtr L, int pos)
	{
		return TypeChecker.CheckEnumType(typeof(CameraExtension.MsaaQuality), L, pos);
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Disabled(IntPtr L)
	{
		ToLua.Push(L, CameraExtension.MsaaQuality.Disabled);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_MSAA2x(IntPtr L)
	{
		ToLua.Push(L, CameraExtension.MsaaQuality.MSAA2x);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_MSAA4x(IntPtr L)
	{
		ToLua.Push(L, CameraExtension.MsaaQuality.MSAA4x);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IntToEnum(IntPtr L)
	{
		CameraExtension.MsaaQuality msaaQuality = (CameraExtension.MsaaQuality)LuaDLL.lua_tonumber(L, 1);
		ToLua.Push(L, msaaQuality);
		return 1;
	}
}
