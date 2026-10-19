using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Runtime.CompilerServices;

namespace Unity.VisualScripting;

public static class MemberUtility
{
	private static readonly Lazy<ExtensionMethodCache> ExtensionMethodsCache;

	private static readonly Lazy<Dictionary<Type, MethodInfo[]>> InheritedExtensionMethodsCache;

	private static readonly Lazy<HashSet<MethodInfo>> GenericExtensionMethods;

	static MemberUtility()
	{
		ExtensionMethodsCache = new Lazy<ExtensionMethodCache>(() => new ExtensionMethodCache(), isThreadSafe: true);
		InheritedExtensionMethodsCache = new Lazy<Dictionary<Type, MethodInfo[]>>(() => new Dictionary<Type, MethodInfo[]>(), isThreadSafe: true);
		GenericExtensionMethods = new Lazy<HashSet<MethodInfo>>(() => new HashSet<MethodInfo>(), isThreadSafe: true);
	}

	public static bool IsOperator(this MethodInfo method)
	{
		if (method.IsSpecialName)
		{
			return OperatorUtility.operatorNames.ContainsKey(method.Name);
		}
		return false;
	}

	public static bool IsUserDefinedConversion(this MethodInfo method)
	{
		if (method.IsSpecialName)
		{
			if (!(method.Name == "op_Implicit"))
			{
				return method.Name == "op_Explicit";
			}
			return true;
		}
		return false;
	}

	public static MethodInfo MakeGenericMethodVia(this MethodInfo openConstructedMethod, params Type[] closedConstructedParameterTypes)
	{
		Ensure.That("openConstructedMethod").IsNotNull(openConstructedMethod);
		Ensure.That("closedConstructedParameterTypes").IsNotNull(closedConstructedParameterTypes);
		if (!openConstructedMethod.ContainsGenericParameters)
		{
			return openConstructedMethod;
		}
		Type[] array = (from p in openConstructedMethod.GetParameters()
			select p.ParameterType).ToArray();
		if (array.Length != closedConstructedParameterTypes.Length)
		{
			throw new ArgumentOutOfRangeException("closedConstructedParameterTypes");
		}
		Dictionary<Type, Type> resolvedGenericParameters = new Dictionary<Type, Type>();
		for (int num = 0; num < array.Length; num++)
		{
			Type openConstructedType = array[num];
			Type closedConstructedType = closedConstructedParameterTypes[num];
			openConstructedType.MakeGenericTypeVia(closedConstructedType, resolvedGenericParameters);
		}
		Type[] typeArguments = (from openConstructedGenericArgument in openConstructedMethod.GetGenericArguments()
			select resolvedGenericParameters.ContainsKey(openConstructedGenericArgument) ? resolvedGenericParameters[openConstructedGenericArgument] : openConstructedGenericArgument).ToArray();
		return openConstructedMethod.MakeGenericMethod(typeArguments);
	}

	public static bool IsGenericExtension(this MethodInfo methodInfo)
	{
		return GenericExtensionMethods.Value.Contains(methodInfo);
	}

	private static IEnumerable<MethodInfo> GetInheritedExtensionMethods(Type thisArgumentType)
	{
		MethodInfo[] cache = ExtensionMethodsCache.Value.Cache;
		MethodInfo[] array = cache;
		foreach (MethodInfo methodInfo in array)
		{
			if (!methodInfo.GetParameters()[0].ParameterType.CanMakeGenericTypeVia(thisArgumentType))
			{
				continue;
			}
			if (methodInfo.ContainsGenericParameters)
			{
				IEnumerable<Type> source = thisArgumentType.Yield().Concat(from p in methodInfo.GetParametersWithoutThis()
					select p.ParameterType);
				MethodInfo methodInfo2 = methodInfo.MakeGenericMethodVia(source.ToArray());
				GenericExtensionMethods.Value.Add(methodInfo2);
				yield return methodInfo2;
			}
			else
			{
				yield return methodInfo;
			}
		}
	}

	public static IEnumerable<MethodInfo> GetExtensionMethods(this Type thisArgumentType, bool inherited = true)
	{
		if (inherited)
		{
			lock (InheritedExtensionMethodsCache)
			{
				if (!InheritedExtensionMethodsCache.Value.TryGetValue(thisArgumentType, out var value))
				{
					value = GetInheritedExtensionMethods(thisArgumentType).ToArray();
					InheritedExtensionMethodsCache.Value.Add(thisArgumentType, value);
				}
				return value;
			}
		}
		return ExtensionMethodsCache.Value.Cache.Where((MethodInfo method) => method.GetParameters()[0].ParameterType == thisArgumentType);
	}

	public static bool IsExtension(this MethodInfo methodInfo)
	{
		return methodInfo.HasAttribute<ExtensionAttribute>(inherit: false);
	}

	public static bool IsExtensionMethod(this MemberInfo memberInfo)
	{
		if (memberInfo is MethodInfo methodInfo)
		{
			return methodInfo.IsExtension();
		}
		return false;
	}

	public static Delegate CreateDelegate(this MethodInfo methodInfo, Type delegateType)
	{
		return Delegate.CreateDelegate(delegateType, methodInfo);
	}

	public static bool IsAccessor(this MemberInfo memberInfo)
	{
		if (!(memberInfo is FieldInfo))
		{
			return memberInfo is PropertyInfo;
		}
		return true;
	}

	public static Type GetAccessorType(this MemberInfo memberInfo)
	{
		if (memberInfo is FieldInfo)
		{
			return ((FieldInfo)memberInfo).FieldType;
		}
		if (memberInfo is PropertyInfo)
		{
			return ((PropertyInfo)memberInfo).PropertyType;
		}
		return null;
	}

	public static bool IsPubliclyGettable(this MemberInfo memberInfo)
	{
		if (memberInfo is FieldInfo)
		{
			return ((FieldInfo)memberInfo).IsPublic;
		}
		if (memberInfo is PropertyInfo)
		{
			PropertyInfo propertyInfo = (PropertyInfo)memberInfo;
			if (propertyInfo.CanRead)
			{
				return propertyInfo.GetGetMethod(nonPublic: false) != null;
			}
			return false;
		}
		if (memberInfo is MethodInfo)
		{
			return ((MethodInfo)memberInfo).IsPublic;
		}
		if (memberInfo is ConstructorInfo)
		{
			return ((ConstructorInfo)memberInfo).IsPublic;
		}
		throw new NotSupportedException();
	}

	private static Type ExtendedDeclaringType(this MemberInfo memberInfo)
	{
		if (memberInfo is MethodInfo methodInfo && methodInfo.IsExtension())
		{
			return methodInfo.GetParameters()[0].ParameterType;
		}
		return memberInfo.DeclaringType;
	}

	public static Type ExtendedDeclaringType(this MemberInfo memberInfo, bool invokeAsExtension)
	{
		if (invokeAsExtension)
		{
			return memberInfo.ExtendedDeclaringType();
		}
		return memberInfo.DeclaringType;
	}

	public static bool IsStatic(this PropertyInfo propertyInfo)
	{
		MethodInfo getMethod = propertyInfo.GetGetMethod(nonPublic: true);
		if ((object)getMethod == null || !getMethod.IsStatic)
		{
			return propertyInfo.GetSetMethod(nonPublic: true)?.IsStatic ?? false;
		}
		return true;
	}

	public static bool IsStatic(this MemberInfo memberInfo)
	{
		if (memberInfo is FieldInfo)
		{
			return ((FieldInfo)memberInfo).IsStatic;
		}
		if (memberInfo is PropertyInfo)
		{
			return ((PropertyInfo)memberInfo).IsStatic();
		}
		if (memberInfo is MethodBase)
		{
			return ((MethodBase)memberInfo).IsStatic;
		}
		throw new NotSupportedException();
	}

	private static IEnumerable<ParameterInfo> GetParametersWithoutThis(this MethodBase methodBase)
	{
		return methodBase.GetParameters().Skip(methodBase.IsExtensionMethod() ? 1 : 0);
	}

	public static bool IsInvokedAsExtension(this MethodBase methodBase, Type targetType)
	{
		if (methodBase.IsExtensionMethod())
		{
			return methodBase.DeclaringType != targetType;
		}
		return false;
	}

	public static IEnumerable<ParameterInfo> GetInvocationParameters(this MethodBase methodBase, bool invokeAsExtension)
	{
		if (invokeAsExtension)
		{
			return methodBase.GetParametersWithoutThis();
		}
		return methodBase.GetParameters();
	}

	public static IEnumerable<ParameterInfo> GetInvocationParameters(this MethodBase methodBase, Type targetType)
	{
		return methodBase.GetInvocationParameters(methodBase.IsInvokedAsExtension(targetType));
	}

	public static Type UnderlyingParameterType(this ParameterInfo parameterInfo)
	{
		if (parameterInfo.ParameterType.IsByRef)
		{
			return parameterInfo.ParameterType.GetElementType();
		}
		return parameterInfo.ParameterType;
	}

	public static bool HasDefaultValue(this ParameterInfo parameterInfo)
	{
		return (parameterInfo.Attributes & ParameterAttributes.HasDefault) == ParameterAttributes.HasDefault;
	}

	public static object DefaultValue(this ParameterInfo parameterInfo)
	{
		if (HasDefaultValue(parameterInfo))
		{
			object obj = parameterInfo.DefaultValue;
			if (obj == null && parameterInfo.ParameterType.IsValueType)
			{
				obj = parameterInfo.ParameterType.Default();
			}
			return obj;
		}
		return parameterInfo.UnderlyingParameterType().Default();
	}

	public static object PseudoDefaultValue(this ParameterInfo parameterInfo)
	{
		if (HasDefaultValue(parameterInfo))
		{
			object obj = parameterInfo.DefaultValue;
			if (obj == null && parameterInfo.ParameterType.IsValueType)
			{
				obj = parameterInfo.ParameterType.PseudoDefault();
			}
			return obj;
		}
		return parameterInfo.UnderlyingParameterType().PseudoDefault();
	}

	public static bool AllowsNull(this ParameterInfo parameterInfo)
	{
		Type parameterType = parameterInfo.ParameterType;
		if (!parameterType.IsReferenceType() || !parameterInfo.HasAttribute<AllowsNullAttribute>())
		{
			return Nullable.GetUnderlyingType(parameterType) != null;
		}
		return true;
	}

	public static bool HasOutModifier(this ParameterInfo parameterInfo)
	{
		Ensure.That("parameterInfo").IsNotNull(parameterInfo);
		if (parameterInfo.IsOut)
		{
			return parameterInfo.ParameterType.IsByRef;
		}
		return false;
	}

	public static bool CanWrite(this FieldInfo fieldInfo)
	{
		if (!fieldInfo.IsInitOnly)
		{
			return !fieldInfo.IsLiteral;
		}
		return false;
	}

	public static Member ToManipulator(this MemberInfo memberInfo)
	{
		return memberInfo.ToManipulator(memberInfo.DeclaringType);
	}

	public static Member ToManipulator(this MemberInfo memberInfo, Type targetType)
	{
		if (memberInfo is FieldInfo fieldInfo)
		{
			return fieldInfo.ToManipulator(targetType);
		}
		if (memberInfo is PropertyInfo propertyInfo)
		{
			return propertyInfo.ToManipulator(targetType);
		}
		if (memberInfo is MethodInfo methodInfo)
		{
			return methodInfo.ToManipulator(targetType);
		}
		if (memberInfo is ConstructorInfo constructorInfo)
		{
			return constructorInfo.ToManipulator(targetType);
		}
		throw new InvalidOperationException();
	}

	public static Member ToManipulator(this FieldInfo fieldInfo, Type targetType)
	{
		return new Member(targetType, fieldInfo);
	}

	public static Member ToManipulator(this PropertyInfo propertyInfo, Type targetType)
	{
		return new Member(targetType, propertyInfo);
	}

	public static Member ToManipulator(this MethodInfo methodInfo, Type targetType)
	{
		return new Member(targetType, methodInfo);
	}

	public static Member ToManipulator(this ConstructorInfo constructorInfo, Type targetType)
	{
		return new Member(targetType, constructorInfo);
	}

	public static ConstructorInfo GetConstructorAccepting(this Type type, Type[] paramTypes, bool nonPublic)
	{
		BindingFlags bindingFlags = BindingFlags.Instance | BindingFlags.Public;
		if (nonPublic)
		{
			bindingFlags |= BindingFlags.NonPublic;
		}
		return type.GetConstructors(bindingFlags).FirstOrDefault((ConstructorInfo constructor) =>
		{
			ParameterInfo[] parameters = constructor.GetParameters();
			if (parameters.Length != paramTypes.Length)
			{
				return false;
			}
			for (int i = 0; i < parameters.Length; i++)
			{
				if (paramTypes[i] == null)
				{
					if (!parameters[i].ParameterType.IsNullable())
					{
						return false;
					}
				}
				else if (!parameters[i].ParameterType.IsAssignableFrom(paramTypes[i]))
				{
					return false;
				}
			}
			return true;
		});
	}

	public static ConstructorInfo GetConstructorAccepting(this Type type, params Type[] paramTypes)
	{
		return type.GetConstructorAccepting(paramTypes, nonPublic: true);
	}

	public static ConstructorInfo GetPublicConstructorAccepting(this Type type, params Type[] paramTypes)
	{
		return type.GetConstructorAccepting(paramTypes, nonPublic: false);
	}

	public static ConstructorInfo GetDefaultConstructor(this Type type)
	{
		return type.GetConstructorAccepting();
	}

	public static ConstructorInfo GetPublicDefaultConstructor(this Type type)
	{
		return type.GetPublicConstructorAccepting();
	}

	public static MemberInfo[] GetExtendedMember(this Type type, string name, MemberTypes types, BindingFlags flags)
	{
		List<MemberInfo> list = type.GetMember(name, types, flags).ToList();
		if (types.HasFlag(MemberTypes.Method))
		{
			list.AddRange((from extension in type.GetExtensionMethods()
				where extension.Name == name
				select extension).Cast<MemberInfo>());
		}
		return list.ToArray();
	}

	public static MemberInfo[] GetExtendedMembers(this Type type, BindingFlags flags)
	{
		HashSet<MemberInfo> hashSet = type.GetMembers(flags).ToHashSet();
		foreach (MethodInfo extensionMethod in type.GetExtensionMethods())
		{
			hashSet.Add(extensionMethod);
		}
		return hashSet.ToArray();
	}

	private static bool NameMatches(this MemberInfo member, string name)
	{
		return member.Name == name;
	}

	private static bool ParametersMatch(this MethodBase methodBase, IEnumerable<Type> parameterTypes, bool invokeAsExtension)
	{
		Ensure.That("parameterTypes").IsNotNull(parameterTypes);
		return (from paramInfo in methodBase.GetInvocationParameters(invokeAsExtension)
			select paramInfo.ParameterType).SequenceEqual(parameterTypes);
	}

	private static bool GenericArgumentsMatch(this MethodInfo method, IEnumerable<Type> genericArgumentTypes)
	{
		Ensure.That("genericArgumentTypes").IsNotNull(genericArgumentTypes);
		if (method.ContainsGenericParameters)
		{
			return false;
		}
		return method.GetGenericArguments().SequenceEqual(genericArgumentTypes);
	}

	public static bool SignatureMatches(this FieldInfo field, string name)
	{
		return field.NameMatches(name);
	}

	public static bool SignatureMatches(this PropertyInfo property, string name)
	{
		return property.NameMatches(name);
	}

	public static bool SignatureMatches(this ConstructorInfo constructor, string name, IEnumerable<Type> parameterTypes)
	{
		if (constructor.NameMatches(name))
		{
			return constructor.ParametersMatch(parameterTypes, invokeAsExtension: false);
		}
		return false;
	}

	public static bool SignatureMatches(this MethodInfo method, string name, IEnumerable<Type> parameterTypes, bool invokeAsExtension)
	{
		if (method.NameMatches(name) && method.ParametersMatch(parameterTypes, invokeAsExtension))
		{
			return !method.ContainsGenericParameters;
		}
		return false;
	}

	public static bool SignatureMatches(this MethodInfo method, string name, IEnumerable<Type> parameterTypes, IEnumerable<Type> genericArgumentTypes, bool invokeAsExtension)
	{
		if (method.NameMatches(name) && method.ParametersMatch(parameterTypes, invokeAsExtension))
		{
			return method.GenericArgumentsMatch(genericArgumentTypes);
		}
		return false;
	}

	public static FieldInfo GetFieldUnambiguous(this Type type, string name, BindingFlags flags)
	{
		Ensure.That("type").IsNotNull(type);
		Ensure.That("name").IsNotNull(name);
		flags |= BindingFlags.DeclaredOnly;
		while (type != null)
		{
			FieldInfo field = type.GetField(name, flags);
			if (field != null)
			{
				return field;
			}
			type = type.BaseType;
		}
		return null;
	}

	public static PropertyInfo GetPropertyUnambiguous(this Type type, string name, BindingFlags flags)
	{
		Ensure.That("type").IsNotNull(type);
		Ensure.That("name").IsNotNull(name);
		flags |= BindingFlags.DeclaredOnly;
		while (type != null)
		{
			PropertyInfo property = type.GetProperty(name, flags);
			if (property != null)
			{
				return property;
			}
			type = type.BaseType;
		}
		return null;
	}

	public static MethodInfo GetMethodUnambiguous(this Type type, string name, BindingFlags flags)
	{
		Ensure.That("type").IsNotNull(type);
		Ensure.That("name").IsNotNull(name);
		flags |= BindingFlags.DeclaredOnly;
		while (type != null)
		{
			MethodInfo method = type.GetMethod(name, flags);
			if (method != null)
			{
				return method;
			}
			type = type.BaseType;
		}
		return null;
	}

	private static TMemberInfo DisambiguateHierarchy<TMemberInfo>(this IEnumerable<TMemberInfo> members, Type type) where TMemberInfo : MemberInfo
	{
		while (type != null)
		{
			foreach (TMemberInfo member in members)
			{
				MethodInfo methodInfo = member as MethodInfo;
				bool invokeAsExtension = methodInfo != null && methodInfo.IsInvokedAsExtension(type);
				if (member.ExtendedDeclaringType(invokeAsExtension) == type)
				{
					return member;
				}
			}
			type = type.BaseType;
		}
		return null;
	}

	public static FieldInfo Disambiguate(this IEnumerable<FieldInfo> fields, Type type)
	{
		Ensure.That("fields").IsNotNull(fields);
		Ensure.That("type").IsNotNull(type);
		return fields.DisambiguateHierarchy(type);
	}

	public static PropertyInfo Disambiguate(this IEnumerable<PropertyInfo> properties, Type type)
	{
		Ensure.That("properties").IsNotNull(properties);
		Ensure.That("type").IsNotNull(type);
		return properties.DisambiguateHierarchy(type);
	}

	public static ConstructorInfo Disambiguate(this IEnumerable<ConstructorInfo> constructors, Type type, IEnumerable<Type> parameterTypes)
	{
		Ensure.That("constructors").IsNotNull(constructors);
		Ensure.That("type").IsNotNull(type);
		Ensure.That("parameterTypes").IsNotNull(parameterTypes);
		return constructors.Where((ConstructorInfo m) => m.ParametersMatch(parameterTypes, invokeAsExtension: false) && !m.ContainsGenericParameters).DisambiguateHierarchy(type);
	}

	public static MethodInfo Disambiguate(this IEnumerable<MethodInfo> methods, Type type, IEnumerable<Type> parameterTypes)
	{
		Ensure.That("methods").IsNotNull(methods);
		Ensure.That("type").IsNotNull(type);
		Ensure.That("parameterTypes").IsNotNull(parameterTypes);
		return methods.Where((MethodInfo m) => m.ParametersMatch(parameterTypes, m.IsInvokedAsExtension(type)) && !m.ContainsGenericParameters).DisambiguateHierarchy(type);
	}

	public static MethodInfo Disambiguate(this IEnumerable<MethodInfo> methods, Type type, IEnumerable<Type> parameterTypes, IEnumerable<Type> genericArgumentTypes)
	{
		Ensure.That("methods").IsNotNull(methods);
		Ensure.That("type").IsNotNull(type);
		Ensure.That("parameterTypes").IsNotNull(parameterTypes);
		Ensure.That("genericArgumentTypes").IsNotNull(genericArgumentTypes);
		return methods.Where((MethodInfo m) => m.ParametersMatch(parameterTypes, m.IsInvokedAsExtension(type)) && m.GenericArgumentsMatch(genericArgumentTypes)).DisambiguateHierarchy(type);
	}
}
