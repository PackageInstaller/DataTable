using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using ParadoxNotion;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas;

[SpoofAOT]
public static class TypeConverter
{
	public static ValueHandler<T> GetConverterFuncFromTo<T>(Type sourceType, Type targetType, ValueHandler<object> func)
	{
		if (targetType.RTIsAssignableFrom(sourceType) || targetType.RTIsSubclassOf(sourceType))
		{
			return () => (T)func();
		}
		if (typeof(IConvertible).RTIsAssignableFrom(targetType) && typeof(IConvertible).RTIsAssignableFrom(sourceType))
		{
			return () => (T)Convert.ChangeType(func(), targetType);
		}
		UnaryExpression exp = null;
		if (ReflectionTools.CanConvert(sourceType, targetType, out exp))
		{
			return delegate
			{
				try
				{
					return (T)exp.Method.Invoke(null, new object[1] { func() });
				}
				catch
				{
					return default(T);
				}
			};
		}
		if (targetType == typeof(string))
		{
			return delegate
			{
				try
				{
					return (T)(object)func().ToString();
				}
				catch
				{
					return default(T);
				}
			};
		}
		if (targetType == typeof(Type))
		{
			return delegate
			{
				try
				{
					return (T)(object)func().GetType();
				}
				catch
				{
					return default(T);
				}
			};
		}
		if (targetType == typeof(Vector3) && typeof(IConvertible).RTIsAssignableFrom(sourceType))
		{
			return delegate
			{
				float num = (float)Convert.ChangeType(func(), typeof(float));
				return (T)(object)new Vector3(num, num, num);
			};
		}
		if (targetType == typeof(Vector3) && typeof(Component).RTIsAssignableFrom(sourceType))
		{
			return delegate
			{
				try
				{
					return (T)(object)(func() as Component).transform.position;
				}
				catch
				{
					return default(T);
				}
			};
		}
		if (targetType == typeof(Vector3) && sourceType == typeof(GameObject))
		{
			return delegate
			{
				try
				{
					return (T)(object)(func() as GameObject).transform.position;
				}
				catch
				{
					return default(T);
				}
			};
		}
		if (targetType == typeof(Quaternion) && typeof(Component).RTIsAssignableFrom(sourceType))
		{
			return delegate
			{
				try
				{
					return (T)(object)(func() as Component).transform.rotation;
				}
				catch
				{
					return default(T);
				}
			};
		}
		if (targetType == typeof(Quaternion) && sourceType == typeof(GameObject))
		{
			return delegate
			{
				try
				{
					return (T)(object)(func() as GameObject).transform.rotation;
				}
				catch
				{
					return default(T);
				}
			};
		}
		if (typeof(Component).RTIsAssignableFrom(targetType) && typeof(Component).RTIsAssignableFrom(sourceType))
		{
			return delegate
			{
				try
				{
					return (T)(object)(func() as Component).GetComponent(targetType);
				}
				catch
				{
					return default(T);
				}
			};
		}
		if (typeof(Component).RTIsAssignableFrom(targetType) && sourceType == typeof(GameObject))
		{
			return delegate
			{
				try
				{
					return (T)(object)(func() as GameObject).GetComponent(targetType);
				}
				catch
				{
					return default(T);
				}
			};
		}
		if (targetType == typeof(GameObject) && typeof(Component).RTIsAssignableFrom(sourceType))
		{
			return delegate
			{
				try
				{
					return (T)(object)(func() as Component).gameObject;
				}
				catch
				{
					return default(T);
				}
			};
		}
		if (typeof(IEnumerable).RTIsAssignableFrom(sourceType) && typeof(IEnumerable).RTIsAssignableFrom(targetType))
		{
			try
			{
				Type other = (sourceType.RTIsArray() ? sourceType.GetElementType() : sourceType.GetGenericArguments().Single());
				Type type = (targetType.RTIsArray() ? targetType.GetElementType() : targetType.GetGenericArguments().Single());
				if (type.RTIsAssignableFrom(other))
				{
					Type listType = typeof(List<>).RTMakeGenericType(type);
					return delegate
					{
						IList list = (IList)Activator.CreateInstance(listType);
						foreach (object item in (IEnumerable)func())
						{
							list.Add(item);
						}
						return (T)list;
					};
				}
			}
			catch
			{
				return null;
			}
		}
		return null;
	}

	public static bool HasConvertion(Type sourceType, Type targetType)
	{
		if (sourceType == typeof(Flow) && sourceType != targetType)
		{
			return false;
		}
		return GetConverterFuncFromTo<object>(sourceType, targetType, null) != null;
	}

	public static T QuickConvert<T>(object obj)
	{
		return (T)QuickConvert(obj, typeof(T));
	}

	public static object QuickConvert(object obj, Type type)
	{
		if (obj == null || type == null)
		{
			return null;
		}
		return GetConverterFuncFromTo<object>(obj.GetType(), type, () => obj)();
	}
}
