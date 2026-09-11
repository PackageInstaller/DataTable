using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;

public class UnityEngine_ComponentWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Component), typeof(UnityEngine.Object));
		L.RegFunction("GetComponent", GetComponent);
		L.RegFunction("TryGetComponent", TryGetComponent);
		L.RegFunction("GetComponentInChildren", GetComponentInChildren);
		L.RegFunction("GetComponentsInChildren", GetComponentsInChildren);
		L.RegFunction("GetComponentInParent", GetComponentInParent);
		L.RegFunction("GetComponentsInParent", GetComponentsInParent);
		L.RegFunction("GetComponents", GetComponents);
		L.RegFunction("CompareTag", CompareTag);
		L.RegFunction("SendMessageUpwards", SendMessageUpwards);
		L.RegFunction("SendMessage", SendMessage);
		L.RegFunction("BroadcastMessage", BroadcastMessage);
		L.RegFunction("New", _CreateUnityEngine_Component);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("transform", get_transform, null);
		L.RegVar("gameObject", get_gameObject, null);
		L.RegVar("tag", get_tag, set_tag);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_Component(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				Component obj = new Component();
				ToLua.Push(L, obj);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.Component.New");
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
				Component obj = (Component)ToLua.CheckObject<Component>(L, 1);
				Type type = (Type)ToLua.ToObject(L, 2);
				Component component = obj.GetComponent(type);
				ToLua.Push(L, component);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<string>(L, 2))
			{
				Component obj2 = (Component)ToLua.CheckObject<Component>(L, 1);
				string compName = ToLua.ToString(L, 2);
				Component componentFromStrToType = U3DUtil.GetComponentFromStrToType(obj2, compName);
				ToLua.Push(L, componentFromStrToType);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Component.GetComponent");
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
			Component obj = (Component)ToLua.CheckObject<Component>(L, 1);
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
	private static int GetComponentInChildren(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Component obj2 = (Component)ToLua.CheckObject<Component>(L, 1);
				Type t2 = ToLua.CheckMonoType(L, 2);
				Component componentInChildren2 = obj2.GetComponentInChildren(t2);
				ToLua.Push(L, componentInChildren2);
				return 1;
			}
			case 3:
			{
				Component obj = (Component)ToLua.CheckObject<Component>(L, 1);
				Type t = ToLua.CheckMonoType(L, 2);
				bool includeInactive = LuaDLL.luaL_checkboolean(L, 3);
				Component componentInChildren = obj.GetComponentInChildren(t, includeInactive);
				ToLua.Push(L, componentInChildren);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Component.GetComponentInChildren");
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
				Component obj2 = (Component)ToLua.CheckObject<Component>(L, 1);
				Type t2 = ToLua.CheckMonoType(L, 2);
				Component[] componentsInChildren2 = obj2.GetComponentsInChildren(t2);
				ToLua.Push(L, componentsInChildren2);
				return 1;
			}
			case 3:
			{
				Component obj = (Component)ToLua.CheckObject<Component>(L, 1);
				Type t = ToLua.CheckMonoType(L, 2);
				bool includeInactive = LuaDLL.luaL_checkboolean(L, 3);
				Component[] componentsInChildren = obj.GetComponentsInChildren(t, includeInactive);
				ToLua.Push(L, componentsInChildren);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Component.GetComponentsInChildren");
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
				Component obj2 = (Component)ToLua.CheckObject<Component>(L, 1);
				Type t2 = ToLua.CheckMonoType(L, 2);
				Component componentInParent2 = obj2.GetComponentInParent(t2);
				ToLua.Push(L, componentInParent2);
				return 1;
			}
			case 3:
			{
				Component obj = (Component)ToLua.CheckObject<Component>(L, 1);
				Type t = ToLua.CheckMonoType(L, 2);
				bool includeInactive = LuaDLL.luaL_checkboolean(L, 3);
				Component componentInParent = obj.GetComponentInParent(t, includeInactive);
				ToLua.Push(L, componentInParent);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Component.GetComponentInParent");
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
				Component obj2 = (Component)ToLua.CheckObject<Component>(L, 1);
				Type t2 = ToLua.CheckMonoType(L, 2);
				Component[] componentsInParent2 = obj2.GetComponentsInParent(t2);
				ToLua.Push(L, componentsInParent2);
				return 1;
			}
			case 3:
			{
				Component obj = (Component)ToLua.CheckObject<Component>(L, 1);
				Type t = ToLua.CheckMonoType(L, 2);
				bool includeInactive = LuaDLL.luaL_checkboolean(L, 3);
				Component[] componentsInParent = obj.GetComponentsInParent(t, includeInactive);
				ToLua.Push(L, componentsInParent);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Component.GetComponentsInParent");
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
				Component obj2 = (Component)ToLua.CheckObject<Component>(L, 1);
				Type type2 = ToLua.CheckMonoType(L, 2);
				Component[] components = obj2.GetComponents(type2);
				ToLua.Push(L, components);
				return 1;
			}
			case 3:
			{
				Component obj = (Component)ToLua.CheckObject<Component>(L, 1);
				Type type = ToLua.CheckMonoType(L, 2);
				List<Component> results = (List<Component>)ToLua.CheckObject(L, 3, typeof(List<Component>));
				obj.GetComponents(type, results);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Component.GetComponents");
			}
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
			Component obj = (Component)ToLua.CheckObject<Component>(L, 1);
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
	private static int SendMessageUpwards(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			switch (num)
			{
			case 2:
			{
				Component obj2 = (Component)ToLua.CheckObject<Component>(L, 1);
				string methodName2 = ToLua.CheckString(L, 2);
				obj2.SendMessageUpwards(methodName2);
				return 0;
			}
			case 3:
				if (TypeChecker.CheckTypes<SendMessageOptions>(L, 3))
				{
					Component obj = (Component)ToLua.CheckObject<Component>(L, 1);
					string methodName = ToLua.CheckString(L, 2);
					SendMessageOptions options = (SendMessageOptions)ToLua.ToObject(L, 3);
					obj.SendMessageUpwards(methodName, options);
					return 0;
				}
				break;
			}
			if (num == 3 && TypeChecker.CheckTypes<object>(L, 3))
			{
				Component obj3 = (Component)ToLua.CheckObject<Component>(L, 1);
				string methodName3 = ToLua.CheckString(L, 2);
				object value = ToLua.ToVarObject(L, 3);
				obj3.SendMessageUpwards(methodName3, value);
				return 0;
			}
			if (num == 4)
			{
				Component obj4 = (Component)ToLua.CheckObject<Component>(L, 1);
				string methodName4 = ToLua.CheckString(L, 2);
				object value2 = ToLua.ToVarObject(L, 3);
				SendMessageOptions options2 = (SendMessageOptions)ToLua.CheckObject(L, 4, typeof(SendMessageOptions));
				obj4.SendMessageUpwards(methodName4, value2, options2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Component.SendMessageUpwards");
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
				Component obj2 = (Component)ToLua.CheckObject<Component>(L, 1);
				string methodName2 = ToLua.CheckString(L, 2);
				obj2.SendMessage(methodName2);
				return 0;
			}
			case 3:
				if (TypeChecker.CheckTypes<SendMessageOptions>(L, 3))
				{
					Component obj = (Component)ToLua.CheckObject<Component>(L, 1);
					string methodName = ToLua.CheckString(L, 2);
					SendMessageOptions options = (SendMessageOptions)ToLua.ToObject(L, 3);
					obj.SendMessage(methodName, options);
					return 0;
				}
				break;
			}
			if (num == 3 && TypeChecker.CheckTypes<object>(L, 3))
			{
				Component obj3 = (Component)ToLua.CheckObject<Component>(L, 1);
				string methodName3 = ToLua.CheckString(L, 2);
				object value = ToLua.ToVarObject(L, 3);
				obj3.SendMessage(methodName3, value);
				return 0;
			}
			if (num == 4)
			{
				Component obj4 = (Component)ToLua.CheckObject<Component>(L, 1);
				string methodName4 = ToLua.CheckString(L, 2);
				object value2 = ToLua.ToVarObject(L, 3);
				SendMessageOptions options2 = (SendMessageOptions)ToLua.CheckObject(L, 4, typeof(SendMessageOptions));
				obj4.SendMessage(methodName4, value2, options2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Component.SendMessage");
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
				Component obj2 = (Component)ToLua.CheckObject<Component>(L, 1);
				string methodName2 = ToLua.CheckString(L, 2);
				obj2.BroadcastMessage(methodName2);
				return 0;
			}
			case 3:
				if (TypeChecker.CheckTypes<SendMessageOptions>(L, 3))
				{
					Component obj = (Component)ToLua.CheckObject<Component>(L, 1);
					string methodName = ToLua.CheckString(L, 2);
					SendMessageOptions options = (SendMessageOptions)ToLua.ToObject(L, 3);
					obj.BroadcastMessage(methodName, options);
					return 0;
				}
				break;
			}
			if (num == 3 && TypeChecker.CheckTypes<object>(L, 3))
			{
				Component obj3 = (Component)ToLua.CheckObject<Component>(L, 1);
				string methodName3 = ToLua.CheckString(L, 2);
				object parameter = ToLua.ToVarObject(L, 3);
				obj3.BroadcastMessage(methodName3, parameter);
				return 0;
			}
			if (num == 4)
			{
				Component obj4 = (Component)ToLua.CheckObject<Component>(L, 1);
				string methodName4 = ToLua.CheckString(L, 2);
				object parameter2 = ToLua.ToVarObject(L, 3);
				SendMessageOptions options2 = (SendMessageOptions)ToLua.CheckObject(L, 4, typeof(SendMessageOptions));
				obj4.BroadcastMessage(methodName4, parameter2, options2);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.Component.BroadcastMessage");
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
			Transform transform = ((Component)obj).transform;
			ToLua.Push(L, transform);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index transform on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_gameObject(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject gameObject = ((Component)obj).gameObject;
			ToLua.PushSealed(L, gameObject);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index gameObject on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_tag(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string tag = ((Component)obj).tag;
			LuaDLL.lua_pushstring(L, tag);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index tag on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_tag(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Component obj2 = (Component)obj;
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
