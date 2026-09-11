using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_Physics2DWrap
{
	public static void Register(LuaState L)
	{
		L.BeginStaticLibs("Physics2D");
		L.RegFunction("Simulate", Simulate);
		L.RegFunction("SyncTransforms", SyncTransforms);
		L.RegFunction("IgnoreCollision", IgnoreCollision);
		L.RegFunction("GetIgnoreCollision", GetIgnoreCollision);
		L.RegFunction("IgnoreLayerCollision", IgnoreLayerCollision);
		L.RegFunction("GetIgnoreLayerCollision", GetIgnoreLayerCollision);
		L.RegFunction("SetLayerCollisionMask", SetLayerCollisionMask);
		L.RegFunction("GetLayerCollisionMask", GetLayerCollisionMask);
		L.RegFunction("IsTouching", IsTouching);
		L.RegFunction("IsTouchingLayers", IsTouchingLayers);
		L.RegFunction("Distance", Distance);
		L.RegFunction("Linecast", Linecast);
		L.RegFunction("LinecastAll", LinecastAll);
		L.RegFunction("LinecastNonAlloc", LinecastNonAlloc);
		L.RegFunction("Raycast", Raycast);
		L.RegFunction("RaycastNonAlloc", RaycastNonAlloc);
		L.RegFunction("RaycastAll", RaycastAll);
		L.RegFunction("CircleCast", CircleCast);
		L.RegFunction("CircleCastAll", CircleCastAll);
		L.RegFunction("CircleCastNonAlloc", CircleCastNonAlloc);
		L.RegFunction("BoxCast", BoxCast);
		L.RegFunction("BoxCastAll", BoxCastAll);
		L.RegFunction("BoxCastNonAlloc", BoxCastNonAlloc);
		L.RegFunction("CapsuleCast", CapsuleCast);
		L.RegFunction("CapsuleCastAll", CapsuleCastAll);
		L.RegFunction("CapsuleCastNonAlloc", CapsuleCastNonAlloc);
		L.RegFunction("GetRayIntersection", GetRayIntersection);
		L.RegFunction("GetRayIntersectionAll", GetRayIntersectionAll);
		L.RegFunction("GetRayIntersectionNonAlloc", GetRayIntersectionNonAlloc);
		L.RegFunction("OverlapPoint", OverlapPoint);
		L.RegFunction("OverlapPointAll", OverlapPointAll);
		L.RegFunction("OverlapPointNonAlloc", OverlapPointNonAlloc);
		L.RegFunction("OverlapCircle", OverlapCircle);
		L.RegFunction("OverlapCircleAll", OverlapCircleAll);
		L.RegFunction("OverlapCircleNonAlloc", OverlapCircleNonAlloc);
		L.RegFunction("OverlapBox", OverlapBox);
		L.RegFunction("OverlapBoxAll", OverlapBoxAll);
		L.RegFunction("OverlapBoxNonAlloc", OverlapBoxNonAlloc);
		L.RegFunction("OverlapArea", OverlapArea);
		L.RegFunction("OverlapAreaAll", OverlapAreaAll);
		L.RegFunction("OverlapAreaNonAlloc", OverlapAreaNonAlloc);
		L.RegFunction("OverlapCapsule", OverlapCapsule);
		L.RegFunction("OverlapCapsuleAll", OverlapCapsuleAll);
		L.RegFunction("OverlapCapsuleNonAlloc", OverlapCapsuleNonAlloc);
		L.RegFunction("OverlapCollider", OverlapCollider);
		L.RegFunction("GetContacts", GetContacts);
		L.RegConstant("IgnoreRaycastLayer", 4.0);
		L.RegConstant("DefaultRaycastLayers", -5.0);
		L.RegConstant("AllLayers", -1.0);
		L.RegVar("defaultPhysicsScene", get_defaultPhysicsScene, null);
		L.RegVar("velocityIterations", get_velocityIterations, set_velocityIterations);
		L.RegVar("positionIterations", get_positionIterations, set_positionIterations);
		L.RegVar("gravity", get_gravity, set_gravity);
		L.RegVar("queriesHitTriggers", get_queriesHitTriggers, set_queriesHitTriggers);
		L.RegVar("queriesStartInColliders", get_queriesStartInColliders, set_queriesStartInColliders);
		L.RegVar("callbacksOnDisable", get_callbacksOnDisable, set_callbacksOnDisable);
		L.RegVar("reuseCollisionCallbacks", get_reuseCollisionCallbacks, set_reuseCollisionCallbacks);
		L.RegVar("autoSyncTransforms", get_autoSyncTransforms, set_autoSyncTransforms);
		L.RegVar("autoSimulation", get_autoSimulation, set_autoSimulation);
		L.RegVar("jobOptions", get_jobOptions, set_jobOptions);
		L.RegVar("velocityThreshold", get_velocityThreshold, set_velocityThreshold);
		L.RegVar("maxLinearCorrection", get_maxLinearCorrection, set_maxLinearCorrection);
		L.RegVar("maxAngularCorrection", get_maxAngularCorrection, set_maxAngularCorrection);
		L.RegVar("maxTranslationSpeed", get_maxTranslationSpeed, set_maxTranslationSpeed);
		L.RegVar("maxRotationSpeed", get_maxRotationSpeed, set_maxRotationSpeed);
		L.RegVar("defaultContactOffset", get_defaultContactOffset, set_defaultContactOffset);
		L.RegVar("baumgarteScale", get_baumgarteScale, set_baumgarteScale);
		L.RegVar("baumgarteTOIScale", get_baumgarteTOIScale, set_baumgarteTOIScale);
		L.RegVar("timeToSleep", get_timeToSleep, set_timeToSleep);
		L.RegVar("linearSleepTolerance", get_linearSleepTolerance, set_linearSleepTolerance);
		L.RegVar("angularSleepTolerance", get_angularSleepTolerance, set_angularSleepTolerance);
		L.EndStaticLibs();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Simulate(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = Physics2D.Simulate((float)LuaDLL.luaL_checknumber(L, 1));
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SyncTransforms(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			Physics2D.SyncTransforms();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IgnoreCollision(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Collider2D collider3 = (Collider2D)ToLua.CheckObject<Collider2D>(L, 1);
				Collider2D collider4 = (Collider2D)ToLua.CheckObject<Collider2D>(L, 2);
				Physics2D.IgnoreCollision(collider3, collider4);
				return 0;
			}
			case 3:
			{
				Collider2D collider = (Collider2D)ToLua.CheckObject<Collider2D>(L, 1);
				Collider2D collider2 = (Collider2D)ToLua.CheckObject<Collider2D>(L, 2);
				bool ignore = LuaDLL.luaL_checkboolean(L, 3);
				Physics2D.IgnoreCollision(collider, collider2, ignore);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics2D.IgnoreCollision");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetIgnoreCollision(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Collider2D collider = (Collider2D)ToLua.CheckObject<Collider2D>(L, 1);
			Collider2D collider2 = (Collider2D)ToLua.CheckObject<Collider2D>(L, 2);
			bool ignoreCollision = Physics2D.GetIgnoreCollision(collider, collider2);
			LuaDLL.lua_pushboolean(L, ignoreCollision);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IgnoreLayerCollision(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				int layer3 = (int)LuaDLL.luaL_checknumber(L, 1);
				int layer4 = (int)LuaDLL.luaL_checknumber(L, 2);
				Physics2D.IgnoreLayerCollision(layer3, layer4);
				return 0;
			}
			case 3:
			{
				int layer = (int)LuaDLL.luaL_checknumber(L, 1);
				int layer2 = (int)LuaDLL.luaL_checknumber(L, 2);
				bool ignore = LuaDLL.luaL_checkboolean(L, 3);
				Physics2D.IgnoreLayerCollision(layer, layer2, ignore);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics2D.IgnoreLayerCollision");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetIgnoreLayerCollision(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int layer = (int)LuaDLL.luaL_checknumber(L, 1);
			int layer2 = (int)LuaDLL.luaL_checknumber(L, 2);
			bool ignoreLayerCollision = Physics2D.GetIgnoreLayerCollision(layer, layer2);
			LuaDLL.lua_pushboolean(L, ignoreLayerCollision);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLayerCollisionMask(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			int layer = (int)LuaDLL.luaL_checknumber(L, 1);
			int layerMask = (int)LuaDLL.luaL_checknumber(L, 2);
			Physics2D.SetLayerCollisionMask(layer, layerMask);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetLayerCollisionMask(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int layerCollisionMask = Physics2D.GetLayerCollisionMask((int)LuaDLL.luaL_checknumber(L, 1));
			LuaDLL.lua_pushinteger(L, layerCollisionMask);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsTouching(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<Collider2D>(L, 2))
			{
				Collider2D collider = (Collider2D)ToLua.CheckObject<Collider2D>(L, 1);
				Collider2D collider2 = (Collider2D)ToLua.ToObject(L, 2);
				bool value = Physics2D.IsTouching(collider, collider2);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<ContactFilter2D>(L, 2))
			{
				Collider2D collider3 = (Collider2D)ToLua.CheckObject<Collider2D>(L, 1);
				ContactFilter2D contactFilter = StackTraits<ContactFilter2D>.To(L, 2);
				bool value2 = Physics2D.IsTouching(collider3, contactFilter);
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			if (num == 3)
			{
				Collider2D collider4 = (Collider2D)ToLua.CheckObject<Collider2D>(L, 1);
				Collider2D collider5 = (Collider2D)ToLua.CheckObject<Collider2D>(L, 2);
				ContactFilter2D contactFilter2 = StackTraits<ContactFilter2D>.Check(L, 3);
				bool value3 = Physics2D.IsTouching(collider4, collider5, contactFilter2);
				LuaDLL.lua_pushboolean(L, value3);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics2D.IsTouching");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsTouchingLayers(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				bool value2 = Physics2D.IsTouchingLayers((Collider2D)ToLua.CheckObject<Collider2D>(L, 1));
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			case 2:
			{
				Collider2D collider = (Collider2D)ToLua.CheckObject<Collider2D>(L, 1);
				int layerMask = (int)LuaDLL.luaL_checknumber(L, 2);
				bool value = Physics2D.IsTouchingLayers(collider, layerMask);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics2D.IsTouchingLayers");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Distance(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Collider2D colliderA = (Collider2D)ToLua.CheckObject<Collider2D>(L, 1);
			Collider2D colliderB = (Collider2D)ToLua.CheckObject<Collider2D>(L, 2);
			ColliderDistance2D v = Physics2D.Distance(colliderA, colliderB);
			ToLua.PushValue(L, v);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Linecast(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			switch (num)
			{
			case 2:
			{
				Vector2 start2 = ToLua.ToVector2(L, 1);
				Vector2 end2 = ToLua.ToVector2(L, 2);
				RaycastHit2D v2 = Physics2D.Linecast(start2, end2);
				ToLua.PushValue(L, v2);
				return 1;
			}
			case 3:
			{
				Vector2 start3 = ToLua.ToVector2(L, 1);
				Vector2 end3 = ToLua.ToVector2(L, 2);
				int layerMask2 = (int)LuaDLL.luaL_checknumber(L, 3);
				RaycastHit2D v3 = Physics2D.Linecast(start3, end3, layerMask2);
				ToLua.PushValue(L, v3);
				return 1;
			}
			case 4:
				if (TypeChecker.CheckTypes<int, float>(L, 3))
				{
					Vector2 start = ToLua.ToVector2(L, 1);
					Vector2 end = ToLua.ToVector2(L, 2);
					int layerMask = (int)LuaDLL.lua_tonumber(L, 3);
					float minDepth = (float)LuaDLL.lua_tonumber(L, 4);
					RaycastHit2D v = Physics2D.Linecast(start, end, layerMask, minDepth);
					ToLua.PushValue(L, v);
					return 1;
				}
				break;
			}
			if (num == 4 && TypeChecker.CheckTypes<ContactFilter2D, RaycastHit2D[]>(L, 3))
			{
				Vector2 start4 = ToLua.ToVector2(L, 1);
				Vector2 end4 = ToLua.ToVector2(L, 2);
				ContactFilter2D contactFilter = StackTraits<ContactFilter2D>.To(L, 3);
				RaycastHit2D[] results = ToLua.ToStructArray<RaycastHit2D>(L, 4);
				int n = Physics2D.Linecast(start4, end4, contactFilter, results);
				LuaDLL.lua_pushinteger(L, n);
				return 1;
			}
			if (num == 5)
			{
				Vector2 start5 = ToLua.ToVector2(L, 1);
				Vector2 end5 = ToLua.ToVector2(L, 2);
				int layerMask3 = (int)LuaDLL.luaL_checknumber(L, 3);
				float minDepth2 = (float)LuaDLL.luaL_checknumber(L, 4);
				float maxDepth = (float)LuaDLL.luaL_checknumber(L, 5);
				RaycastHit2D v4 = Physics2D.Linecast(start5, end5, layerMask3, minDepth2, maxDepth);
				ToLua.PushValue(L, v4);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics2D.Linecast");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LinecastAll(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Vector2 start4 = ToLua.ToVector2(L, 1);
				Vector2 end4 = ToLua.ToVector2(L, 2);
				RaycastHit2D[] array4 = Physics2D.LinecastAll(start4, end4);
				ToLua.Push(L, array4);
				return 1;
			}
			case 3:
			{
				Vector2 start3 = ToLua.ToVector2(L, 1);
				Vector2 end3 = ToLua.ToVector2(L, 2);
				int layerMask3 = (int)LuaDLL.luaL_checknumber(L, 3);
				RaycastHit2D[] array3 = Physics2D.LinecastAll(start3, end3, layerMask3);
				ToLua.Push(L, array3);
				return 1;
			}
			case 4:
			{
				Vector2 start2 = ToLua.ToVector2(L, 1);
				Vector2 end2 = ToLua.ToVector2(L, 2);
				int layerMask2 = (int)LuaDLL.luaL_checknumber(L, 3);
				float minDepth2 = (float)LuaDLL.luaL_checknumber(L, 4);
				RaycastHit2D[] array2 = Physics2D.LinecastAll(start2, end2, layerMask2, minDepth2);
				ToLua.Push(L, array2);
				return 1;
			}
			case 5:
			{
				Vector2 start = ToLua.ToVector2(L, 1);
				Vector2 end = ToLua.ToVector2(L, 2);
				int layerMask = (int)LuaDLL.luaL_checknumber(L, 3);
				float minDepth = (float)LuaDLL.luaL_checknumber(L, 4);
				float maxDepth = (float)LuaDLL.luaL_checknumber(L, 5);
				RaycastHit2D[] array = Physics2D.LinecastAll(start, end, layerMask, minDepth, maxDepth);
				ToLua.Push(L, array);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics2D.LinecastAll");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LinecastNonAlloc(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				Vector2 start4 = ToLua.ToVector2(L, 1);
				Vector2 end4 = ToLua.ToVector2(L, 2);
				RaycastHit2D[] results4 = ToLua.CheckStructArray<RaycastHit2D>(L, 3);
				int n4 = Physics2D.LinecastNonAlloc(start4, end4, results4);
				LuaDLL.lua_pushinteger(L, n4);
				return 1;
			}
			case 4:
			{
				Vector2 start3 = ToLua.ToVector2(L, 1);
				Vector2 end3 = ToLua.ToVector2(L, 2);
				RaycastHit2D[] results3 = ToLua.CheckStructArray<RaycastHit2D>(L, 3);
				int layerMask3 = (int)LuaDLL.luaL_checknumber(L, 4);
				int n3 = Physics2D.LinecastNonAlloc(start3, end3, results3, layerMask3);
				LuaDLL.lua_pushinteger(L, n3);
				return 1;
			}
			case 5:
			{
				Vector2 start2 = ToLua.ToVector2(L, 1);
				Vector2 end2 = ToLua.ToVector2(L, 2);
				RaycastHit2D[] results2 = ToLua.CheckStructArray<RaycastHit2D>(L, 3);
				int layerMask2 = (int)LuaDLL.luaL_checknumber(L, 4);
				float minDepth2 = (float)LuaDLL.luaL_checknumber(L, 5);
				int n2 = Physics2D.LinecastNonAlloc(start2, end2, results2, layerMask2, minDepth2);
				LuaDLL.lua_pushinteger(L, n2);
				return 1;
			}
			case 6:
			{
				Vector2 start = ToLua.ToVector2(L, 1);
				Vector2 end = ToLua.ToVector2(L, 2);
				RaycastHit2D[] results = ToLua.CheckStructArray<RaycastHit2D>(L, 3);
				int layerMask = (int)LuaDLL.luaL_checknumber(L, 4);
				float minDepth = (float)LuaDLL.luaL_checknumber(L, 5);
				float maxDepth = (float)LuaDLL.luaL_checknumber(L, 6);
				int n = Physics2D.LinecastNonAlloc(start, end, results, layerMask, minDepth, maxDepth);
				LuaDLL.lua_pushinteger(L, n);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics2D.LinecastNonAlloc");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Raycast(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			switch (num)
			{
			case 2:
			{
				Vector2 origin2 = ToLua.ToVector2(L, 1);
				Vector2 direction2 = ToLua.ToVector2(L, 2);
				RaycastHit2D v2 = Physics2D.Raycast(origin2, direction2);
				ToLua.PushValue(L, v2);
				return 1;
			}
			case 3:
			{
				Vector2 origin3 = ToLua.ToVector2(L, 1);
				Vector2 direction3 = ToLua.ToVector2(L, 2);
				float distance2 = (float)LuaDLL.luaL_checknumber(L, 3);
				RaycastHit2D v3 = Physics2D.Raycast(origin3, direction3, distance2);
				ToLua.PushValue(L, v3);
				return 1;
			}
			case 4:
				if (TypeChecker.CheckTypes<float, int>(L, 3))
				{
					Vector2 origin = ToLua.ToVector2(L, 1);
					Vector2 direction = ToLua.ToVector2(L, 2);
					float distance = (float)LuaDLL.lua_tonumber(L, 3);
					int layerMask = (int)LuaDLL.lua_tonumber(L, 4);
					RaycastHit2D v = Physics2D.Raycast(origin, direction, distance, layerMask);
					ToLua.PushValue(L, v);
					return 1;
				}
				break;
			}
			if (num == 4 && TypeChecker.CheckTypes<ContactFilter2D, RaycastHit2D[]>(L, 3))
			{
				Vector2 origin4 = ToLua.ToVector2(L, 1);
				Vector2 direction4 = ToLua.ToVector2(L, 2);
				ContactFilter2D contactFilter = StackTraits<ContactFilter2D>.To(L, 3);
				RaycastHit2D[] results = ToLua.ToStructArray<RaycastHit2D>(L, 4);
				int n = Physics2D.Raycast(origin4, direction4, contactFilter, results);
				LuaDLL.lua_pushinteger(L, n);
				return 1;
			}
			if (num == 5 && TypeChecker.CheckTypes<float, int, float>(L, 3))
			{
				Vector2 origin5 = ToLua.ToVector2(L, 1);
				Vector2 direction5 = ToLua.ToVector2(L, 2);
				float distance3 = (float)LuaDLL.lua_tonumber(L, 3);
				int layerMask2 = (int)LuaDLL.lua_tonumber(L, 4);
				float minDepth = (float)LuaDLL.lua_tonumber(L, 5);
				RaycastHit2D v4 = Physics2D.Raycast(origin5, direction5, distance3, layerMask2, minDepth);
				ToLua.PushValue(L, v4);
				return 1;
			}
			if (num == 5 && TypeChecker.CheckTypes<ContactFilter2D, RaycastHit2D[], float>(L, 3))
			{
				Vector2 origin6 = ToLua.ToVector2(L, 1);
				Vector2 direction6 = ToLua.ToVector2(L, 2);
				ContactFilter2D contactFilter2 = StackTraits<ContactFilter2D>.To(L, 3);
				RaycastHit2D[] results2 = ToLua.ToStructArray<RaycastHit2D>(L, 4);
				float distance4 = (float)LuaDLL.lua_tonumber(L, 5);
				int n2 = Physics2D.Raycast(origin6, direction6, contactFilter2, results2, distance4);
				LuaDLL.lua_pushinteger(L, n2);
				return 1;
			}
			if (num == 6)
			{
				Vector2 origin7 = ToLua.ToVector2(L, 1);
				Vector2 direction7 = ToLua.ToVector2(L, 2);
				float distance5 = (float)LuaDLL.luaL_checknumber(L, 3);
				int layerMask3 = (int)LuaDLL.luaL_checknumber(L, 4);
				float minDepth2 = (float)LuaDLL.luaL_checknumber(L, 5);
				float maxDepth = (float)LuaDLL.luaL_checknumber(L, 6);
				RaycastHit2D v5 = Physics2D.Raycast(origin7, direction7, distance5, layerMask3, minDepth2, maxDepth);
				ToLua.PushValue(L, v5);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics2D.Raycast");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RaycastNonAlloc(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				Vector2 origin5 = ToLua.ToVector2(L, 1);
				Vector2 direction5 = ToLua.ToVector2(L, 2);
				RaycastHit2D[] results5 = ToLua.CheckStructArray<RaycastHit2D>(L, 3);
				int n5 = Physics2D.RaycastNonAlloc(origin5, direction5, results5);
				LuaDLL.lua_pushinteger(L, n5);
				return 1;
			}
			case 4:
			{
				Vector2 origin4 = ToLua.ToVector2(L, 1);
				Vector2 direction4 = ToLua.ToVector2(L, 2);
				RaycastHit2D[] results4 = ToLua.CheckStructArray<RaycastHit2D>(L, 3);
				float distance4 = (float)LuaDLL.luaL_checknumber(L, 4);
				int n4 = Physics2D.RaycastNonAlloc(origin4, direction4, results4, distance4);
				LuaDLL.lua_pushinteger(L, n4);
				return 1;
			}
			case 5:
			{
				Vector2 origin3 = ToLua.ToVector2(L, 1);
				Vector2 direction3 = ToLua.ToVector2(L, 2);
				RaycastHit2D[] results3 = ToLua.CheckStructArray<RaycastHit2D>(L, 3);
				float distance3 = (float)LuaDLL.luaL_checknumber(L, 4);
				int layerMask3 = (int)LuaDLL.luaL_checknumber(L, 5);
				int n3 = Physics2D.RaycastNonAlloc(origin3, direction3, results3, distance3, layerMask3);
				LuaDLL.lua_pushinteger(L, n3);
				return 1;
			}
			case 6:
			{
				Vector2 origin2 = ToLua.ToVector2(L, 1);
				Vector2 direction2 = ToLua.ToVector2(L, 2);
				RaycastHit2D[] results2 = ToLua.CheckStructArray<RaycastHit2D>(L, 3);
				float distance2 = (float)LuaDLL.luaL_checknumber(L, 4);
				int layerMask2 = (int)LuaDLL.luaL_checknumber(L, 5);
				float minDepth2 = (float)LuaDLL.luaL_checknumber(L, 6);
				int n2 = Physics2D.RaycastNonAlloc(origin2, direction2, results2, distance2, layerMask2, minDepth2);
				LuaDLL.lua_pushinteger(L, n2);
				return 1;
			}
			case 7:
			{
				Vector2 origin = ToLua.ToVector2(L, 1);
				Vector2 direction = ToLua.ToVector2(L, 2);
				RaycastHit2D[] results = ToLua.CheckStructArray<RaycastHit2D>(L, 3);
				float distance = (float)LuaDLL.luaL_checknumber(L, 4);
				int layerMask = (int)LuaDLL.luaL_checknumber(L, 5);
				float minDepth = (float)LuaDLL.luaL_checknumber(L, 6);
				float maxDepth = (float)LuaDLL.luaL_checknumber(L, 7);
				int n = Physics2D.RaycastNonAlloc(origin, direction, results, distance, layerMask, minDepth, maxDepth);
				LuaDLL.lua_pushinteger(L, n);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics2D.RaycastNonAlloc");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RaycastAll(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Vector2 origin5 = ToLua.ToVector2(L, 1);
				Vector2 direction5 = ToLua.ToVector2(L, 2);
				RaycastHit2D[] array5 = Physics2D.RaycastAll(origin5, direction5);
				ToLua.Push(L, array5);
				return 1;
			}
			case 3:
			{
				Vector2 origin4 = ToLua.ToVector2(L, 1);
				Vector2 direction4 = ToLua.ToVector2(L, 2);
				float distance4 = (float)LuaDLL.luaL_checknumber(L, 3);
				RaycastHit2D[] array4 = Physics2D.RaycastAll(origin4, direction4, distance4);
				ToLua.Push(L, array4);
				return 1;
			}
			case 4:
			{
				Vector2 origin3 = ToLua.ToVector2(L, 1);
				Vector2 direction3 = ToLua.ToVector2(L, 2);
				float distance3 = (float)LuaDLL.luaL_checknumber(L, 3);
				int layerMask3 = (int)LuaDLL.luaL_checknumber(L, 4);
				RaycastHit2D[] array3 = Physics2D.RaycastAll(origin3, direction3, distance3, layerMask3);
				ToLua.Push(L, array3);
				return 1;
			}
			case 5:
			{
				Vector2 origin2 = ToLua.ToVector2(L, 1);
				Vector2 direction2 = ToLua.ToVector2(L, 2);
				float distance2 = (float)LuaDLL.luaL_checknumber(L, 3);
				int layerMask2 = (int)LuaDLL.luaL_checknumber(L, 4);
				float minDepth2 = (float)LuaDLL.luaL_checknumber(L, 5);
				RaycastHit2D[] array2 = Physics2D.RaycastAll(origin2, direction2, distance2, layerMask2, minDepth2);
				ToLua.Push(L, array2);
				return 1;
			}
			case 6:
			{
				Vector2 origin = ToLua.ToVector2(L, 1);
				Vector2 direction = ToLua.ToVector2(L, 2);
				float distance = (float)LuaDLL.luaL_checknumber(L, 3);
				int layerMask = (int)LuaDLL.luaL_checknumber(L, 4);
				float minDepth = (float)LuaDLL.luaL_checknumber(L, 5);
				float maxDepth = (float)LuaDLL.luaL_checknumber(L, 6);
				RaycastHit2D[] array = Physics2D.RaycastAll(origin, direction, distance, layerMask, minDepth, maxDepth);
				ToLua.Push(L, array);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics2D.RaycastAll");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CircleCast(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			switch (num)
			{
			case 3:
			{
				Vector2 origin2 = ToLua.ToVector2(L, 1);
				float radius2 = (float)LuaDLL.luaL_checknumber(L, 2);
				Vector2 direction2 = ToLua.ToVector2(L, 3);
				RaycastHit2D v2 = Physics2D.CircleCast(origin2, radius2, direction2);
				ToLua.PushValue(L, v2);
				return 1;
			}
			case 4:
			{
				Vector2 origin3 = ToLua.ToVector2(L, 1);
				float radius3 = (float)LuaDLL.luaL_checknumber(L, 2);
				Vector2 direction3 = ToLua.ToVector2(L, 3);
				float distance2 = (float)LuaDLL.luaL_checknumber(L, 4);
				RaycastHit2D v3 = Physics2D.CircleCast(origin3, radius3, direction3, distance2);
				ToLua.PushValue(L, v3);
				return 1;
			}
			case 5:
				if (TypeChecker.CheckTypes<float, int>(L, 4))
				{
					Vector2 origin = ToLua.ToVector2(L, 1);
					float radius = (float)LuaDLL.luaL_checknumber(L, 2);
					Vector2 direction = ToLua.ToVector2(L, 3);
					float distance = (float)LuaDLL.lua_tonumber(L, 4);
					int layerMask = (int)LuaDLL.lua_tonumber(L, 5);
					RaycastHit2D v = Physics2D.CircleCast(origin, radius, direction, distance, layerMask);
					ToLua.PushValue(L, v);
					return 1;
				}
				break;
			}
			if (num == 5 && TypeChecker.CheckTypes<ContactFilter2D, RaycastHit2D[]>(L, 4))
			{
				Vector2 origin4 = ToLua.ToVector2(L, 1);
				float radius4 = (float)LuaDLL.luaL_checknumber(L, 2);
				Vector2 direction4 = ToLua.ToVector2(L, 3);
				ContactFilter2D contactFilter = StackTraits<ContactFilter2D>.To(L, 4);
				RaycastHit2D[] results = ToLua.ToStructArray<RaycastHit2D>(L, 5);
				int n = Physics2D.CircleCast(origin4, radius4, direction4, contactFilter, results);
				LuaDLL.lua_pushinteger(L, n);
				return 1;
			}
			if (num == 6 && TypeChecker.CheckTypes<float, int, float>(L, 4))
			{
				Vector2 origin5 = ToLua.ToVector2(L, 1);
				float radius5 = (float)LuaDLL.luaL_checknumber(L, 2);
				Vector2 direction5 = ToLua.ToVector2(L, 3);
				float distance3 = (float)LuaDLL.lua_tonumber(L, 4);
				int layerMask2 = (int)LuaDLL.lua_tonumber(L, 5);
				float minDepth = (float)LuaDLL.lua_tonumber(L, 6);
				RaycastHit2D v4 = Physics2D.CircleCast(origin5, radius5, direction5, distance3, layerMask2, minDepth);
				ToLua.PushValue(L, v4);
				return 1;
			}
			if (num == 6 && TypeChecker.CheckTypes<ContactFilter2D, RaycastHit2D[], float>(L, 4))
			{
				Vector2 origin6 = ToLua.ToVector2(L, 1);
				float radius6 = (float)LuaDLL.luaL_checknumber(L, 2);
				Vector2 direction6 = ToLua.ToVector2(L, 3);
				ContactFilter2D contactFilter2 = StackTraits<ContactFilter2D>.To(L, 4);
				RaycastHit2D[] results2 = ToLua.ToStructArray<RaycastHit2D>(L, 5);
				float distance4 = (float)LuaDLL.lua_tonumber(L, 6);
				int n2 = Physics2D.CircleCast(origin6, radius6, direction6, contactFilter2, results2, distance4);
				LuaDLL.lua_pushinteger(L, n2);
				return 1;
			}
			if (num == 7)
			{
				Vector2 origin7 = ToLua.ToVector2(L, 1);
				float radius7 = (float)LuaDLL.luaL_checknumber(L, 2);
				Vector2 direction7 = ToLua.ToVector2(L, 3);
				float distance5 = (float)LuaDLL.luaL_checknumber(L, 4);
				int layerMask3 = (int)LuaDLL.luaL_checknumber(L, 5);
				float minDepth2 = (float)LuaDLL.luaL_checknumber(L, 6);
				float maxDepth = (float)LuaDLL.luaL_checknumber(L, 7);
				RaycastHit2D v5 = Physics2D.CircleCast(origin7, radius7, direction7, distance5, layerMask3, minDepth2, maxDepth);
				ToLua.PushValue(L, v5);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics2D.CircleCast");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CircleCastAll(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				Vector2 origin5 = ToLua.ToVector2(L, 1);
				float radius5 = (float)LuaDLL.luaL_checknumber(L, 2);
				Vector2 direction5 = ToLua.ToVector2(L, 3);
				RaycastHit2D[] array5 = Physics2D.CircleCastAll(origin5, radius5, direction5);
				ToLua.Push(L, array5);
				return 1;
			}
			case 4:
			{
				Vector2 origin4 = ToLua.ToVector2(L, 1);
				float radius4 = (float)LuaDLL.luaL_checknumber(L, 2);
				Vector2 direction4 = ToLua.ToVector2(L, 3);
				float distance4 = (float)LuaDLL.luaL_checknumber(L, 4);
				RaycastHit2D[] array4 = Physics2D.CircleCastAll(origin4, radius4, direction4, distance4);
				ToLua.Push(L, array4);
				return 1;
			}
			case 5:
			{
				Vector2 origin3 = ToLua.ToVector2(L, 1);
				float radius3 = (float)LuaDLL.luaL_checknumber(L, 2);
				Vector2 direction3 = ToLua.ToVector2(L, 3);
				float distance3 = (float)LuaDLL.luaL_checknumber(L, 4);
				int layerMask3 = (int)LuaDLL.luaL_checknumber(L, 5);
				RaycastHit2D[] array3 = Physics2D.CircleCastAll(origin3, radius3, direction3, distance3, layerMask3);
				ToLua.Push(L, array3);
				return 1;
			}
			case 6:
			{
				Vector2 origin2 = ToLua.ToVector2(L, 1);
				float radius2 = (float)LuaDLL.luaL_checknumber(L, 2);
				Vector2 direction2 = ToLua.ToVector2(L, 3);
				float distance2 = (float)LuaDLL.luaL_checknumber(L, 4);
				int layerMask2 = (int)LuaDLL.luaL_checknumber(L, 5);
				float minDepth2 = (float)LuaDLL.luaL_checknumber(L, 6);
				RaycastHit2D[] array2 = Physics2D.CircleCastAll(origin2, radius2, direction2, distance2, layerMask2, minDepth2);
				ToLua.Push(L, array2);
				return 1;
			}
			case 7:
			{
				Vector2 origin = ToLua.ToVector2(L, 1);
				float radius = (float)LuaDLL.luaL_checknumber(L, 2);
				Vector2 direction = ToLua.ToVector2(L, 3);
				float distance = (float)LuaDLL.luaL_checknumber(L, 4);
				int layerMask = (int)LuaDLL.luaL_checknumber(L, 5);
				float minDepth = (float)LuaDLL.luaL_checknumber(L, 6);
				float maxDepth = (float)LuaDLL.luaL_checknumber(L, 7);
				RaycastHit2D[] array = Physics2D.CircleCastAll(origin, radius, direction, distance, layerMask, minDepth, maxDepth);
				ToLua.Push(L, array);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics2D.CircleCastAll");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CircleCastNonAlloc(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 4:
			{
				Vector2 origin5 = ToLua.ToVector2(L, 1);
				float radius5 = (float)LuaDLL.luaL_checknumber(L, 2);
				Vector2 direction5 = ToLua.ToVector2(L, 3);
				RaycastHit2D[] results5 = ToLua.CheckStructArray<RaycastHit2D>(L, 4);
				int n5 = Physics2D.CircleCastNonAlloc(origin5, radius5, direction5, results5);
				LuaDLL.lua_pushinteger(L, n5);
				return 1;
			}
			case 5:
			{
				Vector2 origin4 = ToLua.ToVector2(L, 1);
				float radius4 = (float)LuaDLL.luaL_checknumber(L, 2);
				Vector2 direction4 = ToLua.ToVector2(L, 3);
				RaycastHit2D[] results4 = ToLua.CheckStructArray<RaycastHit2D>(L, 4);
				float distance4 = (float)LuaDLL.luaL_checknumber(L, 5);
				int n4 = Physics2D.CircleCastNonAlloc(origin4, radius4, direction4, results4, distance4);
				LuaDLL.lua_pushinteger(L, n4);
				return 1;
			}
			case 6:
			{
				Vector2 origin3 = ToLua.ToVector2(L, 1);
				float radius3 = (float)LuaDLL.luaL_checknumber(L, 2);
				Vector2 direction3 = ToLua.ToVector2(L, 3);
				RaycastHit2D[] results3 = ToLua.CheckStructArray<RaycastHit2D>(L, 4);
				float distance3 = (float)LuaDLL.luaL_checknumber(L, 5);
				int layerMask3 = (int)LuaDLL.luaL_checknumber(L, 6);
				int n3 = Physics2D.CircleCastNonAlloc(origin3, radius3, direction3, results3, distance3, layerMask3);
				LuaDLL.lua_pushinteger(L, n3);
				return 1;
			}
			case 7:
			{
				Vector2 origin2 = ToLua.ToVector2(L, 1);
				float radius2 = (float)LuaDLL.luaL_checknumber(L, 2);
				Vector2 direction2 = ToLua.ToVector2(L, 3);
				RaycastHit2D[] results2 = ToLua.CheckStructArray<RaycastHit2D>(L, 4);
				float distance2 = (float)LuaDLL.luaL_checknumber(L, 5);
				int layerMask2 = (int)LuaDLL.luaL_checknumber(L, 6);
				float minDepth2 = (float)LuaDLL.luaL_checknumber(L, 7);
				int n2 = Physics2D.CircleCastNonAlloc(origin2, radius2, direction2, results2, distance2, layerMask2, minDepth2);
				LuaDLL.lua_pushinteger(L, n2);
				return 1;
			}
			case 8:
			{
				Vector2 origin = ToLua.ToVector2(L, 1);
				float radius = (float)LuaDLL.luaL_checknumber(L, 2);
				Vector2 direction = ToLua.ToVector2(L, 3);
				RaycastHit2D[] results = ToLua.CheckStructArray<RaycastHit2D>(L, 4);
				float distance = (float)LuaDLL.luaL_checknumber(L, 5);
				int layerMask = (int)LuaDLL.luaL_checknumber(L, 6);
				float minDepth = (float)LuaDLL.luaL_checknumber(L, 7);
				float maxDepth = (float)LuaDLL.luaL_checknumber(L, 8);
				int n = Physics2D.CircleCastNonAlloc(origin, radius, direction, results, distance, layerMask, minDepth, maxDepth);
				LuaDLL.lua_pushinteger(L, n);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics2D.CircleCastNonAlloc");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int BoxCast(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			switch (num)
			{
			case 4:
			{
				Vector2 origin2 = ToLua.ToVector2(L, 1);
				Vector2 size2 = ToLua.ToVector2(L, 2);
				float angle2 = (float)LuaDLL.luaL_checknumber(L, 3);
				Vector2 direction2 = ToLua.ToVector2(L, 4);
				RaycastHit2D v2 = Physics2D.BoxCast(origin2, size2, angle2, direction2);
				ToLua.PushValue(L, v2);
				return 1;
			}
			case 5:
			{
				Vector2 origin3 = ToLua.ToVector2(L, 1);
				Vector2 size3 = ToLua.ToVector2(L, 2);
				float angle3 = (float)LuaDLL.luaL_checknumber(L, 3);
				Vector2 direction3 = ToLua.ToVector2(L, 4);
				float distance2 = (float)LuaDLL.luaL_checknumber(L, 5);
				RaycastHit2D v3 = Physics2D.BoxCast(origin3, size3, angle3, direction3, distance2);
				ToLua.PushValue(L, v3);
				return 1;
			}
			case 6:
				if (TypeChecker.CheckTypes<float, int>(L, 5))
				{
					Vector2 origin = ToLua.ToVector2(L, 1);
					Vector2 size = ToLua.ToVector2(L, 2);
					float angle = (float)LuaDLL.luaL_checknumber(L, 3);
					Vector2 direction = ToLua.ToVector2(L, 4);
					float distance = (float)LuaDLL.lua_tonumber(L, 5);
					int layerMask = (int)LuaDLL.lua_tonumber(L, 6);
					RaycastHit2D v = Physics2D.BoxCast(origin, size, angle, direction, distance, layerMask);
					ToLua.PushValue(L, v);
					return 1;
				}
				break;
			}
			if (num == 6 && TypeChecker.CheckTypes<ContactFilter2D, RaycastHit2D[]>(L, 5))
			{
				Vector2 origin4 = ToLua.ToVector2(L, 1);
				Vector2 size4 = ToLua.ToVector2(L, 2);
				float angle4 = (float)LuaDLL.luaL_checknumber(L, 3);
				Vector2 direction4 = ToLua.ToVector2(L, 4);
				ContactFilter2D contactFilter = StackTraits<ContactFilter2D>.To(L, 5);
				RaycastHit2D[] results = ToLua.ToStructArray<RaycastHit2D>(L, 6);
				int n = Physics2D.BoxCast(origin4, size4, angle4, direction4, contactFilter, results);
				LuaDLL.lua_pushinteger(L, n);
				return 1;
			}
			if (num == 7 && TypeChecker.CheckTypes<float, int, float>(L, 5))
			{
				Vector2 origin5 = ToLua.ToVector2(L, 1);
				Vector2 size5 = ToLua.ToVector2(L, 2);
				float angle5 = (float)LuaDLL.luaL_checknumber(L, 3);
				Vector2 direction5 = ToLua.ToVector2(L, 4);
				float distance3 = (float)LuaDLL.lua_tonumber(L, 5);
				int layerMask2 = (int)LuaDLL.lua_tonumber(L, 6);
				float minDepth = (float)LuaDLL.lua_tonumber(L, 7);
				RaycastHit2D v4 = Physics2D.BoxCast(origin5, size5, angle5, direction5, distance3, layerMask2, minDepth);
				ToLua.PushValue(L, v4);
				return 1;
			}
			if (num == 7 && TypeChecker.CheckTypes<ContactFilter2D, RaycastHit2D[], float>(L, 5))
			{
				Vector2 origin6 = ToLua.ToVector2(L, 1);
				Vector2 size6 = ToLua.ToVector2(L, 2);
				float angle6 = (float)LuaDLL.luaL_checknumber(L, 3);
				Vector2 direction6 = ToLua.ToVector2(L, 4);
				ContactFilter2D contactFilter2 = StackTraits<ContactFilter2D>.To(L, 5);
				RaycastHit2D[] results2 = ToLua.ToStructArray<RaycastHit2D>(L, 6);
				float distance4 = (float)LuaDLL.lua_tonumber(L, 7);
				int n2 = Physics2D.BoxCast(origin6, size6, angle6, direction6, contactFilter2, results2, distance4);
				LuaDLL.lua_pushinteger(L, n2);
				return 1;
			}
			if (num == 8)
			{
				Vector2 origin7 = ToLua.ToVector2(L, 1);
				Vector2 size7 = ToLua.ToVector2(L, 2);
				float angle7 = (float)LuaDLL.luaL_checknumber(L, 3);
				Vector2 direction7 = ToLua.ToVector2(L, 4);
				float distance5 = (float)LuaDLL.luaL_checknumber(L, 5);
				int layerMask3 = (int)LuaDLL.luaL_checknumber(L, 6);
				float minDepth2 = (float)LuaDLL.luaL_checknumber(L, 7);
				float maxDepth = (float)LuaDLL.luaL_checknumber(L, 8);
				RaycastHit2D v5 = Physics2D.BoxCast(origin7, size7, angle7, direction7, distance5, layerMask3, minDepth2, maxDepth);
				ToLua.PushValue(L, v5);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics2D.BoxCast");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int BoxCastAll(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 4:
			{
				Vector2 origin5 = ToLua.ToVector2(L, 1);
				Vector2 size5 = ToLua.ToVector2(L, 2);
				float angle5 = (float)LuaDLL.luaL_checknumber(L, 3);
				Vector2 direction5 = ToLua.ToVector2(L, 4);
				RaycastHit2D[] array5 = Physics2D.BoxCastAll(origin5, size5, angle5, direction5);
				ToLua.Push(L, array5);
				return 1;
			}
			case 5:
			{
				Vector2 origin4 = ToLua.ToVector2(L, 1);
				Vector2 size4 = ToLua.ToVector2(L, 2);
				float angle4 = (float)LuaDLL.luaL_checknumber(L, 3);
				Vector2 direction4 = ToLua.ToVector2(L, 4);
				float distance4 = (float)LuaDLL.luaL_checknumber(L, 5);
				RaycastHit2D[] array4 = Physics2D.BoxCastAll(origin4, size4, angle4, direction4, distance4);
				ToLua.Push(L, array4);
				return 1;
			}
			case 6:
			{
				Vector2 origin3 = ToLua.ToVector2(L, 1);
				Vector2 size3 = ToLua.ToVector2(L, 2);
				float angle3 = (float)LuaDLL.luaL_checknumber(L, 3);
				Vector2 direction3 = ToLua.ToVector2(L, 4);
				float distance3 = (float)LuaDLL.luaL_checknumber(L, 5);
				int layerMask3 = (int)LuaDLL.luaL_checknumber(L, 6);
				RaycastHit2D[] array3 = Physics2D.BoxCastAll(origin3, size3, angle3, direction3, distance3, layerMask3);
				ToLua.Push(L, array3);
				return 1;
			}
			case 7:
			{
				Vector2 origin2 = ToLua.ToVector2(L, 1);
				Vector2 size2 = ToLua.ToVector2(L, 2);
				float angle2 = (float)LuaDLL.luaL_checknumber(L, 3);
				Vector2 direction2 = ToLua.ToVector2(L, 4);
				float distance2 = (float)LuaDLL.luaL_checknumber(L, 5);
				int layerMask2 = (int)LuaDLL.luaL_checknumber(L, 6);
				float minDepth2 = (float)LuaDLL.luaL_checknumber(L, 7);
				RaycastHit2D[] array2 = Physics2D.BoxCastAll(origin2, size2, angle2, direction2, distance2, layerMask2, minDepth2);
				ToLua.Push(L, array2);
				return 1;
			}
			case 8:
			{
				Vector2 origin = ToLua.ToVector2(L, 1);
				Vector2 size = ToLua.ToVector2(L, 2);
				float angle = (float)LuaDLL.luaL_checknumber(L, 3);
				Vector2 direction = ToLua.ToVector2(L, 4);
				float distance = (float)LuaDLL.luaL_checknumber(L, 5);
				int layerMask = (int)LuaDLL.luaL_checknumber(L, 6);
				float minDepth = (float)LuaDLL.luaL_checknumber(L, 7);
				float maxDepth = (float)LuaDLL.luaL_checknumber(L, 8);
				RaycastHit2D[] array = Physics2D.BoxCastAll(origin, size, angle, direction, distance, layerMask, minDepth, maxDepth);
				ToLua.Push(L, array);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics2D.BoxCastAll");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int BoxCastNonAlloc(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 5:
			{
				Vector2 origin5 = ToLua.ToVector2(L, 1);
				Vector2 size5 = ToLua.ToVector2(L, 2);
				float angle5 = (float)LuaDLL.luaL_checknumber(L, 3);
				Vector2 direction5 = ToLua.ToVector2(L, 4);
				RaycastHit2D[] results5 = ToLua.CheckStructArray<RaycastHit2D>(L, 5);
				int n5 = Physics2D.BoxCastNonAlloc(origin5, size5, angle5, direction5, results5);
				LuaDLL.lua_pushinteger(L, n5);
				return 1;
			}
			case 6:
			{
				Vector2 origin4 = ToLua.ToVector2(L, 1);
				Vector2 size4 = ToLua.ToVector2(L, 2);
				float angle4 = (float)LuaDLL.luaL_checknumber(L, 3);
				Vector2 direction4 = ToLua.ToVector2(L, 4);
				RaycastHit2D[] results4 = ToLua.CheckStructArray<RaycastHit2D>(L, 5);
				float distance4 = (float)LuaDLL.luaL_checknumber(L, 6);
				int n4 = Physics2D.BoxCastNonAlloc(origin4, size4, angle4, direction4, results4, distance4);
				LuaDLL.lua_pushinteger(L, n4);
				return 1;
			}
			case 7:
			{
				Vector2 origin3 = ToLua.ToVector2(L, 1);
				Vector2 size3 = ToLua.ToVector2(L, 2);
				float angle3 = (float)LuaDLL.luaL_checknumber(L, 3);
				Vector2 direction3 = ToLua.ToVector2(L, 4);
				RaycastHit2D[] results3 = ToLua.CheckStructArray<RaycastHit2D>(L, 5);
				float distance3 = (float)LuaDLL.luaL_checknumber(L, 6);
				int layerMask3 = (int)LuaDLL.luaL_checknumber(L, 7);
				int n3 = Physics2D.BoxCastNonAlloc(origin3, size3, angle3, direction3, results3, distance3, layerMask3);
				LuaDLL.lua_pushinteger(L, n3);
				return 1;
			}
			case 8:
			{
				Vector2 origin2 = ToLua.ToVector2(L, 1);
				Vector2 size2 = ToLua.ToVector2(L, 2);
				float angle2 = (float)LuaDLL.luaL_checknumber(L, 3);
				Vector2 direction2 = ToLua.ToVector2(L, 4);
				RaycastHit2D[] results2 = ToLua.CheckStructArray<RaycastHit2D>(L, 5);
				float distance2 = (float)LuaDLL.luaL_checknumber(L, 6);
				int layerMask2 = (int)LuaDLL.luaL_checknumber(L, 7);
				float minDepth2 = (float)LuaDLL.luaL_checknumber(L, 8);
				int n2 = Physics2D.BoxCastNonAlloc(origin2, size2, angle2, direction2, results2, distance2, layerMask2, minDepth2);
				LuaDLL.lua_pushinteger(L, n2);
				return 1;
			}
			case 9:
			{
				Vector2 origin = ToLua.ToVector2(L, 1);
				Vector2 size = ToLua.ToVector2(L, 2);
				float angle = (float)LuaDLL.luaL_checknumber(L, 3);
				Vector2 direction = ToLua.ToVector2(L, 4);
				RaycastHit2D[] results = ToLua.CheckStructArray<RaycastHit2D>(L, 5);
				float distance = (float)LuaDLL.luaL_checknumber(L, 6);
				int layerMask = (int)LuaDLL.luaL_checknumber(L, 7);
				float minDepth = (float)LuaDLL.luaL_checknumber(L, 8);
				float maxDepth = (float)LuaDLL.luaL_checknumber(L, 9);
				int n = Physics2D.BoxCastNonAlloc(origin, size, angle, direction, results, distance, layerMask, minDepth, maxDepth);
				LuaDLL.lua_pushinteger(L, n);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics2D.BoxCastNonAlloc");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CapsuleCast(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			switch (num)
			{
			case 5:
			{
				Vector2 origin2 = ToLua.ToVector2(L, 1);
				Vector2 size2 = ToLua.ToVector2(L, 2);
				CapsuleDirection2D capsuleDirection2 = (CapsuleDirection2D)ToLua.CheckObject(L, 3, typeof(CapsuleDirection2D));
				float angle2 = (float)LuaDLL.luaL_checknumber(L, 4);
				Vector2 direction2 = ToLua.ToVector2(L, 5);
				RaycastHit2D v2 = Physics2D.CapsuleCast(origin2, size2, capsuleDirection2, angle2, direction2);
				ToLua.PushValue(L, v2);
				return 1;
			}
			case 6:
			{
				Vector2 origin3 = ToLua.ToVector2(L, 1);
				Vector2 size3 = ToLua.ToVector2(L, 2);
				CapsuleDirection2D capsuleDirection3 = (CapsuleDirection2D)ToLua.CheckObject(L, 3, typeof(CapsuleDirection2D));
				float angle3 = (float)LuaDLL.luaL_checknumber(L, 4);
				Vector2 direction3 = ToLua.ToVector2(L, 5);
				float distance2 = (float)LuaDLL.luaL_checknumber(L, 6);
				RaycastHit2D v3 = Physics2D.CapsuleCast(origin3, size3, capsuleDirection3, angle3, direction3, distance2);
				ToLua.PushValue(L, v3);
				return 1;
			}
			case 7:
				if (TypeChecker.CheckTypes<float, int>(L, 6))
				{
					Vector2 origin = ToLua.ToVector2(L, 1);
					Vector2 size = ToLua.ToVector2(L, 2);
					CapsuleDirection2D capsuleDirection = (CapsuleDirection2D)ToLua.CheckObject(L, 3, typeof(CapsuleDirection2D));
					float angle = (float)LuaDLL.luaL_checknumber(L, 4);
					Vector2 direction = ToLua.ToVector2(L, 5);
					float distance = (float)LuaDLL.lua_tonumber(L, 6);
					int layerMask = (int)LuaDLL.lua_tonumber(L, 7);
					RaycastHit2D v = Physics2D.CapsuleCast(origin, size, capsuleDirection, angle, direction, distance, layerMask);
					ToLua.PushValue(L, v);
					return 1;
				}
				break;
			}
			if (num == 7 && TypeChecker.CheckTypes<ContactFilter2D, RaycastHit2D[]>(L, 6))
			{
				Vector2 origin4 = ToLua.ToVector2(L, 1);
				Vector2 size4 = ToLua.ToVector2(L, 2);
				CapsuleDirection2D capsuleDirection4 = (CapsuleDirection2D)ToLua.CheckObject(L, 3, typeof(CapsuleDirection2D));
				float angle4 = (float)LuaDLL.luaL_checknumber(L, 4);
				Vector2 direction4 = ToLua.ToVector2(L, 5);
				ContactFilter2D contactFilter = StackTraits<ContactFilter2D>.To(L, 6);
				RaycastHit2D[] results = ToLua.ToStructArray<RaycastHit2D>(L, 7);
				int n = Physics2D.CapsuleCast(origin4, size4, capsuleDirection4, angle4, direction4, contactFilter, results);
				LuaDLL.lua_pushinteger(L, n);
				return 1;
			}
			if (num == 8 && TypeChecker.CheckTypes<float, int, float>(L, 6))
			{
				Vector2 origin5 = ToLua.ToVector2(L, 1);
				Vector2 size5 = ToLua.ToVector2(L, 2);
				CapsuleDirection2D capsuleDirection5 = (CapsuleDirection2D)ToLua.CheckObject(L, 3, typeof(CapsuleDirection2D));
				float angle5 = (float)LuaDLL.luaL_checknumber(L, 4);
				Vector2 direction5 = ToLua.ToVector2(L, 5);
				float distance3 = (float)LuaDLL.lua_tonumber(L, 6);
				int layerMask2 = (int)LuaDLL.lua_tonumber(L, 7);
				float minDepth = (float)LuaDLL.lua_tonumber(L, 8);
				RaycastHit2D v4 = Physics2D.CapsuleCast(origin5, size5, capsuleDirection5, angle5, direction5, distance3, layerMask2, minDepth);
				ToLua.PushValue(L, v4);
				return 1;
			}
			if (num == 8 && TypeChecker.CheckTypes<ContactFilter2D, RaycastHit2D[], float>(L, 6))
			{
				Vector2 origin6 = ToLua.ToVector2(L, 1);
				Vector2 size6 = ToLua.ToVector2(L, 2);
				CapsuleDirection2D capsuleDirection6 = (CapsuleDirection2D)ToLua.CheckObject(L, 3, typeof(CapsuleDirection2D));
				float angle6 = (float)LuaDLL.luaL_checknumber(L, 4);
				Vector2 direction6 = ToLua.ToVector2(L, 5);
				ContactFilter2D contactFilter2 = StackTraits<ContactFilter2D>.To(L, 6);
				RaycastHit2D[] results2 = ToLua.ToStructArray<RaycastHit2D>(L, 7);
				float distance4 = (float)LuaDLL.lua_tonumber(L, 8);
				int n2 = Physics2D.CapsuleCast(origin6, size6, capsuleDirection6, angle6, direction6, contactFilter2, results2, distance4);
				LuaDLL.lua_pushinteger(L, n2);
				return 1;
			}
			if (num == 9)
			{
				Vector2 origin7 = ToLua.ToVector2(L, 1);
				Vector2 size7 = ToLua.ToVector2(L, 2);
				CapsuleDirection2D capsuleDirection7 = (CapsuleDirection2D)ToLua.CheckObject(L, 3, typeof(CapsuleDirection2D));
				float angle7 = (float)LuaDLL.luaL_checknumber(L, 4);
				Vector2 direction7 = ToLua.ToVector2(L, 5);
				float distance5 = (float)LuaDLL.luaL_checknumber(L, 6);
				int layerMask3 = (int)LuaDLL.luaL_checknumber(L, 7);
				float minDepth2 = (float)LuaDLL.luaL_checknumber(L, 8);
				float maxDepth = (float)LuaDLL.luaL_checknumber(L, 9);
				RaycastHit2D v5 = Physics2D.CapsuleCast(origin7, size7, capsuleDirection7, angle7, direction7, distance5, layerMask3, minDepth2, maxDepth);
				ToLua.PushValue(L, v5);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics2D.CapsuleCast");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CapsuleCastAll(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 5:
			{
				Vector2 origin5 = ToLua.ToVector2(L, 1);
				Vector2 size5 = ToLua.ToVector2(L, 2);
				CapsuleDirection2D capsuleDirection5 = (CapsuleDirection2D)ToLua.CheckObject(L, 3, typeof(CapsuleDirection2D));
				float angle5 = (float)LuaDLL.luaL_checknumber(L, 4);
				Vector2 direction5 = ToLua.ToVector2(L, 5);
				RaycastHit2D[] array5 = Physics2D.CapsuleCastAll(origin5, size5, capsuleDirection5, angle5, direction5);
				ToLua.Push(L, array5);
				return 1;
			}
			case 6:
			{
				Vector2 origin4 = ToLua.ToVector2(L, 1);
				Vector2 size4 = ToLua.ToVector2(L, 2);
				CapsuleDirection2D capsuleDirection4 = (CapsuleDirection2D)ToLua.CheckObject(L, 3, typeof(CapsuleDirection2D));
				float angle4 = (float)LuaDLL.luaL_checknumber(L, 4);
				Vector2 direction4 = ToLua.ToVector2(L, 5);
				float distance4 = (float)LuaDLL.luaL_checknumber(L, 6);
				RaycastHit2D[] array4 = Physics2D.CapsuleCastAll(origin4, size4, capsuleDirection4, angle4, direction4, distance4);
				ToLua.Push(L, array4);
				return 1;
			}
			case 7:
			{
				Vector2 origin3 = ToLua.ToVector2(L, 1);
				Vector2 size3 = ToLua.ToVector2(L, 2);
				CapsuleDirection2D capsuleDirection3 = (CapsuleDirection2D)ToLua.CheckObject(L, 3, typeof(CapsuleDirection2D));
				float angle3 = (float)LuaDLL.luaL_checknumber(L, 4);
				Vector2 direction3 = ToLua.ToVector2(L, 5);
				float distance3 = (float)LuaDLL.luaL_checknumber(L, 6);
				int layerMask3 = (int)LuaDLL.luaL_checknumber(L, 7);
				RaycastHit2D[] array3 = Physics2D.CapsuleCastAll(origin3, size3, capsuleDirection3, angle3, direction3, distance3, layerMask3);
				ToLua.Push(L, array3);
				return 1;
			}
			case 8:
			{
				Vector2 origin2 = ToLua.ToVector2(L, 1);
				Vector2 size2 = ToLua.ToVector2(L, 2);
				CapsuleDirection2D capsuleDirection2 = (CapsuleDirection2D)ToLua.CheckObject(L, 3, typeof(CapsuleDirection2D));
				float angle2 = (float)LuaDLL.luaL_checknumber(L, 4);
				Vector2 direction2 = ToLua.ToVector2(L, 5);
				float distance2 = (float)LuaDLL.luaL_checknumber(L, 6);
				int layerMask2 = (int)LuaDLL.luaL_checknumber(L, 7);
				float minDepth2 = (float)LuaDLL.luaL_checknumber(L, 8);
				RaycastHit2D[] array2 = Physics2D.CapsuleCastAll(origin2, size2, capsuleDirection2, angle2, direction2, distance2, layerMask2, minDepth2);
				ToLua.Push(L, array2);
				return 1;
			}
			case 9:
			{
				Vector2 origin = ToLua.ToVector2(L, 1);
				Vector2 size = ToLua.ToVector2(L, 2);
				CapsuleDirection2D capsuleDirection = (CapsuleDirection2D)ToLua.CheckObject(L, 3, typeof(CapsuleDirection2D));
				float angle = (float)LuaDLL.luaL_checknumber(L, 4);
				Vector2 direction = ToLua.ToVector2(L, 5);
				float distance = (float)LuaDLL.luaL_checknumber(L, 6);
				int layerMask = (int)LuaDLL.luaL_checknumber(L, 7);
				float minDepth = (float)LuaDLL.luaL_checknumber(L, 8);
				float maxDepth = (float)LuaDLL.luaL_checknumber(L, 9);
				RaycastHit2D[] array = Physics2D.CapsuleCastAll(origin, size, capsuleDirection, angle, direction, distance, layerMask, minDepth, maxDepth);
				ToLua.Push(L, array);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics2D.CapsuleCastAll");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CapsuleCastNonAlloc(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 6:
			{
				Vector2 origin5 = ToLua.ToVector2(L, 1);
				Vector2 size5 = ToLua.ToVector2(L, 2);
				CapsuleDirection2D capsuleDirection5 = (CapsuleDirection2D)ToLua.CheckObject(L, 3, typeof(CapsuleDirection2D));
				float angle5 = (float)LuaDLL.luaL_checknumber(L, 4);
				Vector2 direction5 = ToLua.ToVector2(L, 5);
				RaycastHit2D[] results5 = ToLua.CheckStructArray<RaycastHit2D>(L, 6);
				int n5 = Physics2D.CapsuleCastNonAlloc(origin5, size5, capsuleDirection5, angle5, direction5, results5);
				LuaDLL.lua_pushinteger(L, n5);
				return 1;
			}
			case 7:
			{
				Vector2 origin4 = ToLua.ToVector2(L, 1);
				Vector2 size4 = ToLua.ToVector2(L, 2);
				CapsuleDirection2D capsuleDirection4 = (CapsuleDirection2D)ToLua.CheckObject(L, 3, typeof(CapsuleDirection2D));
				float angle4 = (float)LuaDLL.luaL_checknumber(L, 4);
				Vector2 direction4 = ToLua.ToVector2(L, 5);
				RaycastHit2D[] results4 = ToLua.CheckStructArray<RaycastHit2D>(L, 6);
				float distance4 = (float)LuaDLL.luaL_checknumber(L, 7);
				int n4 = Physics2D.CapsuleCastNonAlloc(origin4, size4, capsuleDirection4, angle4, direction4, results4, distance4);
				LuaDLL.lua_pushinteger(L, n4);
				return 1;
			}
			case 8:
			{
				Vector2 origin3 = ToLua.ToVector2(L, 1);
				Vector2 size3 = ToLua.ToVector2(L, 2);
				CapsuleDirection2D capsuleDirection3 = (CapsuleDirection2D)ToLua.CheckObject(L, 3, typeof(CapsuleDirection2D));
				float angle3 = (float)LuaDLL.luaL_checknumber(L, 4);
				Vector2 direction3 = ToLua.ToVector2(L, 5);
				RaycastHit2D[] results3 = ToLua.CheckStructArray<RaycastHit2D>(L, 6);
				float distance3 = (float)LuaDLL.luaL_checknumber(L, 7);
				int layerMask3 = (int)LuaDLL.luaL_checknumber(L, 8);
				int n3 = Physics2D.CapsuleCastNonAlloc(origin3, size3, capsuleDirection3, angle3, direction3, results3, distance3, layerMask3);
				LuaDLL.lua_pushinteger(L, n3);
				return 1;
			}
			case 9:
			{
				Vector2 origin2 = ToLua.ToVector2(L, 1);
				Vector2 size2 = ToLua.ToVector2(L, 2);
				CapsuleDirection2D capsuleDirection2 = (CapsuleDirection2D)ToLua.CheckObject(L, 3, typeof(CapsuleDirection2D));
				float angle2 = (float)LuaDLL.luaL_checknumber(L, 4);
				Vector2 direction2 = ToLua.ToVector2(L, 5);
				RaycastHit2D[] results2 = ToLua.CheckStructArray<RaycastHit2D>(L, 6);
				float distance2 = (float)LuaDLL.luaL_checknumber(L, 7);
				int layerMask2 = (int)LuaDLL.luaL_checknumber(L, 8);
				float minDepth2 = (float)LuaDLL.luaL_checknumber(L, 9);
				int n2 = Physics2D.CapsuleCastNonAlloc(origin2, size2, capsuleDirection2, angle2, direction2, results2, distance2, layerMask2, minDepth2);
				LuaDLL.lua_pushinteger(L, n2);
				return 1;
			}
			case 10:
			{
				Vector2 origin = ToLua.ToVector2(L, 1);
				Vector2 size = ToLua.ToVector2(L, 2);
				CapsuleDirection2D capsuleDirection = (CapsuleDirection2D)ToLua.CheckObject(L, 3, typeof(CapsuleDirection2D));
				float angle = (float)LuaDLL.luaL_checknumber(L, 4);
				Vector2 direction = ToLua.ToVector2(L, 5);
				RaycastHit2D[] results = ToLua.CheckStructArray<RaycastHit2D>(L, 6);
				float distance = (float)LuaDLL.luaL_checknumber(L, 7);
				int layerMask = (int)LuaDLL.luaL_checknumber(L, 8);
				float minDepth = (float)LuaDLL.luaL_checknumber(L, 9);
				float maxDepth = (float)LuaDLL.luaL_checknumber(L, 10);
				int n = Physics2D.CapsuleCastNonAlloc(origin, size, capsuleDirection, angle, direction, results, distance, layerMask, minDepth, maxDepth);
				LuaDLL.lua_pushinteger(L, n);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics2D.CapsuleCastNonAlloc");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetRayIntersection(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				RaycastHit2D rayIntersection3 = Physics2D.GetRayIntersection(ToLua.ToRay(L, 1));
				ToLua.PushValue(L, rayIntersection3);
				return 1;
			}
			case 2:
			{
				Ray ray2 = ToLua.ToRay(L, 1);
				float distance2 = (float)LuaDLL.luaL_checknumber(L, 2);
				RaycastHit2D rayIntersection2 = Physics2D.GetRayIntersection(ray2, distance2);
				ToLua.PushValue(L, rayIntersection2);
				return 1;
			}
			case 3:
			{
				Ray ray = ToLua.ToRay(L, 1);
				float distance = (float)LuaDLL.luaL_checknumber(L, 2);
				int layerMask = (int)LuaDLL.luaL_checknumber(L, 3);
				RaycastHit2D rayIntersection = Physics2D.GetRayIntersection(ray, distance, layerMask);
				ToLua.PushValue(L, rayIntersection);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics2D.GetRayIntersection");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetRayIntersectionAll(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				RaycastHit2D[] rayIntersectionAll3 = Physics2D.GetRayIntersectionAll(ToLua.ToRay(L, 1));
				ToLua.Push(L, rayIntersectionAll3);
				return 1;
			}
			case 2:
			{
				Ray ray2 = ToLua.ToRay(L, 1);
				float distance2 = (float)LuaDLL.luaL_checknumber(L, 2);
				RaycastHit2D[] rayIntersectionAll2 = Physics2D.GetRayIntersectionAll(ray2, distance2);
				ToLua.Push(L, rayIntersectionAll2);
				return 1;
			}
			case 3:
			{
				Ray ray = ToLua.ToRay(L, 1);
				float distance = (float)LuaDLL.luaL_checknumber(L, 2);
				int layerMask = (int)LuaDLL.luaL_checknumber(L, 3);
				RaycastHit2D[] rayIntersectionAll = Physics2D.GetRayIntersectionAll(ray, distance, layerMask);
				ToLua.Push(L, rayIntersectionAll);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics2D.GetRayIntersectionAll");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetRayIntersectionNonAlloc(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Ray ray3 = ToLua.ToRay(L, 1);
				RaycastHit2D[] results3 = ToLua.CheckStructArray<RaycastHit2D>(L, 2);
				int rayIntersectionNonAlloc3 = Physics2D.GetRayIntersectionNonAlloc(ray3, results3);
				LuaDLL.lua_pushinteger(L, rayIntersectionNonAlloc3);
				return 1;
			}
			case 3:
			{
				Ray ray2 = ToLua.ToRay(L, 1);
				RaycastHit2D[] results2 = ToLua.CheckStructArray<RaycastHit2D>(L, 2);
				float distance2 = (float)LuaDLL.luaL_checknumber(L, 3);
				int rayIntersectionNonAlloc2 = Physics2D.GetRayIntersectionNonAlloc(ray2, results2, distance2);
				LuaDLL.lua_pushinteger(L, rayIntersectionNonAlloc2);
				return 1;
			}
			case 4:
			{
				Ray ray = ToLua.ToRay(L, 1);
				RaycastHit2D[] results = ToLua.CheckStructArray<RaycastHit2D>(L, 2);
				float distance = (float)LuaDLL.luaL_checknumber(L, 3);
				int layerMask = (int)LuaDLL.luaL_checknumber(L, 4);
				int rayIntersectionNonAlloc = Physics2D.GetRayIntersectionNonAlloc(ray, results, distance, layerMask);
				LuaDLL.lua_pushinteger(L, rayIntersectionNonAlloc);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics2D.GetRayIntersectionNonAlloc");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OverlapPoint(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			switch (num)
			{
			case 1:
			{
				Collider2D obj2 = Physics2D.OverlapPoint(ToLua.ToVector2(L, 1));
				ToLua.Push(L, obj2);
				return 1;
			}
			case 2:
			{
				Vector2 point2 = ToLua.ToVector2(L, 1);
				int layerMask2 = (int)LuaDLL.luaL_checknumber(L, 2);
				Collider2D obj3 = Physics2D.OverlapPoint(point2, layerMask2);
				ToLua.Push(L, obj3);
				return 1;
			}
			case 3:
				if (TypeChecker.CheckTypes<int, float>(L, 2))
				{
					Vector2 point = ToLua.ToVector2(L, 1);
					int layerMask = (int)LuaDLL.lua_tonumber(L, 2);
					float minDepth = (float)LuaDLL.lua_tonumber(L, 3);
					Collider2D obj = Physics2D.OverlapPoint(point, layerMask, minDepth);
					ToLua.Push(L, obj);
					return 1;
				}
				break;
			}
			if (num == 3 && TypeChecker.CheckTypes<ContactFilter2D, Collider2D[]>(L, 2))
			{
				Vector2 point3 = ToLua.ToVector2(L, 1);
				ContactFilter2D contactFilter = StackTraits<ContactFilter2D>.To(L, 2);
				Collider2D[] results = ToLua.ToObjectArray<Collider2D>(L, 3);
				int n = Physics2D.OverlapPoint(point3, contactFilter, results);
				LuaDLL.lua_pushinteger(L, n);
				return 1;
			}
			if (num == 4)
			{
				Vector2 point4 = ToLua.ToVector2(L, 1);
				int layerMask3 = (int)LuaDLL.luaL_checknumber(L, 2);
				float minDepth2 = (float)LuaDLL.luaL_checknumber(L, 3);
				float maxDepth = (float)LuaDLL.luaL_checknumber(L, 4);
				Collider2D obj4 = Physics2D.OverlapPoint(point4, layerMask3, minDepth2, maxDepth);
				ToLua.Push(L, obj4);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics2D.OverlapPoint");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OverlapPointAll(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				Collider2D[] array4 = Physics2D.OverlapPointAll(ToLua.ToVector2(L, 1));
				ToLua.Push(L, array4);
				return 1;
			}
			case 2:
			{
				Vector2 point3 = ToLua.ToVector2(L, 1);
				int layerMask3 = (int)LuaDLL.luaL_checknumber(L, 2);
				Collider2D[] array3 = Physics2D.OverlapPointAll(point3, layerMask3);
				ToLua.Push(L, array3);
				return 1;
			}
			case 3:
			{
				Vector2 point2 = ToLua.ToVector2(L, 1);
				int layerMask2 = (int)LuaDLL.luaL_checknumber(L, 2);
				float minDepth2 = (float)LuaDLL.luaL_checknumber(L, 3);
				Collider2D[] array2 = Physics2D.OverlapPointAll(point2, layerMask2, minDepth2);
				ToLua.Push(L, array2);
				return 1;
			}
			case 4:
			{
				Vector2 point = ToLua.ToVector2(L, 1);
				int layerMask = (int)LuaDLL.luaL_checknumber(L, 2);
				float minDepth = (float)LuaDLL.luaL_checknumber(L, 3);
				float maxDepth = (float)LuaDLL.luaL_checknumber(L, 4);
				Collider2D[] array = Physics2D.OverlapPointAll(point, layerMask, minDepth, maxDepth);
				ToLua.Push(L, array);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics2D.OverlapPointAll");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OverlapPointNonAlloc(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Vector2 point4 = ToLua.ToVector2(L, 1);
				Collider2D[] results4 = ToLua.CheckObjectArray<Collider2D>(L, 2);
				int n4 = Physics2D.OverlapPointNonAlloc(point4, results4);
				LuaDLL.lua_pushinteger(L, n4);
				return 1;
			}
			case 3:
			{
				Vector2 point3 = ToLua.ToVector2(L, 1);
				Collider2D[] results3 = ToLua.CheckObjectArray<Collider2D>(L, 2);
				int layerMask3 = (int)LuaDLL.luaL_checknumber(L, 3);
				int n3 = Physics2D.OverlapPointNonAlloc(point3, results3, layerMask3);
				LuaDLL.lua_pushinteger(L, n3);
				return 1;
			}
			case 4:
			{
				Vector2 point2 = ToLua.ToVector2(L, 1);
				Collider2D[] results2 = ToLua.CheckObjectArray<Collider2D>(L, 2);
				int layerMask2 = (int)LuaDLL.luaL_checknumber(L, 3);
				float minDepth2 = (float)LuaDLL.luaL_checknumber(L, 4);
				int n2 = Physics2D.OverlapPointNonAlloc(point2, results2, layerMask2, minDepth2);
				LuaDLL.lua_pushinteger(L, n2);
				return 1;
			}
			case 5:
			{
				Vector2 point = ToLua.ToVector2(L, 1);
				Collider2D[] results = ToLua.CheckObjectArray<Collider2D>(L, 2);
				int layerMask = (int)LuaDLL.luaL_checknumber(L, 3);
				float minDepth = (float)LuaDLL.luaL_checknumber(L, 4);
				float maxDepth = (float)LuaDLL.luaL_checknumber(L, 5);
				int n = Physics2D.OverlapPointNonAlloc(point, results, layerMask, minDepth, maxDepth);
				LuaDLL.lua_pushinteger(L, n);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics2D.OverlapPointNonAlloc");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OverlapCircle(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			switch (num)
			{
			case 2:
			{
				Vector2 point2 = ToLua.ToVector2(L, 1);
				float radius2 = (float)LuaDLL.luaL_checknumber(L, 2);
				Collider2D obj2 = Physics2D.OverlapCircle(point2, radius2);
				ToLua.Push(L, obj2);
				return 1;
			}
			case 3:
			{
				Vector2 point3 = ToLua.ToVector2(L, 1);
				float radius3 = (float)LuaDLL.luaL_checknumber(L, 2);
				int layerMask2 = (int)LuaDLL.luaL_checknumber(L, 3);
				Collider2D obj3 = Physics2D.OverlapCircle(point3, radius3, layerMask2);
				ToLua.Push(L, obj3);
				return 1;
			}
			case 4:
				if (TypeChecker.CheckTypes<int, float>(L, 3))
				{
					Vector2 point = ToLua.ToVector2(L, 1);
					float radius = (float)LuaDLL.luaL_checknumber(L, 2);
					int layerMask = (int)LuaDLL.lua_tonumber(L, 3);
					float minDepth = (float)LuaDLL.lua_tonumber(L, 4);
					Collider2D obj = Physics2D.OverlapCircle(point, radius, layerMask, minDepth);
					ToLua.Push(L, obj);
					return 1;
				}
				break;
			}
			if (num == 4 && TypeChecker.CheckTypes<ContactFilter2D, Collider2D[]>(L, 3))
			{
				Vector2 point4 = ToLua.ToVector2(L, 1);
				float radius4 = (float)LuaDLL.luaL_checknumber(L, 2);
				ContactFilter2D contactFilter = StackTraits<ContactFilter2D>.To(L, 3);
				Collider2D[] results = ToLua.ToObjectArray<Collider2D>(L, 4);
				int n = Physics2D.OverlapCircle(point4, radius4, contactFilter, results);
				LuaDLL.lua_pushinteger(L, n);
				return 1;
			}
			if (num == 5)
			{
				Vector2 point5 = ToLua.ToVector2(L, 1);
				float radius5 = (float)LuaDLL.luaL_checknumber(L, 2);
				int layerMask3 = (int)LuaDLL.luaL_checknumber(L, 3);
				float minDepth2 = (float)LuaDLL.luaL_checknumber(L, 4);
				float maxDepth = (float)LuaDLL.luaL_checknumber(L, 5);
				Collider2D obj4 = Physics2D.OverlapCircle(point5, radius5, layerMask3, minDepth2, maxDepth);
				ToLua.Push(L, obj4);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics2D.OverlapCircle");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OverlapCircleAll(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Vector2 point4 = ToLua.ToVector2(L, 1);
				float radius4 = (float)LuaDLL.luaL_checknumber(L, 2);
				Collider2D[] array4 = Physics2D.OverlapCircleAll(point4, radius4);
				ToLua.Push(L, array4);
				return 1;
			}
			case 3:
			{
				Vector2 point3 = ToLua.ToVector2(L, 1);
				float radius3 = (float)LuaDLL.luaL_checknumber(L, 2);
				int layerMask3 = (int)LuaDLL.luaL_checknumber(L, 3);
				Collider2D[] array3 = Physics2D.OverlapCircleAll(point3, radius3, layerMask3);
				ToLua.Push(L, array3);
				return 1;
			}
			case 4:
			{
				Vector2 point2 = ToLua.ToVector2(L, 1);
				float radius2 = (float)LuaDLL.luaL_checknumber(L, 2);
				int layerMask2 = (int)LuaDLL.luaL_checknumber(L, 3);
				float minDepth2 = (float)LuaDLL.luaL_checknumber(L, 4);
				Collider2D[] array2 = Physics2D.OverlapCircleAll(point2, radius2, layerMask2, minDepth2);
				ToLua.Push(L, array2);
				return 1;
			}
			case 5:
			{
				Vector2 point = ToLua.ToVector2(L, 1);
				float radius = (float)LuaDLL.luaL_checknumber(L, 2);
				int layerMask = (int)LuaDLL.luaL_checknumber(L, 3);
				float minDepth = (float)LuaDLL.luaL_checknumber(L, 4);
				float maxDepth = (float)LuaDLL.luaL_checknumber(L, 5);
				Collider2D[] array = Physics2D.OverlapCircleAll(point, radius, layerMask, minDepth, maxDepth);
				ToLua.Push(L, array);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics2D.OverlapCircleAll");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OverlapCircleNonAlloc(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				Vector2 point4 = ToLua.ToVector2(L, 1);
				float radius4 = (float)LuaDLL.luaL_checknumber(L, 2);
				Collider2D[] results4 = ToLua.CheckObjectArray<Collider2D>(L, 3);
				int n4 = Physics2D.OverlapCircleNonAlloc(point4, radius4, results4);
				LuaDLL.lua_pushinteger(L, n4);
				return 1;
			}
			case 4:
			{
				Vector2 point3 = ToLua.ToVector2(L, 1);
				float radius3 = (float)LuaDLL.luaL_checknumber(L, 2);
				Collider2D[] results3 = ToLua.CheckObjectArray<Collider2D>(L, 3);
				int layerMask3 = (int)LuaDLL.luaL_checknumber(L, 4);
				int n3 = Physics2D.OverlapCircleNonAlloc(point3, radius3, results3, layerMask3);
				LuaDLL.lua_pushinteger(L, n3);
				return 1;
			}
			case 5:
			{
				Vector2 point2 = ToLua.ToVector2(L, 1);
				float radius2 = (float)LuaDLL.luaL_checknumber(L, 2);
				Collider2D[] results2 = ToLua.CheckObjectArray<Collider2D>(L, 3);
				int layerMask2 = (int)LuaDLL.luaL_checknumber(L, 4);
				float minDepth2 = (float)LuaDLL.luaL_checknumber(L, 5);
				int n2 = Physics2D.OverlapCircleNonAlloc(point2, radius2, results2, layerMask2, minDepth2);
				LuaDLL.lua_pushinteger(L, n2);
				return 1;
			}
			case 6:
			{
				Vector2 point = ToLua.ToVector2(L, 1);
				float radius = (float)LuaDLL.luaL_checknumber(L, 2);
				Collider2D[] results = ToLua.CheckObjectArray<Collider2D>(L, 3);
				int layerMask = (int)LuaDLL.luaL_checknumber(L, 4);
				float minDepth = (float)LuaDLL.luaL_checknumber(L, 5);
				float maxDepth = (float)LuaDLL.luaL_checknumber(L, 6);
				int n = Physics2D.OverlapCircleNonAlloc(point, radius, results, layerMask, minDepth, maxDepth);
				LuaDLL.lua_pushinteger(L, n);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics2D.OverlapCircleNonAlloc");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OverlapBox(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			switch (num)
			{
			case 3:
			{
				Vector2 point2 = ToLua.ToVector2(L, 1);
				Vector2 size2 = ToLua.ToVector2(L, 2);
				float angle2 = (float)LuaDLL.luaL_checknumber(L, 3);
				Collider2D obj2 = Physics2D.OverlapBox(point2, size2, angle2);
				ToLua.Push(L, obj2);
				return 1;
			}
			case 4:
			{
				Vector2 point3 = ToLua.ToVector2(L, 1);
				Vector2 size3 = ToLua.ToVector2(L, 2);
				float angle3 = (float)LuaDLL.luaL_checknumber(L, 3);
				int layerMask2 = (int)LuaDLL.luaL_checknumber(L, 4);
				Collider2D obj3 = Physics2D.OverlapBox(point3, size3, angle3, layerMask2);
				ToLua.Push(L, obj3);
				return 1;
			}
			case 5:
				if (TypeChecker.CheckTypes<int, float>(L, 4))
				{
					Vector2 point = ToLua.ToVector2(L, 1);
					Vector2 size = ToLua.ToVector2(L, 2);
					float angle = (float)LuaDLL.luaL_checknumber(L, 3);
					int layerMask = (int)LuaDLL.lua_tonumber(L, 4);
					float minDepth = (float)LuaDLL.lua_tonumber(L, 5);
					Collider2D obj = Physics2D.OverlapBox(point, size, angle, layerMask, minDepth);
					ToLua.Push(L, obj);
					return 1;
				}
				break;
			}
			if (num == 5 && TypeChecker.CheckTypes<ContactFilter2D, Collider2D[]>(L, 4))
			{
				Vector2 point4 = ToLua.ToVector2(L, 1);
				Vector2 size4 = ToLua.ToVector2(L, 2);
				float angle4 = (float)LuaDLL.luaL_checknumber(L, 3);
				ContactFilter2D contactFilter = StackTraits<ContactFilter2D>.To(L, 4);
				Collider2D[] results = ToLua.ToObjectArray<Collider2D>(L, 5);
				int n = Physics2D.OverlapBox(point4, size4, angle4, contactFilter, results);
				LuaDLL.lua_pushinteger(L, n);
				return 1;
			}
			if (num == 6)
			{
				Vector2 point5 = ToLua.ToVector2(L, 1);
				Vector2 size5 = ToLua.ToVector2(L, 2);
				float angle5 = (float)LuaDLL.luaL_checknumber(L, 3);
				int layerMask3 = (int)LuaDLL.luaL_checknumber(L, 4);
				float minDepth2 = (float)LuaDLL.luaL_checknumber(L, 5);
				float maxDepth = (float)LuaDLL.luaL_checknumber(L, 6);
				Collider2D obj4 = Physics2D.OverlapBox(point5, size5, angle5, layerMask3, minDepth2, maxDepth);
				ToLua.Push(L, obj4);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics2D.OverlapBox");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OverlapBoxAll(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				Vector2 point4 = ToLua.ToVector2(L, 1);
				Vector2 size4 = ToLua.ToVector2(L, 2);
				float angle4 = (float)LuaDLL.luaL_checknumber(L, 3);
				Collider2D[] array4 = Physics2D.OverlapBoxAll(point4, size4, angle4);
				ToLua.Push(L, array4);
				return 1;
			}
			case 4:
			{
				Vector2 point3 = ToLua.ToVector2(L, 1);
				Vector2 size3 = ToLua.ToVector2(L, 2);
				float angle3 = (float)LuaDLL.luaL_checknumber(L, 3);
				int layerMask3 = (int)LuaDLL.luaL_checknumber(L, 4);
				Collider2D[] array3 = Physics2D.OverlapBoxAll(point3, size3, angle3, layerMask3);
				ToLua.Push(L, array3);
				return 1;
			}
			case 5:
			{
				Vector2 point2 = ToLua.ToVector2(L, 1);
				Vector2 size2 = ToLua.ToVector2(L, 2);
				float angle2 = (float)LuaDLL.luaL_checknumber(L, 3);
				int layerMask2 = (int)LuaDLL.luaL_checknumber(L, 4);
				float minDepth2 = (float)LuaDLL.luaL_checknumber(L, 5);
				Collider2D[] array2 = Physics2D.OverlapBoxAll(point2, size2, angle2, layerMask2, minDepth2);
				ToLua.Push(L, array2);
				return 1;
			}
			case 6:
			{
				Vector2 point = ToLua.ToVector2(L, 1);
				Vector2 size = ToLua.ToVector2(L, 2);
				float angle = (float)LuaDLL.luaL_checknumber(L, 3);
				int layerMask = (int)LuaDLL.luaL_checknumber(L, 4);
				float minDepth = (float)LuaDLL.luaL_checknumber(L, 5);
				float maxDepth = (float)LuaDLL.luaL_checknumber(L, 6);
				Collider2D[] array = Physics2D.OverlapBoxAll(point, size, angle, layerMask, minDepth, maxDepth);
				ToLua.Push(L, array);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics2D.OverlapBoxAll");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OverlapBoxNonAlloc(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 4:
			{
				Vector2 point4 = ToLua.ToVector2(L, 1);
				Vector2 size4 = ToLua.ToVector2(L, 2);
				float angle4 = (float)LuaDLL.luaL_checknumber(L, 3);
				Collider2D[] results4 = ToLua.CheckObjectArray<Collider2D>(L, 4);
				int n4 = Physics2D.OverlapBoxNonAlloc(point4, size4, angle4, results4);
				LuaDLL.lua_pushinteger(L, n4);
				return 1;
			}
			case 5:
			{
				Vector2 point3 = ToLua.ToVector2(L, 1);
				Vector2 size3 = ToLua.ToVector2(L, 2);
				float angle3 = (float)LuaDLL.luaL_checknumber(L, 3);
				Collider2D[] results3 = ToLua.CheckObjectArray<Collider2D>(L, 4);
				int layerMask3 = (int)LuaDLL.luaL_checknumber(L, 5);
				int n3 = Physics2D.OverlapBoxNonAlloc(point3, size3, angle3, results3, layerMask3);
				LuaDLL.lua_pushinteger(L, n3);
				return 1;
			}
			case 6:
			{
				Vector2 point2 = ToLua.ToVector2(L, 1);
				Vector2 size2 = ToLua.ToVector2(L, 2);
				float angle2 = (float)LuaDLL.luaL_checknumber(L, 3);
				Collider2D[] results2 = ToLua.CheckObjectArray<Collider2D>(L, 4);
				int layerMask2 = (int)LuaDLL.luaL_checknumber(L, 5);
				float minDepth2 = (float)LuaDLL.luaL_checknumber(L, 6);
				int n2 = Physics2D.OverlapBoxNonAlloc(point2, size2, angle2, results2, layerMask2, minDepth2);
				LuaDLL.lua_pushinteger(L, n2);
				return 1;
			}
			case 7:
			{
				Vector2 point = ToLua.ToVector2(L, 1);
				Vector2 size = ToLua.ToVector2(L, 2);
				float angle = (float)LuaDLL.luaL_checknumber(L, 3);
				Collider2D[] results = ToLua.CheckObjectArray<Collider2D>(L, 4);
				int layerMask = (int)LuaDLL.luaL_checknumber(L, 5);
				float minDepth = (float)LuaDLL.luaL_checknumber(L, 6);
				float maxDepth = (float)LuaDLL.luaL_checknumber(L, 7);
				int n = Physics2D.OverlapBoxNonAlloc(point, size, angle, results, layerMask, minDepth, maxDepth);
				LuaDLL.lua_pushinteger(L, n);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics2D.OverlapBoxNonAlloc");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OverlapArea(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			switch (num)
			{
			case 2:
			{
				Vector2 pointA2 = ToLua.ToVector2(L, 1);
				Vector2 pointB2 = ToLua.ToVector2(L, 2);
				Collider2D obj2 = Physics2D.OverlapArea(pointA2, pointB2);
				ToLua.Push(L, obj2);
				return 1;
			}
			case 3:
			{
				Vector2 pointA3 = ToLua.ToVector2(L, 1);
				Vector2 pointB3 = ToLua.ToVector2(L, 2);
				int layerMask2 = (int)LuaDLL.luaL_checknumber(L, 3);
				Collider2D obj3 = Physics2D.OverlapArea(pointA3, pointB3, layerMask2);
				ToLua.Push(L, obj3);
				return 1;
			}
			case 4:
				if (TypeChecker.CheckTypes<int, float>(L, 3))
				{
					Vector2 pointA = ToLua.ToVector2(L, 1);
					Vector2 pointB = ToLua.ToVector2(L, 2);
					int layerMask = (int)LuaDLL.lua_tonumber(L, 3);
					float minDepth = (float)LuaDLL.lua_tonumber(L, 4);
					Collider2D obj = Physics2D.OverlapArea(pointA, pointB, layerMask, minDepth);
					ToLua.Push(L, obj);
					return 1;
				}
				break;
			}
			if (num == 4 && TypeChecker.CheckTypes<ContactFilter2D, Collider2D[]>(L, 3))
			{
				Vector2 pointA4 = ToLua.ToVector2(L, 1);
				Vector2 pointB4 = ToLua.ToVector2(L, 2);
				ContactFilter2D contactFilter = StackTraits<ContactFilter2D>.To(L, 3);
				Collider2D[] results = ToLua.ToObjectArray<Collider2D>(L, 4);
				int n = Physics2D.OverlapArea(pointA4, pointB4, contactFilter, results);
				LuaDLL.lua_pushinteger(L, n);
				return 1;
			}
			if (num == 5)
			{
				Vector2 pointA5 = ToLua.ToVector2(L, 1);
				Vector2 pointB5 = ToLua.ToVector2(L, 2);
				int layerMask3 = (int)LuaDLL.luaL_checknumber(L, 3);
				float minDepth2 = (float)LuaDLL.luaL_checknumber(L, 4);
				float maxDepth = (float)LuaDLL.luaL_checknumber(L, 5);
				Collider2D obj4 = Physics2D.OverlapArea(pointA5, pointB5, layerMask3, minDepth2, maxDepth);
				ToLua.Push(L, obj4);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics2D.OverlapArea");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OverlapAreaAll(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Vector2 pointA4 = ToLua.ToVector2(L, 1);
				Vector2 pointB4 = ToLua.ToVector2(L, 2);
				Collider2D[] array4 = Physics2D.OverlapAreaAll(pointA4, pointB4);
				ToLua.Push(L, array4);
				return 1;
			}
			case 3:
			{
				Vector2 pointA3 = ToLua.ToVector2(L, 1);
				Vector2 pointB3 = ToLua.ToVector2(L, 2);
				int layerMask3 = (int)LuaDLL.luaL_checknumber(L, 3);
				Collider2D[] array3 = Physics2D.OverlapAreaAll(pointA3, pointB3, layerMask3);
				ToLua.Push(L, array3);
				return 1;
			}
			case 4:
			{
				Vector2 pointA2 = ToLua.ToVector2(L, 1);
				Vector2 pointB2 = ToLua.ToVector2(L, 2);
				int layerMask2 = (int)LuaDLL.luaL_checknumber(L, 3);
				float minDepth2 = (float)LuaDLL.luaL_checknumber(L, 4);
				Collider2D[] array2 = Physics2D.OverlapAreaAll(pointA2, pointB2, layerMask2, minDepth2);
				ToLua.Push(L, array2);
				return 1;
			}
			case 5:
			{
				Vector2 pointA = ToLua.ToVector2(L, 1);
				Vector2 pointB = ToLua.ToVector2(L, 2);
				int layerMask = (int)LuaDLL.luaL_checknumber(L, 3);
				float minDepth = (float)LuaDLL.luaL_checknumber(L, 4);
				float maxDepth = (float)LuaDLL.luaL_checknumber(L, 5);
				Collider2D[] array = Physics2D.OverlapAreaAll(pointA, pointB, layerMask, minDepth, maxDepth);
				ToLua.Push(L, array);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics2D.OverlapAreaAll");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OverlapAreaNonAlloc(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				Vector2 pointA4 = ToLua.ToVector2(L, 1);
				Vector2 pointB4 = ToLua.ToVector2(L, 2);
				Collider2D[] results4 = ToLua.CheckObjectArray<Collider2D>(L, 3);
				int n4 = Physics2D.OverlapAreaNonAlloc(pointA4, pointB4, results4);
				LuaDLL.lua_pushinteger(L, n4);
				return 1;
			}
			case 4:
			{
				Vector2 pointA3 = ToLua.ToVector2(L, 1);
				Vector2 pointB3 = ToLua.ToVector2(L, 2);
				Collider2D[] results3 = ToLua.CheckObjectArray<Collider2D>(L, 3);
				int layerMask3 = (int)LuaDLL.luaL_checknumber(L, 4);
				int n3 = Physics2D.OverlapAreaNonAlloc(pointA3, pointB3, results3, layerMask3);
				LuaDLL.lua_pushinteger(L, n3);
				return 1;
			}
			case 5:
			{
				Vector2 pointA2 = ToLua.ToVector2(L, 1);
				Vector2 pointB2 = ToLua.ToVector2(L, 2);
				Collider2D[] results2 = ToLua.CheckObjectArray<Collider2D>(L, 3);
				int layerMask2 = (int)LuaDLL.luaL_checknumber(L, 4);
				float minDepth2 = (float)LuaDLL.luaL_checknumber(L, 5);
				int n2 = Physics2D.OverlapAreaNonAlloc(pointA2, pointB2, results2, layerMask2, minDepth2);
				LuaDLL.lua_pushinteger(L, n2);
				return 1;
			}
			case 6:
			{
				Vector2 pointA = ToLua.ToVector2(L, 1);
				Vector2 pointB = ToLua.ToVector2(L, 2);
				Collider2D[] results = ToLua.CheckObjectArray<Collider2D>(L, 3);
				int layerMask = (int)LuaDLL.luaL_checknumber(L, 4);
				float minDepth = (float)LuaDLL.luaL_checknumber(L, 5);
				float maxDepth = (float)LuaDLL.luaL_checknumber(L, 6);
				int n = Physics2D.OverlapAreaNonAlloc(pointA, pointB, results, layerMask, minDepth, maxDepth);
				LuaDLL.lua_pushinteger(L, n);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics2D.OverlapAreaNonAlloc");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OverlapCapsule(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			switch (num)
			{
			case 4:
			{
				Vector2 point2 = ToLua.ToVector2(L, 1);
				Vector2 size2 = ToLua.ToVector2(L, 2);
				CapsuleDirection2D direction2 = (CapsuleDirection2D)ToLua.CheckObject(L, 3, typeof(CapsuleDirection2D));
				float angle2 = (float)LuaDLL.luaL_checknumber(L, 4);
				Collider2D obj2 = Physics2D.OverlapCapsule(point2, size2, direction2, angle2);
				ToLua.Push(L, obj2);
				return 1;
			}
			case 5:
			{
				Vector2 point3 = ToLua.ToVector2(L, 1);
				Vector2 size3 = ToLua.ToVector2(L, 2);
				CapsuleDirection2D direction3 = (CapsuleDirection2D)ToLua.CheckObject(L, 3, typeof(CapsuleDirection2D));
				float angle3 = (float)LuaDLL.luaL_checknumber(L, 4);
				int layerMask2 = (int)LuaDLL.luaL_checknumber(L, 5);
				Collider2D obj3 = Physics2D.OverlapCapsule(point3, size3, direction3, angle3, layerMask2);
				ToLua.Push(L, obj3);
				return 1;
			}
			case 6:
				if (TypeChecker.CheckTypes<int, float>(L, 5))
				{
					Vector2 point = ToLua.ToVector2(L, 1);
					Vector2 size = ToLua.ToVector2(L, 2);
					CapsuleDirection2D direction = (CapsuleDirection2D)ToLua.CheckObject(L, 3, typeof(CapsuleDirection2D));
					float angle = (float)LuaDLL.luaL_checknumber(L, 4);
					int layerMask = (int)LuaDLL.lua_tonumber(L, 5);
					float minDepth = (float)LuaDLL.lua_tonumber(L, 6);
					Collider2D obj = Physics2D.OverlapCapsule(point, size, direction, angle, layerMask, minDepth);
					ToLua.Push(L, obj);
					return 1;
				}
				break;
			}
			if (num == 6 && TypeChecker.CheckTypes<ContactFilter2D, Collider2D[]>(L, 5))
			{
				Vector2 point4 = ToLua.ToVector2(L, 1);
				Vector2 size4 = ToLua.ToVector2(L, 2);
				CapsuleDirection2D direction4 = (CapsuleDirection2D)ToLua.CheckObject(L, 3, typeof(CapsuleDirection2D));
				float angle4 = (float)LuaDLL.luaL_checknumber(L, 4);
				ContactFilter2D contactFilter = StackTraits<ContactFilter2D>.To(L, 5);
				Collider2D[] results = ToLua.ToObjectArray<Collider2D>(L, 6);
				int n = Physics2D.OverlapCapsule(point4, size4, direction4, angle4, contactFilter, results);
				LuaDLL.lua_pushinteger(L, n);
				return 1;
			}
			if (num == 7)
			{
				Vector2 point5 = ToLua.ToVector2(L, 1);
				Vector2 size5 = ToLua.ToVector2(L, 2);
				CapsuleDirection2D direction5 = (CapsuleDirection2D)ToLua.CheckObject(L, 3, typeof(CapsuleDirection2D));
				float angle5 = (float)LuaDLL.luaL_checknumber(L, 4);
				int layerMask3 = (int)LuaDLL.luaL_checknumber(L, 5);
				float minDepth2 = (float)LuaDLL.luaL_checknumber(L, 6);
				float maxDepth = (float)LuaDLL.luaL_checknumber(L, 7);
				Collider2D obj4 = Physics2D.OverlapCapsule(point5, size5, direction5, angle5, layerMask3, minDepth2, maxDepth);
				ToLua.Push(L, obj4);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics2D.OverlapCapsule");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OverlapCapsuleAll(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 4:
			{
				Vector2 point4 = ToLua.ToVector2(L, 1);
				Vector2 size4 = ToLua.ToVector2(L, 2);
				CapsuleDirection2D direction4 = (CapsuleDirection2D)ToLua.CheckObject(L, 3, typeof(CapsuleDirection2D));
				float angle4 = (float)LuaDLL.luaL_checknumber(L, 4);
				Collider2D[] array4 = Physics2D.OverlapCapsuleAll(point4, size4, direction4, angle4);
				ToLua.Push(L, array4);
				return 1;
			}
			case 5:
			{
				Vector2 point3 = ToLua.ToVector2(L, 1);
				Vector2 size3 = ToLua.ToVector2(L, 2);
				CapsuleDirection2D direction3 = (CapsuleDirection2D)ToLua.CheckObject(L, 3, typeof(CapsuleDirection2D));
				float angle3 = (float)LuaDLL.luaL_checknumber(L, 4);
				int layerMask3 = (int)LuaDLL.luaL_checknumber(L, 5);
				Collider2D[] array3 = Physics2D.OverlapCapsuleAll(point3, size3, direction3, angle3, layerMask3);
				ToLua.Push(L, array3);
				return 1;
			}
			case 6:
			{
				Vector2 point2 = ToLua.ToVector2(L, 1);
				Vector2 size2 = ToLua.ToVector2(L, 2);
				CapsuleDirection2D direction2 = (CapsuleDirection2D)ToLua.CheckObject(L, 3, typeof(CapsuleDirection2D));
				float angle2 = (float)LuaDLL.luaL_checknumber(L, 4);
				int layerMask2 = (int)LuaDLL.luaL_checknumber(L, 5);
				float minDepth2 = (float)LuaDLL.luaL_checknumber(L, 6);
				Collider2D[] array2 = Physics2D.OverlapCapsuleAll(point2, size2, direction2, angle2, layerMask2, minDepth2);
				ToLua.Push(L, array2);
				return 1;
			}
			case 7:
			{
				Vector2 point = ToLua.ToVector2(L, 1);
				Vector2 size = ToLua.ToVector2(L, 2);
				CapsuleDirection2D direction = (CapsuleDirection2D)ToLua.CheckObject(L, 3, typeof(CapsuleDirection2D));
				float angle = (float)LuaDLL.luaL_checknumber(L, 4);
				int layerMask = (int)LuaDLL.luaL_checknumber(L, 5);
				float minDepth = (float)LuaDLL.luaL_checknumber(L, 6);
				float maxDepth = (float)LuaDLL.luaL_checknumber(L, 7);
				Collider2D[] array = Physics2D.OverlapCapsuleAll(point, size, direction, angle, layerMask, minDepth, maxDepth);
				ToLua.Push(L, array);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics2D.OverlapCapsuleAll");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OverlapCapsuleNonAlloc(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 5:
			{
				Vector2 point4 = ToLua.ToVector2(L, 1);
				Vector2 size4 = ToLua.ToVector2(L, 2);
				CapsuleDirection2D direction4 = (CapsuleDirection2D)ToLua.CheckObject(L, 3, typeof(CapsuleDirection2D));
				float angle4 = (float)LuaDLL.luaL_checknumber(L, 4);
				Collider2D[] results4 = ToLua.CheckObjectArray<Collider2D>(L, 5);
				int n4 = Physics2D.OverlapCapsuleNonAlloc(point4, size4, direction4, angle4, results4);
				LuaDLL.lua_pushinteger(L, n4);
				return 1;
			}
			case 6:
			{
				Vector2 point3 = ToLua.ToVector2(L, 1);
				Vector2 size3 = ToLua.ToVector2(L, 2);
				CapsuleDirection2D direction3 = (CapsuleDirection2D)ToLua.CheckObject(L, 3, typeof(CapsuleDirection2D));
				float angle3 = (float)LuaDLL.luaL_checknumber(L, 4);
				Collider2D[] results3 = ToLua.CheckObjectArray<Collider2D>(L, 5);
				int layerMask3 = (int)LuaDLL.luaL_checknumber(L, 6);
				int n3 = Physics2D.OverlapCapsuleNonAlloc(point3, size3, direction3, angle3, results3, layerMask3);
				LuaDLL.lua_pushinteger(L, n3);
				return 1;
			}
			case 7:
			{
				Vector2 point2 = ToLua.ToVector2(L, 1);
				Vector2 size2 = ToLua.ToVector2(L, 2);
				CapsuleDirection2D direction2 = (CapsuleDirection2D)ToLua.CheckObject(L, 3, typeof(CapsuleDirection2D));
				float angle2 = (float)LuaDLL.luaL_checknumber(L, 4);
				Collider2D[] results2 = ToLua.CheckObjectArray<Collider2D>(L, 5);
				int layerMask2 = (int)LuaDLL.luaL_checknumber(L, 6);
				float minDepth2 = (float)LuaDLL.luaL_checknumber(L, 7);
				int n2 = Physics2D.OverlapCapsuleNonAlloc(point2, size2, direction2, angle2, results2, layerMask2, minDepth2);
				LuaDLL.lua_pushinteger(L, n2);
				return 1;
			}
			case 8:
			{
				Vector2 point = ToLua.ToVector2(L, 1);
				Vector2 size = ToLua.ToVector2(L, 2);
				CapsuleDirection2D direction = (CapsuleDirection2D)ToLua.CheckObject(L, 3, typeof(CapsuleDirection2D));
				float angle = (float)LuaDLL.luaL_checknumber(L, 4);
				Collider2D[] results = ToLua.CheckObjectArray<Collider2D>(L, 5);
				int layerMask = (int)LuaDLL.luaL_checknumber(L, 6);
				float minDepth = (float)LuaDLL.luaL_checknumber(L, 7);
				float maxDepth = (float)LuaDLL.luaL_checknumber(L, 8);
				int n = Physics2D.OverlapCapsuleNonAlloc(point, size, direction, angle, results, layerMask, minDepth, maxDepth);
				LuaDLL.lua_pushinteger(L, n);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics2D.OverlapCapsuleNonAlloc");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OverlapCollider(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Collider2D collider = (Collider2D)ToLua.CheckObject<Collider2D>(L, 1);
			ContactFilter2D contactFilter = StackTraits<ContactFilter2D>.Check(L, 2);
			Collider2D[] results = ToLua.CheckObjectArray<Collider2D>(L, 3);
			int n = Physics2D.OverlapCollider(collider, contactFilter, results);
			LuaDLL.lua_pushinteger(L, n);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetContacts(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<Collider2D, ContactPoint2D[]>(L, 1))
			{
				Collider2D collider = (Collider2D)ToLua.ToObject(L, 1);
				ContactPoint2D[] contacts = ToLua.ToStructArray<ContactPoint2D>(L, 2);
				int contacts2 = Physics2D.GetContacts(collider, contacts);
				LuaDLL.lua_pushinteger(L, contacts2);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<Collider2D, Collider2D[]>(L, 1))
			{
				Collider2D collider2 = (Collider2D)ToLua.ToObject(L, 1);
				Collider2D[] colliders = ToLua.ToObjectArray<Collider2D>(L, 2);
				int contacts3 = Physics2D.GetContacts(collider2, colliders);
				LuaDLL.lua_pushinteger(L, contacts3);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<Rigidbody2D, ContactPoint2D[]>(L, 1))
			{
				Rigidbody2D rigidbody = (Rigidbody2D)ToLua.ToObject(L, 1);
				ContactPoint2D[] contacts4 = ToLua.ToStructArray<ContactPoint2D>(L, 2);
				int contacts5 = Physics2D.GetContacts(rigidbody, contacts4);
				LuaDLL.lua_pushinteger(L, contacts5);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<Rigidbody2D, Collider2D[]>(L, 1))
			{
				Rigidbody2D rigidbody2 = (Rigidbody2D)ToLua.ToObject(L, 1);
				Collider2D[] colliders2 = ToLua.ToObjectArray<Collider2D>(L, 2);
				int contacts6 = Physics2D.GetContacts(rigidbody2, colliders2);
				LuaDLL.lua_pushinteger(L, contacts6);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<Collider2D, ContactFilter2D, ContactPoint2D[]>(L, 1))
			{
				Collider2D collider3 = (Collider2D)ToLua.ToObject(L, 1);
				ContactFilter2D contactFilter = StackTraits<ContactFilter2D>.To(L, 2);
				ContactPoint2D[] contacts7 = ToLua.ToStructArray<ContactPoint2D>(L, 3);
				int contacts8 = Physics2D.GetContacts(collider3, contactFilter, contacts7);
				LuaDLL.lua_pushinteger(L, contacts8);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<Collider2D, ContactFilter2D, Collider2D[]>(L, 1))
			{
				Collider2D collider4 = (Collider2D)ToLua.ToObject(L, 1);
				ContactFilter2D contactFilter2 = StackTraits<ContactFilter2D>.To(L, 2);
				Collider2D[] colliders3 = ToLua.ToObjectArray<Collider2D>(L, 3);
				int contacts9 = Physics2D.GetContacts(collider4, contactFilter2, colliders3);
				LuaDLL.lua_pushinteger(L, contacts9);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<Rigidbody2D, ContactFilter2D, ContactPoint2D[]>(L, 1))
			{
				Rigidbody2D rigidbody3 = (Rigidbody2D)ToLua.ToObject(L, 1);
				ContactFilter2D contactFilter3 = StackTraits<ContactFilter2D>.To(L, 2);
				ContactPoint2D[] contacts10 = ToLua.ToStructArray<ContactPoint2D>(L, 3);
				int contacts11 = Physics2D.GetContacts(rigidbody3, contactFilter3, contacts10);
				LuaDLL.lua_pushinteger(L, contacts11);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<Rigidbody2D, ContactFilter2D, Collider2D[]>(L, 1))
			{
				Rigidbody2D rigidbody4 = (Rigidbody2D)ToLua.ToObject(L, 1);
				ContactFilter2D contactFilter4 = StackTraits<ContactFilter2D>.To(L, 2);
				Collider2D[] colliders4 = ToLua.ToObjectArray<Collider2D>(L, 3);
				int contacts12 = Physics2D.GetContacts(rigidbody4, contactFilter4, colliders4);
				LuaDLL.lua_pushinteger(L, contacts12);
				return 1;
			}
			if (num == 4)
			{
				Collider2D collider5 = (Collider2D)ToLua.CheckObject<Collider2D>(L, 1);
				Collider2D collider6 = (Collider2D)ToLua.CheckObject<Collider2D>(L, 2);
				ContactFilter2D contactFilter5 = StackTraits<ContactFilter2D>.Check(L, 3);
				ContactPoint2D[] contacts13 = ToLua.CheckStructArray<ContactPoint2D>(L, 4);
				int contacts14 = Physics2D.GetContacts(collider5, collider6, contactFilter5, contacts13);
				LuaDLL.lua_pushinteger(L, contacts14);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics2D.GetContacts");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_defaultPhysicsScene(IntPtr L)
	{
		try
		{
			ToLua.PushValue(L, Physics2D.defaultPhysicsScene);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_velocityIterations(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, Physics2D.velocityIterations);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_positionIterations(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, Physics2D.positionIterations);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_gravity(IntPtr L)
	{
		try
		{
			ToLua.Push(L, Physics2D.gravity);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_queriesHitTriggers(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, Physics2D.queriesHitTriggers);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_queriesStartInColliders(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, Physics2D.queriesStartInColliders);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_callbacksOnDisable(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, Physics2D.callbacksOnDisable);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_reuseCollisionCallbacks(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, Physics2D.reuseCollisionCallbacks);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_autoSyncTransforms(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, Physics2D.autoSyncTransforms);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_autoSimulation(IntPtr L)
	{
		try
		{
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_jobOptions(IntPtr L)
	{
		try
		{
			ToLua.PushValue(L, Physics2D.jobOptions);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_velocityThreshold(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, Physics2D.velocityThreshold);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maxLinearCorrection(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, Physics2D.maxLinearCorrection);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maxAngularCorrection(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, Physics2D.maxAngularCorrection);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maxTranslationSpeed(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, Physics2D.maxTranslationSpeed);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maxRotationSpeed(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, Physics2D.maxRotationSpeed);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_defaultContactOffset(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, Physics2D.defaultContactOffset);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_baumgarteScale(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, Physics2D.baumgarteScale);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_baumgarteTOIScale(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, Physics2D.baumgarteTOIScale);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_timeToSleep(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, Physics2D.timeToSleep);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_linearSleepTolerance(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, Physics2D.linearSleepTolerance);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_angularSleepTolerance(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, Physics2D.angularSleepTolerance);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_velocityIterations(IntPtr L)
	{
		try
		{
			Physics2D.velocityIterations = (int)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_positionIterations(IntPtr L)
	{
		try
		{
			Physics2D.positionIterations = (int)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_gravity(IntPtr L)
	{
		try
		{
			Physics2D.gravity = ToLua.ToVector2(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_queriesHitTriggers(IntPtr L)
	{
		try
		{
			Physics2D.queriesHitTriggers = LuaDLL.luaL_checkboolean(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_queriesStartInColliders(IntPtr L)
	{
		try
		{
			Physics2D.queriesStartInColliders = LuaDLL.luaL_checkboolean(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_callbacksOnDisable(IntPtr L)
	{
		try
		{
			Physics2D.callbacksOnDisable = LuaDLL.luaL_checkboolean(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_reuseCollisionCallbacks(IntPtr L)
	{
		try
		{
			Physics2D.reuseCollisionCallbacks = LuaDLL.luaL_checkboolean(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_autoSyncTransforms(IntPtr L)
	{
		try
		{
			Physics2D.autoSyncTransforms = LuaDLL.luaL_checkboolean(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_autoSimulation(IntPtr L)
	{
		try
		{
			LuaDLL.luaL_checkboolean(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_jobOptions(IntPtr L)
	{
		try
		{
			Physics2D.jobOptions = StackTraits<PhysicsJobOptions2D>.Check(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_velocityThreshold(IntPtr L)
	{
		try
		{
			Physics2D.velocityThreshold = (float)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_maxLinearCorrection(IntPtr L)
	{
		try
		{
			Physics2D.maxLinearCorrection = (float)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_maxAngularCorrection(IntPtr L)
	{
		try
		{
			Physics2D.maxAngularCorrection = (float)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_maxTranslationSpeed(IntPtr L)
	{
		try
		{
			Physics2D.maxTranslationSpeed = (float)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_maxRotationSpeed(IntPtr L)
	{
		try
		{
			Physics2D.maxRotationSpeed = (float)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_defaultContactOffset(IntPtr L)
	{
		try
		{
			Physics2D.defaultContactOffset = (float)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_baumgarteScale(IntPtr L)
	{
		try
		{
			Physics2D.baumgarteScale = (float)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_baumgarteTOIScale(IntPtr L)
	{
		try
		{
			Physics2D.baumgarteTOIScale = (float)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_timeToSleep(IntPtr L)
	{
		try
		{
			Physics2D.timeToSleep = (float)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_linearSleepTolerance(IntPtr L)
	{
		try
		{
			Physics2D.linearSleepTolerance = (float)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_angularSleepTolerance(IntPtr L)
	{
		try
		{
			Physics2D.angularSleepTolerance = (float)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
