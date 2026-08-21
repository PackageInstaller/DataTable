using System.Buffers;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Globalization;
using System.IO;
using System.Runtime.CompilerServices;
using System.Runtime.Serialization;
using System.Security;
using System.Text;
using Unity;

namespace System;

[Serializable]
[TypeForwardedFrom("System.Core, Version=2.0.5.0, Culture=Neutral, PublicKeyToken=7cec85d7bea7798e")]
public sealed class TimeZoneInfo : IEquatable<TimeZoneInfo>, ISerializable, IDeserializationCallback
{
	private struct TZifType
	{
		public readonly TimeSpan UtcOffset;

		public readonly bool IsDst;

		public readonly byte AbbreviationIndex;

		public TZifType(byte[] data, int index)
		{
			if (data == null || data.Length < index + 6)
			{
				throw new ArgumentException("The TZif data structure is corrupt.", "data");
			}
			UtcOffset = new TimeSpan(0, 0, TZif_ToInt32(data, index));
			IsDst = data[index + 4] != 0;
			AbbreviationIndex = data[index + 5];
		}
	}

	private struct TZifHead
	{
		public readonly uint Magic;

		public readonly TZVersion Version;

		public readonly uint IsGmtCount;

		public readonly uint IsStdCount;

		public readonly uint LeapCount;

		public readonly uint TimeCount;

		public readonly uint TypeCount;

		public readonly uint CharCount;

		public TZifHead(byte[] data, int index)
		{
			if (data == null || data.Length < 44)
			{
				throw new ArgumentException("bad data", "data");
			}
			Magic = (uint)TZif_ToInt32(data, index);
			if (Magic != 1415211366)
			{
				throw new ArgumentException("The tzfile does not begin with the magic characters 'TZif'.  Please verify that the file is not corrupt.", "data");
			}
			Version = data[index + 4] switch
			{
				51 => TZVersion.V3, 
				50 => TZVersion.V2, 
				_ => TZVersion.V1, 
			};
			IsGmtCount = (uint)TZif_ToInt32(data, index + 20);
			IsStdCount = (uint)TZif_ToInt32(data, index + 24);
			LeapCount = (uint)TZif_ToInt32(data, index + 28);
			TimeCount = (uint)TZif_ToInt32(data, index + 32);
			TypeCount = (uint)TZif_ToInt32(data, index + 36);
			CharCount = (uint)TZif_ToInt32(data, index + 40);
		}
	}

	private enum TZVersion : byte
	{
		V1,
		V2,
		V3
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

		public static AdjustmentRule CreateAdjustmentRule(DateTime dateStart, DateTime dateEnd, TimeSpan daylightDelta, TransitionTime daylightTransitionStart, TransitionTime daylightTransitionEnd)
		{
			return new AdjustmentRule(dateStart, dateEnd, daylightDelta, daylightTransitionStart, daylightTransitionEnd, TimeSpan.Zero, noDaylightTransitions: false);
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

	private struct StringSerializer
	{
		private enum State
		{
			Escaped,
			NotEscaped,
			StartOfToken,
			EndOfLine
		}

		private readonly string _serializedText;

		private int _currentTokenStartIndex;

		private State _state;

		public static string GetSerializedString(TimeZoneInfo zone)
		{
			StringBuilder stringBuilder = StringBuilderCache.Acquire();
			SerializeSubstitute(zone.Id, stringBuilder);
			stringBuilder.Append(';');
			stringBuilder.Append(zone.BaseUtcOffset.TotalMinutes.ToString(CultureInfo.InvariantCulture));
			stringBuilder.Append(';');
			SerializeSubstitute(zone.DisplayName, stringBuilder);
			stringBuilder.Append(';');
			SerializeSubstitute(zone.StandardName, stringBuilder);
			stringBuilder.Append(';');
			SerializeSubstitute(zone.DaylightName, stringBuilder);
			stringBuilder.Append(';');
			AdjustmentRule[] adjustmentRules = zone.GetAdjustmentRules();
			foreach (AdjustmentRule adjustmentRule in adjustmentRules)
			{
				stringBuilder.Append('[');
				stringBuilder.Append(adjustmentRule.DateStart.ToString("MM:dd:yyyy", DateTimeFormatInfo.InvariantInfo));
				stringBuilder.Append(';');
				stringBuilder.Append(adjustmentRule.DateEnd.ToString("MM:dd:yyyy", DateTimeFormatInfo.InvariantInfo));
				stringBuilder.Append(';');
				stringBuilder.Append(adjustmentRule.DaylightDelta.TotalMinutes.ToString(CultureInfo.InvariantCulture));
				stringBuilder.Append(';');
				SerializeTransitionTime(adjustmentRule.DaylightTransitionStart, stringBuilder);
				stringBuilder.Append(';');
				SerializeTransitionTime(adjustmentRule.DaylightTransitionEnd, stringBuilder);
				stringBuilder.Append(';');
				if (adjustmentRule.BaseUtcOffsetDelta != TimeSpan.Zero)
				{
					stringBuilder.Append(adjustmentRule.BaseUtcOffsetDelta.TotalMinutes.ToString(CultureInfo.InvariantCulture));
					stringBuilder.Append(';');
				}
				if (adjustmentRule.NoDaylightTransitions)
				{
					stringBuilder.Append('1');
					stringBuilder.Append(';');
				}
				stringBuilder.Append(']');
			}
			stringBuilder.Append(';');
			return StringBuilderCache.GetStringAndRelease(stringBuilder);
		}

		public static TimeZoneInfo GetDeserializedTimeZoneInfo(string source)
		{
			StringSerializer stringSerializer = new StringSerializer(source);
			string nextStringValue = stringSerializer.GetNextStringValue();
			TimeSpan nextTimeSpanValue = stringSerializer.GetNextTimeSpanValue();
			string nextStringValue2 = stringSerializer.GetNextStringValue();
			string nextStringValue3 = stringSerializer.GetNextStringValue();
			string nextStringValue4 = stringSerializer.GetNextStringValue();
			AdjustmentRule[] nextAdjustmentRuleArrayValue = stringSerializer.GetNextAdjustmentRuleArrayValue();
			try
			{
				return new TimeZoneInfo(nextStringValue, nextTimeSpanValue, nextStringValue2, nextStringValue3, nextStringValue4, nextAdjustmentRuleArrayValue, disableDaylightSavingTime: false);
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

		private StringSerializer(string str)
		{
			_serializedText = str;
			_currentTokenStartIndex = 0;
			_state = State.StartOfToken;
		}

		private static void SerializeSubstitute(string text, StringBuilder serializedText)
		{
			foreach (char c in text)
			{
				if (c == '\\' || c == '[' || c == ']' || c == ';')
				{
					serializedText.Append('\\');
				}
				serializedText.Append(c);
			}
		}

		private static void SerializeTransitionTime(TransitionTime time, StringBuilder serializedText)
		{
			serializedText.Append('[');
			serializedText.Append(time.IsFixedDateRule ? '1' : '0');
			serializedText.Append(';');
			serializedText.Append(time.TimeOfDay.ToString("HH:mm:ss.FFF", DateTimeFormatInfo.InvariantInfo));
			serializedText.Append(';');
			serializedText.Append(time.Month.ToString(CultureInfo.InvariantCulture));
			serializedText.Append(';');
			if (time.IsFixedDateRule)
			{
				serializedText.Append(time.Day.ToString(CultureInfo.InvariantCulture));
				serializedText.Append(';');
			}
			else
			{
				serializedText.Append(time.Week.ToString(CultureInfo.InvariantCulture));
				serializedText.Append(';');
				serializedText.Append(((int)time.DayOfWeek).ToString(CultureInfo.InvariantCulture));
				serializedText.Append(';');
			}
			serializedText.Append(']');
		}

		private static void VerifyIsEscapableCharacter(char c)
		{
			if (c != '\\' && c != ';' && c != '[' && c != ']')
			{
				throw new SerializationException(SR.Format("The serialized data contained an invalid escape sequence '\\\\{0}'.", c));
			}
		}

		private void SkipVersionNextDataFields(int depth)
		{
			if (_currentTokenStartIndex < 0 || _currentTokenStartIndex >= _serializedText.Length)
			{
				throw new SerializationException("An error occurred while deserializing the object.  The serialized data is corrupt.");
			}
			State state = State.NotEscaped;
			for (int i = _currentTokenStartIndex; i < _serializedText.Length; i++)
			{
				switch (state)
				{
				case State.Escaped:
					VerifyIsEscapableCharacter(_serializedText[i]);
					state = State.NotEscaped;
					break;
				case State.NotEscaped:
					switch (_serializedText[i])
					{
					case '\\':
						state = State.Escaped;
						break;
					case '[':
						depth++;
						break;
					case ']':
						depth--;
						if (depth == 0)
						{
							_currentTokenStartIndex = i + 1;
							if (_currentTokenStartIndex >= _serializedText.Length)
							{
								_state = State.EndOfLine;
							}
							else
							{
								_state = State.StartOfToken;
							}
							return;
						}
						break;
					case '\0':
						throw new SerializationException("An error occurred while deserializing the object.  The serialized data is corrupt.");
					}
					break;
				}
			}
			throw new SerializationException("An error occurred while deserializing the object.  The serialized data is corrupt.");
		}

		private string GetNextStringValue()
		{
			if (_state == State.EndOfLine)
			{
				throw new SerializationException("An error occurred while deserializing the object.  The serialized data is corrupt.");
			}
			if (_currentTokenStartIndex < 0 || _currentTokenStartIndex >= _serializedText.Length)
			{
				throw new SerializationException("An error occurred while deserializing the object.  The serialized data is corrupt.");
			}
			State state = State.NotEscaped;
			StringBuilder stringBuilder = StringBuilderCache.Acquire(64);
			for (int i = _currentTokenStartIndex; i < _serializedText.Length; i++)
			{
				switch (state)
				{
				case State.Escaped:
					VerifyIsEscapableCharacter(_serializedText[i]);
					stringBuilder.Append(_serializedText[i]);
					state = State.NotEscaped;
					break;
				case State.NotEscaped:
					switch (_serializedText[i])
					{
					case '\\':
						state = State.Escaped;
						break;
					case '[':
						throw new SerializationException("An error occurred while deserializing the object.  The serialized data is corrupt.");
					case ']':
						throw new SerializationException("An error occurred while deserializing the object.  The serialized data is corrupt.");
					case ';':
						_currentTokenStartIndex = i + 1;
						if (_currentTokenStartIndex >= _serializedText.Length)
						{
							_state = State.EndOfLine;
						}
						else
						{
							_state = State.StartOfToken;
						}
						return StringBuilderCache.GetStringAndRelease(stringBuilder);
					case '\0':
						throw new SerializationException("An error occurred while deserializing the object.  The serialized data is corrupt.");
					default:
						stringBuilder.Append(_serializedText[i]);
						break;
					}
					break;
				}
			}
			if (state == State.Escaped)
			{
				throw new SerializationException(SR.Format("The serialized data contained an invalid escape sequence '\\\\{0}'.", string.Empty));
			}
			throw new SerializationException("An error occurred while deserializing the object.  The serialized data is corrupt.");
		}

		private DateTime GetNextDateTimeValue(string format)
		{
			if (!DateTime.TryParseExact(GetNextStringValue(), format, DateTimeFormatInfo.InvariantInfo, DateTimeStyles.None, out var result))
			{
				throw new SerializationException("An error occurred while deserializing the object.  The serialized data is corrupt.");
			}
			return result;
		}

		private TimeSpan GetNextTimeSpanValue()
		{
			int nextInt32Value = GetNextInt32Value();
			try
			{
				return new TimeSpan(0, nextInt32Value, 0);
			}
			catch (ArgumentOutOfRangeException innerException)
			{
				throw new SerializationException("An error occurred while deserializing the object.  The serialized data is corrupt.", innerException);
			}
		}

		private int GetNextInt32Value()
		{
			if (!int.TryParse(GetNextStringValue(), NumberStyles.AllowLeadingSign, CultureInfo.InvariantCulture, out var result))
			{
				throw new SerializationException("An error occurred while deserializing the object.  The serialized data is corrupt.");
			}
			return result;
		}

		private AdjustmentRule[] GetNextAdjustmentRuleArrayValue()
		{
			List<AdjustmentRule> list = new List<AdjustmentRule>(1);
			int num = 0;
			for (AdjustmentRule nextAdjustmentRuleValue = GetNextAdjustmentRuleValue(); nextAdjustmentRuleValue != null; nextAdjustmentRuleValue = GetNextAdjustmentRuleValue())
			{
				list.Add(nextAdjustmentRuleValue);
				num++;
			}
			if (_state == State.EndOfLine)
			{
				throw new SerializationException("An error occurred while deserializing the object.  The serialized data is corrupt.");
			}
			if (_currentTokenStartIndex < 0 || _currentTokenStartIndex >= _serializedText.Length)
			{
				throw new SerializationException("An error occurred while deserializing the object.  The serialized data is corrupt.");
			}
			if (num == 0)
			{
				return null;
			}
			return list.ToArray();
		}

		private AdjustmentRule GetNextAdjustmentRuleValue()
		{
			if (_state == State.EndOfLine)
			{
				return null;
			}
			if (_currentTokenStartIndex < 0 || _currentTokenStartIndex >= _serializedText.Length)
			{
				throw new SerializationException("An error occurred while deserializing the object.  The serialized data is corrupt.");
			}
			if (_serializedText[_currentTokenStartIndex] == ';')
			{
				return null;
			}
			if (_serializedText[_currentTokenStartIndex] != '[')
			{
				throw new SerializationException("An error occurred while deserializing the object.  The serialized data is corrupt.");
			}
			_currentTokenStartIndex++;
			DateTime nextDateTimeValue = GetNextDateTimeValue("MM:dd:yyyy");
			DateTime nextDateTimeValue2 = GetNextDateTimeValue("MM:dd:yyyy");
			TimeSpan nextTimeSpanValue = GetNextTimeSpanValue();
			TransitionTime nextTransitionTimeValue = GetNextTransitionTimeValue();
			TransitionTime nextTransitionTimeValue2 = GetNextTransitionTimeValue();
			TimeSpan baseUtcOffsetDelta = TimeSpan.Zero;
			int num = 0;
			if (_state == State.EndOfLine || _currentTokenStartIndex >= _serializedText.Length)
			{
				throw new SerializationException("An error occurred while deserializing the object.  The serialized data is corrupt.");
			}
			if ((_serializedText[_currentTokenStartIndex] >= '0' && _serializedText[_currentTokenStartIndex] <= '9') || _serializedText[_currentTokenStartIndex] == '-' || _serializedText[_currentTokenStartIndex] == '+')
			{
				baseUtcOffsetDelta = GetNextTimeSpanValue();
			}
			if (_serializedText[_currentTokenStartIndex] >= '0' && _serializedText[_currentTokenStartIndex] <= '1')
			{
				num = GetNextInt32Value();
			}
			if (_state == State.EndOfLine || _currentTokenStartIndex >= _serializedText.Length)
			{
				throw new SerializationException("An error occurred while deserializing the object.  The serialized data is corrupt.");
			}
			if (_serializedText[_currentTokenStartIndex] != ']')
			{
				SkipVersionNextDataFields(1);
			}
			else
			{
				_currentTokenStartIndex++;
			}
			AdjustmentRule result;
			try
			{
				result = AdjustmentRule.CreateAdjustmentRule(nextDateTimeValue, nextDateTimeValue2, nextTimeSpanValue, nextTransitionTimeValue, nextTransitionTimeValue2, baseUtcOffsetDelta, num > 0);
			}
			catch (ArgumentException innerException)
			{
				throw new SerializationException("An error occurred while deserializing the object.  The serialized data is corrupt.", innerException);
			}
			if (_currentTokenStartIndex >= _serializedText.Length)
			{
				_state = State.EndOfLine;
			}
			else
			{
				_state = State.StartOfToken;
			}
			return result;
		}

		private TransitionTime GetNextTransitionTimeValue()
		{
			if (_state == State.EndOfLine || (_currentTokenStartIndex < _serializedText.Length && _serializedText[_currentTokenStartIndex] == ']'))
			{
				throw new SerializationException("An error occurred while deserializing the object.  The serialized data is corrupt.");
			}
			if (_currentTokenStartIndex < 0 || _currentTokenStartIndex >= _serializedText.Length)
			{
				throw new SerializationException("An error occurred while deserializing the object.  The serialized data is corrupt.");
			}
			if (_serializedText[_currentTokenStartIndex] != '[')
			{
				throw new SerializationException("An error occurred while deserializing the object.  The serialized data is corrupt.");
			}
			_currentTokenStartIndex++;
			int nextInt32Value = GetNextInt32Value();
			if (nextInt32Value != 0 && nextInt32Value != 1)
			{
				throw new SerializationException("An error occurred while deserializing the object.  The serialized data is corrupt.");
			}
			DateTime nextDateTimeValue = GetNextDateTimeValue("HH:mm:ss.FFF");
			nextDateTimeValue = new DateTime(1, 1, 1, nextDateTimeValue.Hour, nextDateTimeValue.Minute, nextDateTimeValue.Second, nextDateTimeValue.Millisecond);
			int nextInt32Value2 = GetNextInt32Value();
			TransitionTime result;
			if (nextInt32Value == 1)
			{
				int nextInt32Value3 = GetNextInt32Value();
				try
				{
					result = TransitionTime.CreateFixedDateRule(nextDateTimeValue, nextInt32Value2, nextInt32Value3);
				}
				catch (ArgumentException innerException)
				{
					throw new SerializationException("An error occurred while deserializing the object.  The serialized data is corrupt.", innerException);
				}
			}
			else
			{
				int nextInt32Value4 = GetNextInt32Value();
				int nextInt32Value5 = GetNextInt32Value();
				try
				{
					result = TransitionTime.CreateFloatingDateRule(nextDateTimeValue, nextInt32Value2, nextInt32Value4, (DayOfWeek)nextInt32Value5);
				}
				catch (ArgumentException innerException2)
				{
					throw new SerializationException("An error occurred while deserializing the object.  The serialized data is corrupt.", innerException2);
				}
			}
			if (_state == State.EndOfLine || _currentTokenStartIndex >= _serializedText.Length)
			{
				throw new SerializationException("An error occurred while deserializing the object.  The serialized data is corrupt.");
			}
			if (_serializedText[_currentTokenStartIndex] != ']')
			{
				SkipVersionNextDataFields(1);
			}
			else
			{
				_currentTokenStartIndex++;
			}
			bool flag = false;
			if (_currentTokenStartIndex < _serializedText.Length && _serializedText[_currentTokenStartIndex] == ';')
			{
				_currentTokenStartIndex++;
				flag = true;
			}
			if (!flag)
			{
				throw new SerializationException("An error occurred while deserializing the object.  The serialized data is corrupt.");
			}
			if (_currentTokenStartIndex >= _serializedText.Length)
			{
				_state = State.EndOfLine;
			}
			else
			{
				_state = State.StartOfToken;
			}
			return result;
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

	private enum TimeZoneInfoResult
	{
		Success,
		TimeZoneNotFoundException,
		InvalidTimeZoneException,
		SecurityException
	}

	private sealed class CachedData
	{
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

	private const string DefaultTimeZoneDirectory = "/usr/share/zoneinfo/";

	private const string ZoneTabFileName = "zone.tab";

	private const string TimeZoneEnvironmentVariable = "TZ";

	private const string TimeZoneDirectoryEnvironmentVariable = "TZDIR";

	private readonly string _id;

	private readonly string _displayName;

	private readonly string _standardDisplayName;

	private readonly string _daylightDisplayName;

	private readonly TimeSpan _baseUtcOffset;

	private readonly bool _supportsDaylightSavingTime;

	private readonly AdjustmentRule[] _adjustmentRules;

	private const string UtcId = "UTC";

	private const string LocalId = "Local";

	private static readonly TimeZoneInfo s_utcTimeZone = CreateCustomTimeZone("UTC", TimeSpan.Zero, "UTC", "UTC");

	private static CachedData s_cachedData = new CachedData();

	private static readonly DateTime s_maxDateOnly = new DateTime(9999, 12, 31);

	private static readonly DateTime s_minDateOnly = new DateTime(1, 1, 2);

	private static readonly TimeSpan MaxOffset = TimeSpan.FromHours(14.0);

	private static readonly TimeSpan MinOffset = -MaxOffset;

	public string Id => _id;

	public string DisplayName => _displayName ?? string.Empty;

	public string StandardName => _standardDisplayName ?? string.Empty;

	public string DaylightName => _daylightDisplayName ?? string.Empty;

	public TimeSpan BaseUtcOffset => _baseUtcOffset;

	public bool SupportsDaylightSavingTime => _supportsDaylightSavingTime;

	public static TimeZoneInfo Local => s_cachedData.Local;

	public static TimeZoneInfo Utc => s_utcTimeZone;

	private TimeZoneInfo(byte[] data, string id, bool dstDisabled)
	{
		TZif_ParseRaw(data, out var _, out var dts, out var typeOfLocalTime, out var transitionType, out var zoneAbbreviations, out var StandardTime, out var GmtTime, out var futureTransitionsPosixFormat);
		_id = id;
		_displayName = "Local";
		_baseUtcOffset = TimeSpan.Zero;
		DateTime utcNow = DateTime.UtcNow;
		for (int i = 0; i < dts.Length && dts[i] <= utcNow; i++)
		{
			int num = typeOfLocalTime[i];
			if (!transitionType[num].IsDst)
			{
				_baseUtcOffset = transitionType[num].UtcOffset;
				_standardDisplayName = TZif_GetZoneAbbreviation(zoneAbbreviations, transitionType[num].AbbreviationIndex);
			}
			else
			{
				_daylightDisplayName = TZif_GetZoneAbbreviation(zoneAbbreviations, transitionType[num].AbbreviationIndex);
			}
		}
		if (dts.Length == 0)
		{
			for (int j = 0; j < transitionType.Length; j++)
			{
				if (!transitionType[j].IsDst)
				{
					_baseUtcOffset = transitionType[j].UtcOffset;
					_standardDisplayName = TZif_GetZoneAbbreviation(zoneAbbreviations, transitionType[j].AbbreviationIndex);
				}
				else
				{
					_daylightDisplayName = TZif_GetZoneAbbreviation(zoneAbbreviations, transitionType[j].AbbreviationIndex);
				}
			}
		}
		_displayName = _standardDisplayName;
		if (_baseUtcOffset.Ticks % 600000000 != 0L)
		{
			_baseUtcOffset = new TimeSpan(_baseUtcOffset.Hours, _baseUtcOffset.Minutes, 0);
		}
		if (!dstDisabled)
		{
			TZif_GenerateAdjustmentRules(out _adjustmentRules, _baseUtcOffset, dts, typeOfLocalTime, transitionType, StandardTime, GmtTime, futureTransitionsPosixFormat);
		}
		ValidateTimeZoneInfo(_id, _baseUtcOffset, _adjustmentRules, out _supportsDaylightSavingTime);
	}

	public AdjustmentRule[] GetAdjustmentRules()
	{
		if (_adjustmentRules == null)
		{
			return Array.Empty<AdjustmentRule>();
		}
		AdjustmentRule[] array = new AdjustmentRule[_adjustmentRules.Length];
		for (int i = 0; i < _adjustmentRules.Length; i++)
		{
			AdjustmentRule adjustmentRule = _adjustmentRules[i];
			DateTime dateTime = ((adjustmentRule.DateStart.Kind == DateTimeKind.Utc) ? new DateTime(adjustmentRule.DateStart.Ticks + _baseUtcOffset.Ticks, DateTimeKind.Unspecified) : adjustmentRule.DateStart);
			DateTime dateTime2 = ((adjustmentRule.DateEnd.Kind == DateTimeKind.Utc) ? new DateTime(adjustmentRule.DateEnd.Ticks + _baseUtcOffset.Ticks + adjustmentRule.DaylightDelta.Ticks, DateTimeKind.Unspecified) : adjustmentRule.DateEnd);
			TransitionTime daylightTransitionStart = TransitionTime.CreateFixedDateRule(new DateTime(1, 1, 1, dateTime.Hour, dateTime.Minute, dateTime.Second), dateTime.Month, dateTime.Day);
			TransitionTime daylightTransitionEnd = TransitionTime.CreateFixedDateRule(new DateTime(1, 1, 1, dateTime2.Hour, dateTime2.Minute, dateTime2.Second), dateTime2.Month, dateTime2.Day);
			array[i] = AdjustmentRule.CreateAdjustmentRule(dateTime.Date, dateTime2.Date, adjustmentRule.DaylightDelta, daylightTransitionStart, daylightTransitionEnd);
		}
		return array;
	}

	private static void PopulateAllSystemTimeZones(CachedData cachedData)
	{
		foreach (string timeZoneId in GetTimeZoneIds(GetTimeZoneDirectory()))
		{
			TryGetTimeZone(timeZoneId, dstDisabled: false, out var _, out var _, cachedData, alwaysFallbackToLocalMachine: true);
		}
	}

	private static TimeZoneInfo GetLocalTimeZone(CachedData cachedData)
	{
		return GetLocalTimeZoneFromTzFile();
	}

	private static TimeZoneInfoResult TryGetTimeZoneFromLocalMachine(string id, out TimeZoneInfo value, out Exception e)
	{
		value = null;
		e = null;
		string text = Path.Combine(GetTimeZoneDirectory(), id);
		byte[] rawData;
		try
		{
			rawData = File.ReadAllBytes(text);
		}
		catch (UnauthorizedAccessException ex)
		{
			e = ex;
			return TimeZoneInfoResult.SecurityException;
		}
		catch (FileNotFoundException ex2)
		{
			e = ex2;
			return TimeZoneInfoResult.TimeZoneNotFoundException;
		}
		catch (DirectoryNotFoundException ex3)
		{
			e = ex3;
			return TimeZoneInfoResult.TimeZoneNotFoundException;
		}
		catch (IOException innerException)
		{
			e = new InvalidTimeZoneException(SR.Format("The time zone ID '{0}' was found on the local computer, but the file at '{1}' was corrupt.", id, text), innerException);
			return TimeZoneInfoResult.InvalidTimeZoneException;
		}
		value = GetTimeZoneFromTzData(rawData, id);
		if (value == null)
		{
			e = new InvalidTimeZoneException(SR.Format("The time zone ID '{0}' was found on the local computer, but the file at '{1}' was corrupt.", id, text));
			return TimeZoneInfoResult.InvalidTimeZoneException;
		}
		return TimeZoneInfoResult.Success;
	}

	private static List<string> GetTimeZoneIds(string timeZoneDirectory)
	{
		List<string> list = new List<string>();
		try
		{
			using StreamReader streamReader = new StreamReader(Path.Combine(timeZoneDirectory, "zone.tab"), Encoding.UTF8);
			string text;
			while ((text = streamReader.ReadLine()) != null)
			{
				if (string.IsNullOrEmpty(text) || text[0] == '#')
				{
					continue;
				}
				int num = text.IndexOf('\t');
				if (num == -1)
				{
					continue;
				}
				int num2 = text.IndexOf('\t', num + 1);
				if (num2 != -1)
				{
					int num3 = num2 + 1;
					int num4 = text.IndexOf('\t', num3);
					string text2;
					if (num4 != -1)
					{
						int length = num4 - num3;
						text2 = text.Substring(num3, length);
					}
					else
					{
						text2 = text.Substring(num3);
					}
					if (!string.IsNullOrEmpty(text2))
					{
						list.Add(text2);
					}
				}
			}
		}
		catch (IOException)
		{
		}
		catch (UnauthorizedAccessException)
		{
		}
		return list;
	}

	private static bool TryGetLocalTzFile(out byte[] rawData, out string id)
	{
		rawData = null;
		id = null;
		string tzEnvironmentVariable = GetTzEnvironmentVariable();
		if (tzEnvironmentVariable == null)
		{
			if (!TryLoadTzFile("/etc/localtime", ref rawData, ref id))
			{
				return TryLoadTzFile(Path.Combine(GetTimeZoneDirectory(), "localtime"), ref rawData, ref id);
			}
			return true;
		}
		if (tzEnvironmentVariable.Length == 0)
		{
			return false;
		}
		string tzFilePath;
		if (tzEnvironmentVariable[0] != '/')
		{
			id = tzEnvironmentVariable;
			tzFilePath = Path.Combine(GetTimeZoneDirectory(), tzEnvironmentVariable);
		}
		else
		{
			tzFilePath = tzEnvironmentVariable;
		}
		return TryLoadTzFile(tzFilePath, ref rawData, ref id);
	}

	private static string GetTzEnvironmentVariable()
	{
		string text = Environment.GetEnvironmentVariable("TZ");
		if (!string.IsNullOrEmpty(text) && text[0] == ':')
		{
			text = text.Substring(1);
		}
		return text;
	}

	private static bool TryLoadTzFile(string tzFilePath, ref byte[] rawData, ref string id)
	{
		if (File.Exists(tzFilePath))
		{
			try
			{
				rawData = File.ReadAllBytes(tzFilePath);
				if (string.IsNullOrEmpty(id))
				{
					id = FindTimeZoneIdUsingReadLink(tzFilePath);
					if (string.IsNullOrEmpty(id))
					{
						id = FindTimeZoneId(rawData);
					}
				}
				return true;
			}
			catch (IOException)
			{
			}
			catch (SecurityException)
			{
			}
			catch (UnauthorizedAccessException)
			{
			}
		}
		return false;
	}

	private static string FindTimeZoneIdUsingReadLink(string tzFilePath)
	{
		string result = null;
		string text = Interop.Sys.ReadLink(tzFilePath);
		if (text != null)
		{
			text = Path.Combine(tzFilePath, text);
			string timeZoneDirectory = GetTimeZoneDirectory();
			if (text.StartsWith(timeZoneDirectory, StringComparison.Ordinal))
			{
				result = text.Substring(timeZoneDirectory.Length);
			}
		}
		return result;
	}

	private static string GetDirectoryEntryFullPath(ref Interop.Sys.DirectoryEntry dirent, string currentPath)
	{
		Span<char> buffer = stackalloc char[256];
		ReadOnlySpan<char> name = dirent.GetName(buffer);
		if ((name.Length == 1 && name[0] == '.') || (name.Length == 2 && name[0] == '.' && name[1] == '.'))
		{
			return null;
		}
		return Path.Join(currentPath.AsSpan(), name);
	}

	private unsafe static void EnumerateFilesRecursively(string path, Predicate<string> condition)
	{
		List<string> list = null;
		int readDirRBufferSize = Interop.Sys.GetReadDirRBufferSize();
		byte[] array = null;
		try
		{
			array = ArrayPool<byte>.Shared.Rent(readDirRBufferSize);
			string text = path;
			fixed (byte* buffer = array)
			{
				while (true)
				{
					IntPtr intPtr = Interop.Sys.OpenDir(text);
					if (intPtr == IntPtr.Zero)
					{
						throw Interop.GetExceptionForIoErrno(Interop.Sys.GetLastErrorInfo(), text, isDirectory: true);
					}
					try
					{
						Interop.Sys.DirectoryEntry outputEntry;
						while (Interop.Sys.ReadDirR(intPtr, buffer, readDirRBufferSize, out outputEntry) == 0)
						{
							string directoryEntryFullPath = GetDirectoryEntryFullPath(ref outputEntry, text);
							if (directoryEntryFullPath == null)
							{
								continue;
							}
							if (outputEntry.InodeType == Interop.Sys.NodeType.DT_DIR || ((outputEntry.InodeType == Interop.Sys.NodeType.DT_LNK || outputEntry.InodeType == Interop.Sys.NodeType.DT_UNKNOWN) && Interop.Sys.Stat(directoryEntryFullPath, out var output) >= 0 && (output.Mode & 0xF000) == 16384))
							{
								if (list == null)
								{
									list = new List<string>();
								}
								list.Add(directoryEntryFullPath);
							}
							else if (condition(directoryEntryFullPath))
							{
								return;
							}
						}
					}
					finally
					{
						if (intPtr != IntPtr.Zero)
						{
							Interop.Sys.CloseDir(intPtr);
						}
					}
					if (list == null || list.Count == 0)
					{
						break;
					}
					text = list[list.Count - 1];
					list.RemoveAt(list.Count - 1);
				}
			}
		}
		finally
		{
			if (array != null)
			{
				ArrayPool<byte>.Shared.Return(array);
			}
		}
	}

	private static string FindTimeZoneId(byte[] rawData)
	{
		string id = "Local";
		string timeZoneDirectory = GetTimeZoneDirectory();
		string localtimeFilePath = Path.Combine(timeZoneDirectory, "localtime");
		string posixrulesFilePath = Path.Combine(timeZoneDirectory, "posixrules");
		byte[] buffer = new byte[rawData.Length];
		try
		{
			EnumerateFilesRecursively(timeZoneDirectory, delegate(string filePath)
			{
				if (!string.Equals(filePath, localtimeFilePath, StringComparison.OrdinalIgnoreCase) && !string.Equals(filePath, posixrulesFilePath, StringComparison.OrdinalIgnoreCase) && CompareTimeZoneFile(filePath, buffer, rawData))
				{
					id = filePath;
					if (id.StartsWith(timeZoneDirectory, StringComparison.Ordinal))
					{
						id = id.Substring(timeZoneDirectory.Length);
					}
					return true;
				}
				return false;
			});
		}
		catch (IOException)
		{
		}
		catch (SecurityException)
		{
		}
		catch (UnauthorizedAccessException)
		{
		}
		return id;
	}

	private static bool CompareTimeZoneFile(string filePath, byte[] buffer, byte[] rawData)
	{
		try
		{
			using FileStream fileStream = new FileStream(filePath, FileMode.Open, FileAccess.Read, FileShare.Read, 1);
			if (fileStream.Length == rawData.Length)
			{
				int i = 0;
				int num = rawData.Length;
				while (num > 0)
				{
					int num2 = fileStream.Read(buffer, i, num);
					if (num2 == 0)
					{
						throw Error.GetEndOfFile();
					}
					for (int num3 = i + num2; i < num3; i++)
					{
						if (buffer[i] != rawData[i])
						{
							return false;
						}
					}
					num -= num2;
				}
				return true;
			}
		}
		catch (IOException)
		{
		}
		catch (SecurityException)
		{
		}
		catch (UnauthorizedAccessException)
		{
		}
		return false;
	}

	private static TimeZoneInfo GetLocalTimeZoneFromTzFile()
	{
		if (TryGetLocalTzFile(out var rawData, out var id))
		{
			TimeZoneInfo timeZoneFromTzData = GetTimeZoneFromTzData(rawData, id);
			if (timeZoneFromTzData != null)
			{
				return timeZoneFromTzData;
			}
		}
		TimeZoneInfo timeZoneInfo = null;
		try
		{
			timeZoneInfo = CreateLocalUnity();
		}
		catch
		{
			timeZoneInfo = null;
		}
		if (timeZoneInfo != null)
		{
			return timeZoneInfo;
		}
		return Utc;
	}

	private static TimeZoneInfo GetTimeZoneFromTzData(byte[] rawData, string id)
	{
		if (rawData != null)
		{
			try
			{
				return new TimeZoneInfo(rawData, id, dstDisabled: false);
			}
			catch (ArgumentException)
			{
			}
			catch (InvalidTimeZoneException)
			{
			}
			try
			{
				return new TimeZoneInfo(rawData, id, dstDisabled: true);
			}
			catch (ArgumentException)
			{
			}
			catch (InvalidTimeZoneException)
			{
			}
		}
		return null;
	}

	private static string GetTimeZoneDirectory()
	{
		string timeZoneDirectoryUnity = GetTimeZoneDirectoryUnity();
		if (!string.IsNullOrEmpty(timeZoneDirectoryUnity))
		{
			return timeZoneDirectoryUnity;
		}
		timeZoneDirectoryUnity = Environment.GetEnvironmentVariable("TZDIR");
		if (timeZoneDirectoryUnity == null)
		{
			timeZoneDirectoryUnity = "/usr/share/zoneinfo/";
		}
		else if (!timeZoneDirectoryUnity.EndsWith(Path.DirectorySeparatorChar))
		{
			timeZoneDirectoryUnity += Path.DirectorySeparatorChar;
		}
		return timeZoneDirectoryUnity;
	}

	public static TimeZoneInfo FindSystemTimeZoneById(string id)
	{
		if (string.Equals(id, "UTC", StringComparison.OrdinalIgnoreCase))
		{
			return Utc;
		}
		if (string.Equals(id, "Local", StringComparison.OrdinalIgnoreCase))
		{
			return Local;
		}
		if (id == null)
		{
			throw new ArgumentNullException("id");
		}
		if (id.Length == 0 || id.Contains('\0'))
		{
			throw new TimeZoneNotFoundException(SR.Format("The time zone ID '{0}' was not found on the local computer.", id));
		}
		CachedData cachedData = s_cachedData;
		TimeZoneInfoResult timeZoneInfoResult;
		TimeZoneInfo value;
		Exception e;
		lock (cachedData)
		{
			timeZoneInfoResult = TryGetTimeZone(id, dstDisabled: false, out value, out e, cachedData, alwaysFallbackToLocalMachine: true);
		}
		return timeZoneInfoResult switch
		{
			TimeZoneInfoResult.Success => value, 
			TimeZoneInfoResult.InvalidTimeZoneException => throw e, 
			TimeZoneInfoResult.SecurityException => throw new SecurityException(SR.Format("The time zone ID '{0}' was found on the local computer, but the application does not have permission to read the file.", id), e), 
			_ => throw new TimeZoneNotFoundException(SR.Format("The time zone ID '{0}' was not found on the local computer.", id), e), 
		};
	}

	internal static TimeSpan GetDateTimeNowUtcOffsetFromUtc(DateTime time, out bool isAmbiguousLocalDst)
	{
		bool isDaylightSavings;
		return GetUtcOffsetFromUtc(time, Local, out isDaylightSavings, out isAmbiguousLocalDst);
	}

	private static void TZif_GenerateAdjustmentRules(out AdjustmentRule[] rules, TimeSpan baseUtcOffset, DateTime[] dts, byte[] typeOfLocalTime, TZifType[] transitionType, bool[] StandardTime, bool[] GmtTime, string futureTransitionsPosixFormat)
	{
		rules = null;
		if (dts.Length != 0)
		{
			int index = 0;
			List<AdjustmentRule> list = new List<AdjustmentRule>();
			while (index <= dts.Length)
			{
				TZif_GenerateAdjustmentRule(ref index, baseUtcOffset, list, dts, typeOfLocalTime, transitionType, StandardTime, GmtTime, futureTransitionsPosixFormat);
			}
			rules = list.ToArray();
			if (rules != null && rules.Length == 0)
			{
				rules = null;
			}
		}
	}

	private static void TZif_GenerateAdjustmentRule(ref int index, TimeSpan timeZoneBaseUtcOffset, List<AdjustmentRule> rulesList, DateTime[] dts, byte[] typeOfLocalTime, TZifType[] transitionTypes, bool[] StandardTime, bool[] GmtTime, string futureTransitionsPosixFormat)
	{
		while (index < dts.Length && dts[index] == DateTime.MinValue)
		{
			index++;
		}
		if (rulesList.Count == 0 && index < dts.Length)
		{
			TZifType tZifType = TZif_GetEarlyDateTransitionType(transitionTypes);
			DateTime dateTime = dts[index];
			TimeSpan timeSpan = TZif_CalculateTransitionOffsetFromBase(tZifType.UtcOffset, timeZoneBaseUtcOffset);
			TimeSpan daylightDelta = (tZifType.IsDst ? timeSpan : TimeSpan.Zero);
			TimeSpan baseUtcOffsetDelta = (tZifType.IsDst ? TimeSpan.Zero : timeSpan);
			AdjustmentRule adjustmentRule = AdjustmentRule.CreateAdjustmentRule(DateTime.MinValue, dateTime.AddTicks(-1L), daylightDelta, default(TransitionTime), default(TransitionTime), baseUtcOffsetDelta, noDaylightTransitions: true);
			if (!IsValidAdjustmentRuleOffest(timeZoneBaseUtcOffset, adjustmentRule))
			{
				NormalizeAdjustmentRuleOffset(timeZoneBaseUtcOffset, ref adjustmentRule);
			}
			rulesList.Add(adjustmentRule);
		}
		else if (index < dts.Length)
		{
			DateTime dateStart = dts[index - 1];
			TZifType tZifType2 = transitionTypes[typeOfLocalTime[index - 1]];
			DateTime dateTime2 = dts[index];
			TimeSpan timeSpan2 = TZif_CalculateTransitionOffsetFromBase(tZifType2.UtcOffset, timeZoneBaseUtcOffset);
			AdjustmentRule adjustmentRule2 = AdjustmentRule.CreateAdjustmentRule(daylightDelta: tZifType2.IsDst ? timeSpan2 : TimeSpan.Zero, baseUtcOffsetDelta: tZifType2.IsDst ? TimeSpan.Zero : timeSpan2, daylightTransitionStart: (!tZifType2.IsDst) ? default(TransitionTime) : TransitionTime.CreateFixedDateRule(DateTime.MinValue.AddMilliseconds(2.0), 1, 1), dateStart: dateStart, dateEnd: dateTime2.AddTicks(-1L), daylightTransitionEnd: default(TransitionTime), noDaylightTransitions: true);
			if (!IsValidAdjustmentRuleOffest(timeZoneBaseUtcOffset, adjustmentRule2))
			{
				NormalizeAdjustmentRuleOffset(timeZoneBaseUtcOffset, ref adjustmentRule2);
			}
			rulesList.Add(adjustmentRule2);
		}
		else
		{
			DateTime dateTime3 = dts[index - 1];
			if (!string.IsNullOrEmpty(futureTransitionsPosixFormat))
			{
				AdjustmentRule adjustmentRule3 = TZif_CreateAdjustmentRuleForPosixFormat(futureTransitionsPosixFormat, dateTime3, timeZoneBaseUtcOffset);
				if (adjustmentRule3 != null)
				{
					if (!IsValidAdjustmentRuleOffest(timeZoneBaseUtcOffset, adjustmentRule3))
					{
						NormalizeAdjustmentRuleOffset(timeZoneBaseUtcOffset, ref adjustmentRule3);
					}
					rulesList.Add(adjustmentRule3);
				}
			}
			else
			{
				TZifType tZifType3 = transitionTypes[typeOfLocalTime[index - 1]];
				TimeSpan timeSpan3 = TZif_CalculateTransitionOffsetFromBase(tZifType3.UtcOffset, timeZoneBaseUtcOffset);
				TimeSpan daylightDelta2 = (tZifType3.IsDst ? timeSpan3 : TimeSpan.Zero);
				TimeSpan baseUtcOffsetDelta2 = (tZifType3.IsDst ? TimeSpan.Zero : timeSpan3);
				AdjustmentRule adjustmentRule4 = AdjustmentRule.CreateAdjustmentRule(dateTime3, DateTime.MaxValue, daylightDelta2, default(TransitionTime), default(TransitionTime), baseUtcOffsetDelta2, noDaylightTransitions: true);
				if (!IsValidAdjustmentRuleOffest(timeZoneBaseUtcOffset, adjustmentRule4))
				{
					NormalizeAdjustmentRuleOffset(timeZoneBaseUtcOffset, ref adjustmentRule4);
				}
				rulesList.Add(adjustmentRule4);
			}
		}
		index++;
	}

	private static TimeSpan TZif_CalculateTransitionOffsetFromBase(TimeSpan transitionOffset, TimeSpan timeZoneBaseUtcOffset)
	{
		TimeSpan result = transitionOffset - timeZoneBaseUtcOffset;
		if (result.Ticks % 600000000 != 0L)
		{
			result = new TimeSpan(result.Hours, result.Minutes, 0);
		}
		return result;
	}

	private static TZifType TZif_GetEarlyDateTransitionType(TZifType[] transitionTypes)
	{
		for (int i = 0; i < transitionTypes.Length; i++)
		{
			TZifType result = transitionTypes[i];
			if (!result.IsDst)
			{
				return result;
			}
		}
		if (transitionTypes.Length != 0)
		{
			return transitionTypes[0];
		}
		throw new InvalidTimeZoneException("There are no ttinfo structures in the tzfile.  At least one ttinfo structure is required in order to construct a TimeZoneInfo object.");
	}

	private static AdjustmentRule TZif_CreateAdjustmentRuleForPosixFormat(string posixFormat, DateTime startTransitionDate, TimeSpan timeZoneBaseUtcOffset)
	{
		if (TZif_ParsePosixFormat(posixFormat, out var _, out var standardOffset, out var daylightSavingsName, out var daylightSavingsOffset, out var start, out var startTime, out var end, out var endTime))
		{
			TimeSpan? timeSpan = TZif_ParseOffsetString(standardOffset);
			if (timeSpan.HasValue)
			{
				TimeSpan transitionOffset = timeSpan.Value.Negate();
				transitionOffset = TZif_CalculateTransitionOffsetFromBase(transitionOffset, timeZoneBaseUtcOffset);
				if (!string.IsNullOrEmpty(daylightSavingsName))
				{
					TimeSpan? timeSpan2 = TZif_ParseOffsetString(daylightSavingsOffset);
					TimeSpan daylightDelta;
					if (!timeSpan2.HasValue)
					{
						daylightDelta = new TimeSpan(1, 0, 0);
					}
					else
					{
						daylightDelta = timeSpan2.Value.Negate();
						daylightDelta = TZif_CalculateTransitionOffsetFromBase(daylightDelta, timeZoneBaseUtcOffset);
						daylightDelta = TZif_CalculateTransitionOffsetFromBase(daylightDelta, transitionOffset);
					}
					TransitionTime daylightTransitionStart = TZif_CreateTransitionTimeFromPosixRule(start, startTime);
					TransitionTime daylightTransitionEnd = TZif_CreateTransitionTimeFromPosixRule(end, endTime);
					return AdjustmentRule.CreateAdjustmentRule(startTransitionDate, DateTime.MaxValue, daylightDelta, daylightTransitionStart, daylightTransitionEnd, transitionOffset, noDaylightTransitions: false);
				}
				return AdjustmentRule.CreateAdjustmentRule(startTransitionDate, DateTime.MaxValue, TimeSpan.Zero, default(TransitionTime), default(TransitionTime), transitionOffset, noDaylightTransitions: true);
			}
		}
		return null;
	}

	private static TimeSpan? TZif_ParseOffsetString(string offset)
	{
		TimeSpan? result = null;
		if (!string.IsNullOrEmpty(offset))
		{
			bool flag = offset[0] == '-';
			if (flag || offset[0] == '+')
			{
				offset = offset.Substring(1);
			}
			TimeSpan result3;
			if (int.TryParse(offset, out var result2))
			{
				result = new TimeSpan(result2, 0, 0);
			}
			else if (TimeSpan.TryParseExact(offset, "g", CultureInfo.InvariantCulture, out result3))
			{
				result = result3;
			}
			if (result.HasValue & flag)
			{
				result = result.Value.Negate();
			}
		}
		return result;
	}

	private static DateTime ParseTimeOfDay(string time)
	{
		TimeSpan? timeSpan = TZif_ParseOffsetString(time);
		if (timeSpan.HasValue)
		{
			timeSpan = new TimeSpan(timeSpan.Value.Hours, timeSpan.Value.Minutes, timeSpan.Value.Seconds);
			DateTime dateTime = ((!(timeSpan.Value < TimeSpan.Zero)) ? new DateTime(1, 1, 1, 0, 0, 0) : new DateTime(1, 1, 2, 0, 0, 0));
			return dateTime + timeSpan.Value;
		}
		return new DateTime(1, 1, 1, 2, 0, 0);
	}

	private static TransitionTime TZif_CreateTransitionTimeFromPosixRule(string date, string time)
	{
		if (string.IsNullOrEmpty(date))
		{
			return default(TransitionTime);
		}
		if (date[0] == 'M')
		{
			if (!TZif_ParseMDateRule(date, out var month, out var week, out var dayOfWeek))
			{
				throw new InvalidTimeZoneException(SR.Format("'{0}' is not a valid POSIX-TZ-environment-variable MDate rule.  A valid rule has the format 'Mm.w.d'.", date));
			}
			return TransitionTime.CreateFloatingDateRule(ParseTimeOfDay(time), month, week, dayOfWeek);
		}
		if (date[0] != 'J')
		{
			throw new InvalidTimeZoneException("Julian n day in POSIX strings is not supported.");
		}
		TZif_ParseJulianDay(date, out var month2, out var day);
		return TransitionTime.CreateFixedDateRule(ParseTimeOfDay(time), month2, day);
	}

	private static void TZif_ParseJulianDay(string date, out int month, out int day)
	{
		month = (day = 0);
		int num = 1;
		if (num >= date.Length || (uint)(date[num] - 48) > 9u)
		{
			throw new InvalidTimeZoneException("Invalid Julian day in POSIX strings.");
		}
		int num2 = 0;
		do
		{
			num2 = num2 * 10 + (date[num] - 48);
			num++;
		}
		while (num < date.Length && (uint)(date[num] - 48) <= 9u);
		int[] daysToMonth = GregorianCalendarHelper.DaysToMonth365;
		if (num2 == 0 || num2 > daysToMonth[daysToMonth.Length - 1])
		{
			throw new InvalidTimeZoneException("Invalid Julian day in POSIX strings.");
		}
		int i;
		for (i = 1; i < daysToMonth.Length && num2 > daysToMonth[i]; i++)
		{
		}
		month = i;
		day = num2 - daysToMonth[i - 1];
	}

	private static bool TZif_ParseMDateRule(string dateRule, out int month, out int week, out DayOfWeek dayOfWeek)
	{
		if (dateRule[0] == 'M')
		{
			int num = dateRule.IndexOf('.');
			if (num > 0)
			{
				int num2 = dateRule.IndexOf('.', num + 1);
				if (num2 > 0 && int.TryParse(dateRule.AsSpan(1, num - 1), out month) && int.TryParse(dateRule.AsSpan(num + 1, num2 - num - 1), out week) && int.TryParse(dateRule.AsSpan(num2 + 1), out var result))
				{
					dayOfWeek = (DayOfWeek)result;
					return true;
				}
			}
		}
		month = 0;
		week = 0;
		dayOfWeek = DayOfWeek.Sunday;
		return false;
	}

	private static bool TZif_ParsePosixFormat(string posixFormat, out string standardName, out string standardOffset, out string daylightSavingsName, out string daylightSavingsOffset, out string start, out string startTime, out string end, out string endTime)
	{
		standardName = null;
		standardOffset = null;
		daylightSavingsName = null;
		daylightSavingsOffset = null;
		start = null;
		startTime = null;
		end = null;
		endTime = null;
		int index = 0;
		standardName = TZif_ParsePosixName(posixFormat, ref index);
		standardOffset = TZif_ParsePosixOffset(posixFormat, ref index);
		daylightSavingsName = TZif_ParsePosixName(posixFormat, ref index);
		if (!string.IsNullOrEmpty(daylightSavingsName))
		{
			daylightSavingsOffset = TZif_ParsePosixOffset(posixFormat, ref index);
			if (index < posixFormat.Length && posixFormat[index] == ',')
			{
				index++;
				TZif_ParsePosixDateTime(posixFormat, ref index, out start, out startTime);
				if (index < posixFormat.Length && posixFormat[index] == ',')
				{
					index++;
					TZif_ParsePosixDateTime(posixFormat, ref index, out end, out endTime);
				}
			}
		}
		if (!string.IsNullOrEmpty(standardName))
		{
			return !string.IsNullOrEmpty(standardOffset);
		}
		return false;
	}

	private static string TZif_ParsePosixName(string posixFormat, ref int index)
	{
		if (index < posixFormat.Length && posixFormat[index] == '<')
		{
			index++;
			string result = TZif_ParsePosixString(posixFormat, ref index, (char c) => c == '>');
			if (index < posixFormat.Length && posixFormat[index] == '>')
			{
				index++;
			}
			return result;
		}
		return TZif_ParsePosixString(posixFormat, ref index, (char c) => char.IsDigit(c) || c == '+' || c == '-' || c == ',');
	}

	private static string TZif_ParsePosixOffset(string posixFormat, ref int index)
	{
		return TZif_ParsePosixString(posixFormat, ref index, (char c) => !char.IsDigit(c) && c != '+' && c != '-' && c != ':');
	}

	private static void TZif_ParsePosixDateTime(string posixFormat, ref int index, out string date, out string time)
	{
		time = null;
		date = TZif_ParsePosixDate(posixFormat, ref index);
		if (index < posixFormat.Length && posixFormat[index] == '/')
		{
			index++;
			time = TZif_ParsePosixTime(posixFormat, ref index);
		}
	}

	private static string TZif_ParsePosixDate(string posixFormat, ref int index)
	{
		return TZif_ParsePosixString(posixFormat, ref index, (char c) => c == '/' || c == ',');
	}

	private static string TZif_ParsePosixTime(string posixFormat, ref int index)
	{
		return TZif_ParsePosixString(posixFormat, ref index, (char c) => c == ',');
	}

	private static string TZif_ParsePosixString(string posixFormat, ref int index, Func<char, bool> breakCondition)
	{
		int num = index;
		while (index < posixFormat.Length)
		{
			char arg = posixFormat[index];
			if (breakCondition(arg))
			{
				break;
			}
			index++;
		}
		return posixFormat.Substring(num, index - num);
	}

	private static string TZif_GetZoneAbbreviation(string zoneAbbreviations, int index)
	{
		int num = zoneAbbreviations.IndexOf('\0', index);
		if (num <= 0)
		{
			return zoneAbbreviations.Substring(index);
		}
		return zoneAbbreviations.Substring(index, num - index);
	}

	private unsafe static int TZif_ToInt32(byte[] value, int startIndex)
	{
		fixed (byte* ptr = &value[startIndex])
		{
			return (*ptr << 24) | (ptr[1] << 16) | (ptr[2] << 8) | ptr[3];
		}
	}

	private unsafe static long TZif_ToInt64(byte[] value, int startIndex)
	{
		fixed (byte* ptr = &value[startIndex])
		{
			int num = (*ptr << 24) | (ptr[1] << 16) | (ptr[2] << 8) | ptr[3];
			return (uint)((ptr[4] << 24) | (ptr[5] << 16) | (ptr[6] << 8) | ptr[7]) | ((long)num << 32);
		}
	}

	private static long TZif_ToUnixTime(byte[] value, int startIndex, TZVersion version)
	{
		if (version == TZVersion.V1)
		{
			return TZif_ToInt32(value, startIndex);
		}
		return TZif_ToInt64(value, startIndex);
	}

	private static DateTime TZif_UnixTimeToDateTime(long unixTime)
	{
		if (unixTime >= -62135596800L)
		{
			if (unixTime <= 253402300799L)
			{
				return DateTimeOffset.FromUnixTimeSeconds(unixTime).UtcDateTime;
			}
			return DateTime.MaxValue;
		}
		return DateTime.MinValue;
	}

	private static void TZif_ParseRaw(byte[] data, out TZifHead t, out DateTime[] dts, out byte[] typeOfLocalTime, out TZifType[] transitionType, out string zoneAbbreviations, out bool[] StandardTime, out bool[] GmtTime, out string futureTransitionsPosixFormat)
	{
		dts = null;
		typeOfLocalTime = null;
		transitionType = null;
		zoneAbbreviations = string.Empty;
		StandardTime = null;
		GmtTime = null;
		futureTransitionsPosixFormat = null;
		int num = 0;
		t = new TZifHead(data, num);
		num += 44;
		int num2 = 4;
		if (t.Version != TZVersion.V1)
		{
			num += (int)(num2 * t.TimeCount + t.TimeCount + 6 * t.TypeCount + (num2 + 4) * t.LeapCount + t.IsStdCount + t.IsGmtCount + t.CharCount);
			t = new TZifHead(data, num);
			num += 44;
			num2 = 8;
		}
		dts = new DateTime[t.TimeCount];
		typeOfLocalTime = new byte[t.TimeCount];
		transitionType = new TZifType[t.TypeCount];
		zoneAbbreviations = string.Empty;
		StandardTime = new bool[t.TypeCount];
		GmtTime = new bool[t.TypeCount];
		for (int i = 0; i < t.TimeCount; i++)
		{
			long unixTime = TZif_ToUnixTime(data, num, t.Version);
			dts[i] = TZif_UnixTimeToDateTime(unixTime);
			num += num2;
		}
		for (int j = 0; j < t.TimeCount; j++)
		{
			typeOfLocalTime[j] = data[num];
			num++;
		}
		for (int k = 0; k < t.TypeCount; k++)
		{
			transitionType[k] = new TZifType(data, num);
			num += 6;
		}
		Encoding uTF = Encoding.UTF8;
		zoneAbbreviations = uTF.GetString(data, num, (int)t.CharCount);
		num += (int)t.CharCount;
		num += (int)(t.LeapCount * (num2 + 4));
		for (int l = 0; l < t.IsStdCount && l < t.TypeCount; l++)
		{
			if (num >= data.Length)
			{
				break;
			}
			StandardTime[l] = data[num++] != 0;
		}
		for (int m = 0; m < t.IsGmtCount && m < t.TypeCount; m++)
		{
			if (num >= data.Length)
			{
				break;
			}
			GmtTime[m] = data[num++] != 0;
		}
		if (t.Version != TZVersion.V1 && data[num++] == 10 && data[data.Length - 1] == 10)
		{
			futureTransitionsPosixFormat = uTF.GetString(data, num, data.Length - num - 1);
		}
	}

	public TimeSpan[] GetAmbiguousTimeOffsets(DateTimeOffset dateTimeOffset)
	{
		if (!SupportsDaylightSavingTime)
		{
			throw new ArgumentException("The supplied DateTimeOffset is not in an ambiguous time range.", "dateTimeOffset");
		}
		DateTime dateTime = ConvertTime(dateTimeOffset, this).DateTime;
		bool flag = false;
		AdjustmentRule adjustmentRuleForAmbiguousOffsets = GetAdjustmentRuleForAmbiguousOffsets(dateTime, out var ruleIndex);
		if (adjustmentRuleForAmbiguousOffsets != null && adjustmentRuleForAmbiguousOffsets.HasDaylightSaving)
		{
			DaylightTimeStruct daylightTime = GetDaylightTime(dateTime.Year, adjustmentRuleForAmbiguousOffsets, ruleIndex);
			flag = GetIsAmbiguousTime(dateTime, adjustmentRuleForAmbiguousOffsets, daylightTime);
		}
		if (!flag)
		{
			throw new ArgumentException("The supplied DateTimeOffset is not in an ambiguous time range.", "dateTimeOffset");
		}
		TimeSpan[] array = new TimeSpan[2];
		TimeSpan timeSpan = _baseUtcOffset + adjustmentRuleForAmbiguousOffsets.BaseUtcOffsetDelta;
		if (adjustmentRuleForAmbiguousOffsets.DaylightDelta > TimeSpan.Zero)
		{
			array[0] = timeSpan;
			array[1] = timeSpan + adjustmentRuleForAmbiguousOffsets.DaylightDelta;
		}
		else
		{
			array[0] = timeSpan + adjustmentRuleForAmbiguousOffsets.DaylightDelta;
			array[1] = timeSpan;
		}
		return array;
	}

	public TimeSpan[] GetAmbiguousTimeOffsets(DateTime dateTime)
	{
		if (!SupportsDaylightSavingTime)
		{
			throw new ArgumentException("The supplied DateTime is not in an ambiguous time range.", "dateTime");
		}
		DateTime dateTime2;
		if (dateTime.Kind == DateTimeKind.Local)
		{
			CachedData cachedData = s_cachedData;
			dateTime2 = ConvertTime(dateTime, cachedData.Local, this, TimeZoneInfoOptions.None, cachedData);
		}
		else if (dateTime.Kind == DateTimeKind.Utc)
		{
			CachedData cachedData2 = s_cachedData;
			dateTime2 = ConvertTime(dateTime, s_utcTimeZone, this, TimeZoneInfoOptions.None, cachedData2);
		}
		else
		{
			dateTime2 = dateTime;
		}
		bool flag = false;
		AdjustmentRule adjustmentRuleForAmbiguousOffsets = GetAdjustmentRuleForAmbiguousOffsets(dateTime2, out var ruleIndex);
		if (adjustmentRuleForAmbiguousOffsets != null && adjustmentRuleForAmbiguousOffsets.HasDaylightSaving)
		{
			DaylightTimeStruct daylightTime = GetDaylightTime(dateTime2.Year, adjustmentRuleForAmbiguousOffsets, ruleIndex);
			flag = GetIsAmbiguousTime(dateTime2, adjustmentRuleForAmbiguousOffsets, daylightTime);
		}
		if (!flag)
		{
			throw new ArgumentException("The supplied DateTime is not in an ambiguous time range.", "dateTime");
		}
		TimeSpan[] array = new TimeSpan[2];
		TimeSpan timeSpan = _baseUtcOffset + adjustmentRuleForAmbiguousOffsets.BaseUtcOffsetDelta;
		if (adjustmentRuleForAmbiguousOffsets.DaylightDelta > TimeSpan.Zero)
		{
			array[0] = timeSpan;
			array[1] = timeSpan + adjustmentRuleForAmbiguousOffsets.DaylightDelta;
		}
		else
		{
			array[0] = timeSpan + adjustmentRuleForAmbiguousOffsets.DaylightDelta;
			array[1] = timeSpan;
		}
		return array;
	}

	private AdjustmentRule GetAdjustmentRuleForAmbiguousOffsets(DateTime adjustedTime, out int? ruleIndex)
	{
		AdjustmentRule adjustmentRuleForTime = GetAdjustmentRuleForTime(adjustedTime, out ruleIndex);
		if (adjustmentRuleForTime != null && adjustmentRuleForTime.NoDaylightTransitions && !adjustmentRuleForTime.HasDaylightSaving)
		{
			return GetPreviousAdjustmentRule(adjustmentRuleForTime, ruleIndex);
		}
		return adjustmentRuleForTime;
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

	public TimeSpan GetUtcOffset(DateTimeOffset dateTimeOffset)
	{
		return GetUtcOffsetFromUtc(dateTimeOffset.UtcDateTime, this);
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

	public bool IsAmbiguousTime(DateTimeOffset dateTimeOffset)
	{
		if (!_supportsDaylightSavingTime)
		{
			return false;
		}
		return IsAmbiguousTime(ConvertTime(dateTimeOffset, this).DateTime);
	}

	public bool IsAmbiguousTime(DateTime dateTime)
	{
		return IsAmbiguousTime(dateTime, TimeZoneInfoOptions.NoThrowOnInvalidTime);
	}

	internal bool IsAmbiguousTime(DateTime dateTime, TimeZoneInfoOptions flags)
	{
		if (!_supportsDaylightSavingTime)
		{
			return false;
		}
		CachedData cachedData = s_cachedData;
		DateTime dateTime2 = ((dateTime.Kind == DateTimeKind.Local) ? ConvertTime(dateTime, cachedData.Local, this, flags, cachedData) : ((dateTime.Kind == DateTimeKind.Utc) ? ConvertTime(dateTime, s_utcTimeZone, this, flags, cachedData) : dateTime));
		AdjustmentRule adjustmentRuleForTime = GetAdjustmentRuleForTime(dateTime2, out var ruleIndex);
		if (adjustmentRuleForTime != null && adjustmentRuleForTime.HasDaylightSaving)
		{
			DaylightTimeStruct daylightTime = GetDaylightTime(dateTime2.Year, adjustmentRuleForTime, ruleIndex);
			return GetIsAmbiguousTime(dateTime2, adjustmentRuleForTime, daylightTime);
		}
		return false;
	}

	public bool IsDaylightSavingTime(DateTimeOffset dateTimeOffset)
	{
		GetUtcOffsetFromUtc(dateTimeOffset.UtcDateTime, this, out var isDaylightSavings);
		return isDaylightSavings;
	}

	public bool IsDaylightSavingTime(DateTime dateTime)
	{
		return IsDaylightSavingTime(dateTime, TimeZoneInfoOptions.NoThrowOnInvalidTime, s_cachedData);
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

	public bool IsInvalidTime(DateTime dateTime)
	{
		bool result = false;
		if (dateTime.Kind == DateTimeKind.Unspecified || (dateTime.Kind == DateTimeKind.Local && s_cachedData.GetCorrespondingKind(this) == DateTimeKind.Local))
		{
			AdjustmentRule adjustmentRuleForTime = GetAdjustmentRuleForTime(dateTime, out var ruleIndex);
			if (adjustmentRuleForTime != null && adjustmentRuleForTime.HasDaylightSaving)
			{
				DaylightTimeStruct daylightTime = GetDaylightTime(dateTime.Year, adjustmentRuleForTime, ruleIndex);
				result = GetIsInvalidTime(dateTime, adjustmentRuleForTime, daylightTime);
			}
			else
			{
				result = false;
			}
		}
		return result;
	}

	public static void ClearCachedData()
	{
		s_cachedData = new CachedData();
	}

	public static DateTimeOffset ConvertTimeBySystemTimeZoneId(DateTimeOffset dateTimeOffset, string destinationTimeZoneId)
	{
		return ConvertTime(dateTimeOffset, FindSystemTimeZoneById(destinationTimeZoneId));
	}

	public static DateTime ConvertTimeBySystemTimeZoneId(DateTime dateTime, string destinationTimeZoneId)
	{
		return ConvertTime(dateTime, FindSystemTimeZoneById(destinationTimeZoneId));
	}

	public static DateTime ConvertTimeBySystemTimeZoneId(DateTime dateTime, string sourceTimeZoneId, string destinationTimeZoneId)
	{
		if (dateTime.Kind == DateTimeKind.Local && string.Equals(sourceTimeZoneId, Local.Id, StringComparison.OrdinalIgnoreCase))
		{
			CachedData cachedData = s_cachedData;
			return ConvertTime(dateTime, cachedData.Local, FindSystemTimeZoneById(destinationTimeZoneId), TimeZoneInfoOptions.None, cachedData);
		}
		if (dateTime.Kind == DateTimeKind.Utc && string.Equals(sourceTimeZoneId, Utc.Id, StringComparison.OrdinalIgnoreCase))
		{
			return ConvertTime(dateTime, s_utcTimeZone, FindSystemTimeZoneById(destinationTimeZoneId), TimeZoneInfoOptions.None, s_cachedData);
		}
		return ConvertTime(dateTime, FindSystemTimeZoneById(sourceTimeZoneId), FindSystemTimeZoneById(destinationTimeZoneId));
	}

	public static DateTimeOffset ConvertTime(DateTimeOffset dateTimeOffset, TimeZoneInfo destinationTimeZone)
	{
		if (destinationTimeZone == null)
		{
			throw new ArgumentNullException("destinationTimeZone");
		}
		DateTime utcDateTime = dateTimeOffset.UtcDateTime;
		TimeSpan utcOffsetFromUtc = GetUtcOffsetFromUtc(utcDateTime, destinationTimeZone);
		long num = utcDateTime.Ticks + utcOffsetFromUtc.Ticks;
		if (num <= DateTimeOffset.MaxValue.Ticks)
		{
			if (num >= DateTimeOffset.MinValue.Ticks)
			{
				return new DateTimeOffset(num, utcOffsetFromUtc);
			}
			return DateTimeOffset.MinValue;
		}
		return DateTimeOffset.MaxValue;
	}

	public static DateTime ConvertTime(DateTime dateTime, TimeZoneInfo destinationTimeZone)
	{
		if (destinationTimeZone == null)
		{
			throw new ArgumentNullException("destinationTimeZone");
		}
		if (dateTime.Ticks == 0L)
		{
			ClearCachedData();
		}
		CachedData cachedData = s_cachedData;
		TimeZoneInfo sourceTimeZone = ((dateTime.Kind == DateTimeKind.Utc) ? s_utcTimeZone : cachedData.Local);
		return ConvertTime(dateTime, sourceTimeZone, destinationTimeZone, TimeZoneInfoOptions.None, cachedData);
	}

	public static DateTime ConvertTime(DateTime dateTime, TimeZoneInfo sourceTimeZone, TimeZoneInfo destinationTimeZone)
	{
		return ConvertTime(dateTime, sourceTimeZone, destinationTimeZone, TimeZoneInfoOptions.None, s_cachedData);
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

	public static DateTime ConvertTimeFromUtc(DateTime dateTime, TimeZoneInfo destinationTimeZone)
	{
		return ConvertTime(dateTime, s_utcTimeZone, destinationTimeZone, TimeZoneInfoOptions.None, s_cachedData);
	}

	public static DateTime ConvertTimeToUtc(DateTime dateTime)
	{
		if (dateTime.Kind == DateTimeKind.Utc)
		{
			return dateTime;
		}
		CachedData cachedData = s_cachedData;
		return ConvertTime(dateTime, cachedData.Local, s_utcTimeZone, TimeZoneInfoOptions.None, cachedData);
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

	public static DateTime ConvertTimeToUtc(DateTime dateTime, TimeZoneInfo sourceTimeZone)
	{
		return ConvertTime(dateTime, sourceTimeZone, s_utcTimeZone, TimeZoneInfoOptions.None, s_cachedData);
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

	public static TimeZoneInfo FromSerializedString(string source)
	{
		if (source == null)
		{
			throw new ArgumentNullException("source");
		}
		if (source.Length == 0)
		{
			throw new ArgumentException(SR.Format("The specified serialized string '{0}' is not supported.", source), "source");
		}
		return StringSerializer.GetDeserializedTimeZoneInfo(source);
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

	public string ToSerializedString()
	{
		return StringSerializer.GetSerializedString(this);
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

	public static TimeZoneInfo CreateCustomTimeZone(string id, TimeSpan baseUtcOffset, string displayName, string standardDisplayName, string daylightDisplayName, AdjustmentRule[] adjustmentRules)
	{
		return CreateCustomTimeZone(id, baseUtcOffset, displayName, standardDisplayName, daylightDisplayName, adjustmentRules, disableDaylightSavingTime: false);
	}

	public static TimeZoneInfo CreateCustomTimeZone(string id, TimeSpan baseUtcOffset, string displayName, string standardDisplayName, string daylightDisplayName, AdjustmentRule[] adjustmentRules, bool disableDaylightSavingTime)
	{
		if (!disableDaylightSavingTime && adjustmentRules != null && adjustmentRules.Length != 0)
		{
			adjustmentRules = (AdjustmentRule[])adjustmentRules.Clone();
		}
		return new TimeZoneInfo(id, baseUtcOffset, displayName, standardDisplayName, daylightDisplayName, adjustmentRules, disableDaylightSavingTime);
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
			cachedData._systemTimeZones.Add(id, value2);
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

	private static void NormalizeAdjustmentRuleOffset(TimeSpan baseUtcOffset, ref AdjustmentRule adjustmentRule)
	{
		TimeSpan utcOffset = GetUtcOffset(baseUtcOffset, adjustmentRule);
		TimeSpan timeSpan = TimeSpan.Zero;
		if (utcOffset > MaxOffset)
		{
			timeSpan = MaxOffset - utcOffset;
		}
		else if (utcOffset < MinOffset)
		{
			timeSpan = MinOffset - utcOffset;
		}
		if (timeSpan != TimeSpan.Zero)
		{
			adjustmentRule = AdjustmentRule.CreateAdjustmentRule(adjustmentRule.DateStart, adjustmentRule.DateEnd, adjustmentRule.DaylightDelta, adjustmentRule.DaylightTransitionStart, adjustmentRule.DaylightTransitionEnd, adjustmentRule.BaseUtcOffsetDelta + timeSpan, adjustmentRule.NoDaylightTransitions);
		}
	}

	private static string GetTimeZoneDirectoryUnity()
	{
		return string.Empty;
	}

	private static List<AdjustmentRule> CreateAdjustmentRule(int year, out long[] data, out string[] names, string standardNameCurrentYear, string daylightNameCurrentYear)
	{
		List<AdjustmentRule> list = new List<AdjustmentRule>();
		if (!CurrentSystemTimeZone.GetTimeZoneData(year, out data, out names, out var daylight_inverted))
		{
			return list;
		}
		DateTime dateTime = new DateTime(data[0]);
		DateTime value = new DateTime(data[1]);
		TimeSpan daylightDelta = new TimeSpan(data[3]);
		if (standardNameCurrentYear != names[0])
		{
			return list;
		}
		if (daylightNameCurrentYear != names[1])
		{
			return list;
		}
		if (dateTime.Equals(value))
		{
			return list;
		}
		DateTime dateStart = new DateTime(year, 1, 1, 0, 0, 0, 0);
		DateTime dateEnd = new DateTime(year, 12, DateTime.DaysInMonth(year, 12));
		DateTime dateTime2 = new DateTime(year, 12, DateTime.DaysInMonth(year, 12), 23, 59, 59, 999);
		if (!daylight_inverted)
		{
			TransitionTime daylightTransitionStart = TransitionTime.CreateFixedDateRule(new DateTime(1, 1, 1).Add(dateTime.TimeOfDay), dateTime.Month, dateTime.Day);
			TransitionTime daylightTransitionEnd = TransitionTime.CreateFixedDateRule(new DateTime(1, 1, 1).Add(value.TimeOfDay), value.Month, value.Day);
			AdjustmentRule item = AdjustmentRule.CreateAdjustmentRule(dateStart, dateEnd, daylightDelta, daylightTransitionStart, daylightTransitionEnd);
			list.Add(item);
		}
		else
		{
			TransitionTime daylightTransitionStart2 = TransitionTime.CreateFixedDateRule(new DateTime(1, 1, 1), 1, 1);
			TransitionTime daylightTransitionEnd2 = TransitionTime.CreateFixedDateRule(new DateTime(1, 1, 1).Add(dateTime.TimeOfDay), dateTime.Month, dateTime.Day);
			AdjustmentRule item2 = AdjustmentRule.CreateAdjustmentRule(new DateTime(year, 1, 1), new DateTime(dateTime.Year, dateTime.Month, dateTime.Day), daylightDelta, daylightTransitionStart2, daylightTransitionEnd2);
			list.Add(item2);
			TransitionTime daylightTransitionStart3 = TransitionTime.CreateFixedDateRule(new DateTime(1, 1, 1).Add(value.TimeOfDay), value.Month, value.Day);
			TransitionTime daylightTransitionEnd3 = TransitionTime.CreateFixedDateRule(new DateTime(1, 1, 1).Add(dateTime2.TimeOfDay), dateTime2.Month, dateTime2.Day);
			AdjustmentRule item3 = AdjustmentRule.CreateAdjustmentRule(new DateTime(dateTime.Year, dateTime.Month, dateTime.Day).AddDays(1.0), dateEnd, daylightDelta, daylightTransitionStart3, daylightTransitionEnd3);
			list.Add(item3);
		}
		return list;
	}

	private static TimeZoneInfo CreateLocalUnity()
	{
		int year = DateTime.UtcNow.Year;
		if (!CurrentSystemTimeZone.GetTimeZoneData(year, out var data, out var names, out var _))
		{
			throw new NotSupportedException("Can't get timezone name.");
		}
		TimeSpan timeSpan = TimeSpan.FromTicks(data[2]);
		string displayName = "(GMT" + ((timeSpan >= TimeSpan.Zero) ? '+' : '-') + timeSpan.ToString("hh\\:mm") + ") Local Time";
		string text = names[0];
		string text2 = names[1];
		List<AdjustmentRule> list = new List<AdjustmentRule>();
		bool flag = data[3] == 0;
		if (!flag)
		{
			int num = 1971;
			int num2 = 2037;
			for (int i = year; i <= num2; i++)
			{
				List<AdjustmentRule> list2 = CreateAdjustmentRule(i, out data, out names, text, text2);
				if (list2.Count <= 0)
				{
					break;
				}
				list.AddRange(list2);
			}
			for (int num3 = year - 1; num3 >= num; num3--)
			{
				List<AdjustmentRule> list3 = CreateAdjustmentRule(num3, out data, out names, text, text2);
				if (list3.Count <= 0)
				{
					break;
				}
				list.AddRange(list3);
			}
			list.Sort((AdjustmentRule rule1, AdjustmentRule rule2) => rule1.DateStart.CompareTo(rule2.DateStart));
		}
		return CreateCustomTimeZone("Local", timeSpan, displayName, text, text2, list.ToArray(), flag);
	}

	internal TimeZoneInfo()
	{
		ThrowStub.ThrowNotSupportedException();
	}
}
