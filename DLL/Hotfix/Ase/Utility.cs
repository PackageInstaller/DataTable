#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Globalization;
using System.Text;
using GameFramework;
using UnityEngine;

namespace Ase;

public static class Utility
{
	public static class Convert
	{
		public static int StringToInt(string paramStr)
		{
			int.TryParse(paramStr, out var result);
			return result;
		}

		public static uint StringToUInt(string paramStr)
		{
			uint.TryParse(paramStr, out var result);
			return result;
		}

		public static float StringToFloat(string paramStr)
		{
			float.TryParse(paramStr, out var result);
			return result;
		}

		public static bool StringToBool(string paramStr)
		{
			bool.TryParse(paramStr, out var result);
			return result;
		}

		public static T StringToEnum<T>(string paramStr) where T : struct
		{
			Enum.TryParse<T>(paramStr, out var result);
			return result;
		}

		public static Vector2 StringToVector2(string param1, string param2)
		{
			return new Vector2(StringToFloat(param1), StringToFloat(param2));
		}

		public static Vector3 StringToVector3(string param1, string param2, string param3)
		{
			return new Vector3(StringToFloat(param1), StringToFloat(param2), StringToFloat(param3));
		}

		public static string DamageNumberToString(float number)
		{
			float num = number / 100000000f;
			int num2 = (int)num;
			if (num < 1f)
			{
				return number.ToString("0");
			}
			if (num >= 1f && num < 100000f)
			{
				float num3 = (float)num2 + (float)num2 / 10000f;
				if (num >= num3)
				{
					string text = num.ToString("0.0000");
					text = text.Remove(6, text.Length - 6);
					if (text.EndsWith("."))
					{
						text = text.Remove(text.Length - 1, 1);
					}
					return text + "亿";
				}
				return num2 + "亿";
			}
			return num2 + "亿";
		}
	}

	public static class DateTime
	{
		private static readonly System.DateTime UnixEpoch = new System.DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc);

		public static string GetLeftDateTime(long leftTime, string format)
		{
			int num = 0;
			int num2 = 0;
			if (leftTime > int.MaxValue)
			{
				num = (int)(leftTime / 60);
				num2 = (int)(leftTime - num * 60);
			}
			else
			{
				num2 = (int)leftTime;
			}
			return new TimeSpan(0, num, num2).ToString(format);
		}

		public static string GetLeftDateHour(long leftTime, string format)
		{
			if (leftTime <= 0)
			{
				return "";
			}
			int num = 0;
			int num2 = 0;
			int num3 = 0;
			num = (int)(leftTime / 86400);
			num2 = (int)(leftTime % 86400) / 3600;
			num3 = (int)(leftTime % 3600) / 60;
			if (num3 > 0)
			{
				num2++;
			}
			if (num2 == 24)
			{
				num++;
				num2 = 0;
			}
			return new TimeSpan(num, num2, num3, 0).ToString(format);
		}

		public static string GetLeftDateHourExact(long leftTime, string format)
		{
			if (leftTime <= 0)
			{
				return "";
			}
			int num = 0;
			int num2 = 0;
			int num3 = 0;
			num = (int)(leftTime / 86400);
			num2 = (int)(leftTime % 86400) / 3600;
			num3 = (int)(leftTime % 3600) / 60;
			return new TimeSpan(num, num2, num3, 0).ToString(format);
		}

		public static string GetLeftDateTimeWithLatest(long leftTime)
		{
			int num = 0;
			int num2 = 0;
			if (leftTime > int.MaxValue)
			{
				num = (int)(leftTime / 60);
				num2 = (int)(leftTime - num * 60);
			}
			else
			{
				num2 = (int)leftTime;
			}
			TimeSpan timeSpan = new TimeSpan(0, num, num2);
			if (leftTime >= 3600)
			{
				return timeSpan.ToString("hh\\时mm\\分ss\\秒");
			}
			if (leftTime >= 60)
			{
				return timeSpan.ToString("mm\\分ss\\秒");
			}
			return timeSpan.ToString("ss\\秒");
		}

		public static string GetLeftDateTimeWithLatest(long leftTime, string format)
		{
			if (leftTime <= 0)
			{
				return "";
			}
			int num = 0;
			int num2 = 0;
			int num3 = 0;
			num = (int)leftTime / 3600;
			num2 = (int)(leftTime % 3600) / 60;
			num3 = (int)(leftTime % 60);
			return new TimeSpan(num, num2, num3).ToString(format);
		}

		public static string GetLeftDateTimeOverHour(long leftTime)
		{
			if (leftTime <= 0)
			{
				return "";
			}
			int num = 0;
			int num2 = 0;
			int num3 = 0;
			num = (int)leftTime / 3600;
			num2 = (int)(leftTime % 3600) / 60;
			num3 = (int)(leftTime % 60);
			string text = ((num >= 10) ? $"{num}" : $"0{num}");
			string text2 = ((num2 >= 10) ? $"{num2}" : $"0{num2}");
			string text3 = ((num3 >= 10) ? $"{num3}" : $"0{num3}");
			return text + ":" + text2 + ":" + text3;
		}

		public static long GetSeverRefreshTimeSpan(string dateString)
		{
			if (string.IsNullOrEmpty(dateString))
			{
				return 0L;
			}
			dateString += " 04";
			string format = "yyyy.MM.dd hh";
			return GetDateString2TimeSpan(dateString, format);
		}

		public static long GetDateString2TimeSpan(string dateString, string format)
		{
			if (string.IsNullOrEmpty(dateString))
			{
				return 0L;
			}
			try
			{
				CultureInfo invariantCulture = CultureInfo.InvariantCulture;
				System.DateTime dateTimeFromLocalZone = GetDateTimeFromLocalZone(System.DateTime.ParseExact(dateString, format, invariantCulture));
				System.DateTime dateTime = new System.DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc);
				return (long)(dateTimeFromLocalZone - dateTime).TotalSeconds;
			}
			catch (Exception ex)
			{
				Log.Error(ex.Message + " / " + ex.StackTrace);
			}
			return 0L;
		}

		public static long GetTimeSpan(string dateTime)
		{
			if (string.IsNullOrEmpty(dateTime))
			{
				return 0L;
			}
			string[] array = dateTime.Split('.');
			if (array.Length < 3)
			{
				return 0L;
			}
			int year = ((array.Length != 0) ? int.Parse(array[0]) : 0);
			int month = ((array.Length > 1) ? int.Parse(array[1]) : 0);
			int day = ((array.Length > 2) ? int.Parse(array[2]) : 0);
			int hour = ((array.Length > 3) ? int.Parse(array[3]) : 0);
			System.DateTime dateTime2 = new System.DateTime(year, month, day, hour, 0, 0, DateTimeKind.Utc);
			return new DateTimeOffset(dateTime2).ToUnixTimeSeconds();
		}

		public static long ToUnixTimestamp(System.DateTime dateTime)
		{
			return (long)(dateTime.ToUniversalTime() - UnixEpoch).TotalSeconds;
		}

		public static System.DateTime UnixTimestampToDateTime(long unixTimestamp)
		{
			System.DateTime unixEpoch = UnixEpoch;
			return unixEpoch.AddSeconds(unixTimestamp).ToLocalTime();
		}

		public static string FormatUnixTimestamp(long unixTimestamp, string format)
		{
			try
			{
				return DateTimeOffset.FromUnixTimeSeconds(unixTimestamp).LocalDateTime.ToString(format, CultureInfo.InvariantCulture);
			}
			catch (Exception)
			{
				Log.Error($"时间参数转换异常 {unixTimestamp}");
			}
			return "";
		}

		public static string GetActivityLeftTime(long leftTime, int maxDay = 0)
		{
			if (leftTime < 0)
			{
				return "";
			}
			if (maxDay > 0 && leftTime >= maxDay * 24 * 3600)
			{
				return "";
			}
			int days = (int)leftTime / 86400;
			int hours = (int)(leftTime % 86400) / 3600;
			int minutes = (int)(leftTime % 3600) / 60;
			TimeSpan timeSpan = new TimeSpan(days, hours, minutes, 0);
			if (leftTime >= 3600)
			{
				if (leftTime >= 86400)
				{
					return timeSpan.ToString("dd\\天hh\\时");
				}
				return timeSpan.ToString("hh\\时mm\\分");
			}
			if (leftTime >= 60)
			{
				return timeSpan.ToString("mm\\分");
			}
			return "小于一分钟";
		}

		public static int GetTimeIntervalDays(long oldTime, long newTime)
		{
			System.DateTime localDateTime = DateTimeOffset.FromUnixTimeSeconds(oldTime).LocalDateTime;
			System.DateTime localDateTime2 = DateTimeOffset.FromUnixTimeSeconds(newTime).LocalDateTime;
			if (localDateTime.Year == localDateTime2.Year)
			{
				return localDateTime2.DayOfYear - localDateTime.DayOfYear;
			}
			int num = 0;
			int year = localDateTime.Year;
			int num2 = (System.DateTime.IsLeapYear(localDateTime.Year) ? 366 : 365);
			num = num2 - localDateTime.DayOfYear;
			for (year++; year < localDateTime2.Year; year++)
			{
				num2 = (System.DateTime.IsLeapYear(year) ? 366 : 365);
				num += num2;
			}
			return num + localDateTime2.DayOfYear;
		}

		private static System.DateTime GetDateTimeFromLocalZone(System.DateTime curDateTime)
		{
			return TimeZoneInfo.ConvertTimeToUtc(curDateTime, GetLocalTimeZoneInfo());
		}

		private static TimeZoneInfo GetLocalTimeZoneInfo()
		{
			return TimeZoneInfo.CreateCustomTimeZone("UTC+8", TimeSpan.FromHours(8.0), "China Time", "China Time");
		}

		public static long GetTimeStampFromDayStart(long time)
		{
			System.DateTime unixEpoch = UnixEpoch;
			return (long)(TimeZoneInfo.ConvertTimeToUtc(TimeZoneInfo.ConvertTimeFromUtc(unixEpoch.AddSeconds(time), GetLocalTimeZoneInfo()).Date, GetLocalTimeZoneInfo()) - UnixEpoch).TotalSeconds;
		}

		public static (long prevTimestamp, long nextTimestamp) GetNearestWeekday(long curTime, int weekday)
		{
			TimeZoneInfo localTimeZoneInfo = GetLocalTimeZoneInfo();
			if (weekday < 1 || weekday > 7)
			{
				throw new ArgumentException("weekday must be between 1 (Monday) and 7 (Sunday)");
			}
			System.DateTime dateTimeFromTimestamp = GetDateTimeFromTimestamp(curTime, localTimeZoneInfo);
			int dayOfWeek = (int)dateTimeFromTimestamp.DayOfWeek;
			int currentWeekday = ((dayOfWeek == 0) ? 7 : dayOfWeek);
			int daysToPreviousWeekday = GetDaysToPreviousWeekday(currentWeekday, weekday);
			int daysToNextWeekday = GetDaysToNextWeekday(currentWeekday, weekday);
			System.DateTime dateTime = dateTimeFromTimestamp.Date.AddDays(daysToPreviousWeekday).AddHours(4.0);
			System.DateTime dateTime2 = dateTimeFromTimestamp.Date.AddDays(daysToNextWeekday).AddHours(4.0);
			long timestampFromDateTime = GetTimestampFromDateTime(dateTime, localTimeZoneInfo);
			long timestampFromDateTime2 = GetTimestampFromDateTime(dateTime2, localTimeZoneInfo);
			return (prevTimestamp: timestampFromDateTime, nextTimestamp: timestampFromDateTime2);
		}

		private static int GetDaysToPreviousWeekday(int currentWeekday, int targetWeekday)
		{
			int num = currentWeekday - targetWeekday;
			if (num < 0)
			{
				return -(7 + num);
			}
			return -num;
		}

		private static int GetDaysToNextWeekday(int currentWeekday, int targetWeekday)
		{
			int num = targetWeekday - currentWeekday;
			if (num <= 0)
			{
				return 7 + num;
			}
			return num;
		}

		private static System.DateTime GetDateTimeFromTimestamp(long timestamp, TimeZoneInfo timeZone)
		{
			System.DateTime unixEpoch = UnixEpoch;
			System.DateTime dateTime = unixEpoch.AddSeconds(timestamp);
			if (timeZone != null)
			{
				return TimeZoneInfo.ConvertTimeFromUtc(dateTime, timeZone);
			}
			return dateTime;
		}

		private static long GetTimestampFromDateTime(System.DateTime dateTime, TimeZoneInfo timeZone)
		{
			return (long)(((timeZone == null) ? dateTime : TimeZoneInfo.ConvertTimeToUtc(dateTime, timeZone)) - UnixEpoch).TotalSeconds;
		}

		public static int GetDayOfWeekWithSplit(long timestamp, int splitHour = 4)
		{
			TimeZoneInfo localTimeZoneInfo = GetLocalTimeZoneInfo();
			System.DateTime dateTime = GetDateTimeFromTimestamp(timestamp, localTimeZoneInfo);
			if (dateTime.Hour < splitHour)
			{
				dateTime = dateTime.AddDays(-1.0);
			}
			return ConvertToCustomDayOfWeek(dateTime.DayOfWeek);
		}

		public static bool IsSameDayWithSplit(long timestamp1, long timestamp2, int splitHour = 4)
		{
			if (((timestamp1 >= timestamp2) ? (timestamp1 - timestamp2) : (timestamp2 - timestamp1)) >= 86400)
			{
				return false;
			}
			if (splitHour < 0)
			{
				splitHour = 0;
			}
			else if (splitHour > 23)
			{
				splitHour = 23;
			}
			TimeZoneInfo localTimeZoneInfo = GetLocalTimeZoneInfo();
			System.DateTime dateTime = GetDateTimeFromTimestamp(timestamp1, localTimeZoneInfo);
			System.DateTime dateTime2 = GetDateTimeFromTimestamp(timestamp2, localTimeZoneInfo);
			if (dateTime.Hour < splitHour)
			{
				dateTime = dateTime.AddDays(-1.0);
			}
			if (dateTime2.Hour < splitHour)
			{
				dateTime2 = dateTime2.AddDays(-1.0);
			}
			if (dateTime.Year == dateTime2.Year && dateTime.Month == dateTime2.Month)
			{
				return dateTime.Day == dateTime2.Day;
			}
			return false;
		}

		private static int ConvertToCustomDayOfWeek(DayOfWeek dayOfWeek)
		{
			if (dayOfWeek != DayOfWeek.Sunday)
			{
				return (int)dayOfWeek;
			}
			return 7;
		}
	}

	public static class Math
	{
		public static Vector2 GetCameraOffsetDir(Vector2 dir)
		{
			return dir;
		}

		public static Vector3 Round(Vector3 value)
		{
			value.x = RoundToTwoDecimals(value.x);
			value.y = RoundToTwoDecimals(value.y);
			value.z = RoundToTwoDecimals(value.z);
			return value;
		}

		public static Quaternion Round(Quaternion value)
		{
			value.x = RoundToTwoDecimals(value.x);
			value.y = RoundToTwoDecimals(value.y);
			value.z = RoundToTwoDecimals(value.z);
			value.w = RoundToTwoDecimals(value.w);
			return value;
		}

		public static float Round(float value, float val = 100f)
		{
			value = Mathf.Round(value * val) / val;
			return value;
		}

		public static float RoundToTwoDecimals(float value)
		{
			double num = (double)value * 100.0;
			if (System.Math.Abs(System.Math.Abs(num - System.Math.Truncate(num)) - 0.5) < 1E-10)
			{
				return (float)((double)System.Math.Sign(num) * System.Math.Ceiling(System.Math.Abs(num)) / 100.0);
			}
			return (float)System.Math.Round(num, MidpointRounding.ToEven) / 100f;
		}
	}

	public static class Text
	{
		[ThreadStatic]
		private static StringBuilder s_CachedStringBuilder;

		public static string Format(string format, object arg0)
		{
			if (format == null)
			{
				throw new Exception("Format is invalid.");
			}
			CheckCachedStringBuilder();
			s_CachedStringBuilder.Length = 0;
			s_CachedStringBuilder.AppendFormat(format, arg0);
			return s_CachedStringBuilder.ToString();
		}

		public static string Format(string format, object arg0, object arg1)
		{
			if (format == null)
			{
				throw new Exception("Format is invalid.");
			}
			CheckCachedStringBuilder();
			s_CachedStringBuilder.Length = 0;
			s_CachedStringBuilder.AppendFormat(format, arg0, arg1);
			return s_CachedStringBuilder.ToString();
		}

		public static string Format(string format, object arg0, object arg1, object arg2)
		{
			if (format == null)
			{
				throw new Exception("Format is invalid.");
			}
			CheckCachedStringBuilder();
			s_CachedStringBuilder.Length = 0;
			s_CachedStringBuilder.AppendFormat(format, arg0, arg1, arg2);
			return s_CachedStringBuilder.ToString();
		}

		public static string Format(string format, params object[] args)
		{
			if (format == null)
			{
				throw new Exception("Format is invalid.");
			}
			if (args == null)
			{
				throw new Exception("Args is invalid.");
			}
			CheckCachedStringBuilder();
			s_CachedStringBuilder.Length = 0;
			s_CachedStringBuilder.AppendFormat(format, args);
			return s_CachedStringBuilder.ToString();
		}

		public static string GetFullName<T>(string name)
		{
			return GetFullName(typeof(T), name);
		}

		public static string GetFullName(Type type, string name)
		{
			if (type == null)
			{
				throw new Exception("Type is invalid.");
			}
			string fullName = type.FullName;
			if (!string.IsNullOrEmpty(name))
			{
				return Format("{0}.{1}", fullName, name);
			}
			return fullName;
		}

		public static string GetByteLengthString(long byteLength)
		{
			if (byteLength < 1024)
			{
				return Format("{0} B", byteLength.ToString());
			}
			if (byteLength < 1048576)
			{
				return Format("{0} KB", ((float)byteLength / 1024f).ToString("F2"));
			}
			if (byteLength < 1073741824)
			{
				return Format("{0} MB", ((float)byteLength / 1048576f).ToString("F2"));
			}
			if (byteLength < 1099511627776L)
			{
				return Format("{0} GB", ((float)byteLength / 1.0737418E+09f).ToString("F2"));
			}
			if (byteLength < 1125899906842624L)
			{
				return Format("{0} TB", ((float)byteLength / 1.0995116E+12f).ToString("F2"));
			}
			if (byteLength < 1152921504606846976L)
			{
				return Format("{0} PB", ((float)byteLength / 1.1258999E+15f).ToString("F2"));
			}
			return Format("{0} EB", ((float)byteLength / 1.1529215E+18f).ToString("F2"));
		}

		private static void CheckCachedStringBuilder()
		{
			if (s_CachedStringBuilder == null)
			{
				s_CachedStringBuilder = new StringBuilder(1024);
			}
		}

		public static void Copy2ClipBoard(string s)
		{
			GUIUtility.systemCopyBuffer = s;
		}
	}
}
