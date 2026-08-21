using System;
using LuaInterface;
using UnityEngine.Pipelines.SimPipeline;

public class UnityEngine_Pipelines_SimPipeline_DepthOfFieldTypeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginEnum(typeof(DepthOfFieldType));
		L.RegVar("Disabled", get_Disabled, null);
		L.RegVar("BlurByBackground", get_BlurByBackground, null);
		L.RegVar("BlurByGroundDepth", get_BlurByGroundDepth, null);
		L.RegFunction("IntToEnum", IntToEnum);
		L.EndEnum();
		TypeTraits<DepthOfFieldType>.Check = CheckType;
		StackTraits<DepthOfFieldType>.Push = Push;
	}

	private static void Push(IntPtr L, DepthOfFieldType arg)
	{
		ToLua.Push(L, arg);
	}

	private static bool CheckType(IntPtr L, int pos)
	{
		return TypeChecker.CheckEnumType(typeof(DepthOfFieldType), L, pos);
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Disabled(IntPtr L)
	{
		ToLua.Push(L, DepthOfFieldType.Disabled);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_BlurByBackground(IntPtr L)
	{
		ToLua.Push(L, DepthOfFieldType.BlurByBackground);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_BlurByGroundDepth(IntPtr L)
	{
		ToLua.Push(L, DepthOfFieldType.BlurByGroundDepth);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IntToEnum(IntPtr L)
	{
		DepthOfFieldType depthOfFieldType = (DepthOfFieldType)LuaDLL.lua_tonumber(L, 1);
		ToLua.Push(L, depthOfFieldType);
		return 1;
	}
}
