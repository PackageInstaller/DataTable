using System;
using System.Collections.Generic;
using System.Reflection;

namespace LuaInterface;

public class LuaReflection : IDisposable
{
	public List<Assembly> list = new List<Assembly>();

	private static LuaReflection _reflection;

	public LuaReflection()
	{
		_reflection = this;
		LoadAssembly("mscorlib");
		LoadAssembly("UnityEngine");
	}

	public static void OpenLibs(IntPtr L)
	{
		LuaDLL.lua_getglobal(L, "tolua");
		LuaDLL.lua_pushstring(L, "findtype");
		LuaDLL.lua_pushcfunction(L, FindType);
		LuaDLL.lua_rawset(L, -3);
		LuaDLL.lua_pushstring(L, "loadassembly");
		LuaDLL.tolua_pushcfunction(L, LoadAssembly);
		LuaDLL.lua_rawset(L, -3);
		LuaDLL.lua_pushstring(L, "getmethod");
		LuaDLL.tolua_pushcfunction(L, GetMethod);
		LuaDLL.lua_rawset(L, -3);
		LuaDLL.lua_pushstring(L, "getconstructor");
		LuaDLL.tolua_pushcfunction(L, GetConstructor);
		LuaDLL.lua_rawset(L, -3);
		LuaDLL.lua_pushstring(L, "gettypemethod");
		LuaDLL.tolua_pushcfunction(L, GetTypeMethod);
		LuaDLL.lua_rawset(L, -3);
		LuaDLL.lua_pushstring(L, "getfield");
		LuaDLL.tolua_pushcfunction(L, GetField);
		LuaDLL.lua_rawset(L, -3);
		LuaDLL.lua_pushstring(L, "getproperty");
		LuaDLL.tolua_pushcfunction(L, GetProperty);
		LuaDLL.lua_rawset(L, -3);
		LuaDLL.lua_pushstring(L, "createinstance");
		LuaDLL.tolua_pushcfunction(L, CreateInstance);
		LuaDLL.lua_rawset(L, -3);
		LuaDLL.lua_pop(L, 1);
		LuaState luaState = LuaState.Get(L);
		luaState.BeginPreLoad();
		luaState.AddPreLoad("tolua.reflection", OpenReflectionLibs);
		luaState.EndPreLoad();
	}

	public static LuaReflection Get(IntPtr L)
	{
		return _reflection;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OpenReflectionLibs(IntPtr L)
	{
		try
		{
			LuaState luaState = LuaState.Get(L);
			luaState.BeginModule(null);
			luaState.BeginModule("LuaInterface");
			LuaInterface_LuaMethodWrap.Register(luaState);
			LuaInterface_LuaPropertyWrap.Register(luaState);
			LuaInterface_LuaFieldWrap.Register(luaState);
			LuaInterface_LuaConstructorWrap.Register(luaState);
			luaState.EndModule();
			luaState.EndModule();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int FindType(IntPtr L)
	{
		string name = ToLua.CheckString(L, 1);
		List<Assembly> list = Get(L).list;
		Type type = null;
		for (int i = 0; i < list.Count; i++)
		{
			type = list[i].GetType(name);
			if (type != null)
			{
				break;
			}
		}
		ToLua.Push(L, type);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LoadAssembly(IntPtr L)
	{
		try
		{
			LuaReflection luaReflection = Get(L);
			string name = ToLua.CheckString(L, 1);
			LuaDLL.lua_pushboolean(L, luaReflection.LoadAssembly(name));
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
		return 1;
	}

	private static void PushLuaMethod(IntPtr L, MethodInfo md, Type t, Type[] types)
	{
		if (md != null)
		{
			LuaMethod o = new LuaMethod(md, t, types);
			ToLua.PushSealed(L, o);
		}
		else
		{
			LuaDLL.lua_pushnil(L);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetMethod(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			Type type = ToLua.CheckMonoType(L, 1);
			string name = ToLua.CheckString(L, 2);
			Type[] array = null;
			if (num > 2)
			{
				array = new Type[num - 2];
				for (int i = 3; i <= num; i++)
				{
					Type type2 = ToLua.CheckMonoType(L, i);
					if (type2 == null)
					{
						LuaDLL.luaL_typerror(L, i, "Type");
					}
					array[i - 3] = type2;
				}
			}
			MethodInfo methodInfo = null;
			methodInfo = ((array != null) ? type.GetMethod(name, array) : type.GetMethod(name));
			PushLuaMethod(L, methodInfo, type, array);
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
		return 1;
	}

	private static void PushLuaConstructor(IntPtr L, ConstructorInfo func, Type[] types)
	{
		if (func != null)
		{
			LuaConstructor o = new LuaConstructor(func, types);
			ToLua.PushSealed(L, o);
		}
		else
		{
			LuaDLL.lua_pushnil(L);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetConstructor(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			Type type = (Type)ToLua.CheckObject(L, 1, typeof(Type));
			Type[] array = null;
			if (num > 1)
			{
				array = new Type[num - 1];
				for (int i = 2; i <= num; i++)
				{
					Type type2 = ToLua.CheckMonoType(L, i);
					if (type2 == null)
					{
						LuaDLL.luaL_typerror(L, i, "Type");
					}
					array[i - 2] = type2;
				}
			}
			ConstructorInfo constructor = type.GetConstructor(array);
			PushLuaConstructor(L, constructor, array);
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetTypeMethod(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<Type, string>(L, 1))
			{
				Type type = (Type)ToLua.ToObject(L, 1);
				string name = ToLua.ToString(L, 2);
				MethodInfo method = type.GetMethod(name);
				PushLuaMethod(L, method, type, null);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<Type, string, Type[]>(L, 1))
			{
				Type type2 = (Type)ToLua.ToObject(L, 1);
				string name2 = ToLua.ToString(L, 2);
				Type[] types = ToLua.ToObjectArray<Type>(L, 3);
				MethodInfo method2 = type2.GetMethod(name2, types);
				PushLuaMethod(L, method2, type2, types);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<Type, string, uint>(L, 1))
			{
				Type type3 = (Type)ToLua.ToObject(L, 1);
				string name3 = ToLua.ToString(L, 2);
				BindingFlags bindingAttr = (BindingFlags)LuaDLL.lua_tonumber(L, 3);
				MethodInfo method3 = type3.GetMethod(name3, bindingAttr);
				PushLuaMethod(L, method3, type3, null);
				return 1;
			}
			if (num == 4 && TypeChecker.CheckTypes<Type, string, Type[], ParameterModifier[]>(L, 1))
			{
				Type type4 = (Type)ToLua.ToObject(L, 1);
				string name4 = ToLua.ToString(L, 2);
				Type[] types2 = ToLua.ToObjectArray<Type>(L, 3);
				ParameterModifier[] modifiers = ToLua.ToStructArray<ParameterModifier>(L, 4);
				MethodInfo method4 = type4.GetMethod(name4, types2, modifiers);
				PushLuaMethod(L, method4, type4, types2);
				return 1;
			}
			if (num == 6 && TypeChecker.CheckTypes<Type, string, uint, Binder, Type[], ParameterModifier[]>(L, 1))
			{
				Type type5 = (Type)ToLua.ToObject(L, 1);
				string name5 = ToLua.ToString(L, 2);
				BindingFlags bindingAttr2 = (BindingFlags)LuaDLL.lua_tonumber(L, 3);
				Binder binder = (Binder)ToLua.ToObject(L, 4);
				Type[] types3 = ToLua.ToObjectArray<Type>(L, 5);
				ParameterModifier[] modifiers2 = ToLua.ToStructArray<ParameterModifier>(L, 6);
				MethodInfo method5 = type5.GetMethod(name5, bindingAttr2, binder, types3, modifiers2);
				PushLuaMethod(L, method5, type5, types3);
				return 1;
			}
			if (num == 7 && TypeChecker.CheckTypes<Type, string, uint, Binder, CallingConventions, Type[], ParameterModifier[]>(L, 1))
			{
				Type type6 = (Type)ToLua.ToObject(L, 1);
				string name6 = ToLua.ToString(L, 2);
				BindingFlags bindingAttr3 = (BindingFlags)LuaDLL.lua_tonumber(L, 3);
				Binder binder2 = (Binder)ToLua.ToObject(L, 4);
				CallingConventions callConvention = (CallingConventions)ToLua.ToObject(L, 5);
				Type[] types4 = ToLua.ToObjectArray<Type>(L, 6);
				ParameterModifier[] modifiers3 = ToLua.ToStructArray<ParameterModifier>(L, 7);
				MethodInfo method6 = type6.GetMethod(name6, bindingAttr3, binder2, callConvention, types4, modifiers3);
				PushLuaMethod(L, method6, type6, types4);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: tolua.gettypemethod");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	private static void PushLuaProperty(IntPtr L, PropertyInfo p, Type t)
	{
		if (p != null)
		{
			LuaProperty o = new LuaProperty(p, t);
			ToLua.PushSealed(L, o);
		}
		else
		{
			LuaDLL.lua_pushnil(L);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetProperty(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<Type, string>(L, 1))
			{
				Type type = (Type)ToLua.ToObject(L, 1);
				string name = ToLua.ToString(L, 2);
				PropertyInfo property = type.GetProperty(name);
				PushLuaProperty(L, property, type);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<Type, string, Type[]>(L, 1))
			{
				Type type2 = (Type)ToLua.ToObject(L, 1);
				string name2 = ToLua.ToString(L, 2);
				Type[] types = ToLua.ToObjectArray<Type>(L, 3);
				PropertyInfo property2 = type2.GetProperty(name2, types);
				PushLuaProperty(L, property2, type2);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<Type, string, Type>(L, 1))
			{
				Type type3 = (Type)ToLua.ToObject(L, 1);
				string name3 = ToLua.ToString(L, 2);
				Type returnType = (Type)ToLua.ToObject(L, 3);
				PropertyInfo property3 = type3.GetProperty(name3, returnType);
				PushLuaProperty(L, property3, type3);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<Type, string, uint>(L, 1))
			{
				Type type4 = (Type)ToLua.ToObject(L, 1);
				string name4 = ToLua.ToString(L, 2);
				BindingFlags bindingAttr = (BindingFlags)LuaDLL.lua_tonumber(L, 3);
				PropertyInfo property4 = type4.GetProperty(name4, bindingAttr);
				PushLuaProperty(L, property4, type4);
				return 1;
			}
			if (num == 4 && TypeChecker.CheckTypes<Type, string, Type, Type[]>(L, 1))
			{
				Type type5 = (Type)ToLua.ToObject(L, 1);
				string name5 = ToLua.ToString(L, 2);
				Type returnType2 = (Type)ToLua.ToObject(L, 3);
				Type[] types2 = ToLua.ToObjectArray<Type>(L, 4);
				PropertyInfo property5 = type5.GetProperty(name5, returnType2, types2);
				PushLuaProperty(L, property5, type5);
				return 1;
			}
			if (num == 5 && TypeChecker.CheckTypes<Type, string, Type, Type[], ParameterModifier[]>(L, 1))
			{
				Type type6 = (Type)ToLua.ToObject(L, 1);
				string name6 = ToLua.ToString(L, 2);
				Type returnType3 = (Type)ToLua.ToObject(L, 3);
				Type[] types3 = ToLua.ToObjectArray<Type>(L, 4);
				ParameterModifier[] modifiers = ToLua.ToStructArray<ParameterModifier>(L, 5);
				PropertyInfo property6 = type6.GetProperty(name6, returnType3, types3, modifiers);
				PushLuaProperty(L, property6, type6);
				return 1;
			}
			if (num == 7 && TypeChecker.CheckTypes<Type, string, uint, Binder, Type, Type[], ParameterModifier[]>(L, 1))
			{
				Type type7 = (Type)ToLua.ToObject(L, 1);
				string name7 = ToLua.ToString(L, 2);
				BindingFlags bindingAttr2 = (BindingFlags)LuaDLL.lua_tonumber(L, 3);
				Binder binder = (Binder)ToLua.ToObject(L, 4);
				Type returnType4 = (Type)ToLua.ToObject(L, 5);
				Type[] types4 = ToLua.ToObjectArray<Type>(L, 6);
				ParameterModifier[] modifiers2 = ToLua.ToStructArray<ParameterModifier>(L, 7);
				PropertyInfo property7 = type7.GetProperty(name7, bindingAttr2, binder, returnType4, types4, modifiers2);
				PushLuaProperty(L, property7, type7);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: tolua.getproperty");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	private static void PushLuaField(IntPtr L, FieldInfo f, Type t)
	{
		if (f != null)
		{
			LuaField o = new LuaField(f, t);
			ToLua.PushSealed(L, o);
		}
		else
		{
			LuaDLL.lua_pushnil(L);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetField(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<Type, string>(L, 1))
			{
				Type type = (Type)ToLua.ToObject(L, 1);
				string name = ToLua.ToString(L, 2);
				FieldInfo field = type.GetField(name);
				PushLuaField(L, field, type);
				return 1;
			}
			if (num == 3 && TypeChecker.CheckTypes<Type, string, uint>(L, 1))
			{
				Type type2 = (Type)ToLua.ToObject(L, 1);
				string name2 = ToLua.ToString(L, 2);
				BindingFlags bindingAttr = (BindingFlags)LuaDLL.lua_tonumber(L, 3);
				FieldInfo field2 = type2.GetField(name2, bindingAttr);
				PushLuaField(L, field2, type2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: tolua.getfield");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CreateInstance(IntPtr L)
	{
		try
		{
			Type type = ToLua.CheckMonoType(L, 1);
			if (type == null)
			{
				LuaDLL.luaL_typerror(L, 1, "Type");
			}
			int num = LuaDLL.lua_gettop(L);
			object obj = null;
			if (num == 1)
			{
				obj = Activator.CreateInstance(type);
			}
			else
			{
				object[] array = new object[num - 1];
				for (int i = 2; i <= num; i++)
				{
					array[i - 2] = ToLua.ToVarObject(L, i);
				}
				obj = Activator.CreateInstance(type, array);
			}
			ToLua.Push(L, obj);
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
		return 1;
	}

	private bool LoadAssembly(string name)
	{
		for (int i = 0; i < list.Count; i++)
		{
			if (list[i].GetName().Name == name)
			{
				return true;
			}
		}
		Assembly assembly = Assembly.Load(name);
		if (assembly == null)
		{
			assembly = Assembly.Load(AssemblyName.GetAssemblyName(name));
		}
		if (assembly != null && !list.Contains(assembly))
		{
			list.Add(assembly);
		}
		return assembly != null;
	}

	public void Dispose()
	{
		list.Clear();
	}
}
