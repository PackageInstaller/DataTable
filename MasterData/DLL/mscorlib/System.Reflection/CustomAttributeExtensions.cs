using System.Collections.Generic;

namespace System.Reflection;

public static class CustomAttributeExtensions
{
	public static Attribute GetCustomAttribute(this Assembly element, Type attributeType)
	{
		return Attribute.GetCustomAttribute(element, attributeType);
	}

	public static Attribute GetCustomAttribute(this MemberInfo element, Type attributeType)
	{
		return Attribute.GetCustomAttribute(element, attributeType);
	}

	public static T GetCustomAttribute<T>(this Assembly element) where T : Attribute
	{
		return (T)element.GetCustomAttribute(typeof(T));
	}

	public static T GetCustomAttribute<T>(this MemberInfo element) where T : Attribute
	{
		return (T)element.GetCustomAttribute(typeof(T));
	}

	public static Attribute GetCustomAttribute(this MemberInfo element, Type attributeType, bool inherit)
	{
		return Attribute.GetCustomAttribute(element, attributeType, inherit);
	}

	public static T GetCustomAttribute<T>(this MemberInfo element, bool inherit) where T : Attribute
	{
		return (T)element.GetCustomAttribute(typeof(T), inherit);
	}

	public static IEnumerable<Attribute> GetCustomAttributes(this Assembly element)
	{
		return Attribute.GetCustomAttributes(element);
	}

	public static IEnumerable<Attribute> GetCustomAttributes(this MemberInfo element)
	{
		return Attribute.GetCustomAttributes(element);
	}

	public static IEnumerable<Attribute> GetCustomAttributes(this MemberInfo element, Type attributeType)
	{
		return Attribute.GetCustomAttributes(element, attributeType);
	}

	public static IEnumerable<T> GetCustomAttributes<T>(this MemberInfo element) where T : Attribute
	{
		return (IEnumerable<T>)element.GetCustomAttributes(typeof(T));
	}

	public static bool IsDefined(this MemberInfo element, Type attributeType)
	{
		return Attribute.IsDefined(element, attributeType);
	}
}
