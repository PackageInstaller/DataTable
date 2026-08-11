using System.Runtime.CompilerServices;

namespace System;

public readonly struct Range : IEquatable<Range>
{
	public Index Start { get; }

	public Index End { get; }

	public override bool Equals(object value)
	{
		if (value is Range { Start: var start } range)
		{
			if (start.Equals(Start))
			{
				return range.End.Equals(End);
			}
			return false;
		}
		return false;
	}

	public bool Equals(Range other)
	{
		if (other.Start.Equals(Start))
		{
			return other.End.Equals(End);
		}
		return false;
	}

	public override int GetHashCode()
	{
		return HashCode.Combine(Start.GetHashCode(), End.GetHashCode());
	}

	public override string ToString()
	{
		Span<char> span = stackalloc char[24];
		int num = 0;
		if (Start.IsFromEnd)
		{
			span[0] = '^';
			num = 1;
		}
		((uint)Start.Value).TryFormat(span.Slice(num), out var charsWritten);
		num += charsWritten;
		span[num++] = '.';
		span[num++] = '.';
		if (End.IsFromEnd)
		{
			span[num++] = '^';
		}
		((uint)End.Value).TryFormat(span.Slice(num), out charsWritten);
		num += charsWritten;
		return new string(span.Slice(0, num));
	}

	[MethodImpl((MethodImplOptions)256)]
	public (int Offset, int Length) GetOffsetAndLength(int length)
	{
		Index start = Start;
		int num = ((!start.IsFromEnd) ? start.Value : (length - start.Value));
		Index end = End;
		int num2 = ((!end.IsFromEnd) ? end.Value : (length - end.Value));
		if ((uint)num2 > (uint)length || (uint)num > (uint)num2)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.length);
		}
		return (Offset: num, Length: num2 - num);
	}
}
