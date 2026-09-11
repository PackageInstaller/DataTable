using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;

public class ControllerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Controller), typeof(MonoBehaviour));
		L.RegFunction("AddEmptyControl", AddEmptyControl);
		L.RegFunction("SetGameObject", SetGameObject);
		L.RegFunction("RemoveControl", RemoveControl);
		L.RegFunction("SaveProperties", SaveProperties);
		L.RegFunction("LoadFromProperties", LoadFromProperties);
		L.RegFunction("LoadFromPropertiesWithCallback", LoadFromPropertiesWithCallback);
		L.RegFunction("GetValues", GetValues);
		L.RegFunction("AddSelectChangeListener", AddSelectChangeListener);
		L.RegFunction("RemoveAllListeners", RemoveAllListeners);
		L.RegFunction("RemoveSelectChangeHandler", RemoveSelectChangeHandler);
		L.RegFunction("SetSelectedIndex", SetSelectedIndex);
		L.RegFunction("SetSelectedIndexWithCallback", SetSelectedIndexWithCallback);
		L.RegFunction("GetStateIndex", GetStateIndex);
		L.RegFunction("SetSelectedState", SetSelectedState);
		L.RegFunction("SetSelectedStateWithCallback", SetSelectedStateWithCallback);
		L.RegFunction("ChangeStateValue", ChangeStateValue);
		L.RegFunction("DeleteStateValue", DeleteStateValue);
		L.RegFunction("AddStateValue", AddStateValue);
		L.RegFunction("UpdateByValue", UpdateByValue);
		L.RegFunction("GetSelectedState", GetSelectedState);
		L.RegFunction("GetName", GetName);
		L.RegFunction("AddRelateItem", AddRelateItem);
		L.RegFunction("UpdateRelateItem", UpdateRelateItem);
		L.RegFunction("RemoveRelateItem", RemoveRelateItem);
		L.RegFunction("UpdateTween", UpdateTween);
		L.RegFunction("GetNewControllerValue", GetNewControllerValue);
		L.RegFunction("GetTypeByProperty", GetTypeByProperty);
		L.RegFunction("GetIndex", GetIndex);
		L.RegFunction("ContainsObject", ContainsObject);
		L.RegFunction("SwapStates", SwapStates);
		L.RegFunction("ResetController", ResetController);
		L.RegFunction("IsPropertyOnControl", IsPropertyOnControl);
		L.RegFunction("GetDefaultIndex", GetDefaultIndex);
		L.RegFunction("ConvertToNewVersion", ConvertToNewVersion);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("OnSelectChange", get_OnSelectChange, set_OnSelectChange);
		L.RegVar("name", get_name, set_name);
		L.RegVar("stateValues", get_stateValues, set_stateValues);
		L.RegVar("objects", get_objects, set_objects);
		L.RegVar("properties", get_properties, set_properties);
		L.RegVar("tweens", get_tweens, set_tweens);
		L.RegVar("durings", get_durings, set_durings);
		L.RegVar("eases", get_eases, set_eases);
		L.RegVar("selectedIndex", get_selectedIndex, set_selectedIndex);
		L.RegVar("defaultIndex", get_defaultIndex, set_defaultIndex);
		L.RegVar("relateItems", get_relateItems, set_relateItems);
		L.RegVar("desc", get_desc, set_desc);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddEmptyControl(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Controller)ToLua.CheckObject<Controller>(L, 1)).AddEmptyControl();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetGameObject(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 5);
			Controller obj = (Controller)ToLua.CheckObject<Controller>(L, 1);
			int index = (int)LuaDLL.luaL_checknumber(L, 2);
			GameObject go = (GameObject)ToLua.CheckObject(L, 3, typeof(GameObject));
			ControllerProperty property = (ControllerProperty)ToLua.CheckObject(L, 4, typeof(ControllerProperty));
			Component target = (Component)ToLua.CheckObject<Component>(L, 5);
			obj.SetGameObject(index, go, property, target);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RemoveControl(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Controller obj = (Controller)ToLua.CheckObject<Controller>(L, 1);
			int index = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.RemoveControl(index);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SaveProperties(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Controller)ToLua.CheckObject<Controller>(L, 1)).SaveProperties();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LoadFromProperties(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Controller obj = (Controller)ToLua.CheckObject<Controller>(L, 1);
			bool immediately = LuaDLL.luaL_checkboolean(L, 2);
			obj.LoadFromProperties(immediately);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LoadFromPropertiesWithCallback(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Controller obj = (Controller)ToLua.CheckObject<Controller>(L, 1);
			Action callback = (Action)ToLua.CheckDelegate<Action>(L, 2);
			obj.LoadFromPropertiesWithCallback(callback);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetValues(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string[] values = ((Controller)ToLua.CheckObject<Controller>(L, 1)).GetValues();
			ToLua.Push(L, values);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddSelectChangeListener(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Controller obj = (Controller)ToLua.CheckObject<Controller>(L, 1);
			Action<int> handler = (Action<int>)ToLua.CheckDelegate<Action<int>>(L, 2);
			obj.AddSelectChangeListener(handler);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RemoveAllListeners(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Controller)ToLua.CheckObject<Controller>(L, 1)).RemoveAllListeners();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RemoveSelectChangeHandler(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Controller obj = (Controller)ToLua.CheckObject<Controller>(L, 1);
			Action<int> handler = (Action<int>)ToLua.CheckDelegate<Action<int>>(L, 2);
			obj.RemoveSelectChangeHandler(handler);
			return 0;
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
				Controller obj2 = (Controller)ToLua.CheckObject<Controller>(L, 1);
				int newIndex2 = (int)LuaDLL.luaL_checknumber(L, 2);
				obj2.SetSelectedIndex(newIndex2);
				return 0;
			}
			case 3:
			{
				Controller obj = (Controller)ToLua.CheckObject<Controller>(L, 1);
				int newIndex = (int)LuaDLL.luaL_checknumber(L, 2);
				bool immediately = LuaDLL.luaL_checkboolean(L, 3);
				obj.SetSelectedIndex(newIndex, immediately);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Controller.SetSelectedIndex");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetSelectedIndexWithCallback(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Controller obj = (Controller)ToLua.CheckObject<Controller>(L, 1);
			int newIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			Action callback = (Action)ToLua.CheckDelegate<Action>(L, 3);
			obj.SetSelectedIndexWithCallback(newIndex, callback);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetStateIndex(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Controller obj = (Controller)ToLua.CheckObject<Controller>(L, 1);
			string stateValue = ToLua.CheckString(L, 2);
			int stateIndex = obj.GetStateIndex(stateValue);
			LuaDLL.lua_pushinteger(L, stateIndex);
			return 1;
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
				Controller obj2 = (Controller)ToLua.CheckObject<Controller>(L, 1);
				string value2 = ToLua.CheckString(L, 2);
				obj2.SetSelectedState(value2);
				return 0;
			}
			case 3:
			{
				Controller obj = (Controller)ToLua.CheckObject<Controller>(L, 1);
				string value = ToLua.CheckString(L, 2);
				bool immediately = LuaDLL.luaL_checkboolean(L, 3);
				obj.SetSelectedState(value, immediately);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Controller.SetSelectedState");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetSelectedStateWithCallback(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Controller obj = (Controller)ToLua.CheckObject<Controller>(L, 1);
			string value = ToLua.CheckString(L, 2);
			Action callback = (Action)ToLua.CheckDelegate<Action>(L, 3);
			obj.SetSelectedStateWithCallback(value, callback);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ChangeStateValue(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Controller obj = (Controller)ToLua.CheckObject<Controller>(L, 1);
			int valueIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			string newVal = ToLua.CheckString(L, 3);
			obj.ChangeStateValue(valueIndex, newVal);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DeleteStateValue(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Controller obj = (Controller)ToLua.CheckObject<Controller>(L, 1);
			string value = ToLua.CheckString(L, 2);
			obj.DeleteStateValue(value);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddStateValue(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Controller obj = (Controller)ToLua.CheckObject<Controller>(L, 1);
			string value = ToLua.CheckString(L, 2);
			obj.AddStateValue(value);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UpdateByValue(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Controller obj = (Controller)ToLua.CheckObject<Controller>(L, 1);
			string name = ToLua.CheckString(L, 2);
			string[] stateValues = ToLua.CheckStringArray(L, 3);
			obj.UpdateByValue(name, stateValues);
			return 0;
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
			string selectedState = ((Controller)ToLua.CheckObject<Controller>(L, 1)).GetSelectedState();
			LuaDLL.lua_pushstring(L, selectedState);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetName(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string name = ((Controller)ToLua.CheckObject<Controller>(L, 1)).GetName();
			LuaDLL.lua_pushstring(L, name);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddRelateItem(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			Controller obj = (Controller)ToLua.CheckObject<Controller>(L, 1);
			GameObject go = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			ControllerProperty property = (ControllerProperty)ToLua.CheckObject(L, 3, typeof(ControllerProperty));
			Component target = (Component)ToLua.CheckObject<Component>(L, 4);
			obj.AddRelateItem(go, property, target);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UpdateRelateItem(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			Controller obj = (Controller)ToLua.CheckObject<Controller>(L, 1);
			GameObject go = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			ControllerProperty property = (ControllerProperty)ToLua.CheckObject(L, 3, typeof(ControllerProperty));
			Component newValue = (Component)ToLua.CheckObject<Component>(L, 4);
			obj.UpdateRelateItem(go, property, newValue);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RemoveRelateItem(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Controller obj = (Controller)ToLua.CheckObject<Controller>(L, 1);
			GameObject go = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			ControllerProperty property = (ControllerProperty)ToLua.CheckObject(L, 3, typeof(ControllerProperty));
			obj.RemoveRelateItem(go, property);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UpdateTween(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 5);
			Controller obj = (Controller)ToLua.CheckObject<Controller>(L, 1);
			int index = (int)LuaDLL.luaL_checknumber(L, 2);
			bool isTween = LuaDLL.luaL_checkboolean(L, 3);
			float during = (float)LuaDLL.luaL_checknumber(L, 4);
			LeanTweenType ease = (LeanTweenType)ToLua.CheckObject(L, 5, typeof(LeanTweenType));
			obj.UpdateTween(index, isTween, during, ease);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetNewControllerValue(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Controller obj = (Controller)ToLua.CheckObject<Controller>(L, 1);
			GameObject go = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			ControllerProperty property = (ControllerProperty)ToLua.CheckObject(L, 3, typeof(ControllerProperty));
			NewControllerValue newControllerValue = obj.GetNewControllerValue(go, property);
			ToLua.PushObject(L, newControllerValue);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetTypeByProperty(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Type typeByProperty = Controller.GetTypeByProperty((ControllerProperty)ToLua.CheckObject(L, 1, typeof(ControllerProperty)));
			ToLua.Push(L, typeByProperty);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetIndex(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Controller obj = (Controller)ToLua.CheckObject<Controller>(L, 1);
			GameObject go = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			ControllerProperty property = (ControllerProperty)ToLua.CheckObject(L, 3, typeof(ControllerProperty));
			int index = obj.GetIndex(go, property);
			LuaDLL.lua_pushinteger(L, index);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ContainsObject(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Controller obj = (Controller)ToLua.CheckObject<Controller>(L, 1);
			GameObject go = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			bool value = obj.ContainsObject(go);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SwapStates(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Controller obj = (Controller)ToLua.CheckObject<Controller>(L, 1);
			int fromIndex = (int)LuaDLL.luaL_checknumber(L, 2);
			int toIndex = (int)LuaDLL.luaL_checknumber(L, 3);
			obj.SwapStates(fromIndex, toIndex);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ResetController(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Controller)ToLua.CheckObject<Controller>(L, 1)).ResetController();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsPropertyOnControl(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			List<ControllerCompareData> o = ((Controller)ToLua.CheckObject<Controller>(L, 1)).IsPropertyOnControl();
			ToLua.PushSealed(L, o);
			return 1;
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
			int defaultIndex = ((Controller)ToLua.CheckObject<Controller>(L, 1)).GetDefaultIndex();
			LuaDLL.lua_pushinteger(L, defaultIndex);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ConvertToNewVersion(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((Controller)ToLua.CheckObject<Controller>(L, 1)).ConvertToNewVersion();
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
	private static int get_OnSelectChange(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Action<int> onSelectChange = ((Controller)obj).OnSelectChange;
			ToLua.Push(L, onSelectChange);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index OnSelectChange on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_name(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string name = ((Controller)obj).name;
			LuaDLL.lua_pushstring(L, name);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index name on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_stateValues(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<string> stateValues = ((Controller)obj).stateValues;
			ToLua.PushSealed(L, stateValues);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stateValues on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_objects(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<GameObject> objects = ((Controller)obj).objects;
			ToLua.PushSealed(L, objects);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index objects on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_properties(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<ControllerProperty> properties = ((Controller)obj).properties;
			ToLua.PushSealed(L, properties);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index properties on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_tweens(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<bool> tweens = ((Controller)obj).tweens;
			ToLua.PushSealed(L, tweens);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index tweens on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_durings(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<float> durings = ((Controller)obj).durings;
			ToLua.PushSealed(L, durings);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index durings on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_eases(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<LeanTweenType> eases = ((Controller)obj).eases;
			ToLua.PushSealed(L, eases);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index eases on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_selectedIndex(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int selectedIndex = ((Controller)obj).selectedIndex;
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
			int defaultIndex = ((Controller)obj).defaultIndex;
			LuaDLL.lua_pushinteger(L, defaultIndex);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index defaultIndex on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_relateItems(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<ControllerRelateItem> relateItems = ((Controller)obj).relateItems;
			ToLua.PushSealed(L, relateItems);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index relateItems on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_desc(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string desc = ((Controller)obj).desc;
			LuaDLL.lua_pushstring(L, desc);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index desc on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_OnSelectChange(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Controller obj2 = (Controller)obj;
			Action<int> onSelectChange = (Action<int>)ToLua.CheckDelegate<Action<int>>(L, 2);
			obj2.OnSelectChange = onSelectChange;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index OnSelectChange on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_name(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Controller obj2 = (Controller)obj;
			string name = ToLua.CheckString(L, 2);
			obj2.name = name;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index name on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_stateValues(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Controller obj2 = (Controller)obj;
			List<string> stateValues = (List<string>)ToLua.CheckObject(L, 2, typeof(List<string>));
			obj2.stateValues = stateValues;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stateValues on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_objects(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Controller obj2 = (Controller)obj;
			List<GameObject> objects = (List<GameObject>)ToLua.CheckObject(L, 2, typeof(List<GameObject>));
			obj2.objects = objects;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index objects on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_properties(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Controller obj2 = (Controller)obj;
			List<ControllerProperty> properties = (List<ControllerProperty>)ToLua.CheckObject(L, 2, typeof(List<ControllerProperty>));
			obj2.properties = properties;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index properties on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_tweens(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Controller obj2 = (Controller)obj;
			List<bool> tweens = (List<bool>)ToLua.CheckObject(L, 2, typeof(List<bool>));
			obj2.tweens = tweens;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index tweens on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_durings(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Controller obj2 = (Controller)obj;
			List<float> durings = (List<float>)ToLua.CheckObject(L, 2, typeof(List<float>));
			obj2.durings = durings;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index durings on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_eases(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Controller obj2 = (Controller)obj;
			List<LeanTweenType> eases = (List<LeanTweenType>)ToLua.CheckObject(L, 2, typeof(List<LeanTweenType>));
			obj2.eases = eases;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index eases on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_selectedIndex(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Controller obj2 = (Controller)obj;
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
			Controller obj2 = (Controller)obj;
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
	private static int set_relateItems(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Controller obj2 = (Controller)obj;
			List<ControllerRelateItem> relateItems = (List<ControllerRelateItem>)ToLua.CheckObject(L, 2, typeof(List<ControllerRelateItem>));
			obj2.relateItems = relateItems;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index relateItems on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_desc(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Controller obj2 = (Controller)obj;
			string desc = ToLua.CheckString(L, 2);
			obj2.desc = desc;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index desc on a nil value");
		}
	}
}
