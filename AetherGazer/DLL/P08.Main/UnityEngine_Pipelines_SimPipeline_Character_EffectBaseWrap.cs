using System;
using LuaInterface;
using UnityEngine.Pipelines.SimPipeline.Character;

public class UnityEngine_Pipelines_SimPipeline_Character_EffectBaseWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(EffectBase), typeof(object));
		L.RegFunction("SetDirty", SetDirty);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetDirty(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((EffectBase)ToLua.CheckObject<EffectBase>(L, 1)).SetDirty();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
