using System.Runtime.CompilerServices;

namespace System.Collections.Generic;

[Serializable]
[TypeDependency("System.Collections.Generic.ObjectEqualityComparer`1")]
public abstract class EqualityComparer<T> : IEqualityComparer, IEqualityComparer<T>
{
	private static volatile EqualityComparer<T> defaultComparer;

	public static EqualityComparer<T> Default
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			EqualityComparer<T> equalityComparer = defaultComparer;
			if (equalityComparer == null)
			{
				equalityComparer = (defaultComparer = CreateComparer());
			}
			return equalityComparer;
		}
	}

	private static EqualityComparer<T> CreateComparer()
	{
		RuntimeType runtimeType = (RuntimeType)typeof(T);
		if (runtimeType == typeof(byte))
		{
			return (EqualityComparer<T>)(object)new ByteEqualityComparer();
		}
		if (runtimeType == typeof(string))
		{
			return (EqualityComparer<T>)(object)new InternalStringComparer();
		}
		if (typeof(IEquatable<T>).IsAssignableFrom(runtimeType))
		{
			return (EqualityComparer<T>)RuntimeType.CreateInstanceForAnotherGenericParameter(typeof(GenericEqualityComparer<>), runtimeType);
		}
		if (runtimeType.IsGenericType && runtimeType.GetGenericTypeDefinition() == typeof(Nullable<>))
		{
			RuntimeType runtimeType2 = (RuntimeType)runtimeType.GetGenericArguments()[0];
			if (typeof(IEquatable<>).MakeGenericType(runtimeType2).IsAssignableFrom(runtimeType2))
			{
				return (EqualityComparer<T>)RuntimeType.CreateInstanceForAnotherGenericParameter(typeof(NullableEqualityComparer<>), runtimeType2);
			}
		}
		if (runtimeType.IsEnum)
		{
			switch (Type.GetTypeCode(Enum.GetUnderlyingType(runtimeType)))
			{
			case TypeCode.Int16:
				return (EqualityComparer<T>)RuntimeType.CreateInstanceForAnotherGenericParameter(typeof(ShortEnumEqualityComparer<>), runtimeType);
			case TypeCode.SByte:
				return (EqualityComparer<T>)RuntimeType.CreateInstanceForAnotherGenericParameter(typeof(SByteEnumEqualityComparer<>), runtimeType);
			case TypeCode.Byte:
			case TypeCode.UInt16:
			case TypeCode.Int32:
			case TypeCode.UInt32:
				return (EqualityComparer<T>)RuntimeType.CreateInstanceForAnotherGenericParameter(typeof(EnumEqualityComparer<>), runtimeType);
			case TypeCode.Int64:
			case TypeCode.UInt64:
				return (EqualityComparer<T>)RuntimeType.CreateInstanceForAnotherGenericParameter(typeof(LongEnumEqualityComparer<>), runtimeType);
			}
		}
		return new ObjectEqualityComparer<T>();
	}

	public abstract bool Equals(T x, T y);

	public abstract int GetHashCode(T obj);

	internal virtual int IndexOf(T[] array, T value, int startIndex, int count)
	{
		int num = startIndex + count;
		for (int i = startIndex; i < num; i++)
		{
			if (Equals(array[i], value))
			{
				return i;
			}
		}
		return -1;
	}

	internal virtual int LastIndexOf(T[] array, T value, int startIndex, int count)
	{
		int num = startIndex - count + 1;
		for (int num2 = startIndex; num2 >= num; num2--)
		{
			if (Equals(array[num2], value))
			{
				return num2;
			}
		}
		return -1;
	}

	int IEqualityComparer.GetHashCode(object obj)
	{
		if (obj == null)
		{
			return 0;
		}
		if (obj is T)
		{
			return GetHashCode((T)obj);
		}
		ThrowHelper.ThrowArgumentException(ExceptionResource.Argument_InvalidArgumentForComparison);
		return 0;
	}

	bool IEqualityComparer.Equals(object x, object y)
	{
		if (x == y)
		{
			return true;
		}
		if (x == null || y == null)
		{
			return false;
		}
		if (x is T && y is T)
		{
			return Equals((T)x, (T)y);
		}
		ThrowHelper.ThrowArgumentException(ExceptionResource.Argument_InvalidArgumentForComparison);
		return false;
	}
}
