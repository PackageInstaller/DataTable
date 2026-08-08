using System;
using System.Globalization;
using System.Reflection;
using System.Runtime.InteropServices;
using LuaInterface;

public class System_TypeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(Type), typeof(object));
		L.RegFunction("Equals", Equals);
		L.RegFunction("GetType", GetType);
		L.RegFunction("GetTypeArray", GetTypeArray);
		L.RegFunction("GetTypeCode", GetTypeCode);
		L.RegFunction("GetTypeFromHandle", GetTypeFromHandle);
		L.RegFunction("GetTypeHandle", GetTypeHandle);
		L.RegFunction("IsSubclassOf", IsSubclassOf);
		L.RegFunction("FindInterfaces", FindInterfaces);
		L.RegFunction("GetInterface", GetInterface);
		L.RegFunction("GetInterfaceMap", GetInterfaceMap);
		L.RegFunction("GetInterfaces", GetInterfaces);
		L.RegFunction("IsAssignableFrom", IsAssignableFrom);
		L.RegFunction("IsInstanceOfType", IsInstanceOfType);
		L.RegFunction("GetArrayRank", GetArrayRank);
		L.RegFunction("GetElementType", GetElementType);
		L.RegFunction("GetHashCode", GetHashCode);
		L.RegFunction("GetNestedType", GetNestedType);
		L.RegFunction("GetNestedTypes", GetNestedTypes);
		L.RegFunction("GetDefaultMembers", GetDefaultMembers);
		L.RegFunction("FindMembers", FindMembers);
		L.RegFunction("InvokeMember", InvokeMember);
		L.RegFunction("ToString", ToString);
		L.RegFunction("GetGenericArguments", GetGenericArguments);
		L.RegFunction("GetGenericTypeDefinition", GetGenericTypeDefinition);
		L.RegFunction("MakeGenericType", MakeGenericType);
		L.RegFunction("GetGenericParameterConstraints", GetGenericParameterConstraints);
		L.RegFunction("MakeArrayType", MakeArrayType);
		L.RegFunction("MakeByRefType", MakeByRefType);
		L.RegFunction("MakePointerType", MakePointerType);
		L.RegFunction("ReflectionOnlyGetType", ReflectionOnlyGetType);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("Delimiter", get_Delimiter, null);
		L.RegVar("EmptyTypes", get_EmptyTypes, null);
		L.RegVar("FilterAttribute", get_FilterAttribute, null);
		L.RegVar("FilterName", get_FilterName, null);
		L.RegVar("FilterNameIgnoreCase", get_FilterNameIgnoreCase, null);
		L.RegVar("Missing", get_Missing, null);
		L.RegVar("Assembly", get_Assembly, null);
		L.RegVar("AssemblyQualifiedName", get_AssemblyQualifiedName, null);
		L.RegVar("Attributes", get_Attributes, null);
		L.RegVar("BaseType", get_BaseType, null);
		L.RegVar("DeclaringType", get_DeclaringType, null);
		L.RegVar("DefaultBinder", get_DefaultBinder, null);
		L.RegVar("FullName", get_FullName, null);
		L.RegVar("GUID", get_GUID, null);
		L.RegVar("HasElementType", get_HasElementType, null);
		L.RegVar("IsAbstract", get_IsAbstract, null);
		L.RegVar("IsAnsiClass", get_IsAnsiClass, null);
		L.RegVar("IsArray", get_IsArray, null);
		L.RegVar("IsAutoClass", get_IsAutoClass, null);
		L.RegVar("IsAutoLayout", get_IsAutoLayout, null);
		L.RegVar("IsByRef", get_IsByRef, null);
		L.RegVar("IsClass", get_IsClass, null);
		L.RegVar("IsCOMObject", get_IsCOMObject, null);
		L.RegVar("IsContextful", get_IsContextful, null);
		L.RegVar("IsEnum", get_IsEnum, null);
		L.RegVar("IsExplicitLayout", get_IsExplicitLayout, null);
		L.RegVar("IsImport", get_IsImport, null);
		L.RegVar("IsInterface", get_IsInterface, null);
		L.RegVar("IsLayoutSequential", get_IsLayoutSequential, null);
		L.RegVar("IsMarshalByRef", get_IsMarshalByRef, null);
		L.RegVar("IsNestedAssembly", get_IsNestedAssembly, null);
		L.RegVar("IsNestedFamANDAssem", get_IsNestedFamANDAssem, null);
		L.RegVar("IsNestedFamily", get_IsNestedFamily, null);
		L.RegVar("IsNestedFamORAssem", get_IsNestedFamORAssem, null);
		L.RegVar("IsNestedPrivate", get_IsNestedPrivate, null);
		L.RegVar("IsNestedPublic", get_IsNestedPublic, null);
		L.RegVar("IsNotPublic", get_IsNotPublic, null);
		L.RegVar("IsPointer", get_IsPointer, null);
		L.RegVar("IsPrimitive", get_IsPrimitive, null);
		L.RegVar("IsPublic", get_IsPublic, null);
		L.RegVar("IsSealed", get_IsSealed, null);
		L.RegVar("IsSerializable", get_IsSerializable, null);
		L.RegVar("IsSpecialName", get_IsSpecialName, null);
		L.RegVar("IsUnicodeClass", get_IsUnicodeClass, null);
		L.RegVar("IsValueType", get_IsValueType, null);
		L.RegVar("MemberType", get_MemberType, null);
		L.RegVar("Module", get_Module, null);
		L.RegVar("Namespace", get_Namespace, null);
		L.RegVar("ReflectedType", get_ReflectedType, null);
		L.RegVar("TypeHandle", get_TypeHandle, null);
		L.RegVar("TypeInitializer", get_TypeInitializer, null);
		L.RegVar("UnderlyingSystemType", get_UnderlyingSystemType, null);
		L.RegVar("ContainsGenericParameters", get_ContainsGenericParameters, null);
		L.RegVar("IsGenericTypeDefinition", get_IsGenericTypeDefinition, null);
		L.RegVar("IsGenericType", get_IsGenericType, null);
		L.RegVar("IsGenericParameter", get_IsGenericParameter, null);
		L.RegVar("IsNested", get_IsNested, null);
		L.RegVar("IsVisible", get_IsVisible, null);
		L.RegVar("GenericParameterPosition", get_GenericParameterPosition, null);
		L.RegVar("GenericParameterAttributes", get_GenericParameterAttributes, null);
		L.RegVar("DeclaringMethod", get_DeclaringMethod, null);
		L.RegVar("StructLayoutAttribute", get_StructLayoutAttribute, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Equals(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<Type>(L, 2))
			{
				Type type = ToLua.CheckMonoType(L, 1);
				Type type2 = (Type)ToLua.ToObject(L, 2);
				bool value = ((type != null) ? type.Equals(type2) : (type2 == null));
				LuaDLL.lua_pushboolean(L, value);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<object>(L, 2))
			{
				Type type3 = ToLua.CheckMonoType(L, 1);
				object obj = ToLua.ToVarObject(L, 2);
				bool value2 = ((type3 != null) ? type3.Equals(obj) : (obj == null));
				LuaDLL.lua_pushboolean(L, value2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: System.Type.Equals");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetType(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 1 && TypeChecker.CheckTypes<Type>(L, 1))
			{
				Type type = ((Type)ToLua.ToObject(L, 1)).GetType();
				ToLua.Push(L, type);
				return 1;
			}
			if (num == 1 && TypeChecker.CheckTypes<string>(L, 1))
			{
				Type type2 = Type.GetType(ToLua.ToString(L, 1));
				ToLua.Push(L, type2);
				return 1;
			}
			switch (num)
			{
			case 2:
			{
				string typeName2 = ToLua.CheckString(L, 1);
				bool throwOnError2 = LuaDLL.luaL_checkboolean(L, 2);
				Type type4 = Type.GetType(typeName2, throwOnError2);
				ToLua.Push(L, type4);
				return 1;
			}
			case 3:
			{
				string typeName = ToLua.CheckString(L, 1);
				bool throwOnError = LuaDLL.luaL_checkboolean(L, 2);
				bool ignoreCase = LuaDLL.luaL_checkboolean(L, 3);
				Type type3 = Type.GetType(typeName, throwOnError, ignoreCase);
				ToLua.Push(L, type3);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: System.Type.GetType");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetTypeArray(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Type[] typeArray = Type.GetTypeArray(ToLua.CheckObjectArray(L, 1));
			ToLua.Push(L, typeArray);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetTypeCode(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			TypeCode typeCode = Type.GetTypeCode(ToLua.CheckMonoType(L, 1));
			ToLua.Push(L, typeCode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetTypeFromHandle(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Type typeFromHandle = Type.GetTypeFromHandle(StackTraits<RuntimeTypeHandle>.Check(L, 1));
			ToLua.Push(L, typeFromHandle);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetTypeHandle(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			RuntimeTypeHandle typeHandle = Type.GetTypeHandle(ToLua.ToVarObject(L, 1));
			ToLua.PushValue(L, typeHandle);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsSubclassOf(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Type type = ToLua.CheckMonoType(L, 1);
			Type c = ToLua.CheckMonoType(L, 2);
			bool value = type.IsSubclassOf(c);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int FindInterfaces(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Type type = ToLua.CheckMonoType(L, 1);
			TypeFilter filter = (TypeFilter)ToLua.CheckDelegate<TypeFilter>(L, 2);
			object filterCriteria = ToLua.ToVarObject(L, 3);
			Type[] array = type.FindInterfaces(filter, filterCriteria);
			ToLua.Push(L, array);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetInterface(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Type type2 = ToLua.CheckMonoType(L, 1);
				string name2 = ToLua.CheckString(L, 2);
				Type t2 = type2.GetInterface(name2);
				ToLua.Push(L, t2);
				return 1;
			}
			case 3:
			{
				Type type = ToLua.CheckMonoType(L, 1);
				string name = ToLua.CheckString(L, 2);
				bool ignoreCase = LuaDLL.luaL_checkboolean(L, 3);
				Type t = type.GetInterface(name, ignoreCase);
				ToLua.Push(L, t);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: System.Type.GetInterface");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetInterfaceMap(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Type type = ToLua.CheckMonoType(L, 1);
			Type interfaceType = ToLua.CheckMonoType(L, 2);
			InterfaceMapping interfaceMap = type.GetInterfaceMap(interfaceType);
			ToLua.PushValue(L, interfaceMap);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetInterfaces(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Type[] interfaces = ToLua.CheckMonoType(L, 1).GetInterfaces();
			ToLua.Push(L, interfaces);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsAssignableFrom(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Type type = ToLua.CheckMonoType(L, 1);
			Type c = ToLua.CheckMonoType(L, 2);
			bool value = type.IsAssignableFrom(c);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsInstanceOfType(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Type type = ToLua.CheckMonoType(L, 1);
			object o = ToLua.ToVarObject(L, 2);
			bool value = type.IsInstanceOfType(o);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetArrayRank(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int arrayRank = ToLua.CheckMonoType(L, 1).GetArrayRank();
			LuaDLL.lua_pushinteger(L, arrayRank);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetElementType(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Type elementType = ToLua.CheckMonoType(L, 1).GetElementType();
			ToLua.Push(L, elementType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetHashCode(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int hashCode = ToLua.CheckMonoType(L, 1).GetHashCode();
			LuaDLL.lua_pushinteger(L, hashCode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetNestedType(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				Type type2 = ToLua.CheckMonoType(L, 1);
				string name2 = ToLua.CheckString(L, 2);
				Type nestedType2 = type2.GetNestedType(name2);
				ToLua.Push(L, nestedType2);
				return 1;
			}
			case 3:
			{
				Type type = ToLua.CheckMonoType(L, 1);
				string name = ToLua.CheckString(L, 2);
				BindingFlags bindingAttr = (BindingFlags)LuaDLL.luaL_checknumber(L, 3);
				Type nestedType = type.GetNestedType(name, bindingAttr);
				ToLua.Push(L, nestedType);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: System.Type.GetNestedType");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetNestedTypes(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				Type[] nestedTypes2 = ToLua.CheckMonoType(L, 1).GetNestedTypes();
				ToLua.Push(L, nestedTypes2);
				return 1;
			}
			case 2:
			{
				Type type = ToLua.CheckMonoType(L, 1);
				BindingFlags bindingAttr = (BindingFlags)LuaDLL.luaL_checknumber(L, 2);
				Type[] nestedTypes = type.GetNestedTypes(bindingAttr);
				ToLua.Push(L, nestedTypes);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: System.Type.GetNestedTypes");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetDefaultMembers(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			MemberInfo[] defaultMembers = ToLua.CheckMonoType(L, 1).GetDefaultMembers();
			ToLua.Push(L, defaultMembers);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int FindMembers(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 5);
			Type type = ToLua.CheckMonoType(L, 1);
			MemberTypes memberType = (MemberTypes)ToLua.CheckObject(L, 2, typeof(MemberTypes));
			BindingFlags bindingAttr = (BindingFlags)LuaDLL.luaL_checknumber(L, 3);
			MemberFilter filter = (MemberFilter)ToLua.CheckDelegate<MemberFilter>(L, 4);
			object filterCriteria = ToLua.ToVarObject(L, 5);
			MemberInfo[] array = type.FindMembers(memberType, bindingAttr, filter, filterCriteria);
			ToLua.Push(L, array);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InvokeMember(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 6:
			{
				Type type3 = ToLua.CheckMonoType(L, 1);
				string name3 = ToLua.CheckString(L, 2);
				BindingFlags invokeAttr3 = (BindingFlags)LuaDLL.luaL_checknumber(L, 3);
				Binder binder3 = (Binder)ToLua.CheckObject<Binder>(L, 4);
				object target3 = ToLua.ToVarObject(L, 5);
				object[] args3 = ToLua.CheckObjectArray(L, 6);
				object obj3 = type3.InvokeMember(name3, invokeAttr3, binder3, target3, args3);
				ToLua.Push(L, obj3);
				return 1;
			}
			case 7:
			{
				Type type2 = ToLua.CheckMonoType(L, 1);
				string name2 = ToLua.CheckString(L, 2);
				BindingFlags invokeAttr2 = (BindingFlags)LuaDLL.luaL_checknumber(L, 3);
				Binder binder2 = (Binder)ToLua.CheckObject<Binder>(L, 4);
				object target2 = ToLua.ToVarObject(L, 5);
				object[] args2 = ToLua.CheckObjectArray(L, 6);
				CultureInfo culture2 = (CultureInfo)ToLua.CheckObject<CultureInfo>(L, 7);
				object obj2 = type2.InvokeMember(name2, invokeAttr2, binder2, target2, args2, culture2);
				ToLua.Push(L, obj2);
				return 1;
			}
			case 9:
			{
				Type type = ToLua.CheckMonoType(L, 1);
				string name = ToLua.CheckString(L, 2);
				BindingFlags invokeAttr = (BindingFlags)LuaDLL.luaL_checknumber(L, 3);
				Binder binder = (Binder)ToLua.CheckObject<Binder>(L, 4);
				object target = ToLua.ToVarObject(L, 5);
				object[] args = ToLua.CheckObjectArray(L, 6);
				ParameterModifier[] modifiers = ToLua.CheckStructArray<ParameterModifier>(L, 7);
				CultureInfo culture = (CultureInfo)ToLua.CheckObject<CultureInfo>(L, 8);
				string[] namedParameters = ToLua.CheckStringArray(L, 9);
				object obj = type.InvokeMember(name, invokeAttr, binder, target, args, modifiers, culture, namedParameters);
				ToLua.Push(L, obj);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: System.Type.InvokeMember");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ToString(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string str = ToLua.CheckMonoType(L, 1).ToString();
			LuaDLL.lua_pushstring(L, str);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetGenericArguments(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Type[] genericArguments = ToLua.CheckMonoType(L, 1).GetGenericArguments();
			ToLua.Push(L, genericArguments);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetGenericTypeDefinition(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Type genericTypeDefinition = ToLua.CheckMonoType(L, 1).GetGenericTypeDefinition();
			ToLua.Push(L, genericTypeDefinition);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int MakeGenericType(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			Type type = ToLua.CheckMonoType(L, 1);
			Type[] typeArguments = ToLua.CheckParamsObject<Type>(L, 2, num - 1);
			Type t = type.MakeGenericType(typeArguments);
			ToLua.Push(L, t);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetGenericParameterConstraints(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Type[] genericParameterConstraints = ToLua.CheckMonoType(L, 1).GetGenericParameterConstraints();
			ToLua.Push(L, genericParameterConstraints);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int MakeArrayType(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				Type t2 = ToLua.CheckMonoType(L, 1).MakeArrayType();
				ToLua.Push(L, t2);
				return 1;
			}
			case 2:
			{
				Type type = ToLua.CheckMonoType(L, 1);
				int rank = (int)LuaDLL.luaL_checknumber(L, 2);
				Type t = type.MakeArrayType(rank);
				ToLua.Push(L, t);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: System.Type.MakeArrayType");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int MakeByRefType(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Type t = ToLua.CheckMonoType(L, 1).MakeByRefType();
			ToLua.Push(L, t);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int MakePointerType(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Type t = ToLua.CheckMonoType(L, 1).MakePointerType();
			ToLua.Push(L, t);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ReflectionOnlyGetType(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			string typeName = ToLua.CheckString(L, 1);
			bool throwIfNotFound = LuaDLL.luaL_checkboolean(L, 2);
			bool ignoreCase = LuaDLL.luaL_checkboolean(L, 3);
			Type t = Type.ReflectionOnlyGetType(typeName, throwIfNotFound, ignoreCase);
			ToLua.Push(L, t);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Delimiter(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, (int)Type.Delimiter);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_EmptyTypes(IntPtr L)
	{
		try
		{
			ToLua.Push(L, Type.EmptyTypes);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_FilterAttribute(IntPtr L)
	{
		try
		{
			ToLua.Push(L, Type.FilterAttribute);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_FilterName(IntPtr L)
	{
		try
		{
			ToLua.Push(L, Type.FilterName);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_FilterNameIgnoreCase(IntPtr L)
	{
		try
		{
			ToLua.Push(L, Type.FilterNameIgnoreCase);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Missing(IntPtr L)
	{
		try
		{
			ToLua.Push(L, Type.Missing);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Assembly(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Assembly assembly = ((Type)obj).Assembly;
			ToLua.PushObject(L, assembly);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Assembly on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_AssemblyQualifiedName(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string assemblyQualifiedName = ((Type)obj).AssemblyQualifiedName;
			LuaDLL.lua_pushstring(L, assemblyQualifiedName);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index AssemblyQualifiedName on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Attributes(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TypeAttributes attributes = ((Type)obj).Attributes;
			ToLua.Push(L, attributes);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Attributes on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_BaseType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Type baseType = ((Type)obj).BaseType;
			ToLua.Push(L, baseType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index BaseType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_DeclaringType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Type declaringType = ((Type)obj).DeclaringType;
			ToLua.Push(L, declaringType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index DeclaringType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_DefaultBinder(IntPtr L)
	{
		try
		{
			ToLua.PushObject(L, Type.DefaultBinder);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_FullName(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string fullName = ((Type)obj).FullName;
			LuaDLL.lua_pushstring(L, fullName);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index FullName on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_GUID(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Guid gUID = ((Type)obj).GUID;
			ToLua.PushValue(L, gUID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index GUID on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_HasElementType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool hasElementType = ((Type)obj).HasElementType;
			LuaDLL.lua_pushboolean(L, hasElementType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index HasElementType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsAbstract(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isAbstract = ((Type)obj).IsAbstract;
			LuaDLL.lua_pushboolean(L, isAbstract);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsAbstract on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsAnsiClass(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isAnsiClass = ((Type)obj).IsAnsiClass;
			LuaDLL.lua_pushboolean(L, isAnsiClass);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsAnsiClass on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsArray(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isArray = ((Type)obj).IsArray;
			LuaDLL.lua_pushboolean(L, isArray);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsArray on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsAutoClass(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isAutoClass = ((Type)obj).IsAutoClass;
			LuaDLL.lua_pushboolean(L, isAutoClass);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsAutoClass on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsAutoLayout(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isAutoLayout = ((Type)obj).IsAutoLayout;
			LuaDLL.lua_pushboolean(L, isAutoLayout);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsAutoLayout on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsByRef(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isByRef = ((Type)obj).IsByRef;
			LuaDLL.lua_pushboolean(L, isByRef);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsByRef on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsClass(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isClass = ((Type)obj).IsClass;
			LuaDLL.lua_pushboolean(L, isClass);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsClass on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsCOMObject(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isCOMObject = ((Type)obj).IsCOMObject;
			LuaDLL.lua_pushboolean(L, isCOMObject);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsCOMObject on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsContextful(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isContextful = ((Type)obj).IsContextful;
			LuaDLL.lua_pushboolean(L, isContextful);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsContextful on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsEnum(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isEnum = ((Type)obj).IsEnum;
			LuaDLL.lua_pushboolean(L, isEnum);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsEnum on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsExplicitLayout(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isExplicitLayout = ((Type)obj).IsExplicitLayout;
			LuaDLL.lua_pushboolean(L, isExplicitLayout);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsExplicitLayout on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsImport(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isImport = ((Type)obj).IsImport;
			LuaDLL.lua_pushboolean(L, isImport);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsImport on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsInterface(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isInterface = ((Type)obj).IsInterface;
			LuaDLL.lua_pushboolean(L, isInterface);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsInterface on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsLayoutSequential(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isLayoutSequential = ((Type)obj).IsLayoutSequential;
			LuaDLL.lua_pushboolean(L, isLayoutSequential);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsLayoutSequential on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsMarshalByRef(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isMarshalByRef = ((Type)obj).IsMarshalByRef;
			LuaDLL.lua_pushboolean(L, isMarshalByRef);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsMarshalByRef on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsNestedAssembly(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isNestedAssembly = ((Type)obj).IsNestedAssembly;
			LuaDLL.lua_pushboolean(L, isNestedAssembly);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsNestedAssembly on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsNestedFamANDAssem(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isNestedFamANDAssem = ((Type)obj).IsNestedFamANDAssem;
			LuaDLL.lua_pushboolean(L, isNestedFamANDAssem);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsNestedFamANDAssem on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsNestedFamily(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isNestedFamily = ((Type)obj).IsNestedFamily;
			LuaDLL.lua_pushboolean(L, isNestedFamily);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsNestedFamily on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsNestedFamORAssem(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isNestedFamORAssem = ((Type)obj).IsNestedFamORAssem;
			LuaDLL.lua_pushboolean(L, isNestedFamORAssem);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsNestedFamORAssem on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsNestedPrivate(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isNestedPrivate = ((Type)obj).IsNestedPrivate;
			LuaDLL.lua_pushboolean(L, isNestedPrivate);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsNestedPrivate on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsNestedPublic(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isNestedPublic = ((Type)obj).IsNestedPublic;
			LuaDLL.lua_pushboolean(L, isNestedPublic);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsNestedPublic on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsNotPublic(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isNotPublic = ((Type)obj).IsNotPublic;
			LuaDLL.lua_pushboolean(L, isNotPublic);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsNotPublic on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsPointer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isPointer = ((Type)obj).IsPointer;
			LuaDLL.lua_pushboolean(L, isPointer);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsPointer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsPrimitive(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isPrimitive = ((Type)obj).IsPrimitive;
			LuaDLL.lua_pushboolean(L, isPrimitive);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsPrimitive on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsPublic(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isPublic = ((Type)obj).IsPublic;
			LuaDLL.lua_pushboolean(L, isPublic);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsPublic on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsSealed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isSealed = ((Type)obj).IsSealed;
			LuaDLL.lua_pushboolean(L, isSealed);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsSealed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsSerializable(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isSerializable = ((Type)obj).IsSerializable;
			LuaDLL.lua_pushboolean(L, isSerializable);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsSerializable on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsSpecialName(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isSpecialName = ((Type)obj).IsSpecialName;
			LuaDLL.lua_pushboolean(L, isSpecialName);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsSpecialName on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsUnicodeClass(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isUnicodeClass = ((Type)obj).IsUnicodeClass;
			LuaDLL.lua_pushboolean(L, isUnicodeClass);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsUnicodeClass on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsValueType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isValueType = ((Type)obj).IsValueType;
			LuaDLL.lua_pushboolean(L, isValueType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsValueType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_MemberType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MemberTypes memberType = ((Type)obj).MemberType;
			ToLua.Push(L, memberType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index MemberType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Module(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Module module = ((Type)obj).Module;
			ToLua.PushObject(L, module);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Module on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Namespace(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string str = ((Type)obj).Namespace;
			LuaDLL.lua_pushstring(L, str);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Namespace on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ReflectedType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Type reflectedType = ((Type)obj).ReflectedType;
			ToLua.Push(L, reflectedType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ReflectedType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_TypeHandle(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RuntimeTypeHandle typeHandle = ((Type)obj).TypeHandle;
			ToLua.PushValue(L, typeHandle);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index TypeHandle on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_TypeInitializer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			ConstructorInfo typeInitializer = ((Type)obj).TypeInitializer;
			ToLua.PushObject(L, typeInitializer);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index TypeInitializer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_UnderlyingSystemType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Type underlyingSystemType = ((Type)obj).UnderlyingSystemType;
			ToLua.Push(L, underlyingSystemType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index UnderlyingSystemType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ContainsGenericParameters(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool containsGenericParameters = ((Type)obj).ContainsGenericParameters;
			LuaDLL.lua_pushboolean(L, containsGenericParameters);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ContainsGenericParameters on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsGenericTypeDefinition(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isGenericTypeDefinition = ((Type)obj).IsGenericTypeDefinition;
			LuaDLL.lua_pushboolean(L, isGenericTypeDefinition);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsGenericTypeDefinition on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsGenericType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isGenericType = ((Type)obj).IsGenericType;
			LuaDLL.lua_pushboolean(L, isGenericType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsGenericType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsGenericParameter(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isGenericParameter = ((Type)obj).IsGenericParameter;
			LuaDLL.lua_pushboolean(L, isGenericParameter);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsGenericParameter on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsNested(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isNested = ((Type)obj).IsNested;
			LuaDLL.lua_pushboolean(L, isNested);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsNested on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsVisible(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isVisible = ((Type)obj).IsVisible;
			LuaDLL.lua_pushboolean(L, isVisible);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsVisible on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_GenericParameterPosition(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int genericParameterPosition = ((Type)obj).GenericParameterPosition;
			LuaDLL.lua_pushinteger(L, genericParameterPosition);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index GenericParameterPosition on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_GenericParameterAttributes(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GenericParameterAttributes genericParameterAttributes = ((Type)obj).GenericParameterAttributes;
			ToLua.Push(L, genericParameterAttributes);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index GenericParameterAttributes on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_DeclaringMethod(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MethodBase declaringMethod = ((Type)obj).DeclaringMethod;
			ToLua.PushObject(L, declaringMethod);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index DeclaringMethod on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_StructLayoutAttribute(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			StructLayoutAttribute structLayoutAttribute = ((Type)obj).StructLayoutAttribute;
			ToLua.PushSealed(L, structLayoutAttribute);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index StructLayoutAttribute on a nil value");
		}
	}
}
