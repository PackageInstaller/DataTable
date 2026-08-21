using System.Collections.Generic;
using System.Runtime.Versioning;

namespace System;

[Serializable]
[NonVersionable]
public struct Nullable<T>(T value) where T : struct
{
	private readonly bool hasValue = true;

	internal T value = value;

	public bool HasValue
	{
		[NonVersionable]
		get
		{
			return hasValue;
		}
	}

	public T Value
	{
		get
		{
			if (!hasValue)
			{
				ThrowHelper.ThrowInvalidOperationException_InvalidOperation_NoValue();
			}
			return value;
		}
	}

	[NonVersionable]
	public T GetValueOrDefault()
	{
		return value;
	}

	[NonVersionable]
	public T GetValueOrDefault(T defaultValue)
	{
		if (!hasValue)
		{
			return defaultValue;
		}
		return value;
	}

	public override bool Equals(object other)
	{
		if (!hasValue)
		{
			return other == null;
		}
		if (other == null)
		{
			return false;
		}
		return value.Equals(other);
	}

	public override int GetHashCode()
	{
		if (!hasValue)
		{
			return 0;
		}
		return value.GetHashCode();
	}

	public override string ToString()
	{
		if (!hasValue)
		{
			return "";
		}
		return value.ToString();
	}

	[NonVersionable]
	public static implicit operator T?(T value)
	{
		return value;
	}

	[NonVersionable]
	public static explicit operator T(T? value)
	{
		return value.Value;
	}

	private static object Box(T? o)
	{
		if (!o.hasValue)
		{
			return null;
		}
		return o.value;
	}

	private static T? Unbox(object o)
	{
		if (o == null)
		{
			return null;
		}
		return (T)o;
	}

	private static T? UnboxExact(object o)
	{
		if (o == null)
		{
			return null;
		}
		if (o.GetType() != typeof(T))
		{
			throw new InvalidCastException();
		}
		return (T)o;
	}
}
public static class Nullable
{
	public static int Compare<T>(T? n1, T? n2) where T : struct
	{
		if (n1.HasValue)
		{
			if (n2.HasValue)
			{
				return Comparer<T>.Default.Compare(n1.value, n2.value);
			}
			return 1;
		}
		if (n2.HasValue)
		{
			return -1;
		}
		return 0;
	}

	public static bool Equals<T>(T? n1, T? n2) where T : struct
	{
		if (n1.HasValue)
		{
			if (n2.HasValue)
			{
				return EqualityComparer<T>.Default.Equals(n1.value, n2.value);
			}
			return false;
		}
		if (n2.HasValue)
		{
			return false;
		}
		return true;
	}

	public static Type GetUnderlyingType(Type nullableType)
	{
		if ((object)nullableType == null)
		{
			throw new ArgumentNullException("nullableType");
		}
		if (nullableType.IsGenericType && !nullableType.IsGenericTypeDefinition && (object)nullableType.GetGenericTypeDefinition() == typeof(Nullable<>))
		{
			return nullableType.GetGenericArguments()[0];
		}
		return null;
	}
}
