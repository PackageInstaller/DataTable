using System;
using LuaInterface;
using UnityEngine;

public class UIParabolaMotionWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(UIParabolaMotion), typeof(MonoBehaviour));
		L.RegFunction("StartMotion", StartMotion);
		L.RegFunction("SetSpeedMultiplier", SetSpeedMultiplier);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("parabolaHeight", get_parabolaHeight, set_parabolaHeight);
		L.RegVar("duration", get_duration, set_duration);
		L.RegVar("enableRotation", get_enableRotation, set_enableRotation);
		L.RegVar("rotationOffset", get_rotationOffset, set_rotationOffset);
		L.RegVar("movingObject", get_movingObject, set_movingObject);
		L.RegVar("ratateProp", get_ratateProp, set_ratateProp);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StartMotion(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 5:
			{
				UIParabolaMotion obj3 = (UIParabolaMotion)ToLua.CheckObject<UIParabolaMotion>(L, 1);
				GameObject startPoint3 = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
				GameObject endPoint3 = (GameObject)ToLua.CheckObject(L, 3, typeof(GameObject));
				float speed3 = (float)LuaDLL.luaL_checknumber(L, 4);
				float prop3 = (float)LuaDLL.luaL_checknumber(L, 5);
				obj3.StartMotion(startPoint3, endPoint3, speed3, prop3);
				return 0;
			}
			case 6:
			{
				UIParabolaMotion obj2 = (UIParabolaMotion)ToLua.CheckObject<UIParabolaMotion>(L, 1);
				GameObject startPoint2 = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
				GameObject endPoint2 = (GameObject)ToLua.CheckObject(L, 3, typeof(GameObject));
				float speed2 = (float)LuaDLL.luaL_checknumber(L, 4);
				float prop2 = (float)LuaDLL.luaL_checknumber(L, 5);
				Action nextCallback2 = (Action)ToLua.CheckDelegate<Action>(L, 6);
				obj2.StartMotion(startPoint2, endPoint2, speed2, prop2, nextCallback2);
				return 0;
			}
			case 7:
			{
				UIParabolaMotion obj = (UIParabolaMotion)ToLua.CheckObject<UIParabolaMotion>(L, 1);
				GameObject startPoint = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
				GameObject endPoint = (GameObject)ToLua.CheckObject(L, 3, typeof(GameObject));
				float speed = (float)LuaDLL.luaL_checknumber(L, 4);
				float prop = (float)LuaDLL.luaL_checknumber(L, 5);
				Action nextCallback = (Action)ToLua.CheckDelegate<Action>(L, 6);
				Action endCallback = (Action)ToLua.CheckDelegate<Action>(L, 7);
				obj.StartMotion(startPoint, endPoint, speed, prop, nextCallback, endCallback);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UIParabolaMotion.StartMotion");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetSpeedMultiplier(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UIParabolaMotion obj = (UIParabolaMotion)ToLua.CheckObject<UIParabolaMotion>(L, 1);
			float speedMultiplier = (float)LuaDLL.luaL_checknumber(L, 2);
			obj.SetSpeedMultiplier(speedMultiplier);
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
	private static int get_parabolaHeight(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float parabolaHeight = ((UIParabolaMotion)obj).parabolaHeight;
			LuaDLL.lua_pushnumber(L, parabolaHeight);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index parabolaHeight on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_duration(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float duration = ((UIParabolaMotion)obj).duration;
			LuaDLL.lua_pushnumber(L, duration);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index duration on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_enableRotation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool enableRotation = ((UIParabolaMotion)obj).enableRotation;
			LuaDLL.lua_pushboolean(L, enableRotation);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enableRotation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_rotationOffset(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float rotationOffset = ((UIParabolaMotion)obj).rotationOffset;
			LuaDLL.lua_pushnumber(L, rotationOffset);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rotationOffset on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_movingObject(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectTransform movingObject = ((UIParabolaMotion)obj).movingObject;
			ToLua.PushSealed(L, movingObject);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index movingObject on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ratateProp(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float ratateProp = ((UIParabolaMotion)obj).ratateProp;
			LuaDLL.lua_pushnumber(L, ratateProp);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ratateProp on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_parabolaHeight(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIParabolaMotion obj2 = (UIParabolaMotion)obj;
			float parabolaHeight = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.parabolaHeight = parabolaHeight;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index parabolaHeight on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_duration(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIParabolaMotion obj2 = (UIParabolaMotion)obj;
			float duration = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.duration = duration;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index duration on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_enableRotation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIParabolaMotion obj2 = (UIParabolaMotion)obj;
			bool enableRotation = LuaDLL.luaL_checkboolean(L, 2);
			obj2.enableRotation = enableRotation;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enableRotation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_rotationOffset(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIParabolaMotion obj2 = (UIParabolaMotion)obj;
			float rotationOffset = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.rotationOffset = rotationOffset;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rotationOffset on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_movingObject(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIParabolaMotion obj2 = (UIParabolaMotion)obj;
			RectTransform movingObject = (RectTransform)ToLua.CheckObject(L, 2, typeof(RectTransform));
			obj2.movingObject = movingObject;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index movingObject on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_ratateProp(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			UIParabolaMotion obj2 = (UIParabolaMotion)obj;
			float ratateProp = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.ratateProp = ratateProp;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ratateProp on a nil value");
		}
	}
}
