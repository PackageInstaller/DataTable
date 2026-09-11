using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_PhysicsWrap
{
	public static void Register(LuaState L)
	{
		L.BeginStaticLibs("Physics");
		L.RegFunction("IgnoreCollision", IgnoreCollision);
		L.RegFunction("IgnoreLayerCollision", IgnoreLayerCollision);
		L.RegFunction("GetIgnoreLayerCollision", GetIgnoreLayerCollision);
		L.RegFunction("Raycast", Raycast);
		L.RegFunction("Linecast", Linecast);
		L.RegFunction("CapsuleCast", CapsuleCast);
		L.RegFunction("SphereCast", SphereCast);
		L.RegFunction("BoxCast", BoxCast);
		L.RegFunction("RaycastAll", RaycastAll);
		L.RegFunction("RaycastNonAlloc", RaycastNonAlloc);
		L.RegFunction("CapsuleCastAll", CapsuleCastAll);
		L.RegFunction("SphereCastAll", SphereCastAll);
		L.RegFunction("OverlapCapsule", OverlapCapsule);
		L.RegFunction("OverlapSphere", OverlapSphere);
		L.RegFunction("Simulate", Simulate);
		L.RegFunction("SyncTransforms", SyncTransforms);
		L.RegFunction("ComputePenetration", ComputePenetration);
		L.RegFunction("ClosestPoint", ClosestPoint);
		L.RegFunction("OverlapSphereNonAlloc", OverlapSphereNonAlloc);
		L.RegFunction("CheckSphere", CheckSphere);
		L.RegFunction("CapsuleCastNonAlloc", CapsuleCastNonAlloc);
		L.RegFunction("SphereCastNonAlloc", SphereCastNonAlloc);
		L.RegFunction("CheckCapsule", CheckCapsule);
		L.RegFunction("CheckBox", CheckBox);
		L.RegFunction("OverlapBox", OverlapBox);
		L.RegFunction("OverlapBoxNonAlloc", OverlapBoxNonAlloc);
		L.RegFunction("BoxCastNonAlloc", BoxCastNonAlloc);
		L.RegFunction("BoxCastAll", BoxCastAll);
		L.RegFunction("OverlapCapsuleNonAlloc", OverlapCapsuleNonAlloc);
		L.RegFunction("RebuildBroadphaseRegions", RebuildBroadphaseRegions);
		L.RegConstant("IgnoreRaycastLayer", 4.0);
		L.RegConstant("DefaultRaycastLayers", -5.0);
		L.RegConstant("AllLayers", -1.0);
		L.RegVar("gravity", get_gravity, set_gravity);
		L.RegVar("defaultContactOffset", get_defaultContactOffset, set_defaultContactOffset);
		L.RegVar("sleepThreshold", get_sleepThreshold, set_sleepThreshold);
		L.RegVar("queriesHitTriggers", get_queriesHitTriggers, set_queriesHitTriggers);
		L.RegVar("queriesHitBackfaces", get_queriesHitBackfaces, set_queriesHitBackfaces);
		L.RegVar("bounceThreshold", get_bounceThreshold, set_bounceThreshold);
		L.RegVar("defaultSolverIterations", get_defaultSolverIterations, set_defaultSolverIterations);
		L.RegVar("defaultSolverVelocityIterations", get_defaultSolverVelocityIterations, set_defaultSolverVelocityIterations);
		L.RegVar("defaultPhysicsScene", get_defaultPhysicsScene, null);
		L.RegVar("autoSimulation", get_autoSimulation, set_autoSimulation);
		L.RegVar("autoSyncTransforms", get_autoSyncTransforms, set_autoSyncTransforms);
		L.RegVar("reuseCollisionCallbacks", get_reuseCollisionCallbacks, set_reuseCollisionCallbacks);
		L.RegVar("interCollisionDistance", get_interCollisionDistance, set_interCollisionDistance);
		L.RegVar("interCollisionStiffness", get_interCollisionStiffness, set_interCollisionStiffness);
		L.RegVar("interCollisionSettingsToggle", get_interCollisionSettingsToggle, set_interCollisionSettingsToggle);
		L.EndStaticLibs();
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
				Collider collider3 = (Collider)ToLua.CheckObject<Collider>(L, 1);
				Collider collider4 = (Collider)ToLua.CheckObject<Collider>(L, 2);
				Physics.IgnoreCollision(collider3, collider4);
				return 0;
			}
			case 3:
			{
				Collider collider = (Collider)ToLua.CheckObject<Collider>(L, 1);
				Collider collider2 = (Collider)ToLua.CheckObject<Collider>(L, 2);
				bool ignore = LuaDLL.luaL_checkboolean(L, 3);
				Physics.IgnoreCollision(collider, collider2, ignore);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics.IgnoreCollision");
			}
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
				Physics.IgnoreLayerCollision(layer3, layer4);
				return 0;
			}
			case 3:
			{
				int layer = (int)LuaDLL.luaL_checknumber(L, 1);
				int layer2 = (int)LuaDLL.luaL_checknumber(L, 2);
				bool ignore = LuaDLL.luaL_checkboolean(L, 3);
				Physics.IgnoreLayerCollision(layer, layer2, ignore);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics.IgnoreLayerCollision");
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
			bool ignoreLayerCollision = Physics.GetIgnoreLayerCollision(layer, layer2);
			LuaDLL.lua_pushboolean(L, ignoreLayerCollision);
			return 1;
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
			case 1:
			{
				bool value2 = Physics.Raycast(ToLua.ToRay(L, 1));
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			case 2:
				if (TypeChecker.CheckTypes<Vector3, Vector3>(L, 1))
				{
					Vector3 origin = ToLua.ToVector3(L, 1);
					Vector3 direction = ToLua.ToVector3(L, 2);
					bool value = Physics.Raycast(origin, direction);
					LuaDLL.lua_pushboolean(L, value);
					return 1;
				}
				break;
			}
			if (num == 2 && TypeChecker.CheckTypes<Ray, float>(L, 1))
			{
				Ray ray = ToLua.ToRay(L, 1);
				float maxDistance = (float)LuaDLL.lua_tonumber(L, 2);
				bool value3 = Physics.Raycast(ray, maxDistance);
				LuaDLL.lua_pushboolean(L, value3);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<Ray, LuaOut<RaycastHit>>(L, 1))
			{
				bool flag = Physics.Raycast(ToLua.ToRay(L, 1), out var hitInfo);
				LuaDLL.lua_pushboolean(L, flag);
				if (flag)
				{
					ToLua.Push(L, hitInfo);
				}
				else
				{
					LuaDLL.lua_pushnil(L);
				}
				return 2;
			}
			if (num == 3 && TypeChecker.CheckTypes<Vector3, Vector3, LuaOut<RaycastHit>>(L, 1))
			{
				Vector3 origin2 = ToLua.ToVector3(L, 1);
				Vector3 direction2 = ToLua.ToVector3(L, 2);
				bool flag2 = Physics.Raycast(origin2, direction2, out var hitInfo2);
				LuaDLL.lua_pushboolean(L, flag2);
				if (flag2)
				{
					ToLua.Push(L, hitInfo2);
				}
				else
				{
					LuaDLL.lua_pushnil(L);
				}
				return 2;
			}
			if (num == 3 && TypeChecker.CheckTypes<Ray, float, int>(L, 1))
			{
				Ray ray2 = ToLua.ToRay(L, 1);
				float maxDistance2 = (float)LuaDLL.lua_tonumber(L, 2);
				int layerMask = (int)LuaDLL.lua_tonumber(L, 3);
				bool value4 = Physics.Raycast(ray2, maxDistance2, layerMask);
				LuaDLL.lua_pushboolean(L, value4);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<Ray, LuaOut<RaycastHit>, float>(L, 1))
			{
				Ray ray3 = ToLua.ToRay(L, 1);
				float maxDistance3 = (float)LuaDLL.lua_tonumber(L, 3);
				bool flag3 = Physics.Raycast(ray3, out var hitInfo3, maxDistance3);
				LuaDLL.lua_pushboolean(L, flag3);
				if (flag3)
				{
					ToLua.Push(L, hitInfo3);
				}
				else
				{
					LuaDLL.lua_pushnil(L);
				}
				return 2;
			}
			if (num == 3 && TypeChecker.CheckTypes<Vector3, Vector3, float>(L, 1))
			{
				Vector3 origin3 = ToLua.ToVector3(L, 1);
				Vector3 direction3 = ToLua.ToVector3(L, 2);
				float maxDistance4 = (float)LuaDLL.lua_tonumber(L, 3);
				bool value5 = Physics.Raycast(origin3, direction3, maxDistance4);
				LuaDLL.lua_pushboolean(L, value5);
				return 1;
			}
			if (num == 4 && TypeChecker.CheckTypes<Vector3, Vector3, LuaOut<RaycastHit>, float>(L, 1))
			{
				Vector3 origin4 = ToLua.ToVector3(L, 1);
				Vector3 direction4 = ToLua.ToVector3(L, 2);
				float maxDistance5 = (float)LuaDLL.lua_tonumber(L, 4);
				bool flag4 = Physics.Raycast(origin4, direction4, out var hitInfo4, maxDistance5);
				LuaDLL.lua_pushboolean(L, flag4);
				if (flag4)
				{
					ToLua.Push(L, hitInfo4);
				}
				else
				{
					LuaDLL.lua_pushnil(L);
				}
				return 2;
			}
			if (num == 4 && TypeChecker.CheckTypes<Ray, LuaOut<RaycastHit>, float, int>(L, 1))
			{
				Ray ray4 = ToLua.ToRay(L, 1);
				float maxDistance6 = (float)LuaDLL.lua_tonumber(L, 3);
				int layerMask2 = (int)LuaDLL.lua_tonumber(L, 4);
				bool flag5 = Physics.Raycast(ray4, out var hitInfo5, maxDistance6, layerMask2);
				LuaDLL.lua_pushboolean(L, flag5);
				if (flag5)
				{
					ToLua.Push(L, hitInfo5);
				}
				else
				{
					LuaDLL.lua_pushnil(L);
				}
				return 2;
			}
			if (num == 4 && TypeChecker.CheckTypes<Vector3, Vector3, float, int>(L, 1))
			{
				Vector3 origin5 = ToLua.ToVector3(L, 1);
				Vector3 direction5 = ToLua.ToVector3(L, 2);
				float maxDistance7 = (float)LuaDLL.lua_tonumber(L, 3);
				int layerMask3 = (int)LuaDLL.lua_tonumber(L, 4);
				bool value6 = Physics.Raycast(origin5, direction5, maxDistance7, layerMask3);
				LuaDLL.lua_pushboolean(L, value6);
				return 1;
			}
			if (num == 4 && TypeChecker.CheckTypes<Ray, float, int, QueryTriggerInteraction>(L, 1))
			{
				Ray ray5 = ToLua.ToRay(L, 1);
				float maxDistance8 = (float)LuaDLL.lua_tonumber(L, 2);
				int layerMask4 = (int)LuaDLL.lua_tonumber(L, 3);
				QueryTriggerInteraction queryTriggerInteraction = (QueryTriggerInteraction)ToLua.ToObject(L, 4);
				bool value7 = Physics.Raycast(ray5, maxDistance8, layerMask4, queryTriggerInteraction);
				LuaDLL.lua_pushboolean(L, value7);
				return 1;
			}
			if (num == 5 && TypeChecker.CheckTypes<Vector3, Vector3, float, int, QueryTriggerInteraction>(L, 1))
			{
				Vector3 origin6 = ToLua.ToVector3(L, 1);
				Vector3 direction6 = ToLua.ToVector3(L, 2);
				float maxDistance9 = (float)LuaDLL.lua_tonumber(L, 3);
				int layerMask5 = (int)LuaDLL.lua_tonumber(L, 4);
				QueryTriggerInteraction queryTriggerInteraction2 = (QueryTriggerInteraction)ToLua.ToObject(L, 5);
				bool value8 = Physics.Raycast(origin6, direction6, maxDistance9, layerMask5, queryTriggerInteraction2);
				LuaDLL.lua_pushboolean(L, value8);
				return 1;
			}
			if (num == 5 && TypeChecker.CheckTypes<Vector3, Vector3, LuaOut<RaycastHit>, float, int>(L, 1))
			{
				Vector3 origin7 = ToLua.ToVector3(L, 1);
				Vector3 direction7 = ToLua.ToVector3(L, 2);
				float maxDistance10 = (float)LuaDLL.lua_tonumber(L, 4);
				int layerMask6 = (int)LuaDLL.lua_tonumber(L, 5);
				bool flag6 = Physics.Raycast(origin7, direction7, out var hitInfo6, maxDistance10, layerMask6);
				LuaDLL.lua_pushboolean(L, flag6);
				if (flag6)
				{
					ToLua.Push(L, hitInfo6);
				}
				else
				{
					LuaDLL.lua_pushnil(L);
				}
				return 2;
			}
			if (num == 5 && TypeChecker.CheckTypes<Ray, LuaOut<RaycastHit>, float, int, QueryTriggerInteraction>(L, 1))
			{
				Ray ray6 = ToLua.ToRay(L, 1);
				float maxDistance11 = (float)LuaDLL.lua_tonumber(L, 3);
				int layerMask7 = (int)LuaDLL.lua_tonumber(L, 4);
				QueryTriggerInteraction queryTriggerInteraction3 = (QueryTriggerInteraction)ToLua.ToObject(L, 5);
				bool flag7 = Physics.Raycast(ray6, out var hitInfo7, maxDistance11, layerMask7, queryTriggerInteraction3);
				LuaDLL.lua_pushboolean(L, flag7);
				if (flag7)
				{
					ToLua.Push(L, hitInfo7);
				}
				else
				{
					LuaDLL.lua_pushnil(L);
				}
				return 2;
			}
			if (num == 6)
			{
				Vector3 origin8 = ToLua.ToVector3(L, 1);
				Vector3 direction8 = ToLua.ToVector3(L, 2);
				float maxDistance12 = (float)LuaDLL.luaL_checknumber(L, 4);
				int layerMask8 = (int)LuaDLL.luaL_checknumber(L, 5);
				QueryTriggerInteraction queryTriggerInteraction4 = (QueryTriggerInteraction)ToLua.CheckObject(L, 6, typeof(QueryTriggerInteraction));
				bool flag8 = Physics.Raycast(origin8, direction8, out var hitInfo8, maxDistance12, layerMask8, queryTriggerInteraction4);
				LuaDLL.lua_pushboolean(L, flag8);
				if (flag8)
				{
					ToLua.Push(L, hitInfo8);
				}
				else
				{
					LuaDLL.lua_pushnil(L);
				}
				return 2;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics.Raycast");
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
				Vector3 start2 = ToLua.ToVector3(L, 1);
				Vector3 end2 = ToLua.ToVector3(L, 2);
				bool value2 = Physics.Linecast(start2, end2);
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			case 3:
				if (TypeChecker.CheckTypes<LuaOut<RaycastHit>>(L, 3))
				{
					Vector3 start = ToLua.ToVector3(L, 1);
					Vector3 end = ToLua.ToVector3(L, 2);
					bool value = Physics.Linecast(start, end, out var hitInfo);
					LuaDLL.lua_pushboolean(L, value);
					ToLua.Push(L, hitInfo);
					return 2;
				}
				break;
			}
			if (num == 3 && TypeChecker.CheckTypes<int>(L, 3))
			{
				Vector3 start3 = ToLua.ToVector3(L, 1);
				Vector3 end3 = ToLua.ToVector3(L, 2);
				int layerMask = (int)LuaDLL.lua_tonumber(L, 3);
				bool value3 = Physics.Linecast(start3, end3, layerMask);
				LuaDLL.lua_pushboolean(L, value3);
				return 1;
			}
			if (num == 4 && TypeChecker.CheckTypes<LuaOut<RaycastHit>, int>(L, 3))
			{
				Vector3 start4 = ToLua.ToVector3(L, 1);
				Vector3 end4 = ToLua.ToVector3(L, 2);
				int layerMask2 = (int)LuaDLL.lua_tonumber(L, 4);
				bool value4 = Physics.Linecast(start4, end4, out var hitInfo2, layerMask2);
				LuaDLL.lua_pushboolean(L, value4);
				ToLua.Push(L, hitInfo2);
				return 2;
			}
			if (num == 4 && TypeChecker.CheckTypes<int, QueryTriggerInteraction>(L, 3))
			{
				Vector3 start5 = ToLua.ToVector3(L, 1);
				Vector3 end5 = ToLua.ToVector3(L, 2);
				int layerMask3 = (int)LuaDLL.lua_tonumber(L, 3);
				QueryTriggerInteraction queryTriggerInteraction = (QueryTriggerInteraction)ToLua.ToObject(L, 4);
				bool value5 = Physics.Linecast(start5, end5, layerMask3, queryTriggerInteraction);
				LuaDLL.lua_pushboolean(L, value5);
				return 1;
			}
			if (num == 5)
			{
				Vector3 start6 = ToLua.ToVector3(L, 1);
				Vector3 end6 = ToLua.ToVector3(L, 2);
				int layerMask4 = (int)LuaDLL.luaL_checknumber(L, 4);
				QueryTriggerInteraction queryTriggerInteraction2 = (QueryTriggerInteraction)ToLua.CheckObject(L, 5, typeof(QueryTriggerInteraction));
				bool value6 = Physics.Linecast(start6, end6, out var hitInfo3, layerMask4, queryTriggerInteraction2);
				LuaDLL.lua_pushboolean(L, value6);
				ToLua.Push(L, hitInfo3);
				return 2;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics.Linecast");
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
			case 4:
			{
				Vector3 point3 = ToLua.ToVector3(L, 1);
				Vector3 point4 = ToLua.ToVector3(L, 2);
				float radius2 = (float)LuaDLL.luaL_checknumber(L, 3);
				Vector3 direction2 = ToLua.ToVector3(L, 4);
				bool value2 = Physics.CapsuleCast(point3, point4, radius2, direction2);
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			case 5:
				if (TypeChecker.CheckTypes<LuaOut<RaycastHit>>(L, 5))
				{
					Vector3 point = ToLua.ToVector3(L, 1);
					Vector3 point2 = ToLua.ToVector3(L, 2);
					float radius = (float)LuaDLL.luaL_checknumber(L, 3);
					Vector3 direction = ToLua.ToVector3(L, 4);
					bool value = Physics.CapsuleCast(point, point2, radius, direction, out var hitInfo);
					LuaDLL.lua_pushboolean(L, value);
					ToLua.Push(L, hitInfo);
					return 2;
				}
				break;
			}
			if (num == 5 && TypeChecker.CheckTypes<float>(L, 5))
			{
				Vector3 point5 = ToLua.ToVector3(L, 1);
				Vector3 point6 = ToLua.ToVector3(L, 2);
				float radius3 = (float)LuaDLL.luaL_checknumber(L, 3);
				Vector3 direction3 = ToLua.ToVector3(L, 4);
				float maxDistance = (float)LuaDLL.lua_tonumber(L, 5);
				bool value3 = Physics.CapsuleCast(point5, point6, radius3, direction3, maxDistance);
				LuaDLL.lua_pushboolean(L, value3);
				return 1;
			}
			if (num == 6 && TypeChecker.CheckTypes<float, int>(L, 5))
			{
				Vector3 point7 = ToLua.ToVector3(L, 1);
				Vector3 point8 = ToLua.ToVector3(L, 2);
				float radius4 = (float)LuaDLL.luaL_checknumber(L, 3);
				Vector3 direction4 = ToLua.ToVector3(L, 4);
				float maxDistance2 = (float)LuaDLL.lua_tonumber(L, 5);
				int layerMask = (int)LuaDLL.lua_tonumber(L, 6);
				bool value4 = Physics.CapsuleCast(point7, point8, radius4, direction4, maxDistance2, layerMask);
				LuaDLL.lua_pushboolean(L, value4);
				return 1;
			}
			if (num == 6 && TypeChecker.CheckTypes<LuaOut<RaycastHit>, float>(L, 5))
			{
				Vector3 point9 = ToLua.ToVector3(L, 1);
				Vector3 point10 = ToLua.ToVector3(L, 2);
				float radius5 = (float)LuaDLL.luaL_checknumber(L, 3);
				Vector3 direction5 = ToLua.ToVector3(L, 4);
				float maxDistance3 = (float)LuaDLL.lua_tonumber(L, 6);
				bool value5 = Physics.CapsuleCast(point9, point10, radius5, direction5, out var hitInfo2, maxDistance3);
				LuaDLL.lua_pushboolean(L, value5);
				ToLua.Push(L, hitInfo2);
				return 2;
			}
			if (num == 7 && TypeChecker.CheckTypes<LuaOut<RaycastHit>, float, int>(L, 5))
			{
				Vector3 point11 = ToLua.ToVector3(L, 1);
				Vector3 point12 = ToLua.ToVector3(L, 2);
				float radius6 = (float)LuaDLL.luaL_checknumber(L, 3);
				Vector3 direction6 = ToLua.ToVector3(L, 4);
				float maxDistance4 = (float)LuaDLL.lua_tonumber(L, 6);
				int layerMask2 = (int)LuaDLL.lua_tonumber(L, 7);
				bool value6 = Physics.CapsuleCast(point11, point12, radius6, direction6, out var hitInfo3, maxDistance4, layerMask2);
				LuaDLL.lua_pushboolean(L, value6);
				ToLua.Push(L, hitInfo3);
				return 2;
			}
			if (num == 7 && TypeChecker.CheckTypes<float, int, QueryTriggerInteraction>(L, 5))
			{
				Vector3 point13 = ToLua.ToVector3(L, 1);
				Vector3 point14 = ToLua.ToVector3(L, 2);
				float radius7 = (float)LuaDLL.luaL_checknumber(L, 3);
				Vector3 direction7 = ToLua.ToVector3(L, 4);
				float maxDistance5 = (float)LuaDLL.lua_tonumber(L, 5);
				int layerMask3 = (int)LuaDLL.lua_tonumber(L, 6);
				QueryTriggerInteraction queryTriggerInteraction = (QueryTriggerInteraction)ToLua.ToObject(L, 7);
				bool value7 = Physics.CapsuleCast(point13, point14, radius7, direction7, maxDistance5, layerMask3, queryTriggerInteraction);
				LuaDLL.lua_pushboolean(L, value7);
				return 1;
			}
			if (num == 8)
			{
				Vector3 point15 = ToLua.ToVector3(L, 1);
				Vector3 point16 = ToLua.ToVector3(L, 2);
				float radius8 = (float)LuaDLL.luaL_checknumber(L, 3);
				Vector3 direction8 = ToLua.ToVector3(L, 4);
				float maxDistance6 = (float)LuaDLL.luaL_checknumber(L, 6);
				int layerMask4 = (int)LuaDLL.luaL_checknumber(L, 7);
				QueryTriggerInteraction queryTriggerInteraction2 = (QueryTriggerInteraction)ToLua.CheckObject(L, 8, typeof(QueryTriggerInteraction));
				bool value8 = Physics.CapsuleCast(point15, point16, radius8, direction8, out var hitInfo4, maxDistance6, layerMask4, queryTriggerInteraction2);
				LuaDLL.lua_pushboolean(L, value8);
				ToLua.Push(L, hitInfo4);
				return 2;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics.CapsuleCast");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SphereCast(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			switch (num)
			{
			case 2:
			{
				Ray ray2 = ToLua.ToRay(L, 1);
				float radius2 = (float)LuaDLL.luaL_checknumber(L, 2);
				bool value2 = Physics.SphereCast(ray2, radius2);
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			case 3:
				if (TypeChecker.CheckTypes<float>(L, 3))
				{
					Ray ray = ToLua.ToRay(L, 1);
					float radius = (float)LuaDLL.luaL_checknumber(L, 2);
					float maxDistance = (float)LuaDLL.lua_tonumber(L, 3);
					bool value = Physics.SphereCast(ray, radius, maxDistance);
					LuaDLL.lua_pushboolean(L, value);
					return 1;
				}
				break;
			}
			if (num == 3 && TypeChecker.CheckTypes<LuaOut<RaycastHit>>(L, 3))
			{
				Ray ray3 = ToLua.ToRay(L, 1);
				float radius3 = (float)LuaDLL.luaL_checknumber(L, 2);
				bool value3 = Physics.SphereCast(ray3, radius3, out var hitInfo);
				LuaDLL.lua_pushboolean(L, value3);
				ToLua.Push(L, hitInfo);
				return 2;
			}
			if (num == 4 && TypeChecker.CheckTypes<Ray, float, float, int>(L, 1))
			{
				Ray ray4 = ToLua.ToRay(L, 1);
				float radius4 = (float)LuaDLL.lua_tonumber(L, 2);
				float maxDistance2 = (float)LuaDLL.lua_tonumber(L, 3);
				int layerMask = (int)LuaDLL.lua_tonumber(L, 4);
				bool value4 = Physics.SphereCast(ray4, radius4, maxDistance2, layerMask);
				LuaDLL.lua_pushboolean(L, value4);
				return 1;
			}
			if (num == 4 && TypeChecker.CheckTypes<Ray, float, LuaOut<RaycastHit>, float>(L, 1))
			{
				Ray ray5 = ToLua.ToRay(L, 1);
				float radius5 = (float)LuaDLL.lua_tonumber(L, 2);
				float maxDistance3 = (float)LuaDLL.lua_tonumber(L, 4);
				bool value5 = Physics.SphereCast(ray5, radius5, out var hitInfo2, maxDistance3);
				LuaDLL.lua_pushboolean(L, value5);
				ToLua.Push(L, hitInfo2);
				return 2;
			}
			if (num == 4 && TypeChecker.CheckTypes<Vector3, float, Vector3, LuaOut<RaycastHit>>(L, 1))
			{
				Vector3 origin = ToLua.ToVector3(L, 1);
				float radius6 = (float)LuaDLL.lua_tonumber(L, 2);
				Vector3 direction = ToLua.ToVector3(L, 3);
				bool value6 = Physics.SphereCast(origin, radius6, direction, out var hitInfo3);
				LuaDLL.lua_pushboolean(L, value6);
				ToLua.Push(L, hitInfo3);
				return 2;
			}
			if (num == 5 && TypeChecker.CheckTypes<Ray, float, LuaOut<RaycastHit>, float, int>(L, 1))
			{
				Ray ray6 = ToLua.ToRay(L, 1);
				float radius7 = (float)LuaDLL.lua_tonumber(L, 2);
				float maxDistance4 = (float)LuaDLL.lua_tonumber(L, 4);
				int layerMask2 = (int)LuaDLL.lua_tonumber(L, 5);
				bool value7 = Physics.SphereCast(ray6, radius7, out var hitInfo4, maxDistance4, layerMask2);
				LuaDLL.lua_pushboolean(L, value7);
				ToLua.Push(L, hitInfo4);
				return 2;
			}
			if (num == 5 && TypeChecker.CheckTypes<Vector3, float, Vector3, LuaOut<RaycastHit>, float>(L, 1))
			{
				Vector3 origin2 = ToLua.ToVector3(L, 1);
				float radius8 = (float)LuaDLL.lua_tonumber(L, 2);
				Vector3 direction2 = ToLua.ToVector3(L, 3);
				float maxDistance5 = (float)LuaDLL.lua_tonumber(L, 5);
				bool value8 = Physics.SphereCast(origin2, radius8, direction2, out var hitInfo5, maxDistance5);
				LuaDLL.lua_pushboolean(L, value8);
				ToLua.Push(L, hitInfo5);
				return 2;
			}
			if (num == 5 && TypeChecker.CheckTypes<Ray, float, float, int, QueryTriggerInteraction>(L, 1))
			{
				Ray ray7 = ToLua.ToRay(L, 1);
				float radius9 = (float)LuaDLL.lua_tonumber(L, 2);
				float maxDistance6 = (float)LuaDLL.lua_tonumber(L, 3);
				int layerMask3 = (int)LuaDLL.lua_tonumber(L, 4);
				QueryTriggerInteraction queryTriggerInteraction = (QueryTriggerInteraction)ToLua.ToObject(L, 5);
				bool value9 = Physics.SphereCast(ray7, radius9, maxDistance6, layerMask3, queryTriggerInteraction);
				LuaDLL.lua_pushboolean(L, value9);
				return 1;
			}
			if (num == 6 && TypeChecker.CheckTypes<Vector3, float, Vector3, LuaOut<RaycastHit>, float, int>(L, 1))
			{
				Vector3 origin3 = ToLua.ToVector3(L, 1);
				float radius10 = (float)LuaDLL.lua_tonumber(L, 2);
				Vector3 direction3 = ToLua.ToVector3(L, 3);
				float maxDistance7 = (float)LuaDLL.lua_tonumber(L, 5);
				int layerMask4 = (int)LuaDLL.lua_tonumber(L, 6);
				bool value10 = Physics.SphereCast(origin3, radius10, direction3, out var hitInfo6, maxDistance7, layerMask4);
				LuaDLL.lua_pushboolean(L, value10);
				ToLua.Push(L, hitInfo6);
				return 2;
			}
			if (num == 6 && TypeChecker.CheckTypes<Ray, float, LuaOut<RaycastHit>, float, int, QueryTriggerInteraction>(L, 1))
			{
				Ray ray8 = ToLua.ToRay(L, 1);
				float radius11 = (float)LuaDLL.lua_tonumber(L, 2);
				float maxDistance8 = (float)LuaDLL.lua_tonumber(L, 4);
				int layerMask5 = (int)LuaDLL.lua_tonumber(L, 5);
				QueryTriggerInteraction queryTriggerInteraction2 = (QueryTriggerInteraction)ToLua.ToObject(L, 6);
				bool value11 = Physics.SphereCast(ray8, radius11, out var hitInfo7, maxDistance8, layerMask5, queryTriggerInteraction2);
				LuaDLL.lua_pushboolean(L, value11);
				ToLua.Push(L, hitInfo7);
				return 2;
			}
			if (num == 7)
			{
				Vector3 origin4 = ToLua.ToVector3(L, 1);
				float radius12 = (float)LuaDLL.luaL_checknumber(L, 2);
				Vector3 direction4 = ToLua.ToVector3(L, 3);
				float maxDistance9 = (float)LuaDLL.luaL_checknumber(L, 5);
				int layerMask6 = (int)LuaDLL.luaL_checknumber(L, 6);
				QueryTriggerInteraction queryTriggerInteraction3 = (QueryTriggerInteraction)ToLua.CheckObject(L, 7, typeof(QueryTriggerInteraction));
				bool value12 = Physics.SphereCast(origin4, radius12, direction4, out var hitInfo8, maxDistance9, layerMask6, queryTriggerInteraction3);
				LuaDLL.lua_pushboolean(L, value12);
				ToLua.Push(L, hitInfo8);
				return 2;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics.SphereCast");
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
			case 3:
			{
				Vector3 center2 = ToLua.ToVector3(L, 1);
				Vector3 halfExtents2 = ToLua.ToVector3(L, 2);
				Vector3 direction2 = ToLua.ToVector3(L, 3);
				bool value2 = Physics.BoxCast(center2, halfExtents2, direction2);
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			case 4:
				if (TypeChecker.CheckTypes<Quaternion>(L, 4))
				{
					Vector3 center = ToLua.ToVector3(L, 1);
					Vector3 halfExtents = ToLua.ToVector3(L, 2);
					Vector3 direction = ToLua.ToVector3(L, 3);
					Quaternion orientation = ToLua.ToQuaternion(L, 4);
					bool value = Physics.BoxCast(center, halfExtents, direction, orientation);
					LuaDLL.lua_pushboolean(L, value);
					return 1;
				}
				break;
			}
			if (num == 4 && TypeChecker.CheckTypes<LuaOut<RaycastHit>>(L, 4))
			{
				Vector3 center3 = ToLua.ToVector3(L, 1);
				Vector3 halfExtents3 = ToLua.ToVector3(L, 2);
				Vector3 direction3 = ToLua.ToVector3(L, 3);
				bool value3 = Physics.BoxCast(center3, halfExtents3, direction3, out var hitInfo);
				LuaDLL.lua_pushboolean(L, value3);
				ToLua.Push(L, hitInfo);
				return 2;
			}
			if (num == 5 && TypeChecker.CheckTypes<LuaOut<RaycastHit>, Quaternion>(L, 4))
			{
				Vector3 center4 = ToLua.ToVector3(L, 1);
				Vector3 halfExtents4 = ToLua.ToVector3(L, 2);
				Vector3 direction4 = ToLua.ToVector3(L, 3);
				Quaternion orientation2 = ToLua.ToQuaternion(L, 5);
				bool value4 = Physics.BoxCast(center4, halfExtents4, direction4, out var hitInfo2, orientation2);
				LuaDLL.lua_pushboolean(L, value4);
				ToLua.Push(L, hitInfo2);
				return 2;
			}
			if (num == 5 && TypeChecker.CheckTypes<Quaternion, float>(L, 4))
			{
				Vector3 center5 = ToLua.ToVector3(L, 1);
				Vector3 halfExtents5 = ToLua.ToVector3(L, 2);
				Vector3 direction5 = ToLua.ToVector3(L, 3);
				Quaternion orientation3 = ToLua.ToQuaternion(L, 4);
				float maxDistance = (float)LuaDLL.lua_tonumber(L, 5);
				bool value5 = Physics.BoxCast(center5, halfExtents5, direction5, orientation3, maxDistance);
				LuaDLL.lua_pushboolean(L, value5);
				return 1;
			}
			if (num == 6 && TypeChecker.CheckTypes<LuaOut<RaycastHit>, Quaternion, float>(L, 4))
			{
				Vector3 center6 = ToLua.ToVector3(L, 1);
				Vector3 halfExtents6 = ToLua.ToVector3(L, 2);
				Vector3 direction6 = ToLua.ToVector3(L, 3);
				Quaternion orientation4 = ToLua.ToQuaternion(L, 5);
				float maxDistance2 = (float)LuaDLL.lua_tonumber(L, 6);
				bool value6 = Physics.BoxCast(center6, halfExtents6, direction6, out var hitInfo3, orientation4, maxDistance2);
				LuaDLL.lua_pushboolean(L, value6);
				ToLua.Push(L, hitInfo3);
				return 2;
			}
			if (num == 6 && TypeChecker.CheckTypes<Quaternion, float, int>(L, 4))
			{
				Vector3 center7 = ToLua.ToVector3(L, 1);
				Vector3 halfExtents7 = ToLua.ToVector3(L, 2);
				Vector3 direction7 = ToLua.ToVector3(L, 3);
				Quaternion orientation5 = ToLua.ToQuaternion(L, 4);
				float maxDistance3 = (float)LuaDLL.lua_tonumber(L, 5);
				int layerMask = (int)LuaDLL.lua_tonumber(L, 6);
				bool value7 = Physics.BoxCast(center7, halfExtents7, direction7, orientation5, maxDistance3, layerMask);
				LuaDLL.lua_pushboolean(L, value7);
				return 1;
			}
			if (num == 7 && TypeChecker.CheckTypes<Quaternion, float, int, QueryTriggerInteraction>(L, 4))
			{
				Vector3 center8 = ToLua.ToVector3(L, 1);
				Vector3 halfExtents8 = ToLua.ToVector3(L, 2);
				Vector3 direction8 = ToLua.ToVector3(L, 3);
				Quaternion orientation6 = ToLua.ToQuaternion(L, 4);
				float maxDistance4 = (float)LuaDLL.lua_tonumber(L, 5);
				int layerMask2 = (int)LuaDLL.lua_tonumber(L, 6);
				QueryTriggerInteraction queryTriggerInteraction = (QueryTriggerInteraction)ToLua.ToObject(L, 7);
				bool value8 = Physics.BoxCast(center8, halfExtents8, direction8, orientation6, maxDistance4, layerMask2, queryTriggerInteraction);
				LuaDLL.lua_pushboolean(L, value8);
				return 1;
			}
			if (num == 7 && TypeChecker.CheckTypes<LuaOut<RaycastHit>, Quaternion, float, int>(L, 4))
			{
				Vector3 center9 = ToLua.ToVector3(L, 1);
				Vector3 halfExtents9 = ToLua.ToVector3(L, 2);
				Vector3 direction9 = ToLua.ToVector3(L, 3);
				Quaternion orientation7 = ToLua.ToQuaternion(L, 5);
				float maxDistance5 = (float)LuaDLL.lua_tonumber(L, 6);
				int layerMask3 = (int)LuaDLL.lua_tonumber(L, 7);
				bool value9 = Physics.BoxCast(center9, halfExtents9, direction9, out var hitInfo4, orientation7, maxDistance5, layerMask3);
				LuaDLL.lua_pushboolean(L, value9);
				ToLua.Push(L, hitInfo4);
				return 2;
			}
			if (num == 8)
			{
				Vector3 center10 = ToLua.ToVector3(L, 1);
				Vector3 halfExtents10 = ToLua.ToVector3(L, 2);
				Vector3 direction10 = ToLua.ToVector3(L, 3);
				Quaternion orientation8 = ToLua.ToQuaternion(L, 5);
				float maxDistance6 = (float)LuaDLL.luaL_checknumber(L, 6);
				int layerMask4 = (int)LuaDLL.luaL_checknumber(L, 7);
				QueryTriggerInteraction queryTriggerInteraction2 = (QueryTriggerInteraction)ToLua.CheckObject(L, 8, typeof(QueryTriggerInteraction));
				bool value10 = Physics.BoxCast(center10, halfExtents10, direction10, out var hitInfo5, orientation8, maxDistance6, layerMask4, queryTriggerInteraction2);
				LuaDLL.lua_pushboolean(L, value10);
				ToLua.Push(L, hitInfo5);
				return 2;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics.BoxCast");
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
			int num = LuaDLL.lua_gettop(L);
			switch (num)
			{
			case 1:
			{
				RaycastHit[] array2 = Physics.RaycastAll(ToLua.ToRay(L, 1));
				ToLua.Push(L, array2);
				return 1;
			}
			case 2:
				if (TypeChecker.CheckTypes<Vector3, Vector3>(L, 1))
				{
					Vector3 origin = ToLua.ToVector3(L, 1);
					Vector3 direction = ToLua.ToVector3(L, 2);
					RaycastHit[] array = Physics.RaycastAll(origin, direction);
					ToLua.Push(L, array);
					return 1;
				}
				break;
			}
			if (num == 2 && TypeChecker.CheckTypes<Ray, float>(L, 1))
			{
				Ray ray = ToLua.ToRay(L, 1);
				float maxDistance = (float)LuaDLL.lua_tonumber(L, 2);
				RaycastHit[] array3 = Physics.RaycastAll(ray, maxDistance);
				ToLua.Push(L, array3);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<Ray, float, int>(L, 1))
			{
				Ray ray2 = ToLua.ToRay(L, 1);
				float maxDistance2 = (float)LuaDLL.lua_tonumber(L, 2);
				int layerMask = (int)LuaDLL.lua_tonumber(L, 3);
				RaycastHit[] array4 = Physics.RaycastAll(ray2, maxDistance2, layerMask);
				ToLua.Push(L, array4);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<Vector3, Vector3, float>(L, 1))
			{
				Vector3 origin2 = ToLua.ToVector3(L, 1);
				Vector3 direction2 = ToLua.ToVector3(L, 2);
				float maxDistance3 = (float)LuaDLL.lua_tonumber(L, 3);
				RaycastHit[] array5 = Physics.RaycastAll(origin2, direction2, maxDistance3);
				ToLua.Push(L, array5);
				return 1;
			}
			if (num == 4 && TypeChecker.CheckTypes<Vector3, Vector3, float, int>(L, 1))
			{
				Vector3 origin3 = ToLua.ToVector3(L, 1);
				Vector3 direction3 = ToLua.ToVector3(L, 2);
				float maxDistance4 = (float)LuaDLL.lua_tonumber(L, 3);
				int layerMask2 = (int)LuaDLL.lua_tonumber(L, 4);
				RaycastHit[] array6 = Physics.RaycastAll(origin3, direction3, maxDistance4, layerMask2);
				ToLua.Push(L, array6);
				return 1;
			}
			if (num == 4 && TypeChecker.CheckTypes<Ray, float, int, QueryTriggerInteraction>(L, 1))
			{
				Ray ray3 = ToLua.ToRay(L, 1);
				float maxDistance5 = (float)LuaDLL.lua_tonumber(L, 2);
				int layerMask3 = (int)LuaDLL.lua_tonumber(L, 3);
				QueryTriggerInteraction queryTriggerInteraction = (QueryTriggerInteraction)ToLua.ToObject(L, 4);
				RaycastHit[] array7 = Physics.RaycastAll(ray3, maxDistance5, layerMask3, queryTriggerInteraction);
				ToLua.Push(L, array7);
				return 1;
			}
			if (num == 5)
			{
				Vector3 origin4 = ToLua.ToVector3(L, 1);
				Vector3 direction4 = ToLua.ToVector3(L, 2);
				float maxDistance6 = (float)LuaDLL.luaL_checknumber(L, 3);
				int layerMask4 = (int)LuaDLL.luaL_checknumber(L, 4);
				QueryTriggerInteraction queryTriggerInteraction2 = (QueryTriggerInteraction)ToLua.CheckObject(L, 5, typeof(QueryTriggerInteraction));
				RaycastHit[] array8 = Physics.RaycastAll(origin4, direction4, maxDistance6, layerMask4, queryTriggerInteraction2);
				ToLua.Push(L, array8);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics.RaycastAll");
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
			int num = LuaDLL.lua_gettop(L);
			switch (num)
			{
			case 2:
			{
				Ray ray = ToLua.ToRay(L, 1);
				RaycastHit[] results2 = ToLua.CheckStructArray<RaycastHit>(L, 2);
				int n2 = Physics.RaycastNonAlloc(ray, results2);
				LuaDLL.lua_pushinteger(L, n2);
				return 1;
			}
			case 3:
				if (TypeChecker.CheckTypes<Vector3, Vector3, RaycastHit[]>(L, 1))
				{
					Vector3 origin = ToLua.ToVector3(L, 1);
					Vector3 direction = ToLua.ToVector3(L, 2);
					RaycastHit[] results = ToLua.ToStructArray<RaycastHit>(L, 3);
					int n = Physics.RaycastNonAlloc(origin, direction, results);
					LuaDLL.lua_pushinteger(L, n);
					return 1;
				}
				break;
			}
			if (num == 3 && TypeChecker.CheckTypes<Ray, RaycastHit[], float>(L, 1))
			{
				Ray ray2 = ToLua.ToRay(L, 1);
				RaycastHit[] results3 = ToLua.ToStructArray<RaycastHit>(L, 2);
				float maxDistance = (float)LuaDLL.lua_tonumber(L, 3);
				int n3 = Physics.RaycastNonAlloc(ray2, results3, maxDistance);
				LuaDLL.lua_pushinteger(L, n3);
				return 1;
			}
			if (num == 4 && TypeChecker.CheckTypes<Ray, RaycastHit[], float, int>(L, 1))
			{
				Ray ray3 = ToLua.ToRay(L, 1);
				RaycastHit[] results4 = ToLua.ToStructArray<RaycastHit>(L, 2);
				float maxDistance2 = (float)LuaDLL.lua_tonumber(L, 3);
				int layerMask = (int)LuaDLL.lua_tonumber(L, 4);
				int n4 = Physics.RaycastNonAlloc(ray3, results4, maxDistance2, layerMask);
				LuaDLL.lua_pushinteger(L, n4);
				return 1;
			}
			if (num == 4 && TypeChecker.CheckTypes<Vector3, Vector3, RaycastHit[], float>(L, 1))
			{
				Vector3 origin2 = ToLua.ToVector3(L, 1);
				Vector3 direction2 = ToLua.ToVector3(L, 2);
				RaycastHit[] results5 = ToLua.ToStructArray<RaycastHit>(L, 3);
				float maxDistance3 = (float)LuaDLL.lua_tonumber(L, 4);
				int n5 = Physics.RaycastNonAlloc(origin2, direction2, results5, maxDistance3);
				LuaDLL.lua_pushinteger(L, n5);
				return 1;
			}
			if (num == 5 && TypeChecker.CheckTypes<Vector3, Vector3, RaycastHit[], float, int>(L, 1))
			{
				Vector3 origin3 = ToLua.ToVector3(L, 1);
				Vector3 direction3 = ToLua.ToVector3(L, 2);
				RaycastHit[] results6 = ToLua.ToStructArray<RaycastHit>(L, 3);
				float maxDistance4 = (float)LuaDLL.lua_tonumber(L, 4);
				int layerMask2 = (int)LuaDLL.lua_tonumber(L, 5);
				int n6 = Physics.RaycastNonAlloc(origin3, direction3, results6, maxDistance4, layerMask2);
				LuaDLL.lua_pushinteger(L, n6);
				return 1;
			}
			if (num == 5 && TypeChecker.CheckTypes<Ray, RaycastHit[], float, int, QueryTriggerInteraction>(L, 1))
			{
				Ray ray4 = ToLua.ToRay(L, 1);
				RaycastHit[] results7 = ToLua.ToStructArray<RaycastHit>(L, 2);
				float maxDistance5 = (float)LuaDLL.lua_tonumber(L, 3);
				int layerMask3 = (int)LuaDLL.lua_tonumber(L, 4);
				QueryTriggerInteraction queryTriggerInteraction = (QueryTriggerInteraction)ToLua.ToObject(L, 5);
				int n7 = Physics.RaycastNonAlloc(ray4, results7, maxDistance5, layerMask3, queryTriggerInteraction);
				LuaDLL.lua_pushinteger(L, n7);
				return 1;
			}
			if (num == 6)
			{
				Vector3 origin4 = ToLua.ToVector3(L, 1);
				Vector3 direction4 = ToLua.ToVector3(L, 2);
				RaycastHit[] results8 = ToLua.CheckStructArray<RaycastHit>(L, 3);
				float maxDistance6 = (float)LuaDLL.luaL_checknumber(L, 4);
				int layerMask4 = (int)LuaDLL.luaL_checknumber(L, 5);
				QueryTriggerInteraction queryTriggerInteraction2 = (QueryTriggerInteraction)ToLua.CheckObject(L, 6, typeof(QueryTriggerInteraction));
				int n8 = Physics.RaycastNonAlloc(origin4, direction4, results8, maxDistance6, layerMask4, queryTriggerInteraction2);
				LuaDLL.lua_pushinteger(L, n8);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics.RaycastNonAlloc");
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
			case 4:
			{
				Vector3 point7 = ToLua.ToVector3(L, 1);
				Vector3 point8 = ToLua.ToVector3(L, 2);
				float radius4 = (float)LuaDLL.luaL_checknumber(L, 3);
				Vector3 direction4 = ToLua.ToVector3(L, 4);
				RaycastHit[] array4 = Physics.CapsuleCastAll(point7, point8, radius4, direction4);
				ToLua.Push(L, array4);
				return 1;
			}
			case 5:
			{
				Vector3 point5 = ToLua.ToVector3(L, 1);
				Vector3 point6 = ToLua.ToVector3(L, 2);
				float radius3 = (float)LuaDLL.luaL_checknumber(L, 3);
				Vector3 direction3 = ToLua.ToVector3(L, 4);
				float maxDistance3 = (float)LuaDLL.luaL_checknumber(L, 5);
				RaycastHit[] array3 = Physics.CapsuleCastAll(point5, point6, radius3, direction3, maxDistance3);
				ToLua.Push(L, array3);
				return 1;
			}
			case 6:
			{
				Vector3 point3 = ToLua.ToVector3(L, 1);
				Vector3 point4 = ToLua.ToVector3(L, 2);
				float radius2 = (float)LuaDLL.luaL_checknumber(L, 3);
				Vector3 direction2 = ToLua.ToVector3(L, 4);
				float maxDistance2 = (float)LuaDLL.luaL_checknumber(L, 5);
				int layerMask2 = (int)LuaDLL.luaL_checknumber(L, 6);
				RaycastHit[] array2 = Physics.CapsuleCastAll(point3, point4, radius2, direction2, maxDistance2, layerMask2);
				ToLua.Push(L, array2);
				return 1;
			}
			case 7:
			{
				Vector3 point = ToLua.ToVector3(L, 1);
				Vector3 point2 = ToLua.ToVector3(L, 2);
				float radius = (float)LuaDLL.luaL_checknumber(L, 3);
				Vector3 direction = ToLua.ToVector3(L, 4);
				float maxDistance = (float)LuaDLL.luaL_checknumber(L, 5);
				int layerMask = (int)LuaDLL.luaL_checknumber(L, 6);
				QueryTriggerInteraction queryTriggerInteraction = (QueryTriggerInteraction)ToLua.CheckObject(L, 7, typeof(QueryTriggerInteraction));
				RaycastHit[] array = Physics.CapsuleCastAll(point, point2, radius, direction, maxDistance, layerMask, queryTriggerInteraction);
				ToLua.Push(L, array);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics.CapsuleCastAll");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SphereCastAll(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			switch (num)
			{
			case 2:
			{
				Ray ray = ToLua.ToRay(L, 1);
				float radius2 = (float)LuaDLL.luaL_checknumber(L, 2);
				RaycastHit[] array2 = Physics.SphereCastAll(ray, radius2);
				ToLua.Push(L, array2);
				return 1;
			}
			case 3:
				if (TypeChecker.CheckTypes<Vector3, float, Vector3>(L, 1))
				{
					Vector3 origin = ToLua.ToVector3(L, 1);
					float radius = (float)LuaDLL.lua_tonumber(L, 2);
					Vector3 direction = ToLua.ToVector3(L, 3);
					RaycastHit[] array = Physics.SphereCastAll(origin, radius, direction);
					ToLua.Push(L, array);
					return 1;
				}
				break;
			}
			if (num == 3 && TypeChecker.CheckTypes<Ray, float, float>(L, 1))
			{
				Ray ray2 = ToLua.ToRay(L, 1);
				float radius3 = (float)LuaDLL.lua_tonumber(L, 2);
				float maxDistance = (float)LuaDLL.lua_tonumber(L, 3);
				RaycastHit[] array3 = Physics.SphereCastAll(ray2, radius3, maxDistance);
				ToLua.Push(L, array3);
				return 1;
			}
			if (num == 4 && TypeChecker.CheckTypes<Ray, float, float, int>(L, 1))
			{
				Ray ray3 = ToLua.ToRay(L, 1);
				float radius4 = (float)LuaDLL.lua_tonumber(L, 2);
				float maxDistance2 = (float)LuaDLL.lua_tonumber(L, 3);
				int layerMask = (int)LuaDLL.lua_tonumber(L, 4);
				RaycastHit[] array4 = Physics.SphereCastAll(ray3, radius4, maxDistance2, layerMask);
				ToLua.Push(L, array4);
				return 1;
			}
			if (num == 4 && TypeChecker.CheckTypes<Vector3, float, Vector3, float>(L, 1))
			{
				Vector3 origin2 = ToLua.ToVector3(L, 1);
				float radius5 = (float)LuaDLL.lua_tonumber(L, 2);
				Vector3 direction2 = ToLua.ToVector3(L, 3);
				float maxDistance3 = (float)LuaDLL.lua_tonumber(L, 4);
				RaycastHit[] array5 = Physics.SphereCastAll(origin2, radius5, direction2, maxDistance3);
				ToLua.Push(L, array5);
				return 1;
			}
			if (num == 5 && TypeChecker.CheckTypes<Vector3, float, Vector3, float, int>(L, 1))
			{
				Vector3 origin3 = ToLua.ToVector3(L, 1);
				float radius6 = (float)LuaDLL.lua_tonumber(L, 2);
				Vector3 direction3 = ToLua.ToVector3(L, 3);
				float maxDistance4 = (float)LuaDLL.lua_tonumber(L, 4);
				int layerMask2 = (int)LuaDLL.lua_tonumber(L, 5);
				RaycastHit[] array6 = Physics.SphereCastAll(origin3, radius6, direction3, maxDistance4, layerMask2);
				ToLua.Push(L, array6);
				return 1;
			}
			if (num == 5 && TypeChecker.CheckTypes<Ray, float, float, int, QueryTriggerInteraction>(L, 1))
			{
				Ray ray4 = ToLua.ToRay(L, 1);
				float radius7 = (float)LuaDLL.lua_tonumber(L, 2);
				float maxDistance5 = (float)LuaDLL.lua_tonumber(L, 3);
				int layerMask3 = (int)LuaDLL.lua_tonumber(L, 4);
				QueryTriggerInteraction queryTriggerInteraction = (QueryTriggerInteraction)ToLua.ToObject(L, 5);
				RaycastHit[] array7 = Physics.SphereCastAll(ray4, radius7, maxDistance5, layerMask3, queryTriggerInteraction);
				ToLua.Push(L, array7);
				return 1;
			}
			if (num == 6)
			{
				Vector3 origin4 = ToLua.ToVector3(L, 1);
				float radius8 = (float)LuaDLL.luaL_checknumber(L, 2);
				Vector3 direction4 = ToLua.ToVector3(L, 3);
				float maxDistance6 = (float)LuaDLL.luaL_checknumber(L, 4);
				int layerMask4 = (int)LuaDLL.luaL_checknumber(L, 5);
				QueryTriggerInteraction queryTriggerInteraction2 = (QueryTriggerInteraction)ToLua.CheckObject(L, 6, typeof(QueryTriggerInteraction));
				RaycastHit[] array8 = Physics.SphereCastAll(origin4, radius8, direction4, maxDistance6, layerMask4, queryTriggerInteraction2);
				ToLua.Push(L, array8);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics.SphereCastAll");
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
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				Vector3 point5 = ToLua.ToVector3(L, 1);
				Vector3 point6 = ToLua.ToVector3(L, 2);
				float radius3 = (float)LuaDLL.luaL_checknumber(L, 3);
				Collider[] array3 = Physics.OverlapCapsule(point5, point6, radius3);
				ToLua.Push(L, array3);
				return 1;
			}
			case 4:
			{
				Vector3 point3 = ToLua.ToVector3(L, 1);
				Vector3 point4 = ToLua.ToVector3(L, 2);
				float radius2 = (float)LuaDLL.luaL_checknumber(L, 3);
				int layerMask2 = (int)LuaDLL.luaL_checknumber(L, 4);
				Collider[] array2 = Physics.OverlapCapsule(point3, point4, radius2, layerMask2);
				ToLua.Push(L, array2);
				return 1;
			}
			case 5:
			{
				Vector3 point = ToLua.ToVector3(L, 1);
				Vector3 point2 = ToLua.ToVector3(L, 2);
				float radius = (float)LuaDLL.luaL_checknumber(L, 3);
				int layerMask = (int)LuaDLL.luaL_checknumber(L, 4);
				QueryTriggerInteraction queryTriggerInteraction = (QueryTriggerInteraction)ToLua.CheckObject(L, 5, typeof(QueryTriggerInteraction));
				Collider[] array = Physics.OverlapCapsule(point, point2, radius, layerMask, queryTriggerInteraction);
				ToLua.Push(L, array);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics.OverlapCapsule");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OverlapSphere(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Vector3 position3 = ToLua.ToVector3(L, 1);
				float radius3 = (float)LuaDLL.luaL_checknumber(L, 2);
				Collider[] array3 = Physics.OverlapSphere(position3, radius3);
				ToLua.Push(L, array3);
				return 1;
			}
			case 3:
			{
				Vector3 position2 = ToLua.ToVector3(L, 1);
				float radius2 = (float)LuaDLL.luaL_checknumber(L, 2);
				int layerMask2 = (int)LuaDLL.luaL_checknumber(L, 3);
				Collider[] array2 = Physics.OverlapSphere(position2, radius2, layerMask2);
				ToLua.Push(L, array2);
				return 1;
			}
			case 4:
			{
				Vector3 position = ToLua.ToVector3(L, 1);
				float radius = (float)LuaDLL.luaL_checknumber(L, 2);
				int layerMask = (int)LuaDLL.luaL_checknumber(L, 3);
				QueryTriggerInteraction queryTriggerInteraction = (QueryTriggerInteraction)ToLua.CheckObject(L, 4, typeof(QueryTriggerInteraction));
				Collider[] array = Physics.OverlapSphere(position, radius, layerMask, queryTriggerInteraction);
				ToLua.Push(L, array);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics.OverlapSphere");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Simulate(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Physics.Simulate((float)LuaDLL.luaL_checknumber(L, 1));
			return 0;
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
			Physics.SyncTransforms();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ComputePenetration(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 8);
			Collider colliderA = (Collider)ToLua.CheckObject<Collider>(L, 1);
			Vector3 positionA = ToLua.ToVector3(L, 2);
			Quaternion rotationA = ToLua.ToQuaternion(L, 3);
			Collider colliderB = (Collider)ToLua.CheckObject<Collider>(L, 4);
			Vector3 positionB = ToLua.ToVector3(L, 5);
			Quaternion rotationB = ToLua.ToQuaternion(L, 6);
			bool value = Physics.ComputePenetration(colliderA, positionA, rotationA, colliderB, positionB, rotationB, out var direction, out var distance);
			LuaDLL.lua_pushboolean(L, value);
			ToLua.Push(L, direction);
			LuaDLL.lua_pushnumber(L, distance);
			return 3;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClosestPoint(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			Vector3 point = ToLua.ToVector3(L, 1);
			Collider collider = (Collider)ToLua.CheckObject<Collider>(L, 2);
			Vector3 position = ToLua.ToVector3(L, 3);
			Quaternion rotation = ToLua.ToQuaternion(L, 4);
			Vector3 v = Physics.ClosestPoint(point, collider, position, rotation);
			ToLua.Push(L, v);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OverlapSphereNonAlloc(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				Vector3 position3 = ToLua.ToVector3(L, 1);
				float radius3 = (float)LuaDLL.luaL_checknumber(L, 2);
				Collider[] results3 = null;
				int n3 = Physics.OverlapSphereNonAlloc(position3, radius3, results3);
				LuaDLL.lua_pushinteger(L, n3);
				return 1;
			}
			case 4:
			{
				Vector3 position2 = ToLua.ToVector3(L, 1);
				float radius2 = (float)LuaDLL.luaL_checknumber(L, 2);
				Collider[] results2 = null;
				int layerMask2 = (int)LuaDLL.luaL_checknumber(L, 4);
				int n2 = Physics.OverlapSphereNonAlloc(position2, radius2, results2, layerMask2);
				LuaDLL.lua_pushinteger(L, n2);
				return 1;
			}
			case 5:
			{
				Vector3 position = ToLua.ToVector3(L, 1);
				float radius = (float)LuaDLL.luaL_checknumber(L, 2);
				Collider[] results = null;
				int layerMask = (int)LuaDLL.luaL_checknumber(L, 4);
				QueryTriggerInteraction queryTriggerInteraction = (QueryTriggerInteraction)ToLua.CheckObject(L, 5, typeof(QueryTriggerInteraction));
				int n = Physics.OverlapSphereNonAlloc(position, radius, results, layerMask, queryTriggerInteraction);
				LuaDLL.lua_pushinteger(L, n);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics.OverlapSphereNonAlloc");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CheckSphere(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Vector3 position3 = ToLua.ToVector3(L, 1);
				float radius3 = (float)LuaDLL.luaL_checknumber(L, 2);
				bool value3 = Physics.CheckSphere(position3, radius3);
				LuaDLL.lua_pushboolean(L, value3);
				return 1;
			}
			case 3:
			{
				Vector3 position2 = ToLua.ToVector3(L, 1);
				float radius2 = (float)LuaDLL.luaL_checknumber(L, 2);
				int layerMask2 = (int)LuaDLL.luaL_checknumber(L, 3);
				bool value2 = Physics.CheckSphere(position2, radius2, layerMask2);
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			case 4:
			{
				Vector3 position = ToLua.ToVector3(L, 1);
				float radius = (float)LuaDLL.luaL_checknumber(L, 2);
				int layerMask = (int)LuaDLL.luaL_checknumber(L, 3);
				QueryTriggerInteraction queryTriggerInteraction = (QueryTriggerInteraction)ToLua.CheckObject(L, 4, typeof(QueryTriggerInteraction));
				bool value = Physics.CheckSphere(position, radius, layerMask, queryTriggerInteraction);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics.CheckSphere");
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
			case 5:
			{
				Vector3 point7 = ToLua.ToVector3(L, 1);
				Vector3 point8 = ToLua.ToVector3(L, 2);
				float radius4 = (float)LuaDLL.luaL_checknumber(L, 3);
				Vector3 direction4 = ToLua.ToVector3(L, 4);
				RaycastHit[] results4 = ToLua.CheckStructArray<RaycastHit>(L, 5);
				int n4 = Physics.CapsuleCastNonAlloc(point7, point8, radius4, direction4, results4);
				LuaDLL.lua_pushinteger(L, n4);
				return 1;
			}
			case 6:
			{
				Vector3 point5 = ToLua.ToVector3(L, 1);
				Vector3 point6 = ToLua.ToVector3(L, 2);
				float radius3 = (float)LuaDLL.luaL_checknumber(L, 3);
				Vector3 direction3 = ToLua.ToVector3(L, 4);
				RaycastHit[] results3 = ToLua.CheckStructArray<RaycastHit>(L, 5);
				float maxDistance3 = (float)LuaDLL.luaL_checknumber(L, 6);
				int n3 = Physics.CapsuleCastNonAlloc(point5, point6, radius3, direction3, results3, maxDistance3);
				LuaDLL.lua_pushinteger(L, n3);
				return 1;
			}
			case 7:
			{
				Vector3 point3 = ToLua.ToVector3(L, 1);
				Vector3 point4 = ToLua.ToVector3(L, 2);
				float radius2 = (float)LuaDLL.luaL_checknumber(L, 3);
				Vector3 direction2 = ToLua.ToVector3(L, 4);
				RaycastHit[] results2 = ToLua.CheckStructArray<RaycastHit>(L, 5);
				float maxDistance2 = (float)LuaDLL.luaL_checknumber(L, 6);
				int layerMask2 = (int)LuaDLL.luaL_checknumber(L, 7);
				int n2 = Physics.CapsuleCastNonAlloc(point3, point4, radius2, direction2, results2, maxDistance2, layerMask2);
				LuaDLL.lua_pushinteger(L, n2);
				return 1;
			}
			case 8:
			{
				Vector3 point = ToLua.ToVector3(L, 1);
				Vector3 point2 = ToLua.ToVector3(L, 2);
				float radius = (float)LuaDLL.luaL_checknumber(L, 3);
				Vector3 direction = ToLua.ToVector3(L, 4);
				RaycastHit[] results = ToLua.CheckStructArray<RaycastHit>(L, 5);
				float maxDistance = (float)LuaDLL.luaL_checknumber(L, 6);
				int layerMask = (int)LuaDLL.luaL_checknumber(L, 7);
				QueryTriggerInteraction queryTriggerInteraction = (QueryTriggerInteraction)ToLua.CheckObject(L, 8, typeof(QueryTriggerInteraction));
				int n = Physics.CapsuleCastNonAlloc(point, point2, radius, direction, results, maxDistance, layerMask, queryTriggerInteraction);
				LuaDLL.lua_pushinteger(L, n);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics.CapsuleCastNonAlloc");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SphereCastNonAlloc(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			switch (num)
			{
			case 3:
			{
				Ray ray = ToLua.ToRay(L, 1);
				float radius2 = (float)LuaDLL.luaL_checknumber(L, 2);
				RaycastHit[] results2 = ToLua.CheckStructArray<RaycastHit>(L, 3);
				int n2 = Physics.SphereCastNonAlloc(ray, radius2, results2);
				LuaDLL.lua_pushinteger(L, n2);
				return 1;
			}
			case 4:
				if (TypeChecker.CheckTypes<Vector3, float, Vector3, RaycastHit[]>(L, 1))
				{
					Vector3 origin = ToLua.ToVector3(L, 1);
					float radius = (float)LuaDLL.lua_tonumber(L, 2);
					Vector3 direction = ToLua.ToVector3(L, 3);
					RaycastHit[] results = ToLua.ToStructArray<RaycastHit>(L, 4);
					int n = Physics.SphereCastNonAlloc(origin, radius, direction, results);
					LuaDLL.lua_pushinteger(L, n);
					return 1;
				}
				break;
			}
			if (num == 4 && TypeChecker.CheckTypes<Ray, float, RaycastHit[], float>(L, 1))
			{
				Ray ray2 = ToLua.ToRay(L, 1);
				float radius3 = (float)LuaDLL.lua_tonumber(L, 2);
				RaycastHit[] results3 = ToLua.ToStructArray<RaycastHit>(L, 3);
				float maxDistance = (float)LuaDLL.lua_tonumber(L, 4);
				int n3 = Physics.SphereCastNonAlloc(ray2, radius3, results3, maxDistance);
				LuaDLL.lua_pushinteger(L, n3);
				return 1;
			}
			if (num == 5 && TypeChecker.CheckTypes<Ray, float, RaycastHit[], float, int>(L, 1))
			{
				Ray ray3 = ToLua.ToRay(L, 1);
				float radius4 = (float)LuaDLL.lua_tonumber(L, 2);
				RaycastHit[] results4 = ToLua.ToStructArray<RaycastHit>(L, 3);
				float maxDistance2 = (float)LuaDLL.lua_tonumber(L, 4);
				int layerMask = (int)LuaDLL.lua_tonumber(L, 5);
				int n4 = Physics.SphereCastNonAlloc(ray3, radius4, results4, maxDistance2, layerMask);
				LuaDLL.lua_pushinteger(L, n4);
				return 1;
			}
			if (num == 5 && TypeChecker.CheckTypes<Vector3, float, Vector3, RaycastHit[], float>(L, 1))
			{
				Vector3 origin2 = ToLua.ToVector3(L, 1);
				float radius5 = (float)LuaDLL.lua_tonumber(L, 2);
				Vector3 direction2 = ToLua.ToVector3(L, 3);
				RaycastHit[] results5 = ToLua.ToStructArray<RaycastHit>(L, 4);
				float maxDistance3 = (float)LuaDLL.lua_tonumber(L, 5);
				int n5 = Physics.SphereCastNonAlloc(origin2, radius5, direction2, results5, maxDistance3);
				LuaDLL.lua_pushinteger(L, n5);
				return 1;
			}
			if (num == 6 && TypeChecker.CheckTypes<Vector3, float, Vector3, RaycastHit[], float, int>(L, 1))
			{
				Vector3 origin3 = ToLua.ToVector3(L, 1);
				float radius6 = (float)LuaDLL.lua_tonumber(L, 2);
				Vector3 direction3 = ToLua.ToVector3(L, 3);
				RaycastHit[] results6 = ToLua.ToStructArray<RaycastHit>(L, 4);
				float maxDistance4 = (float)LuaDLL.lua_tonumber(L, 5);
				int layerMask2 = (int)LuaDLL.lua_tonumber(L, 6);
				int n6 = Physics.SphereCastNonAlloc(origin3, radius6, direction3, results6, maxDistance4, layerMask2);
				LuaDLL.lua_pushinteger(L, n6);
				return 1;
			}
			if (num == 6 && TypeChecker.CheckTypes<Ray, float, RaycastHit[], float, int, QueryTriggerInteraction>(L, 1))
			{
				Ray ray4 = ToLua.ToRay(L, 1);
				float radius7 = (float)LuaDLL.lua_tonumber(L, 2);
				RaycastHit[] results7 = ToLua.ToStructArray<RaycastHit>(L, 3);
				float maxDistance5 = (float)LuaDLL.lua_tonumber(L, 4);
				int layerMask3 = (int)LuaDLL.lua_tonumber(L, 5);
				QueryTriggerInteraction queryTriggerInteraction = (QueryTriggerInteraction)ToLua.ToObject(L, 6);
				int n7 = Physics.SphereCastNonAlloc(ray4, radius7, results7, maxDistance5, layerMask3, queryTriggerInteraction);
				LuaDLL.lua_pushinteger(L, n7);
				return 1;
			}
			if (num == 7)
			{
				Vector3 origin4 = ToLua.ToVector3(L, 1);
				float radius8 = (float)LuaDLL.luaL_checknumber(L, 2);
				Vector3 direction4 = ToLua.ToVector3(L, 3);
				RaycastHit[] results8 = ToLua.CheckStructArray<RaycastHit>(L, 4);
				float maxDistance6 = (float)LuaDLL.luaL_checknumber(L, 5);
				int layerMask4 = (int)LuaDLL.luaL_checknumber(L, 6);
				QueryTriggerInteraction queryTriggerInteraction2 = (QueryTriggerInteraction)ToLua.CheckObject(L, 7, typeof(QueryTriggerInteraction));
				int n8 = Physics.SphereCastNonAlloc(origin4, radius8, direction4, results8, maxDistance6, layerMask4, queryTriggerInteraction2);
				LuaDLL.lua_pushinteger(L, n8);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics.SphereCastNonAlloc");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CheckCapsule(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				Vector3 start3 = ToLua.ToVector3(L, 1);
				Vector3 end3 = ToLua.ToVector3(L, 2);
				float radius3 = (float)LuaDLL.luaL_checknumber(L, 3);
				bool value3 = Physics.CheckCapsule(start3, end3, radius3);
				LuaDLL.lua_pushboolean(L, value3);
				return 1;
			}
			case 4:
			{
				Vector3 start2 = ToLua.ToVector3(L, 1);
				Vector3 end2 = ToLua.ToVector3(L, 2);
				float radius2 = (float)LuaDLL.luaL_checknumber(L, 3);
				int layerMask2 = (int)LuaDLL.luaL_checknumber(L, 4);
				bool value2 = Physics.CheckCapsule(start2, end2, radius2, layerMask2);
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			case 5:
			{
				Vector3 start = ToLua.ToVector3(L, 1);
				Vector3 end = ToLua.ToVector3(L, 2);
				float radius = (float)LuaDLL.luaL_checknumber(L, 3);
				int layerMask = (int)LuaDLL.luaL_checknumber(L, 4);
				QueryTriggerInteraction queryTriggerInteraction = (QueryTriggerInteraction)ToLua.CheckObject(L, 5, typeof(QueryTriggerInteraction));
				bool value = Physics.CheckCapsule(start, end, radius, layerMask, queryTriggerInteraction);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics.CheckCapsule");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CheckBox(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Vector3 center4 = ToLua.ToVector3(L, 1);
				Vector3 halfExtents4 = ToLua.ToVector3(L, 2);
				bool value4 = Physics.CheckBox(center4, halfExtents4);
				LuaDLL.lua_pushboolean(L, value4);
				return 1;
			}
			case 3:
			{
				Vector3 center3 = ToLua.ToVector3(L, 1);
				Vector3 halfExtents3 = ToLua.ToVector3(L, 2);
				Quaternion orientation3 = ToLua.ToQuaternion(L, 3);
				bool value3 = Physics.CheckBox(center3, halfExtents3, orientation3);
				LuaDLL.lua_pushboolean(L, value3);
				return 1;
			}
			case 4:
			{
				Vector3 center2 = ToLua.ToVector3(L, 1);
				Vector3 halfExtents2 = ToLua.ToVector3(L, 2);
				Quaternion orientation2 = ToLua.ToQuaternion(L, 3);
				int layerMask = (int)LuaDLL.luaL_checknumber(L, 4);
				bool value2 = Physics.CheckBox(center2, halfExtents2, orientation2, layerMask);
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			case 5:
			{
				Vector3 center = ToLua.ToVector3(L, 1);
				Vector3 halfExtents = ToLua.ToVector3(L, 2);
				Quaternion orientation = ToLua.ToQuaternion(L, 3);
				int layermask = (int)LuaDLL.luaL_checknumber(L, 4);
				QueryTriggerInteraction queryTriggerInteraction = (QueryTriggerInteraction)ToLua.CheckObject(L, 5, typeof(QueryTriggerInteraction));
				bool value = Physics.CheckBox(center, halfExtents, orientation, layermask, queryTriggerInteraction);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics.CheckBox");
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
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Vector3 center4 = ToLua.ToVector3(L, 1);
				Vector3 halfExtents4 = ToLua.ToVector3(L, 2);
				Collider[] array4 = Physics.OverlapBox(center4, halfExtents4);
				ToLua.Push(L, array4);
				return 1;
			}
			case 3:
			{
				Vector3 center3 = ToLua.ToVector3(L, 1);
				Vector3 halfExtents3 = ToLua.ToVector3(L, 2);
				Quaternion orientation3 = ToLua.ToQuaternion(L, 3);
				Collider[] array3 = Physics.OverlapBox(center3, halfExtents3, orientation3);
				ToLua.Push(L, array3);
				return 1;
			}
			case 4:
			{
				Vector3 center2 = ToLua.ToVector3(L, 1);
				Vector3 halfExtents2 = ToLua.ToVector3(L, 2);
				Quaternion orientation2 = ToLua.ToQuaternion(L, 3);
				int layerMask2 = (int)LuaDLL.luaL_checknumber(L, 4);
				Collider[] array2 = Physics.OverlapBox(center2, halfExtents2, orientation2, layerMask2);
				ToLua.Push(L, array2);
				return 1;
			}
			case 5:
			{
				Vector3 center = ToLua.ToVector3(L, 1);
				Vector3 halfExtents = ToLua.ToVector3(L, 2);
				Quaternion orientation = ToLua.ToQuaternion(L, 3);
				int layerMask = (int)LuaDLL.luaL_checknumber(L, 4);
				QueryTriggerInteraction queryTriggerInteraction = (QueryTriggerInteraction)ToLua.CheckObject(L, 5, typeof(QueryTriggerInteraction));
				Collider[] array = Physics.OverlapBox(center, halfExtents, orientation, layerMask, queryTriggerInteraction);
				ToLua.Push(L, array);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics.OverlapBox");
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
			case 3:
			{
				Vector3 center4 = ToLua.ToVector3(L, 1);
				Vector3 halfExtents4 = ToLua.ToVector3(L, 2);
				Collider[] results4 = null;
				int n4 = Physics.OverlapBoxNonAlloc(center4, halfExtents4, results4);
				LuaDLL.lua_pushinteger(L, n4);
				return 1;
			}
			case 4:
			{
				Vector3 center3 = ToLua.ToVector3(L, 1);
				Vector3 halfExtents3 = ToLua.ToVector3(L, 2);
				Collider[] results3 = null;
				Quaternion orientation3 = ToLua.ToQuaternion(L, 4);
				int n3 = Physics.OverlapBoxNonAlloc(center3, halfExtents3, results3, orientation3);
				LuaDLL.lua_pushinteger(L, n3);
				return 1;
			}
			case 5:
			{
				Vector3 center2 = ToLua.ToVector3(L, 1);
				Vector3 halfExtents2 = ToLua.ToVector3(L, 2);
				Collider[] results2 = null;
				Quaternion orientation2 = ToLua.ToQuaternion(L, 4);
				int mask2 = (int)LuaDLL.luaL_checknumber(L, 5);
				int n2 = Physics.OverlapBoxNonAlloc(center2, halfExtents2, results2, orientation2, mask2);
				LuaDLL.lua_pushinteger(L, n2);
				return 1;
			}
			case 6:
			{
				Vector3 center = ToLua.ToVector3(L, 1);
				Vector3 halfExtents = ToLua.ToVector3(L, 2);
				Collider[] results = null;
				Quaternion orientation = ToLua.ToQuaternion(L, 4);
				int mask = (int)LuaDLL.luaL_checknumber(L, 5);
				QueryTriggerInteraction queryTriggerInteraction = (QueryTriggerInteraction)ToLua.CheckObject(L, 6, typeof(QueryTriggerInteraction));
				int n = Physics.OverlapBoxNonAlloc(center, halfExtents, results, orientation, mask, queryTriggerInteraction);
				LuaDLL.lua_pushinteger(L, n);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics.OverlapBoxNonAlloc");
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
			case 4:
			{
				Vector3 center5 = ToLua.ToVector3(L, 1);
				Vector3 halfExtents5 = ToLua.ToVector3(L, 2);
				Vector3 direction5 = ToLua.ToVector3(L, 3);
				RaycastHit[] results5 = ToLua.CheckStructArray<RaycastHit>(L, 4);
				int n5 = Physics.BoxCastNonAlloc(center5, halfExtents5, direction5, results5);
				LuaDLL.lua_pushinteger(L, n5);
				return 1;
			}
			case 5:
			{
				Vector3 center4 = ToLua.ToVector3(L, 1);
				Vector3 halfExtents4 = ToLua.ToVector3(L, 2);
				Vector3 direction4 = ToLua.ToVector3(L, 3);
				RaycastHit[] results4 = ToLua.CheckStructArray<RaycastHit>(L, 4);
				Quaternion orientation4 = ToLua.ToQuaternion(L, 5);
				int n4 = Physics.BoxCastNonAlloc(center4, halfExtents4, direction4, results4, orientation4);
				LuaDLL.lua_pushinteger(L, n4);
				return 1;
			}
			case 6:
			{
				Vector3 center3 = ToLua.ToVector3(L, 1);
				Vector3 halfExtents3 = ToLua.ToVector3(L, 2);
				Vector3 direction3 = ToLua.ToVector3(L, 3);
				RaycastHit[] results3 = ToLua.CheckStructArray<RaycastHit>(L, 4);
				Quaternion orientation3 = ToLua.ToQuaternion(L, 5);
				float maxDistance3 = (float)LuaDLL.luaL_checknumber(L, 6);
				int n3 = Physics.BoxCastNonAlloc(center3, halfExtents3, direction3, results3, orientation3, maxDistance3);
				LuaDLL.lua_pushinteger(L, n3);
				return 1;
			}
			case 7:
			{
				Vector3 center2 = ToLua.ToVector3(L, 1);
				Vector3 halfExtents2 = ToLua.ToVector3(L, 2);
				Vector3 direction2 = ToLua.ToVector3(L, 3);
				RaycastHit[] results2 = ToLua.CheckStructArray<RaycastHit>(L, 4);
				Quaternion orientation2 = ToLua.ToQuaternion(L, 5);
				float maxDistance2 = (float)LuaDLL.luaL_checknumber(L, 6);
				int layerMask2 = (int)LuaDLL.luaL_checknumber(L, 7);
				int n2 = Physics.BoxCastNonAlloc(center2, halfExtents2, direction2, results2, orientation2, maxDistance2, layerMask2);
				LuaDLL.lua_pushinteger(L, n2);
				return 1;
			}
			case 8:
			{
				Vector3 center = ToLua.ToVector3(L, 1);
				Vector3 halfExtents = ToLua.ToVector3(L, 2);
				Vector3 direction = ToLua.ToVector3(L, 3);
				RaycastHit[] results = ToLua.CheckStructArray<RaycastHit>(L, 4);
				Quaternion orientation = ToLua.ToQuaternion(L, 5);
				float maxDistance = (float)LuaDLL.luaL_checknumber(L, 6);
				int layerMask = (int)LuaDLL.luaL_checknumber(L, 7);
				QueryTriggerInteraction queryTriggerInteraction = (QueryTriggerInteraction)ToLua.CheckObject(L, 8, typeof(QueryTriggerInteraction));
				int n = Physics.BoxCastNonAlloc(center, halfExtents, direction, results, orientation, maxDistance, layerMask, queryTriggerInteraction);
				LuaDLL.lua_pushinteger(L, n);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics.BoxCastNonAlloc");
			}
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
			case 3:
			{
				Vector3 center5 = ToLua.ToVector3(L, 1);
				Vector3 halfExtents5 = ToLua.ToVector3(L, 2);
				Vector3 direction5 = ToLua.ToVector3(L, 3);
				RaycastHit[] array5 = Physics.BoxCastAll(center5, halfExtents5, direction5);
				ToLua.Push(L, array5);
				return 1;
			}
			case 4:
			{
				Vector3 center4 = ToLua.ToVector3(L, 1);
				Vector3 halfExtents4 = ToLua.ToVector3(L, 2);
				Vector3 direction4 = ToLua.ToVector3(L, 3);
				Quaternion orientation4 = ToLua.ToQuaternion(L, 4);
				RaycastHit[] array4 = Physics.BoxCastAll(center4, halfExtents4, direction4, orientation4);
				ToLua.Push(L, array4);
				return 1;
			}
			case 5:
			{
				Vector3 center3 = ToLua.ToVector3(L, 1);
				Vector3 halfExtents3 = ToLua.ToVector3(L, 2);
				Vector3 direction3 = ToLua.ToVector3(L, 3);
				Quaternion orientation3 = ToLua.ToQuaternion(L, 4);
				float maxDistance3 = (float)LuaDLL.luaL_checknumber(L, 5);
				RaycastHit[] array3 = Physics.BoxCastAll(center3, halfExtents3, direction3, orientation3, maxDistance3);
				ToLua.Push(L, array3);
				return 1;
			}
			case 6:
			{
				Vector3 center2 = ToLua.ToVector3(L, 1);
				Vector3 halfExtents2 = ToLua.ToVector3(L, 2);
				Vector3 direction2 = ToLua.ToVector3(L, 3);
				Quaternion orientation2 = ToLua.ToQuaternion(L, 4);
				float maxDistance2 = (float)LuaDLL.luaL_checknumber(L, 5);
				int layerMask2 = (int)LuaDLL.luaL_checknumber(L, 6);
				RaycastHit[] array2 = Physics.BoxCastAll(center2, halfExtents2, direction2, orientation2, maxDistance2, layerMask2);
				ToLua.Push(L, array2);
				return 1;
			}
			case 7:
			{
				Vector3 center = ToLua.ToVector3(L, 1);
				Vector3 halfExtents = ToLua.ToVector3(L, 2);
				Vector3 direction = ToLua.ToVector3(L, 3);
				Quaternion orientation = ToLua.ToQuaternion(L, 4);
				float maxDistance = (float)LuaDLL.luaL_checknumber(L, 5);
				int layerMask = (int)LuaDLL.luaL_checknumber(L, 6);
				QueryTriggerInteraction queryTriggerInteraction = (QueryTriggerInteraction)ToLua.CheckObject(L, 7, typeof(QueryTriggerInteraction));
				RaycastHit[] array = Physics.BoxCastAll(center, halfExtents, direction, orientation, maxDistance, layerMask, queryTriggerInteraction);
				ToLua.Push(L, array);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics.BoxCastAll");
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
			case 4:
			{
				Vector3 point5 = ToLua.ToVector3(L, 1);
				Vector3 point6 = ToLua.ToVector3(L, 2);
				float radius3 = (float)LuaDLL.luaL_checknumber(L, 3);
				Collider[] results3 = null;
				int n3 = Physics.OverlapCapsuleNonAlloc(point5, point6, radius3, results3);
				LuaDLL.lua_pushinteger(L, n3);
				return 1;
			}
			case 5:
			{
				Vector3 point3 = ToLua.ToVector3(L, 1);
				Vector3 point4 = ToLua.ToVector3(L, 2);
				float radius2 = (float)LuaDLL.luaL_checknumber(L, 3);
				Collider[] results2 = null;
				int layerMask2 = (int)LuaDLL.luaL_checknumber(L, 5);
				int n2 = Physics.OverlapCapsuleNonAlloc(point3, point4, radius2, results2, layerMask2);
				LuaDLL.lua_pushinteger(L, n2);
				return 1;
			}
			case 6:
			{
				Vector3 point = ToLua.ToVector3(L, 1);
				Vector3 point2 = ToLua.ToVector3(L, 2);
				float radius = (float)LuaDLL.luaL_checknumber(L, 3);
				Collider[] results = null;
				int layerMask = (int)LuaDLL.luaL_checknumber(L, 5);
				QueryTriggerInteraction queryTriggerInteraction = (QueryTriggerInteraction)ToLua.CheckObject(L, 6, typeof(QueryTriggerInteraction));
				int n = Physics.OverlapCapsuleNonAlloc(point, point2, radius, results, layerMask, queryTriggerInteraction);
				LuaDLL.lua_pushinteger(L, n);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Physics.OverlapCapsuleNonAlloc");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RebuildBroadphaseRegions(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Bounds worldBounds = ToLua.ToBounds(L, 1);
			int subdivisions = (int)LuaDLL.luaL_checknumber(L, 2);
			Physics.RebuildBroadphaseRegions(worldBounds, subdivisions);
			return 0;
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
			ToLua.Push(L, Physics.gravity);
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
			LuaDLL.lua_pushnumber(L, Physics.defaultContactOffset);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_sleepThreshold(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, Physics.sleepThreshold);
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
			LuaDLL.lua_pushboolean(L, Physics.queriesHitTriggers);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_queriesHitBackfaces(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, Physics.queriesHitBackfaces);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_bounceThreshold(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, Physics.bounceThreshold);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_defaultSolverIterations(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, Physics.defaultSolverIterations);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_defaultSolverVelocityIterations(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, Physics.defaultSolverVelocityIterations);
			return 1;
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
			ToLua.PushValue(L, Physics.defaultPhysicsScene);
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
			LuaDLL.lua_pushboolean(L, Physics.autoSimulation);
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
			LuaDLL.lua_pushboolean(L, Physics.autoSyncTransforms);
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
			LuaDLL.lua_pushboolean(L, Physics.reuseCollisionCallbacks);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_interCollisionDistance(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, Physics.interCollisionDistance);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_interCollisionStiffness(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, Physics.interCollisionStiffness);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_interCollisionSettingsToggle(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, Physics.interCollisionSettingsToggle);
			return 1;
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
			Physics.gravity = ToLua.ToVector3(L, 2);
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
			Physics.defaultContactOffset = (float)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_sleepThreshold(IntPtr L)
	{
		try
		{
			Physics.sleepThreshold = (float)LuaDLL.luaL_checknumber(L, 2);
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
			Physics.queriesHitTriggers = LuaDLL.luaL_checkboolean(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_queriesHitBackfaces(IntPtr L)
	{
		try
		{
			Physics.queriesHitBackfaces = LuaDLL.luaL_checkboolean(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_bounceThreshold(IntPtr L)
	{
		try
		{
			Physics.bounceThreshold = (float)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_defaultSolverIterations(IntPtr L)
	{
		try
		{
			Physics.defaultSolverIterations = (int)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_defaultSolverVelocityIterations(IntPtr L)
	{
		try
		{
			Physics.defaultSolverVelocityIterations = (int)LuaDLL.luaL_checknumber(L, 2);
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
			Physics.autoSimulation = LuaDLL.luaL_checkboolean(L, 2);
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
			Physics.autoSyncTransforms = LuaDLL.luaL_checkboolean(L, 2);
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
			Physics.reuseCollisionCallbacks = LuaDLL.luaL_checkboolean(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_interCollisionDistance(IntPtr L)
	{
		try
		{
			Physics.interCollisionDistance = (float)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_interCollisionStiffness(IntPtr L)
	{
		try
		{
			Physics.interCollisionStiffness = (float)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_interCollisionSettingsToggle(IntPtr L)
	{
		try
		{
			Physics.interCollisionSettingsToggle = LuaDLL.luaL_checkboolean(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
