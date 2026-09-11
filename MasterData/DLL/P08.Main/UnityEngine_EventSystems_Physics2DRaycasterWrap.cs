using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;
using UnityEngine.EventSystems;

public class UnityEngine_EventSystems_Physics2DRaycasterWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Physics2DRaycaster), typeof(PhysicsRaycaster));
		L.RegFunction("Raycast", Raycast);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Raycast(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Physics2DRaycaster obj = (Physics2DRaycaster)ToLua.CheckObject<Physics2DRaycaster>(L, 1);
			PointerEventData eventData = (PointerEventData)ToLua.CheckObject<PointerEventData>(L, 2);
			List<RaycastResult> resultAppendList = (List<RaycastResult>)ToLua.CheckObject(L, 3, typeof(List<RaycastResult>));
			obj.Raycast(eventData, resultAppendList);
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
