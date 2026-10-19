using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Runtime.InteropServices;
using UnityEngine;

namespace Unity.VisualScripting;

public static class ConversionUtility
{
	public enum ConversionType
	{
		Impossible,
		Identity,
		Upcast,
		Downcast,
		NumericImplicit,
		NumericExplicit,
		UserDefinedImplicit,
		UserDefinedExplicit,
		UserDefinedThenNumericImplicit,
		UserDefinedThenNumericExplicit,
		UnityHierarchy,
		EnumerableToArray,
		EnumerableToList,
		ToString
	}

	private struct ConversionQuery(Type source, Type destination) : IEquatable<ConversionQuery>
	{
		public readonly Type source = source;

		public readonly Type destination = destination;

		public bool Equals(ConversionQuery other)
		{
			if (source == other.source)
			{
				return destination == other.destination;
			}
			return false;
		}

		public override bool Equals(object obj)
		{
			if (!(obj is ConversionQuery))
			{
				return false;
			}
			return Equals((ConversionQuery)obj);
		}

		public override int GetHashCode()
		{
			return HashUtility.GetHashCode(source, destination);
		}
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	private struct ConversionQueryComparer : IEqualityComparer<ConversionQuery>
	{
		public bool Equals(ConversionQuery x, ConversionQuery y)
		{
			return x.Equals(y);
		}

		public int GetHashCode(ConversionQuery obj)
		{
			return obj.GetHashCode();
		}
	}

	private const BindingFlags UserDefinedBindingFlags = BindingFlags.Static | BindingFlags.Public;

	private static readonly Dictionary<ConversionQuery, ConversionType> conversionTypesCache = new Dictionary<ConversionQuery, ConversionType>(default(ConversionQueryComparer));

	private static readonly Dictionary<ConversionQuery, MethodInfo[]> userConversionMethodsCache = new Dictionary<ConversionQuery, MethodInfo[]>(default(ConversionQueryComparer));

	private static readonly Dictionary<Type, HashSet<Type>> implicitNumericConversions = new Dictionary<Type, HashSet<Type>>
	{
		{
			typeof(sbyte),
			new HashSet<Type>
			{
				typeof(byte),
				typeof(int),
				typeof(long),
				typeof(float),
				typeof(double),
				typeof(decimal)
			}
		},
		{
			typeof(byte),
			new HashSet<Type>
			{
				typeof(short),
				typeof(ushort),
				typeof(int),
				typeof(uint),
				typeof(long),
				typeof(ulong),
				typeof(float),
				typeof(double),
				typeof(decimal)
			}
		},
		{
			typeof(short),
			new HashSet<Type>
			{
				typeof(int),
				typeof(long),
				typeof(float),
				typeof(double),
				typeof(decimal)
			}
		},
		{
			typeof(ushort),
			new HashSet<Type>
			{
				typeof(int),
				typeof(uint),
				typeof(long),
				typeof(ulong),
				typeof(float),
				typeof(double),
				typeof(decimal)
			}
		},
		{
			typeof(int),
			new HashSet<Type>
			{
				typeof(long),
				typeof(float),
				typeof(double),
				typeof(decimal)
			}
		},
		{
			typeof(uint),
			new HashSet<Type>
			{
				typeof(long),
				typeof(ulong),
				typeof(float),
				typeof(double),
				typeof(decimal)
			}
		},
		{
			typeof(long),
			new HashSet<Type>
			{
				typeof(float),
				typeof(double),
				typeof(decimal)
			}
		},
		{
			typeof(char),
			new HashSet<Type>
			{
				typeof(ushort),
				typeof(int),
				typeof(uint),
				typeof(long),
				typeof(ulong),
				typeof(float),
				typeof(double),
				typeof(decimal)
			}
		},
		{
			typeof(float),
			new HashSet<Type> { typeof(double) }
		},
		{
			typeof(ulong),
			new HashSet<Type>
			{
				typeof(float),
				typeof(double),
				typeof(decimal)
			}
		}
	};

	private static readonly Dictionary<Type, HashSet<Type>> explicitNumericConversions = new Dictionary<Type, HashSet<Type>>
	{
		{
			typeof(sbyte),
			new HashSet<Type>
			{
				typeof(byte),
				typeof(ushort),
				typeof(uint),
				typeof(ulong),
				typeof(char)
			}
		},
		{
			typeof(byte),
			new HashSet<Type>
			{
				typeof(sbyte),
				typeof(char)
			}
		},
		{
			typeof(short),
			new HashSet<Type>
			{
				typeof(sbyte),
				typeof(byte),
				typeof(ushort),
				typeof(uint),
				typeof(ulong),
				typeof(char)
			}
		},
		{
			typeof(ushort),
			new HashSet<Type>
			{
				typeof(sbyte),
				typeof(byte),
				typeof(short),
				typeof(char)
			}
		},
		{
			typeof(int),
			new HashSet<Type>
			{
				typeof(sbyte),
				typeof(byte),
				typeof(short),
				typeof(ushort),
				typeof(uint),
				typeof(ulong),
				typeof(char)
			}
		},
		{
			typeof(uint),
			new HashSet<Type>
			{
				typeof(sbyte),
				typeof(byte),
				typeof(short),
				typeof(ushort),
				typeof(int),
				typeof(char)
			}
		},
		{
			typeof(long),
			new HashSet<Type>
			{
				typeof(sbyte),
				typeof(byte),
				typeof(short),
				typeof(ushort),
				typeof(int),
				typeof(uint),
				typeof(ulong),
				typeof(char)
			}
		},
		{
			typeof(ulong),
			new HashSet<Type>
			{
				typeof(sbyte),
				typeof(byte),
				typeof(short),
				typeof(ushort),
				typeof(int),
				typeof(uint),
				typeof(long),
				typeof(char)
			}
		},
		{
			typeof(char),
			new HashSet<Type>
			{
				typeof(sbyte),
				typeof(byte),
				typeof(short)
			}
		},
		{
			typeof(float),
			new HashSet<Type>
			{
				typeof(sbyte),
				typeof(byte),
				typeof(short),
				typeof(ushort),
				typeof(int),
				typeof(uint),
				typeof(long),
				typeof(ulong),
				typeof(char),
				typeof(decimal)
			}
		},
		{
			typeof(double),
			new HashSet<Type>
			{
				typeof(sbyte),
				typeof(byte),
				typeof(short),
				typeof(ushort),
				typeof(int),
				typeof(uint),
				typeof(long),
				typeof(ulong),
				typeof(char),
				typeof(float),
				typeof(decimal)
			}
		},
		{
			typeof(decimal),
			new HashSet<Type>
			{
				typeof(sbyte),
				typeof(byte),
				typeof(short),
				typeof(ushort),
				typeof(int),
				typeof(uint),
				typeof(long),
				typeof(ulong),
				typeof(char),
				typeof(float),
				typeof(double)
			}
		}
	};

	private static bool RespectsIdentity(Type source, Type destination)
	{
		return source == destination;
	}

	private static bool IsUpcast(Type source, Type destination)
	{
		return destination.IsAssignableFrom(source);
	}

	private static bool IsDowncast(Type source, Type destination)
	{
		return source.IsAssignableFrom(destination);
	}

	private static bool ExpectsString(Type source, Type destination)
	{
		return destination == typeof(string);
	}

	public static bool HasImplicitNumericConversion(Type source, Type destination)
	{
		if (implicitNumericConversions.ContainsKey(source))
		{
			return implicitNumericConversions[source].Contains(destination);
		}
		return false;
	}

	public static bool HasExplicitNumericConversion(Type source, Type destination)
	{
		if (explicitNumericConversions.ContainsKey(source))
		{
			return explicitNumericConversions[source].Contains(destination);
		}
		return false;
	}

	public static bool HasNumericConversion(Type source, Type destination)
	{
		if (!HasImplicitNumericConversion(source, destination))
		{
			return HasExplicitNumericConversion(source, destination);
		}
		return true;
	}

	private static IEnumerable<MethodInfo> FindUserDefinedConversionMethods(ConversionQuery query)
	{
		Type source = query.source;
		Type destination = query.destination;
		IEnumerable<MethodInfo> first = from m in source.GetMethods(BindingFlags.Static | BindingFlags.Public)
			where m.IsUserDefinedConversion()
			select m;
		IEnumerable<MethodInfo> second = from m in destination.GetMethods(BindingFlags.Static | BindingFlags.Public)
			where m.IsUserDefinedConversion()
			select m;
		return from m in first.Concat(second)
			where m.GetParameters()[0].ParameterType.IsAssignableFrom(source) || source.IsAssignableFrom(m.GetParameters()[0].ParameterType)
			select m;
	}

	private static MethodInfo[] GetUserDefinedConversionMethods(Type source, Type destination)
	{
		ConversionQuery conversionQuery = new ConversionQuery(source, destination);
		if (!userConversionMethodsCache.ContainsKey(conversionQuery))
		{
			userConversionMethodsCache.Add(conversionQuery, FindUserDefinedConversionMethods(conversionQuery).ToArray());
		}
		return userConversionMethodsCache[conversionQuery];
	}

	private static ConversionType GetUserDefinedConversionType(Type source, Type destination)
	{
		MethodInfo[] userDefinedConversionMethods = GetUserDefinedConversionMethods(source, destination);
		MethodInfo methodInfo = userDefinedConversionMethods.FirstOrDefault((MethodInfo m) => m.ReturnType == destination);
		if (methodInfo != null)
		{
			if (methodInfo.Name == "op_Implicit")
			{
				return ConversionType.UserDefinedImplicit;
			}
			if (methodInfo.Name == "op_Explicit")
			{
				return ConversionType.UserDefinedExplicit;
			}
		}
		else if (destination.IsPrimitive && destination != typeof(IntPtr) && destination != typeof(UIntPtr))
		{
			methodInfo = userDefinedConversionMethods.FirstOrDefault((MethodInfo m) => HasImplicitNumericConversion(m.ReturnType, destination));
			if (methodInfo != null)
			{
				if (methodInfo.Name == "op_Implicit")
				{
					return ConversionType.UserDefinedThenNumericImplicit;
				}
				if (methodInfo.Name == "op_Explicit")
				{
					return ConversionType.UserDefinedThenNumericExplicit;
				}
			}
			else
			{
				methodInfo = userDefinedConversionMethods.FirstOrDefault((MethodInfo m) => HasExplicitNumericConversion(m.ReturnType, destination));
				if (methodInfo != null)
				{
					return ConversionType.UserDefinedThenNumericExplicit;
				}
			}
		}
		return ConversionType.Impossible;
	}

	private static bool HasEnumerableToArrayConversion(Type source, Type destination)
	{
		if (source != typeof(string) && typeof(IEnumerable).IsAssignableFrom(source) && destination.IsArray)
		{
			return destination.GetArrayRank() == 1;
		}
		return false;
	}

	private static bool HasEnumerableToListConversion(Type source, Type destination)
	{
		if (source != typeof(string) && typeof(IEnumerable).IsAssignableFrom(source) && destination.IsGenericType)
		{
			return destination.GetGenericTypeDefinition() == typeof(List<>);
		}
		return false;
	}

	private static bool HasUnityHierarchyConversion(Type source, Type destination)
	{
		if (destination == typeof(GameObject))
		{
			return typeof(Component).IsAssignableFrom(source);
		}
		if (typeof(Component).IsAssignableFrom(destination) || destination.IsInterface)
		{
			if (!(source == typeof(GameObject)))
			{
				return typeof(Component).IsAssignableFrom(source);
			}
			return true;
		}
		return false;
	}

	private static bool IsValidConversion(ConversionType conversionType, bool guaranteed)
	{
		if (conversionType == ConversionType.Impossible)
		{
			return false;
		}
		if (guaranteed && conversionType == ConversionType.Downcast)
		{
			return false;
		}
		return true;
	}

	public static bool CanConvert(object value, Type type, bool guaranteed)
	{
		return IsValidConversion(GetRequiredConversion(value, type), guaranteed);
	}

	public static bool CanConvert(Type source, Type destination, bool guaranteed)
	{
		return IsValidConversion(GetRequiredConversion(source, destination), guaranteed);
	}

	public static object Convert(object value, Type type)
	{
		return Convert(value, type, GetRequiredConversion(value, type));
	}

	public static T Convert<T>(object value)
	{
		return (T)Convert(value, typeof(T));
	}

	public static bool TryConvert(object value, Type type, out object result, bool guaranteed)
	{
		ConversionType requiredConversion = GetRequiredConversion(value, type);
		if (IsValidConversion(requiredConversion, guaranteed))
		{
			result = Convert(value, type, requiredConversion);
			return true;
		}
		result = value;
		return false;
	}

	public static bool TryConvert<T>(object value, out T result, bool guaranteed)
	{
		if (TryConvert(value, typeof(T), out var result2, guaranteed))
		{
			result = (T)result2;
			return true;
		}
		result = default;
		return false;
	}

	public static bool IsConvertibleTo(this Type source, Type destination, bool guaranteed)
	{
		return CanConvert(source, destination, guaranteed);
	}

	public static bool IsConvertibleTo(this object source, Type type, bool guaranteed)
	{
		return CanConvert(source, type, guaranteed);
	}

	public static bool IsConvertibleTo<T>(this object source, bool guaranteed)
	{
		return CanConvert(source, typeof(T), guaranteed);
	}

	public static object ConvertTo(this object source, Type type)
	{
		return Convert(source, type);
	}

	public static T ConvertTo<T>(this object source)
	{
		return (T)Convert(source, typeof(T));
	}

	public static ConversionType GetRequiredConversion(Type source, Type destination)
	{
		ConversionQuery conversionQuery = new ConversionQuery(source, destination);
		if (!conversionTypesCache.TryGetValue(conversionQuery, out var value))
		{
			value = DetermineConversionType(conversionQuery);
			conversionTypesCache.Add(conversionQuery, value);
		}
		return value;
	}

	private static ConversionType DetermineConversionType(ConversionQuery query)
	{
		Type source = query.source;
		Type destination = query.destination;
		if (source == null)
		{
			if (destination.IsNullable())
			{
				return ConversionType.Identity;
			}
			return ConversionType.Impossible;
		}
		Ensure.That("destination").IsNotNull(destination);
		if (RespectsIdentity(source, destination))
		{
			return ConversionType.Identity;
		}
		if (IsUpcast(source, destination))
		{
			return ConversionType.Upcast;
		}
		if (IsDowncast(source, destination))
		{
			return ConversionType.Downcast;
		}
		if (HasImplicitNumericConversion(source, destination))
		{
			return ConversionType.NumericImplicit;
		}
		if (HasExplicitNumericConversion(source, destination))
		{
			return ConversionType.NumericExplicit;
		}
		if (HasUnityHierarchyConversion(source, destination))
		{
			return ConversionType.UnityHierarchy;
		}
		if (HasEnumerableToArrayConversion(source, destination))
		{
			return ConversionType.EnumerableToArray;
		}
		if (HasEnumerableToListConversion(source, destination))
		{
			return ConversionType.EnumerableToList;
		}
		ConversionType userDefinedConversionType = GetUserDefinedConversionType(source, destination);
		if (userDefinedConversionType != ConversionType.Impossible)
		{
			return userDefinedConversionType;
		}
		return ConversionType.Impossible;
	}

	public static ConversionType GetRequiredConversion(object value, Type type)
	{
		Ensure.That("type").IsNotNull(type);
		return GetRequiredConversion(value?.GetType(), type);
	}

	private static object NumericConversion(object value, Type type)
	{
		return System.Convert.ChangeType(value, type);
	}

	private static object UserDefinedConversion(ConversionType conversion, object value, Type type)
	{
		MethodInfo[] userDefinedConversionMethods = GetUserDefinedConversionMethods(value.GetType(), type);
		bool flag = conversion == ConversionType.UserDefinedThenNumericImplicit || conversion == ConversionType.UserDefinedThenNumericExplicit;
		MethodInfo methodInfo = null;
		if (flag)
		{
			MethodInfo[] array = userDefinedConversionMethods;
			foreach (MethodInfo methodInfo2 in array)
			{
				if (HasNumericConversion(methodInfo2.ReturnType, type))
				{
					methodInfo = methodInfo2;
					break;
				}
			}
		}
		else
		{
			MethodInfo[] array = userDefinedConversionMethods;
			foreach (MethodInfo methodInfo3 in array)
			{
				if (methodInfo3.ReturnType == type)
				{
					methodInfo = methodInfo3;
					break;
				}
			}
		}
		object obj = methodInfo.InvokeOptimized(null, value);
		if (flag)
		{
			obj = NumericConversion(obj, type);
		}
		return obj;
	}

	private static object EnumerableToArrayConversion(object value, Type arrayType)
	{
		Type elementType = arrayType.GetElementType();
		object[] array = ((IEnumerable)value).Cast<object>().Where(elementType.IsAssignableFrom).ToArray();
		Array array2 = Array.CreateInstance(elementType, array.Length);
		array.CopyTo(array2, 0);
		return array2;
	}

	private static object EnumerableToListConversion(object value, Type listType)
	{
		Type type = listType.GetGenericArguments()[0];
		object[] array = ((IEnumerable)value).Cast<object>().Where(type.IsAssignableFrom).ToArray();
		IList list = (IList)Activator.CreateInstance(listType);
		for (int i = 0; i < array.Length; i++)
		{
			list.Add(array[i]);
		}
		return list;
	}

	private static object UnityHierarchyConversion(object value, Type type)
	{
		if (value.IsUnityNull())
		{
			return null;
		}
		if (type == typeof(GameObject) && value is Component)
		{
			return ((Component)value).gameObject;
		}
		if (typeof(Component).IsAssignableFrom(type) || type.IsInterface)
		{
			if (value is Component)
			{
				return ((Component)value).GetComponent(type);
			}
			if (value is GameObject)
			{
				return ((GameObject)value).GetComponent(type);
			}
		}
		throw new InvalidConversionException();
	}

	private static object Convert(object value, Type type, ConversionType conversionType)
	{
		Ensure.That("type").IsNotNull(type);
		if (conversionType == ConversionType.Impossible)
		{
			throw new InvalidConversionException(string.Format("Cannot convert from '{0}' to '{1}'.", value?.GetType().ToString() ?? "null", type));
		}
		try
		{
			switch (conversionType)
			{
			case ConversionType.Identity:
			case ConversionType.Upcast:
			case ConversionType.Downcast:
				return value;
			case ConversionType.ToString:
				return value.ToString();
			case ConversionType.NumericImplicit:
			case ConversionType.NumericExplicit:
				return NumericConversion(value, type);
			case ConversionType.UserDefinedImplicit:
			case ConversionType.UserDefinedExplicit:
			case ConversionType.UserDefinedThenNumericImplicit:
			case ConversionType.UserDefinedThenNumericExplicit:
				return UserDefinedConversion(conversionType, value, type);
			case ConversionType.EnumerableToArray:
				return EnumerableToArrayConversion(value, type);
			case ConversionType.EnumerableToList:
				return EnumerableToListConversion(value, type);
			case ConversionType.UnityHierarchy:
				return UnityHierarchyConversion(value, type);
			default:
				throw new UnexpectedEnumValueException<ConversionType>(conversionType);
			}
		}
		catch (Exception innerException)
		{
			throw new InvalidConversionException(string.Format("Failed to convert from '{0}' to '{1}' via {2}.", value?.GetType().ToString() ?? "null", type, conversionType), innerException);
		}
	}
}
