using System;
using System.Collections;
using LuaInterface;
using UnityEngine;

public class UnityEngine_TransformWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Transform), typeof(Component));
		L.RegFunction("SetParent", SetParent);
		L.RegFunction("SetPositionAndRotation", SetPositionAndRotation);
		L.RegFunction("Translate", Translate);
		L.RegFunction("Rotate", Rotate);
		L.RegFunction("RotateAround", RotateAround);
		L.RegFunction("LookAt", LookAt);
		L.RegFunction("TransformDirection", TransformDirection);
		L.RegFunction("InverseTransformDirection", InverseTransformDirection);
		L.RegFunction("TransformVector", TransformVector);
		L.RegFunction("InverseTransformVector", InverseTransformVector);
		L.RegFunction("TransformPoint", TransformPoint);
		L.RegFunction("InverseTransformPoint", InverseTransformPoint);
		L.RegFunction("DetachChildren", DetachChildren);
		L.RegFunction("SetAsFirstSibling", SetAsFirstSibling);
		L.RegFunction("SetAsLastSibling", SetAsLastSibling);
		L.RegFunction("SetSiblingIndex", SetSiblingIndex);
		L.RegFunction("GetSiblingIndex", GetSiblingIndex);
		L.RegFunction("Find", Find);
		L.RegFunction("IsChildOf", IsChildOf);
		L.RegFunction("GetEnumerator", GetEnumerator);
		L.RegFunction("GetChild", GetChild);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("position", get_position, set_position);
		L.RegVar("localPosition", get_localPosition, set_localPosition);
		L.RegVar("eulerAngles", get_eulerAngles, set_eulerAngles);
		L.RegVar("localEulerAngles", get_localEulerAngles, set_localEulerAngles);
		L.RegVar("right", get_right, set_right);
		L.RegVar("up", get_up, set_up);
		L.RegVar("forward", get_forward, set_forward);
		L.RegVar("rotation", get_rotation, set_rotation);
		L.RegVar("localRotation", get_localRotation, set_localRotation);
		L.RegVar("localScale", get_localScale, set_localScale);
		L.RegVar("parent", get_parent, set_parent);
		L.RegVar("worldToLocalMatrix", get_worldToLocalMatrix, null);
		L.RegVar("localToWorldMatrix", get_localToWorldMatrix, null);
		L.RegVar("root", get_root, null);
		L.RegVar("childCount", get_childCount, null);
		L.RegVar("lossyScale", get_lossyScale, null);
		L.RegVar("hasChanged", get_hasChanged, set_hasChanged);
		L.RegVar("hierarchyCapacity", get_hierarchyCapacity, set_hierarchyCapacity);
		L.RegVar("hierarchyCount", get_hierarchyCount, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetParent(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Transform obj2 = (Transform)ToLua.CheckObject<Transform>(L, 1);
				Transform parent2 = (Transform)ToLua.CheckObject<Transform>(L, 2);
				obj2.SetParent(parent2);
				return 0;
			}
			case 3:
			{
				Transform obj = (Transform)ToLua.CheckObject<Transform>(L, 1);
				Transform parent = (Transform)ToLua.CheckObject<Transform>(L, 2);
				bool worldPositionStays = LuaDLL.luaL_checkboolean(L, 3);
				obj.SetParent(parent, worldPositionStays);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Transform.SetParent");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetPositionAndRotation(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Transform obj = (Transform)ToLua.CheckObject<Transform>(L, 1);
			Vector3 position = ToLua.ToVector3(L, 2);
			Quaternion rotation = ToLua.ToQuaternion(L, 3);
			obj.SetPositionAndRotation(position, rotation);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Translate(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			switch (num)
			{
			case 2:
			{
				Transform obj2 = (Transform)ToLua.CheckObject<Transform>(L, 1);
				Vector3 translation2 = ToLua.ToVector3(L, 2);
				obj2.Translate(translation2);
				return 0;
			}
			case 3:
				if (TypeChecker.CheckTypes<Space>(L, 3))
				{
					Transform obj = (Transform)ToLua.CheckObject<Transform>(L, 1);
					Vector3 translation = ToLua.ToVector3(L, 2);
					Space relativeTo = (Space)ToLua.ToObject(L, 3);
					obj.Translate(translation, relativeTo);
					return 0;
				}
				break;
			}
			if (num == 3 && TypeChecker.CheckTypes<Transform>(L, 3))
			{
				Transform obj3 = (Transform)ToLua.CheckObject<Transform>(L, 1);
				Vector3 translation3 = ToLua.ToVector3(L, 2);
				Transform relativeTo2 = (Transform)ToLua.ToObject(L, 3);
				obj3.Translate(translation3, relativeTo2);
				return 0;
			}
			switch (num)
			{
			case 4:
			{
				Transform obj5 = (Transform)ToLua.CheckObject<Transform>(L, 1);
				float x2 = (float)LuaDLL.luaL_checknumber(L, 2);
				float y2 = (float)LuaDLL.luaL_checknumber(L, 3);
				float z2 = (float)LuaDLL.luaL_checknumber(L, 4);
				obj5.Translate(x2, y2, z2);
				return 0;
			}
			case 5:
				if (TypeChecker.CheckTypes<Space>(L, 5))
				{
					Transform obj4 = (Transform)ToLua.CheckObject<Transform>(L, 1);
					float x = (float)LuaDLL.luaL_checknumber(L, 2);
					float y = (float)LuaDLL.luaL_checknumber(L, 3);
					float z = (float)LuaDLL.luaL_checknumber(L, 4);
					Space relativeTo3 = (Space)ToLua.ToObject(L, 5);
					obj4.Translate(x, y, z, relativeTo3);
					return 0;
				}
				break;
			}
			if (num == 5 && TypeChecker.CheckTypes<Transform>(L, 5))
			{
				Transform obj6 = (Transform)ToLua.CheckObject<Transform>(L, 1);
				float x3 = (float)LuaDLL.luaL_checknumber(L, 2);
				float y3 = (float)LuaDLL.luaL_checknumber(L, 3);
				float z3 = (float)LuaDLL.luaL_checknumber(L, 4);
				Transform relativeTo4 = (Transform)ToLua.ToObject(L, 5);
				obj6.Translate(x3, y3, z3, relativeTo4);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Transform.Translate");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Rotate(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			switch (num)
			{
			case 2:
			{
				Transform obj2 = (Transform)ToLua.CheckObject<Transform>(L, 1);
				Vector3 eulers2 = ToLua.ToVector3(L, 2);
				obj2.Rotate(eulers2);
				return 0;
			}
			case 3:
				if (TypeChecker.CheckTypes<Space>(L, 3))
				{
					Transform obj = (Transform)ToLua.CheckObject<Transform>(L, 1);
					Vector3 eulers = ToLua.ToVector3(L, 2);
					Space relativeTo = (Space)ToLua.ToObject(L, 3);
					obj.Rotate(eulers, relativeTo);
					return 0;
				}
				break;
			}
			if (num == 3 && TypeChecker.CheckTypes<float>(L, 3))
			{
				Transform obj3 = (Transform)ToLua.CheckObject<Transform>(L, 1);
				Vector3 axis = ToLua.ToVector3(L, 2);
				float angle = (float)LuaDLL.lua_tonumber(L, 3);
				obj3.Rotate(axis, angle);
				return 0;
			}
			if (num == 4 && TypeChecker.CheckTypes<float, float, float>(L, 2))
			{
				Transform obj4 = (Transform)ToLua.CheckObject<Transform>(L, 1);
				float xAngle = (float)LuaDLL.lua_tonumber(L, 2);
				float yAngle = (float)LuaDLL.lua_tonumber(L, 3);
				float zAngle = (float)LuaDLL.lua_tonumber(L, 4);
				obj4.Rotate(xAngle, yAngle, zAngle);
				return 0;
			}
			if (num == 4 && TypeChecker.CheckTypes<Vector3, float, Space>(L, 2))
			{
				Transform obj5 = (Transform)ToLua.CheckObject<Transform>(L, 1);
				Vector3 axis2 = ToLua.ToVector3(L, 2);
				float angle2 = (float)LuaDLL.lua_tonumber(L, 3);
				Space relativeTo2 = (Space)ToLua.ToObject(L, 4);
				obj5.Rotate(axis2, angle2, relativeTo2);
				return 0;
			}
			if (num == 5)
			{
				Transform obj6 = (Transform)ToLua.CheckObject<Transform>(L, 1);
				float xAngle2 = (float)LuaDLL.luaL_checknumber(L, 2);
				float yAngle2 = (float)LuaDLL.luaL_checknumber(L, 3);
				float zAngle2 = (float)LuaDLL.luaL_checknumber(L, 4);
				Space relativeTo3 = (Space)ToLua.CheckObject(L, 5, typeof(Space));
				obj6.Rotate(xAngle2, yAngle2, zAngle2, relativeTo3);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Transform.Rotate");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RotateAround(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			Transform obj = (Transform)ToLua.CheckObject<Transform>(L, 1);
			Vector3 point = ToLua.ToVector3(L, 2);
			Vector3 axis = ToLua.ToVector3(L, 3);
			float angle = (float)LuaDLL.luaL_checknumber(L, 4);
			obj.RotateAround(point, axis, angle);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LookAt(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<Transform>(L, 2))
			{
				Transform obj = (Transform)ToLua.CheckObject<Transform>(L, 1);
				Transform target = (Transform)ToLua.ToObject(L, 2);
				obj.LookAt(target);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<Vector3>(L, 2))
			{
				Transform obj2 = (Transform)ToLua.CheckObject<Transform>(L, 1);
				Vector3 worldPosition = ToLua.ToVector3(L, 2);
				obj2.LookAt(worldPosition);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<Transform, Vector3>(L, 2))
			{
				Transform obj3 = (Transform)ToLua.CheckObject<Transform>(L, 1);
				Transform target2 = (Transform)ToLua.ToObject(L, 2);
				Vector3 worldUp = ToLua.ToVector3(L, 3);
				obj3.LookAt(target2, worldUp);
				return 0;
			}
			if (num == 3 && TypeChecker.CheckTypes<Vector3, Vector3>(L, 2))
			{
				Transform obj4 = (Transform)ToLua.CheckObject<Transform>(L, 1);
				Vector3 worldPosition2 = ToLua.ToVector3(L, 2);
				Vector3 worldUp2 = ToLua.ToVector3(L, 3);
				obj4.LookAt(worldPosition2, worldUp2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Transform.LookAt");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int TransformDirection(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Transform obj2 = (Transform)ToLua.CheckObject<Transform>(L, 1);
				Vector3 direction = ToLua.ToVector3(L, 2);
				Vector3 v2 = obj2.TransformDirection(direction);
				ToLua.Push(L, v2);
				return 1;
			}
			case 4:
			{
				Transform obj = (Transform)ToLua.CheckObject<Transform>(L, 1);
				float x = (float)LuaDLL.luaL_checknumber(L, 2);
				float y = (float)LuaDLL.luaL_checknumber(L, 3);
				float z = (float)LuaDLL.luaL_checknumber(L, 4);
				Vector3 v = obj.TransformDirection(x, y, z);
				ToLua.Push(L, v);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Transform.TransformDirection");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InverseTransformDirection(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Transform obj2 = (Transform)ToLua.CheckObject<Transform>(L, 1);
				Vector3 direction = ToLua.ToVector3(L, 2);
				Vector3 v2 = obj2.InverseTransformDirection(direction);
				ToLua.Push(L, v2);
				return 1;
			}
			case 4:
			{
				Transform obj = (Transform)ToLua.CheckObject<Transform>(L, 1);
				float x = (float)LuaDLL.luaL_checknumber(L, 2);
				float y = (float)LuaDLL.luaL_checknumber(L, 3);
				float z = (float)LuaDLL.luaL_checknumber(L, 4);
				Vector3 v = obj.InverseTransformDirection(x, y, z);
				ToLua.Push(L, v);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Transform.InverseTransformDirection");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int TransformVector(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Transform obj2 = (Transform)ToLua.CheckObject<Transform>(L, 1);
				Vector3 vector = ToLua.ToVector3(L, 2);
				Vector3 v2 = obj2.TransformVector(vector);
				ToLua.Push(L, v2);
				return 1;
			}
			case 4:
			{
				Transform obj = (Transform)ToLua.CheckObject<Transform>(L, 1);
				float x = (float)LuaDLL.luaL_checknumber(L, 2);
				float y = (float)LuaDLL.luaL_checknumber(L, 3);
				float z = (float)LuaDLL.luaL_checknumber(L, 4);
				Vector3 v = obj.TransformVector(x, y, z);
				ToLua.Push(L, v);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Transform.TransformVector");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InverseTransformVector(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Transform obj2 = (Transform)ToLua.CheckObject<Transform>(L, 1);
				Vector3 vector = ToLua.ToVector3(L, 2);
				Vector3 v2 = obj2.InverseTransformVector(vector);
				ToLua.Push(L, v2);
				return 1;
			}
			case 4:
			{
				Transform obj = (Transform)ToLua.CheckObject<Transform>(L, 1);
				float x = (float)LuaDLL.luaL_checknumber(L, 2);
				float y = (float)LuaDLL.luaL_checknumber(L, 3);
				float z = (float)LuaDLL.luaL_checknumber(L, 4);
				Vector3 v = obj.InverseTransformVector(x, y, z);
				ToLua.Push(L, v);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Transform.InverseTransformVector");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int TransformPoint(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Transform obj2 = (Transform)ToLua.CheckObject<Transform>(L, 1);
				Vector3 position = ToLua.ToVector3(L, 2);
				Vector3 v2 = obj2.TransformPoint(position);
				ToLua.Push(L, v2);
				return 1;
			}
			case 4:
			{
				Transform obj = (Transform)ToLua.CheckObject<Transform>(L, 1);
				float x = (float)LuaDLL.luaL_checknumber(L, 2);
				float y = (float)LuaDLL.luaL_checknumber(L, 3);
				float z = (float)LuaDLL.luaL_checknumber(L, 4);
				Vector3 v = obj.TransformPoint(x, y, z);
				ToLua.Push(L, v);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Transform.TransformPoint");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InverseTransformPoint(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Transform obj2 = (Transform)ToLua.CheckObject<Transform>(L, 1);
				Vector3 position = ToLua.ToVector3(L, 2);
				Vector3 v2 = obj2.InverseTransformPoint(position);
				ToLua.Push(L, v2);
				return 1;
			}
			case 4:
			{
				Transform obj = (Transform)ToLua.CheckObject<Transform>(L, 1);
				float x = (float)LuaDLL.luaL_checknumber(L, 2);
				float y = (float)LuaDLL.luaL_checknumber(L, 3);
				float z = (float)LuaDLL.luaL_checknumber(L, 4);
				Vector3 v = obj.InverseTransformPoint(x, y, z);
				ToLua.Push(L, v);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Transform.InverseTransformPoint");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DetachChildren(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Transform)ToLua.CheckObject<Transform>(L, 1)).DetachChildren();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetAsFirstSibling(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Transform)ToLua.CheckObject<Transform>(L, 1)).SetAsFirstSibling();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetAsLastSibling(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Transform)ToLua.CheckObject<Transform>(L, 1)).SetAsLastSibling();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetSiblingIndex(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Transform obj = (Transform)ToLua.CheckObject<Transform>(L, 1);
			int siblingIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.SetSiblingIndex(siblingIndex);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetSiblingIndex(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int siblingIndex = ((Transform)ToLua.CheckObject<Transform>(L, 1)).GetSiblingIndex();
			LuaDLL.lua_pushinteger(L, siblingIndex);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Find(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Transform obj = (Transform)ToLua.CheckObject<Transform>(L, 1);
			string n = ToLua.CheckString(L, 2);
			Transform obj2 = obj.Find(n);
			ToLua.Push(L, obj2);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsChildOf(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Transform obj = (Transform)ToLua.CheckObject<Transform>(L, 1);
			Transform parent = (Transform)ToLua.CheckObject<Transform>(L, 2);
			bool value = obj.IsChildOf(parent);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetEnumerator(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			IEnumerator enumerator = ((Transform)ToLua.CheckObject<Transform>(L, 1)).GetEnumerator();
			ToLua.Push(L, enumerator);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetChild(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Transform obj = (Transform)ToLua.CheckObject<Transform>(L, 1);
			int index = (int)LuaDLL.luaL_checknumber(L, 2);
			Transform child = obj.GetChild(index);
			ToLua.Push(L, child);
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
	private static int get_position(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3 position = ((Transform)obj).position;
			ToLua.Push(L, position);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index position on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_localPosition(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3 localPosition = ((Transform)obj).localPosition;
			ToLua.Push(L, localPosition);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index localPosition on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_eulerAngles(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3 eulerAngles = ((Transform)obj).eulerAngles;
			ToLua.Push(L, eulerAngles);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index eulerAngles on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_localEulerAngles(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3 localEulerAngles = ((Transform)obj).localEulerAngles;
			ToLua.Push(L, localEulerAngles);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index localEulerAngles on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_right(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3 right = ((Transform)obj).right;
			ToLua.Push(L, right);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index right on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_up(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3 up = ((Transform)obj).up;
			ToLua.Push(L, up);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index up on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_forward(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3 forward = ((Transform)obj).forward;
			ToLua.Push(L, forward);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index forward on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_rotation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Quaternion rotation = ((Transform)obj).rotation;
			ToLua.Push(L, rotation);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rotation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_localRotation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Quaternion localRotation = ((Transform)obj).localRotation;
			ToLua.Push(L, localRotation);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index localRotation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_localScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3 localScale = ((Transform)obj).localScale;
			ToLua.Push(L, localScale);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index localScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_parent(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform parent = ((Transform)obj).parent;
			ToLua.Push(L, parent);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index parent on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_worldToLocalMatrix(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Matrix4x4 worldToLocalMatrix = ((Transform)obj).worldToLocalMatrix;
			ToLua.PushValue(L, worldToLocalMatrix);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index worldToLocalMatrix on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_localToWorldMatrix(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Matrix4x4 localToWorldMatrix = ((Transform)obj).localToWorldMatrix;
			ToLua.PushValue(L, localToWorldMatrix);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index localToWorldMatrix on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_root(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform root = ((Transform)obj).root;
			ToLua.Push(L, root);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index root on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_childCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int childCount = ((Transform)obj).childCount;
			LuaDLL.lua_pushinteger(L, childCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index childCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_lossyScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3 lossyScale = ((Transform)obj).lossyScale;
			ToLua.Push(L, lossyScale);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lossyScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_hasChanged(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool hasChanged = ((Transform)obj).hasChanged;
			LuaDLL.lua_pushboolean(L, hasChanged);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index hasChanged on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_hierarchyCapacity(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int hierarchyCapacity = ((Transform)obj).hierarchyCapacity;
			LuaDLL.lua_pushinteger(L, hierarchyCapacity);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index hierarchyCapacity on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_hierarchyCount(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int hierarchyCount = ((Transform)obj).hierarchyCount;
			LuaDLL.lua_pushinteger(L, hierarchyCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index hierarchyCount on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_position(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform obj2 = (Transform)obj;
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
	private static int set_localPosition(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform obj2 = (Transform)obj;
			Vector3 localPosition = ToLua.ToVector3(L, 2);
			obj2.localPosition = localPosition;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index localPosition on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_eulerAngles(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform obj2 = (Transform)obj;
			Vector3 eulerAngles = ToLua.ToVector3(L, 2);
			obj2.eulerAngles = eulerAngles;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index eulerAngles on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_localEulerAngles(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform obj2 = (Transform)obj;
			Vector3 localEulerAngles = ToLua.ToVector3(L, 2);
			obj2.localEulerAngles = localEulerAngles;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index localEulerAngles on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_right(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform obj2 = (Transform)obj;
			Vector3 right = ToLua.ToVector3(L, 2);
			obj2.right = right;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index right on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_up(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform obj2 = (Transform)obj;
			Vector3 up = ToLua.ToVector3(L, 2);
			obj2.up = up;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index up on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_forward(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform obj2 = (Transform)obj;
			Vector3 forward = ToLua.ToVector3(L, 2);
			obj2.forward = forward;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index forward on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_rotation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform obj2 = (Transform)obj;
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
	private static int set_localRotation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform obj2 = (Transform)obj;
			Quaternion localRotation = ToLua.ToQuaternion(L, 2);
			obj2.localRotation = localRotation;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index localRotation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_localScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform obj2 = (Transform)obj;
			Vector3 localScale = ToLua.ToVector3(L, 2);
			obj2.localScale = localScale;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index localScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_parent(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform obj2 = (Transform)obj;
			Transform parent = (Transform)ToLua.CheckObject<Transform>(L, 2);
			obj2.parent = parent;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index parent on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_hasChanged(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform obj2 = (Transform)obj;
			bool hasChanged = LuaDLL.luaL_checkboolean(L, 2);
			obj2.hasChanged = hasChanged;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index hasChanged on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_hierarchyCapacity(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform obj2 = (Transform)obj;
			int hierarchyCapacity = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.hierarchyCapacity = hierarchyCapacity;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index hierarchyCapacity on a nil value");
		}
	}
}
