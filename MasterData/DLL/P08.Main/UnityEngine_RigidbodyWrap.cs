using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_RigidbodyWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Rigidbody), typeof(Component));
		L.RegFunction("SetDensity", SetDensity);
		L.RegFunction("MovePosition", MovePosition);
		L.RegFunction("MoveRotation", MoveRotation);
		L.RegFunction("Sleep", Sleep);
		L.RegFunction("IsSleeping", IsSleeping);
		L.RegFunction("WakeUp", WakeUp);
		L.RegFunction("ResetCenterOfMass", ResetCenterOfMass);
		L.RegFunction("ResetInertiaTensor", ResetInertiaTensor);
		L.RegFunction("GetRelativePointVelocity", GetRelativePointVelocity);
		L.RegFunction("GetPointVelocity", GetPointVelocity);
		L.RegFunction("AddForce", AddForce);
		L.RegFunction("AddRelativeForce", AddRelativeForce);
		L.RegFunction("AddTorque", AddTorque);
		L.RegFunction("AddRelativeTorque", AddRelativeTorque);
		L.RegFunction("AddForceAtPosition", AddForceAtPosition);
		L.RegFunction("AddExplosionForce", AddExplosionForce);
		L.RegFunction("ClosestPointOnBounds", ClosestPointOnBounds);
		L.RegFunction("SweepTest", SweepTest);
		L.RegFunction("SweepTestAll", SweepTestAll);
		L.RegFunction("New", _CreateUnityEngine_Rigidbody);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("velocity", get_velocity, set_velocity);
		L.RegVar("angularVelocity", get_angularVelocity, set_angularVelocity);
		L.RegVar("drag", get_drag, set_drag);
		L.RegVar("angularDrag", get_angularDrag, set_angularDrag);
		L.RegVar("mass", get_mass, set_mass);
		L.RegVar("useGravity", get_useGravity, set_useGravity);
		L.RegVar("maxDepenetrationVelocity", get_maxDepenetrationVelocity, set_maxDepenetrationVelocity);
		L.RegVar("isKinematic", get_isKinematic, set_isKinematic);
		L.RegVar("freezeRotation", get_freezeRotation, set_freezeRotation);
		L.RegVar("constraints", get_constraints, set_constraints);
		L.RegVar("collisionDetectionMode", get_collisionDetectionMode, set_collisionDetectionMode);
		L.RegVar("centerOfMass", get_centerOfMass, set_centerOfMass);
		L.RegVar("worldCenterOfMass", get_worldCenterOfMass, null);
		L.RegVar("inertiaTensorRotation", get_inertiaTensorRotation, set_inertiaTensorRotation);
		L.RegVar("inertiaTensor", get_inertiaTensor, set_inertiaTensor);
		L.RegVar("detectCollisions", get_detectCollisions, set_detectCollisions);
		L.RegVar("position", get_position, set_position);
		L.RegVar("rotation", get_rotation, set_rotation);
		L.RegVar("interpolation", get_interpolation, set_interpolation);
		L.RegVar("solverIterations", get_solverIterations, set_solverIterations);
		L.RegVar("sleepThreshold", get_sleepThreshold, set_sleepThreshold);
		L.RegVar("maxAngularVelocity", get_maxAngularVelocity, set_maxAngularVelocity);
		L.RegVar("solverVelocityIterations", get_solverVelocityIterations, set_solverVelocityIterations);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_Rigidbody(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				Rigidbody obj = new Rigidbody();
				ToLua.Push(L, obj);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.Rigidbody.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetDensity(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Rigidbody obj = (Rigidbody)ToLua.CheckObject<Rigidbody>(L, 1);
			float density = (float)LuaDLL.luaL_checknumber(L, 2);
			obj.SetDensity(density);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int MovePosition(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Rigidbody obj = (Rigidbody)ToLua.CheckObject<Rigidbody>(L, 1);
			Vector3 position = ToLua.ToVector3(L, 2);
			obj.MovePosition(position);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int MoveRotation(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Rigidbody obj = (Rigidbody)ToLua.CheckObject<Rigidbody>(L, 1);
			Quaternion rot = ToLua.ToQuaternion(L, 2);
			obj.MoveRotation(rot);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Sleep(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Rigidbody)ToLua.CheckObject<Rigidbody>(L, 1)).Sleep();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsSleeping(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((Rigidbody)ToLua.CheckObject<Rigidbody>(L, 1)).IsSleeping();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int WakeUp(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Rigidbody)ToLua.CheckObject<Rigidbody>(L, 1)).WakeUp();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ResetCenterOfMass(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Rigidbody)ToLua.CheckObject<Rigidbody>(L, 1)).ResetCenterOfMass();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ResetInertiaTensor(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Rigidbody)ToLua.CheckObject<Rigidbody>(L, 1)).ResetInertiaTensor();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetRelativePointVelocity(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Rigidbody obj = (Rigidbody)ToLua.CheckObject<Rigidbody>(L, 1);
			Vector3 relativePoint = ToLua.ToVector3(L, 2);
			Vector3 relativePointVelocity = obj.GetRelativePointVelocity(relativePoint);
			ToLua.Push(L, relativePointVelocity);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetPointVelocity(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Rigidbody obj = (Rigidbody)ToLua.CheckObject<Rigidbody>(L, 1);
			Vector3 worldPoint = ToLua.ToVector3(L, 2);
			Vector3 pointVelocity = obj.GetPointVelocity(worldPoint);
			ToLua.Push(L, pointVelocity);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddForce(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Rigidbody obj4 = (Rigidbody)ToLua.CheckObject<Rigidbody>(L, 1);
				Vector3 force2 = ToLua.ToVector3(L, 2);
				obj4.AddForce(force2);
				return 0;
			}
			case 3:
			{
				Rigidbody obj3 = (Rigidbody)ToLua.CheckObject<Rigidbody>(L, 1);
				Vector3 force = ToLua.ToVector3(L, 2);
				ForceMode mode2 = (ForceMode)ToLua.CheckObject(L, 3, typeof(ForceMode));
				obj3.AddForce(force, mode2);
				return 0;
			}
			case 4:
			{
				Rigidbody obj2 = (Rigidbody)ToLua.CheckObject<Rigidbody>(L, 1);
				float x2 = (float)LuaDLL.luaL_checknumber(L, 2);
				float y2 = (float)LuaDLL.luaL_checknumber(L, 3);
				float z2 = (float)LuaDLL.luaL_checknumber(L, 4);
				obj2.AddForce(x2, y2, z2);
				return 0;
			}
			case 5:
			{
				Rigidbody obj = (Rigidbody)ToLua.CheckObject<Rigidbody>(L, 1);
				float x = (float)LuaDLL.luaL_checknumber(L, 2);
				float y = (float)LuaDLL.luaL_checknumber(L, 3);
				float z = (float)LuaDLL.luaL_checknumber(L, 4);
				ForceMode mode = (ForceMode)ToLua.CheckObject(L, 5, typeof(ForceMode));
				obj.AddForce(x, y, z, mode);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Rigidbody.AddForce");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddRelativeForce(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Rigidbody obj4 = (Rigidbody)ToLua.CheckObject<Rigidbody>(L, 1);
				Vector3 force2 = ToLua.ToVector3(L, 2);
				obj4.AddRelativeForce(force2);
				return 0;
			}
			case 3:
			{
				Rigidbody obj3 = (Rigidbody)ToLua.CheckObject<Rigidbody>(L, 1);
				Vector3 force = ToLua.ToVector3(L, 2);
				ForceMode mode2 = (ForceMode)ToLua.CheckObject(L, 3, typeof(ForceMode));
				obj3.AddRelativeForce(force, mode2);
				return 0;
			}
			case 4:
			{
				Rigidbody obj2 = (Rigidbody)ToLua.CheckObject<Rigidbody>(L, 1);
				float x2 = (float)LuaDLL.luaL_checknumber(L, 2);
				float y2 = (float)LuaDLL.luaL_checknumber(L, 3);
				float z2 = (float)LuaDLL.luaL_checknumber(L, 4);
				obj2.AddRelativeForce(x2, y2, z2);
				return 0;
			}
			case 5:
			{
				Rigidbody obj = (Rigidbody)ToLua.CheckObject<Rigidbody>(L, 1);
				float x = (float)LuaDLL.luaL_checknumber(L, 2);
				float y = (float)LuaDLL.luaL_checknumber(L, 3);
				float z = (float)LuaDLL.luaL_checknumber(L, 4);
				ForceMode mode = (ForceMode)ToLua.CheckObject(L, 5, typeof(ForceMode));
				obj.AddRelativeForce(x, y, z, mode);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Rigidbody.AddRelativeForce");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddTorque(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Rigidbody obj4 = (Rigidbody)ToLua.CheckObject<Rigidbody>(L, 1);
				Vector3 torque2 = ToLua.ToVector3(L, 2);
				obj4.AddTorque(torque2);
				return 0;
			}
			case 3:
			{
				Rigidbody obj3 = (Rigidbody)ToLua.CheckObject<Rigidbody>(L, 1);
				Vector3 torque = ToLua.ToVector3(L, 2);
				ForceMode mode2 = (ForceMode)ToLua.CheckObject(L, 3, typeof(ForceMode));
				obj3.AddTorque(torque, mode2);
				return 0;
			}
			case 4:
			{
				Rigidbody obj2 = (Rigidbody)ToLua.CheckObject<Rigidbody>(L, 1);
				float x2 = (float)LuaDLL.luaL_checknumber(L, 2);
				float y2 = (float)LuaDLL.luaL_checknumber(L, 3);
				float z2 = (float)LuaDLL.luaL_checknumber(L, 4);
				obj2.AddTorque(x2, y2, z2);
				return 0;
			}
			case 5:
			{
				Rigidbody obj = (Rigidbody)ToLua.CheckObject<Rigidbody>(L, 1);
				float x = (float)LuaDLL.luaL_checknumber(L, 2);
				float y = (float)LuaDLL.luaL_checknumber(L, 3);
				float z = (float)LuaDLL.luaL_checknumber(L, 4);
				ForceMode mode = (ForceMode)ToLua.CheckObject(L, 5, typeof(ForceMode));
				obj.AddTorque(x, y, z, mode);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Rigidbody.AddTorque");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddRelativeTorque(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Rigidbody obj4 = (Rigidbody)ToLua.CheckObject<Rigidbody>(L, 1);
				Vector3 torque2 = ToLua.ToVector3(L, 2);
				obj4.AddRelativeTorque(torque2);
				return 0;
			}
			case 3:
			{
				Rigidbody obj3 = (Rigidbody)ToLua.CheckObject<Rigidbody>(L, 1);
				Vector3 torque = ToLua.ToVector3(L, 2);
				ForceMode mode2 = (ForceMode)ToLua.CheckObject(L, 3, typeof(ForceMode));
				obj3.AddRelativeTorque(torque, mode2);
				return 0;
			}
			case 4:
			{
				Rigidbody obj2 = (Rigidbody)ToLua.CheckObject<Rigidbody>(L, 1);
				float x2 = (float)LuaDLL.luaL_checknumber(L, 2);
				float y2 = (float)LuaDLL.luaL_checknumber(L, 3);
				float z2 = (float)LuaDLL.luaL_checknumber(L, 4);
				obj2.AddRelativeTorque(x2, y2, z2);
				return 0;
			}
			case 5:
			{
				Rigidbody obj = (Rigidbody)ToLua.CheckObject<Rigidbody>(L, 1);
				float x = (float)LuaDLL.luaL_checknumber(L, 2);
				float y = (float)LuaDLL.luaL_checknumber(L, 3);
				float z = (float)LuaDLL.luaL_checknumber(L, 4);
				ForceMode mode = (ForceMode)ToLua.CheckObject(L, 5, typeof(ForceMode));
				obj.AddRelativeTorque(x, y, z, mode);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Rigidbody.AddRelativeTorque");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddForceAtPosition(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				Rigidbody obj2 = (Rigidbody)ToLua.CheckObject<Rigidbody>(L, 1);
				Vector3 force2 = ToLua.ToVector3(L, 2);
				Vector3 position2 = ToLua.ToVector3(L, 3);
				obj2.AddForceAtPosition(force2, position2);
				return 0;
			}
			case 4:
			{
				Rigidbody obj = (Rigidbody)ToLua.CheckObject<Rigidbody>(L, 1);
				Vector3 force = ToLua.ToVector3(L, 2);
				Vector3 position = ToLua.ToVector3(L, 3);
				ForceMode mode = (ForceMode)ToLua.CheckObject(L, 4, typeof(ForceMode));
				obj.AddForceAtPosition(force, position, mode);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Rigidbody.AddForceAtPosition");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddExplosionForce(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 4:
			{
				Rigidbody obj3 = (Rigidbody)ToLua.CheckObject<Rigidbody>(L, 1);
				float explosionForce3 = (float)LuaDLL.luaL_checknumber(L, 2);
				Vector3 explosionPosition3 = ToLua.ToVector3(L, 3);
				float explosionRadius3 = (float)LuaDLL.luaL_checknumber(L, 4);
				obj3.AddExplosionForce(explosionForce3, explosionPosition3, explosionRadius3);
				return 0;
			}
			case 5:
			{
				Rigidbody obj2 = (Rigidbody)ToLua.CheckObject<Rigidbody>(L, 1);
				float explosionForce2 = (float)LuaDLL.luaL_checknumber(L, 2);
				Vector3 explosionPosition2 = ToLua.ToVector3(L, 3);
				float explosionRadius2 = (float)LuaDLL.luaL_checknumber(L, 4);
				float upwardsModifier2 = (float)LuaDLL.luaL_checknumber(L, 5);
				obj2.AddExplosionForce(explosionForce2, explosionPosition2, explosionRadius2, upwardsModifier2);
				return 0;
			}
			case 6:
			{
				Rigidbody obj = (Rigidbody)ToLua.CheckObject<Rigidbody>(L, 1);
				float explosionForce = (float)LuaDLL.luaL_checknumber(L, 2);
				Vector3 explosionPosition = ToLua.ToVector3(L, 3);
				float explosionRadius = (float)LuaDLL.luaL_checknumber(L, 4);
				float upwardsModifier = (float)LuaDLL.luaL_checknumber(L, 5);
				ForceMode mode = (ForceMode)ToLua.CheckObject(L, 6, typeof(ForceMode));
				obj.AddExplosionForce(explosionForce, explosionPosition, explosionRadius, upwardsModifier, mode);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Rigidbody.AddExplosionForce");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClosestPointOnBounds(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Rigidbody obj = (Rigidbody)ToLua.CheckObject<Rigidbody>(L, 1);
			Vector3 position = ToLua.ToVector3(L, 2);
			Vector3 v = obj.ClosestPointOnBounds(position);
			ToLua.Push(L, v);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SweepTest(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				Rigidbody obj3 = (Rigidbody)ToLua.CheckObject<Rigidbody>(L, 1);
				Vector3 direction3 = ToLua.ToVector3(L, 2);
				bool value3 = obj3.SweepTest(direction3, out var hitInfo3);
				LuaDLL.lua_pushboolean(L, value3);
				ToLua.Push(L, hitInfo3);
				return 2;
			}
			case 4:
			{
				Rigidbody obj2 = (Rigidbody)ToLua.CheckObject<Rigidbody>(L, 1);
				Vector3 direction2 = ToLua.ToVector3(L, 2);
				float maxDistance2 = (float)LuaDLL.luaL_checknumber(L, 4);
				bool value2 = obj2.SweepTest(direction2, out var hitInfo2, maxDistance2);
				LuaDLL.lua_pushboolean(L, value2);
				ToLua.Push(L, hitInfo2);
				return 2;
			}
			case 5:
			{
				Rigidbody obj = (Rigidbody)ToLua.CheckObject<Rigidbody>(L, 1);
				Vector3 direction = ToLua.ToVector3(L, 2);
				float maxDistance = (float)LuaDLL.luaL_checknumber(L, 4);
				QueryTriggerInteraction queryTriggerInteraction = (QueryTriggerInteraction)ToLua.CheckObject(L, 5, typeof(QueryTriggerInteraction));
				bool value = obj.SweepTest(direction, out var hitInfo, maxDistance, queryTriggerInteraction);
				LuaDLL.lua_pushboolean(L, value);
				ToLua.Push(L, hitInfo);
				return 2;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Rigidbody.SweepTest");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SweepTestAll(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Rigidbody obj3 = (Rigidbody)ToLua.CheckObject<Rigidbody>(L, 1);
				Vector3 direction3 = ToLua.ToVector3(L, 2);
				RaycastHit[] array3 = obj3.SweepTestAll(direction3);
				ToLua.Push(L, array3);
				return 1;
			}
			case 3:
			{
				Rigidbody obj2 = (Rigidbody)ToLua.CheckObject<Rigidbody>(L, 1);
				Vector3 direction2 = ToLua.ToVector3(L, 2);
				float maxDistance2 = (float)LuaDLL.luaL_checknumber(L, 3);
				RaycastHit[] array2 = obj2.SweepTestAll(direction2, maxDistance2);
				ToLua.Push(L, array2);
				return 1;
			}
			case 4:
			{
				Rigidbody obj = (Rigidbody)ToLua.CheckObject<Rigidbody>(L, 1);
				Vector3 direction = ToLua.ToVector3(L, 2);
				float maxDistance = (float)LuaDLL.luaL_checknumber(L, 3);
				QueryTriggerInteraction queryTriggerInteraction = (QueryTriggerInteraction)ToLua.CheckObject(L, 4, typeof(QueryTriggerInteraction));
				RaycastHit[] array = obj.SweepTestAll(direction, maxDistance, queryTriggerInteraction);
				ToLua.Push(L, array);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Rigidbody.SweepTestAll");
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

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_velocity(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3 velocity = ((Rigidbody)obj).velocity;
			ToLua.Push(L, velocity);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index velocity on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_angularVelocity(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3 angularVelocity = ((Rigidbody)obj).angularVelocity;
			ToLua.Push(L, angularVelocity);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index angularVelocity on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_drag(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float drag = ((Rigidbody)obj).drag;
			LuaDLL.lua_pushnumber(L, drag);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index drag on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_angularDrag(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float angularDrag = ((Rigidbody)obj).angularDrag;
			LuaDLL.lua_pushnumber(L, angularDrag);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index angularDrag on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mass(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float mass = ((Rigidbody)obj).mass;
			LuaDLL.lua_pushnumber(L, mass);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mass on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_useGravity(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool useGravity = ((Rigidbody)obj).useGravity;
			LuaDLL.lua_pushboolean(L, useGravity);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useGravity on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maxDepenetrationVelocity(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float maxDepenetrationVelocity = ((Rigidbody)obj).maxDepenetrationVelocity;
			LuaDLL.lua_pushnumber(L, maxDepenetrationVelocity);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maxDepenetrationVelocity on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isKinematic(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isKinematic = ((Rigidbody)obj).isKinematic;
			LuaDLL.lua_pushboolean(L, isKinematic);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isKinematic on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_freezeRotation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool freezeRotation = ((Rigidbody)obj).freezeRotation;
			LuaDLL.lua_pushboolean(L, freezeRotation);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index freezeRotation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_constraints(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RigidbodyConstraints constraints = ((Rigidbody)obj).constraints;
			ToLua.Push(L, constraints);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index constraints on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_collisionDetectionMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CollisionDetectionMode collisionDetectionMode = ((Rigidbody)obj).collisionDetectionMode;
			ToLua.Push(L, collisionDetectionMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index collisionDetectionMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_centerOfMass(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3 centerOfMass = ((Rigidbody)obj).centerOfMass;
			ToLua.Push(L, centerOfMass);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index centerOfMass on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_worldCenterOfMass(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3 worldCenterOfMass = ((Rigidbody)obj).worldCenterOfMass;
			ToLua.Push(L, worldCenterOfMass);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index worldCenterOfMass on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_inertiaTensorRotation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Quaternion inertiaTensorRotation = ((Rigidbody)obj).inertiaTensorRotation;
			ToLua.Push(L, inertiaTensorRotation);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index inertiaTensorRotation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_inertiaTensor(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3 inertiaTensor = ((Rigidbody)obj).inertiaTensor;
			ToLua.Push(L, inertiaTensor);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index inertiaTensor on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_detectCollisions(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool detectCollisions = ((Rigidbody)obj).detectCollisions;
			LuaDLL.lua_pushboolean(L, detectCollisions);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index detectCollisions on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_position(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3 position = ((Rigidbody)obj).position;
			ToLua.Push(L, position);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index position on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_rotation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Quaternion rotation = ((Rigidbody)obj).rotation;
			ToLua.Push(L, rotation);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rotation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_interpolation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RigidbodyInterpolation interpolation = ((Rigidbody)obj).interpolation;
			ToLua.Push(L, interpolation);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index interpolation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_solverIterations(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int solverIterations = ((Rigidbody)obj).solverIterations;
			LuaDLL.lua_pushinteger(L, solverIterations);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index solverIterations on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_sleepThreshold(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float sleepThreshold = ((Rigidbody)obj).sleepThreshold;
			LuaDLL.lua_pushnumber(L, sleepThreshold);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sleepThreshold on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maxAngularVelocity(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float maxAngularVelocity = ((Rigidbody)obj).maxAngularVelocity;
			LuaDLL.lua_pushnumber(L, maxAngularVelocity);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maxAngularVelocity on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_solverVelocityIterations(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int solverVelocityIterations = ((Rigidbody)obj).solverVelocityIterations;
			LuaDLL.lua_pushinteger(L, solverVelocityIterations);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index solverVelocityIterations on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_velocity(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Rigidbody obj2 = (Rigidbody)obj;
			Vector3 velocity = ToLua.ToVector3(L, 2);
			obj2.velocity = velocity;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index velocity on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_angularVelocity(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Rigidbody obj2 = (Rigidbody)obj;
			Vector3 angularVelocity = ToLua.ToVector3(L, 2);
			obj2.angularVelocity = angularVelocity;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index angularVelocity on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_drag(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Rigidbody obj2 = (Rigidbody)obj;
			float drag = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.drag = drag;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index drag on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_angularDrag(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Rigidbody obj2 = (Rigidbody)obj;
			float angularDrag = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.angularDrag = angularDrag;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index angularDrag on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mass(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Rigidbody obj2 = (Rigidbody)obj;
			float mass = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.mass = mass;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mass on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_useGravity(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Rigidbody obj2 = (Rigidbody)obj;
			bool useGravity = LuaDLL.luaL_checkboolean(L, 2);
			obj2.useGravity = useGravity;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index useGravity on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_maxDepenetrationVelocity(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Rigidbody obj2 = (Rigidbody)obj;
			float maxDepenetrationVelocity = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.maxDepenetrationVelocity = maxDepenetrationVelocity;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maxDepenetrationVelocity on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isKinematic(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Rigidbody obj2 = (Rigidbody)obj;
			bool isKinematic = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isKinematic = isKinematic;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isKinematic on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_freezeRotation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Rigidbody obj2 = (Rigidbody)obj;
			bool freezeRotation = LuaDLL.luaL_checkboolean(L, 2);
			obj2.freezeRotation = freezeRotation;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index freezeRotation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_constraints(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Rigidbody obj2 = (Rigidbody)obj;
			RigidbodyConstraints constraints = (RigidbodyConstraints)ToLua.CheckObject(L, 2, typeof(RigidbodyConstraints));
			obj2.constraints = constraints;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index constraints on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_collisionDetectionMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Rigidbody obj2 = (Rigidbody)obj;
			CollisionDetectionMode collisionDetectionMode = (CollisionDetectionMode)ToLua.CheckObject(L, 2, typeof(CollisionDetectionMode));
			obj2.collisionDetectionMode = collisionDetectionMode;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index collisionDetectionMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_centerOfMass(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Rigidbody obj2 = (Rigidbody)obj;
			Vector3 centerOfMass = ToLua.ToVector3(L, 2);
			obj2.centerOfMass = centerOfMass;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index centerOfMass on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_inertiaTensorRotation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Rigidbody obj2 = (Rigidbody)obj;
			Quaternion inertiaTensorRotation = ToLua.ToQuaternion(L, 2);
			obj2.inertiaTensorRotation = inertiaTensorRotation;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index inertiaTensorRotation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_inertiaTensor(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Rigidbody obj2 = (Rigidbody)obj;
			Vector3 inertiaTensor = ToLua.ToVector3(L, 2);
			obj2.inertiaTensor = inertiaTensor;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index inertiaTensor on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_detectCollisions(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Rigidbody obj2 = (Rigidbody)obj;
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
	private static int set_position(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Rigidbody obj2 = (Rigidbody)obj;
			Vector3 position = ToLua.ToVector3(L, 2);
			obj2.position = position;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index position on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_rotation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Rigidbody obj2 = (Rigidbody)obj;
			Quaternion rotation = ToLua.ToQuaternion(L, 2);
			obj2.rotation = rotation;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rotation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_interpolation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Rigidbody obj2 = (Rigidbody)obj;
			RigidbodyInterpolation interpolation = (RigidbodyInterpolation)ToLua.CheckObject(L, 2, typeof(RigidbodyInterpolation));
			obj2.interpolation = interpolation;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index interpolation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_solverIterations(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Rigidbody obj2 = (Rigidbody)obj;
			int solverIterations = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.solverIterations = solverIterations;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index solverIterations on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_sleepThreshold(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Rigidbody obj2 = (Rigidbody)obj;
			float sleepThreshold = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.sleepThreshold = sleepThreshold;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sleepThreshold on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_maxAngularVelocity(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Rigidbody obj2 = (Rigidbody)obj;
			float maxAngularVelocity = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.maxAngularVelocity = maxAngularVelocity;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maxAngularVelocity on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_solverVelocityIterations(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Rigidbody obj2 = (Rigidbody)obj;
			int solverVelocityIterations = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.solverVelocityIterations = solverVelocityIterations;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index solverVelocityIterations on a nil value");
		}
	}
}
