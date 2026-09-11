using System;
using System.Globalization;
using System.Reflection;

namespace LuaInterface;

public sealed class LuaProperty
{
	private PropertyInfo property;

	private Type kclass;

	[NoToLua]
	public LuaProperty(PropertyInfo prop, Type t)
	{
		property = prop;
		kclass = t;
	}

	public int Get(IntPtr L)
	{
		switch (LuaDLL.lua_gettop(L))
		{
		case 3:
		{
			object obj2 = ToLua.CheckVarObject(L, 2, kclass);
			object[] index2 = ToLua.CheckObjectArray(L, 3);
			object value2 = property.GetValue(obj2, index2);
			ToLua.Push(L, value2);
			return 1;
		}
		case 6:
		{
			object obj = ToLua.CheckVarObject(L, 2, kclass);
			BindingFlags invokeAttr = (BindingFlags)LuaDLL.luaL_checknumber(L, 3);
			Binder binder = (Binder)ToLua.CheckObject(L, 4, typeof(Binder));
			object[] index = ToLua.CheckObjectArray(L, 5);
			CultureInfo culture = (CultureInfo)ToLua.CheckObject(L, 6, typeof(CultureInfo));
			object value = property.GetValue(obj, invokeAttr, binder, index, culture);
			ToLua.Push(L, value);
			return 1;
		}
		default:
			return LuaDLL.luaL_throw(L, "invalid arguments to method: LuaInterface.LuaProperty.Get");
		}
	}

	public int Set(IntPtr L)
	{
		switch (LuaDLL.lua_gettop(L))
		{
		case 4:
		{
			object obj3 = ToLua.CheckVarObject(L, 2, kclass);
			object obj4 = ToLua.ToVarObject(L, 3);
			if (obj4 != null)
			{
				obj4 = TypeChecker.ChangeType(obj4, property.PropertyType);
			}
			object[] index2 = ToLua.CheckObjectArray(L, 4);
			property.SetValue(obj3, obj4, index2);
			return 0;
		}
		case 7:
		{
			object obj = ToLua.CheckVarObject(L, 2, kclass);
			object obj2 = ToLua.ToVarObject(L, 3);
			if (obj2 != null)
			{
				obj2 = TypeChecker.ChangeType(obj2, property.PropertyType);
			}
			BindingFlags invokeAttr = (BindingFlags)LuaDLL.luaL_checknumber(L, 4);
			Binder binder = (Binder)ToLua.CheckObject(L, 5, typeof(Binder));
			object[] index = ToLua.CheckObjectArray(L, 6);
			CultureInfo culture = (CultureInfo)ToLua.CheckObject(L, 7, typeof(CultureInfo));
			property.SetValue(obj, obj2, invokeAttr, binder, index, culture);
			return 0;
		}
		default:
			return LuaDLL.luaL_throw(L, "invalid arguments to method: LuaInterface.LuaProperty.Set");
		}
	}
}
