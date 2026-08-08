using System;
using UnityEngine;

namespace ParadoxNotion;

public static class TypeConverter
{
	public static Func<object, object> Get(Type fromType, Type toType)
	{
		if (toType.RTIsAssignableFrom(fromType))
		{
			return (object value) => value;
		}
		if (toType == typeof(string))
		{
			return (object value) => (value == null) ? "NULL" : value.ToString();
		}
		if (typeof(IConvertible).RTIsAssignableFrom(toType) && typeof(IConvertible).RTIsAssignableFrom(fromType))
		{
			return delegate(object value)
			{
				try
				{
					return Convert.ChangeType(value, toType);
				}
				catch
				{
					return (!toType.RTIsAbstract()) ? Activator.CreateInstance(toType) : null;
				}
			};
		}
		if (typeof(UnityEngine.Object).RTIsAssignableFrom(fromType) && toType == typeof(bool))
		{
			return (object value) => value != null;
		}
		if (fromType == typeof(GameObject) && typeof(Component).RTIsAssignableFrom(toType))
		{
			return (object value) => (!(value is GameObject)) ? null : (value as GameObject).GetComponent(toType);
		}
		if (typeof(Component).RTIsAssignableFrom(fromType) && toType == typeof(GameObject))
		{
			return (object value) => (!(value is Component)) ? null : (value as Component).gameObject;
		}
		if (typeof(Component).RTIsAssignableFrom(fromType) && typeof(Component).RTIsAssignableFrom(toType))
		{
			return (object value) => (!(value is Component)) ? null : (value as Component).gameObject.GetComponent(toType);
		}
		if (fromType == typeof(GameObject) && toType.RTIsInterface())
		{
			return (object value) => (!(value is GameObject)) ? null : (value as GameObject).GetComponent(toType);
		}
		if (typeof(Component).RTIsAssignableFrom(fromType) && toType.RTIsInterface())
		{
			return (object value) => (!(value is Component)) ? null : (value as Component).gameObject.GetComponent(toType);
		}
		if (fromType == typeof(GameObject) && toType == typeof(Vector3))
		{
			return (object value) => (value is GameObject) ? (value as GameObject).transform.position : Vector3.zero;
		}
		if (typeof(Component).RTIsAssignableFrom(fromType) && toType == typeof(Vector3))
		{
			return (object value) => (value is Component) ? (value as Component).transform.position : Vector3.zero;
		}
		if (fromType == typeof(GameObject) && toType == typeof(Quaternion))
		{
			return (object value) => (value is GameObject) ? (value as GameObject).transform.rotation : Quaternion.identity;
		}
		if (typeof(Component).RTIsAssignableFrom(fromType) && toType == typeof(Quaternion))
		{
			return (object value) => (value is Component) ? (value as Component).transform.rotation : Quaternion.identity;
		}
		if (fromType == typeof(Quaternion) && toType == typeof(Vector3))
		{
			return (object value) => ((Quaternion)value).eulerAngles;
		}
		if (fromType == typeof(Vector3) && toType == typeof(Quaternion))
		{
			return (object value) => Quaternion.Euler((Vector3)value);
		}
		if (fromType == typeof(Vector2) && toType == typeof(Vector3))
		{
			return (object value) => (Vector3)(Vector2)value;
		}
		if (fromType == typeof(Vector3) && toType == typeof(Vector2))
		{
			return (object value) => (Vector2)(Vector3)value;
		}
		return null;
	}

	public static bool CanConvert(Type fromType, Type toType)
	{
		return Get(fromType, toType) != null;
	}
}
