using System;
using LuaInterface;
using UnityEngine;

public class U3DHudWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(U3DHud), typeof(MonoBehaviour));
		L.RegFunction("ConverHUDWorld", ConverHUDWorld);
		L.RegFunction("SetHUDPosition", SetHUDPosition);
		L.RegFunction("AddChild", AddChild);
		L.RegFunction("RomoveChild", RomoveChild);
		L.RegFunction("SetWidthAndHeight", SetWidthAndHeight);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("mOffset", get_mOffset, set_mOffset);
		L.RegVar("mWidth", get_mWidth, set_mWidth);
		L.RegVar("mHeight", get_mHeight, set_mHeight);
		L.RegVar("mTest", get_mTest, set_mTest);
		L.RegVar("mIndicator", get_mIndicator, set_mIndicator);
		L.RegVar("mInstance", get_mInstance, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ConverHUDWorld(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			U3DHud obj = (U3DHud)ToLua.CheckObject<U3DHud>(L, 1);
			Vector3 position = ToLua.ToVector3(L, 2);
			Vector3 v = obj.ConverHUDWorld(position);
			ToLua.Push(L, v);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetHUDPosition(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			U3DHud obj = (U3DHud)ToLua.CheckObject<U3DHud>(L, 1);
			Transform target = (Transform)ToLua.CheckObject<Transform>(L, 2);
			Vector3 position = ToLua.ToVector3(L, 3);
			obj.SetHUDPosition(target, position);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddChild(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				U3DHud obj2 = (U3DHud)ToLua.CheckObject<U3DHud>(L, 1);
				Transform child2 = (Transform)ToLua.CheckObject<Transform>(L, 2);
				obj2.AddChild(child2);
				return 0;
			}
			case 3:
			{
				U3DHud obj = (U3DHud)ToLua.CheckObject<U3DHud>(L, 1);
				Transform child = (Transform)ToLua.CheckObject<Transform>(L, 2);
				Vector3 position = ToLua.ToVector3(L, 3);
				obj.AddChild(child, position);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: U3DHud.AddChild");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RomoveChild(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			U3DHud obj = (U3DHud)ToLua.CheckObject<U3DHud>(L, 1);
			Transform child = (Transform)ToLua.CheckObject<Transform>(L, 2);
			obj.RomoveChild(child);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetWidthAndHeight(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			U3DHud obj = (U3DHud)ToLua.CheckObject<U3DHud>(L, 1);
			int width = (int)LuaDLL.luaL_checknumber(L, 2);
			int height = (int)LuaDLL.luaL_checknumber(L, 3);
			obj.SetWidthAndHeight(width, height);
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
	private static int get_mOffset(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float mOffset = ((U3DHud)obj).mOffset;
			LuaDLL.lua_pushnumber(L, mOffset);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mOffset on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mWidth(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int mWidth = ((U3DHud)obj).mWidth;
			LuaDLL.lua_pushinteger(L, mWidth);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mWidth on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mHeight(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int mHeight = ((U3DHud)obj).mHeight;
			LuaDLL.lua_pushinteger(L, mHeight);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mHeight on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mTest(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform mTest = ((U3DHud)obj).mTest;
			ToLua.Push(L, mTest);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mTest on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mIndicator(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform mIndicator = ((U3DHud)obj).mIndicator;
			ToLua.Push(L, mIndicator);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mIndicator on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mInstance(IntPtr L)
	{
		try
		{
			ToLua.Push(L, U3DHud.mInstance);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mOffset(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			U3DHud obj2 = (U3DHud)obj;
			float mOffset = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.mOffset = mOffset;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mOffset on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mWidth(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			U3DHud obj2 = (U3DHud)obj;
			int mWidth = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.mWidth = mWidth;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mWidth on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mHeight(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			U3DHud obj2 = (U3DHud)obj;
			int mHeight = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.mHeight = mHeight;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mHeight on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mTest(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			U3DHud obj2 = (U3DHud)obj;
			Transform mTest = (Transform)ToLua.CheckObject<Transform>(L, 2);
			obj2.mTest = mTest;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mTest on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mIndicator(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			U3DHud obj2 = (U3DHud)obj;
			Transform mIndicator = (Transform)ToLua.CheckObject<Transform>(L, 2);
			obj2.mIndicator = mIndicator;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mIndicator on a nil value");
		}
	}
}
