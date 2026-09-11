using System;
using System.Globalization;
using System.Reflection;

namespace LuaInterface;

public sealed class LuaField
{
	private FieldInfo field;

	private Type kclass;

	[NoToLua]
	public LuaField(FieldInfo info, Type t)
	{
		field = info;
		kclass = t;
	}

	public int Get(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			object obj = ToLua.CheckObject(L, 2, kclass);
			object value = field.GetValue(obj);
			if (value == null)
			{
				if (typeof(MulticastDelegate).IsAssignableFrom(field.FieldType))
				{
					value = DelegateFactory.CreateDelegate(field.FieldType);
					ToLua.Push(L, (Delegate)value);
				}
				else
				{
					LuaDLL.lua_pushnil(L);
				}
			}
			else
			{
				ToLua.Push(L, value);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	public int Set(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				object obj3 = ToLua.CheckVarObject(L, 2, kclass);
				object obj4 = ToLua.ToVarObject(L, 3);
				if (obj4 != null)
				{
					obj4 = TypeChecker.ChangeType(obj4, field.FieldType);
				}
				field.SetValue(obj3, obj4);
				return 0;
			}
			case 6:
			{
				object obj = ToLua.CheckVarObject(L, 2, kclass);
				object obj2 = ToLua.ToVarObject(L, 3);
				if (obj2 != null)
				{
					obj2 = TypeChecker.ChangeType(obj2, field.FieldType);
				}
				BindingFlags invokeAttr = (BindingFlags)LuaDLL.luaL_checknumber(L, 4);
				Binder binder = (Binder)ToLua.CheckObject(L, 5, typeof(Binder));
				CultureInfo culture = (CultureInfo)ToLua.CheckObject(L, 6, typeof(CultureInfo));
				field.SetValue(obj, obj2, invokeAttr, binder, culture);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: LuaField.Set");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
