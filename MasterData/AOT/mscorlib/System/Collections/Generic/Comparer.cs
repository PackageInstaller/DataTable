using System.Runtime.CompilerServices;

namespace System.Collections.Generic;

[Serializable]
[TypeDependency("System.Collections.Generic.ObjectComparer`1")]
public abstract class Comparer<T> : IComparer, IComparer<T>
{
	private static volatile Comparer<T> defaultComparer;

	public static Comparer<T> Default
	{
		get
		{
			Comparer<T> comparer = defaultComparer;
			if (comparer == null)
			{
				comparer = (defaultComparer = CreateComparer());
			}
			return comparer;
		}
	}

	public static Comparer<T> Create(Comparison<T> comparison)
	{
		if (comparison == null)
		{
			throw new ArgumentNullException("comparison");
		}
		return new ComparisonComparer<T>(comparison);
	}

	private static Comparer<T> CreateComparer()
	{
		RuntimeType runtimeType = (RuntimeType)typeof(T);
		if (typeof(IComparable<T>).IsAssignableFrom(runtimeType))
		{
			return (Comparer<T>)RuntimeType.CreateInstanceForAnotherGenericParameter(typeof(GenericComparer<>), runtimeType);
		}
		if (runtimeType.IsGenericType && runtimeType.GetGenericTypeDefinition() == typeof(Nullable<>))
		{
			RuntimeType runtimeType2 = (RuntimeType)runtimeType.GetGenericArguments()[0];
			if (typeof(IComparable<>).MakeGenericType(runtimeType2).IsAssignableFrom(runtimeType2))
			{
				return (Comparer<T>)RuntimeType.CreateInstanceForAnotherGenericParameter(typeof(NullableComparer<>), runtimeType2);
			}
		}
		return new ObjectComparer<T>();
	}

	public abstract int Compare(T x, T y);

	int IComparer.Compare(object x, object y)
	{
		if (x == null)
		{
			if (y != null)
			{
				return -1;
			}
			return 0;
		}
		if (y == null)
		{
			return 1;
		}
		if (x is T && y is T)
		{
			return Compare((T)x, (T)y);
		}
		ThrowHelper.ThrowArgumentException(ExceptionResource.Argument_InvalidArgumentForComparison);
		return 0;
	}
}
