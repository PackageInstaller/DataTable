using System;
using System.Reflection;
using System.Runtime.CompilerServices;

namespace MessagePack.Internal;

internal static class ReflectionExtensions
{
	public static bool IsNullable(this TypeInfo type)
	{
		if (type.IsGenericType)
		{
			return type.GetGenericTypeDefinition() == typeof(Nullable<>);
		}
		return false;
	}

	public static bool IsPublic(this TypeInfo type)
	{
		return type.IsPublic;
	}

	public static bool IsAnonymous(this TypeInfo type)
	{
		if (type.Namespace == null && type.IsSealed && (type.Name.StartsWith("<>f__AnonymousType", StringComparison.Ordinal) || type.Name.StartsWith("<>__AnonType", StringComparison.Ordinal) || type.Name.StartsWith("VB$AnonymousType_", StringComparison.Ordinal)))
		{
			return type.IsDefined(typeof(CompilerGeneratedAttribute), inherit: false);
		}
		return false;
	}

	public static bool IsIndexer(this PropertyInfo propertyInfo)
	{
		return propertyInfo.GetIndexParameters().Length != 0;
	}

	public static bool IsConstructedGenericType(this TypeInfo type)
	{
		return type.AsType().IsConstructedGenericType;
	}

	public static MethodInfo GetGetMethod(this PropertyInfo propInfo)
	{
		return propInfo.GetMethod;
	}

	public static MethodInfo GetSetMethod(this PropertyInfo propInfo)
	{
		return propInfo.SetMethod;
	}
}
