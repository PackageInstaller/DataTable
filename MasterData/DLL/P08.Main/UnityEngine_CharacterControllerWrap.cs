using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_CharacterControllerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(CharacterController), typeof(Collider));
		L.RegFunction("SimpleMove", SimpleMove);
		L.RegFunction("Move", Move);
		L.RegFunction("New", _CreateUnityEngine_CharacterController);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("velocity", get_velocity, null);
		L.RegVar("isGrounded", get_isGrounded, null);
		L.RegVar("collisionFlags", get_collisionFlags, null);
		L.RegVar("radius", get_radius, set_radius);
		L.RegVar("height", get_height, set_height);
		L.RegVar("center", get_center, set_center);
		L.RegVar("slopeLimit", get_slopeLimit, set_slopeLimit);
		L.RegVar("stepOffset", get_stepOffset, set_stepOffset);
		L.RegVar("skinWidth", get_skinWidth, set_skinWidth);
		L.RegVar("minMoveDistance", get_minMoveDistance, set_minMoveDistance);
		L.RegVar("detectCollisions", get_detectCollisions, set_detectCollisions);
		L.RegVar("enableOverlapRecovery", get_enableOverlapRecovery, set_enableOverlapRecovery);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_CharacterController(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				CharacterController obj = new CharacterController();
				ToLua.Push(L, obj);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.CharacterController.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SimpleMove(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			CharacterController obj = (CharacterController)ToLua.CheckObject<CharacterController>(L, 1);
			Vector3 speed = ToLua.ToVector3(L, 2);
			bool value = obj.SimpleMove(speed);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Move(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			CharacterController obj = (CharacterController)ToLua.CheckObject<CharacterController>(L, 1);
			Vector3 motion = ToLua.ToVector3(L, 2);
			CollisionFlags collisionFlags = obj.Move(motion);
			ToLua.Push(L, collisionFlags);
			return 1;
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
	private static int get_velocity(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3 velocity = ((CharacterController)obj).velocity;
			ToLua.Push(L, velocity);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index velocity on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isGrounded(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isGrounded = ((CharacterController)obj).isGrounded;
			LuaDLL.lua_pushboolean(L, isGrounded);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isGrounded on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_collisionFlags(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CollisionFlags collisionFlags = ((CharacterController)obj).collisionFlags;
			ToLua.Push(L, collisionFlags);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index collisionFlags on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_radius(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float radius = ((CharacterController)obj).radius;
			LuaDLL.lua_pushnumber(L, radius);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index radius on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_height(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float height = ((CharacterController)obj).height;
			LuaDLL.lua_pushnumber(L, height);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index height on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_center(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3 center = ((CharacterController)obj).center;
			ToLua.Push(L, center);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index center on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_slopeLimit(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float slopeLimit = ((CharacterController)obj).slopeLimit;
			LuaDLL.lua_pushnumber(L, slopeLimit);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index slopeLimit on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_stepOffset(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float stepOffset = ((CharacterController)obj).stepOffset;
			LuaDLL.lua_pushnumber(L, stepOffset);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stepOffset on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_skinWidth(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float skinWidth = ((CharacterController)obj).skinWidth;
			LuaDLL.lua_pushnumber(L, skinWidth);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index skinWidth on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_minMoveDistance(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float minMoveDistance = ((CharacterController)obj).minMoveDistance;
			LuaDLL.lua_pushnumber(L, minMoveDistance);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index minMoveDistance on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_detectCollisions(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool detectCollisions = ((CharacterController)obj).detectCollisions;
			LuaDLL.lua_pushboolean(L, detectCollisions);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index detectCollisions on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_enableOverlapRecovery(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool enableOverlapRecovery = ((CharacterController)obj).enableOverlapRecovery;
			LuaDLL.lua_pushboolean(L, enableOverlapRecovery);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enableOverlapRecovery on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_radius(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CharacterController obj2 = (CharacterController)obj;
			float radius = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.radius = radius;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index radius on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_height(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CharacterController obj2 = (CharacterController)obj;
			float height = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.height = height;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index height on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_center(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CharacterController obj2 = (CharacterController)obj;
			Vector3 center = ToLua.ToVector3(L, 2);
			obj2.center = center;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index center on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_slopeLimit(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CharacterController obj2 = (CharacterController)obj;
			float slopeLimit = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.slopeLimit = slopeLimit;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index slopeLimit on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_stepOffset(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CharacterController obj2 = (CharacterController)obj;
			float stepOffset = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.stepOffset = stepOffset;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stepOffset on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_skinWidth(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CharacterController obj2 = (CharacterController)obj;
			float skinWidth = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.skinWidth = skinWidth;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index skinWidth on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_minMoveDistance(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CharacterController obj2 = (CharacterController)obj;
			float minMoveDistance = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.minMoveDistance = minMoveDistance;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index minMoveDistance on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_detectCollisions(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CharacterController obj2 = (CharacterController)obj;
			bool detectCollisions = LuaDLL.luaL_checkboolean(L, 2);
			obj2.detectCollisions = detectCollisions;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index detectCollisions on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_enableOverlapRecovery(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CharacterController obj2 = (CharacterController)obj;
			bool enableOverlapRecovery = LuaDLL.luaL_checkboolean(L, 2);
			obj2.enableOverlapRecovery = enableOverlapRecovery;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enableOverlapRecovery on a nil value");
		}
	}
}
