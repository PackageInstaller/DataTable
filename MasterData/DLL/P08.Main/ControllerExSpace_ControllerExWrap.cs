using System;
using System.Collections.Generic;
using ControllerExSpace;
using LuaInterface;
using UnityEngine;

public class ControllerExSpace_ControllerExWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(ControllerEx), typeof(object));
		L.RegFunction("CheckGaearStatus", CheckGaearStatus);
		L.RegFunction("SetGearStatus", SetGearStatus);
		L.RegFunction("AddProperty", AddProperty);
		L.RegFunction("RemoveProperty", RemoveProperty);
		L.RegFunction("SetPropertyGameObject", SetPropertyGameObject);
		L.RegFunction("SetPropertyTags", SetPropertyTags);
		L.RegFunction("GetDefaultIndex", GetDefaultIndex);
		L.RegFunction("GetSelectedState", GetSelectedState);
		L.RegFunction("GetSelectedIndex", GetSelectedIndex);
		L.RegFunction("SetSelectedIndex", SetSelectedIndex);
		L.RegFunction("SetSelectedState", SetSelectedState);
		L.RegFunction("AddState", AddState);
		L.RegFunction("RemoveState", RemoveState);
		L.RegFunction("New", _CreateControllerExSpace_ControllerEx);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("_name", get__name, set__name);
		L.RegVar("selectedIndex", get_selectedIndex, set_selectedIndex);
		L.RegVar("defaultIndex", get_defaultIndex, set_defaultIndex);
		L.RegVar("properties", get_properties, set_properties);
		L.RegVar("states", get_states, set_states);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateControllerExSpace_ControllerEx(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 1)
			{
				ControllerEx o = new ControllerEx(ToLua.CheckString(L, 1));
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: ControllerExSpace.ControllerEx.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CheckGaearStatus(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			uint tags = (uint)LuaDLL.luaL_checknumber(L, 1);
			GearType type = (GearType)ToLua.CheckObject(L, 2, typeof(GearType));
			bool value = ControllerEx.CheckGaearStatus(tags, type);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetGearStatus(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			uint tags = (uint)LuaDLL.luaL_checknumber(L, 1);
			GearType type = (GearType)ToLua.CheckObject(L, 2, typeof(GearType));
			bool value = LuaDLL.luaL_checkboolean(L, 3);
			uint num = ControllerEx.SetGearStatus(tags, type, value);
			LuaDLL.lua_pushnumber(L, num);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddProperty(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((ControllerEx)ToLua.CheckObject<ControllerEx>(L, 1)).AddProperty();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RemoveProperty(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				((ControllerEx)ToLua.CheckObject<ControllerEx>(L, 1)).RemoveProperty();
				return 0;
			case 2:
			{
				ControllerEx obj = (ControllerEx)ToLua.CheckObject<ControllerEx>(L, 1);
				int index = (int)LuaDLL.luaL_checknumber(L, 2);
				obj.RemoveProperty(index);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: ControllerExSpace.ControllerEx.RemoveProperty");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetPropertyGameObject(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			ControllerEx obj = (ControllerEx)ToLua.CheckObject<ControllerEx>(L, 1);
			Property property = (Property)ToLua.CheckObject<Property>(L, 2);
			GameObject gameObject = (GameObject)ToLua.CheckObject(L, 3, typeof(GameObject));
			obj.SetPropertyGameObject(property, gameObject);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetPropertyTags(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			ControllerEx obj = (ControllerEx)ToLua.CheckObject<ControllerEx>(L, 1);
			Property property = (Property)ToLua.CheckObject<Property>(L, 2);
			uint tags = (uint)LuaDLL.luaL_checknumber(L, 3);
			obj.SetPropertyTags(property, tags);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetDefaultIndex(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int defaultIndex = ((ControllerEx)ToLua.CheckObject<ControllerEx>(L, 1)).GetDefaultIndex();
			LuaDLL.lua_pushinteger(L, defaultIndex);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetSelectedState(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string selectedState = ((ControllerEx)ToLua.CheckObject<ControllerEx>(L, 1)).GetSelectedState();
			LuaDLL.lua_pushstring(L, selectedState);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetSelectedIndex(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int selectedIndex = ((ControllerEx)ToLua.CheckObject<ControllerEx>(L, 1)).GetSelectedIndex();
			LuaDLL.lua_pushinteger(L, selectedIndex);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetSelectedIndex(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				ControllerEx obj2 = (ControllerEx)ToLua.CheckObject<ControllerEx>(L, 1);
				int newIndex2 = (int)LuaDLL.luaL_checknumber(L, 2);
				obj2.SetSelectedIndex(newIndex2);
				return 0;
			}
			case 3:
			{
				ControllerEx obj = (ControllerEx)ToLua.CheckObject<ControllerEx>(L, 1);
				int newIndex = (int)LuaDLL.luaL_checknumber(L, 2);
				bool immediately = LuaDLL.luaL_checkboolean(L, 3);
				obj.SetSelectedIndex(newIndex, immediately);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: ControllerExSpace.ControllerEx.SetSelectedIndex");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetSelectedState(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				ControllerEx obj2 = (ControllerEx)ToLua.CheckObject<ControllerEx>(L, 1);
				string value2 = ToLua.CheckString(L, 2);
				obj2.SetSelectedState(value2);
				return 0;
			}
			case 3:
			{
				ControllerEx obj = (ControllerEx)ToLua.CheckObject<ControllerEx>(L, 1);
				string value = ToLua.CheckString(L, 2);
				bool immediately = LuaDLL.luaL_checkboolean(L, 3);
				obj.SetSelectedState(value, immediately);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: ControllerExSpace.ControllerEx.SetSelectedState");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddState(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((ControllerEx)ToLua.CheckObject<ControllerEx>(L, 1)).AddState();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RemoveState(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			ControllerEx obj = (ControllerEx)ToLua.CheckObject<ControllerEx>(L, 1);
			int index = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.RemoveState(index);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get__name(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string name = ((ControllerEx)obj)._name;
			LuaDLL.lua_pushstring(L, name);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _name on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_selectedIndex(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int selectedIndex = ((ControllerEx)obj).selectedIndex;
			LuaDLL.lua_pushinteger(L, selectedIndex);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index selectedIndex on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_defaultIndex(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int defaultIndex = ((ControllerEx)obj).defaultIndex;
			LuaDLL.lua_pushinteger(L, defaultIndex);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index defaultIndex on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_properties(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<Property> properties = ((ControllerEx)obj).properties;
			ToLua.PushSealed(L, properties);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index properties on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_states(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<ControllerState> states = ((ControllerEx)obj).states;
			ToLua.PushSealed(L, states);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index states on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__name(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ControllerEx obj2 = (ControllerEx)obj;
			string name = ToLua.CheckString(L, 2);
			obj2._name = name;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _name on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_selectedIndex(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ControllerEx obj2 = (ControllerEx)obj;
			int selectedIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.selectedIndex = selectedIndex;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index selectedIndex on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_defaultIndex(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ControllerEx obj2 = (ControllerEx)obj;
			int defaultIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.defaultIndex = defaultIndex;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index defaultIndex on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_properties(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ControllerEx obj2 = (ControllerEx)obj;
			List<Property> properties = (List<Property>)ToLua.CheckObject(L, 2, typeof(List<Property>));
			obj2.properties = properties;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index properties on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_states(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ControllerEx obj2 = (ControllerEx)obj;
			List<ControllerState> states = (List<ControllerState>)ToLua.CheckObject(L, 2, typeof(List<ControllerState>));
			obj2.states = states;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index states on a nil value");
		}
	}
}
