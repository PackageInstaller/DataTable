using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Reflection;

namespace Sirenix.Utilities;

public static class MemberInfoExtensions
{
	public static bool IsDefined<T>(this ICustomAttributeProvider member, bool inherit) where T : Attribute
	{
		try
		{
			return member.IsDefined(typeof(T), inherit);
		}
		catch
		{
			return false;
		}
	}

	public static bool IsDefined<T>(this ICustomAttributeProvider member) where T : Attribute
	{
		return member.IsDefined<T>(inherit: false);
	}

	public static T GetAttribute<T>(this ICustomAttributeProvider member, bool inherit) where T : Attribute
	{
		T[] array = member.GetAttributes<T>(inherit).ToArray();
		if (array != null && array.Length != 0)
		{
			return array[0];
		}
		return null;
	}

	public static T GetAttribute<T>(this ICustomAttributeProvider member) where T : Attribute
	{
		return member.GetAttribute<T>(inherit: false);
	}

	public static IEnumerable<T> GetAttributes<T>(this ICustomAttributeProvider member) where T : Attribute
	{
		return member.GetAttributes<T>(inherit: false);
	}

	public static IEnumerable<T> GetAttributes<T>(this ICustomAttributeProvider member, bool inherit) where T : Attribute
	{
		try
		{
			return member.GetCustomAttributes(typeof(T), inherit).Cast<T>();
		}
		catch
		{
			return new T[0];
		}
	}

	public static Attribute[] GetAttributes(this ICustomAttributeProvider member)
	{
		try
		{
			return member.GetAttributes<Attribute>().ToArray();
		}
		catch
		{
			return new Attribute[0];
		}
	}

	public static Attribute[] GetAttributes(this ICustomAttributeProvider member, bool inherit)
	{
		try
		{
			return member.GetAttributes<Attribute>(inherit).ToArray();
		}
		catch
		{
			return new Attribute[0];
		}
	}

	public static string GetNiceName(this MemberInfo member)
	{
		MethodBase methodBase = member as MethodBase;
		string input = ((!(methodBase != null)) ? member.Name : methodBase.GetFullName());
		return input.ToTitleCase();
	}

	public static bool IsStatic(this MemberInfo member)
	{
		FieldInfo fieldInfo = member as FieldInfo;
		if (fieldInfo != null)
		{
			return fieldInfo.IsStatic;
		}
		PropertyInfo propertyInfo = member as PropertyInfo;
		if (propertyInfo != null)
		{
			if (!propertyInfo.CanRead)
			{
				return propertyInfo.GetSetMethod(nonPublic: true).IsStatic;
			}
			return propertyInfo.GetGetMethod(nonPublic: true).IsStatic;
		}
		MethodBase methodBase = member as MethodBase;
		if (methodBase != null)
		{
			return methodBase.IsStatic;
		}
		EventInfo eventInfo = member as EventInfo;
		if (eventInfo != null)
		{
			return eventInfo.GetRaiseMethod(nonPublic: true).IsStatic;
		}
		Type type = member as Type;
		if (type != null)
		{
			if (type.IsSealed)
			{
				return type.IsAbstract;
			}
			return false;
		}
		string message = string.Format(CultureInfo.InvariantCulture, "Unable to determine IsStatic for member {0}.{1}MemberType was {2} but only fields, properties, methods, events and types are supported.", member.DeclaringType.FullName, member.Name, member.GetType().FullName);
		throw new NotSupportedException(message);
	}

	public static bool IsAlias(this MemberInfo memberInfo)
	{
		if (!(memberInfo is MemberAliasFieldInfo) && !(memberInfo is MemberAliasPropertyInfo))
		{
			return memberInfo is MemberAliasMethodInfo;
		}
		return true;
	}

	public static MemberInfo DeAlias(this MemberInfo memberInfo, bool throwOnNotAliased = false)
	{
		MemberAliasFieldInfo memberAliasFieldInfo = memberInfo as MemberAliasFieldInfo;
		if (memberAliasFieldInfo != null)
		{
			return memberAliasFieldInfo.AliasedField;
		}
		MemberAliasPropertyInfo memberAliasPropertyInfo = memberInfo as MemberAliasPropertyInfo;
		if (memberAliasPropertyInfo != null)
		{
			return memberAliasPropertyInfo.AliasedProperty;
		}
		MemberAliasMethodInfo memberAliasMethodInfo = memberInfo as MemberAliasMethodInfo;
		if (memberAliasMethodInfo != null)
		{
			return memberAliasMethodInfo.AliasedMethod;
		}
		if (throwOnNotAliased)
		{
			throw new ArgumentException("The member " + memberInfo.GetNiceName() + " was not aliased.");
		}
		return memberInfo;
	}

	public static bool SignaturesAreEqual(this MemberInfo a, MemberInfo b)
	{
		if (a.MemberType != b.MemberType)
		{
			return false;
		}
		if (a.Name != b.Name)
		{
			return false;
		}
		if (a.GetReturnType() != b.GetReturnType())
		{
			return false;
		}
		if (a.IsStatic() != b.IsStatic())
		{
			return false;
		}
		MethodInfo methodInfo = a as MethodInfo;
		MethodInfo methodInfo2 = b as MethodInfo;
		if (methodInfo != null)
		{
			if (methodInfo.IsPublic != methodInfo2.IsPublic)
			{
				return false;
			}
			if (methodInfo.IsPrivate != methodInfo2.IsPrivate)
			{
				return false;
			}
			if (methodInfo.IsPublic != methodInfo2.IsPublic)
			{
				return false;
			}
			ParameterInfo[] parameters = methodInfo.GetParameters();
			ParameterInfo[] parameters2 = methodInfo2.GetParameters();
			if (parameters.Length != parameters2.Length)
			{
				return false;
			}
			for (int i = 0; i < parameters.Length; i++)
			{
				if (parameters[i].ParameterType != parameters2[i].ParameterType)
				{
					return false;
				}
			}
		}
		PropertyInfo propertyInfo = a as PropertyInfo;
		PropertyInfo propertyInfo2 = b as PropertyInfo;
		if (propertyInfo != null)
		{
			MethodInfo[] accessors = propertyInfo.GetAccessors(nonPublic: true);
			MethodInfo[] accessors2 = propertyInfo2.GetAccessors(nonPublic: true);
			if (accessors.Length != accessors2.Length)
			{
				return false;
			}
			if (accessors[0].IsPublic != accessors2[0].IsPublic)
			{
				return false;
			}
			if (accessors.Length > 1 && accessors[1].IsPublic != accessors2[1].IsPublic)
			{
				return false;
			}
		}
		return true;
	}
}
