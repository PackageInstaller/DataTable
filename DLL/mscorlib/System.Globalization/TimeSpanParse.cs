using System.Text;

namespace System.Globalization;

internal static class TimeSpanParse
{
	private enum ParseFailureKind : byte
	{
		None,
		ArgumentNull,
		Format,
		FormatWithParameter,
		Overflow
	}

	[Flags]
	private enum TimeSpanStandardStyles : byte
	{
		None = 0,
		Invariant = 1,
		Localized = 2,
		RequireFull = 4,
		Any = Invariant | Localized
	}

	private enum TTT : byte
	{
		None,
		End,
		Num,
		Sep,
		NumOverflow
	}

	private ref struct TimeSpanToken
	{
		internal TTT _ttt;

		internal int _num;

		internal int _zeroes;

		internal ReadOnlySpan<char> _sep;

		public TimeSpanToken(TTT type)
			: this(type, 0, 0, default(ReadOnlySpan<char>))
		{
		}

		public TimeSpanToken(int number)
			: this(TTT.Num, number, 0, default(ReadOnlySpan<char>))
		{
		}

		public TimeSpanToken(int number, int leadingZeroes)
			: this(TTT.Num, number, leadingZeroes, default(ReadOnlySpan<char>))
		{
		}

		public TimeSpanToken(TTT type, int number, int leadingZeroes, ReadOnlySpan<char> separator)
		{
			_ttt = type;
			_num = number;
			_zeroes = leadingZeroes;
			_sep = separator;
		}

		public bool IsInvalidFraction()
		{
			if (_num > 9999999 || _zeroes > 7)
			{
				return true;
			}
			if (_num == 0 || _zeroes == 0)
			{
				return false;
			}
			return _num >= 9999999 / Pow10(_zeroes - 1);
		}
	}

	private ref struct TimeSpanTokenizer
	{
		private ReadOnlySpan<char> _value;

		private int _pos;

		internal bool EOL => _pos >= _value.Length - 1;

		internal char NextChar
		{
			get
			{
				int num = ++_pos;
				if ((uint)num >= (uint)_value.Length)
				{
					return '\0';
				}
				return _value[num];
			}
		}

		internal TimeSpanTokenizer(ReadOnlySpan<char> input)
			: this(input, 0)
		{
		}

		internal TimeSpanTokenizer(ReadOnlySpan<char> input, int startPosition)
		{
			_value = input;
			_pos = startPosition;
		}

		internal TimeSpanToken GetNextToken()
		{
			int pos = _pos;
			if (pos >= _value.Length)
			{
				return new TimeSpanToken(TTT.End);
			}
			int num = _value[pos] - 48;
			if ((uint)num <= 9u)
			{
				int num2 = 0;
				if (num == 0)
				{
					num2 = 1;
					int num3;
					while (true)
					{
						if (++_pos >= _value.Length || (uint)(num3 = _value[_pos] - 48) > 9u)
						{
							return new TimeSpanToken(TTT.Num, 0, num2, default(ReadOnlySpan<char>));
						}
						if (num3 != 0)
						{
							break;
						}
						num2++;
					}
					num = num3;
				}
				while (++_pos < _value.Length)
				{
					int num4 = _value[_pos] - 48;
					if ((uint)num4 > 9u)
					{
						break;
					}
					num = num * 10 + num4;
					if ((num & 0xF0000000u) != 0L)
					{
						return new TimeSpanToken(TTT.NumOverflow);
					}
				}
				return new TimeSpanToken(TTT.Num, num, num2, default(ReadOnlySpan<char>));
			}
			int num5 = 1;
			while (++_pos < _value.Length && (uint)(_value[_pos] - 48) > 9u)
			{
				num5++;
			}
			return new TimeSpanToken(TTT.Sep, 0, 0, _value.Slice(pos, num5));
		}

		internal void BackOne()
		{
			if (_pos > 0)
			{
				_pos--;
			}
		}
	}

	private ref struct TimeSpanRawInfo
	{
		internal TTT _lastSeenTTT;

		internal int _tokenCount;

		internal int _sepCount;

		internal int _numCount;

		private TimeSpanFormat.FormatLiterals _posLoc;

		private TimeSpanFormat.FormatLiterals _negLoc;

		private bool _posLocInit;

		private bool _negLocInit;

		private string _fullPosPattern;

		private string _fullNegPattern;

		internal TimeSpanToken _numbers0;

		internal TimeSpanToken _numbers1;

		internal TimeSpanToken _numbers2;

		internal TimeSpanToken _numbers3;

		internal TimeSpanToken _numbers4;

		internal ReadOnlySpan<char> _literals0;

		internal ReadOnlySpan<char> _literals1;

		internal ReadOnlySpan<char> _literals2;

		internal ReadOnlySpan<char> _literals3;

		internal ReadOnlySpan<char> _literals4;

		internal ReadOnlySpan<char> _literals5;

		internal TimeSpanFormat.FormatLiterals PositiveInvariant => TimeSpanFormat.PositiveInvariantFormatLiterals;

		internal TimeSpanFormat.FormatLiterals NegativeInvariant => TimeSpanFormat.NegativeInvariantFormatLiterals;

		internal TimeSpanFormat.FormatLiterals PositiveLocalized
		{
			get
			{
				if (!_posLocInit)
				{
					_posLoc = default(TimeSpanFormat.FormatLiterals);
					_posLoc.Init(_fullPosPattern, useInvariantFieldLengths: false);
					_posLocInit = true;
				}
				return _posLoc;
			}
		}

		internal TimeSpanFormat.FormatLiterals NegativeLocalized
		{
			get
			{
				if (!_negLocInit)
				{
					_negLoc = default(TimeSpanFormat.FormatLiterals);
					_negLoc.Init(_fullNegPattern, useInvariantFieldLengths: false);
					_negLocInit = true;
				}
				return _negLoc;
			}
		}

		internal bool FullAppCompatMatch(TimeSpanFormat.FormatLiterals pattern)
		{
			if (_sepCount == 5 && _numCount == 4 && _literals0.EqualsOrdinal(pattern.Start) && _literals1.EqualsOrdinal(pattern.DayHourSep) && _literals2.EqualsOrdinal(pattern.HourMinuteSep) && _literals3.EqualsOrdinal(pattern.AppCompatLiteral))
			{
				return _literals4.EqualsOrdinal(pattern.End);
			}
			return false;
		}

		internal bool PartialAppCompatMatch(TimeSpanFormat.FormatLiterals pattern)
		{
			if (_sepCount == 4 && _numCount == 3 && _literals0.EqualsOrdinal(pattern.Start) && _literals1.EqualsOrdinal(pattern.HourMinuteSep) && _literals2.EqualsOrdinal(pattern.AppCompatLiteral))
			{
				return _literals3.EqualsOrdinal(pattern.End);
			}
			return false;
		}

		internal bool FullMatch(TimeSpanFormat.FormatLiterals pattern)
		{
			if (_sepCount == 6 && _numCount == 5 && _literals0.EqualsOrdinal(pattern.Start) && _literals1.EqualsOrdinal(pattern.DayHourSep) && _literals2.EqualsOrdinal(pattern.HourMinuteSep) && _literals3.EqualsOrdinal(pattern.MinuteSecondSep) && _literals4.EqualsOrdinal(pattern.SecondFractionSep))
			{
				return _literals5.EqualsOrdinal(pattern.End);
			}
			return false;
		}

		internal bool FullDMatch(TimeSpanFormat.FormatLiterals pattern)
		{
			if (_sepCount == 2 && _numCount == 1 && _literals0.EqualsOrdinal(pattern.Start))
			{
				return _literals1.EqualsOrdinal(pattern.End);
			}
			return false;
		}

		internal bool FullHMMatch(TimeSpanFormat.FormatLiterals pattern)
		{
			if (_sepCount == 3 && _numCount == 2 && _literals0.EqualsOrdinal(pattern.Start) && _literals1.EqualsOrdinal(pattern.HourMinuteSep))
			{
				return _literals2.EqualsOrdinal(pattern.End);
			}
			return false;
		}

		internal bool FullDHMMatch(TimeSpanFormat.FormatLiterals pattern)
		{
			if (_sepCount == 4 && _numCount == 3 && _literals0.EqualsOrdinal(pattern.Start) && _literals1.EqualsOrdinal(pattern.DayHourSep) && _literals2.EqualsOrdinal(pattern.HourMinuteSep))
			{
				return _literals3.EqualsOrdinal(pattern.End);
			}
			return false;
		}

		internal bool FullHMSMatch(TimeSpanFormat.FormatLiterals pattern)
		{
			if (_sepCount == 4 && _numCount == 3 && _literals0.EqualsOrdinal(pattern.Start) && _literals1.EqualsOrdinal(pattern.HourMinuteSep) && _literals2.EqualsOrdinal(pattern.MinuteSecondSep))
			{
				return _literals3.EqualsOrdinal(pattern.End);
			}
			return false;
		}

		internal bool FullDHMSMatch(TimeSpanFormat.FormatLiterals pattern)
		{
			if (_sepCount == 5 && _numCount == 4 && _literals0.EqualsOrdinal(pattern.Start) && _literals1.EqualsOrdinal(pattern.DayHourSep) && _literals2.EqualsOrdinal(pattern.HourMinuteSep) && _literals3.EqualsOrdinal(pattern.MinuteSecondSep))
			{
				return _literals4.EqualsOrdinal(pattern.End);
			}
			return false;
		}

		internal bool FullHMSFMatch(TimeSpanFormat.FormatLiterals pattern)
		{
			if (_sepCount == 5 && _numCount == 4 && _literals0.EqualsOrdinal(pattern.Start) && _literals1.EqualsOrdinal(pattern.HourMinuteSep) && _literals2.EqualsOrdinal(pattern.MinuteSecondSep) && _literals3.EqualsOrdinal(pattern.SecondFractionSep))
			{
				return _literals4.EqualsOrdinal(pattern.End);
			}
			return false;
		}

		internal void Init(DateTimeFormatInfo dtfi)
		{
			_lastSeenTTT = TTT.None;
			_tokenCount = 0;
			_sepCount = 0;
			_numCount = 0;
			_fullPosPattern = dtfi.FullTimeSpanPositivePattern;
			_fullNegPattern = dtfi.FullTimeSpanNegativePattern;
			_posLocInit = false;
			_negLocInit = false;
		}

		internal bool ProcessToken(ref TimeSpanToken tok, ref TimeSpanResult result)
		{
			switch (tok._ttt)
			{
			case TTT.Num:
				if ((_tokenCount == 0 && !AddSep(default(ReadOnlySpan<char>), ref result)) || !AddNum(tok, ref result))
				{
					return false;
				}
				break;
			case TTT.Sep:
				if (!AddSep(tok._sep, ref result))
				{
					return false;
				}
				break;
			case TTT.NumOverflow:
				return result.SetFailure(ParseFailureKind.Overflow, "The TimeSpan could not be parsed because at least one of the numeric components is out of range or contains too many digits.");
			default:
				return result.SetFailure(ParseFailureKind.Format, "String was not recognized as a valid TimeSpan.");
			}
			_lastSeenTTT = tok._ttt;
			return true;
		}

		private bool AddSep(ReadOnlySpan<char> sep, ref TimeSpanResult result)
		{
			if (_sepCount >= 6 || _tokenCount >= 11)
			{
				return result.SetFailure(ParseFailureKind.Format, "String was not recognized as a valid TimeSpan.");
			}
			switch (_sepCount++)
			{
			case 0:
				_literals0 = sep;
				break;
			case 1:
				_literals1 = sep;
				break;
			case 2:
				_literals2 = sep;
				break;
			case 3:
				_literals3 = sep;
				break;
			case 4:
				_literals4 = sep;
				break;
			default:
				_literals5 = sep;
				break;
			}
			_tokenCount++;
			return true;
		}

		private bool AddNum(TimeSpanToken num, ref TimeSpanResult result)
		{
			if (_numCount >= 5 || _tokenCount >= 11)
			{
				return result.SetFailure(ParseFailureKind.Format, "String was not recognized as a valid TimeSpan.");
			}
			switch (_numCount++)
			{
			case 0:
				_numbers0 = num;
				break;
			case 1:
				_numbers1 = num;
				break;
			case 2:
				_numbers2 = num;
				break;
			case 3:
				_numbers3 = num;
				break;
			default:
				_numbers4 = num;
				break;
			}
			_tokenCount++;
			return true;
		}
	}

	private struct TimeSpanResult
	{
		internal TimeSpan parsedTimeSpan;

		private readonly bool _throwOnFailure;

		internal TimeSpanResult(bool throwOnFailure)
		{
			parsedTimeSpan = default(TimeSpan);
			_throwOnFailure = throwOnFailure;
		}

		internal bool SetFailure(ParseFailureKind kind, string resourceKey, object messageArgument = null, string argumentName = null)
		{
			if (!_throwOnFailure)
			{
				return false;
			}
			string resourceString = SR.GetResourceString(resourceKey);
			switch (kind)
			{
			case ParseFailureKind.ArgumentNull:
				throw new ArgumentNullException(argumentName, resourceString);
			case ParseFailureKind.FormatWithParameter:
				throw new FormatException(SR.Format(resourceString, messageArgument));
			case ParseFailureKind.Overflow:
				throw new OverflowException(resourceString);
			default:
				throw new FormatException(resourceString);
			}
		}
	}

	private ref struct StringParser
	{
		private ReadOnlySpan<char> _str;

		private char _ch;

		private int _pos;

		private int _len;

		internal void NextChar()
		{
			if (_pos < _len)
			{
				_pos++;
			}
			_ch = ((_pos < _len) ? _str[_pos] : '\0');
		}

		internal char NextNonDigit()
		{
			for (int i = _pos; i < _len; i++)
			{
				char c = _str[i];
				if (c < '0' || c > '9')
				{
					return c;
				}
			}
			return '\0';
		}

		internal bool TryParse(ReadOnlySpan<char> input, ref TimeSpanResult result)
		{
			result.parsedTimeSpan = default(TimeSpan);
			_str = input;
			_len = input.Length;
			_pos = -1;
			NextChar();
			SkipBlanks();
			bool flag = false;
			if (_ch == '-')
			{
				flag = true;
				NextChar();
			}
			long time;
			if (NextNonDigit() == ':')
			{
				if (!ParseTime(out time, ref result))
				{
					return false;
				}
			}
			else
			{
				if (!ParseInt(10675199, out var i, ref result))
				{
					return false;
				}
				time = i * 864000000000L;
				if (_ch == '.')
				{
					NextChar();
					if (!ParseTime(out var time2, ref result))
					{
						return false;
					}
					time += time2;
				}
			}
			if (flag)
			{
				time = -time;
				if (time > 0)
				{
					return result.SetFailure(ParseFailureKind.Overflow, "The TimeSpan could not be parsed because at least one of the numeric components is out of range or contains too many digits.");
				}
			}
			else if (time < 0)
			{
				return result.SetFailure(ParseFailureKind.Overflow, "The TimeSpan could not be parsed because at least one of the numeric components is out of range or contains too many digits.");
			}
			SkipBlanks();
			if (_pos < _len)
			{
				return result.SetFailure(ParseFailureKind.Format, "String was not recognized as a valid TimeSpan.");
			}
			result.parsedTimeSpan = new TimeSpan(time);
			return true;
		}

		internal bool ParseInt(int max, out int i, ref TimeSpanResult result)
		{
			i = 0;
			int pos = _pos;
			while (_ch >= '0' && _ch <= '9')
			{
				if ((i & 0xF0000000u) != 0L)
				{
					return result.SetFailure(ParseFailureKind.Overflow, "The TimeSpan could not be parsed because at least one of the numeric components is out of range or contains too many digits.");
				}
				i = i * 10 + _ch - 48;
				if (i < 0)
				{
					return result.SetFailure(ParseFailureKind.Overflow, "The TimeSpan could not be parsed because at least one of the numeric components is out of range or contains too many digits.");
				}
				NextChar();
			}
			if (pos == _pos)
			{
				return result.SetFailure(ParseFailureKind.Format, "String was not recognized as a valid TimeSpan.");
			}
			if (i > max)
			{
				return result.SetFailure(ParseFailureKind.Overflow, "The TimeSpan could not be parsed because at least one of the numeric components is out of range or contains too many digits.");
			}
			return true;
		}

		internal bool ParseTime(out long time, ref TimeSpanResult result)
		{
			time = 0L;
			if (!ParseInt(23, out var i, ref result))
			{
				return false;
			}
			time = i * 36000000000L;
			if (_ch != ':')
			{
				return result.SetFailure(ParseFailureKind.Format, "String was not recognized as a valid TimeSpan.");
			}
			NextChar();
			if (!ParseInt(59, out i, ref result))
			{
				return false;
			}
			time += (long)i * 600000000L;
			if (_ch == ':')
			{
				NextChar();
				if (_ch != '.')
				{
					if (!ParseInt(59, out i, ref result))
					{
						return false;
					}
					time += (long)i * 10000000L;
				}
				if (_ch == '.')
				{
					NextChar();
					int num = 10000000;
					while (num > 1 && _ch >= '0' && _ch <= '9')
					{
						num /= 10;
						time += (_ch - 48) * num;
						NextChar();
					}
				}
			}
			return true;
		}

		internal void SkipBlanks()
		{
			while (_ch == ' ' || _ch == '\t')
			{
				NextChar();
			}
		}
	}

	internal static long Pow10(int pow)
	{
		return pow switch
		{
			0 => 1L, 
			1 => 10L, 
			2 => 100L, 
			3 => 1000L, 
			4 => 10000L, 
			5 => 100000L, 
			6 => 1000000L, 
			7 => 10000000L, 
			_ => (long)Math.Pow(10.0, pow), 
		};
	}

	private static bool TryTimeToTicks(bool positive, TimeSpanToken days, TimeSpanToken hours, TimeSpanToken minutes, TimeSpanToken seconds, TimeSpanToken fraction, out long result)
	{
		if (days._num > 10675199 || hours._num > 23 || minutes._num > 59 || seconds._num > 59 || fraction.IsInvalidFraction())
		{
			result = 0L;
			return false;
		}
		long num = ((long)days._num * 3600L * 24 + (long)hours._num * 3600L + (long)minutes._num * 60L + seconds._num) * 1000;
		if (num > 922337203685477L || num < -922337203685477L)
		{
			result = 0L;
			return false;
		}
		long num2 = fraction._num;
		if (num2 != 0L)
		{
			long num3 = 1000000L;
			if (fraction._zeroes > 0)
			{
				long num4 = Pow10(fraction._zeroes);
				num3 /= num4;
			}
			while (num2 < num3)
			{
				num2 *= 10;
			}
		}
		result = num * 10000 + num2;
		if (positive && result < 0)
		{
			result = 0L;
			return false;
		}
		return true;
	}

	internal static TimeSpan Parse(ReadOnlySpan<char> input, IFormatProvider formatProvider)
	{
		TimeSpanResult result = new TimeSpanResult(throwOnFailure: true);
		TryParseTimeSpan(input, TimeSpanStandardStyles.Any, formatProvider, ref result);
		return result.parsedTimeSpan;
	}

	internal static bool TryParse(ReadOnlySpan<char> input, IFormatProvider formatProvider, out TimeSpan result)
	{
		TimeSpanResult result2 = new TimeSpanResult(throwOnFailure: false);
		if (TryParseTimeSpan(input, TimeSpanStandardStyles.Any, formatProvider, ref result2))
		{
			result = result2.parsedTimeSpan;
			return true;
		}
		result = default(TimeSpan);
		return false;
	}

	internal static TimeSpan ParseExact(ReadOnlySpan<char> input, ReadOnlySpan<char> format, IFormatProvider formatProvider, TimeSpanStyles styles)
	{
		TimeSpanResult result = new TimeSpanResult(throwOnFailure: true);
		TryParseExactTimeSpan(input, format, formatProvider, styles, ref result);
		return result.parsedTimeSpan;
	}

	internal static bool TryParseExact(ReadOnlySpan<char> input, ReadOnlySpan<char> format, IFormatProvider formatProvider, TimeSpanStyles styles, out TimeSpan result)
	{
		TimeSpanResult result2 = new TimeSpanResult(throwOnFailure: false);
		if (TryParseExactTimeSpan(input, format, formatProvider, styles, ref result2))
		{
			result = result2.parsedTimeSpan;
			return true;
		}
		result = default(TimeSpan);
		return false;
	}

	internal static TimeSpan ParseExactMultiple(ReadOnlySpan<char> input, string[] formats, IFormatProvider formatProvider, TimeSpanStyles styles)
	{
		TimeSpanResult result = new TimeSpanResult(throwOnFailure: true);
		TryParseExactMultipleTimeSpan(input, formats, formatProvider, styles, ref result);
		return result.parsedTimeSpan;
	}

	internal static bool TryParseExactMultiple(ReadOnlySpan<char> input, string[] formats, IFormatProvider formatProvider, TimeSpanStyles styles, out TimeSpan result)
	{
		TimeSpanResult result2 = new TimeSpanResult(throwOnFailure: false);
		if (TryParseExactMultipleTimeSpan(input, formats, formatProvider, styles, ref result2))
		{
			result = result2.parsedTimeSpan;
			return true;
		}
		result = default(TimeSpan);
		return false;
	}

	private static bool TryParseTimeSpan(ReadOnlySpan<char> input, TimeSpanStandardStyles style, IFormatProvider formatProvider, ref TimeSpanResult result)
	{
		input = input.Trim();
		if (input.IsEmpty)
		{
			return result.SetFailure(ParseFailureKind.Format, "String was not recognized as a valid TimeSpan.");
		}
		TimeSpanTokenizer timeSpanTokenizer = new TimeSpanTokenizer(input);
		TimeSpanRawInfo raw = default(TimeSpanRawInfo);
		raw.Init(DateTimeFormatInfo.GetInstance(formatProvider));
		TimeSpanToken tok = timeSpanTokenizer.GetNextToken();
		while (tok._ttt != TTT.End)
		{
			if (!raw.ProcessToken(ref tok, ref result))
			{
				return result.SetFailure(ParseFailureKind.Format, "String was not recognized as a valid TimeSpan.");
			}
			tok = timeSpanTokenizer.GetNextToken();
		}
		if (!ProcessTerminalState(ref raw, style, ref result))
		{
			return result.SetFailure(ParseFailureKind.Format, "String was not recognized as a valid TimeSpan.");
		}
		return true;
	}

	private static bool ProcessTerminalState(ref TimeSpanRawInfo raw, TimeSpanStandardStyles style, ref TimeSpanResult result)
	{
		if (raw._lastSeenTTT == TTT.Num)
		{
			TimeSpanToken tok = new TimeSpanToken
			{
				_ttt = TTT.Sep
			};
			if (!raw.ProcessToken(ref tok, ref result))
			{
				return result.SetFailure(ParseFailureKind.Format, "String was not recognized as a valid TimeSpan.");
			}
		}
		return raw._numCount switch
		{
			1 => ProcessTerminal_D(ref raw, style, ref result), 
			2 => ProcessTerminal_HM(ref raw, style, ref result), 
			3 => ProcessTerminal_HM_S_D(ref raw, style, ref result), 
			4 => ProcessTerminal_HMS_F_D(ref raw, style, ref result), 
			5 => ProcessTerminal_DHMSF(ref raw, style, ref result), 
			_ => result.SetFailure(ParseFailureKind.Format, "String was not recognized as a valid TimeSpan."), 
		};
	}

	private static bool ProcessTerminal_DHMSF(ref TimeSpanRawInfo raw, TimeSpanStandardStyles style, ref TimeSpanResult result)
	{
		if (raw._sepCount != 6)
		{
			return result.SetFailure(ParseFailureKind.Format, "String was not recognized as a valid TimeSpan.");
		}
		bool num = (style & TimeSpanStandardStyles.Invariant) != 0;
		bool flag = (style & TimeSpanStandardStyles.Localized) != 0;
		bool flag2 = false;
		bool flag3 = false;
		if (num)
		{
			if (raw.FullMatch(raw.PositiveInvariant))
			{
				flag3 = true;
				flag2 = true;
			}
			if (!flag3 && raw.FullMatch(raw.NegativeInvariant))
			{
				flag3 = true;
				flag2 = false;
			}
		}
		if (flag)
		{
			if (!flag3 && raw.FullMatch(raw.PositiveLocalized))
			{
				flag3 = true;
				flag2 = true;
			}
			if (!flag3 && raw.FullMatch(raw.NegativeLocalized))
			{
				flag3 = true;
				flag2 = false;
			}
		}
		if (flag3)
		{
			if (!TryTimeToTicks(flag2, raw._numbers0, raw._numbers1, raw._numbers2, raw._numbers3, raw._numbers4, out var result2))
			{
				return result.SetFailure(ParseFailureKind.Overflow, "The TimeSpan could not be parsed because at least one of the numeric components is out of range or contains too many digits.");
			}
			if (!flag2)
			{
				result2 = -result2;
				if (result2 > 0)
				{
					return result.SetFailure(ParseFailureKind.Overflow, "The TimeSpan could not be parsed because at least one of the numeric components is out of range or contains too many digits.");
				}
			}
			result.parsedTimeSpan = new TimeSpan(result2);
			return true;
		}
		return result.SetFailure(ParseFailureKind.Format, "String was not recognized as a valid TimeSpan.");
	}

	private static bool ProcessTerminal_HMS_F_D(ref TimeSpanRawInfo raw, TimeSpanStandardStyles style, ref TimeSpanResult result)
	{
		if (raw._sepCount != 5 || (style & TimeSpanStandardStyles.RequireFull) != TimeSpanStandardStyles.None)
		{
			return result.SetFailure(ParseFailureKind.Format, "String was not recognized as a valid TimeSpan.");
		}
		bool num = (style & TimeSpanStandardStyles.Invariant) != 0;
		bool flag = (style & TimeSpanStandardStyles.Localized) != 0;
		long result2 = 0L;
		bool flag2 = false;
		bool flag3 = false;
		bool flag4 = false;
		TimeSpanToken timeSpanToken = new TimeSpanToken(0);
		if (num)
		{
			if (raw.FullHMSFMatch(raw.PositiveInvariant))
			{
				flag2 = true;
				flag3 = TryTimeToTicks(flag2, timeSpanToken, raw._numbers0, raw._numbers1, raw._numbers2, raw._numbers3, out result2);
				flag4 = flag4 || !flag3;
			}
			if (!flag3 && raw.FullDHMSMatch(raw.PositiveInvariant))
			{
				flag2 = true;
				flag3 = TryTimeToTicks(flag2, raw._numbers0, raw._numbers1, raw._numbers2, raw._numbers3, timeSpanToken, out result2);
				flag4 = flag4 || !flag3;
			}
			if (!flag3 && raw.FullAppCompatMatch(raw.PositiveInvariant))
			{
				flag2 = true;
				flag3 = TryTimeToTicks(flag2, raw._numbers0, raw._numbers1, raw._numbers2, timeSpanToken, raw._numbers3, out result2);
				flag4 = flag4 || !flag3;
			}
			if (!flag3 && raw.FullHMSFMatch(raw.NegativeInvariant))
			{
				flag2 = false;
				flag3 = TryTimeToTicks(flag2, timeSpanToken, raw._numbers0, raw._numbers1, raw._numbers2, raw._numbers3, out result2);
				flag4 = flag4 || !flag3;
			}
			if (!flag3 && raw.FullDHMSMatch(raw.NegativeInvariant))
			{
				flag2 = false;
				flag3 = TryTimeToTicks(flag2, raw._numbers0, raw._numbers1, raw._numbers2, raw._numbers3, timeSpanToken, out result2);
				flag4 = flag4 || !flag3;
			}
			if (!flag3 && raw.FullAppCompatMatch(raw.NegativeInvariant))
			{
				flag2 = false;
				flag3 = TryTimeToTicks(flag2, raw._numbers0, raw._numbers1, raw._numbers2, timeSpanToken, raw._numbers3, out result2);
				flag4 = flag4 || !flag3;
			}
		}
		if (flag)
		{
			if (!flag3 && raw.FullHMSFMatch(raw.PositiveLocalized))
			{
				flag2 = true;
				flag3 = TryTimeToTicks(flag2, timeSpanToken, raw._numbers0, raw._numbers1, raw._numbers2, raw._numbers3, out result2);
				flag4 = flag4 || !flag3;
			}
			if (!flag3 && raw.FullDHMSMatch(raw.PositiveLocalized))
			{
				flag2 = true;
				flag3 = TryTimeToTicks(flag2, raw._numbers0, raw._numbers1, raw._numbers2, raw._numbers3, timeSpanToken, out result2);
				flag4 = flag4 || !flag3;
			}
			if (!flag3 && raw.FullAppCompatMatch(raw.PositiveLocalized))
			{
				flag2 = true;
				flag3 = TryTimeToTicks(flag2, raw._numbers0, raw._numbers1, raw._numbers2, timeSpanToken, raw._numbers3, out result2);
				flag4 = flag4 || !flag3;
			}
			if (!flag3 && raw.FullHMSFMatch(raw.NegativeLocalized))
			{
				flag2 = false;
				flag3 = TryTimeToTicks(flag2, timeSpanToken, raw._numbers0, raw._numbers1, raw._numbers2, raw._numbers3, out result2);
				flag4 = flag4 || !flag3;
			}
			if (!flag3 && raw.FullDHMSMatch(raw.NegativeLocalized))
			{
				flag2 = false;
				flag3 = TryTimeToTicks(flag2, raw._numbers0, raw._numbers1, raw._numbers2, raw._numbers3, timeSpanToken, out result2);
				flag4 = flag4 || !flag3;
			}
			if (!flag3 && raw.FullAppCompatMatch(raw.NegativeLocalized))
			{
				flag2 = false;
				flag3 = TryTimeToTicks(flag2, raw._numbers0, raw._numbers1, raw._numbers2, timeSpanToken, raw._numbers3, out result2);
				flag4 = flag4 || !flag3;
			}
		}
		if (flag3)
		{
			if (!flag2)
			{
				result2 = -result2;
				if (result2 > 0)
				{
					return result.SetFailure(ParseFailureKind.Overflow, "The TimeSpan could not be parsed because at least one of the numeric components is out of range or contains too many digits.");
				}
			}
			result.parsedTimeSpan = new TimeSpan(result2);
			return true;
		}
		if (!flag4)
		{
			return result.SetFailure(ParseFailureKind.Format, "String was not recognized as a valid TimeSpan.");
		}
		return result.SetFailure(ParseFailureKind.Overflow, "The TimeSpan could not be parsed because at least one of the numeric components is out of range or contains too many digits.");
	}

	private static bool ProcessTerminal_HM_S_D(ref TimeSpanRawInfo raw, TimeSpanStandardStyles style, ref TimeSpanResult result)
	{
		if (raw._sepCount != 4 || (style & TimeSpanStandardStyles.RequireFull) != TimeSpanStandardStyles.None)
		{
			return result.SetFailure(ParseFailureKind.Format, "String was not recognized as a valid TimeSpan.");
		}
		bool num = (style & TimeSpanStandardStyles.Invariant) != 0;
		bool flag = (style & TimeSpanStandardStyles.Localized) != 0;
		bool flag2 = false;
		bool flag3 = false;
		bool flag4 = false;
		TimeSpanToken timeSpanToken = new TimeSpanToken(0);
		long result2 = 0L;
		if (num)
		{
			if (raw.FullHMSMatch(raw.PositiveInvariant))
			{
				flag2 = true;
				flag3 = TryTimeToTicks(flag2, timeSpanToken, raw._numbers0, raw._numbers1, raw._numbers2, timeSpanToken, out result2);
				flag4 = flag4 || !flag3;
			}
			if (!flag3 && raw.FullDHMMatch(raw.PositiveInvariant))
			{
				flag2 = true;
				flag3 = TryTimeToTicks(flag2, raw._numbers0, raw._numbers1, raw._numbers2, timeSpanToken, timeSpanToken, out result2);
				flag4 = flag4 || !flag3;
			}
			if (!flag3 && raw.PartialAppCompatMatch(raw.PositiveInvariant))
			{
				flag2 = true;
				flag3 = TryTimeToTicks(flag2, timeSpanToken, raw._numbers0, raw._numbers1, timeSpanToken, raw._numbers2, out result2);
				flag4 = flag4 || !flag3;
			}
			if (!flag3 && raw.FullHMSMatch(raw.NegativeInvariant))
			{
				flag2 = false;
				flag3 = TryTimeToTicks(flag2, timeSpanToken, raw._numbers0, raw._numbers1, raw._numbers2, timeSpanToken, out result2);
				flag4 = flag4 || !flag3;
			}
			if (!flag3 && raw.FullDHMMatch(raw.NegativeInvariant))
			{
				flag2 = false;
				flag3 = TryTimeToTicks(flag2, raw._numbers0, raw._numbers1, raw._numbers2, timeSpanToken, timeSpanToken, out result2);
				flag4 = flag4 || !flag3;
			}
			if (!flag3 && raw.PartialAppCompatMatch(raw.NegativeInvariant))
			{
				flag2 = false;
				flag3 = TryTimeToTicks(flag2, timeSpanToken, raw._numbers0, raw._numbers1, timeSpanToken, raw._numbers2, out result2);
				flag4 = flag4 || !flag3;
			}
		}
		if (flag)
		{
			if (!flag3 && raw.FullHMSMatch(raw.PositiveLocalized))
			{
				flag2 = true;
				flag3 = TryTimeToTicks(flag2, timeSpanToken, raw._numbers0, raw._numbers1, raw._numbers2, timeSpanToken, out result2);
				flag4 = flag4 || !flag3;
			}
			if (!flag3 && raw.FullDHMMatch(raw.PositiveLocalized))
			{
				flag2 = true;
				flag3 = TryTimeToTicks(flag2, raw._numbers0, raw._numbers1, raw._numbers2, timeSpanToken, timeSpanToken, out result2);
				flag4 = flag4 || !flag3;
			}
			if (!flag3 && raw.PartialAppCompatMatch(raw.PositiveLocalized))
			{
				flag2 = true;
				flag3 = TryTimeToTicks(flag2, timeSpanToken, raw._numbers0, raw._numbers1, timeSpanToken, raw._numbers2, out result2);
				flag4 = flag4 || !flag3;
			}
			if (!flag3 && raw.FullHMSMatch(raw.NegativeLocalized))
			{
				flag2 = false;
				flag3 = TryTimeToTicks(flag2, timeSpanToken, raw._numbers0, raw._numbers1, raw._numbers2, timeSpanToken, out result2);
				flag4 = flag4 || !flag3;
			}
			if (!flag3 && raw.FullDHMMatch(raw.NegativeLocalized))
			{
				flag2 = false;
				flag3 = TryTimeToTicks(flag2, raw._numbers0, raw._numbers1, raw._numbers2, timeSpanToken, timeSpanToken, out result2);
				flag4 = flag4 || !flag3;
			}
			if (!flag3 && raw.PartialAppCompatMatch(raw.NegativeLocalized))
			{
				flag2 = false;
				flag3 = TryTimeToTicks(flag2, timeSpanToken, raw._numbers0, raw._numbers1, timeSpanToken, raw._numbers2, out result2);
				flag4 = flag4 || !flag3;
			}
		}
		if (flag3)
		{
			if (!flag2)
			{
				result2 = -result2;
				if (result2 > 0)
				{
					return result.SetFailure(ParseFailureKind.Overflow, "The TimeSpan could not be parsed because at least one of the numeric components is out of range or contains too many digits.");
				}
			}
			result.parsedTimeSpan = new TimeSpan(result2);
			return true;
		}
		if (!flag4)
		{
			return result.SetFailure(ParseFailureKind.Format, "String was not recognized as a valid TimeSpan.");
		}
		return result.SetFailure(ParseFailureKind.Overflow, "The TimeSpan could not be parsed because at least one of the numeric components is out of range or contains too many digits.");
	}

	private static bool ProcessTerminal_HM(ref TimeSpanRawInfo raw, TimeSpanStandardStyles style, ref TimeSpanResult result)
	{
		if (raw._sepCount != 3 || (style & TimeSpanStandardStyles.RequireFull) != TimeSpanStandardStyles.None)
		{
			return result.SetFailure(ParseFailureKind.Format, "String was not recognized as a valid TimeSpan.");
		}
		bool num = (style & TimeSpanStandardStyles.Invariant) != 0;
		bool flag = (style & TimeSpanStandardStyles.Localized) != 0;
		bool flag2 = false;
		bool flag3 = false;
		if (num)
		{
			if (raw.FullHMMatch(raw.PositiveInvariant))
			{
				flag3 = true;
				flag2 = true;
			}
			if (!flag3 && raw.FullHMMatch(raw.NegativeInvariant))
			{
				flag3 = true;
				flag2 = false;
			}
		}
		if (flag)
		{
			if (!flag3 && raw.FullHMMatch(raw.PositiveLocalized))
			{
				flag3 = true;
				flag2 = true;
			}
			if (!flag3 && raw.FullHMMatch(raw.NegativeLocalized))
			{
				flag3 = true;
				flag2 = false;
			}
		}
		if (flag3)
		{
			long result2 = 0L;
			TimeSpanToken timeSpanToken = new TimeSpanToken(0);
			if (!TryTimeToTicks(flag2, timeSpanToken, raw._numbers0, raw._numbers1, timeSpanToken, timeSpanToken, out result2))
			{
				return result.SetFailure(ParseFailureKind.Overflow, "The TimeSpan could not be parsed because at least one of the numeric components is out of range or contains too many digits.");
			}
			if (!flag2)
			{
				result2 = -result2;
				if (result2 > 0)
				{
					return result.SetFailure(ParseFailureKind.Overflow, "The TimeSpan could not be parsed because at least one of the numeric components is out of range or contains too many digits.");
				}
			}
			result.parsedTimeSpan = new TimeSpan(result2);
			return true;
		}
		return result.SetFailure(ParseFailureKind.Format, "String was not recognized as a valid TimeSpan.");
	}

	private static bool ProcessTerminal_D(ref TimeSpanRawInfo raw, TimeSpanStandardStyles style, ref TimeSpanResult result)
	{
		if (raw._sepCount != 2 || (style & TimeSpanStandardStyles.RequireFull) != TimeSpanStandardStyles.None)
		{
			return result.SetFailure(ParseFailureKind.Format, "String was not recognized as a valid TimeSpan.");
		}
		bool num = (style & TimeSpanStandardStyles.Invariant) != 0;
		bool flag = (style & TimeSpanStandardStyles.Localized) != 0;
		bool flag2 = false;
		bool flag3 = false;
		if (num)
		{
			if (raw.FullDMatch(raw.PositiveInvariant))
			{
				flag3 = true;
				flag2 = true;
			}
			if (!flag3 && raw.FullDMatch(raw.NegativeInvariant))
			{
				flag3 = true;
				flag2 = false;
			}
		}
		if (flag)
		{
			if (!flag3 && raw.FullDMatch(raw.PositiveLocalized))
			{
				flag3 = true;
				flag2 = true;
			}
			if (!flag3 && raw.FullDMatch(raw.NegativeLocalized))
			{
				flag3 = true;
				flag2 = false;
			}
		}
		if (flag3)
		{
			long result2 = 0L;
			TimeSpanToken timeSpanToken = new TimeSpanToken(0);
			if (!TryTimeToTicks(flag2, raw._numbers0, timeSpanToken, timeSpanToken, timeSpanToken, timeSpanToken, out result2))
			{
				return result.SetFailure(ParseFailureKind.Overflow, "The TimeSpan could not be parsed because at least one of the numeric components is out of range or contains too many digits.");
			}
			if (!flag2)
			{
				result2 = -result2;
				if (result2 > 0)
				{
					return result.SetFailure(ParseFailureKind.Overflow, "The TimeSpan could not be parsed because at least one of the numeric components is out of range or contains too many digits.");
				}
			}
			result.parsedTimeSpan = new TimeSpan(result2);
			return true;
		}
		return result.SetFailure(ParseFailureKind.Format, "String was not recognized as a valid TimeSpan.");
	}

	private static bool TryParseExactTimeSpan(ReadOnlySpan<char> input, ReadOnlySpan<char> format, IFormatProvider formatProvider, TimeSpanStyles styles, ref TimeSpanResult result)
	{
		if (format.Length == 0)
		{
			return result.SetFailure(ParseFailureKind.Format, "Format specifier was invalid.");
		}
		if (format.Length == 1)
		{
			switch (format[0])
			{
			case 'T':
			case 'c':
			case 't':
				return TryParseTimeSpanConstant(input, ref result);
			case 'g':
				return TryParseTimeSpan(input, TimeSpanStandardStyles.Localized, formatProvider, ref result);
			case 'G':
				return TryParseTimeSpan(input, TimeSpanStandardStyles.Localized | TimeSpanStandardStyles.RequireFull, formatProvider, ref result);
			default:
				return result.SetFailure(ParseFailureKind.Format, "Format specifier was invalid.");
			}
		}
		return TryParseByFormat(input, format, styles, ref result);
	}

	private static bool TryParseByFormat(ReadOnlySpan<char> input, ReadOnlySpan<char> format, TimeSpanStyles styles, ref TimeSpanResult result)
	{
		bool flag = false;
		bool flag2 = false;
		bool flag3 = false;
		bool flag4 = false;
		bool flag5 = false;
		int result2 = 0;
		int result3 = 0;
		int result4 = 0;
		int result5 = 0;
		int zeroes = 0;
		int result6 = 0;
		int i = 0;
		int returnValue = 0;
		TimeSpanTokenizer tokenizer = new TimeSpanTokenizer(input, -1);
		for (; i < format.Length; i += returnValue)
		{
			char c = format[i];
			switch (c)
			{
			case 'h':
				returnValue = DateTimeFormat.ParseRepeatPattern(format, i, c);
				if (((returnValue > 2) | flag2) || !ParseExactDigits(ref tokenizer, returnValue, out result3))
				{
					return result.SetFailure(ParseFailureKind.Format, "Input string was not in a correct format.");
				}
				flag2 = true;
				break;
			case 'm':
				returnValue = DateTimeFormat.ParseRepeatPattern(format, i, c);
				if (((returnValue > 2) | flag3) || !ParseExactDigits(ref tokenizer, returnValue, out result4))
				{
					return result.SetFailure(ParseFailureKind.Format, "Input string was not in a correct format.");
				}
				flag3 = true;
				break;
			case 's':
				returnValue = DateTimeFormat.ParseRepeatPattern(format, i, c);
				if (((returnValue > 2) | flag4) || !ParseExactDigits(ref tokenizer, returnValue, out result5))
				{
					return result.SetFailure(ParseFailureKind.Format, "Input string was not in a correct format.");
				}
				flag4 = true;
				break;
			case 'f':
				returnValue = DateTimeFormat.ParseRepeatPattern(format, i, c);
				if (((returnValue > 7) | flag5) || !ParseExactDigits(ref tokenizer, returnValue, returnValue, out zeroes, out result6))
				{
					return result.SetFailure(ParseFailureKind.Format, "Input string was not in a correct format.");
				}
				flag5 = true;
				break;
			case 'F':
				returnValue = DateTimeFormat.ParseRepeatPattern(format, i, c);
				if ((returnValue > 7) | flag5)
				{
					return result.SetFailure(ParseFailureKind.Format, "Input string was not in a correct format.");
				}
				ParseExactDigits(ref tokenizer, returnValue, returnValue, out zeroes, out result6);
				flag5 = true;
				break;
			case 'd':
			{
				returnValue = DateTimeFormat.ParseRepeatPattern(format, i, c);
				int zeroes2 = 0;
				if (((returnValue > 8) | flag) || !ParseExactDigits(ref tokenizer, (returnValue < 2) ? 1 : returnValue, (returnValue < 2) ? 8 : returnValue, out zeroes2, out result2))
				{
					return result.SetFailure(ParseFailureKind.Format, "Input string was not in a correct format.");
				}
				flag = true;
				break;
			}
			case '"':
			case '\'':
			{
				StringBuilder stringBuilder = StringBuilderCache.Acquire();
				if (!DateTimeParse.TryParseQuoteString(format, i, stringBuilder, out returnValue))
				{
					StringBuilderCache.Release(stringBuilder);
					return result.SetFailure(ParseFailureKind.FormatWithParameter, "Cannot find a matching quote character for the character '{0}'.", c);
				}
				if (!ParseExactLiteral(ref tokenizer, stringBuilder))
				{
					StringBuilderCache.Release(stringBuilder);
					return result.SetFailure(ParseFailureKind.Format, "Input string was not in a correct format.");
				}
				StringBuilderCache.Release(stringBuilder);
				break;
			}
			case '%':
			{
				int num = DateTimeFormat.ParseNextChar(format, i);
				if (num >= 0 && num != 37)
				{
					returnValue = 1;
					break;
				}
				return result.SetFailure(ParseFailureKind.Format, "Input string was not in a correct format.");
			}
			case '\\':
			{
				int num = DateTimeFormat.ParseNextChar(format, i);
				if (num >= 0 && tokenizer.NextChar == (ushort)num)
				{
					returnValue = 2;
					break;
				}
				return result.SetFailure(ParseFailureKind.Format, "Input string was not in a correct format.");
			}
			default:
				return result.SetFailure(ParseFailureKind.Format, "Input string was not in a correct format.");
			}
		}
		if (!tokenizer.EOL)
		{
			return result.SetFailure(ParseFailureKind.Format, "String was not recognized as a valid TimeSpan.");
		}
		bool flag6 = (styles & TimeSpanStyles.AssumeNegative) == 0;
		if (TryTimeToTicks(flag6, new TimeSpanToken(result2), new TimeSpanToken(result3), new TimeSpanToken(result4), new TimeSpanToken(result5), new TimeSpanToken(result6, zeroes), out var result7))
		{
			if (!flag6)
			{
				result7 = -result7;
			}
			result.parsedTimeSpan = new TimeSpan(result7);
			return true;
		}
		return result.SetFailure(ParseFailureKind.Overflow, "The TimeSpan could not be parsed because at least one of the numeric components is out of range or contains too many digits.");
	}

	private static bool ParseExactDigits(ref TimeSpanTokenizer tokenizer, int minDigitLength, out int result)
	{
		result = 0;
		int zeroes = 0;
		int maxDigitLength = ((minDigitLength == 1) ? 2 : minDigitLength);
		return ParseExactDigits(ref tokenizer, minDigitLength, maxDigitLength, out zeroes, out result);
	}

	private static bool ParseExactDigits(ref TimeSpanTokenizer tokenizer, int minDigitLength, int maxDigitLength, out int zeroes, out int result)
	{
		int num = 0;
		int num2 = 0;
		int i;
		for (i = 0; i < maxDigitLength; i++)
		{
			char nextChar = tokenizer.NextChar;
			if (nextChar < '0' || nextChar > '9')
			{
				tokenizer.BackOne();
				break;
			}
			num = num * 10 + (nextChar - 48);
			if (num == 0)
			{
				num2++;
			}
		}
		zeroes = num2;
		result = num;
		return i >= minDigitLength;
	}

	private static bool ParseExactLiteral(ref TimeSpanTokenizer tokenizer, StringBuilder enquotedString)
	{
		for (int i = 0; i < enquotedString.Length; i++)
		{
			if (enquotedString[i] != tokenizer.NextChar)
			{
				return false;
			}
		}
		return true;
	}

	private static bool TryParseTimeSpanConstant(ReadOnlySpan<char> input, ref TimeSpanResult result)
	{
		return default(StringParser).TryParse(input, ref result);
	}

	private static bool TryParseExactMultipleTimeSpan(ReadOnlySpan<char> input, string[] formats, IFormatProvider formatProvider, TimeSpanStyles styles, ref TimeSpanResult result)
	{
		if (formats == null)
		{
			return result.SetFailure(ParseFailureKind.ArgumentNull, "String reference not set to an instance of a String.", null, "formats");
		}
		if (input.Length == 0)
		{
			return result.SetFailure(ParseFailureKind.Format, "String was not recognized as a valid TimeSpan.");
		}
		if (formats.Length == 0)
		{
			return result.SetFailure(ParseFailureKind.Format, "Format specifier was invalid.");
		}
		for (int i = 0; i < formats.Length; i++)
		{
			if (formats[i] == null || formats[i].Length == 0)
			{
				return result.SetFailure(ParseFailureKind.Format, "Format specifier was invalid.");
			}
			TimeSpanResult result2 = new TimeSpanResult(throwOnFailure: false);
			if (TryParseExactTimeSpan(input, formats[i], formatProvider, styles, ref result2))
			{
				result.parsedTimeSpan = result2.parsedTimeSpan;
				return true;
			}
		}
		return result.SetFailure(ParseFailureKind.Format, "String was not recognized as a valid TimeSpan.");
	}
}
