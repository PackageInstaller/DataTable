using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.Serialization;
using ParadoxNotion.Serialization;
using UnityEngine;

namespace ParadoxNotion;

public static class ReflectionTools
{
	public enum MethodType
	{
		Normal,
		PropertyAccessor,
		Event,
		Operator
	}

	public const BindingFlags FLAGS_ALL = BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.FlattenHierarchy;

	public const BindingFlags FLAGS_ALL_DECLARED = BindingFlags.DeclaredOnly | BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic;

	private static Assembly[] _loadedAssemblies;

	private static Type[] _allTypes;

	private static object[] _tempArgs;

	private static Dictionary<string, Type> _typesMap;

	private static Dictionary<Type, Type[]> _subTypesMap;

	private static Dictionary<MethodBase, MethodType> _methodSpecialType;

	private static Dictionary<Type, string> _typeFriendlyName;

	private static Dictionary<Type, string> _typeFriendlyNameCompileSafe;

	private static Dictionary<MethodBase, string> _methodSignatures;

	private static Dictionary<Type, ConstructorInfo[]> _typeConstructors;

	private static Dictionary<Type, MethodInfo[]> _typeMethods;

	private static Dictionary<Type, FieldInfo[]> _typeFields;

	private static Dictionary<Type, PropertyInfo[]> _typeProperties;

	private static Dictionary<Type, EventInfo[]> _typeEvents;

	private static Dictionary<Type, object[]> _typeAttributes;

	private static Dictionary<MemberInfo, object[]> _memberAttributes;

	private static Dictionary<MemberInfo, bool> _obsoleteCache;

	private static Dictionary<Type, MethodInfo[]> _typeExtensions;

	private static Dictionary<Type, Type[]> _genericArgsTypeCache;

	private static Dictionary<MethodInfo, Type[]> _genericArgsMathodCache;

	public static readonly Dictionary<string, string> op_FriendlyNamesLong;

	public static readonly Dictionary<string, string> op_FriendlyNamesShort;

	public static readonly Dictionary<string, string> op_CSharpAliases;

	public const string METHOD_SPECIAL_NAME_GET = "get_";

	public const string METHOD_SPECIAL_NAME_SET = "set_";

	public const string METHOD_SPECIAL_NAME_ADD = "add_";

	public const string METHOD_SPECIAL_NAME_REMOVE = "remove_";

	public const string METHOD_SPECIAL_NAME_OP = "op_";

	private static Assembly[] loadedAssemblies
	{
		get
		{
			if (_loadedAssemblies == null)
			{
				return _loadedAssemblies = AppDomain.CurrentDomain.GetAssemblies();
			}
			return _loadedAssemblies;
		}
	}

	static ReflectionTools()
	{
		op_FriendlyNamesLong = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase)
		{
			{ "op_Equality", "Equal" },
			{ "op_Inequality", "Not Equal" },
			{ "op_GreaterThan", "Greater" },
			{ "op_LessThan", "Less" },
			{ "op_GreaterThanOrEqual", "Greater Or Equal" },
			{ "op_LessThanOrEqual", "Less Or Equal" },
			{ "op_Addition", "Add" },
			{ "op_Subtraction", "Subtract" },
			{ "op_Division", "Divide" },
			{ "op_Multiply", "Multiply" },
			{ "op_UnaryNegation", "Negate" },
			{ "op_UnaryPlus", "Positive" },
			{ "op_Increment", "Increment" },
			{ "op_Decrement", "Decrement" },
			{ "op_LogicalNot", "NOT" },
			{ "op_OnesComplement", "Complements" },
			{ "op_False", "FALSE" },
			{ "op_True", "TRUE" },
			{ "op_Modulus", "MOD" },
			{ "op_BitwiseAnd", "AND" },
			{ "op_BitwiseOR", "OR" },
			{ "op_LeftShift", "Shift Left" },
			{ "op_RightShift", "Shift Right" },
			{ "op_ExclusiveOr", "XOR" },
			{ "op_Implicit", "Convert" },
			{ "op_Explicit", "Convert" }
		};
		op_FriendlyNamesShort = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase)
		{
			{ "op_Equality", "=" },
			{ "op_Inequality", "≠" },
			{ "op_GreaterThan", ">" },
			{ "op_LessThan", "<" },
			{ "op_GreaterThanOrEqual", "≥" },
			{ "op_LessThanOrEqual", "≤" },
			{ "op_Addition", "+" },
			{ "op_Subtraction", "-" },
			{ "op_Division", "÷" },
			{ "op_Multiply", "×" },
			{ "op_UnaryNegation", "Negate" },
			{ "op_UnaryPlus", "Positive" },
			{ "op_Increment", "++" },
			{ "op_Decrement", "--" },
			{ "op_LogicalNot", "NOT" },
			{ "op_OnesComplement", "~" },
			{ "op_False", "FALSE" },
			{ "op_True", "TRUE" },
			{ "op_Modulus", "MOD" },
			{ "op_BitwiseAnd", "AND" },
			{ "op_BitwiseOR", "OR" },
			{ "op_LeftShift", "<<" },
			{ "op_RightShift", ">>" },
			{ "op_ExclusiveOr", "XOR" },
			{ "op_Implicit", "Convert" },
			{ "op_Explicit", "Convert" }
		};
		op_CSharpAliases = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase)
		{
			{ "!=", "≠" },
			{ ">=", "≥" },
			{ "<=", "≤" },
			{ "/", "÷" },
			{ "*", "×" }
		};
		FlushMem();
	}

	public static void FlushMem()
	{
		_loadedAssemblies = new Assembly[4];
		_loadedAssemblies[0] = Assembly.Load("Unity.Model.Codes");
		_loadedAssemblies[1] = Assembly.Load("UnityEngine");
		_loadedAssemblies[2] = Assembly.Load("UnityEngine.UI");
		_loadedAssemblies[3] = Assembly.Load("Unity.Hotfix.Codes");
		_allTypes = null;
		_tempArgs = new object[1];
		_typesMap = new Dictionary<string, Type>();
		_subTypesMap = new Dictionary<Type, Type[]>();
		_methodSpecialType = new Dictionary<MethodBase, MethodType>();
		_typeFriendlyName = new Dictionary<Type, string>();
		_typeFriendlyNameCompileSafe = new Dictionary<Type, string>();
		_methodSignatures = new Dictionary<MethodBase, string>();
		_typeConstructors = new Dictionary<Type, ConstructorInfo[]>();
		_typeMethods = new Dictionary<Type, MethodInfo[]>();
		_typeFields = new Dictionary<Type, FieldInfo[]>();
		_typeProperties = new Dictionary<Type, PropertyInfo[]>();
		_typeEvents = new Dictionary<Type, EventInfo[]>();
		_typeAttributes = new Dictionary<Type, object[]>();
		_memberAttributes = new Dictionary<MemberInfo, object[]>();
		_obsoleteCache = new Dictionary<MemberInfo, bool>();
		_typeExtensions = new Dictionary<Type, MethodInfo[]>();
		_genericArgsTypeCache = new Dictionary<Type, Type[]>();
		_genericArgsMathodCache = new Dictionary<MethodInfo, Type[]>();
	}

	public static Type GetType(string typeFullName)
	{
		return GetType(typeFullName, false, null);
	}

	public static Type GetType(string typeFullName, Type fallbackAssignable)
	{
		return GetType(typeFullName, fallbackNoNamespace: true, fallbackAssignable);
	}

	public static Type GetType(string typeFullName, bool fallbackNoNamespace = false, Type fallbackAssignable = null)
	{
		if (string.IsNullOrEmpty(typeFullName))
		{
			return null;
		}
		Type value = null;
		if (_typesMap.TryGetValue(typeFullName, out value))
		{
			return value;
		}
		value = GetTypeDirect(typeFullName);
		if (value != null)
		{
			return _typesMap[typeFullName] = value;
		}
		value = TryResolveGenericType(typeFullName, fallbackNoNamespace, fallbackAssignable);
		if (value != null)
		{
			return _typesMap[typeFullName] = value;
		}
		value = TryResolveDeserializeFromAttribute(typeFullName);
		if (value != null)
		{
			return _typesMap[typeFullName] = value;
		}
		if (fallbackNoNamespace)
		{
			value = TryResolveWithoutNamespace(typeFullName, fallbackAssignable);
			if (value != null)
			{
				return _typesMap[typeFullName] = value;
			}
		}
		return _typesMap[typeFullName] = null;
	}

	private static Type GetTypeDirect(string typeFullName)
	{
		Type type = Type.GetType(typeFullName);
		if (type != null)
		{
			return type;
		}
		for (int i = 0; i < loadedAssemblies.Length; i++)
		{
			Assembly assembly = loadedAssemblies[i];
			try
			{
				type = assembly.GetType(typeFullName);
			}
			catch
			{
				continue;
			}
			if (type != null)
			{
				return type;
			}
		}
		return null;
	}

	private static Type TryResolveGenericType(string typeFullName, bool fallbackNoNamespace = false, Type fallbackAssignable = null)
	{
		if (!typeFullName.Contains('`') || !typeFullName.Contains('['))
		{
			return null;
		}
		try
		{
			int num = typeFullName.IndexOf('`');
			Type type = GetType(typeFullName.Substring(0, num + 2), fallbackNoNamespace, fallbackAssignable);
			if (type == null)
			{
				return null;
			}
			int num2 = Convert.ToInt32(typeFullName.Substring(num + 1, 1));
			string text = typeFullName.Substring(num + 2, typeFullName.Length - num - 2);
			string[] array = null;
			if (text.StartsWith("[["))
			{
				int num3 = typeFullName.IndexOf("[[") + 2;
				int num4 = typeFullName.LastIndexOf("]]");
				array = typeFullName.Substring(num3, num4 - num3).Split(new string[1] { "],[" }, num2, StringSplitOptions.RemoveEmptyEntries);
			}
			else
			{
				int num5 = typeFullName.IndexOf('[') + 1;
				int num6 = typeFullName.LastIndexOf(']');
				array = typeFullName.Substring(num5, num6 - num5).Split(new char[1] { ',' }, num2, StringSplitOptions.RemoveEmptyEntries);
			}
			Type[] array2 = new Type[num2];
			for (int i = 0; i < array.Length; i++)
			{
				string text2 = array[i];
				if (!text2.Contains('`') && text2.Contains(','))
				{
					text2 = text2.Substring(0, text2.IndexOf(','));
				}
				Type type2 = GetType(text2, fallbackNoNamespace: true);
				if (type2 == null)
				{
					return null;
				}
				array2[i] = type2;
			}
			return type.RTMakeGenericType(array2);
		}
		catch (Exception)
		{
			return null;
		}
	}

	private static Type TryResolveDeserializeFromAttribute(string typeName)
	{
		Type[] allTypes = GetAllTypes(includeObsolete: true);
		foreach (Type type in allTypes)
		{
			if (type.GetCustomAttribute(typeof(DeserializeFromAttribute), inherit: false) is DeserializeFromAttribute deserializeFromAttribute && deserializeFromAttribute.previousTypeFullName == typeName)
			{
				return type;
			}
		}
		return null;
	}

	private static Type TryResolveWithoutNamespace(string typeName, Type fallbackAssignable = null)
	{
		if (typeName.Contains('`') && typeName.Contains('['))
		{
			return null;
		}
		if (typeName.Contains(','))
		{
			typeName = typeName.Substring(0, typeName.IndexOf(','));
		}
		if (typeName.Contains('.'))
		{
			int num = typeName.LastIndexOf('.') + 1;
			typeName = typeName.Substring(num, typeName.Length - num);
		}
		Type[] allTypes = GetAllTypes(includeObsolete: true);
		foreach (Type type in allTypes)
		{
			if (type.Name == typeName && (fallbackAssignable == null || fallbackAssignable.RTIsAssignableFrom(type)))
			{
				return type;
			}
		}
		return null;
	}

	public static Type[] GetAllTypes(bool includeObsolete)
	{
		if (_allTypes != null)
		{
			return _allTypes;
		}
		List<Type> list = new List<Type>();
		for (int i = 0; i < loadedAssemblies.Length; i++)
		{
			Assembly assembly = loadedAssemblies[i];
			try
			{
				list.AddRange(from t in assembly.GetExportedTypes()
					where includeObsolete || !t.RTIsDefined<ObsoleteAttribute>(inherited: false)
					select t);
			}
			catch
			{
			}
		}
		return _allTypes = (from t in list
			orderby t.Namespace, t.FriendlyName()
			select t).ToArray();
	}

	public static Type[] GetImplementationsOf(Type baseType)
	{
		Type[] value = null;
		if (_subTypesMap.TryGetValue(baseType, out value))
		{
			return value;
		}
		List<Type> list = new List<Type>();
		Type[] allTypes = GetAllTypes(includeObsolete: false);
		foreach (Type type in allTypes)
		{
			if (baseType.RTIsAssignableFrom(type) && !type.RTIsAbstract())
			{
				list.Add(type);
			}
		}
		return _subTypesMap[baseType] = list.ToArray();
	}

	public static object[] SingleTempArgsArray(object arg)
	{
		_tempArgs[0] = arg;
		return _tempArgs;
	}

	public static MethodType GetMethodSpecialType(this MethodBase method)
	{
		if (_methodSpecialType.TryGetValue(method, out var value))
		{
			return value;
		}
		string name = method.Name;
		if (method.IsSpecialName)
		{
			if (name.StartsWith("get_") || name.StartsWith("set_"))
			{
				return _methodSpecialType[method] = MethodType.PropertyAccessor;
			}
			if (name.StartsWith("add_") || name.StartsWith("remove_"))
			{
				return _methodSpecialType[method] = MethodType.Event;
			}
			if (name.StartsWith("op_"))
			{
				return _methodSpecialType[method] = MethodType.Operator;
			}
		}
		return _methodSpecialType[method] = MethodType.Normal;
	}

	public static string FriendlyName(this Type t, bool compileSafe = false)
	{
		if (t == null)
		{
			return null;
		}
		if (!compileSafe && t.IsByRef)
		{
			t = t.GetElementType();
		}
		if (!compileSafe && t == typeof(UnityEngine.Object))
		{
			return "UnityObject";
		}
		if (!compileSafe && _typeFriendlyName.TryGetValue(t, out var value))
		{
			return value;
		}
		if (compileSafe && _typeFriendlyNameCompileSafe.TryGetValue(t, out value))
		{
			return value;
		}
		value = (compileSafe ? t.FullName : t.Name);
		if (!compileSafe)
		{
			if (value == "Single")
			{
				value = "Float";
			}
			if (value == "Single[]")
			{
				value = "Float[]";
			}
			if (value == "Int32")
			{
				value = "Integer";
			}
			if (value == "Int32[]")
			{
				value = "Integer[]";
			}
		}
		if (t.RTIsGenericParameter())
		{
			value = "T";
		}
		if (t.RTIsGenericType())
		{
			value = ((compileSafe && !string.IsNullOrEmpty(t.Namespace)) ? (t.Namespace + "." + t.Name) : t.Name);
			Type[] array = t.RTGetGenericArguments();
			if (array.Length != 0)
			{
				value = value.Replace("`" + array.Length, "");
				value += (compileSafe ? "<" : " (");
				for (int i = 0; i < array.Length; i++)
				{
					value = value + ((i == 0) ? "" : ", ") + array[i].FriendlyName(compileSafe);
				}
				value += (compileSafe ? ">" : ")");
			}
		}
		if (compileSafe)
		{
			return _typeFriendlyNameCompileSafe[t] = value;
		}
		return _typeFriendlyName[t] = value;
	}

	public static string FriendlyName(this MemberInfo info)
	{
		if (info == null)
		{
			return null;
		}
		if (info is Type)
		{
			return ((Type)info).FriendlyName();
		}
		return info.ReflectedType.FriendlyName() + "." + info.Name;
	}

	public static string FriendlyName(this MethodBase method)
	{
		MethodType specialNameType = MethodType.Normal;
		return method.FriendlyName(out specialNameType);
	}

	public static string FriendlyName(this MethodBase method, out MethodType specialNameType)
	{
		specialNameType = MethodType.Normal;
		string value = method.Name;
		if (method.IsSpecialName)
		{
			if (value.StartsWith("get_"))
			{
				value = "Get " + value.Substring("get_".Length).CapitalizeFirst();
				specialNameType = MethodType.PropertyAccessor;
				return value;
			}
			if (value.StartsWith("set_"))
			{
				value = "Set " + value.Substring("set_".Length).CapitalizeFirst();
				specialNameType = MethodType.PropertyAccessor;
				return value;
			}
			if (value.StartsWith("add_"))
			{
				value = value.Substring("add_".Length) + " +=";
				specialNameType = MethodType.Event;
				return value;
			}
			if (value.StartsWith("remove_"))
			{
				value = value.Substring("remove_".Length) + " -=";
				specialNameType = MethodType.Event;
				return value;
			}
			if (value.StartsWith("op_"))
			{
				op_FriendlyNamesLong.TryGetValue(value, out value);
				specialNameType = MethodType.Operator;
				return value;
			}
		}
		return value;
	}

	public static string SignatureName(this MethodBase method)
	{
		string value = null;
		if (_methodSignatures.TryGetValue(method, out value))
		{
			return value;
		}
		MethodType specialNameType = MethodType.Normal;
		string arg = method.FriendlyName(out specialNameType);
		ParameterInfo[] parameters = method.GetParameters();
		value = ((!(method is ConstructorInfo)) ? string.Format("{0}{1} (", (method.IsStatic && specialNameType != MethodType.Operator) ? "static " : "", arg) : $"new {method.DeclaringType.FriendlyName()} (");
		for (int i = 0; i < parameters.Length; i++)
		{
			ParameterInfo parameterInfo = parameters[i];
			if (parameterInfo.IsParams(parameters))
			{
				value += "params ";
			}
			value = value + (parameterInfo.ParameterType.IsByRef ? (parameterInfo.IsOut ? "out " : "ref ") : "") + parameterInfo.ParameterType.FriendlyName() + ((i < parameters.Length - 1) ? ", " : "");
		}
		value = ((!(method is MethodInfo)) ? (value + ")") : (value + ") : " + (method as MethodInfo).ReturnType.FriendlyName()));
		return _methodSignatures[method] = value;
	}

	public static string FriendlyTypeName(string fullName)
	{
		if (fullName.Contains("`1"))
		{
			string stringWithinInner = fullName.GetStringWithinInner('[', ',');
			string stringWithinInner2 = fullName.GetStringWithinInner('.', '`');
			return $"{stringWithinInner2}({stringWithinInner})";
		}
		if (fullName.Contains('.'))
		{
			int num = fullName.LastIndexOf('.') + 1;
			return fullName.Substring(num, fullName.Length - num);
		}
		return fullName;
	}

	public static Type RTReflectedOrDeclaredType(this MemberInfo member)
	{
		if (!(member.ReflectedType != null))
		{
			return member.DeclaringType;
		}
		return member.ReflectedType;
	}

	public static bool RTIsAssignableFrom(this Type type, Type other)
	{
		return type.IsAssignableFrom(other);
	}

	public static bool RTIsAssignableTo(this Type type, Type other)
	{
		return other.RTIsAssignableFrom(type);
	}

	public static bool RTIsAbstract(this Type type)
	{
		return type.IsAbstract;
	}

	public static bool RTIsValueType(this Type type)
	{
		return type.IsValueType;
	}

	public static bool RTIsArray(this Type type)
	{
		return type.IsArray;
	}

	public static bool RTIsInterface(this Type type)
	{
		return type.IsInterface;
	}

	public static bool RTIsSubclassOf(this Type type, Type other)
	{
		return type.IsSubclassOf(other);
	}

	public static bool RTIsGenericParameter(this Type type)
	{
		return type.IsGenericParameter;
	}

	public static bool RTIsGenericType(this Type type)
	{
		return type.IsGenericType;
	}

	public static MethodInfo RTGetGetMethod(this PropertyInfo prop)
	{
		return prop.GetGetMethod();
	}

	public static MethodInfo RTGetSetMethod(this PropertyInfo prop)
	{
		return prop.GetSetMethod();
	}

	public static MethodInfo RTGetDelegateMethodInfo(this Delegate del)
	{
		return del.Method;
	}

	public static Type RTMakeGenericType(this Type type, params Type[] typeArgs)
	{
		return type.MakeGenericType(typeArgs);
	}

	public static Type[] RTGetGenericArguments(this Type type)
	{
		Type[] value = null;
		if (_genericArgsTypeCache.TryGetValue(type, out value))
		{
			return value;
		}
		return _genericArgsTypeCache[type] = (value = type.GetGenericArguments());
	}

	public static Type[] RTGetGenericArguments(this MethodInfo method)
	{
		Type[] value = null;
		if (_genericArgsMathodCache.TryGetValue(method, out value))
		{
			return value;
		}
		return _genericArgsMathodCache[method] = (value = method.GetGenericArguments());
	}

	public static Type[] RTGetEmptyTypes()
	{
		return Type.EmptyTypes;
	}

	public static Type RTGetElementType(this Type type)
	{
		if (type == null)
		{
			return null;
		}
		return type.GetElementType();
	}

	public static bool RTIsByRef(this Type type)
	{
		if (type == null)
		{
			return false;
		}
		return type.IsByRef;
	}

	public static object CreateObject(this Type type)
	{
		if (type == null)
		{
			return null;
		}
		return Activator.CreateInstance(type);
	}

	public static object CreateObjectUninitialized(this Type type)
	{
		if (type == null)
		{
			return null;
		}
		return FormatterServices.GetUninitializedObject(type);
	}

	public static ConstructorInfo RTGetDefaultConstructor(this Type type)
	{
		ConstructorInfo[] array = type.RTGetConstructors();
		for (int i = 0; i < array.Length; i++)
		{
			if (array[i].GetParameters().Length == 0)
			{
				return array[i];
			}
		}
		return null;
	}

	public static ConstructorInfo RTGetConstructor(this Type type, Type[] paramTypes)
	{
		ConstructorInfo[] array = type.RTGetConstructors();
		foreach (ConstructorInfo constructorInfo in array)
		{
			ParameterInfo[] parameters = constructorInfo.GetParameters();
			if (parameters.Length != paramTypes.Length)
			{
				continue;
			}
			bool flag = true;
			for (int j = 0; j < parameters.Length; j++)
			{
				if (parameters[j].ParameterType != paramTypes[j])
				{
					flag = false;
					break;
				}
			}
			if (flag)
			{
				return constructorInfo;
			}
		}
		return null;
	}

	private static bool MemberResolvedFromDeserializeAttribute(MemberInfo member, string targetName)
	{
		DeserializeFromAttribute deserializeFromAttribute = member.RTGetAttribute<DeserializeFromAttribute>(inherited: true);
		if (deserializeFromAttribute != null)
		{
			return deserializeFromAttribute.previousTypeFullName == targetName;
		}
		return false;
	}

	public static MethodInfo RTGetMethod(this Type type, string name)
	{
		MethodInfo[] array = type.RTGetMethods();
		foreach (MethodInfo methodInfo in array)
		{
			if (methodInfo.Name == name || MemberResolvedFromDeserializeAttribute(methodInfo, name))
			{
				return methodInfo;
			}
		}
		return null;
	}

	public static MethodInfo RTGetMethod(this Type type, string name, Type[] paramTypes, Type returnType = null, Type[] genericArgumentTypes = null)
	{
		MethodInfo[] array = type.RTGetMethods();
		for (int i = 0; i < array.Length; i++)
		{
			MethodInfo methodInfo = array[i];
			if ((!(methodInfo.Name == name) && !MemberResolvedFromDeserializeAttribute(methodInfo, name)) || (genericArgumentTypes != null && !methodInfo.IsGenericMethod))
			{
				continue;
			}
			ParameterInfo[] parameters = methodInfo.GetParameters();
			if (parameters.Length != paramTypes.Length)
			{
				continue;
			}
			if (genericArgumentTypes != null)
			{
				methodInfo = methodInfo.MakeGenericMethod(genericArgumentTypes);
				parameters = methodInfo.GetParameters();
			}
			if (returnType != null && methodInfo.ReturnType != returnType)
			{
				continue;
			}
			bool flag = true;
			for (int j = 0; j < parameters.Length; j++)
			{
				if (parameters[j].ParameterType != paramTypes[j])
				{
					flag = false;
					break;
				}
			}
			if (flag)
			{
				return methodInfo;
			}
		}
		return null;
	}

	public static FieldInfo RTGetField(this Type type, string name, bool includePrivateBase = false)
	{
		Type type2 = type;
		while (type2 != null)
		{
			FieldInfo[] array = type2.RTGetFields();
			foreach (FieldInfo fieldInfo in array)
			{
				if (fieldInfo.Name == name || MemberResolvedFromDeserializeAttribute(fieldInfo, name))
				{
					return fieldInfo;
				}
			}
			if (!includePrivateBase)
			{
				break;
			}
			type2 = type2.BaseType;
		}
		return null;
	}

	public static PropertyInfo RTGetProperty(this Type type, string name)
	{
		PropertyInfo[] array = type.RTGetProperties();
		foreach (PropertyInfo propertyInfo in array)
		{
			if (propertyInfo.Name == name || MemberResolvedFromDeserializeAttribute(propertyInfo, name))
			{
				return propertyInfo;
			}
		}
		return null;
	}

	public static MemberInfo RTGetFieldOrProp(this Type type, string name)
	{
		FieldInfo[] array = type.RTGetFields();
		foreach (FieldInfo fieldInfo in array)
		{
			if (fieldInfo.Name == name || MemberResolvedFromDeserializeAttribute(fieldInfo, name))
			{
				return fieldInfo;
			}
		}
		PropertyInfo[] array2 = type.RTGetProperties();
		foreach (PropertyInfo propertyInfo in array2)
		{
			if (propertyInfo.Name == name || MemberResolvedFromDeserializeAttribute(propertyInfo, name))
			{
				return propertyInfo;
			}
		}
		return null;
	}

	public static EventInfo RTGetEvent(this Type type, string name)
	{
		EventInfo[] array = type.RTGetEvents();
		foreach (EventInfo eventInfo in array)
		{
			if (eventInfo.Name == name || MemberResolvedFromDeserializeAttribute(eventInfo, name))
			{
				return eventInfo;
			}
		}
		return null;
	}

	public static object RTGetFieldOrPropValue(this MemberInfo member, object instance, int index = -1)
	{
		if (member is FieldInfo)
		{
			return (member as FieldInfo).GetValue(instance);
		}
		if (member is PropertyInfo)
		{
			return (member as PropertyInfo).GetValue(instance, (index == -1) ? null : SingleTempArgsArray(index));
		}
		return null;
	}

	public static void RTSetFieldOrPropValue(this MemberInfo member, object instance, object value, int index = -1)
	{
		if (member is FieldInfo)
		{
			(member as FieldInfo).SetValue(instance, value);
		}
		if (member is PropertyInfo)
		{
			(member as PropertyInfo).SetValue(instance, value, (index == -1) ? null : SingleTempArgsArray(index));
		}
	}

	public static ConstructorInfo[] RTGetConstructors(this Type type)
	{
		if (!_typeConstructors.TryGetValue(type, out var value))
		{
			value = type.GetConstructors(BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.FlattenHierarchy);
			_typeConstructors[type] = value;
		}
		return value;
	}

	public static MethodInfo[] RTGetMethods(this Type type)
	{
		if (!_typeMethods.TryGetValue(type, out var value))
		{
			value = type.GetMethods(BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.FlattenHierarchy);
			_typeMethods[type] = value;
		}
		return value;
	}

	public static FieldInfo[] RTGetFields(this Type type)
	{
		if (!_typeFields.TryGetValue(type, out var value))
		{
			value = type.GetFields(BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.FlattenHierarchy);
			_typeFields[type] = value;
		}
		return value;
	}

	public static PropertyInfo[] RTGetProperties(this Type type)
	{
		if (!_typeProperties.TryGetValue(type, out var value))
		{
			value = type.GetProperties(BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.FlattenHierarchy);
			_typeProperties[type] = value;
		}
		return value;
	}

	public static EventInfo[] RTGetEvents(this Type type)
	{
		if (!_typeEvents.TryGetValue(type, out var value))
		{
			value = type.GetEvents(BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.FlattenHierarchy);
			_typeEvents[type] = value;
		}
		return value;
	}

	public static object[] RTGetAllAttributes(this Type type)
	{
		if (!_typeAttributes.TryGetValue(type, out var value))
		{
			try
			{
				value = type.GetCustomAttributes(inherit: true);
				return value;
			}
			catch
			{
			}
			finally
			{
				_typeAttributes[type] = value;
			}
		}
		return value;
	}

	public static bool RTIsDefined<T>(this Type type, bool inherited) where T : Attribute
	{
		return type.RTIsDefined(typeof(T), inherited);
	}

	public static bool RTIsDefined(this Type type, Type attributeType, bool inherited)
	{
		if (!inherited)
		{
			return type.IsDefined(attributeType, inherit: false);
		}
		return type.RTGetAttribute(attributeType, inherited) != null;
	}

	public static T RTGetAttribute<T>(this Type type, bool inherited) where T : Attribute
	{
		return (T)type.RTGetAttribute(typeof(T), inherited);
	}

	public static Attribute RTGetAttribute(this Type type, Type attributeType, bool inherited)
	{
		object[] array = type.RTGetAllAttributes();
		if (array != null)
		{
			for (int i = 0; i < array.Length; i++)
			{
				Attribute attribute = (Attribute)array[i];
				Type type2 = attribute.GetType();
				if (type2.RTIsAssignableTo(attributeType) && (inherited || type.IsDefined(type2, inherit: false)))
				{
					return attribute;
				}
			}
		}
		return null;
	}

	public static object[] RTGetAllAttributes(this MemberInfo member)
	{
		if (!_memberAttributes.TryGetValue(member, out var value))
		{
			value = member.GetCustomAttributes(inherit: true);
			_memberAttributes[member] = value;
		}
		return value;
	}

	public static bool RTIsDefined<T>(this MemberInfo member, bool inherited) where T : Attribute
	{
		return member.RTIsDefined(typeof(T), inherited);
	}

	public static bool RTIsDefined(this MemberInfo member, Type attributeType, bool inherited)
	{
		if (!inherited)
		{
			return member.IsDefined(attributeType, inherit: false);
		}
		return member.RTGetAttribute(attributeType, inherited) != null;
	}

	public static T RTGetAttribute<T>(this MemberInfo member, bool inherited) where T : Attribute
	{
		return (T)member.RTGetAttribute(typeof(T), inherited);
	}

	public static Attribute RTGetAttribute(this MemberInfo member, Type attributeType, bool inherited)
	{
		object[] array = member.RTGetAllAttributes();
		for (int i = 0; i < array.Length; i++)
		{
			Attribute attribute = (Attribute)array[i];
			Type type = attribute.GetType();
			if (type.RTIsAssignableTo(attributeType) && (inherited || member.IsDefined(type, inherit: false)))
			{
				return attribute;
			}
		}
		return null;
	}

	public static IEnumerable<T> RTGetAttributesRecursive<T>(this Type type) where T : Attribute
	{
		Type current = type;
		while (current != null)
		{
			T val = current.RTGetAttribute<T>(inherited: false);
			if (val != null)
			{
				yield return val;
			}
			current = current.BaseType;
		}
	}

	public static ParameterInfo[] RTGetDelegateTypeParameters(this Type delegateType)
	{
		if (delegateType == null || !delegateType.RTIsSubclassOf(typeof(Delegate)))
		{
			return new ParameterInfo[0];
		}
		return delegateType.RTGetMethod("Invoke").GetParameters();
	}

	public static T RTCreateDelegate<T>(this MethodInfo method, object instance) where T : Delegate
	{
		return (T)method.RTCreateDelegate(typeof(T), instance);
	}

	public static Delegate RTCreateDelegate(this MethodInfo method, Type type, object instance)
	{
		if (instance != null)
		{
			Type type2 = instance.GetType();
			if (method.DeclaringType != type2)
			{
				method = type2.RTGetMethod(method.Name, (from p in method.GetParameters()
					select p.ParameterType).ToArray());
			}
		}
		return Delegate.CreateDelegate(type, instance, method);
	}

	public static Delegate ConvertDelegate(Delegate originalDelegate, Type targetDelegateType)
	{
		return Delegate.CreateDelegate(targetDelegateType, originalDelegate.Target, originalDelegate.Method);
	}

	public static bool IsReadOnly(this FieldInfo field)
	{
		if (!field.IsInitOnly)
		{
			return field.IsLiteral;
		}
		return true;
	}

	public static bool IsConstant(this FieldInfo field)
	{
		if (field.IsReadOnly())
		{
			return field.IsStatic;
		}
		return false;
	}

	public static bool IsStatic(this EventInfo info)
	{
		MethodInfo addMethod = info.GetAddMethod();
		if (!(addMethod != null))
		{
			return false;
		}
		return addMethod.IsStatic;
	}

	public static bool IsStatic(this PropertyInfo info)
	{
		MethodInfo getMethod = info.GetGetMethod();
		if (!(getMethod != null))
		{
			return false;
		}
		return getMethod.IsStatic;
	}

	public static bool IsParams(this ParameterInfo parameter, ParameterInfo[] parameters)
	{
		if (parameter.Position == parameters.Length - 1)
		{
			return parameter.IsDefined(typeof(ParamArrayAttribute), inherit: false);
		}
		return false;
	}

	public static bool IsObsolete(this MemberInfo member, bool inherited = true)
	{
		if (_obsoleteCache.TryGetValue(member, out var value))
		{
			return value;
		}
		MemberInfo member2 = member;
		if (member is MethodInfo)
		{
			MethodInfo method = (MethodInfo)member;
			if (method.IsPropertyAccessor())
			{
				member2 = method.GetAccessorProperty();
			}
		}
		bool flag = member2.RTIsDefined<ObsoleteAttribute>(inherited);
		return _obsoleteCache[member] = flag;
	}

	public static PropertyInfo GetBaseDefinition(this PropertyInfo propertyInfo)
	{
		MethodInfo methodInfo = propertyInfo.GetAccessors(nonPublic: true).FirstOrDefault();
		if (methodInfo == null)
		{
			return null;
		}
		MethodInfo baseDefinition = methodInfo.GetBaseDefinition();
		if (baseDefinition == methodInfo)
		{
			return propertyInfo;
		}
		Type[] types = (from p in propertyInfo.GetIndexParameters()
			select p.ParameterType).ToArray();
		return baseDefinition.DeclaringType.GetProperty(propertyInfo.Name, BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.FlattenHierarchy, null, propertyInfo.PropertyType, types, null);
	}

	public static FieldInfo GetBaseDefinition(this FieldInfo fieldInfo)
	{
		return fieldInfo.DeclaringType.RTGetField(fieldInfo.Name);
	}

	public static MethodInfo[] GetExtensionMethods(this Type targetType)
	{
		MethodInfo[] value = null;
		if (_typeExtensions.TryGetValue(targetType, out value))
		{
			return value;
		}
		List<MethodInfo> list = new List<MethodInfo>();
		Type[] allTypes = GetAllTypes(includeObsolete: false);
		foreach (Type type in allTypes)
		{
			if (!type.IsSealed || type.IsGenericType || !type.RTIsDefined<ExtensionAttribute>(inherited: true))
			{
				continue;
			}
			MethodInfo[] array = type.RTGetMethods();
			foreach (MethodInfo methodInfo in array)
			{
				if (methodInfo.IsExtensionMethod() && methodInfo.GetParameters()[0].ParameterType.RTIsAssignableFrom(targetType))
				{
					list.Add(methodInfo);
				}
			}
		}
		return _typeExtensions[targetType] = list.ToArray();
	}

	public static bool IsExtensionMethod(this MethodInfo method)
	{
		return method.RTIsDefined<ExtensionAttribute>(inherited: true);
	}

	public static bool IsPropertyAccessor(this MethodInfo method)
	{
		return method.GetMethodSpecialType() == MethodType.PropertyAccessor;
	}

	public static bool IsIndexerProperty(this PropertyInfo property)
	{
		return property.GetIndexParameters().Length != 0;
	}

	public static bool IsAutoProperty(this PropertyInfo property)
	{
		if (!property.CanRead || !property.CanWrite)
		{
			return false;
		}
		string name = "<" + property.Name + ">k__BackingField";
		return property.DeclaringType.RTGetField(name) != null;
	}

	public static PropertyInfo GetAccessorProperty(this MethodInfo method)
	{
		if (method.IsPropertyAccessor())
		{
			return method.RTReflectedOrDeclaredType().RTGetProperty(method.Name.Substring(4));
		}
		return null;
	}

	public static bool IsEnumerableCollection(this Type type)
	{
		if (type == null)
		{
			return false;
		}
		if (typeof(IEnumerable).RTIsAssignableFrom(type))
		{
			if (!type.RTIsGenericType())
			{
				return type.RTIsArray();
			}
			return true;
		}
		return false;
	}

	public static Type GetEnumerableElementType(this Type type)
	{
		if (type == null)
		{
			return null;
		}
		if (!typeof(IEnumerable).RTIsAssignableFrom(type))
		{
			return null;
		}
		if (type.HasElementType || type.RTIsArray())
		{
			return type.GetElementType();
		}
		if (type.RTIsGenericType())
		{
			Type[] array = type.RTGetGenericArguments();
			if (array.Length == 1)
			{
				return array[0];
			}
			if (typeof(IDictionary).RTIsAssignableFrom(type) && array.Length == 2)
			{
				return array[1];
			}
		}
		return null;
	}

	public static Type GetSingleGenericArgument(this Type type)
	{
		if (type.RTIsGenericType())
		{
			Type[] array = type.RTGetGenericArguments();
			if (array.Length != 1)
			{
				return null;
			}
			return array[0];
		}
		return null;
	}

	public static Type GetFirstGenericParameterConstraintType(this Type type)
	{
		if (type == null || !type.RTIsGenericType())
		{
			return null;
		}
		type = type.GetGenericTypeDefinition();
		Type type2 = type.RTGetGenericArguments().First().GetGenericParameterConstraints()
			.FirstOrDefault();
		if (!(type2 != null))
		{
			return typeof(object);
		}
		return type2;
	}

	public static Type GetFirstGenericParameterConstraintType(this MethodInfo method)
	{
		if (method == null || !method.IsGenericMethod)
		{
			return null;
		}
		method = method.GetGenericMethodDefinition();
		Type type = method.RTGetGenericArguments().First().GetGenericParameterConstraints()
			.FirstOrDefault();
		if (!(type != null))
		{
			return typeof(object);
		}
		return type;
	}

	public static bool TryMakeGeneric(this Type def, Type argType, out Type result)
	{
		result = null;
		if (def == null || argType == null || !def.IsGenericType)
		{
			return false;
		}
		try
		{
			result = def.GetGenericTypeDefinition().MakeGenericType(argType);
			return true;
		}
		catch
		{
			return false;
		}
	}

	public static bool TryMakeGeneric(this MethodInfo def, Type argType, out MethodInfo result)
	{
		result = null;
		if (def == null || argType == null || !def.IsGenericMethod)
		{
			return false;
		}
		try
		{
			result = def.GetGenericMethodDefinition().MakeGenericMethod(argType);
			return true;
		}
		catch
		{
			return false;
		}
	}

	public static Array Resize(this Array array, int newSize)
	{
		if (array == null)
		{
			return null;
		}
		int length = array.Length;
		Array array2 = Array.CreateInstance(array.GetType().GetElementType(), newSize);
		int num = Math.Min(length, newSize);
		if (num > 0)
		{
			Array.Copy(array, array2, num);
		}
		return array2;
	}

	public static bool TryConvert(Type fromType, Type toType, out UnaryExpression exp)
	{
		try
		{
			exp = Expression.Convert(Expression.Parameter(fromType, null), toType);
			return true;
		}
		catch
		{
			exp = null;
			return false;
		}
	}

	public static void DigFields(object root, Predicate<FieldInfo> move, Action<object> push, Action<object> pop)
	{
		if (root == null)
		{
			return;
		}
		Type type = root.GetType();
		if (type.IsPrimitive || type == typeof(string))
		{
			return;
		}
		push?.Invoke(root);
		FieldInfo[] array = type.RTGetFields();
		foreach (FieldInfo fieldInfo in array)
		{
			if (fieldInfo.IsStatic || fieldInfo.FieldType.IsPrimitive || !(fieldInfo.FieldType != typeof(string)) || !move(fieldInfo))
			{
				continue;
			}
			object value = fieldInfo.GetValue(root);
			if (value == null)
			{
				continue;
			}
			if (value is IList)
			{
				foreach (object item in (IList)value)
				{
					DigFields(item, move, push, pop);
				}
			}
			else if (value is IDictionary)
			{
				foreach (object value2 in ((IDictionary)value).Values)
				{
					DigFields(value2, move, push, pop);
				}
			}
			else
			{
				DigFields(value, move, push, pop);
			}
		}
		pop?.Invoke(root);
	}

	public static Func<T, TResult> GetFieldGetter<T, TResult>(FieldInfo info)
	{
		return (T instance) => (TResult)info.GetValue(instance);
	}

	public static Action<T, TValue> GetFieldSetter<T, TValue>(FieldInfo info)
	{
		return delegate(T instance, TValue value)
		{
			info.SetValue(instance, value);
		};
	}
}
