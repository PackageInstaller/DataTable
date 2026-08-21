using System;
using System.Reflection;

namespace GameFramework.Runtime;

public static class TypeExtensions
{
	public static bool IsSubclassOfGenericTypeDefinition(this Type type, Type genericTypeDefinition)
	{
		if (!genericTypeDefinition.IsGenericTypeDefinition)
		{
			return false;
		}
		if (type.IsGenericType && type.GetGenericTypeDefinition().Equals(genericTypeDefinition))
		{
			return true;
		}
		Type baseType = type.BaseType;
		if (baseType != null && baseType != typeof(object) && baseType.IsSubclassOfGenericTypeDefinition(genericTypeDefinition))
		{
			return true;
		}
		Type[] interfaces = type.GetInterfaces();
		foreach (Type type2 in interfaces)
		{
			if (type2.IsSubclassOfGenericTypeDefinition(genericTypeDefinition))
			{
				return true;
			}
		}
		return false;
	}

	public static object CreateDefault(this Type type)
	{
		if (type == null)
		{
			return null;
		}
		if (type.Equals(typeof(string)))
		{
			return "";
		}
		if (!type.IsValueType)
		{
			return null;
		}
		if (Nullable.GetUnderlyingType(type) != null)
		{
			return null;
		}
		return Activator.CreateInstance(type);
	}

	public static bool IsStatic(this MemberInfo info)
	{
		FieldInfo fieldInfo = info as FieldInfo;
		if (fieldInfo != null)
		{
			return fieldInfo.IsStatic;
		}
		PropertyInfo propertyInfo = info as PropertyInfo;
		if (propertyInfo != null)
		{
			MethodInfo getMethod = propertyInfo.GetGetMethod();
			if (getMethod != null)
			{
				return getMethod.IsStatic;
			}
			getMethod = propertyInfo.GetSetMethod();
			if (getMethod != null)
			{
				return getMethod.IsStatic;
			}
		}
		MethodInfo methodInfo = info as MethodInfo;
		if (methodInfo != null)
		{
			return methodInfo.IsStatic;
		}
		EventInfo eventInfo = info as EventInfo;
		if (eventInfo != null)
		{
			MethodInfo addMethod = eventInfo.GetAddMethod();
			if (addMethod != null)
			{
				return addMethod.IsStatic;
			}
			addMethod = eventInfo.GetRemoveMethod();
			if (addMethod != null)
			{
				return addMethod.IsStatic;
			}
		}
		return false;
	}

	public static object ToSafe(this Type type, object value)
	{
		if (value == null)
		{
			return type.CreateDefault();
		}
		object obj = value;
		try
		{
			if (!type.IsInstanceOfType(value))
			{
				if (value is IObservableProperty)
				{
					obj = (value as IObservableProperty).Value;
					if (!type.IsInstanceOfType(obj))
					{
						obj = ChangeType(obj, type);
					}
				}
				else if (type == typeof(string))
				{
					obj = value.ToString();
				}
				else if (type.IsEnum)
				{
					obj = ((value is string value2) ? Enum.Parse(type, value2, ignoreCase: true) : Enum.ToObject(type, value));
				}
				else if (type.IsValueType)
				{
					Type type2 = Nullable.GetUnderlyingType(type) ?? type;
					obj = ((type2 == typeof(bool)) ? ((object)ConvertToBoolean(value)) : ChangeType(value, type2));
				}
				else
				{
					obj = ChangeType(value, type);
				}
			}
		}
		catch (Exception)
		{
		}
		return obj;
	}

	private static bool ConvertToBoolean(object result)
	{
		if (result == null)
		{
			return false;
		}
		if (result is string text)
		{
			return text.ToLower().Equals("true");
		}
		if (!(result is bool result2))
		{
			Type type = result.GetType();
			if (type.IsValueType)
			{
				Type type2 = Nullable.GetUnderlyingType(type) ?? type;
				return !result.Equals(type2.CreateDefault());
			}
			return true;
		}
		return result2;
	}

	private static object ChangeType(object value, Type type)
	{
		try
		{
			return Convert.ChangeType(value, type);
		}
		catch (Exception)
		{
			return value;
		}
	}
}
