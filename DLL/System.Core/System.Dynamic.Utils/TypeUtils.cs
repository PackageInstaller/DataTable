using System.Linq;
using System.Linq.Expressions;
using System.Reflection;

namespace System.Dynamic.Utils;

internal static class TypeUtils
{
	private static readonly Type[] s_arrayAssignableInterfaces = (from i in typeof(int[]).GetInterfaces()
		where i.IsGenericType
		select i.GetGenericTypeDefinition()).ToArray();

	public static Type GetNonNullableType(this Type type)
	{
		if (!type.IsNullableType())
		{
			return type;
		}
		return type.GetGenericArguments()[0];
	}

	public static Type GetNullableType(this Type type)
	{
		if (type.IsValueType && !type.IsNullableType())
		{
			return typeof(Nullable<>).MakeGenericType(type);
		}
		return type;
	}

	public static bool IsNullableType(this Type type)
	{
		if (type.IsConstructedGenericType)
		{
			return type.GetGenericTypeDefinition() == typeof(Nullable<>);
		}
		return false;
	}

	public static bool IsNullableOrReferenceType(this Type type)
	{
		if (type.IsValueType)
		{
			return type.IsNullableType();
		}
		return true;
	}

	public static bool IsBool(this Type type)
	{
		return type.GetNonNullableType() == typeof(bool);
	}

	public static bool IsNumeric(this Type type)
	{
		type = type.GetNonNullableType();
		if (!type.IsEnum)
		{
			TypeCode typeCode = type.GetTypeCode();
			if ((uint)(typeCode - 4) <= 10u)
			{
				return true;
			}
		}
		return false;
	}

	public static bool IsInteger(this Type type)
	{
		type = type.GetNonNullableType();
		if (!type.IsEnum)
		{
			TypeCode typeCode = type.GetTypeCode();
			if ((uint)(typeCode - 5) <= 7u)
			{
				return true;
			}
		}
		return false;
	}

	public static bool IsArithmetic(this Type type)
	{
		type = type.GetNonNullableType();
		if (!type.IsEnum)
		{
			TypeCode typeCode = type.GetTypeCode();
			if ((uint)(typeCode - 7) <= 7u)
			{
				return true;
			}
		}
		return false;
	}

	public static bool IsUnsignedInt(this Type type)
	{
		type = type.GetNonNullableType();
		if (!type.IsEnum)
		{
			switch (type.GetTypeCode())
			{
			case TypeCode.UInt16:
			case TypeCode.UInt32:
			case TypeCode.UInt64:
				return true;
			}
		}
		return false;
	}

	public static bool IsIntegerOrBool(this Type type)
	{
		type = type.GetNonNullableType();
		if (!type.IsEnum)
		{
			TypeCode typeCode = type.GetTypeCode();
			if (typeCode == TypeCode.Boolean || (uint)(typeCode - 5) <= 7u)
			{
				return true;
			}
		}
		return false;
	}

	public static bool IsNumericOrBool(this Type type)
	{
		if (!type.IsNumeric())
		{
			return type.IsBool();
		}
		return true;
	}

	public static bool IsValidInstanceType(MemberInfo member, Type instanceType)
	{
		Type declaringType = member.DeclaringType;
		if (AreReferenceAssignable(declaringType, instanceType))
		{
			return true;
		}
		if (declaringType == null)
		{
			return false;
		}
		if (instanceType.IsValueType)
		{
			if (AreReferenceAssignable(declaringType, typeof(object)))
			{
				return true;
			}
			if (AreReferenceAssignable(declaringType, typeof(ValueType)))
			{
				return true;
			}
			if (instanceType.IsEnum && AreReferenceAssignable(declaringType, typeof(Enum)))
			{
				return true;
			}
			if (declaringType.IsInterface)
			{
				foreach (Type implementedInterface in instanceType.GetTypeInfo().ImplementedInterfaces)
				{
					if (AreReferenceAssignable(declaringType, implementedInterface))
					{
						return true;
					}
				}
			}
		}
		return false;
	}

	public static bool HasIdentityPrimitiveOrNullableConversionTo(this Type source, Type dest)
	{
		if (AreEquivalent(source, dest))
		{
			return true;
		}
		if (source.IsNullableType() && AreEquivalent(dest, source.GetNonNullableType()))
		{
			return true;
		}
		if (dest.IsNullableType() && AreEquivalent(source, dest.GetNonNullableType()))
		{
			return true;
		}
		if (source.IsConvertible() && dest.IsConvertible())
		{
			if (!(dest.GetNonNullableType() != typeof(bool)))
			{
				if (source.IsEnum)
				{
					return source.GetEnumUnderlyingType() == typeof(bool);
				}
				return false;
			}
			return true;
		}
		return false;
	}

	public static bool HasReferenceConversionTo(this Type source, Type dest)
	{
		if (source == typeof(void) || dest == typeof(void))
		{
			return false;
		}
		Type nonNullableType = source.GetNonNullableType();
		Type nonNullableType2 = dest.GetNonNullableType();
		if (nonNullableType.IsAssignableFrom(nonNullableType2))
		{
			return true;
		}
		if (nonNullableType2.IsAssignableFrom(nonNullableType))
		{
			return true;
		}
		if (source.IsInterface || dest.IsInterface)
		{
			return true;
		}
		if (IsLegalExplicitVariantDelegateConversion(source, dest))
		{
			return true;
		}
		if (source.IsArray || dest.IsArray)
		{
			return source.StrictHasReferenceConversionTo(dest, skipNonArray: true);
		}
		return false;
	}

	private static bool StrictHasReferenceConversionTo(this Type source, Type dest, bool skipNonArray)
	{
		while (true)
		{
			if (!skipNonArray)
			{
				if (source.IsValueType | dest.IsValueType)
				{
					return false;
				}
				if (source.IsAssignableFrom(dest) || dest.IsAssignableFrom(source))
				{
					return true;
				}
				if (source.IsInterface)
				{
					if (dest.IsInterface || (dest.IsClass && !dest.IsSealed))
					{
						return true;
					}
				}
				else if (dest.IsInterface && source.IsClass && !source.IsSealed)
				{
					return true;
				}
			}
			if (!source.IsArray)
			{
				break;
			}
			if (dest.IsArray)
			{
				if (source.GetArrayRank() != dest.GetArrayRank() || source.IsSZArray != dest.IsSZArray)
				{
					return false;
				}
				source = source.GetElementType();
				dest = dest.GetElementType();
				skipNonArray = false;
				continue;
			}
			return HasArrayToInterfaceConversion(source, dest);
		}
		if (dest.IsArray)
		{
			if (HasInterfaceToArrayConversion(source, dest))
			{
				return true;
			}
			return IsImplicitReferenceConversion(typeof(Array), source);
		}
		return IsLegalExplicitVariantDelegateConversion(source, dest);
	}

	private static bool HasArrayToInterfaceConversion(Type source, Type dest)
	{
		if (!source.IsSZArray || !dest.IsInterface || !dest.IsGenericType)
		{
			return false;
		}
		Type[] genericArguments = dest.GetGenericArguments();
		if (genericArguments.Length != 1)
		{
			return false;
		}
		Type genericTypeDefinition = dest.GetGenericTypeDefinition();
		Type[] array = s_arrayAssignableInterfaces;
		foreach (Type t in array)
		{
			if (AreEquivalent(genericTypeDefinition, t))
			{
				return source.GetElementType().StrictHasReferenceConversionTo(genericArguments[0], skipNonArray: false);
			}
		}
		return false;
	}

	private static bool HasInterfaceToArrayConversion(Type source, Type dest)
	{
		if (!dest.IsSZArray || !source.IsInterface || !source.IsGenericType)
		{
			return false;
		}
		Type[] genericArguments = source.GetGenericArguments();
		if (genericArguments.Length != 1)
		{
			return false;
		}
		Type genericTypeDefinition = source.GetGenericTypeDefinition();
		Type[] array = s_arrayAssignableInterfaces;
		foreach (Type t in array)
		{
			if (AreEquivalent(genericTypeDefinition, t))
			{
				return genericArguments[0].StrictHasReferenceConversionTo(dest.GetElementType(), skipNonArray: false);
			}
		}
		return false;
	}

	private static bool IsCovariant(Type t)
	{
		return (t.GenericParameterAttributes & GenericParameterAttributes.Covariant) != 0;
	}

	private static bool IsContravariant(Type t)
	{
		return (t.GenericParameterAttributes & GenericParameterAttributes.Contravariant) != 0;
	}

	private static bool IsInvariant(Type t)
	{
		return (t.GenericParameterAttributes & GenericParameterAttributes.VarianceMask) == 0;
	}

	private static bool IsDelegate(Type t)
	{
		return t.IsSubclassOf(typeof(MulticastDelegate));
	}

	public static bool IsLegalExplicitVariantDelegateConversion(Type source, Type dest)
	{
		if (!IsDelegate(source) || !IsDelegate(dest) || !source.IsGenericType || !dest.IsGenericType)
		{
			return false;
		}
		Type genericTypeDefinition = source.GetGenericTypeDefinition();
		if (dest.GetGenericTypeDefinition() != genericTypeDefinition)
		{
			return false;
		}
		Type[] genericArguments = genericTypeDefinition.GetGenericArguments();
		Type[] genericArguments2 = source.GetGenericArguments();
		Type[] genericArguments3 = dest.GetGenericArguments();
		for (int i = 0; i < genericArguments.Length; i++)
		{
			Type type = genericArguments2[i];
			Type type2 = genericArguments3[i];
			if (AreEquivalent(type, type2))
			{
				continue;
			}
			Type t = genericArguments[i];
			if (IsInvariant(t))
			{
				return false;
			}
			if (IsCovariant(t))
			{
				if (!type.HasReferenceConversionTo(type2))
				{
					return false;
				}
			}
			else if (IsContravariant(t) && (type.IsValueType || type2.IsValueType))
			{
				return false;
			}
		}
		return true;
	}

	public static bool IsConvertible(this Type type)
	{
		type = type.GetNonNullableType();
		if (type.IsEnum)
		{
			return true;
		}
		TypeCode typeCode = type.GetTypeCode();
		if ((uint)(typeCode - 3) <= 11u)
		{
			return true;
		}
		return false;
	}

	public static bool HasReferenceEquality(Type left, Type right)
	{
		if (left.IsValueType || right.IsValueType)
		{
			return false;
		}
		if (!left.IsInterface && !right.IsInterface && !AreReferenceAssignable(left, right))
		{
			return AreReferenceAssignable(right, left);
		}
		return true;
	}

	public static bool HasBuiltInEqualityOperator(Type left, Type right)
	{
		if (left.IsInterface && !right.IsValueType)
		{
			return true;
		}
		if (right.IsInterface && !left.IsValueType)
		{
			return true;
		}
		if (!left.IsValueType && !right.IsValueType && (AreReferenceAssignable(left, right) || AreReferenceAssignable(right, left)))
		{
			return true;
		}
		if (!AreEquivalent(left, right))
		{
			return false;
		}
		Type nonNullableType = left.GetNonNullableType();
		if (!(nonNullableType == typeof(bool)) && !nonNullableType.IsNumeric())
		{
			return nonNullableType.IsEnum;
		}
		return true;
	}

	public static bool IsImplicitlyConvertibleTo(this Type source, Type destination)
	{
		if (!AreEquivalent(source, destination) && !IsImplicitNumericConversion(source, destination) && !IsImplicitReferenceConversion(source, destination) && !IsImplicitBoxingConversion(source, destination))
		{
			return IsImplicitNullableConversion(source, destination);
		}
		return true;
	}

	public static MethodInfo GetUserDefinedCoercionMethod(Type convertFrom, Type convertToType)
	{
		Type nonNullableType = convertFrom.GetNonNullableType();
		Type nonNullableType2 = convertToType.GetNonNullableType();
		MethodInfo[] methods = nonNullableType.GetMethods(BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic);
		MethodInfo methodInfo = FindConversionOperator(methods, convertFrom, convertToType);
		if (methodInfo != null)
		{
			return methodInfo;
		}
		MethodInfo[] methods2 = nonNullableType2.GetMethods(BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic);
		methodInfo = FindConversionOperator(methods2, convertFrom, convertToType);
		if (methodInfo != null)
		{
			return methodInfo;
		}
		if (AreEquivalent(nonNullableType, convertFrom) && AreEquivalent(nonNullableType2, convertToType))
		{
			return null;
		}
		return FindConversionOperator(methods, nonNullableType, nonNullableType2) ?? FindConversionOperator(methods2, nonNullableType, nonNullableType2) ?? FindConversionOperator(methods, nonNullableType, convertToType) ?? FindConversionOperator(methods2, nonNullableType, convertToType);
	}

	private static MethodInfo FindConversionOperator(MethodInfo[] methods, Type typeFrom, Type typeTo)
	{
		foreach (MethodInfo methodInfo in methods)
		{
			if ((methodInfo.Name == "op_Implicit" || methodInfo.Name == "op_Explicit") && AreEquivalent(methodInfo.ReturnType, typeTo))
			{
				ParameterInfo[] parametersCached = methodInfo.GetParametersCached();
				if (parametersCached.Length == 1 && AreEquivalent(parametersCached[0].ParameterType, typeFrom))
				{
					return methodInfo;
				}
			}
		}
		return null;
	}

	private static bool IsImplicitNumericConversion(Type source, Type destination)
	{
		TypeCode typeCode = source.GetTypeCode();
		TypeCode typeCode2 = destination.GetTypeCode();
		switch (typeCode)
		{
		case TypeCode.SByte:
			switch (typeCode2)
			{
			case TypeCode.Int16:
			case TypeCode.Int32:
			case TypeCode.Int64:
			case TypeCode.Single:
			case TypeCode.Double:
			case TypeCode.Decimal:
				return true;
			}
			break;
		case TypeCode.Byte:
			if ((uint)(typeCode2 - 7) <= 8u)
			{
				return true;
			}
			break;
		case TypeCode.Int16:
			switch (typeCode2)
			{
			case TypeCode.Int32:
			case TypeCode.Int64:
			case TypeCode.Single:
			case TypeCode.Double:
			case TypeCode.Decimal:
				return true;
			}
			break;
		case TypeCode.UInt16:
			if ((uint)(typeCode2 - 9) <= 6u)
			{
				return true;
			}
			break;
		case TypeCode.Int32:
			if (typeCode2 == TypeCode.Int64 || (uint)(typeCode2 - 13) <= 2u)
			{
				return true;
			}
			break;
		case TypeCode.UInt32:
			if ((uint)(typeCode2 - 11) <= 4u)
			{
				return true;
			}
			break;
		case TypeCode.Int64:
		case TypeCode.UInt64:
			if ((uint)(typeCode2 - 13) <= 2u)
			{
				return true;
			}
			break;
		case TypeCode.Char:
			if ((uint)(typeCode2 - 8) <= 7u)
			{
				return true;
			}
			break;
		case TypeCode.Single:
			return typeCode2 == TypeCode.Double;
		}
		return false;
	}

	private static bool IsImplicitReferenceConversion(Type source, Type destination)
	{
		return destination.IsAssignableFrom(source);
	}

	private static bool IsImplicitBoxingConversion(Type source, Type destination)
	{
		if (!source.IsValueType || (!(destination == typeof(object)) && !(destination == typeof(ValueType))))
		{
			if (source.IsEnum)
			{
				return destination == typeof(Enum);
			}
			return false;
		}
		return true;
	}

	private static bool IsImplicitNullableConversion(Type source, Type destination)
	{
		if (destination.IsNullableType())
		{
			return source.GetNonNullableType().IsImplicitlyConvertibleTo(destination.GetNonNullableType());
		}
		return false;
	}

	public static Type FindGenericType(Type definition, Type type)
	{
		while ((object)type != null && type != typeof(object))
		{
			if (type.IsConstructedGenericType && AreEquivalent(type.GetGenericTypeDefinition(), definition))
			{
				return type;
			}
			if (definition.IsInterface)
			{
				foreach (Type implementedInterface in type.GetTypeInfo().ImplementedInterfaces)
				{
					Type type2 = FindGenericType(definition, implementedInterface);
					if (type2 != null)
					{
						return type2;
					}
				}
			}
			type = type.BaseType;
		}
		return null;
	}

	public static MethodInfo GetBooleanOperator(Type type, string name)
	{
		do
		{
			MethodInfo anyStaticMethodValidated = type.GetAnyStaticMethodValidated(name, new Type[1] { type });
			if (anyStaticMethodValidated != null && anyStaticMethodValidated.IsSpecialName && !anyStaticMethodValidated.ContainsGenericParameters)
			{
				return anyStaticMethodValidated;
			}
			type = type.BaseType;
		}
		while (type != null);
		return null;
	}

	public static Type GetNonRefType(this Type type)
	{
		if (!type.IsByRef)
		{
			return type;
		}
		return type.GetElementType();
	}

	public static bool AreEquivalent(Type t1, Type t2)
	{
		if (t1 != null)
		{
			return t1.IsEquivalentTo(t2);
		}
		return false;
	}

	public static bool AreReferenceAssignable(Type dest, Type src)
	{
		if (AreEquivalent(dest, src))
		{
			return true;
		}
		if (!dest.IsValueType && !src.IsValueType)
		{
			return dest.IsAssignableFrom(src);
		}
		return false;
	}

	public static bool IsSameOrSubclass(Type type, Type subType)
	{
		if (!AreEquivalent(type, subType))
		{
			return subType.IsSubclassOf(type);
		}
		return true;
	}

	public static void ValidateType(Type type, string paramName)
	{
		ValidateType(type, paramName, allowByRef: false, allowPointer: false);
	}

	public static void ValidateType(Type type, string paramName, bool allowByRef, bool allowPointer)
	{
		if (ValidateType(type, paramName, -1))
		{
			if (!allowByRef && type.IsByRef)
			{
				throw System.Linq.Expressions.Error.TypeMustNotBeByRef(paramName);
			}
			if (!allowPointer && type.IsPointer)
			{
				throw System.Linq.Expressions.Error.TypeMustNotBePointer(paramName);
			}
		}
	}

	public static bool ValidateType(Type type, string paramName, int index)
	{
		if (type == typeof(void))
		{
			return false;
		}
		if (type.ContainsGenericParameters)
		{
			throw type.IsGenericTypeDefinition ? System.Linq.Expressions.Error.TypeIsGeneric(type, paramName, index) : System.Linq.Expressions.Error.TypeContainsGenericParameters(type, paramName, index);
		}
		return true;
	}

	public static MethodInfo GetInvokeMethod(this Type delegateType)
	{
		return delegateType.GetMethod("Invoke", BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
	}
}
