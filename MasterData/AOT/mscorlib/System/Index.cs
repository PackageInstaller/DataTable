using System.Runtime.CompilerServices;

namespace System;

public readonly struct Index : IEquatable<Index>
{
	private readonly int _value;

	public static Index Start => new Index(0);

	public int Value
	{
		get
		{
			if (_value < 0)
			{
				return ~_value;
			}
			return _value;
		}
	}

	public bool IsFromEnd => _value < 0;

	private Index(int value)
	{
		_value = value;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static Index FromStart(int value)
	{
		if (value < 0)
		{
			ThrowHelper.ThrowValueArgumentOutOfRange_NeedNonNegNumException();
		}
		return new Index(value);
	}

	[MethodImpl((MethodImplOptions)256)]
	public int GetOffset(int length)
	{
		if (IsFromEnd)
		{
			return length - ~_value;
		}
		return _value;
	}

	public override bool Equals(object value)
	{
		if (value is Index)
		{
			return _value == ((Index)value)._value;
		}
		return false;
	}

	public bool Equals(Index other)
	{
		return _value == other._value;
	}

	public override int GetHashCode()
	{
		return _value;
	}

	public static implicit operator Index(int value)
	{
		return FromStart(value);
	}

	public override string ToString()
	{
		if (IsFromEnd)
		{
			return ToStringFromEnd();
		}
		return ((uint)Value).ToString();
	}

	private string ToStringFromEnd()
	{
		Span<char> span = stackalloc char[11];
		((uint)Value).TryFormat(span.Slice(1), out var charsWritten);
		span[0] = '^';
		return new string(span.Slice(0, charsWritten + 1));
	}
}
