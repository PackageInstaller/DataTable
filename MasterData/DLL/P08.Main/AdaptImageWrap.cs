using System;
using LuaInterface;
using UnityEngine;

public class AdaptImageWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(AdaptImage), typeof(MonoBehaviour));
		L.RegFunction("AdaptImg", AdaptImg);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AdaptImg(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((AdaptImage)ToLua.CheckObject<AdaptImage>(L, 1)).AdaptImg();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int op_Equality(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UnityEngine.Object obj = (UnityEngine.Object)ToLua.ToObject(L, 1);
			UnityEngine.Object obj2 = (UnityEngine.Object)ToLua.ToObject(L, 2);
			bool value = obj == obj2;
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
