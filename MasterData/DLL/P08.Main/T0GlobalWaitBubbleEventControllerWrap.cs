using System;
using LuaInterface;
using Sirenix.OdinInspector;
using UnityEngine;

public class T0GlobalWaitBubbleEventControllerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(T0GlobalWaitBubbleEventController), typeof(SerializedMonoBehaviour));
		L.RegFunction("TriggerInteract", TriggerInteract);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int TriggerInteract(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				T0GlobalWaitBubbleEventController obj2 = (T0GlobalWaitBubbleEventController)ToLua.CheckObject<T0GlobalWaitBubbleEventController>(L, 1);
				string key2 = ToLua.CheckString(L, 2);
				obj2.TriggerInteract(key2);
				return 0;
			}
			case 3:
			{
				T0GlobalWaitBubbleEventController obj = (T0GlobalWaitBubbleEventController)ToLua.CheckObject<T0GlobalWaitBubbleEventController>(L, 1);
				string key = ToLua.CheckString(L, 2);
				bool check = LuaDLL.luaL_checkboolean(L, 3);
				obj.TriggerInteract(key, check);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: T0GlobalWaitBubbleEventController.TriggerInteract");
			}
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
