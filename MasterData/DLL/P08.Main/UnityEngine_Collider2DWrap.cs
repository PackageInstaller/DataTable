using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;

public class UnityEngine_Collider2DWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Collider2D), typeof(Behaviour));
		L.RegFunction("CreateMesh", CreateMesh);
		L.RegFunction("GetShapeHash", GetShapeHash);
		L.RegFunction("GetShapes", GetShapes);
		L.RegFunction("IsTouching", IsTouching);
		L.RegFunction("IsTouchingLayers", IsTouchingLayers);
		L.RegFunction("OverlapPoint", OverlapPoint);
		L.RegFunction("Distance", Distance);
		L.RegFunction("OverlapCollider", OverlapCollider);
		L.RegFunction("GetContacts", GetContacts);
		L.RegFunction("Cast", Cast);
		L.RegFunction("Raycast", Raycast);
		L.RegFunction("ClosestPoint", ClosestPoint);
		L.RegFunction("New", _CreateUnityEngine_Collider2D);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("density", get_density, set_density);
		L.RegVar("isTrigger", get_isTrigger, set_isTrigger);
		L.RegVar("usedByEffector", get_usedByEffector, set_usedByEffector);
		L.RegVar("usedByComposite", get_usedByComposite, set_usedByComposite);
		L.RegVar("composite", get_composite, null);
		L.RegVar("offset", get_offset, set_offset);
		L.RegVar("attachedRigidbody", get_attachedRigidbody, null);
		L.RegVar("shapeCount", get_shapeCount, null);
		L.RegVar("bounds", get_bounds, null);
		L.RegVar("errorState", get_errorState, null);
		L.RegVar("sharedMaterial", get_sharedMaterial, set_sharedMaterial);
		L.RegVar("friction", get_friction, null);
		L.RegVar("bounciness", get_bounciness, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_Collider2D(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				Collider2D obj = new Collider2D();
				ToLua.Push(L, obj);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.Collider2D.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CreateMesh(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Collider2D obj = (Collider2D)ToLua.CheckObject<Collider2D>(L, 1);
			bool useBodyPosition = LuaDLL.luaL_checkboolean(L, 2);
			bool useBodyRotation = LuaDLL.luaL_checkboolean(L, 3);
			Mesh o = obj.CreateMesh(useBodyPosition, useBodyRotation);
			ToLua.PushSealed(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetShapeHash(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			uint shapeHash = ((Collider2D)ToLua.CheckObject<Collider2D>(L, 1)).GetShapeHash();
			LuaDLL.lua_pushnumber(L, shapeHash);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetShapes(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Collider2D obj3 = (Collider2D)ToLua.CheckObject<Collider2D>(L, 1);
				PhysicsShapeGroup2D physicsShapeGroup3 = (PhysicsShapeGroup2D)ToLua.CheckObject<PhysicsShapeGroup2D>(L, 2);
				int shapes3 = obj3.GetShapes(physicsShapeGroup3);
				LuaDLL.lua_pushinteger(L, shapes3);
				return 1;
			}
			case 3:
			{
				Collider2D obj2 = (Collider2D)ToLua.CheckObject<Collider2D>(L, 1);
				PhysicsShapeGroup2D physicsShapeGroup2 = (PhysicsShapeGroup2D)ToLua.CheckObject<PhysicsShapeGroup2D>(L, 2);
				int shapeIndex2 = (int)LuaDLL.luaL_checknumber(L, 3);
				int shapes2 = obj2.GetShapes(physicsShapeGroup2, shapeIndex2);
				LuaDLL.lua_pushinteger(L, shapes2);
				return 1;
			}
			case 4:
			{
				Collider2D obj = (Collider2D)ToLua.CheckObject<Collider2D>(L, 1);
				PhysicsShapeGroup2D physicsShapeGroup = (PhysicsShapeGroup2D)ToLua.CheckObject<PhysicsShapeGroup2D>(L, 2);
				int shapeIndex = (int)LuaDLL.luaL_checknumber(L, 3);
				int shapeCount = (int)LuaDLL.luaL_checknumber(L, 4);
				int shapes = obj.GetShapes(physicsShapeGroup, shapeIndex, shapeCount);
				LuaDLL.lua_pushinteger(L, shapes);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Collider2D.GetShapes");
			}
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
				Collider2D obj = (Collider2D)ToLua.CheckObject<Collider2D>(L, 1);
				Collider2D collider = (Collider2D)ToLua.ToObject(L, 2);
				bool value = obj.IsTouching(collider);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<ContactFilter2D>(L, 2))
			{
				Collider2D obj2 = (Collider2D)ToLua.CheckObject<Collider2D>(L, 1);
				ContactFilter2D contactFilter = StackTraits<ContactFilter2D>.To(L, 2);
				bool value2 = obj2.IsTouching(contactFilter);
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			if (num == 3)
			{
				Collider2D obj3 = (Collider2D)ToLua.CheckObject<Collider2D>(L, 1);
				Collider2D collider2 = (Collider2D)ToLua.CheckObject<Collider2D>(L, 2);
				ContactFilter2D contactFilter2 = StackTraits<ContactFilter2D>.Check(L, 3);
				bool value3 = obj3.IsTouching(collider2, contactFilter2);
				LuaDLL.lua_pushboolean(L, value3);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Collider2D.IsTouching");
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
				bool value2 = ((Collider2D)ToLua.CheckObject<Collider2D>(L, 1)).IsTouchingLayers();
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			case 2:
			{
				Collider2D obj = (Collider2D)ToLua.CheckObject<Collider2D>(L, 1);
				int layerMask = (int)LuaDLL.luaL_checknumber(L, 2);
				bool value = obj.IsTouchingLayers(layerMask);
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Collider2D.IsTouchingLayers");
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
			ToLua.CheckArgsCount(L, 2);
			Collider2D obj = (Collider2D)ToLua.CheckObject<Collider2D>(L, 1);
			Vector2 point = ToLua.ToVector2(L, 2);
			bool value = obj.OverlapPoint(point);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
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
			Collider2D obj = (Collider2D)ToLua.CheckObject<Collider2D>(L, 1);
			Collider2D collider = (Collider2D)ToLua.CheckObject<Collider2D>(L, 2);
			ColliderDistance2D v = obj.Distance(collider);
			ToLua.PushValue(L, v);
			return 1;
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
			int num = LuaDLL.lua_gettop(L);
			if (num == 3 && TypeChecker.CheckTypes<Collider2D[]>(L, 3))
			{
				Collider2D obj = (Collider2D)ToLua.CheckObject<Collider2D>(L, 1);
				ContactFilter2D contactFilter = StackTraits<ContactFilter2D>.Check(L, 2);
				Collider2D[] results = ToLua.ToObjectArray<Collider2D>(L, 3);
				int n = obj.OverlapCollider(contactFilter, results);
				LuaDLL.lua_pushinteger(L, n);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<List<Collider2D>>(L, 3))
			{
				Collider2D obj2 = (Collider2D)ToLua.CheckObject<Collider2D>(L, 1);
				ContactFilter2D contactFilter2 = StackTraits<ContactFilter2D>.Check(L, 2);
				List<Collider2D> results2 = (List<Collider2D>)ToLua.ToObject(L, 3);
				int n2 = obj2.OverlapCollider(contactFilter2, results2);
				LuaDLL.lua_pushinteger(L, n2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Collider2D.OverlapCollider");
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
			if (num == 2 && TypeChecker.CheckTypes<ContactPoint2D[]>(L, 2))
			{
				Collider2D obj = (Collider2D)ToLua.CheckObject<Collider2D>(L, 1);
				ContactPoint2D[] contacts = ToLua.ToStructArray<ContactPoint2D>(L, 2);
				int contacts2 = obj.GetContacts(contacts);
				LuaDLL.lua_pushinteger(L, contacts2);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<List<ContactPoint2D>>(L, 2))
			{
				Collider2D obj2 = (Collider2D)ToLua.CheckObject<Collider2D>(L, 1);
				List<ContactPoint2D> contacts3 = (List<ContactPoint2D>)ToLua.ToObject(L, 2);
				int contacts4 = obj2.GetContacts(contacts3);
				LuaDLL.lua_pushinteger(L, contacts4);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<Collider2D[]>(L, 2))
			{
				Collider2D obj3 = (Collider2D)ToLua.CheckObject<Collider2D>(L, 1);
				Collider2D[] colliders = ToLua.ToObjectArray<Collider2D>(L, 2);
				int contacts5 = obj3.GetContacts(colliders);
				LuaDLL.lua_pushinteger(L, contacts5);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<List<Collider2D>>(L, 2))
			{
				Collider2D obj4 = (Collider2D)ToLua.CheckObject<Collider2D>(L, 1);
				List<Collider2D> colliders2 = (List<Collider2D>)ToLua.ToObject(L, 2);
				int contacts6 = obj4.GetContacts(colliders2);
				LuaDLL.lua_pushinteger(L, contacts6);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<ContactPoint2D[]>(L, 3))
			{
				Collider2D obj5 = (Collider2D)ToLua.CheckObject<Collider2D>(L, 1);
				ContactFilter2D contactFilter = StackTraits<ContactFilter2D>.Check(L, 2);
				ContactPoint2D[] contacts7 = ToLua.ToStructArray<ContactPoint2D>(L, 3);
				int contacts8 = obj5.GetContacts(contactFilter, contacts7);
				LuaDLL.lua_pushinteger(L, contacts8);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<List<ContactPoint2D>>(L, 3))
			{
				Collider2D obj6 = (Collider2D)ToLua.CheckObject<Collider2D>(L, 1);
				ContactFilter2D contactFilter2 = StackTraits<ContactFilter2D>.Check(L, 2);
				List<ContactPoint2D> contacts9 = (List<ContactPoint2D>)ToLua.ToObject(L, 3);
				int contacts10 = obj6.GetContacts(contactFilter2, contacts9);
				LuaDLL.lua_pushinteger(L, contacts10);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<Collider2D[]>(L, 3))
			{
				Collider2D obj7 = (Collider2D)ToLua.CheckObject<Collider2D>(L, 1);
				ContactFilter2D contactFilter3 = StackTraits<ContactFilter2D>.Check(L, 2);
				Collider2D[] colliders3 = ToLua.ToObjectArray<Collider2D>(L, 3);
				int contacts11 = obj7.GetContacts(contactFilter3, colliders3);
				LuaDLL.lua_pushinteger(L, contacts11);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<List<Collider2D>>(L, 3))
			{
				Collider2D obj8 = (Collider2D)ToLua.CheckObject<Collider2D>(L, 1);
				ContactFilter2D contactFilter4 = StackTraits<ContactFilter2D>.Check(L, 2);
				List<Collider2D> colliders4 = (List<Collider2D>)ToLua.ToObject(L, 3);
				int contacts12 = obj8.GetContacts(contactFilter4, colliders4);
				LuaDLL.lua_pushinteger(L, contacts12);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Collider2D.GetContacts");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Cast(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			switch (num)
			{
			case 3:
			{
				Collider2D obj2 = (Collider2D)ToLua.CheckObject<Collider2D>(L, 1);
				Vector2 direction2 = ToLua.ToVector2(L, 2);
				RaycastHit2D[] results2 = ToLua.CheckStructArray<RaycastHit2D>(L, 3);
				int n2 = obj2.Cast(direction2, results2);
				LuaDLL.lua_pushinteger(L, n2);
				return 1;
			}
			case 4:
				if (TypeChecker.CheckTypes<RaycastHit2D[], float>(L, 3))
				{
					Collider2D obj = (Collider2D)ToLua.CheckObject<Collider2D>(L, 1);
					Vector2 direction = ToLua.ToVector2(L, 2);
					RaycastHit2D[] results = ToLua.ToStructArray<RaycastHit2D>(L, 3);
					float distance = (float)LuaDLL.lua_tonumber(L, 4);
					int n = obj.Cast(direction, results, distance);
					LuaDLL.lua_pushinteger(L, n);
					return 1;
				}
				break;
			}
			if (num == 4 && TypeChecker.CheckTypes<ContactFilter2D, RaycastHit2D[]>(L, 3))
			{
				Collider2D obj3 = (Collider2D)ToLua.CheckObject<Collider2D>(L, 1);
				Vector2 direction3 = ToLua.ToVector2(L, 2);
				ContactFilter2D contactFilter = StackTraits<ContactFilter2D>.To(L, 3);
				RaycastHit2D[] results3 = ToLua.ToStructArray<RaycastHit2D>(L, 4);
				int n3 = obj3.Cast(direction3, contactFilter, results3);
				LuaDLL.lua_pushinteger(L, n3);
				return 1;
			}
			if (num == 4 && TypeChecker.CheckTypes<ContactFilter2D, List<RaycastHit2D>>(L, 3))
			{
				Collider2D obj4 = (Collider2D)ToLua.CheckObject<Collider2D>(L, 1);
				Vector2 direction4 = ToLua.ToVector2(L, 2);
				ContactFilter2D contactFilter2 = StackTraits<ContactFilter2D>.To(L, 3);
				List<RaycastHit2D> results4 = (List<RaycastHit2D>)ToLua.ToObject(L, 4);
				int n4 = obj4.Cast(direction4, contactFilter2, results4);
				LuaDLL.lua_pushinteger(L, n4);
				return 1;
			}
			if (num == 5 && TypeChecker.CheckTypes<RaycastHit2D[], float, bool>(L, 3))
			{
				Collider2D obj5 = (Collider2D)ToLua.CheckObject<Collider2D>(L, 1);
				Vector2 direction5 = ToLua.ToVector2(L, 2);
				RaycastHit2D[] results5 = ToLua.ToStructArray<RaycastHit2D>(L, 3);
				float distance2 = (float)LuaDLL.lua_tonumber(L, 4);
				bool ignoreSiblingColliders = LuaDLL.lua_toboolean(L, 5);
				int n5 = obj5.Cast(direction5, results5, distance2, ignoreSiblingColliders);
				LuaDLL.lua_pushinteger(L, n5);
				return 1;
			}
			if (num == 5 && TypeChecker.CheckTypes<ContactFilter2D, RaycastHit2D[], float>(L, 3))
			{
				Collider2D obj6 = (Collider2D)ToLua.CheckObject<Collider2D>(L, 1);
				Vector2 direction6 = ToLua.ToVector2(L, 2);
				ContactFilter2D contactFilter3 = StackTraits<ContactFilter2D>.To(L, 3);
				RaycastHit2D[] results6 = ToLua.ToStructArray<RaycastHit2D>(L, 4);
				float distance3 = (float)LuaDLL.lua_tonumber(L, 5);
				int n6 = obj6.Cast(direction6, contactFilter3, results6, distance3);
				LuaDLL.lua_pushinteger(L, n6);
				return 1;
			}
			if (num == 5 && TypeChecker.CheckTypes<ContactFilter2D, List<RaycastHit2D>, float>(L, 3))
			{
				Collider2D obj7 = (Collider2D)ToLua.CheckObject<Collider2D>(L, 1);
				Vector2 direction7 = ToLua.ToVector2(L, 2);
				ContactFilter2D contactFilter4 = StackTraits<ContactFilter2D>.To(L, 3);
				List<RaycastHit2D> results7 = (List<RaycastHit2D>)ToLua.ToObject(L, 4);
				float distance4 = (float)LuaDLL.lua_tonumber(L, 5);
				int n7 = obj7.Cast(direction7, contactFilter4, results7, distance4);
				LuaDLL.lua_pushinteger(L, n7);
				return 1;
			}
			if (num == 6 && TypeChecker.CheckTypes<RaycastHit2D[], float, bool>(L, 4))
			{
				Collider2D obj8 = (Collider2D)ToLua.CheckObject<Collider2D>(L, 1);
				Vector2 direction8 = ToLua.ToVector2(L, 2);
				ContactFilter2D contactFilter5 = StackTraits<ContactFilter2D>.Check(L, 3);
				RaycastHit2D[] results8 = ToLua.ToStructArray<RaycastHit2D>(L, 4);
				float distance5 = (float)LuaDLL.lua_tonumber(L, 5);
				bool ignoreSiblingColliders2 = LuaDLL.lua_toboolean(L, 6);
				int n8 = obj8.Cast(direction8, contactFilter5, results8, distance5, ignoreSiblingColliders2);
				LuaDLL.lua_pushinteger(L, n8);
				return 1;
			}
			if (num == 6 && TypeChecker.CheckTypes<List<RaycastHit2D>, float, bool>(L, 4))
			{
				Collider2D obj9 = (Collider2D)ToLua.CheckObject<Collider2D>(L, 1);
				Vector2 direction9 = ToLua.ToVector2(L, 2);
				ContactFilter2D contactFilter6 = StackTraits<ContactFilter2D>.Check(L, 3);
				List<RaycastHit2D> results9 = (List<RaycastHit2D>)ToLua.ToObject(L, 4);
				float distance6 = (float)LuaDLL.lua_tonumber(L, 5);
				bool ignoreSiblingColliders3 = LuaDLL.lua_toboolean(L, 6);
				int n9 = obj9.Cast(direction9, contactFilter6, results9, distance6, ignoreSiblingColliders3);
				LuaDLL.lua_pushinteger(L, n9);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Collider2D.Cast");
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
			case 3:
			{
				Collider2D obj2 = (Collider2D)ToLua.CheckObject<Collider2D>(L, 1);
				Vector2 direction2 = ToLua.ToVector2(L, 2);
				RaycastHit2D[] results2 = ToLua.CheckStructArray<RaycastHit2D>(L, 3);
				int n2 = obj2.Raycast(direction2, results2);
				LuaDLL.lua_pushinteger(L, n2);
				return 1;
			}
			case 4:
				if (TypeChecker.CheckTypes<RaycastHit2D[], float>(L, 3))
				{
					Collider2D obj = (Collider2D)ToLua.CheckObject<Collider2D>(L, 1);
					Vector2 direction = ToLua.ToVector2(L, 2);
					RaycastHit2D[] results = ToLua.ToStructArray<RaycastHit2D>(L, 3);
					float distance = (float)LuaDLL.lua_tonumber(L, 4);
					int n = obj.Raycast(direction, results, distance);
					LuaDLL.lua_pushinteger(L, n);
					return 1;
				}
				break;
			}
			if (num == 4 && TypeChecker.CheckTypes<ContactFilter2D, RaycastHit2D[]>(L, 3))
			{
				Collider2D obj3 = (Collider2D)ToLua.CheckObject<Collider2D>(L, 1);
				Vector2 direction3 = ToLua.ToVector2(L, 2);
				ContactFilter2D contactFilter = StackTraits<ContactFilter2D>.To(L, 3);
				RaycastHit2D[] results3 = ToLua.ToStructArray<RaycastHit2D>(L, 4);
				int n3 = obj3.Raycast(direction3, contactFilter, results3);
				LuaDLL.lua_pushinteger(L, n3);
				return 1;
			}
			if (num == 4 && TypeChecker.CheckTypes<ContactFilter2D, List<RaycastHit2D>>(L, 3))
			{
				Collider2D obj4 = (Collider2D)ToLua.CheckObject<Collider2D>(L, 1);
				Vector2 direction4 = ToLua.ToVector2(L, 2);
				ContactFilter2D contactFilter2 = StackTraits<ContactFilter2D>.To(L, 3);
				List<RaycastHit2D> results4 = (List<RaycastHit2D>)ToLua.ToObject(L, 4);
				int n4 = obj4.Raycast(direction4, contactFilter2, results4);
				LuaDLL.lua_pushinteger(L, n4);
				return 1;
			}
			if (num == 5 && TypeChecker.CheckTypes<RaycastHit2D[], float, int>(L, 3))
			{
				Collider2D obj5 = (Collider2D)ToLua.CheckObject<Collider2D>(L, 1);
				Vector2 direction5 = ToLua.ToVector2(L, 2);
				RaycastHit2D[] results5 = ToLua.ToStructArray<RaycastHit2D>(L, 3);
				float distance2 = (float)LuaDLL.lua_tonumber(L, 4);
				int layerMask = (int)LuaDLL.lua_tonumber(L, 5);
				int n5 = obj5.Raycast(direction5, results5, distance2, layerMask);
				LuaDLL.lua_pushinteger(L, n5);
				return 1;
			}
			if (num == 5 && TypeChecker.CheckTypes<ContactFilter2D, RaycastHit2D[], float>(L, 3))
			{
				Collider2D obj6 = (Collider2D)ToLua.CheckObject<Collider2D>(L, 1);
				Vector2 direction6 = ToLua.ToVector2(L, 2);
				ContactFilter2D contactFilter3 = StackTraits<ContactFilter2D>.To(L, 3);
				RaycastHit2D[] results6 = ToLua.ToStructArray<RaycastHit2D>(L, 4);
				float distance3 = (float)LuaDLL.lua_tonumber(L, 5);
				int n6 = obj6.Raycast(direction6, contactFilter3, results6, distance3);
				LuaDLL.lua_pushinteger(L, n6);
				return 1;
			}
			if (num == 5 && TypeChecker.CheckTypes<ContactFilter2D, List<RaycastHit2D>, float>(L, 3))
			{
				Collider2D obj7 = (Collider2D)ToLua.CheckObject<Collider2D>(L, 1);
				Vector2 direction7 = ToLua.ToVector2(L, 2);
				ContactFilter2D contactFilter4 = StackTraits<ContactFilter2D>.To(L, 3);
				List<RaycastHit2D> results7 = (List<RaycastHit2D>)ToLua.ToObject(L, 4);
				float distance4 = (float)LuaDLL.lua_tonumber(L, 5);
				int n7 = obj7.Raycast(direction7, contactFilter4, results7, distance4);
				LuaDLL.lua_pushinteger(L, n7);
				return 1;
			}
			switch (num)
			{
			case 6:
			{
				Collider2D obj9 = (Collider2D)ToLua.CheckObject<Collider2D>(L, 1);
				Vector2 direction9 = ToLua.ToVector2(L, 2);
				RaycastHit2D[] results9 = ToLua.CheckStructArray<RaycastHit2D>(L, 3);
				float distance6 = (float)LuaDLL.luaL_checknumber(L, 4);
				int layerMask3 = (int)LuaDLL.luaL_checknumber(L, 5);
				float minDepth2 = (float)LuaDLL.luaL_checknumber(L, 6);
				int n9 = obj9.Raycast(direction9, results9, distance6, layerMask3, minDepth2);
				LuaDLL.lua_pushinteger(L, n9);
				return 1;
			}
			case 7:
			{
				Collider2D obj8 = (Collider2D)ToLua.CheckObject<Collider2D>(L, 1);
				Vector2 direction8 = ToLua.ToVector2(L, 2);
				RaycastHit2D[] results8 = ToLua.CheckStructArray<RaycastHit2D>(L, 3);
				float distance5 = (float)LuaDLL.luaL_checknumber(L, 4);
				int layerMask2 = (int)LuaDLL.luaL_checknumber(L, 5);
				float minDepth = (float)LuaDLL.luaL_checknumber(L, 6);
				float maxDepth = (float)LuaDLL.luaL_checknumber(L, 7);
				int n8 = obj8.Raycast(direction8, results8, distance5, layerMask2, minDepth, maxDepth);
				LuaDLL.lua_pushinteger(L, n8);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Collider2D.Raycast");
			}
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
			ToLua.CheckArgsCount(L, 2);
			Collider2D obj = (Collider2D)ToLua.CheckObject<Collider2D>(L, 1);
			Vector2 position = ToLua.ToVector2(L, 2);
			Vector2 v = obj.ClosestPoint(position);
			ToLua.Push(L, v);
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
	private static int get_density(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float density = ((Collider2D)obj).density;
			LuaDLL.lua_pushnumber(L, density);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index density on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isTrigger(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isTrigger = ((Collider2D)obj).isTrigger;
			LuaDLL.lua_pushboolean(L, isTrigger);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isTrigger on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_usedByEffector(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool usedByEffector = ((Collider2D)obj).usedByEffector;
			LuaDLL.lua_pushboolean(L, usedByEffector);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index usedByEffector on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_usedByComposite(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool usedByComposite = ((Collider2D)obj).usedByComposite;
			LuaDLL.lua_pushboolean(L, usedByComposite);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index usedByComposite on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_composite(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CompositeCollider2D composite = ((Collider2D)obj).composite;
			ToLua.PushSealed(L, composite);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index composite on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_offset(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector2 offset = ((Collider2D)obj).offset;
			ToLua.Push(L, offset);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index offset on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_attachedRigidbody(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Rigidbody2D attachedRigidbody = ((Collider2D)obj).attachedRigidbody;
			ToLua.PushSealed(L, attachedRigidbody);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index attachedRigidbody on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_shapeCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int shapeCount = ((Collider2D)obj).shapeCount;
			LuaDLL.lua_pushinteger(L, shapeCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index shapeCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_bounds(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Bounds bounds = ((Collider2D)obj).bounds;
			ToLua.Push(L, bounds);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bounds on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_errorState(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ColliderErrorState2D errorState = ((Collider2D)obj).errorState;
			ToLua.Push(L, errorState);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index errorState on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_sharedMaterial(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PhysicsMaterial2D sharedMaterial = ((Collider2D)obj).sharedMaterial;
			ToLua.PushSealed(L, sharedMaterial);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sharedMaterial on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_friction(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float friction = ((Collider2D)obj).friction;
			LuaDLL.lua_pushnumber(L, friction);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index friction on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_bounciness(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float bounciness = ((Collider2D)obj).bounciness;
			LuaDLL.lua_pushnumber(L, bounciness);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bounciness on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_density(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Collider2D obj2 = (Collider2D)obj;
			float density = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.density = density;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index density on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isTrigger(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Collider2D obj2 = (Collider2D)obj;
			bool isTrigger = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isTrigger = isTrigger;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isTrigger on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_usedByEffector(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Collider2D obj2 = (Collider2D)obj;
			bool usedByEffector = LuaDLL.luaL_checkboolean(L, 2);
			obj2.usedByEffector = usedByEffector;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index usedByEffector on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_usedByComposite(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Collider2D obj2 = (Collider2D)obj;
			bool usedByComposite = LuaDLL.luaL_checkboolean(L, 2);
			obj2.usedByComposite = usedByComposite;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index usedByComposite on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_offset(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Collider2D obj2 = (Collider2D)obj;
			Vector2 offset = ToLua.ToVector2(L, 2);
			obj2.offset = offset;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index offset on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_sharedMaterial(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Collider2D obj2 = (Collider2D)obj;
			PhysicsMaterial2D sharedMaterial = (PhysicsMaterial2D)ToLua.CheckObject(L, 2, typeof(PhysicsMaterial2D));
			obj2.sharedMaterial = sharedMaterial;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sharedMaterial on a nil value");
		}
	}
}
