using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.Serialization;
using ParadoxNotion.Serialization;
using ParadoxNotion.Services;
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

	private const BindingFlags flagsEverything = BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.FlattenHierarchy;

	private static Assembly[] _loadedAssemblies;

	private static Dictionary<string, Type> typeMap = new Dictionary<string, Type>();

	private static Type[] _allTypes;

	private static Dictionary<Type, Type[]> _subTypesMap = new Dictionary<Type, Type[]>();

	public static readonly Dictionary<string, string> op_FriendlyNamesLong = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase)
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

	public static readonly Dictionary<string, string> op_FriendlyNamesShort = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase)
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

	public static readonly Dictionary<string, string> op_CSharpAliases = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase)
	{
		{ "!=", "≠" },
		{ ">=", "≥" },
		{ "<=", "≤" },
		{ "/", "÷" },
		{ "*", "×" }
	};

	public const string METHOD_SPECIAL_NAME_GET = "get_";

	public const string METHOD_SPECIAL_NAME_SET = "set_";

	public const string METHOD_SPECIAL_NAME_ADD = "add_";

	public const string METHOD_SPECIAL_NAME_REMOVE = "remove_";

	public const string METHOD_SPECIAL_NAME_OP = "op_";

	private static Dictionary<MethodBase, string> cacheSignatures = new Dictionary<MethodBase, string>();

	private static Dictionary<Type, FieldInfo[]> _typeFields = new Dictionary<Type, FieldInfo[]>();

	private static Dictionary<Type, PropertyInfo[]> _typeProperties = new Dictionary<Type, PropertyInfo[]>();

	private static Dictionary<Type, MethodInfo[]> _typeMethods = new Dictionary<Type, MethodInfo[]>();

	private static Dictionary<Type, ConstructorInfo[]> _typeConstructors = new Dictionary<Type, ConstructorInfo[]>();

	private static Dictionary<Type, EventInfo[]> _typeEvents = new Dictionary<Type, EventInfo[]>();

	private static Dictionary<Type, MethodInfo[]> _typeExtensions = new Dictionary<Type, MethodInfo[]>();

	private static Assembly[] loadedAssemblies
	{
		get
		{
			if (_loadedAssemblies == null)
			{
				_loadedAssemblies = AppDomain.CurrentDomain.GetAssemblies();
			}
			return _loadedAssemblies;
		}
	}

	public static Type GetType(string typeFullName, bool fallbackNoNamespace = false, Type fallbackAssignable = null)
	{
		if (string.IsNullOrEmpty(typeFullName))
		{
			return null;
		}
		Type value = null;
		if (typeMap.TryGetValue(typeFullName, out value))
		{
			return value;
		}
		value = GetTypeDirect(typeFullName);
		if (value != null)
		{
			return typeMap[typeFullName] = value;
		}
		value = TryResolveGenericType(typeFullName, fallbackNoNamespace, fallbackAssignable);
		if (value != null)
		{
			return typeMap[typeFullName] = value;
		}
		value = TryResolveDeserializeFromAttribute(typeFullName);
		if (value != null)
		{
			return typeMap[typeFullName] = value;
		}
		if (fallbackNoNamespace)
		{
			value = TryResolveWithoutNamespace(typeFullName, fallbackAssignable);
			if (value != null)
			{
				return typeMap[value.FullName] = value;
			}
		}
		ParadoxNotion.Services.Logger.LogError($"Type with name '{typeFullName}' could not be resolved.", "Type Request");
		return typeMap[typeFullName] = null;
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
				array = typeFullName.Substring(num3, num4 - num3).Split(new string[1] { "],[" }, num2, StringSplitOptions.RemoveEmptyEntries).ToArray();
			}
			else
			{
				int num5 = typeFullName.IndexOf('[') + 1;
				int num6 = typeFullName.LastIndexOf(']');
				array = typeFullName.Substring(num5, num6 - num5).Split(new char[1] { ',' }, num2, StringSplitOptions.RemoveEmptyEntries).ToArray();
			}
			Type[] array2 = new Type[num2];
			for (int i = 0; i < array.Length; i++)
			{
				string text2 = array[i];
				if (!text2.Contains('`') && text2.Contains(','))
				{
					text2 = text2.Substring(0, text2.IndexOf(','));
				}
				Type fallbackAssignable2 = null;
				if (fallbackNoNamespace)
				{
					Type[] genericParameterConstraints = type.RTGetGenericArguments()[i].GetGenericParameterConstraints();
					fallbackAssignable2 = ((genericParameterConstraints.Length == 0) ? typeof(object) : genericParameterConstraints[0]);
				}
				Type type2 = GetType(text2, fallbackNoNamespace, fallbackAssignable2);
				if (type2 == null)
				{
					return null;
				}
				array2[i] = type2;
			}
			return type.RTMakeGenericType(array2);
		}
		catch (Exception exception)
		{
			ParadoxNotion.Services.Logger.LogException(exception, "Type Request Bug");
			return null;
		}
	}

	private static Type TryResolveDeserializeFromAttribute(string typeName)
	{
		Type[] allTypes = GetAllTypes(includeObsolete: true);
		foreach (Type type in allTypes)
		{
			DeserializeFromAttribute deserializeFromAttribute = type.RTGetAttribute<DeserializeFromAttribute>(inherited: false);
			if (deserializeFromAttribute != null && deserializeFromAttribute.previousTypeNames.Any((string n) => n == typeName))
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
			Assembly asm = loadedAssemblies[i];
			try
			{
				list.AddRange(from t in asm.RTGetExportedTypes()
					where includeObsolete || !t.RTIsDefined<ObsoleteAttribute>(inherited: true)
					select t);
			}
			catch
			{
			}
		}
		return _allTypes = (from t in list
			orderby t.FriendlyName()
			orderby t.Namespace
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

	private static Type[] RTGetExportedTypes(this Assembly asm)
	{
		return asm.GetExportedTypes();
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
		string text = (compileSafe ? t.FullName : t.Name);
		if (!compileSafe)
		{
			if (text == "Single")
			{
				text = "Float";
			}
			if (text == "Single[]")
			{
				text = "Float[]";
			}
			if (text == "Int32")
			{
				text = "Integer";
			}
			if (text == "Int32[]")
			{
				text = "Integer[]";
			}
		}
		if (t.RTIsGenericParameter())
		{
			text = "T";
		}
		if (t.RTIsGenericType())
		{
			text = (compileSafe ? (t.Namespace + "." + t.Name) : t.Name);
			Type[] array = t.RTGetGenericArguments();
			if (array.Length != 0)
			{
				text = text.Replace("`" + array.Length, "");
				text += (compileSafe ? "<" : " (");
				for (int i = 0; i < array.Length; i++)
				{
					text = text + ((i == 0) ? "" : ", ") + array[i].FriendlyName(compileSafe);
				}
				text += (compileSafe ? ">" : ")");
			}
		}
		return text;
	}

	public static MethodType GetMethodSpecialType(this MethodBase method)
	{
		string name = method.Name;
		if (method.IsSpecialName)
		{
			if (name.StartsWith("get_") || name.StartsWith("set_"))
			{
				return MethodType.PropertyAccessor;
			}
			if (name.StartsWith("add_") || name.StartsWith("remove_"))
			{
				return MethodType.Event;
			}
			if (name.StartsWith("op_"))
			{
				return MethodType.Operator;
			}
		}
		return MethodType.Normal;
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
		if (cacheSignatures.TryGetValue(method, out value))
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
		return cacheSignatures[method] = value;
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

	public static Type RTReflectedType(this MemberInfo member)
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

	public static FieldInfo RTGetField(this Type type, string name)
	{
		return type.GetField(name, BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.FlattenHierarchy);
	}

	public static PropertyInfo RTGetProperty(this Type type, string name)
	{
		try
		{
			return type.GetProperty(name, BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.FlattenHierarchy);
		}
		catch (AmbiguousMatchException)
		{
			return type.RTGetProperties().FirstOrDefault((PropertyInfo p) => p.Name == name);
		}
	}

	public static ConstructorInfo RTGetConstructor(this Type type)
	{
		return type.GetConstructors(BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.FlattenHierarchy).FirstOrDefault((ConstructorInfo info) => info.GetParameters().Length == 0);
	}

	public static ConstructorInfo RTGetConstructor(this Type type, Type[] paramTypes)
	{
		return type.GetConstructor(BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.FlattenHierarchy, null, paramTypes, null);
	}

	public static MethodInfo RTGetMethod(this Type type, string name)
	{
		return type.GetMethod(name, BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.FlattenHierarchy);
	}

	public static MethodInfo RTGetMethod(this Type type, string name, Type[] paramTypes)
	{
		return type.GetMethod(name, paramTypes);
	}

	public static EventInfo RTGetEvent(this Type type, string name)
	{
		return type.GetEvent(name, BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.FlattenHierarchy);
	}

	public static MethodInfo RTGetDelegateMethodInfo(this Delegate del)
	{
		return del.Method;
	}

	public static ParameterInfo[] RTGetDelegateTypeParameters(this Type delegateType)
	{
		if (delegateType == null || !delegateType.RTIsSubclassOf(typeof(Delegate)))
		{
			return new ParameterInfo[0];
		}
		return delegateType.RTGetMethod("Invoke").GetParameters();
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

	public static MethodInfo[] RTGetMethods(this Type type)
	{
		if (!_typeMethods.TryGetValue(type, out var value))
		{
			value = type.GetMethods(BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.FlattenHierarchy);
			_typeMethods[type] = value;
		}
		return value;
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

	public static EventInfo[] RTGetEvents(this Type type)
	{
		if (!_typeEvents.TryGetValue(type, out var value))
		{
			value = type.GetEvents(BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.FlattenHierarchy);
			_typeEvents[type] = value;
		}
		return value;
	}

	public static bool RTIsDefined<T>(this Type type, bool inherited) where T : Attribute
	{
		return type.IsDefined(typeof(T), inherited);
	}

	public static bool RTIsDefined<T>(this MemberInfo member, bool inherited) where T : Attribute
	{
		return member.IsDefined(typeof(T), inherited);
	}

	public static T RTGetAttribute<T>(this Type type, bool inherited) where T : Attribute
	{
		return (T)type.GetCustomAttributes(typeof(T), inherited).FirstOrDefault();
	}

	public static T RTGetAttribute<T>(this MemberInfo member, bool inherited) where T : Attribute
	{
		return (T)member.GetCustomAttributes(typeof(T), inherited).FirstOrDefault();
	}

	public static T[] RTGetAttributesRecursive<T>(this Type type) where T : Attribute
	{
		List<T> list = new List<T>();
		Type type2 = type;
		while (type2 != null)
		{
			T val = type2.RTGetAttribute<T>(inherited: false);
			if (val != null)
			{
				list.Add(val);
			}
			type2 = type2.BaseType;
		}
		return list.ToArray();
	}

	public static Type RTMakeGenericType(this Type type, params Type[] typeArgs)
	{
		return type.MakeGenericType(typeArgs);
	}

	public static Type[] RTGetGenericArguments(this Type type)
	{
		return type.GetGenericArguments();
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

	public static T RTCreateDelegate<T>(this MethodInfo method, object instance)
	{
		return (T)(object)method.RTCreateDelegate(typeof(T), instance);
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

	public static bool IsObsolete(this MemberInfo member, bool inherited = true)
	{
		if (member is MethodInfo)
		{
			MethodInfo method = (MethodInfo)member;
			if (method.IsPropertyAccessor())
			{
				member = method.GetAccessorProperty();
			}
		}
		return member.RTIsDefined<ObsoleteAttribute>(inherited);
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

	public static bool IsParams(this ParameterInfo parameter, ParameterInfo[] parameters)
	{
		if (parameter.Position == parameters.Length - 1)
		{
			return parameter.IsDefined(typeof(ParamArrayAttribute), inherit: false);
		}
		return false;
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
			if (!type.IsSealed || type.IsGenericType || !type.RTIsDefined<ExtensionAttribute>(inherited: false))
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
		return method.RTIsDefined<ExtensionAttribute>(inherited: false);
	}

	public static bool IsPropertyAccessor(this MethodInfo method)
	{
		return method.GetMethodSpecialType() == MethodType.PropertyAccessor;
	}

	public static bool IsIndexerProperty(this PropertyInfo property)
	{
		return property.GetIndexParameters().Length != 0;
	}

	public static PropertyInfo GetAccessorProperty(this MethodInfo method)
	{
		if (method.IsPropertyAccessor())
		{
			return method.RTReflectedType().RTGetProperty(method.Name.Substring(4));
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
		if (type.RTIsArray())
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
			if (array.Length == 2)
			{
				return array[1];
			}
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
		Type type2 = type.GetGenericArguments().First().GetGenericParameterConstraints()
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
		Type type = method.GetGenericArguments().First().GetGenericParameterConstraints()
			.FirstOrDefault();
		if (!(type != null))
		{
			return typeof(object);
		}
		return type;
	}

	public static bool CanBeMadeGenericWith(this MethodInfo def, Type type)
	{
		if (def == null || !def.IsGenericMethod)
		{
			return false;
		}
		return type.IsAllowedByGenericArgument(def.GetGenericMethodDefinition().GetGenericArguments().FirstOrDefault());
	}

	public static bool CanBeMadeGenericWith(this Type def, Type type)
	{
		if (def == null || !def.RTIsGenericType())
		{
			return false;
		}
		return type.IsAllowedByGenericArgument(def.GetGenericTypeDefinition().GetGenericArguments().FirstOrDefault());
	}

	public static bool IsAllowedByGenericArgument(this Type type, Type genericArgument)
	{
		if (type == null || genericArgument == null)
		{
			return false;
		}
		Type[] genericParameterConstraints = genericArgument.GetGenericParameterConstraints();
		GenericParameterAttributes genericParameterAttributes = genericArgument.GenericParameterAttributes;
		bool flag = true;
		foreach (Type type2 in genericParameterConstraints)
		{
			if (!(type2 == typeof(ValueType)))
			{
				if (!flag)
				{
					break;
				}
				flag &= type2.RTIsAssignableFrom(type);
			}
		}
		if (flag && (genericParameterAttributes & GenericParameterAttributes.DefaultConstructorConstraint) == GenericParameterAttributes.DefaultConstructorConstraint && (genericParameterAttributes & GenericParameterAttributes.NotNullableValueTypeConstraint) != GenericParameterAttributes.NotNullableValueTypeConstraint && type.RTGetConstructors().FirstOrDefault((ConstructorInfo info) => info.IsPublic && info.GetParameters().Length == 0) == null)
		{
			flag = false;
		}
		if (flag && (genericParameterAttributes & GenericParameterAttributes.ReferenceTypeConstraint) == GenericParameterAttributes.ReferenceTypeConstraint && type.RTIsValueType())
		{
			flag = false;
		}
		if (flag && (genericParameterAttributes & GenericParameterAttributes.NotNullableValueTypeConstraint) == GenericParameterAttributes.NotNullableValueTypeConstraint && !type.RTIsValueType())
		{
			flag = false;
		}
		return flag;
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

	public static bool CanConvert(Type fromType, Type toType, out UnaryExpression exp)
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
}
