using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;
using UnityEngine.SceneManagement;

public class UnityEngine_GameObjectWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(GameObject), typeof(UnityEngine.Object));
		L.RegFunction("CreatePrimitive", CreatePrimitive);
		L.RegFunction("GetComponent", GetComponent);
		L.RegFunction("GetComponentInChildren", GetComponentInChildren);
		L.RegFunction("GetComponentInParent", GetComponentInParent);
		L.RegFunction("GetComponents", GetComponents);
		L.RegFunction("GetComponentsInChildren", GetComponentsInChildren);
		L.RegFunction("GetComponentsInParent", GetComponentsInParent);
		L.RegFunction("TryGetComponent", TryGetComponent);
		L.RegFunction("FindWithTag", FindWithTag);
		L.RegFunction("SendMessageUpwards", SendMessageUpwards);
		L.RegFunction("SendMessage", SendMessage);
		L.RegFunction("BroadcastMessage", BroadcastMessage);
		L.RegFunction("AddComponent", AddComponent);
		L.RegFunction("SetActive", SetActive);
		L.RegFunction("CompareTag", CompareTag);
		L.RegFunction("FindGameObjectWithTag", FindGameObjectWithTag);
		L.RegFunction("FindGameObjectsWithTag", FindGameObjectsWithTag);
		L.RegFunction("Find", Find);
		L.RegFunction("GetHeorModelAttachPointTrans", GetHeorModelAttachPointTrans);
		L.RegFunction("GetPosition", GetPosition);
		L.RegFunction("SetPositionEx", SetPositionEx);
		L.RegFunction("SetParentPure", SetParentPure);
		L.RegFunction("SetParentAndInitTrans", SetParentAndInitTrans);
		L.RegFunction("InjectUI", InjectUI);
		L.RegFunction("New", _CreateUnityEngine_GameObject);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("transform", get_transform, null);
		L.RegVar("layer", get_layer, set_layer);
		L.RegVar("activeSelf", get_activeSelf, null);
		L.RegVar("activeInHierarchy", get_activeInHierarchy, null);
		L.RegVar("isStatic", get_isStatic, set_isStatic);
		L.RegVar("tag", get_tag, set_tag);
		L.RegVar("scene", get_scene, null);
		L.RegVar("sceneCullingMask", get_sceneCullingMask, null);
		L.RegVar("gameObject", get_gameObject, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_GameObject(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			switch (num)
			{
			case 0:
			{
				GameObject o2 = new GameObject();
				ToLua.PushSealed(L, o2);
				return 1;
			}
			case 1:
				if (TypeChecker.CheckTypes<string>(L, 1))
				{
					GameObject o = new GameObject(ToLua.ToString(L, 1));
					ToLua.PushSealed(L, o);
					return 1;
				}
				break;
			}
			if (TypeChecker.CheckTypes<string>(L, 1) && TypeChecker.CheckParamsType<Type>(L, 2, num - 1))
			{
				string name = ToLua.ToString(L, 1);
				Type[] components = ToLua.ToParamsObject<Type>(L, 2, num - 1);
				GameObject o3 = new GameObject(name, components);
				ToLua.PushSealed(L, o3);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.GameObject.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CreatePrimitive(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			GameObject o = GameObject.CreatePrimitive((PrimitiveType)ToLua.CheckObject(L, 1, typeof(PrimitiveType)));
			ToLua.PushSealed(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetComponent(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<Type>(L, 2))
			{
				GameObject obj = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
				Type type = (Type)ToLua.ToObject(L, 2);
				Component component = obj.GetComponent(type);
				ToLua.Push(L, component);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<string>(L, 2))
			{
				GameObject go = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
				string compName = ToLua.ToString(L, 2);
				Component componentFromStrToType = U3DUtil.GetComponentFromStrToType(go, compName);
				ToLua.Push(L, componentFromStrToType);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.GameObject.GetComponent");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetComponentInChildren(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				GameObject obj2 = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
				Type type2 = ToLua.CheckMonoType(L, 2);
				Component componentInChildren2 = obj2.GetComponentInChildren(type2);
				ToLua.Push(L, componentInChildren2);
				return 1;
			}
			case 3:
			{
				GameObject obj = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
				Type type = ToLua.CheckMonoType(L, 2);
				bool includeInactive = LuaDLL.luaL_checkboolean(L, 3);
				Component componentInChildren = obj.GetComponentInChildren(type, includeInactive);
				ToLua.Push(L, componentInChildren);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.GameObject.GetComponentInChildren");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetComponentInParent(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				GameObject obj2 = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
				Type type2 = ToLua.CheckMonoType(L, 2);
				Component componentInParent2 = obj2.GetComponentInParent(type2);
				ToLua.Push(L, componentInParent2);
				return 1;
			}
			case 3:
			{
				GameObject obj = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
				Type type = ToLua.CheckMonoType(L, 2);
				bool includeInactive = LuaDLL.luaL_checkboolean(L, 3);
				Component componentInParent = obj.GetComponentInParent(type, includeInactive);
				ToLua.Push(L, componentInParent);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.GameObject.GetComponentInParent");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetComponents(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				GameObject obj2 = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
				Type type2 = ToLua.CheckMonoType(L, 2);
				Component[] components = obj2.GetComponents(type2);
				ToLua.Push(L, components);
				return 1;
			}
			case 3:
			{
				GameObject obj = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
				Type type = ToLua.CheckMonoType(L, 2);
				List<Component> results = (List<Component>)ToLua.CheckObject(L, 3, typeof(List<Component>));
				obj.GetComponents(type, results);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.GameObject.GetComponents");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetComponentsInChildren(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				GameObject obj2 = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
				Type type2 = ToLua.CheckMonoType(L, 2);
				Component[] componentsInChildren2 = obj2.GetComponentsInChildren(type2);
				ToLua.Push(L, componentsInChildren2);
				return 1;
			}
			case 3:
			{
				GameObject obj = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
				Type type = ToLua.CheckMonoType(L, 2);
				bool includeInactive = LuaDLL.luaL_checkboolean(L, 3);
				Component[] componentsInChildren = obj.GetComponentsInChildren(type, includeInactive);
				ToLua.Push(L, componentsInChildren);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.GameObject.GetComponentsInChildren");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetComponentsInParent(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				GameObject obj2 = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
				Type type2 = ToLua.CheckMonoType(L, 2);
				Component[] componentsInParent2 = obj2.GetComponentsInParent(type2);
				ToLua.Push(L, componentsInParent2);
				return 1;
			}
			case 3:
			{
				GameObject obj = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
				Type type = ToLua.CheckMonoType(L, 2);
				bool includeInactive = LuaDLL.luaL_checkboolean(L, 3);
				Component[] componentsInParent = obj.GetComponentsInParent(type, includeInactive);
				ToLua.Push(L, componentsInParent);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.GameObject.GetComponentsInParent");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int TryGetComponent(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			GameObject obj = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
			Type type = ToLua.CheckMonoType(L, 2);
			Component component = null;
			bool value = obj.TryGetComponent(type, out component);
			LuaDLL.lua_pushboolean(L, value);
			ToLua.Push(L, component);
			return 2;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int FindWithTag(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			GameObject o = GameObject.FindWithTag(ToLua.CheckString(L, 1));
			ToLua.PushSealed(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SendMessageUpwards(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			switch (num)
			{
			case 2:
			{
				GameObject obj2 = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
				string methodName2 = ToLua.CheckString(L, 2);
				obj2.SendMessageUpwards(methodName2);
				return 0;
			}
			case 3:
				if (TypeChecker.CheckTypes<SendMessageOptions>(L, 3))
				{
					GameObject obj = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
					string methodName = ToLua.CheckString(L, 2);
					SendMessageOptions options = (SendMessageOptions)ToLua.ToObject(L, 3);
					obj.SendMessageUpwards(methodName, options);
					return 0;
				}
				break;
			}
			if (num == 3 && TypeChecker.CheckTypes<object>(L, 3))
			{
				GameObject obj3 = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
				string methodName3 = ToLua.CheckString(L, 2);
				object value = ToLua.ToVarObject(L, 3);
				obj3.SendMessageUpwards(methodName3, value);
				return 0;
			}
			if (num == 4)
			{
				GameObject obj4 = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
				string methodName4 = ToLua.CheckString(L, 2);
				object value2 = ToLua.ToVarObject(L, 3);
				SendMessageOptions options2 = (SendMessageOptions)ToLua.CheckObject(L, 4, typeof(SendMessageOptions));
				obj4.SendMessageUpwards(methodName4, value2, options2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.GameObject.SendMessageUpwards");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SendMessage(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			switch (num)
			{
			case 2:
			{
				GameObject obj2 = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
				string methodName2 = ToLua.CheckString(L, 2);
				obj2.SendMessage(methodName2);
				return 0;
			}
			case 3:
				if (TypeChecker.CheckTypes<SendMessageOptions>(L, 3))
				{
					GameObject obj = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
					string methodName = ToLua.CheckString(L, 2);
					SendMessageOptions options = (SendMessageOptions)ToLua.ToObject(L, 3);
					obj.SendMessage(methodName, options);
					return 0;
				}
				break;
			}
			if (num == 3 && TypeChecker.CheckTypes<object>(L, 3))
			{
				GameObject obj3 = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
				string methodName3 = ToLua.CheckString(L, 2);
				object value = ToLua.ToVarObject(L, 3);
				obj3.SendMessage(methodName3, value);
				return 0;
			}
			if (num == 4)
			{
				GameObject obj4 = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
				string methodName4 = ToLua.CheckString(L, 2);
				object value2 = ToLua.ToVarObject(L, 3);
				SendMessageOptions options2 = (SendMessageOptions)ToLua.CheckObject(L, 4, typeof(SendMessageOptions));
				obj4.SendMessage(methodName4, value2, options2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.GameObject.SendMessage");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int BroadcastMessage(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			switch (num)
			{
			case 2:
			{
				GameObject obj2 = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
				string methodName2 = ToLua.CheckString(L, 2);
				obj2.BroadcastMessage(methodName2);
				return 0;
			}
			case 3:
				if (TypeChecker.CheckTypes<SendMessageOptions>(L, 3))
				{
					GameObject obj = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
					string methodName = ToLua.CheckString(L, 2);
					SendMessageOptions options = (SendMessageOptions)ToLua.ToObject(L, 3);
					obj.BroadcastMessage(methodName, options);
					return 0;
				}
				break;
			}
			if (num == 3 && TypeChecker.CheckTypes<object>(L, 3))
			{
				GameObject obj3 = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
				string methodName3 = ToLua.CheckString(L, 2);
				object parameter = ToLua.ToVarObject(L, 3);
				obj3.BroadcastMessage(methodName3, parameter);
				return 0;
			}
			if (num == 4)
			{
				GameObject obj4 = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
				string methodName4 = ToLua.CheckString(L, 2);
				object parameter2 = ToLua.ToVarObject(L, 3);
				SendMessageOptions options2 = (SendMessageOptions)ToLua.CheckObject(L, 4, typeof(SendMessageOptions));
				obj4.BroadcastMessage(methodName4, parameter2, options2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.GameObject.BroadcastMessage");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddComponent(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			GameObject obj = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
			Type componentType = ToLua.CheckMonoType(L, 2);
			Component obj2 = obj.AddComponent(componentType);
			ToLua.Push(L, obj2);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetActive(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			GameObject obj = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
			bool active = LuaDLL.luaL_checkboolean(L, 2);
			obj.SetActive(active);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CompareTag(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			GameObject obj = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
			string tag = ToLua.CheckString(L, 2);
			bool value = obj.CompareTag(tag);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int FindGameObjectWithTag(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			GameObject o = GameObject.FindGameObjectWithTag(ToLua.CheckString(L, 1));
			ToLua.PushSealed(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int FindGameObjectsWithTag(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			GameObject[] array = GameObject.FindGameObjectsWithTag(ToLua.CheckString(L, 1));
			ToLua.Push(L, array);
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
			ToLua.CheckArgsCount(L, 1);
			GameObject o = GameObject.Find(ToLua.CheckString(L, 1));
			ToLua.PushSealed(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetHeorModelAttachPointTrans(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			GameObject heroModelGo = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
			string pointName = ToLua.CheckString(L, 2);
			Transform heorModelAttachPointTrans = heroModelGo.GetHeorModelAttachPointTrans(pointName);
			ToLua.Push(L, heorModelAttachPointTrans);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetPosition(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Vector3 position = ((GameObject)ToLua.CheckObject(L, 1, typeof(GameObject))).GetPosition();
			ToLua.Push(L, position);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetPositionEx(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			GameObject go = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
			float x = (float)LuaDLL.luaL_checknumber(L, 2);
			float y = (float)LuaDLL.luaL_checknumber(L, 3);
			float z = (float)LuaDLL.luaL_checknumber(L, 4);
			go.SetPositionEx(x, y, z);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetParentPure(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			GameObject obj = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
			Component parent = (Component)ToLua.CheckObject<Component>(L, 2);
			obj.SetParentPure(parent);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetParentAndInitTrans(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			GameObject obj = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
			Component parent = (Component)ToLua.CheckObject<Component>(L, 2);
			obj.SetParentAndInitTrans(parent);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InjectUI(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			GameObject obj = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
			LuaTable table = ToLua.CheckLuaTable(L, 2);
			obj.InjectUI(table);
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
	private static int get_transform(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform transform = ((GameObject)obj).transform;
			ToLua.Push(L, transform);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index transform on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_layer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int layer = ((GameObject)obj).layer;
			LuaDLL.lua_pushinteger(L, layer);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index layer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_activeSelf(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool activeSelf = ((GameObject)obj).activeSelf;
			LuaDLL.lua_pushboolean(L, activeSelf);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index activeSelf on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_activeInHierarchy(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool activeInHierarchy = ((GameObject)obj).activeInHierarchy;
			LuaDLL.lua_pushboolean(L, activeInHierarchy);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index activeInHierarchy on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isStatic(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isStatic = ((GameObject)obj).isStatic;
			LuaDLL.lua_pushboolean(L, isStatic);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isStatic on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_tag(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string tag = ((GameObject)obj).tag;
			LuaDLL.lua_pushstring(L, tag);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index tag on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_scene(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Scene scene = ((GameObject)obj).scene;
			ToLua.PushValue(L, scene);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index scene on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_sceneCullingMask(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ulong sceneCullingMask = ((GameObject)obj).sceneCullingMask;
			LuaDLL.tolua_pushuint64(L, sceneCullingMask);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index sceneCullingMask on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_gameObject(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject gameObject = ((GameObject)obj).gameObject;
			ToLua.PushSealed(L, gameObject);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index gameObject on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_layer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject obj2 = (GameObject)obj;
			int layer = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.layer = layer;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index layer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isStatic(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject obj2 = (GameObject)obj;
			bool isStatic = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isStatic = isStatic;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isStatic on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_tag(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject obj2 = (GameObject)obj;
			string tag = ToLua.CheckString(L, 2);
			obj2.tag = tag;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index tag on a nil value");
		}
	}
}
