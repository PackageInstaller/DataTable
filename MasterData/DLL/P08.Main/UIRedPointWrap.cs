using System;
using LuaInterface;
using UnityEngine;

public class UIRedPointWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(UIRedPoint), typeof(MonoBehaviour));
		L.RegFunction("Awake", Awake);
		L.RegFunction("ShowRed", ShowRed);
		L.RegFunction("SetPosition", SetPosition);
		L.RegFunction("SetScale", SetScale);
		L.RegFunction("SetPositionAxis", SetPositionAxis);
		L.RegFunction("SetScaleAxis", SetScaleAxis);
		L.RegFunction("SetDebugName", SetDebugName);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("Anim", get_Anim, null);
		L.RegVar("DebugName", get_DebugName, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Awake(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((UIRedPoint)ToLua.CheckObject<UIRedPoint>(L, 1)).Awake();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ShowRed(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UIRedPoint obj = (UIRedPoint)ToLua.CheckObject<UIRedPoint>(L, 1);
			UIRedPointStyle redPointStyle = (UIRedPointStyle)ToLua.CheckObject(L, 2, typeof(UIRedPointStyle));
			obj.ShowRed(redPointStyle);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetPosition(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			UIRedPoint obj = (UIRedPoint)ToLua.CheckObject<UIRedPoint>(L, 1);
			float x = (float)LuaDLL.luaL_checknumber(L, 2);
			float y = (float)LuaDLL.luaL_checknumber(L, 3);
			obj.SetPosition(x, y);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetScale(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			UIRedPoint obj = (UIRedPoint)ToLua.CheckObject<UIRedPoint>(L, 1);
			float x = (float)LuaDLL.luaL_checknumber(L, 2);
			float y = (float)LuaDLL.luaL_checknumber(L, 3);
			obj.SetScale(x, y);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetPositionAxis(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			UIRedPoint obj = (UIRedPoint)ToLua.CheckObject<UIRedPoint>(L, 1);
			float value = (float)LuaDLL.luaL_checknumber(L, 2);
			int axis = (int)LuaDLL.luaL_checknumber(L, 3);
			obj.SetPositionAxis(value, axis);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetScaleAxis(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			UIRedPoint obj = (UIRedPoint)ToLua.CheckObject<UIRedPoint>(L, 1);
			float value = (float)LuaDLL.luaL_checknumber(L, 2);
			int axis = (int)LuaDLL.luaL_checknumber(L, 3);
			obj.SetScaleAxis(value, axis);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetDebugName(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UIRedPoint obj = (UIRedPoint)ToLua.CheckObject<UIRedPoint>(L, 1);
			string debugName = ToLua.CheckString(L, 2);
			obj.SetDebugName(debugName);
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

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Anim(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Animator anim = ((UIRedPoint)obj).Anim;
			ToLua.Push(L, anim);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Anim on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_DebugName(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string debugName = ((UIRedPoint)obj).DebugName;
			LuaDLL.lua_pushstring(L, debugName);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index DebugName on a nil value");
		}
	}
}
