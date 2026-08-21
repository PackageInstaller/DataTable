using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Globalization;
using System.IO;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Runtime.Serialization;
using System.Text;
using Microsoft.Win32;
using Microsoft.Win32.SafeHandles;
using Unity;

namespace System;

[Serializable]
[TypeForwardedFrom("System.Core, Version=2.0.5.0, Culture=Neutral, PublicKeyToken=7cec85d7bea7798e")]
public sealed class TimeZoneInfo : IEquatable<TimeZoneInfo>, ISerializable, IDeserializationCallback
{
	private sealed class CachedData
	{
		private volatile OffsetAndRule _oneYearLocalFromUtc;

		private volatile TimeZoneInfo _localTimeZone;

		public Dictionary<string, TimeZoneInfo> _systemTimeZones;

		public ReadOnlyCollection<TimeZoneInfo> _readOnlySystemTimeZones;

		public bool _allSystemTimeZonesRead;

		public TimeZoneInfo Local
		{
			get
			{
				TimeZoneInfo timeZoneInfo = _localTimeZone;
				if (timeZoneInfo == null)
				{
					timeZoneInfo = CreateLocal();
				}
				return timeZoneInfo;
			}
		}

		private static TimeZoneInfo GetCurrentOneYearLocal()
		{
			if (Interop.Kernel32.GetTimeZoneInformation(out var lpTimeZoneInformation) != uint.MaxValue)
			{
				return GetLocalTimeZoneFromWin32Data(in lpTimeZoneInformation, dstDisabled: false);
			}
			return CreateCustomTimeZone("Local", TimeSpan.Zero, "Local", "Local");
		}

		public OffsetAndRule GetOneYearLocalFromUtc(int year)
		{
			OffsetAndRule offsetAndRule = _oneYearLocalFromUtc;
			if (offsetAndRule == null || offsetAndRule.Year != year)
			{
				TimeZoneInfo currentOneYearLocal = GetCurrentOneYearLocal();
				AdjustmentRule rule = ((currentOneYearLocal._adjustmentRules == null) ? null : currentOneYearLocal._adjustmentRules[0]);
				offsetAndRule = (_oneYearLocalFromUtc = new OffsetAndRule(year, currentOneYearLocal.BaseUtcOffset, rule));
			}
			return offsetAndRule;
		}

		private TimeZoneInfo CreateLocal()
		{
			lock (this)
			{
				TimeZoneInfo timeZoneInfo = _localTimeZone;
				if (timeZoneInfo == null)
				{
					timeZoneInfo = GetLocalTimeZone(this);
					timeZoneInfo = (_localTimeZone = new TimeZoneInfo(timeZoneInfo._id, timeZoneInfo._baseUtcOffset, timeZoneInfo._displayName, timeZoneInfo._standardDisplayName, timeZoneInfo._daylightDisplayName, timeZoneInfo._adjustmentRules, disableDaylightSavingTime: false));
				}
				return timeZoneInfo;
			}
		}

		public DateTimeKind GetCorrespondingKind(TimeZoneInfo timeZone)
		{
			if (timeZone != s_utcTimeZone)
			{
				if (timeZone != _localTimeZone)
				{
					return DateTimeKind.Unspecified;
				}
				return DateTimeKind.Local;
			}
			return DateTimeKind.Utc;
		}
	}

	private sealed class OffsetAndRule
	{
		public readonly int Year;

		public readonly TimeSpan Offset;

		public readonly AdjustmentRule Rule;

		public OffsetAndRule(int year, TimeSpan offset, AdjustmentRule rule)
		{
			Year = year;
			Offset = offset;
			Rule = rule;
		}
	}

	[StructLayout(LayoutKind.Sequential, CharSet = CharSet.Unicode)]
	internal struct DYNAMIC_TIME_ZONE_INFORMATION
	{
		internal Interop.Kernel32.TIME_ZONE_INFORMATION TZI;

		[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 128)]
		internal string TimeZoneKeyName;

		internal byte DynamicDaylightTimeDisabled;
	}

	private enum TimeZoneInfoResult
	{
		Success,
		TimeZoneNotFoundException,
		InvalidTimeZoneException,
		SecurityException
	}

	[Serializable]
	public sealed class AdjustmentRule : IEquatable<AdjustmentRule>, ISerializable, IDeserializationCallback
	{
		private readonly DateTime _dateStart;

		private readonly DateTime _dateEnd;

		private readonly TimeSpan _daylightDelta;

		private readonly TransitionTime _daylightTransitionStart;

		private readonly TransitionTime _daylightTransitionEnd;

		private readonly TimeSpan _baseUtcOffsetDelta;

		private readonly bool _noDaylightTransitions;

		public DateTime DateStart => _dateStart;

		public DateTime DateEnd => _dateEnd;

		public TimeSpan DaylightDelta => _daylightDelta;

		public TransitionTime DaylightTransitionStart => _daylightTransitionStart;

		public TransitionTime DaylightTransitionEnd => _daylightTransitionEnd;

		internal TimeSpan BaseUtcOffsetDelta => _baseUtcOffsetDelta;

		internal bool NoDaylightTransitions => _noDaylightTransitions;

		internal bool HasDaylightSaving
		{
			get
			{
				if (!(DaylightDelta != TimeSpan.Zero) && (!(DaylightTransitionStart != default(TransitionTime)) || !(DaylightTransitionStart.TimeOfDay != DateTime.MinValue)))
				{
					if (DaylightTransitionEnd != default(TransitionTime))
					{
						return DaylightTransitionEnd.TimeOfDay != DateTime.MinValue.AddMilliseconds(1.0);
					}
					return false;
				}
				return true;
			}
		}

		public bool Equals(AdjustmentRule other)
		{
			if (other != null && _dateStart == other._dateStart && _dateEnd == other._dateEnd && _daylightDelta == other._daylightDelta && _baseUtcOffsetDelta == other._baseUtcOffsetDelta && _daylightTransitionEnd.Equals(other._daylightTransitionEnd))
			{
				return _daylightTransitionStart.Equals(other._daylightTransitionStart);
			}
			return false;
		}

		public override int GetHashCode()
		{
			return _dateStart.GetHashCode();
		}

		private AdjustmentRule(DateTime dateStart, DateTime dateEnd, TimeSpan daylightDelta, TransitionTime daylightTransitionStart, TransitionTime daylightTransitionEnd, TimeSpan baseUtcOffsetDelta, bool noDaylightTransitions)
		{
			ValidateAdjustmentRule(dateStart, dateEnd, daylightDelta, daylightTransitionStart, daylightTransitionEnd, noDaylightTransitions);
			_dateStart = dateStart;
			_dateEnd = dateEnd;
			_daylightDelta = daylightDelta;
			_daylightTransitionStart = daylightTransitionStart;
			_daylightTransitionEnd = daylightTransitionEnd;
			_baseUtcOffsetDelta = baseUtcOffsetDelta;
			_noDaylightTransitions = noDaylightTransitions;
		}

		internal static AdjustmentRule CreateAdjustmentRule(DateTime dateStart, DateTime dateEnd, TimeSpan daylightDelta, TransitionTime daylightTransitionStart, TransitionTime daylightTransitionEnd, TimeSpan baseUtcOffsetDelta, bool noDaylightTransitions)
		{
			return new AdjustmentRule(dateStart, dateEnd, daylightDelta, daylightTransitionStart, daylightTransitionEnd, baseUtcOffsetDelta, noDaylightTransitions);
		}

		internal bool IsStartDateMarkerForBeginningOfYear()
		{
			if (!NoDaylightTransitions && DaylightTransitionStart.Month == 1 && DaylightTransitionStart.Day == 1 && DaylightTransitionStart.TimeOfDay.Hour == 0 && DaylightTransitionStart.TimeOfDay.Minute == 0 && DaylightTransitionStart.TimeOfDay.Second == 0)
			{
				return _dateStart.Year == _dateEnd.Year;
			}
			return false;
		}

		internal bool IsEndDateMarkerForEndOfYear()
		{
			if (!NoDaylightTransitions && DaylightTransitionEnd.Month == 1 && DaylightTransitionEnd.Day == 1 && DaylightTransitionEnd.TimeOfDay.Hour == 0 && DaylightTransitionEnd.TimeOfDay.Minute == 0 && DaylightTransitionEnd.TimeOfDay.Second == 0)
			{
				return _dateStart.Year == _dateEnd.Year;
			}
			return false;
		}

		private static void ValidateAdjustmentRule(DateTime dateStart, DateTime dateEnd, TimeSpan daylightDelta, TransitionTime daylightTransitionStart, TransitionTime daylightTransitionEnd, bool noDaylightTransitions)
		{
			if (dateStart.Kind != DateTimeKind.Unspecified && dateStart.Kind != DateTimeKind.Utc)
			{
				throw new ArgumentException("The supplied DateTime must have the Kind property set to DateTimeKind.Unspecified or DateTimeKind.Utc.", "dateStart");
			}
			if (dateEnd.Kind != DateTimeKind.Unspecified && dateEnd.Kind != DateTimeKind.Utc)
			{
				throw new ArgumentException("The supplied DateTime must have the Kind property set to DateTimeKind.Unspecified or DateTimeKind.Utc.", "dateEnd");
			}
			if (daylightTransitionStart.Equals(daylightTransitionEnd) && !noDaylightTransitions)
			{
				throw new ArgumentException("The DaylightTransitionStart property must not equal the DaylightTransitionEnd property.", "daylightTransitionEnd");
			}
			if (dateStart > dateEnd)
			{
				throw new ArgumentException("The DateStart property must come before the DateEnd property.", "dateStart");
			}
			if (daylightDelta.TotalHours < -23.0 || daylightDelta.TotalHours > 14.0)
			{
				throw new ArgumentOutOfRangeException("daylightDelta", daylightDelta, "The TimeSpan parameter must be within plus or minus 14.0 hours.");
			}
			if (daylightDelta.Ticks % 600000000 != 0L)
			{
				throw new ArgumentException("The TimeSpan parameter cannot be specified more precisely than whole minutes.", "daylightDelta");
			}
			if (dateStart != DateTime.MinValue && dateStart.Kind == DateTimeKind.Unspecified && dateStart.TimeOfDay != TimeSpan.Zero)
			{
				throw new ArgumentException("The supplied DateTime includes a TimeOfDay setting.   This is not supported.", "dateStart");
			}
			if (dateEnd != DateTime.MaxValue && dateEnd.Kind == DateTimeKind.Unspecified && dateEnd.TimeOfDay != TimeSpan.Zero)
			{
				throw new ArgumentException("The supplied DateTime includes a TimeOfDay setting.   This is not supported.", "dateEnd");
			}
		}

		void IDeserializationCallback.OnDeserialization(object sender)
		{
			try
			{
				ValidateAdjustmentRule(_dateStart, _dateEnd, _daylightDelta, _daylightTransitionStart, _daylightTransitionEnd, _noDaylightTransitions);
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
			info.AddValue("DateStart", _dateStart);
			info.AddValue("DateEnd", _dateEnd);
			info.AddValue("DaylightDelta", _daylightDelta);
			info.AddValue("DaylightTransitionStart", _daylightTransitionStart);
			info.AddValue("DaylightTransitionEnd", _daylightTransitionEnd);
			info.AddValue("BaseUtcOffsetDelta", _baseUtcOffsetDelta);
			info.AddValue("NoDaylightTransitions", _noDaylightTransitions);
		}

		private AdjustmentRule(SerializationInfo info, StreamingContext context)
		{
			if (info == null)
			{
				throw new ArgumentNullException("info");
			}
			_dateStart = (DateTime)info.GetValue("DateStart", typeof(DateTime));
			_dateEnd = (DateTime)info.GetValue("DateEnd", typeof(DateTime));
			_daylightDelta = (TimeSpan)info.GetValue("DaylightDelta", typeof(TimeSpan));
			_daylightTransitionStart = (TransitionTime)info.GetValue("DaylightTransitionStart", typeof(TransitionTime));
			_daylightTransitionEnd = (TransitionTime)info.GetValue("DaylightTransitionEnd", typeof(TransitionTime));
			object valueNoThrow = info.GetValueNoThrow("BaseUtcOffsetDelta", typeof(TimeSpan));
			if (valueNoThrow != null)
			{
				_baseUtcOffsetDelta = (TimeSpan)valueNoThrow;
			}
			valueNoThrow = info.GetValueNoThrow("NoDaylightTransitions", typeof(bool));
			if (valueNoThrow != null)
			{
				_noDaylightTransitions = (bool)valueNoThrow;
			}
		}

		internal AdjustmentRule()
		{
			ThrowStub.ThrowNotSupportedException();
		}
	}

	[Serializable]
	public readonly struct TransitionTime : IEquatable<TransitionTime>, ISerializable, IDeserializationCallback
	{
		private readonly DateTime _timeOfDay;

		private readonly byte _month;

		private readonly byte _week;

		private readonly byte _day;

		private readonly DayOfWeek _dayOfWeek;

		private readonly bool _isFixedDateRule;

		public DateTime TimeOfDay => _timeOfDay;

		public int Month => _month;

		public int Week => _week;

		public int Day => _day;

		public DayOfWeek DayOfWeek => _dayOfWeek;

		public bool IsFixedDateRule => _isFixedDateRule;

		public override bool Equals(object obj)
		{
			if (obj is TransitionTime)
			{
				return Equals((TransitionTime)obj);
			}
			return false;
		}

		public static bool operator !=(TransitionTime t1, TransitionTime t2)
		{
			return !t1.Equals(t2);
		}

		public bool Equals(TransitionTime other)
		{
			if (_isFixedDateRule == other._isFixedDateRule && _timeOfDay == other._timeOfDay && _month == other._month)
			{
				if (!other._isFixedDateRule)
				{
					if (_week == other._week)
					{
						return _dayOfWeek == other._dayOfWeek;
					}
					return false;
				}
				return _day == other._day;
			}
			return false;
		}

		public override int GetHashCode()
		{
			return _month ^ (_week << 8);
		}

		private TransitionTime(DateTime timeOfDay, int month, int week, int day, DayOfWeek dayOfWeek, bool isFixedDateRule)
		{
			ValidateTransitionTime(timeOfDay, month, week, day, dayOfWeek);
			_timeOfDay = timeOfDay;
			_month = (byte)month;
			_week = (byte)week;
			_day = (byte)day;
			_dayOfWeek = dayOfWeek;
			_isFixedDateRule = isFixedDateRule;
		}

		public static TransitionTime CreateFixedDateRule(DateTime timeOfDay, int month, int day)
		{
			return new TransitionTime(timeOfDay, month, 1, day, DayOfWeek.Sunday, isFixedDateRule: true);
		}

		public static TransitionTime CreateFloatingDateRule(DateTime timeOfDay, int month, int week, DayOfWeek dayOfWeek)
		{
			return new TransitionTime(timeOfDay, month, week, 1, dayOfWeek, isFixedDateRule: false);
		}

		private static void ValidateTransitionTime(DateTime timeOfDay, int month, int week, int day, DayOfWeek dayOfWeek)
		{
			if (timeOfDay.Kind != DateTimeKind.Unspecified)
			{
				throw new ArgumentException("The supplied DateTime must have the Kind property set to DateTimeKind.Unspecified.", "timeOfDay");
			}
			if (month < 1 || month > 12)
			{
				throw new ArgumentOutOfRangeException("month", "The Month parameter must be in the range 1 through 12.");
			}
			if (day < 1 || day > 31)
			{
				throw new ArgumentOutOfRangeException("day", "The Day parameter must be in the range 1 through 31.");
			}
			if (week < 1 || week > 5)
			{
				throw new ArgumentOutOfRangeException("week", "The Week parameter must be in the range 1 through 5.");
			}
			if (dayOfWeek < DayOfWeek.Sunday || dayOfWeek > DayOfWeek.Saturday)
			{
				throw new ArgumentOutOfRangeException("dayOfWeek", "The DayOfWeek enumeration must be in the range 0 through 6.");
			}
			timeOfDay.GetDatePart(out var year, out var month2, out var day2);
			if (year != 1 || month2 != 1 || day2 != 1 || timeOfDay.Ticks % 10000 != 0L)
			{
				throw new ArgumentException("The supplied DateTime must have the Year, Month, and Day properties set to 1.  The time cannot be specified more precisely than whole milliseconds.", "timeOfDay");
			}
		}

		void IDeserializationCallback.OnDeserialization(object sender)
		{
			try
			{
				ValidateTransitionTime(_timeOfDay, _month, _week, _day, _dayOfWeek);
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
			info.AddValue("TimeOfDay", _timeOfDay);
			info.AddValue("Month", _month);
			info.AddValue("Week", _week);
			info.AddValue("Day", _day);
			info.AddValue("DayOfWeek", _dayOfWeek);
			info.AddValue("IsFixedDateRule", _isFixedDateRule);
		}

		private TransitionTime(SerializationInfo info, StreamingContext context)
		{
			if (info == null)
			{
				throw new ArgumentNullException("info");
			}
			_timeOfDay = (DateTime)info.GetValue("TimeOfDay", typeof(DateTime));
			_month = (byte)info.GetValue("Month", typeof(byte));
			_week = (byte)info.GetValue("Week", typeof(byte));
			_day = (byte)info.GetValue("Day", typeof(byte));
			_dayOfWeek = (DayOfWeek)info.GetValue("DayOfWeek", typeof(DayOfWeek));
			_isFixedDateRule = (bool)info.GetValue("IsFixedDateRule", typeof(bool));
		}
	}

	private static Lazy<bool> lazyHaveRegistry = new Lazy<bool>(delegate
	{
		try
		{
			using (Registry.LocalMachine.OpenSubKey("SYSTEM\\CurrentControlSet\\Control\\TimeZoneInformation", writable: false))
			{
				return true;
			}
		}
		catch
		{
			return false;
		}
	});

	private readonly string _id;

	private readonly string _displayName;

	private readonly string _standardDisplayName;

	private readonly string _daylightDisplayName;

	private readonly TimeSpan _baseUtcOffset;

	private readonly bool _supportsDaylightSavingTime;

	private readonly AdjustmentRule[] _adjustmentRules;

	private static readonly TimeZoneInfo s_utcTimeZone = CreateCustomTimeZone("UTC", TimeSpan.Zero, "UTC", "UTC");

	private static CachedData s_cachedData = new CachedData();

	private static readonly DateTime s_maxDateOnly = new DateTime(9999, 12, 31);

	private static readonly DateTime s_minDateOnly = new DateTime(1, 1, 2);

	private static readonly TimeSpan MaxOffset = TimeSpan.FromHours(14.0);

	private static readonly TimeSpan MinOffset = -MaxOffset;

	private static bool HaveRegistry => lazyHaveRegistry.Value;

	public string Id => _id;

	public string DisplayName => _displayName ?? string.Empty;

	public TimeSpan BaseUtcOffset => _baseUtcOffset;

	public static TimeZoneInfo Local => s_cachedData.Local;

	public static TimeZoneInfo Utc => s_utcTimeZone;

	private static void PopulateAllSystemTimeZones(CachedData cachedData)
	{
		if (HaveRegistry)
		{
			PopulateAllSystemTimeZonesFromRegistry(cachedData);
		}
		else
		{
			GetSystemTimeZonesWinRTFallback(cachedData);
		}
	}

	private static void PopulateAllSystemTimeZonesFromRegistry(CachedData cachedData)
	{
		using RegistryKey registryKey = Registry.LocalMachine.OpenSubKey("SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Time Zones", writable: false);
		if (registryKey != null)
		{
			string[] subKeyNames = registryKey.GetSubKeyNames();
			for (int i = 0; i < subKeyNames.Length; i++)
			{
				TryGetTimeZone(subKeyNames[i], dstDisabled: false, out var _, out var _, cachedData);
			}
		}
	}

	private TimeZoneInfo(in Interop.Kernel32.TIME_ZONE_INFORMATION zone, bool dstDisabled)
	{
		string standardName = zone.GetStandardName();
		if (standardName.Length == 0)
		{
			_id = "Local";
		}
		else
		{
			_id = standardName;
		}
		_baseUtcOffset = new TimeSpan(0, -zone.Bias, 0);
		if (!dstDisabled)
		{
			AdjustmentRule adjustmentRule = CreateAdjustmentRuleFromTimeZoneInformation(new Interop.Kernel32.REG_TZI_FORMAT(in zone), DateTime.MinValue.Date, DateTime.MaxValue.Date, zone.Bias);
			if (adjustmentRule != null)
			{
				_adjustmentRules = new AdjustmentRule[1] { adjustmentRule };
			}
		}
		ValidateTimeZoneInfo(_id, _baseUtcOffset, _adjustmentRules, out _supportsDaylightSavingTime);
		_displayName = standardName;
		_standardDisplayName = standardName;
		_daylightDisplayName = zone.GetDaylightName();
	}

	private static bool CheckDaylightSavingTimeNotSupported(in Interop.Kernel32.TIME_ZONE_INFORMATION timeZone)
	{
		return timeZone.DaylightDate.Equals(in timeZone.StandardDate);
	}

	private static AdjustmentRule CreateAdjustmentRuleFromTimeZoneInformation(in Interop.Kernel32.REG_TZI_FORMAT timeZoneInformation, DateTime startDate, DateTime endDate, int defaultBaseUtcOffset)
	{
		if (timeZoneInformation.StandardDate.Month == 0)
		{
			if (timeZoneInformation.Bias == defaultBaseUtcOffset)
			{
				return null;
			}
			return AdjustmentRule.CreateAdjustmentRule(startDate, endDate, TimeSpan.Zero, TransitionTime.CreateFixedDateRule(DateTime.MinValue, 1, 1), TransitionTime.CreateFixedDateRule(DateTime.MinValue.AddMilliseconds(1.0), 1, 1), new TimeSpan(0, defaultBaseUtcOffset - timeZoneInformation.Bias, 0), noDaylightTransitions: false);
		}
		if (!TransitionTimeFromTimeZoneInformation(in timeZoneInformation, out var transitionTime, readStartDate: true))
		{
			return null;
		}
		if (!TransitionTimeFromTimeZoneInformation(in timeZoneInformation, out var transitionTime2, readStartDate: false))
		{
			return null;
		}
		if (transitionTime.Equals(transitionTime2))
		{
			return null;
		}
		return AdjustmentRule.CreateAdjustmentRule(startDate, endDate, new TimeSpan(0, -timeZoneInformation.DaylightBias, 0), transitionTime, transitionTime2, new TimeSpan(0, defaultBaseUtcOffset - timeZoneInformation.Bias, 0), noDaylightTransitions: false);
	}

	private static string FindIdFromTimeZoneInformation(in Interop.Kernel32.TIME_ZONE_INFORMATION timeZone, out bool dstDisabled)
	{
		dstDisabled = false;
		using (RegistryKey registryKey = Registry.LocalMachine.OpenSubKey("SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Time Zones", writable: false))
		{
			if (registryKey == null)
			{
				return null;
			}
			string[] subKeyNames = registryKey.GetSubKeyNames();
			foreach (string text in subKeyNames)
			{
				if (TryCompareTimeZoneInformationToRegistry(in timeZone, text, out dstDisabled))
				{
					return text;
				}
			}
		}
		return null;
	}

	private static TimeZoneInfo GetLocalTimeZone(CachedData cachedData)
	{
		if (!HaveRegistry)
		{
			return GetLocalTimeZoneInfoWinRTFallback();
		}
		Interop.Kernel32.TIME_DYNAMIC_ZONE_INFORMATION pTimeZoneInformation = default(Interop.Kernel32.TIME_DYNAMIC_ZONE_INFORMATION);
		if (Interop.Kernel32.GetDynamicTimeZoneInformation(out pTimeZoneInformation) == uint.MaxValue)
		{
			return CreateCustomTimeZone("Local", TimeSpan.Zero, "Local", "Local");
		}
		string timeZoneKeyName = pTimeZoneInformation.GetTimeZoneKeyName();
		if (timeZoneKeyName.Length != 0 && TryGetTimeZone(timeZoneKeyName, pTimeZoneInformation.DynamicDaylightTimeDisabled != 0, out var value, out var _, cachedData) == TimeZoneInfoResult.Success)
		{
			return value;
		}
		Interop.Kernel32.TIME_ZONE_INFORMATION timeZone = new Interop.Kernel32.TIME_ZONE_INFORMATION(in pTimeZoneInformation);
		string text = FindIdFromTimeZoneInformation(in timeZone, out var dstDisabled);
		if (text != null && TryGetTimeZone(text, dstDisabled, out var value2, out var _, cachedData) == TimeZoneInfoResult.Success)
		{
			return value2;
		}
		return GetLocalTimeZoneFromWin32Data(in timeZone, dstDisabled);
	}

	private static TimeZoneInfo GetLocalTimeZoneFromWin32Data(in Interop.Kernel32.TIME_ZONE_INFORMATION timeZoneInformation, bool dstDisabled)
	{
		try
		{
			return new TimeZoneInfo(in timeZoneInformation, dstDisabled);
		}
		catch (ArgumentException)
		{
		}
		catch (InvalidTimeZoneException)
		{
		}
		if (!dstDisabled)
		{
			try
			{
				return new TimeZoneInfo(in timeZoneInformation, dstDisabled: true);
			}
			catch (ArgumentException)
			{
			}
			catch (InvalidTimeZoneException)
			{
			}
		}
		return CreateCustomTimeZone("Local", TimeSpan.Zero, "Local", "Local");
	}

	internal static TimeSpan GetDateTimeNowUtcOffsetFromUtc(DateTime time, out bool isAmbiguousLocalDst)
	{
		bool flag = false;
		isAmbiguousLocalDst = false;
		int year = time.Year;
		OffsetAndRule oneYearLocalFromUtc = s_cachedData.GetOneYearLocalFromUtc(year);
		TimeSpan offset = oneYearLocalFromUtc.Offset;
		if (oneYearLocalFromUtc.Rule != null)
		{
			offset += oneYearLocalFromUtc.Rule.BaseUtcOffsetDelta;
			if (oneYearLocalFromUtc.Rule.HasDaylightSaving)
			{
				flag = GetIsDaylightSavingsFromUtc(time, year, oneYearLocalFromUtc.Offset, oneYearLocalFromUtc.Rule, null, out isAmbiguousLocalDst, Local);
				offset += (flag ? oneYearLocalFromUtc.Rule.DaylightDelta : TimeSpan.Zero);
			}
		}
		return offset;
	}

	private static bool TransitionTimeFromTimeZoneInformation(in Interop.Kernel32.REG_TZI_FORMAT timeZoneInformation, out TransitionTime transitionTime, bool readStartDate)
	{
		if (timeZoneInformation.StandardDate.Month == 0)
		{
			transitionTime = default(TransitionTime);
			return false;
		}
		if (readStartDate)
		{
			if (timeZoneInformation.DaylightDate.Year == 0)
			{
				transitionTime = TransitionTime.CreateFloatingDateRule(new DateTime(1, 1, 1, timeZoneInformation.DaylightDate.Hour, timeZoneInformation.DaylightDate.Minute, timeZoneInformation.DaylightDate.Second, timeZoneInformation.DaylightDate.Milliseconds), timeZoneInformation.DaylightDate.Month, timeZoneInformation.DaylightDate.Day, (DayOfWeek)timeZoneInformation.DaylightDate.DayOfWeek);
			}
			else
			{
				transitionTime = TransitionTime.CreateFixedDateRule(new DateTime(1, 1, 1, timeZoneInformation.DaylightDate.Hour, timeZoneInformation.DaylightDate.Minute, timeZoneInformation.DaylightDate.Second, timeZoneInformation.DaylightDate.Milliseconds), timeZoneInformation.DaylightDate.Month, timeZoneInformation.DaylightDate.Day);
			}
		}
		else if (timeZoneInformation.StandardDate.Year == 0)
		{
			transitionTime = TransitionTime.CreateFloatingDateRule(new DateTime(1, 1, 1, timeZoneInformation.StandardDate.Hour, timeZoneInformation.StandardDate.Minute, timeZoneInformation.StandardDate.Second, timeZoneInformation.StandardDate.Milliseconds), timeZoneInformation.StandardDate.Month, timeZoneInformation.StandardDate.Day, (DayOfWeek)timeZoneInformation.StandardDate.DayOfWeek);
		}
		else
		{
			transitionTime = TransitionTime.CreateFixedDateRule(new DateTime(1, 1, 1, timeZoneInformation.StandardDate.Hour, timeZoneInformation.StandardDate.Minute, timeZoneInformation.StandardDate.Second, timeZoneInformation.StandardDate.Milliseconds), timeZoneInformation.StandardDate.Month, timeZoneInformation.StandardDate.Day);
		}
		return true;
	}

	private static bool TryCreateAdjustmentRules(string id, in Interop.Kernel32.REG_TZI_FORMAT defaultTimeZoneInformation, out AdjustmentRule[] rules, out Exception e, int defaultBaseUtcOffset)
	{
		rules = null;
		e = null;
		try
		{
			using RegistryKey registryKey = Registry.LocalMachine.OpenSubKey("SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Time Zones\\" + id + "\\Dynamic DST", writable: false);
			if (registryKey == null)
			{
				AdjustmentRule adjustmentRule = CreateAdjustmentRuleFromTimeZoneInformation(in defaultTimeZoneInformation, DateTime.MinValue.Date, DateTime.MaxValue.Date, defaultBaseUtcOffset);
				if (adjustmentRule != null)
				{
					rules = new AdjustmentRule[1] { adjustmentRule };
				}
				return true;
			}
			int num = (int)registryKey.GetValue("FirstEntry", -1, RegistryValueOptions.None);
			int num2 = (int)registryKey.GetValue("LastEntry", -1, RegistryValueOptions.None);
			if (num == -1 || num2 == -1 || num > num2)
			{
				return false;
			}
			if (!TryGetTimeZoneEntryFromRegistry(registryKey, num.ToString(CultureInfo.InvariantCulture), out var dtzi))
			{
				return false;
			}
			if (num == num2)
			{
				AdjustmentRule adjustmentRule2 = CreateAdjustmentRuleFromTimeZoneInformation(in dtzi, DateTime.MinValue.Date, DateTime.MaxValue.Date, defaultBaseUtcOffset);
				if (adjustmentRule2 != null)
				{
					rules = new AdjustmentRule[1] { adjustmentRule2 };
				}
				return true;
			}
			List<AdjustmentRule> list = new List<AdjustmentRule>(1);
			AdjustmentRule adjustmentRule3 = CreateAdjustmentRuleFromTimeZoneInformation(in dtzi, DateTime.MinValue.Date, new DateTime(num, 12, 31), defaultBaseUtcOffset);
			if (adjustmentRule3 != null)
			{
				list.Add(adjustmentRule3);
			}
			for (int i = num + 1; i < num2; i++)
			{
				if (!TryGetTimeZoneEntryFromRegistry(registryKey, i.ToString(CultureInfo.InvariantCulture), out dtzi))
				{
					return false;
				}
				AdjustmentRule adjustmentRule4 = CreateAdjustmentRuleFromTimeZoneInformation(in dtzi, new DateTime(i, 1, 1), new DateTime(i, 12, 31), defaultBaseUtcOffset);
				if (adjustmentRule4 != null)
				{
					list.Add(adjustmentRule4);
				}
			}
			if (!TryGetTimeZoneEntryFromRegistry(registryKey, num2.ToString(CultureInfo.InvariantCulture), out dtzi))
			{
				return false;
			}
			AdjustmentRule adjustmentRule5 = CreateAdjustmentRuleFromTimeZoneInformation(in dtzi, new DateTime(num2, 1, 1), DateTime.MaxValue.Date, defaultBaseUtcOffset);
			if (adjustmentRule5 != null)
			{
				list.Add(adjustmentRule5);
			}
			if (list.Count != 0)
			{
				rules = list.ToArray();
			}
		}
		catch (InvalidCastException ex)
		{
			e = ex;
			return false;
		}
		catch (ArgumentOutOfRangeException ex2)
		{
			e = ex2;
			return false;
		}
		catch (ArgumentException ex3)
		{
			e = ex3;
			return false;
		}
		return true;
	}

	private unsafe static bool TryGetTimeZoneEntryFromRegistry(RegistryKey key, string name, out Interop.Kernel32.REG_TZI_FORMAT dtzi)
	{
		if (!(key.GetValue(name, null, RegistryValueOptions.None) is byte[] array) || array.Length != sizeof(Interop.Kernel32.REG_TZI_FORMAT))
		{
			dtzi = default(Interop.Kernel32.REG_TZI_FORMAT);
			return false;
		}
		fixed (byte* ptr = &array[0])
		{
			dtzi = *(Interop.Kernel32.REG_TZI_FORMAT*)ptr;
		}
		return true;
	}

	private static bool TryCompareStandardDate(in Interop.Kernel32.TIME_ZONE_INFORMATION timeZone, in Interop.Kernel32.REG_TZI_FORMAT registryTimeZoneInfo)
	{
		if (timeZone.Bias == registryTimeZoneInfo.Bias && timeZone.StandardBias == registryTimeZoneInfo.StandardBias)
		{
			return timeZone.StandardDate.Equals(in registryTimeZoneInfo.StandardDate);
		}
		return false;
	}

	private static bool TryCompareTimeZoneInformationToRegistry(in Interop.Kernel32.TIME_ZONE_INFORMATION timeZone, string id, out bool dstDisabled)
	{
		dstDisabled = false;
		using RegistryKey registryKey = Registry.LocalMachine.OpenSubKey("SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Time Zones\\" + id, writable: false);
		if (registryKey == null)
		{
			return false;
		}
		if (!TryGetTimeZoneEntryFromRegistry(registryKey, "TZI", out var dtzi))
		{
			return false;
		}
		if (!TryCompareStandardDate(in timeZone, in dtzi))
		{
			return false;
		}
		bool flag = dstDisabled || CheckDaylightSavingTimeNotSupported(in timeZone) || (timeZone.DaylightBias == dtzi.DaylightBias && timeZone.DaylightDate.Equals(in dtzi.DaylightDate));
		if (flag)
		{
			flag = string.Equals(registryKey.GetValue("Std", string.Empty, RegistryValueOptions.None) as string, timeZone.GetStandardName(), StringComparison.Ordinal);
		}
		return flag;
	}

	private static string TryGetLocalizedNameByMuiNativeResource(string resource)
	{
		if (string.IsNullOrEmpty(resource))
		{
			return string.Empty;
		}
		string[] array = resource.Split(',');
		if (array.Length != 2)
		{
			return string.Empty;
		}
		string systemDirectory = Environment.SystemDirectory;
		string path = array[0].TrimStart('@');
		string filePath;
		try
		{
			filePath = Path.Combine(systemDirectory, path);
		}
		catch (ArgumentException)
		{
			return string.Empty;
		}
		if (!int.TryParse(array[1], NumberStyles.Integer, CultureInfo.InvariantCulture, out var result))
		{
			return string.Empty;
		}
		result = -result;
		try
		{
			StringBuilder stringBuilder = StringBuilderCache.Acquire(260);
			stringBuilder.Length = 260;
			int fileMuiPathLength = 260;
			int languageLength = 0;
			long enumerator = 0L;
			if (!Interop.Kernel32.GetFileMUIPath(16u, filePath, null, ref languageLength, stringBuilder, ref fileMuiPathLength, ref enumerator))
			{
				StringBuilderCache.Release(stringBuilder);
				return string.Empty;
			}
			return TryGetLocalizedNameByNativeResource(StringBuilderCache.GetStringAndRelease(stringBuilder), result);
		}
		catch (EntryPointNotFoundException)
		{
			return string.Empty;
		}
	}

	private static string TryGetLocalizedNameByNativeResource(string filePath, int resource)
	{
		using (SafeLibraryHandle safeLibraryHandle = Interop.Kernel32.LoadLibraryEx(filePath, IntPtr.Zero, 2))
		{
			if (!safeLibraryHandle.IsInvalid)
			{
				StringBuilder stringBuilder = StringBuilderCache.Acquire(500);
				if (Interop.User32.LoadString(safeLibraryHandle, resource, stringBuilder, 500) != 0)
				{
					return StringBuilderCache.GetStringAndRelease(stringBuilder);
				}
			}
		}
		return string.Empty;
	}

	private static void GetLocalizedNamesByRegistryKey(RegistryKey key, out string displayName, out string standardName, out string daylightName)
	{
		displayName = string.Empty;
		standardName = string.Empty;
		daylightName = string.Empty;
		string text = key.GetValue("MUI_Display", string.Empty, RegistryValueOptions.None) as string;
		string text2 = key.GetValue("MUI_Std", string.Empty, RegistryValueOptions.None) as string;
		string text3 = key.GetValue("MUI_Dlt", string.Empty, RegistryValueOptions.None) as string;
		if (!string.IsNullOrEmpty(text))
		{
			displayName = TryGetLocalizedNameByMuiNativeResource(text);
		}
		if (!string.IsNullOrEmpty(text2))
		{
			standardName = TryGetLocalizedNameByMuiNativeResource(text2);
		}
		if (!string.IsNullOrEmpty(text3))
		{
			daylightName = TryGetLocalizedNameByMuiNativeResource(text3);
		}
		if (string.IsNullOrEmpty(displayName))
		{
			displayName = key.GetValue("Display", string.Empty, RegistryValueOptions.None) as string;
		}
		if (string.IsNullOrEmpty(standardName))
		{
			standardName = key.GetValue("Std", string.Empty, RegistryValueOptions.None) as string;
		}
		if (string.IsNullOrEmpty(daylightName))
		{
			daylightName = key.GetValue("Dlt", string.Empty, RegistryValueOptions.None) as string;
		}
	}

	private static TimeZoneInfoResult TryGetTimeZoneFromLocalMachine(string id, out TimeZoneInfo value, out Exception e)
	{
		if (HaveRegistry)
		{
			return TryGetTimeZoneFromLocalRegistry(id, out value, out e);
		}
		e = null;
		value = FindSystemTimeZoneByIdWinRTFallback(id);
		return TimeZoneInfoResult.Success;
	}

	private static TimeZoneInfoResult TryGetTimeZoneFromLocalRegistry(string id, out TimeZoneInfo value, out Exception e)
	{
		e = null;
		using RegistryKey registryKey = Registry.LocalMachine.OpenSubKey("SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Time Zones\\" + id, writable: false);
		if (registryKey == null)
		{
			value = null;
			return TimeZoneInfoResult.TimeZoneNotFoundException;
		}
		if (!TryGetTimeZoneEntryFromRegistry(registryKey, "TZI", out var dtzi))
		{
			value = null;
			return TimeZoneInfoResult.InvalidTimeZoneException;
		}
		if (!TryCreateAdjustmentRules(id, in dtzi, out var rules, out e, dtzi.Bias))
		{
			value = null;
			return TimeZoneInfoResult.InvalidTimeZoneException;
		}
		GetLocalizedNamesByRegistryKey(registryKey, out var displayName, out var standardName, out var daylightName);
		try
		{
			value = new TimeZoneInfo(id, new TimeSpan(0, -dtzi.Bias, 0), displayName, standardName, daylightName, rules, disableDaylightSavingTime: false);
			return TimeZoneInfoResult.Success;
		}
		catch (ArgumentException ex)
		{
			value = null;
			e = ex;
			return TimeZoneInfoResult.InvalidTimeZoneException;
		}
		catch (InvalidTimeZoneException ex2)
		{
			value = null;
			e = ex2;
			return TimeZoneInfoResult.InvalidTimeZoneException;
		}
	}

	[DllImport("api-ms-win-core-timezone-l1-1-0.dll")]
	internal static extern uint EnumDynamicTimeZoneInformation(uint dwIndex, out DYNAMIC_TIME_ZONE_INFORMATION lpTimeZoneInformation);

	[DllImport("api-ms-win-core-timezone-l1-1-0.dll")]
	internal static extern uint GetDynamicTimeZoneInformation(out DYNAMIC_TIME_ZONE_INFORMATION pTimeZoneInformation);

	[DllImport("api-ms-win-core-timezone-l1-1-0.dll")]
	internal static extern uint GetDynamicTimeZoneInformationEffectiveYears(ref DYNAMIC_TIME_ZONE_INFORMATION lpTimeZoneInformation, out uint FirstYear, out uint LastYear);

	[DllImport("api-ms-win-core-timezone-l1-1-0.dll")]
	internal static extern bool GetTimeZoneInformationForYear(ushort wYear, ref DYNAMIC_TIME_ZONE_INFORMATION pdtzi, out Interop.Kernel32.TIME_ZONE_INFORMATION ptzi);

	internal static AdjustmentRule CreateAdjustmentRuleFromTimeZoneInformation(ref DYNAMIC_TIME_ZONE_INFORMATION timeZoneInformation, DateTime startDate, DateTime endDate, int defaultBaseUtcOffset)
	{
		if (timeZoneInformation.TZI.StandardDate.Month == 0)
		{
			if (timeZoneInformation.TZI.Bias == defaultBaseUtcOffset)
			{
				return null;
			}
			return AdjustmentRule.CreateAdjustmentRule(startDate, endDate, TimeSpan.Zero, TransitionTime.CreateFixedDateRule(DateTime.MinValue, 1, 1), TransitionTime.CreateFixedDateRule(DateTime.MinValue.AddMilliseconds(1.0), 1, 1), new TimeSpan(0, defaultBaseUtcOffset - timeZoneInformation.TZI.Bias, 0), noDaylightTransitions: false);
		}
		if (!TransitionTimeFromTimeZoneInformation(timeZoneInformation, out var transitionTime, readStartDate: true))
		{
			return null;
		}
		if (!TransitionTimeFromTimeZoneInformation(timeZoneInformation, out var transitionTime2, readStartDate: false))
		{
			return null;
		}
		if (transitionTime.Equals(transitionTime2))
		{
			return null;
		}
		return AdjustmentRule.CreateAdjustmentRule(startDate, endDate, new TimeSpan(0, -timeZoneInformation.TZI.DaylightBias, 0), transitionTime, transitionTime2, new TimeSpan(0, defaultBaseUtcOffset - timeZoneInformation.TZI.Bias, 0), noDaylightTransitions: false);
	}

	private static bool TransitionTimeFromTimeZoneInformation(DYNAMIC_TIME_ZONE_INFORMATION timeZoneInformation, out TransitionTime transitionTime, bool readStartDate)
	{
		if (timeZoneInformation.TZI.StandardDate.Month == 0)
		{
			transitionTime = default(TransitionTime);
			return false;
		}
		if (readStartDate)
		{
			if (timeZoneInformation.TZI.DaylightDate.Year == 0)
			{
				transitionTime = TransitionTime.CreateFloatingDateRule(new DateTime(1, 1, 1, timeZoneInformation.TZI.DaylightDate.Hour, timeZoneInformation.TZI.DaylightDate.Minute, timeZoneInformation.TZI.DaylightDate.Second, timeZoneInformation.TZI.DaylightDate.Milliseconds), timeZoneInformation.TZI.DaylightDate.Month, timeZoneInformation.TZI.DaylightDate.Day, (DayOfWeek)timeZoneInformation.TZI.DaylightDate.DayOfWeek);
			}
			else
			{
				transitionTime = TransitionTime.CreateFixedDateRule(new DateTime(1, 1, 1, timeZoneInformation.TZI.DaylightDate.Hour, timeZoneInformation.TZI.DaylightDate.Minute, timeZoneInformation.TZI.DaylightDate.Second, timeZoneInformation.TZI.DaylightDate.Milliseconds), timeZoneInformation.TZI.DaylightDate.Month, timeZoneInformation.TZI.DaylightDate.Day);
			}
		}
		else if (timeZoneInformation.TZI.StandardDate.Year == 0)
		{
			transitionTime = TransitionTime.CreateFloatingDateRule(new DateTime(1, 1, 1, timeZoneInformation.TZI.StandardDate.Hour, timeZoneInformation.TZI.StandardDate.Minute, timeZoneInformation.TZI.StandardDate.Second, timeZoneInformation.TZI.StandardDate.Milliseconds), timeZoneInformation.TZI.StandardDate.Month, timeZoneInformation.TZI.StandardDate.Day, (DayOfWeek)timeZoneInformation.TZI.StandardDate.DayOfWeek);
		}
		else
		{
			transitionTime = TransitionTime.CreateFixedDateRule(new DateTime(1, 1, 1, timeZoneInformation.TZI.StandardDate.Hour, timeZoneInformation.TZI.StandardDate.Minute, timeZoneInformation.TZI.StandardDate.Second, timeZoneInformation.TZI.StandardDate.Milliseconds), timeZoneInformation.TZI.StandardDate.Month, timeZoneInformation.TZI.StandardDate.Day);
		}
		return true;
	}

	internal static TimeZoneInfo TryCreateTimeZone(DYNAMIC_TIME_ZONE_INFORMATION timeZoneInformation)
	{
		uint FirstYear = 0u;
		uint LastYear = 0u;
		AdjustmentRule[] adjustmentRules = null;
		int bias = timeZoneInformation.TZI.Bias;
		if (string.IsNullOrEmpty(timeZoneInformation.TimeZoneKeyName))
		{
			return null;
		}
		try
		{
			if (GetDynamicTimeZoneInformationEffectiveYears(ref timeZoneInformation, out FirstYear, out LastYear) != 0)
			{
				FirstYear = (LastYear = 0u);
			}
		}
		catch
		{
			FirstYear = (LastYear = 0u);
		}
		if (FirstYear == LastYear)
		{
			AdjustmentRule adjustmentRule = CreateAdjustmentRuleFromTimeZoneInformation(ref timeZoneInformation, DateTime.MinValue.Date, DateTime.MaxValue.Date, bias);
			if (adjustmentRule != null)
			{
				adjustmentRules = new AdjustmentRule[1] { adjustmentRule };
			}
		}
		else
		{
			DYNAMIC_TIME_ZONE_INFORMATION timeZoneInformation2 = default(DYNAMIC_TIME_ZONE_INFORMATION);
			List<AdjustmentRule> list = new List<AdjustmentRule>();
			if (!GetTimeZoneInformationForYear((ushort)FirstYear, ref timeZoneInformation, out timeZoneInformation2.TZI))
			{
				return null;
			}
			AdjustmentRule adjustmentRule = CreateAdjustmentRuleFromTimeZoneInformation(ref timeZoneInformation2, DateTime.MinValue.Date, new DateTime((int)FirstYear, 12, 31), bias);
			if (adjustmentRule != null)
			{
				list.Add(adjustmentRule);
			}
			for (uint num = FirstYear + 1; num < LastYear; num++)
			{
				if (!GetTimeZoneInformationForYear((ushort)num, ref timeZoneInformation, out timeZoneInformation2.TZI))
				{
					return null;
				}
				adjustmentRule = CreateAdjustmentRuleFromTimeZoneInformation(ref timeZoneInformation2, new DateTime((int)num, 1, 1), new DateTime((int)num, 12, 31), bias);
				if (adjustmentRule != null)
				{
					list.Add(adjustmentRule);
				}
			}
			if (!GetTimeZoneInformationForYear((ushort)LastYear, ref timeZoneInformation, out timeZoneInformation2.TZI))
			{
				return null;
			}
			adjustmentRule = CreateAdjustmentRuleFromTimeZoneInformation(ref timeZoneInformation2, new DateTime((int)LastYear, 1, 1), DateTime.MaxValue.Date, bias);
			if (adjustmentRule != null)
			{
				list.Add(adjustmentRule);
			}
			if (list.Count > 0)
			{
				adjustmentRules = list.ToArray();
			}
		}
		return new TimeZoneInfo(timeZoneInformation.TimeZoneKeyName, new TimeSpan(0, -timeZoneInformation.TZI.Bias, 0), timeZoneInformation.TZI.GetStandardName(), timeZoneInformation.TZI.GetStandardName(), timeZoneInformation.TZI.GetDaylightName(), adjustmentRules, disableDaylightSavingTime: false);
	}

	internal static TimeZoneInfo GetLocalTimeZoneInfoWinRTFallback()
	{
		try
		{
			if (GetDynamicTimeZoneInformation(out var pTimeZoneInformation) == uint.MaxValue)
			{
				return Utc;
			}
			TimeZoneInfo timeZoneInfo = TryCreateTimeZone(pTimeZoneInformation);
			return (timeZoneInfo != null) ? timeZoneInfo : Utc;
		}
		catch
		{
			return Utc;
		}
	}

	internal static TimeZoneInfo FindSystemTimeZoneByIdWinRTFallback(string id)
	{
		foreach (TimeZoneInfo systemTimeZone in GetSystemTimeZones())
		{
			if (string.Compare(id, systemTimeZone.Id, StringComparison.Ordinal) == 0)
			{
				return systemTimeZone;
			}
		}
		throw new TimeZoneNotFoundException();
	}

	private static void GetSystemTimeZonesWinRTFallback(CachedData cachedData)
	{
		List<TimeZoneInfo> list = new List<TimeZoneInfo>();
		try
		{
			uint num = 0u;
			DYNAMIC_TIME_ZONE_INFORMATION lpTimeZoneInformation;
			while (EnumDynamicTimeZoneInformation(num++, out lpTimeZoneInformation) != 259)
			{
				TimeZoneInfo timeZoneInfo = TryCreateTimeZone(lpTimeZoneInformation);
				if (timeZoneInfo != null)
				{
					list.Add(timeZoneInfo);
				}
			}
		}
		catch
		{
		}
		if (list.Count == 0)
		{
			list.Add(Local);
			list.Add(Utc);
		}
		list.Sort(delegate(TimeZoneInfo x, TimeZoneInfo y)
		{
			int num2 = x.BaseUtcOffset.CompareTo(y.BaseUtcOffset);
			return (num2 != 0) ? num2 : string.CompareOrdinal(x.DisplayName, y.DisplayName);
		});
		foreach (TimeZoneInfo item in list)
		{
			if (cachedData._systemTimeZones == null)
			{
				cachedData._systemTimeZones = new Dictionary<string, TimeZoneInfo>(StringComparer.OrdinalIgnoreCase);
			}
			cachedData._systemTimeZones.Add(item.Id, item);
		}
	}

	private AdjustmentRule GetPreviousAdjustmentRule(AdjustmentRule rule, int? ruleIndex)
	{
		if (ruleIndex.HasValue && 0 < ruleIndex.Value && ruleIndex.Value < _adjustmentRules.Length)
		{
			return _adjustmentRules[ruleIndex.Value - 1];
		}
		AdjustmentRule result = rule;
		for (int i = 1; i < _adjustmentRules.Length; i++)
		{
			if (rule == _adjustmentRules[i])
			{
				result = _adjustmentRules[i - 1];
				break;
			}
		}
		return result;
	}

	public TimeSpan GetUtcOffset(DateTime dateTime)
	{
		return GetUtcOffset(dateTime, TimeZoneInfoOptions.NoThrowOnInvalidTime, s_cachedData);
	}

	internal static TimeSpan GetLocalUtcOffset(DateTime dateTime, TimeZoneInfoOptions flags)
	{
		CachedData cachedData = s_cachedData;
		return cachedData.Local.GetUtcOffset(dateTime, flags, cachedData);
	}

	internal TimeSpan GetUtcOffset(DateTime dateTime, TimeZoneInfoOptions flags)
	{
		return GetUtcOffset(dateTime, flags, s_cachedData);
	}

	private TimeSpan GetUtcOffset(DateTime dateTime, TimeZoneInfoOptions flags, CachedData cachedData)
	{
		if (dateTime.Kind == DateTimeKind.Local)
		{
			if (cachedData.GetCorrespondingKind(this) != DateTimeKind.Local)
			{
				return GetUtcOffsetFromUtc(ConvertTime(dateTime, cachedData.Local, s_utcTimeZone, flags), this);
			}
		}
		else if (dateTime.Kind == DateTimeKind.Utc)
		{
			if (cachedData.GetCorrespondingKind(this) == DateTimeKind.Utc)
			{
				return _baseUtcOffset;
			}
			return GetUtcOffsetFromUtc(dateTime, this);
		}
		return GetUtcOffset(dateTime, this, flags);
	}

	internal bool IsDaylightSavingTime(DateTime dateTime, TimeZoneInfoOptions flags)
	{
		return IsDaylightSavingTime(dateTime, flags, s_cachedData);
	}

	private bool IsDaylightSavingTime(DateTime dateTime, TimeZoneInfoOptions flags, CachedData cachedData)
	{
		if (!_supportsDaylightSavingTime || _adjustmentRules == null)
		{
			return false;
		}
		DateTime dateTime2;
		if (dateTime.Kind == DateTimeKind.Local)
		{
			dateTime2 = ConvertTime(dateTime, cachedData.Local, this, flags, cachedData);
		}
		else
		{
			if (dateTime.Kind == DateTimeKind.Utc)
			{
				if (cachedData.GetCorrespondingKind(this) == DateTimeKind.Utc)
				{
					return false;
				}
				GetUtcOffsetFromUtc(dateTime, this, out var isDaylightSavings);
				return isDaylightSavings;
			}
			dateTime2 = dateTime;
		}
		AdjustmentRule adjustmentRuleForTime = GetAdjustmentRuleForTime(dateTime2, out var ruleIndex);
		if (adjustmentRuleForTime != null && adjustmentRuleForTime.HasDaylightSaving)
		{
			DaylightTimeStruct daylightTime = GetDaylightTime(dateTime2.Year, adjustmentRuleForTime, ruleIndex);
			return GetIsDaylightSavings(dateTime2, adjustmentRuleForTime, daylightTime, flags);
		}
		return false;
	}

	public static void ClearCachedData()
	{
		s_cachedData = new CachedData();
	}

	internal static DateTime ConvertTime(DateTime dateTime, TimeZoneInfo sourceTimeZone, TimeZoneInfo destinationTimeZone, TimeZoneInfoOptions flags)
	{
		return ConvertTime(dateTime, sourceTimeZone, destinationTimeZone, flags, s_cachedData);
	}

	private static DateTime ConvertTime(DateTime dateTime, TimeZoneInfo sourceTimeZone, TimeZoneInfo destinationTimeZone, TimeZoneInfoOptions flags, CachedData cachedData)
	{
		if (sourceTimeZone == null)
		{
			throw new ArgumentNullException("sourceTimeZone");
		}
		if (destinationTimeZone == null)
		{
			throw new ArgumentNullException("destinationTimeZone");
		}
		DateTimeKind correspondingKind = cachedData.GetCorrespondingKind(sourceTimeZone);
		if ((flags & TimeZoneInfoOptions.NoThrowOnInvalidTime) == 0 && dateTime.Kind != DateTimeKind.Unspecified && dateTime.Kind != correspondingKind)
		{
			throw new ArgumentException("The conversion could not be completed because the supplied DateTime did not have the Kind property set correctly.  For example, when the Kind property is DateTimeKind.Local, the source time zone must be TimeZoneInfo.Local.", "sourceTimeZone");
		}
		AdjustmentRule adjustmentRuleForTime = sourceTimeZone.GetAdjustmentRuleForTime(dateTime, out var ruleIndex);
		TimeSpan baseUtcOffset = sourceTimeZone.BaseUtcOffset;
		if (adjustmentRuleForTime != null)
		{
			baseUtcOffset += adjustmentRuleForTime.BaseUtcOffsetDelta;
			if (adjustmentRuleForTime.HasDaylightSaving)
			{
				bool flag = false;
				DaylightTimeStruct daylightTime = sourceTimeZone.GetDaylightTime(dateTime.Year, adjustmentRuleForTime, ruleIndex);
				if ((flags & TimeZoneInfoOptions.NoThrowOnInvalidTime) == 0 && GetIsInvalidTime(dateTime, adjustmentRuleForTime, daylightTime))
				{
					throw new ArgumentException("The supplied DateTime represents an invalid time.  For example, when the clock is adjusted forward, any time in the period that is skipped is invalid.", "dateTime");
				}
				flag = GetIsDaylightSavings(dateTime, adjustmentRuleForTime, daylightTime, flags);
				baseUtcOffset += (flag ? adjustmentRuleForTime.DaylightDelta : TimeSpan.Zero);
			}
		}
		DateTimeKind correspondingKind2 = cachedData.GetCorrespondingKind(destinationTimeZone);
		if (dateTime.Kind != DateTimeKind.Unspecified && correspondingKind != DateTimeKind.Unspecified && correspondingKind == correspondingKind2)
		{
			return dateTime;
		}
		DateTime dateTime2 = ConvertUtcToTimeZone(dateTime.Ticks - baseUtcOffset.Ticks, destinationTimeZone, out var isAmbiguousLocalDst);
		if (correspondingKind2 == DateTimeKind.Local)
		{
			return new DateTime(dateTime2.Ticks, DateTimeKind.Local, isAmbiguousLocalDst);
		}
		return new DateTime(dateTime2.Ticks, correspondingKind2);
	}

	internal static DateTime ConvertTimeToUtc(DateTime dateTime, TimeZoneInfoOptions flags)
	{
		if (dateTime.Kind == DateTimeKind.Utc)
		{
			return dateTime;
		}
		CachedData cachedData = s_cachedData;
		return ConvertTime(dateTime, cachedData.Local, s_utcTimeZone, flags, cachedData);
	}

	public bool Equals(TimeZoneInfo other)
	{
		if (other != null && string.Equals(_id, other._id, StringComparison.OrdinalIgnoreCase))
		{
			return HasSameRules(other);
		}
		return false;
	}

	public override bool Equals(object obj)
	{
		return Equals(obj as TimeZoneInfo);
	}

	public override int GetHashCode()
	{
		return StringComparer.OrdinalIgnoreCase.GetHashCode(_id);
	}

	public static ReadOnlyCollection<TimeZoneInfo> GetSystemTimeZones()
	{
		CachedData cachedData = s_cachedData;
		lock (cachedData)
		{
			if (cachedData._readOnlySystemTimeZones == null)
			{
				PopulateAllSystemTimeZones(cachedData);
				cachedData._allSystemTimeZonesRead = true;
				List<TimeZoneInfo> list = ((cachedData._systemTimeZones == null) ? new List<TimeZoneInfo>() : new List<TimeZoneInfo>(cachedData._systemTimeZones.Values));
				list.Sort(delegate(TimeZoneInfo x, TimeZoneInfo y)
				{
					int num = x.BaseUtcOffset.CompareTo(y.BaseUtcOffset);
					return (num != 0) ? num : string.CompareOrdinal(x.DisplayName, y.DisplayName);
				});
				cachedData._readOnlySystemTimeZones = new ReadOnlyCollection<TimeZoneInfo>(list);
			}
		}
		return cachedData._readOnlySystemTimeZones;
	}

	public bool HasSameRules(TimeZoneInfo other)
	{
		if (other == null)
		{
			throw new ArgumentNullException("other");
		}
		if (_baseUtcOffset != other._baseUtcOffset || _supportsDaylightSavingTime != other._supportsDaylightSavingTime)
		{
			return false;
		}
		AdjustmentRule[] adjustmentRules = _adjustmentRules;
		AdjustmentRule[] adjustmentRules2 = other._adjustmentRules;
		bool flag = (adjustmentRules == null && adjustmentRules2 == null) || (adjustmentRules != null && adjustmentRules2 != null);
		if (!flag)
		{
			return false;
		}
		if (adjustmentRules != null)
		{
			if (adjustmentRules.Length != adjustmentRules2.Length)
			{
				return false;
			}
			for (int i = 0; i < adjustmentRules.Length; i++)
			{
				if (!adjustmentRules[i].Equals(adjustmentRules2[i]))
				{
					return false;
				}
			}
		}
		return flag;
	}

	public override string ToString()
	{
		return DisplayName;
	}

	private TimeZoneInfo(string id, TimeSpan baseUtcOffset, string displayName, string standardDisplayName, string daylightDisplayName, AdjustmentRule[] adjustmentRules, bool disableDaylightSavingTime)
	{
		ValidateTimeZoneInfo(id, baseUtcOffset, adjustmentRules, out var adjustmentRulesSupportDst);
		_id = id;
		_baseUtcOffset = baseUtcOffset;
		_displayName = displayName;
		_standardDisplayName = standardDisplayName;
		_daylightDisplayName = (disableDaylightSavingTime ? null : daylightDisplayName);
		_supportsDaylightSavingTime = adjustmentRulesSupportDst && !disableDaylightSavingTime;
		_adjustmentRules = adjustmentRules;
	}

	public static TimeZoneInfo CreateCustomTimeZone(string id, TimeSpan baseUtcOffset, string displayName, string standardDisplayName)
	{
		return new TimeZoneInfo(id, baseUtcOffset, displayName, standardDisplayName, standardDisplayName, null, disableDaylightSavingTime: false);
	}

	void IDeserializationCallback.OnDeserialization(object sender)
	{
		try
		{
			ValidateTimeZoneInfo(_id, _baseUtcOffset, _adjustmentRules, out var adjustmentRulesSupportDst);
			if (adjustmentRulesSupportDst != _supportsDaylightSavingTime)
			{
				throw new SerializationException(SR.Format("The value of the field '{0}' is invalid.  The serialized data is corrupt.", "SupportsDaylightSavingTime"));
			}
		}
		catch (ArgumentException innerException)
		{
			throw new SerializationException("An error occurred while deserializing the object.  The serialized data is corrupt.", innerException);
		}
		catch (InvalidTimeZoneException innerException2)
		{
			throw new SerializationException("An error occurred while deserializing the object.  The serialized data is corrupt.", innerException2);
		}
	}

	void ISerializable.GetObjectData(SerializationInfo info, StreamingContext context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
		info.AddValue("Id", _id);
		info.AddValue("DisplayName", _displayName);
		info.AddValue("StandardName", _standardDisplayName);
		info.AddValue("DaylightName", _daylightDisplayName);
		info.AddValue("BaseUtcOffset", _baseUtcOffset);
		info.AddValue("AdjustmentRules", _adjustmentRules);
		info.AddValue("SupportsDaylightSavingTime", _supportsDaylightSavingTime);
	}

	private TimeZoneInfo(SerializationInfo info, StreamingContext context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
		_id = (string)info.GetValue("Id", typeof(string));
		_displayName = (string)info.GetValue("DisplayName", typeof(string));
		_standardDisplayName = (string)info.GetValue("StandardName", typeof(string));
		_daylightDisplayName = (string)info.GetValue("DaylightName", typeof(string));
		_baseUtcOffset = (TimeSpan)info.GetValue("BaseUtcOffset", typeof(TimeSpan));
		_adjustmentRules = (AdjustmentRule[])info.GetValue("AdjustmentRules", typeof(AdjustmentRule[]));
		_supportsDaylightSavingTime = (bool)info.GetValue("SupportsDaylightSavingTime", typeof(bool));
	}

	private AdjustmentRule GetAdjustmentRuleForTime(DateTime dateTime, out int? ruleIndex)
	{
		return GetAdjustmentRuleForTime(dateTime, dateTimeisUtc: false, out ruleIndex);
	}

	private AdjustmentRule GetAdjustmentRuleForTime(DateTime dateTime, bool dateTimeisUtc, out int? ruleIndex)
	{
		if (_adjustmentRules == null || _adjustmentRules.Length == 0)
		{
			ruleIndex = null;
			return null;
		}
		DateTime dateOnly = (dateTimeisUtc ? (dateTime + BaseUtcOffset).Date : dateTime.Date);
		int num = 0;
		int num2 = _adjustmentRules.Length - 1;
		while (num <= num2)
		{
			int num3 = num + (num2 - num >> 1);
			AdjustmentRule adjustmentRule = _adjustmentRules[num3];
			AdjustmentRule previousRule = ((num3 > 0) ? _adjustmentRules[num3 - 1] : adjustmentRule);
			int num4 = CompareAdjustmentRuleToDateTime(adjustmentRule, previousRule, dateTime, dateOnly, dateTimeisUtc);
			if (num4 == 0)
			{
				ruleIndex = num3;
				return adjustmentRule;
			}
			if (num4 < 0)
			{
				num = num3 + 1;
			}
			else
			{
				num2 = num3 - 1;
			}
		}
		ruleIndex = null;
		return null;
	}

	private int CompareAdjustmentRuleToDateTime(AdjustmentRule rule, AdjustmentRule previousRule, DateTime dateTime, DateTime dateOnly, bool dateTimeisUtc)
	{
		if (!((rule.DateStart.Kind != DateTimeKind.Utc) ? (dateOnly >= rule.DateStart) : ((dateTimeisUtc ? dateTime : ConvertToUtc(dateTime, previousRule.DaylightDelta, previousRule.BaseUtcOffsetDelta)) >= rule.DateStart)))
		{
			return 1;
		}
		if (!((rule.DateEnd.Kind != DateTimeKind.Utc) ? (dateOnly <= rule.DateEnd) : ((dateTimeisUtc ? dateTime : ConvertToUtc(dateTime, rule.DaylightDelta, rule.BaseUtcOffsetDelta)) <= rule.DateEnd)))
		{
			return -1;
		}
		return 0;
	}

	private DateTime ConvertToUtc(DateTime dateTime, TimeSpan daylightDelta, TimeSpan baseUtcOffsetDelta)
	{
		return ConvertToFromUtc(dateTime, daylightDelta, baseUtcOffsetDelta, convertToUtc: true);
	}

	private DateTime ConvertFromUtc(DateTime dateTime, TimeSpan daylightDelta, TimeSpan baseUtcOffsetDelta)
	{
		return ConvertToFromUtc(dateTime, daylightDelta, baseUtcOffsetDelta, convertToUtc: false);
	}

	private DateTime ConvertToFromUtc(DateTime dateTime, TimeSpan daylightDelta, TimeSpan baseUtcOffsetDelta, bool convertToUtc)
	{
		TimeSpan timeSpan = BaseUtcOffset + daylightDelta + baseUtcOffsetDelta;
		if (convertToUtc)
		{
			timeSpan = timeSpan.Negate();
		}
		long num = dateTime.Ticks + timeSpan.Ticks;
		if (num <= DateTime.MaxValue.Ticks)
		{
			if (num >= DateTime.MinValue.Ticks)
			{
				return new DateTime(num);
			}
			return DateTime.MinValue;
		}
		return DateTime.MaxValue;
	}

	private static DateTime ConvertUtcToTimeZone(long ticks, TimeZoneInfo destinationTimeZone, out bool isAmbiguousLocalDst)
	{
		ticks += GetUtcOffsetFromUtc((ticks > DateTime.MaxValue.Ticks) ? DateTime.MaxValue : ((ticks < DateTime.MinValue.Ticks) ? DateTime.MinValue : new DateTime(ticks)), destinationTimeZone, out isAmbiguousLocalDst).Ticks;
		if (ticks <= DateTime.MaxValue.Ticks)
		{
			if (ticks >= DateTime.MinValue.Ticks)
			{
				return new DateTime(ticks);
			}
			return DateTime.MinValue;
		}
		return DateTime.MaxValue;
	}

	private DaylightTimeStruct GetDaylightTime(int year, AdjustmentRule rule, int? ruleIndex)
	{
		TimeSpan daylightDelta = rule.DaylightDelta;
		DateTime start;
		DateTime end;
		if (rule.NoDaylightTransitions)
		{
			AdjustmentRule previousAdjustmentRule = GetPreviousAdjustmentRule(rule, ruleIndex);
			start = ConvertFromUtc(rule.DateStart, previousAdjustmentRule.DaylightDelta, previousAdjustmentRule.BaseUtcOffsetDelta);
			end = ConvertFromUtc(rule.DateEnd, rule.DaylightDelta, rule.BaseUtcOffsetDelta);
		}
		else
		{
			start = TransitionTimeToDateTime(year, rule.DaylightTransitionStart);
			end = TransitionTimeToDateTime(year, rule.DaylightTransitionEnd);
		}
		return new DaylightTimeStruct(start, end, daylightDelta);
	}

	private static bool GetIsDaylightSavings(DateTime time, AdjustmentRule rule, DaylightTimeStruct daylightTime, TimeZoneInfoOptions flags)
	{
		if (rule == null)
		{
			return false;
		}
		DateTime startTime;
		DateTime endTime;
		if (time.Kind == DateTimeKind.Local)
		{
			startTime = (rule.IsStartDateMarkerForBeginningOfYear() ? new DateTime(daylightTime.Start.Year, 1, 1, 0, 0, 0) : (daylightTime.Start + daylightTime.Delta));
			endTime = (rule.IsEndDateMarkerForEndOfYear() ? new DateTime(daylightTime.End.Year + 1, 1, 1, 0, 0, 0).AddTicks(-1L) : daylightTime.End);
		}
		else
		{
			bool flag = rule.DaylightDelta > TimeSpan.Zero;
			startTime = (rule.IsStartDateMarkerForBeginningOfYear() ? new DateTime(daylightTime.Start.Year, 1, 1, 0, 0, 0) : (daylightTime.Start + (flag ? rule.DaylightDelta : TimeSpan.Zero)));
			endTime = (rule.IsEndDateMarkerForEndOfYear() ? new DateTime(daylightTime.End.Year + 1, 1, 1, 0, 0, 0).AddTicks(-1L) : (daylightTime.End + (flag ? (-rule.DaylightDelta) : TimeSpan.Zero)));
		}
		bool flag2 = CheckIsDst(startTime, time, endTime, ignoreYearAdjustment: false, rule);
		if (flag2 && time.Kind == DateTimeKind.Local && GetIsAmbiguousTime(time, rule, daylightTime))
		{
			flag2 = time.IsAmbiguousDaylightSavingTime();
		}
		return flag2;
	}

	private TimeSpan GetDaylightSavingsStartOffsetFromUtc(TimeSpan baseUtcOffset, AdjustmentRule rule, int? ruleIndex)
	{
		if (rule.NoDaylightTransitions)
		{
			AdjustmentRule previousAdjustmentRule = GetPreviousAdjustmentRule(rule, ruleIndex);
			return baseUtcOffset + previousAdjustmentRule.BaseUtcOffsetDelta + previousAdjustmentRule.DaylightDelta;
		}
		return baseUtcOffset + rule.BaseUtcOffsetDelta;
	}

	private TimeSpan GetDaylightSavingsEndOffsetFromUtc(TimeSpan baseUtcOffset, AdjustmentRule rule)
	{
		return baseUtcOffset + rule.BaseUtcOffsetDelta + rule.DaylightDelta;
	}

	private static bool GetIsDaylightSavingsFromUtc(DateTime time, int year, TimeSpan utc, AdjustmentRule rule, int? ruleIndex, out bool isAmbiguousLocalDst, TimeZoneInfo zone)
	{
		isAmbiguousLocalDst = false;
		if (rule == null)
		{
			return false;
		}
		DaylightTimeStruct daylightTime = zone.GetDaylightTime(year, rule, ruleIndex);
		bool ignoreYearAdjustment = false;
		TimeSpan daylightSavingsStartOffsetFromUtc = zone.GetDaylightSavingsStartOffsetFromUtc(utc, rule, ruleIndex);
		DateTime dateTime;
		if (rule.IsStartDateMarkerForBeginningOfYear() && daylightTime.Start.Year > DateTime.MinValue.Year)
		{
			AdjustmentRule adjustmentRuleForTime = zone.GetAdjustmentRuleForTime(new DateTime(daylightTime.Start.Year - 1, 12, 31), out var ruleIndex2);
			if (adjustmentRuleForTime != null && adjustmentRuleForTime.IsEndDateMarkerForEndOfYear())
			{
				dateTime = zone.GetDaylightTime(daylightTime.Start.Year - 1, adjustmentRuleForTime, ruleIndex2).Start - utc - adjustmentRuleForTime.BaseUtcOffsetDelta;
				ignoreYearAdjustment = true;
			}
			else
			{
				dateTime = new DateTime(daylightTime.Start.Year, 1, 1, 0, 0, 0) - daylightSavingsStartOffsetFromUtc;
			}
		}
		else
		{
			dateTime = daylightTime.Start - daylightSavingsStartOffsetFromUtc;
		}
		TimeSpan daylightSavingsEndOffsetFromUtc = zone.GetDaylightSavingsEndOffsetFromUtc(utc, rule);
		DateTime dateTime2;
		if (rule.IsEndDateMarkerForEndOfYear() && daylightTime.End.Year < DateTime.MaxValue.Year)
		{
			AdjustmentRule adjustmentRuleForTime2 = zone.GetAdjustmentRuleForTime(new DateTime(daylightTime.End.Year + 1, 1, 1), out var ruleIndex3);
			if (adjustmentRuleForTime2 != null && adjustmentRuleForTime2.IsStartDateMarkerForBeginningOfYear())
			{
				dateTime2 = ((!adjustmentRuleForTime2.IsEndDateMarkerForEndOfYear()) ? (zone.GetDaylightTime(daylightTime.End.Year + 1, adjustmentRuleForTime2, ruleIndex3).End - utc - adjustmentRuleForTime2.BaseUtcOffsetDelta - adjustmentRuleForTime2.DaylightDelta) : (new DateTime(daylightTime.End.Year + 1, 12, 31) - utc - adjustmentRuleForTime2.BaseUtcOffsetDelta - adjustmentRuleForTime2.DaylightDelta));
				ignoreYearAdjustment = true;
			}
			else
			{
				dateTime2 = new DateTime(daylightTime.End.Year + 1, 1, 1, 0, 0, 0).AddTicks(-1L) - daylightSavingsEndOffsetFromUtc;
			}
		}
		else
		{
			dateTime2 = daylightTime.End - daylightSavingsEndOffsetFromUtc;
		}
		DateTime dateTime3;
		DateTime dateTime4;
		if (daylightTime.Delta.Ticks > 0)
		{
			dateTime3 = dateTime2 - daylightTime.Delta;
			dateTime4 = dateTime2;
		}
		else
		{
			dateTime3 = dateTime;
			dateTime4 = dateTime - daylightTime.Delta;
		}
		bool flag = CheckIsDst(dateTime, time, dateTime2, ignoreYearAdjustment, rule);
		if (flag)
		{
			isAmbiguousLocalDst = time >= dateTime3 && time < dateTime4;
			if (!isAmbiguousLocalDst && dateTime3.Year != dateTime4.Year)
			{
				try
				{
					dateTime3.AddYears(1);
					dateTime4.AddYears(1);
					isAmbiguousLocalDst = time >= dateTime3 && time < dateTime4;
				}
				catch (ArgumentOutOfRangeException)
				{
				}
				if (!isAmbiguousLocalDst)
				{
					try
					{
						dateTime3.AddYears(-1);
						dateTime4.AddYears(-1);
						isAmbiguousLocalDst = time >= dateTime3 && time < dateTime4;
					}
					catch (ArgumentOutOfRangeException)
					{
					}
				}
			}
		}
		return flag;
	}

	private static bool CheckIsDst(DateTime startTime, DateTime time, DateTime endTime, bool ignoreYearAdjustment, AdjustmentRule rule)
	{
		if (!ignoreYearAdjustment && !rule.NoDaylightTransitions)
		{
			int year = startTime.Year;
			int year2 = endTime.Year;
			if (year != year2)
			{
				endTime = endTime.AddYears(year - year2);
			}
			int year3 = time.Year;
			if (year != year3)
			{
				time = time.AddYears(year - year3);
			}
		}
		if (startTime > endTime)
		{
			if (!(time < endTime))
			{
				return time >= startTime;
			}
			return true;
		}
		if (rule.NoDaylightTransitions)
		{
			if (time >= startTime)
			{
				return time <= endTime;
			}
			return false;
		}
		if (time >= startTime)
		{
			return time < endTime;
		}
		return false;
	}

	private static bool GetIsAmbiguousTime(DateTime time, AdjustmentRule rule, DaylightTimeStruct daylightTime)
	{
		bool result = false;
		if (rule == null || rule.DaylightDelta == TimeSpan.Zero)
		{
			return result;
		}
		DateTime dateTime;
		DateTime dateTime2;
		if (rule.DaylightDelta > TimeSpan.Zero)
		{
			if (rule.IsEndDateMarkerForEndOfYear())
			{
				return false;
			}
			dateTime = daylightTime.End;
			dateTime2 = daylightTime.End - rule.DaylightDelta;
		}
		else
		{
			if (rule.IsStartDateMarkerForBeginningOfYear())
			{
				return false;
			}
			dateTime = daylightTime.Start;
			dateTime2 = daylightTime.Start + rule.DaylightDelta;
		}
		result = time >= dateTime2 && time < dateTime;
		if (!result && dateTime.Year != dateTime2.Year)
		{
			try
			{
				DateTime dateTime3 = dateTime.AddYears(1);
				DateTime dateTime4 = dateTime2.AddYears(1);
				result = time >= dateTime4 && time < dateTime3;
			}
			catch (ArgumentOutOfRangeException)
			{
			}
			if (!result)
			{
				try
				{
					DateTime dateTime3 = dateTime.AddYears(-1);
					DateTime dateTime4 = dateTime2.AddYears(-1);
					result = time >= dateTime4 && time < dateTime3;
				}
				catch (ArgumentOutOfRangeException)
				{
				}
			}
		}
		return result;
	}

	private static bool GetIsInvalidTime(DateTime time, AdjustmentRule rule, DaylightTimeStruct daylightTime)
	{
		bool result = false;
		if (rule == null || rule.DaylightDelta == TimeSpan.Zero)
		{
			return result;
		}
		DateTime dateTime;
		DateTime dateTime2;
		if (rule.DaylightDelta < TimeSpan.Zero)
		{
			if (rule.IsEndDateMarkerForEndOfYear())
			{
				return false;
			}
			dateTime = daylightTime.End;
			dateTime2 = daylightTime.End - rule.DaylightDelta;
		}
		else
		{
			if (rule.IsStartDateMarkerForBeginningOfYear())
			{
				return false;
			}
			dateTime = daylightTime.Start;
			dateTime2 = daylightTime.Start + rule.DaylightDelta;
		}
		result = time >= dateTime && time < dateTime2;
		if (!result && dateTime.Year != dateTime2.Year)
		{
			try
			{
				DateTime dateTime3 = dateTime.AddYears(1);
				DateTime dateTime4 = dateTime2.AddYears(1);
				result = time >= dateTime3 && time < dateTime4;
			}
			catch (ArgumentOutOfRangeException)
			{
			}
			if (!result)
			{
				try
				{
					DateTime dateTime3 = dateTime.AddYears(-1);
					DateTime dateTime4 = dateTime2.AddYears(-1);
					result = time >= dateTime3 && time < dateTime4;
				}
				catch (ArgumentOutOfRangeException)
				{
				}
			}
		}
		return result;
	}

	private static TimeSpan GetUtcOffset(DateTime time, TimeZoneInfo zone, TimeZoneInfoOptions flags)
	{
		TimeSpan baseUtcOffset = zone.BaseUtcOffset;
		AdjustmentRule adjustmentRuleForTime = zone.GetAdjustmentRuleForTime(time, out var ruleIndex);
		if (adjustmentRuleForTime != null)
		{
			baseUtcOffset += adjustmentRuleForTime.BaseUtcOffsetDelta;
			if (adjustmentRuleForTime.HasDaylightSaving)
			{
				DaylightTimeStruct daylightTime = zone.GetDaylightTime(time.Year, adjustmentRuleForTime, ruleIndex);
				bool isDaylightSavings = GetIsDaylightSavings(time, adjustmentRuleForTime, daylightTime, flags);
				baseUtcOffset += (isDaylightSavings ? adjustmentRuleForTime.DaylightDelta : TimeSpan.Zero);
			}
		}
		return baseUtcOffset;
	}

	private static TimeSpan GetUtcOffsetFromUtc(DateTime time, TimeZoneInfo zone)
	{
		bool isDaylightSavings;
		return GetUtcOffsetFromUtc(time, zone, out isDaylightSavings);
	}

	private static TimeSpan GetUtcOffsetFromUtc(DateTime time, TimeZoneInfo zone, out bool isDaylightSavings)
	{
		bool isAmbiguousLocalDst;
		return GetUtcOffsetFromUtc(time, zone, out isDaylightSavings, out isAmbiguousLocalDst);
	}

	internal static TimeSpan GetUtcOffsetFromUtc(DateTime time, TimeZoneInfo zone, out bool isDaylightSavings, out bool isAmbiguousLocalDst)
	{
		isDaylightSavings = false;
		isAmbiguousLocalDst = false;
		TimeSpan baseUtcOffset = zone.BaseUtcOffset;
		AdjustmentRule adjustmentRuleForTime;
		int? ruleIndex;
		int year;
		if (time > s_maxDateOnly)
		{
			adjustmentRuleForTime = zone.GetAdjustmentRuleForTime(DateTime.MaxValue, out ruleIndex);
			year = 9999;
		}
		else if (time < s_minDateOnly)
		{
			adjustmentRuleForTime = zone.GetAdjustmentRuleForTime(DateTime.MinValue, out ruleIndex);
			year = 1;
		}
		else
		{
			adjustmentRuleForTime = zone.GetAdjustmentRuleForTime(time, dateTimeisUtc: true, out ruleIndex);
			year = (time + baseUtcOffset).Year;
		}
		if (adjustmentRuleForTime != null)
		{
			baseUtcOffset += adjustmentRuleForTime.BaseUtcOffsetDelta;
			if (adjustmentRuleForTime.HasDaylightSaving)
			{
				isDaylightSavings = GetIsDaylightSavingsFromUtc(time, year, zone._baseUtcOffset, adjustmentRuleForTime, ruleIndex, out isAmbiguousLocalDst, zone);
				baseUtcOffset += (isDaylightSavings ? adjustmentRuleForTime.DaylightDelta : TimeSpan.Zero);
			}
		}
		return baseUtcOffset;
	}

	internal static DateTime TransitionTimeToDateTime(int year, TransitionTime transitionTime)
	{
		DateTime timeOfDay = transitionTime.TimeOfDay;
		DateTime result;
		if (transitionTime.IsFixedDateRule)
		{
			int num = DateTime.DaysInMonth(year, transitionTime.Month);
			result = new DateTime(year, transitionTime.Month, (num < transitionTime.Day) ? num : transitionTime.Day, timeOfDay.Hour, timeOfDay.Minute, timeOfDay.Second, timeOfDay.Millisecond);
		}
		else if (transitionTime.Week <= 4)
		{
			result = new DateTime(year, transitionTime.Month, 1, timeOfDay.Hour, timeOfDay.Minute, timeOfDay.Second, timeOfDay.Millisecond);
			int dayOfWeek = (int)result.DayOfWeek;
			int num2 = (int)(transitionTime.DayOfWeek - dayOfWeek);
			if (num2 < 0)
			{
				num2 += 7;
			}
			num2 += 7 * (transitionTime.Week - 1);
			if (num2 > 0)
			{
				return result.AddDays(num2);
			}
		}
		else
		{
			int day = DateTime.DaysInMonth(year, transitionTime.Month);
			result = new DateTime(year, transitionTime.Month, day, timeOfDay.Hour, timeOfDay.Minute, timeOfDay.Second, timeOfDay.Millisecond);
			int num3 = result.DayOfWeek - transitionTime.DayOfWeek;
			if (num3 < 0)
			{
				num3 += 7;
			}
			if (num3 > 0)
			{
				return result.AddDays(-num3);
			}
		}
		return result;
	}

	private static TimeZoneInfoResult TryGetTimeZone(string id, bool dstDisabled, out TimeZoneInfo value, out Exception e, CachedData cachedData, bool alwaysFallbackToLocalMachine = false)
	{
		TimeZoneInfoResult result = TimeZoneInfoResult.Success;
		e = null;
		TimeZoneInfo value2 = null;
		if (cachedData._systemTimeZones != null && cachedData._systemTimeZones.TryGetValue(id, out value2))
		{
			if (dstDisabled && value2._supportsDaylightSavingTime)
			{
				value = CreateCustomTimeZone(value2._id, value2._baseUtcOffset, value2._displayName, value2._standardDisplayName);
			}
			else
			{
				value = new TimeZoneInfo(value2._id, value2._baseUtcOffset, value2._displayName, value2._standardDisplayName, value2._daylightDisplayName, value2._adjustmentRules, disableDaylightSavingTime: false);
			}
			return result;
		}
		if (!cachedData._allSystemTimeZonesRead | alwaysFallbackToLocalMachine)
		{
			result = TryGetTimeZoneFromLocalMachine(id, dstDisabled, out value, out e, cachedData);
		}
		else
		{
			result = TimeZoneInfoResult.TimeZoneNotFoundException;
			value = null;
		}
		return result;
	}

	private static TimeZoneInfoResult TryGetTimeZoneFromLocalMachine(string id, bool dstDisabled, out TimeZoneInfo value, out Exception e, CachedData cachedData)
	{
		TimeZoneInfoResult num = TryGetTimeZoneFromLocalMachine(id, out var value2, out e);
		if (num == TimeZoneInfoResult.Success)
		{
			if (cachedData._systemTimeZones == null)
			{
				cachedData._systemTimeZones = new Dictionary<string, TimeZoneInfo>(StringComparer.OrdinalIgnoreCase);
			}
			if (!cachedData._systemTimeZones.ContainsKey(id))
			{
				cachedData._systemTimeZones.Add(id, value2);
			}
			if (dstDisabled && value2._supportsDaylightSavingTime)
			{
				value = CreateCustomTimeZone(value2._id, value2._baseUtcOffset, value2._displayName, value2._standardDisplayName);
				return num;
			}
			value = new TimeZoneInfo(value2._id, value2._baseUtcOffset, value2._displayName, value2._standardDisplayName, value2._daylightDisplayName, value2._adjustmentRules, disableDaylightSavingTime: false);
			return num;
		}
		value = null;
		return num;
	}

	private static void ValidateTimeZoneInfo(string id, TimeSpan baseUtcOffset, AdjustmentRule[] adjustmentRules, out bool adjustmentRulesSupportDst)
	{
		if (id == null)
		{
			throw new ArgumentNullException("id");
		}
		if (id.Length == 0)
		{
			throw new ArgumentException(SR.Format("The specified ID parameter '{0}' is not supported.", id), "id");
		}
		if (UtcOffsetOutOfRange(baseUtcOffset))
		{
			throw new ArgumentOutOfRangeException("baseUtcOffset", "The TimeSpan parameter must be within plus or minus 14.0 hours.");
		}
		if (baseUtcOffset.Ticks % 600000000 != 0L)
		{
			throw new ArgumentException("The TimeSpan parameter cannot be specified more precisely than whole minutes.", "baseUtcOffset");
		}
		adjustmentRulesSupportDst = false;
		if (adjustmentRules == null || adjustmentRules.Length == 0)
		{
			return;
		}
		adjustmentRulesSupportDst = true;
		AdjustmentRule adjustmentRule = null;
		AdjustmentRule adjustmentRule2 = null;
		for (int i = 0; i < adjustmentRules.Length; i++)
		{
			adjustmentRule = adjustmentRule2;
			adjustmentRule2 = adjustmentRules[i];
			if (adjustmentRule2 == null)
			{
				throw new InvalidTimeZoneException("The AdjustmentRule array cannot contain null elements.");
			}
			if (!IsValidAdjustmentRuleOffest(baseUtcOffset, adjustmentRule2))
			{
				throw new InvalidTimeZoneException("The sum of the BaseUtcOffset and DaylightDelta properties must within plus or minus 14.0 hours.");
			}
			if (adjustmentRule != null && adjustmentRule2.DateStart <= adjustmentRule.DateEnd)
			{
				throw new InvalidTimeZoneException("The elements of the AdjustmentRule array must be in chronological order and must not overlap.");
			}
		}
	}

	internal static bool UtcOffsetOutOfRange(TimeSpan offset)
	{
		if (!(offset < MinOffset))
		{
			return offset > MaxOffset;
		}
		return true;
	}

	private static TimeSpan GetUtcOffset(TimeSpan baseUtcOffset, AdjustmentRule adjustmentRule)
	{
		return baseUtcOffset + adjustmentRule.BaseUtcOffsetDelta + (adjustmentRule.HasDaylightSaving ? adjustmentRule.DaylightDelta : TimeSpan.Zero);
	}

	private static bool IsValidAdjustmentRuleOffest(TimeSpan baseUtcOffset, AdjustmentRule adjustmentRule)
	{
		return !UtcOffsetOutOfRange(GetUtcOffset(baseUtcOffset, adjustmentRule));
	}

	internal TimeZoneInfo()
	{
		ThrowStub.ThrowNotSupportedException();
	}
}
