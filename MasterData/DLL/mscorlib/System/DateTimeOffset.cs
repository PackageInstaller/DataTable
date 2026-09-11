using System.Globalization;
using System.Runtime.InteropServices;
using System.Runtime.Serialization;

namespace System;

[Serializable]
[StructLayout(LayoutKind.Auto)]
public readonly struct DateTimeOffset : IComparable, IFormattable, IComparable<DateTimeOffset>, IEquatable<DateTimeOffset>, ISerializable, IDeserializationCallback, ISpanFormattable
{
	internal const long MaxOffset = 504000000000L;

	internal const long MinOffset = -504000000000L;

	private const long UnixEpochSeconds = 62135596800L;

	private const long UnixEpochMilliseconds = 62135596800000L;

	internal const long UnixMinSeconds = -62135596800L;

	internal const long UnixMaxSeconds = 253402300799L;

	public static readonly DateTimeOffset MinValue = new DateTimeOffset(0L, TimeSpan.Zero);

	public static readonly DateTimeOffset MaxValue = new DateTimeOffset(3155378975999999999L, TimeSpan.Zero);

	public static readonly DateTimeOffset UnixEpoch = new DateTimeOffset(621355968000000000L, TimeSpan.Zero);

	private readonly DateTime _dateTime;

	private readonly short _offsetMinutes;

	public static DateTimeOffset Now => new DateTimeOffset(DateTime.Now);

	public static DateTimeOffset UtcNow => new DateTimeOffset(DateTime.UtcNow);

	public DateTime DateTime => ClockDateTime;

	public DateTime UtcDateTime => DateTime.SpecifyKind(_dateTime, DateTimeKind.Utc);

	public DateTime LocalDateTime => UtcDateTime.ToLocalTime();

	private DateTime ClockDateTime => new DateTime((_dateTime + Offset).Ticks, DateTimeKind.Unspecified);

	public DateTime Date => ClockDateTime.Date;

	public int Day => ClockDateTime.Day;

	public DayOfWeek DayOfWeek => ClockDateTime.DayOfWeek;

	public int DayOfYear => ClockDateTime.DayOfYear;

	public int Hour => ClockDateTime.Hour;

	public int Millisecond => ClockDateTime.Millisecond;

	public int Minute => ClockDateTime.Minute;

	public int Month => ClockDateTime.Month;

	public TimeSpan Offset => new TimeSpan(0, _offsetMinutes, 0);

	public int Second => ClockDateTime.Second;

	public long Ticks => ClockDateTime.Ticks;

	public long UtcTicks => UtcDateTime.Ticks;

	public TimeSpan TimeOfDay => ClockDateTime.TimeOfDay;

	public int Year => ClockDateTime.Year;

	public DateTimeOffset(long ticks, TimeSpan offset)
	{
		_offsetMinutes = ValidateOffset(offset);
		DateTime dateTime = new DateTime(ticks);
		_dateTime = ValidateDate(dateTime, offset);
	}

	public DateTimeOffset(DateTime dateTime)
	{
		TimeSpan offset = ((dateTime.Kind == DateTimeKind.Utc) ? new TimeSpan(0L) : TimeZoneInfo.GetLocalUtcOffset(dateTime, TimeZoneInfoOptions.NoThrowOnInvalidTime));
		_offsetMinutes = ValidateOffset(offset);
		_dateTime = ValidateDate(dateTime, offset);
	}

	public DateTimeOffset(DateTime dateTime, TimeSpan offset)
	{
		if (dateTime.Kind == DateTimeKind.Local)
		{
			if (offset != TimeZoneInfo.GetLocalUtcOffset(dateTime, TimeZoneInfoOptions.NoThrowOnInvalidTime))
			{
				throw new ArgumentException("The UTC Offset of the local dateTime parameter does not match the offset argument.", "offset");
			}
		}
		else if (dateTime.Kind == DateTimeKind.Utc && offset != TimeSpan.Zero)
		{
			throw new ArgumentException("The UTC Offset for Utc DateTime instances must be 0.", "offset");
		}
		_offsetMinutes = ValidateOffset(offset);
		_dateTime = ValidateDate(dateTime, offset);
	}

	public DateTimeOffset(int year, int month, int day, int hour, int minute, int second, TimeSpan offset)
	{
		_offsetMinutes = ValidateOffset(offset);
		_dateTime = ValidateDate(new DateTime(year, month, day, hour, minute, second), offset);
	}

	public DateTimeOffset(int year, int month, int day, int hour, int minute, int second, int millisecond, TimeSpan offset)
	{
		_offsetMinutes = ValidateOffset(offset);
		_dateTime = ValidateDate(new DateTime(year, month, day, hour, minute, second, millisecond), offset);
	}

	public DateTimeOffset(int year, int month, int day, int hour, int minute, int second, int millisecond, Calendar calendar, TimeSpan offset)
	{
		_offsetMinutes = ValidateOffset(offset);
		_dateTime = ValidateDate(new DateTime(year, month, day, hour, minute, second, millisecond, calendar), offset);
	}

	public DateTimeOffset ToOffset(TimeSpan offset)
	{
		return new DateTimeOffset((_dateTime + offset).Ticks, offset);
	}

	public DateTimeOffset Add(TimeSpan timeSpan)
	{
		return new DateTimeOffset(ClockDateTime.Add(timeSpan), Offset);
	}

	public DateTimeOffset AddDays(double days)
	{
		return new DateTimeOffset(ClockDateTime.AddDays(days), Offset);
	}

	public DateTimeOffset AddHours(double hours)
	{
		return new DateTimeOffset(ClockDateTime.AddHours(hours), Offset);
	}

	public DateTimeOffset AddMilliseconds(double milliseconds)
	{
		return new DateTimeOffset(ClockDateTime.AddMilliseconds(milliseconds), Offset);
	}

	public DateTimeOffset AddMinutes(double minutes)
	{
		return new DateTimeOffset(ClockDateTime.AddMinutes(minutes), Offset);
	}

	public DateTimeOffset AddMonths(int months)
	{
		return new DateTimeOffset(ClockDateTime.AddMonths(months), Offset);
	}

	public DateTimeOffset AddSeconds(double seconds)
	{
		return new DateTimeOffset(ClockDateTime.AddSeconds(seconds), Offset);
	}

	public DateTimeOffset AddTicks(long ticks)
	{
		return new DateTimeOffset(ClockDateTime.AddTicks(ticks), Offset);
	}

	public DateTimeOffset AddYears(int years)
	{
		return new DateTimeOffset(ClockDateTime.AddYears(years), Offset);
	}

	public static int Compare(DateTimeOffset first, DateTimeOffset second)
	{
		return DateTime.Compare(first.UtcDateTime, second.UtcDateTime);
	}

	int IComparable.CompareTo(object obj)
	{
		if (obj == null)
		{
			return 1;
		}
		if (!(obj is DateTimeOffset { UtcDateTime: var utcDateTime }))
		{
			throw new ArgumentException("Object must be of type DateTimeOffset.");
		}
		DateTime utcDateTime2 = UtcDateTime;
		if (utcDateTime2 > utcDateTime)
		{
			return 1;
		}
		if (utcDateTime2 < utcDateTime)
		{
			return -1;
		}
		return 0;
	}

	public int CompareTo(DateTimeOffset other)
	{
		DateTime utcDateTime = other.UtcDateTime;
		DateTime utcDateTime2 = UtcDateTime;
		if (utcDateTime2 > utcDateTime)
		{
			return 1;
		}
		if (utcDateTime2 < utcDateTime)
		{
			return -1;
		}
		return 0;
	}

	public override bool Equals(object obj)
	{
		if (obj is DateTimeOffset)
		{
			return UtcDateTime.Equals(((DateTimeOffset)obj).UtcDateTime);
		}
		return false;
	}

	public bool Equals(DateTimeOffset other)
	{
		return UtcDateTime.Equals(other.UtcDateTime);
	}

	public bool EqualsExact(DateTimeOffset other)
	{
		if (ClockDateTime == other.ClockDateTime && Offset == other.Offset)
		{
			return ClockDateTime.Kind == other.ClockDateTime.Kind;
		}
		return false;
	}

	public static bool Equals(DateTimeOffset first, DateTimeOffset second)
	{
		return DateTime.Equals(first.UtcDateTime, second.UtcDateTime);
	}

	public static DateTimeOffset FromFileTime(long fileTime)
	{
		return new DateTimeOffset(DateTime.FromFileTime(fileTime));
	}

	public static DateTimeOffset FromUnixTimeSeconds(long seconds)
	{
		if (seconds < -62135596800L || seconds > 253402300799L)
		{
			throw new ArgumentOutOfRangeException("seconds", SR.Format("Valid values are between {0} and {1}, inclusive.", -62135596800L, 253402300799L));
		}
		return new DateTimeOffset(seconds * 10000000 + 621355968000000000L, TimeSpan.Zero);
	}

	public static DateTimeOffset FromUnixTimeMilliseconds(long milliseconds)
	{
		if (milliseconds < -62135596800000L || milliseconds > 253402300799999L)
		{
			throw new ArgumentOutOfRangeException("milliseconds", SR.Format("Valid values are between {0} and {1}, inclusive.", -62135596800000L, 253402300799999L));
		}
		return new DateTimeOffset(milliseconds * 10000 + 621355968000000000L, TimeSpan.Zero);
	}

	void IDeserializationCallback.OnDeserialization(object sender)
	{
		try
		{
			ValidateOffset(Offset);
			ValidateDate(ClockDateTime, Offset);
		}
		catch (ArgumentException innerException)
		{
			throw new SerializationException("An error occurred while deserializing the object.  The serialized data is corrupt.", innerException);
		}
	}

	void ISerializable.GetObjectData(SerializationInfo info, StreamingContext context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
		info.AddValue("DateTime", _dateTime);
		info.AddValue("OffsetMinutes", _offsetMinutes);
	}

	private DateTimeOffset(SerializationInfo info, StreamingContext context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
		_dateTime = (DateTime)info.GetValue("DateTime", typeof(DateTime));
		_offsetMinutes = (short)info.GetValue("OffsetMinutes", typeof(short));
	}

	public override int GetHashCode()
	{
		return UtcDateTime.GetHashCode();
	}

	public static DateTimeOffset Parse(string input)
	{
		if (input == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.input);
		}
		TimeSpan offset;
		return new DateTimeOffset(DateTimeParse.Parse(input, DateTimeFormatInfo.CurrentInfo, DateTimeStyles.None, out offset).Ticks, offset);
	}

	public static DateTimeOffset Parse(string input, IFormatProvider formatProvider)
	{
		if (input == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.input);
		}
		return Parse(input, formatProvider, DateTimeStyles.None);
	}

	public static DateTimeOffset Parse(string input, IFormatProvider formatProvider, DateTimeStyles styles)
	{
		styles = ValidateStyles(styles, "styles");
		if (input == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.input);
		}
		TimeSpan offset;
		return new DateTimeOffset(DateTimeParse.Parse(input, DateTimeFormatInfo.GetInstance(formatProvider), styles, out offset).Ticks, offset);
	}

	public static DateTimeOffset Parse(ReadOnlySpan<char> input, IFormatProvider formatProvider = null, DateTimeStyles styles = DateTimeStyles.None)
	{
		styles = ValidateStyles(styles, "styles");
		TimeSpan offset;
		return new DateTimeOffset(DateTimeParse.Parse(input, DateTimeFormatInfo.GetInstance(formatProvider), styles, out offset).Ticks, offset);
	}

	public static DateTimeOffset ParseExact(string input, string format, IFormatProvider formatProvider)
	{
		if (input == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.input);
		}
		if (format == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.format);
		}
		return ParseExact(input, format, formatProvider, DateTimeStyles.None);
	}

	public static DateTimeOffset ParseExact(string input, string format, IFormatProvider formatProvider, DateTimeStyles styles)
	{
		styles = ValidateStyles(styles, "styles");
		if (input == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.input);
		}
		if (format == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.format);
		}
		TimeSpan offset;
		return new DateTimeOffset(DateTimeParse.ParseExact(input, format, DateTimeFormatInfo.GetInstance(formatProvider), styles, out offset).Ticks, offset);
	}

	public static DateTimeOffset ParseExact(ReadOnlySpan<char> input, ReadOnlySpan<char> format, IFormatProvider formatProvider, DateTimeStyles styles = DateTimeStyles.None)
	{
		styles = ValidateStyles(styles, "styles");
		TimeSpan offset;
		return new DateTimeOffset(DateTimeParse.ParseExact(input, format, DateTimeFormatInfo.GetInstance(formatProvider), styles, out offset).Ticks, offset);
	}

	public static DateTimeOffset ParseExact(string input, string[] formats, IFormatProvider formatProvider, DateTimeStyles styles)
	{
		styles = ValidateStyles(styles, "styles");
		if (input == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.input);
		}
		TimeSpan offset;
		return new DateTimeOffset(DateTimeParse.ParseExactMultiple(input, formats, DateTimeFormatInfo.GetInstance(formatProvider), styles, out offset).Ticks, offset);
	}

	public static DateTimeOffset ParseExact(ReadOnlySpan<char> input, string[] formats, IFormatProvider formatProvider, DateTimeStyles styles = DateTimeStyles.None)
	{
		styles = ValidateStyles(styles, "styles");
		TimeSpan offset;
		return new DateTimeOffset(DateTimeParse.ParseExactMultiple(input, formats, DateTimeFormatInfo.GetInstance(formatProvider), styles, out offset).Ticks, offset);
	}

	public TimeSpan Subtract(DateTimeOffset value)
	{
		return UtcDateTime.Subtract(value.UtcDateTime);
	}

	public DateTimeOffset Subtract(TimeSpan value)
	{
		return new DateTimeOffset(ClockDateTime.Subtract(value), Offset);
	}

	public long ToFileTime()
	{
		return UtcDateTime.ToFileTime();
	}

	public long ToUnixTimeSeconds()
	{
		return UtcDateTime.Ticks / 10000000 - 62135596800L;
	}

	public long ToUnixTimeMilliseconds()
	{
		return UtcDateTime.Ticks / 10000 - 62135596800000L;
	}

	public DateTimeOffset ToLocalTime()
	{
		return ToLocalTime(throwOnOverflow: false);
	}

	internal DateTimeOffset ToLocalTime(bool throwOnOverflow)
	{
		return new DateTimeOffset(UtcDateTime.ToLocalTime(throwOnOverflow));
	}

	public override string ToString()
	{
		return DateTimeFormat.Format(ClockDateTime, null, null, Offset);
	}

	public string ToString(string format)
	{
		return DateTimeFormat.Format(ClockDateTime, format, null, Offset);
	}

	public string ToString(IFormatProvider formatProvider)
	{
		return DateTimeFormat.Format(ClockDateTime, null, formatProvider, Offset);
	}

	public string ToString(string format, IFormatProvider formatProvider)
	{
		return DateTimeFormat.Format(ClockDateTime, format, formatProvider, Offset);
	}

	public bool TryFormat(Span<char> destination, out int charsWritten, ReadOnlySpan<char> format = default(ReadOnlySpan<char>), IFormatProvider formatProvider = null)
	{
		return DateTimeFormat.TryFormat(ClockDateTime, destination, out charsWritten, format, formatProvider, Offset);
	}

	public DateTimeOffset ToUniversalTime()
	{
		return new DateTimeOffset(UtcDateTime);
	}

	public static bool TryParse(string input, out DateTimeOffset result)
	{
		bool result2 = DateTimeParse.TryParse(input, DateTimeFormatInfo.CurrentInfo, DateTimeStyles.None, out var result3, out var offset);
		result = new DateTimeOffset(result3.Ticks, offset);
		return result2;
	}

	public static bool TryParse(ReadOnlySpan<char> input, out DateTimeOffset result)
	{
		bool result2 = DateTimeParse.TryParse(input, DateTimeFormatInfo.CurrentInfo, DateTimeStyles.None, out var result3, out var offset);
		result = new DateTimeOffset(result3.Ticks, offset);
		return result2;
	}

	public static bool TryParse(string input, IFormatProvider formatProvider, DateTimeStyles styles, out DateTimeOffset result)
	{
		styles = ValidateStyles(styles, "styles");
		if (input == null)
		{
			result = default(DateTimeOffset);
			return false;
		}
		bool result2 = DateTimeParse.TryParse(input, DateTimeFormatInfo.GetInstance(formatProvider), styles, out var result3, out var offset);
		result = new DateTimeOffset(result3.Ticks, offset);
		return result2;
	}

	public static bool TryParse(ReadOnlySpan<char> input, IFormatProvider formatProvider, DateTimeStyles styles, out DateTimeOffset result)
	{
		styles = ValidateStyles(styles, "styles");
		bool result2 = DateTimeParse.TryParse(input, DateTimeFormatInfo.GetInstance(formatProvider), styles, out var result3, out var offset);
		result = new DateTimeOffset(result3.Ticks, offset);
		return result2;
	}

	public static bool TryParseExact(string input, string format, IFormatProvider formatProvider, DateTimeStyles styles, out DateTimeOffset result)
	{
		styles = ValidateStyles(styles, "styles");
		if (input == null || format == null)
		{
			result = default(DateTimeOffset);
			return false;
		}
		bool result2 = DateTimeParse.TryParseExact(input, format, DateTimeFormatInfo.GetInstance(formatProvider), styles, out var result3, out var offset);
		result = new DateTimeOffset(result3.Ticks, offset);
		return result2;
	}

	public static bool TryParseExact(ReadOnlySpan<char> input, ReadOnlySpan<char> format, IFormatProvider formatProvider, DateTimeStyles styles, out DateTimeOffset result)
	{
		styles = ValidateStyles(styles, "styles");
		bool result2 = DateTimeParse.TryParseExact(input, format, DateTimeFormatInfo.GetInstance(formatProvider), styles, out var result3, out var offset);
		result = new DateTimeOffset(result3.Ticks, offset);
		return result2;
	}

	public static bool TryParseExact(string input, string[] formats, IFormatProvider formatProvider, DateTimeStyles styles, out DateTimeOffset result)
	{
		styles = ValidateStyles(styles, "styles");
		if (input == null)
		{
			result = default(DateTimeOffset);
			return false;
		}
		bool result2 = DateTimeParse.TryParseExactMultiple(input, formats, DateTimeFormatInfo.GetInstance(formatProvider), styles, out var result3, out var offset);
		result = new DateTimeOffset(result3.Ticks, offset);
		return result2;
	}

	public static bool TryParseExact(ReadOnlySpan<char> input, string[] formats, IFormatProvider formatProvider, DateTimeStyles styles, out DateTimeOffset result)
	{
		styles = ValidateStyles(styles, "styles");
		bool result2 = DateTimeParse.TryParseExactMultiple(input, formats, DateTimeFormatInfo.GetInstance(formatProvider), styles, out var result3, out var offset);
		result = new DateTimeOffset(result3.Ticks, offset);
		return result2;
	}

	private static short ValidateOffset(TimeSpan offset)
	{
		long ticks = offset.Ticks;
		if (ticks % 600000000 != 0L)
		{
			throw new ArgumentException("Offset must be specified in whole minutes.", "offset");
		}
		if (ticks < -504000000000L || ticks > 504000000000L)
		{
			throw new ArgumentOutOfRangeException("offset", "Offset must be within plus or minus 14 hours.");
		}
		return (short)(offset.Ticks / 600000000);
	}

	private static DateTime ValidateDate(DateTime dateTime, TimeSpan offset)
	{
		long num = dateTime.Ticks - offset.Ticks;
		if (num < 0 || num > 3155378975999999999L)
		{
			throw new ArgumentOutOfRangeException("offset", "The UTC time represented when the offset is applied must be between year 0 and 10,000.");
		}
		return new DateTime(num, DateTimeKind.Unspecified);
	}

	private static DateTimeStyles ValidateStyles(DateTimeStyles style, string parameterName)
	{
		if ((style & ~(DateTimeStyles.AllowWhiteSpaces | DateTimeStyles.NoCurrentDateDefault | DateTimeStyles.AdjustToUniversal | DateTimeStyles.AssumeLocal | DateTimeStyles.AssumeUniversal | DateTimeStyles.RoundtripKind)) != DateTimeStyles.None)
		{
			throw new ArgumentException("An undefined DateTimeStyles value is being used.", parameterName);
		}
		if ((style & DateTimeStyles.AssumeLocal) != DateTimeStyles.None && (style & DateTimeStyles.AssumeUniversal) != DateTimeStyles.None)
		{
			throw new ArgumentException("The DateTimeStyles values AssumeLocal and AssumeUniversal cannot be used together.", parameterName);
		}
		if ((style & DateTimeStyles.NoCurrentDateDefault) != DateTimeStyles.None)
		{
			throw new ArgumentException("The DateTimeStyles value 'NoCurrentDateDefault' is not allowed when parsing DateTimeOffset.", parameterName);
		}
		style &= ~DateTimeStyles.RoundtripKind;
		style &= ~DateTimeStyles.AssumeLocal;
		return style;
	}

	public static implicit operator DateTimeOffset(DateTime dateTime)
	{
		return new DateTimeOffset(dateTime);
	}

	public static DateTimeOffset operator +(DateTimeOffset dateTimeOffset, TimeSpan timeSpan)
	{
		return new DateTimeOffset(dateTimeOffset.ClockDateTime + timeSpan, dateTimeOffset.Offset);
	}

	public static DateTimeOffset operator -(DateTimeOffset dateTimeOffset, TimeSpan timeSpan)
	{
		return new DateTimeOffset(dateTimeOffset.ClockDateTime - timeSpan, dateTimeOffset.Offset);
	}

	public static TimeSpan operator -(DateTimeOffset left, DateTimeOffset right)
	{
		return left.UtcDateTime - right.UtcDateTime;
	}

	public static bool operator ==(DateTimeOffset left, DateTimeOffset right)
	{
		return left.UtcDateTime == right.UtcDateTime;
	}

	public static bool operator !=(DateTimeOffset left, DateTimeOffset right)
	{
		return left.UtcDateTime != right.UtcDateTime;
	}

	public static bool operator <(DateTimeOffset left, DateTimeOffset right)
	{
		return left.UtcDateTime < right.UtcDateTime;
	}

	public static bool operator <=(DateTimeOffset left, DateTimeOffset right)
	{
		return left.UtcDateTime <= right.UtcDateTime;
	}

	public static bool operator >(DateTimeOffset left, DateTimeOffset right)
	{
		return left.UtcDateTime > right.UtcDateTime;
	}

	public static bool operator >=(DateTimeOffset left, DateTimeOffset right)
	{
		return left.UtcDateTime >= right.UtcDateTime;
	}
}
