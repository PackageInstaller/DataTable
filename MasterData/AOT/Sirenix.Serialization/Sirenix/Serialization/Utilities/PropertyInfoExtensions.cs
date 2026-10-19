using System;
using System.Reflection;

namespace Sirenix.Serialization.Utilities;

internal static class PropertyInfoExtensions
{
	public static bool IsAutoProperty(this PropertyInfo propInfo, bool allowVirtual = false)
	{
		if (!propInfo.CanWrite || !propInfo.CanRead)
		{
			return false;
		}
		if (!allowVirtual)
		{
			MethodInfo getMethod = propInfo.GetGetMethod(nonPublic: true);
			MethodInfo setMethod = propInfo.GetSetMethod(nonPublic: true);
			if ((getMethod != null && (getMethod.IsAbstract || getMethod.IsVirtual)) || (setMethod != null && (setMethod.IsAbstract || setMethod.IsVirtual)))
			{
				return false;
			}
		}
		BindingFlags bindingAttr = BindingFlags.Instance | BindingFlags.Static | BindingFlags.NonPublic;
		string value = "<" + propInfo.Name + ">";
		FieldInfo[] fields = propInfo.DeclaringType.GetFields(bindingAttr);
		for (int i = 0; i < fields.Length; i++)
		{
			if (fields[i].Name.Contains(value))
			{
				return true;
			}
		}
		return false;
	}

	public static bool IsAliasProperty(this PropertyInfo propertyInfo)
	{
		return propertyInfo is MemberAliasPropertyInfo;
	}

	public static PropertyInfo DeAliasProperty(this PropertyInfo propertyInfo, bool throwOnNotAliased = false)
	{
		MemberAliasPropertyInfo memberAliasPropertyInfo = propertyInfo as MemberAliasPropertyInfo;
		if (memberAliasPropertyInfo != null)
		{
			while (memberAliasPropertyInfo.AliasedProperty is MemberAliasPropertyInfo)
			{
				memberAliasPropertyInfo = memberAliasPropertyInfo.AliasedProperty as MemberAliasPropertyInfo;
			}
			return memberAliasPropertyInfo.AliasedProperty;
		}
		if (throwOnNotAliased)
		{
			throw new ArgumentException("The property " + propertyInfo.GetNiceName() + " was not aliased.");
		}
		return propertyInfo;
	}
}
