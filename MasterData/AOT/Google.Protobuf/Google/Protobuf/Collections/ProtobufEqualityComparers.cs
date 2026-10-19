using System;
using System.Collections.Generic;

namespace Google.Protobuf.Collections;

public static class ProtobufEqualityComparers
{
	private class BitwiseDoubleEqualityComparerImpl : EqualityComparer<double>
	{
		public override bool Equals(double x, double y)
		{
			return BitConverter.DoubleToInt64Bits(x) == BitConverter.DoubleToInt64Bits(y);
		}

		public override int GetHashCode(double obj)
		{
			return BitConverter.DoubleToInt64Bits(obj).GetHashCode();
		}
	}

	private class BitwiseSingleEqualityComparerImpl : EqualityComparer<float>
	{
		public override bool Equals(float x, float y)
		{
			return BitConverter.DoubleToInt64Bits(x) == BitConverter.DoubleToInt64Bits(y);
		}

		public override int GetHashCode(float obj)
		{
			return BitConverter.DoubleToInt64Bits(obj).GetHashCode();
		}
	}

	private class BitwiseNullableDoubleEqualityComparerImpl : EqualityComparer<double?>
	{
		public override bool Equals(double? x, double? y)
		{
			if (x.HasValue || y.HasValue)
			{
				if (x.HasValue && y.HasValue)
				{
					return BitwiseDoubleEqualityComparer.Equals(x.Value, y.Value);
				}
				return false;
			}
			return true;
		}

		public override int GetHashCode(double? obj)
		{
			if (obj.HasValue)
			{
				return BitwiseDoubleEqualityComparer.GetHashCode(obj.Value);
			}
			return 293864;
		}
	}

	private class BitwiseNullableSingleEqualityComparerImpl : EqualityComparer<float?>
	{
		public override bool Equals(float? x, float? y)
		{
			if (x.HasValue || y.HasValue)
			{
				if (x.HasValue && y.HasValue)
				{
					return BitwiseSingleEqualityComparer.Equals(x.Value, y.Value);
				}
				return false;
			}
			return true;
		}

		public override int GetHashCode(float? obj)
		{
			if (obj.HasValue)
			{
				return BitwiseSingleEqualityComparer.GetHashCode(obj.Value);
			}
			return 293864;
		}
	}

	public static EqualityComparer<double> BitwiseDoubleEqualityComparer { get; } = new BitwiseDoubleEqualityComparerImpl();

	public static EqualityComparer<float> BitwiseSingleEqualityComparer { get; } = new BitwiseSingleEqualityComparerImpl();

	public static EqualityComparer<double?> BitwiseNullableDoubleEqualityComparer { get; } = new BitwiseNullableDoubleEqualityComparerImpl();

	public static EqualityComparer<float?> BitwiseNullableSingleEqualityComparer { get; } = new BitwiseNullableSingleEqualityComparerImpl();

	public static EqualityComparer<T> GetEqualityComparer<T>()
	{
		if (!(typeof(T) == typeof(double)))
		{
			if (!(typeof(T) == typeof(float)))
			{
				if (!(typeof(T) == typeof(double?)))
				{
					if (!(typeof(T) == typeof(float?)))
					{
						return EqualityComparer<T>.Default;
					}
					return (EqualityComparer<T>)(object)BitwiseNullableSingleEqualityComparer;
				}
				return (EqualityComparer<T>)(object)BitwiseNullableDoubleEqualityComparer;
			}
			return (EqualityComparer<T>)(object)BitwiseSingleEqualityComparer;
		}
		return (EqualityComparer<T>)(object)BitwiseDoubleEqualityComparer;
	}
}
