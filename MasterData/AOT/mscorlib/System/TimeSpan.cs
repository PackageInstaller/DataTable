using System.Globalization;

namespace System;

[Serializable]
public readonly struct TimeSpan : IComparable, IComparable<TimeSpan>, IEquatable<TimeSpan>, IFormattable, ISpanFormattable
{
	public const long TicksPerMillisecond = 10000L;

	private const double MillisecondsPerTick = 0.0001;

	public const long TicksPerSecond = 10000000L;

	private const double SecondsPerTick = 1E-07;

	public const long TicksPerMinute = 600000000L;

	private const double MinutesPerTick = 1.6666666666666667E-09;

	public const long TicksPerHour = 36000000000L;

	private const double HoursPerTick = 2.7777777777777777E-11;

	public const long TicksPerDay = 864000000000L;

	private const double DaysPerTick = 1.1574074074074074E-12;

	private const int MillisPerSecond = 1000;

	private const int MillisPerMinute = 60000;

	private const int MillisPerHour = 3600000;

	private const int MillisPerDay = 86400000;

	internal const long MaxSeconds = 922337203685L;

	internal const long MinSeconds = -922337203685L;

	internal const long MaxMilliSeconds = 922337203685477L;

	internal const long MinMilliSeconds = -922337203685477L;

	internal const long TicksPerTenthSecond = 1000000L;

	public static readonly TimeSpan Zero = new TimeSpan(0L);

	public static readonly TimeSpan MaxValue = new TimeSpan(long.MaxValue);

	public static readonly TimeSpan MinValue = new TimeSpan(long.MinValue);

	internal readonly long _ticks;

	public long Ticks => _ticks;

	public int Days => (int)(_ticks / 864000000000L);

	public int Hours => (int)(_ticks / 36000000000L % 24);

	public int Milliseconds => (int)(_ticks / 10000 % 1000);

	public int Minutes => (int)(_ticks / 600000000 % 60);

	public int Seconds => (int)(_ticks / 10000000 % 60);

	public double TotalDays => (double)_ticks * 1.1574074074074074E-12;

	public double TotalHours => (double)_ticks * 2.7777777777777777E-11;

	public double TotalMilliseconds
	{
		get
		{
			double num = (double)_ticks * 0.0001;
			if (num > 922337203685477.0)
			{
				return 922337203685477.0;
			}
			if (num < -922337203685477.0)
			{
				return -922337203685477.0;
			}
			return num;
		}
	}

	public double TotalMinutes => (double)_ticks * 1.6666666666666667E-09;

	public double TotalSeconds => (double)_ticks * 1E-07;

	public TimeSpan(long ticks)
	{
		_ticks = ticks;
	}

	public TimeSpan(int hours, int minutes, int seconds)
	{
		_ticks = TimeToTicks(hours, minutes, seconds);
	}

	public TimeSpan(int days, int hours, int minutes, int seconds)
		: this(days, hours, minutes, seconds, 0)
	{
	}

	public TimeSpan(int days, int hours, int minutes, int seconds, int milliseconds)
	{
		long num = ((long)days * 3600L * 24 + (long)hours * 3600L + (long)minutes * 60L + seconds) * 1000 + milliseconds;
		if (num > 922337203685477L || num < -922337203685477L)
		{
			throw new ArgumentOutOfRangeException(null, "TimeSpan overflowed because the duration is too long.");
		}
		_ticks = num * 10000;
	}

	public TimeSpan Add(TimeSpan ts)
	{
		long num = _ticks + ts._ticks;
		if (_ticks >> 63 == ts._ticks >> 63 && _ticks >> 63 != num >> 63)
		{
			throw new OverflowException("TimeSpan overflowed because the duration is too long.");
		}
		return new TimeSpan(num);
	}

	public static int Compare(TimeSpan t1, TimeSpan t2)
	{
		if (t1._ticks > t2._ticks)
		{
			return 1;
		}
		if (t1._ticks < t2._ticks)
		{
			return -1;
		}
		return 0;
	}

	public int CompareTo(object value)
	{
		if (value == null)
		{
			return 1;
		}
		if (!(value is TimeSpan))
		{
			throw new ArgumentException("Object must be of type TimeSpan.");
		}
		long ticks = ((TimeSpan)value)._ticks;
		if (_ticks > ticks)
		{
			return 1;
		}
		if (_ticks < ticks)
		{
			return -1;
		}
		return 0;
	}

	public int CompareTo(TimeSpan value)
	{
		long ticks = value._ticks;
		if (_ticks > ticks)
		{
			return 1;
		}
		if (_ticks < ticks)
		{
			return -1;
		}
		return 0;
	}

	public static TimeSpan FromDays(double value)
	{
		return Interval(value, 86400000);
	}

	public TimeSpan Duration()
	{
		if (Ticks == MinValue.Ticks)
		{
			throw new OverflowException("The duration cannot be returned for TimeSpan.MinValue because the absolute value of TimeSpan.MinValue exceeds the value of TimeSpan.MaxValue.");
		}
		return new TimeSpan((_ticks >= 0) ? _ticks : (-_ticks));
	}

	public override bool Equals(object value)
	{
		if (value is TimeSpan)
		{
			return _ticks == ((TimeSpan)value)._ticks;
		}
		return false;
	}

	public bool Equals(TimeSpan obj)
	{
		return _ticks == obj._ticks;
	}

	public static bool Equals(TimeSpan t1, TimeSpan t2)
	{
		return t1._ticks == t2._ticks;
	}

	public override int GetHashCode()
	{
		return (int)_ticks ^ (int)(_ticks >> 32);
	}

	public static TimeSpan FromHours(double value)
	{
		return Interval(value, 3600000);
	}

	private static TimeSpan Interval(double value, int scale)
	{
		if (double.IsNaN(value))
		{
			throw new ArgumentException("TimeSpan does not accept floating point Not-a-Number values.");
		}
		double num = value * (double)scale + ((value >= 0.0) ? 0.5 : (-0.5));
		if (num > 922337203685477.0 || num < -922337203685477.0)
		{
			throw new OverflowException("TimeSpan overflowed because the duration is too long.");
		}
		return new TimeSpan((long)num * 10000);
	}

	public static TimeSpan FromMilliseconds(double value)
	{
		return Interval(value, 1);
	}

	public static TimeSpan FromMinutes(double value)
	{
		return Interval(value, 60000);
	}

	public TimeSpan Negate()
	{
		if (Ticks == MinValue.Ticks)
		{
			throw new OverflowException("Negating the minimum value of a twos complement number is invalid.");
		}
		return new TimeSpan(-_ticks);
	}

	public static TimeSpan FromSeconds(double value)
	{
		return Interval(value, 1000);
	}

	public TimeSpan Subtract(TimeSpan ts)
	{
		long num = _ticks - ts._ticks;
		if (_ticks >> 63 != ts._ticks >> 63 && _ticks >> 63 != num >> 63)
		{
			throw new OverflowException("TimeSpan overflowed because the duration is too long.");
		}
		return new TimeSpan(num);
	}

	public TimeSpan Multiply(double factor)
	{
		return this * factor;
	}

	public TimeSpan Divide(double divisor)
	{
		return this / divisor;
	}

	public double Divide(TimeSpan ts)
	{
		return this / ts;
	}

	public static TimeSpan FromTicks(long value)
	{
		return new TimeSpan(value);
	}

	internal static long TimeToTicks(int hour, int minute, int second)
	{
		long num = (long)hour * 3600L + (long)minute * 60L + second;
		if (num > 922337203685L || num < -922337203685L)
		{
			throw new ArgumentOutOfRangeException(null, "TimeSpan overflowed because the duration is too long.");
		}
		return num * 10000000;
	}

	private static void ValidateStyles(TimeSpanStyles style, string parameterName)
	{
		if (style != TimeSpanStyles.None && style != TimeSpanStyles.AssumeNegative)
		{
			throw new ArgumentException("An undefined TimeSpanStyles value is being used.", parameterName);
		}
	}

	public static TimeSpan Parse(string s)
	{
		if (s == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.input);
		}
		return TimeSpanParse.Parse(s, null);
	}

	public static TimeSpan Parse(string input, IFormatProvider formatProvider)
	{
		if (input == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.input);
		}
		return TimeSpanParse.Parse(input, formatProvider);
	}

	public static TimeSpan Parse(ReadOnlySpan<char> input, IFormatProvider formatProvider = null)
	{
		return TimeSpanParse.Parse(input, formatProvider);
	}

	public static TimeSpan ParseExact(string input, string format, IFormatProvider formatProvider)
	{
		if (input == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.input);
		}
		if (format == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.format);
		}
		return TimeSpanParse.ParseExact(input, format, formatProvider, TimeSpanStyles.None);
	}

	public static TimeSpan ParseExact(string input, string[] formats, IFormatProvider formatProvider)
	{
		if (input == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.input);
		}
		return TimeSpanParse.ParseExactMultiple(input, formats, formatProvider, TimeSpanStyles.None);
	}

	public static TimeSpan ParseExact(string input, string format, IFormatProvider formatProvider, TimeSpanStyles styles)
	{
		ValidateStyles(styles, "styles");
		if (input == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.input);
		}
		if (format == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.format);
		}
		return TimeSpanParse.ParseExact(input, format, formatProvider, styles);
	}

	public static TimeSpan ParseExact(ReadOnlySpan<char> input, ReadOnlySpan<char> format, IFormatProvider formatProvider, TimeSpanStyles styles = TimeSpanStyles.None)
	{
		ValidateStyles(styles, "styles");
		return TimeSpanParse.ParseExact(input, format, formatProvider, styles);
	}

	public static TimeSpan ParseExact(string input, string[] formats, IFormatProvider formatProvider, TimeSpanStyles styles)
	{
		ValidateStyles(styles, "styles");
		if (input == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.input);
		}
		return TimeSpanParse.ParseExactMultiple(input, formats, formatProvider, styles);
	}

	public static TimeSpan ParseExact(ReadOnlySpan<char> input, string[] formats, IFormatProvider formatProvider, TimeSpanStyles styles = TimeSpanStyles.None)
	{
		ValidateStyles(styles, "styles");
		return TimeSpanParse.ParseExactMultiple(input, formats, formatProvider, styles);
	}

	public static bool TryParse(string s, out TimeSpan result)
	{
		if (s == null)
		{
			result = default;
			return false;
		}
		return TimeSpanParse.TryParse(s, null, out result);
	}

	public static bool TryParse(ReadOnlySpan<char> s, out TimeSpan result)
	{
		return TimeSpanParse.TryParse(s, null, out result);
	}

	public static bool TryParse(string input, IFormatProvider formatProvider, out TimeSpan result)
	{
		if (input == null)
		{
			result = default;
			return false;
		}
		return TimeSpanParse.TryParse(input, formatProvider, out result);
	}

	public static bool TryParse(ReadOnlySpan<char> input, IFormatProvider formatProvider, out TimeSpan result)
	{
		return TimeSpanParse.TryParse(input, formatProvider, out result);
	}

	public static bool TryParseExact(string input, string format, IFormatProvider formatProvider, out TimeSpan result)
	{
		if (input == null || format == null)
		{
			result = default;
			return false;
		}
		return TimeSpanParse.TryParseExact(input, format, formatProvider, TimeSpanStyles.None, out result);
	}

	public static bool TryParseExact(ReadOnlySpan<char> input, ReadOnlySpan<char> format, IFormatProvider formatProvider, out TimeSpan result)
	{
		return TimeSpanParse.TryParseExact(input, format, formatProvider, TimeSpanStyles.None, out result);
	}

	public static bool TryParseExact(string input, string[] formats, IFormatProvider formatProvider, out TimeSpan result)
	{
		if (input == null)
		{
			result = default;
			return false;
		}
		return TimeSpanParse.TryParseExactMultiple(input, formats, formatProvider, TimeSpanStyles.None, out result);
	}

	public static bool TryParseExact(ReadOnlySpan<char> input, string[] formats, IFormatProvider formatProvider, out TimeSpan result)
	{
		return TimeSpanParse.TryParseExactMultiple(input, formats, formatProvider, TimeSpanStyles.None, out result);
	}

	public static bool TryParseExact(string input, string format, IFormatProvider formatProvider, TimeSpanStyles styles, out TimeSpan result)
	{
		ValidateStyles(styles, "styles");
		if (input == null || format == null)
		{
			result = default;
			return false;
		}
		return TimeSpanParse.TryParseExact(input, format, formatProvider, styles, out result);
	}

	public static bool TryParseExact(ReadOnlySpan<char> input, ReadOnlySpan<char> format, IFormatProvider formatProvider, TimeSpanStyles styles, out TimeSpan result)
	{
		ValidateStyles(styles, "styles");
		return TimeSpanParse.TryParseExact(input, format, formatProvider, styles, out result);
	}

	public static bool TryParseExact(string input, string[] formats, IFormatProvider formatProvider, TimeSpanStyles styles, out TimeSpan result)
	{
		ValidateStyles(styles, "styles");
		if (input == null)
		{
			result = default;
			return false;
		}
		return TimeSpanParse.TryParseExactMultiple(input, formats, formatProvider, styles, out result);
	}

	public static bool TryParseExact(ReadOnlySpan<char> input, string[] formats, IFormatProvider formatProvider, TimeSpanStyles styles, out TimeSpan result)
	{
		ValidateStyles(styles, "styles");
		return TimeSpanParse.TryParseExactMultiple(input, formats, formatProvider, styles, out result);
	}

	public override string ToString()
	{
		return TimeSpanFormat.Format(this, null, null);
	}

	public string ToString(string format)
	{
		return TimeSpanFormat.Format(this, format, null);
	}

	public string ToString(string format, IFormatProvider formatProvider)
	{
		return TimeSpanFormat.Format(this, format, formatProvider);
	}

	public bool TryFormat(Span<char> destination, out int charsWritten, ReadOnlySpan<char> format = default(ReadOnlySpan<char>), IFormatProvider formatProvider = null)
	{
		return TimeSpanFormat.TryFormat(this, destination, out charsWritten, format, formatProvider);
	}

	public static TimeSpan operator -(TimeSpan t)
	{
		if (t._ticks == MinValue._ticks)
		{
			throw new OverflowException("Negating the minimum value of a twos complement number is invalid.");
		}
		return new TimeSpan(-t._ticks);
	}

	public static TimeSpan operator -(TimeSpan t1, TimeSpan t2)
	{
		return t1.Subtract(t2);
	}

	public static TimeSpan operator +(TimeSpan t)
	{
		return t;
	}

	public static TimeSpan operator +(TimeSpan t1, TimeSpan t2)
	{
		return t1.Add(t2);
	}

	public static TimeSpan operator *(TimeSpan timeSpan, double factor)
	{
		if (double.IsNaN(factor))
		{
			throw new ArgumentException("TimeSpan does not accept floating point Not-a-Number values.", "factor");
		}
		double num = Math.Round((double)timeSpan.Ticks * factor);
		if ((num > 9.223372036854776E+18) | (num < -9.223372036854776E+18))
		{
			throw new OverflowException("TimeSpan overflowed because the duration is too long.");
		}
		return FromTicks((long)num);
	}

	public static TimeSpan operator *(double factor, TimeSpan timeSpan)
	{
		return timeSpan * factor;
	}

	public static TimeSpan operator /(TimeSpan timeSpan, double divisor)
	{
		if (double.IsNaN(divisor))
		{
			throw new ArgumentException("TimeSpan does not accept floating point Not-a-Number values.", "divisor");
		}
		double num = Math.Round((double)timeSpan.Ticks / divisor);
		if (((num > 9.223372036854776E+18) | (num < -9.223372036854776E+18)) || double.IsNaN(num))
		{
			throw new OverflowException("TimeSpan overflowed because the duration is too long.");
		}
		return FromTicks((long)num);
	}

	public static double operator /(TimeSpan t1, TimeSpan t2)
	{
		return (double)t1.Ticks / (double)t2.Ticks;
	}

	public static bool operator ==(TimeSpan t1, TimeSpan t2)
	{
		return t1._ticks == t2._ticks;
	}

	public static bool operator !=(TimeSpan t1, TimeSpan t2)
	{
		return t1._ticks != t2._ticks;
	}

	public static bool operator <(TimeSpan t1, TimeSpan t2)
	{
		return t1._ticks < t2._ticks;
	}

	public static bool operator <=(TimeSpan t1, TimeSpan t2)
	{
		return t1._ticks <= t2._ticks;
	}

	public static bool operator >(TimeSpan t1, TimeSpan t2)
	{
		return t1._ticks > t2._ticks;
	}

	public static bool operator >=(TimeSpan t1, TimeSpan t2)
	{
		return t1._ticks >= t2._ticks;
	}
}
