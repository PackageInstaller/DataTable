using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.Runtime.CompilerServices;

namespace System.Text.RegularExpressions;

internal sealed class RegexParser
{
	private RegexNode _stack;

	private RegexNode _group;

	private RegexNode _alternation;

	private RegexNode _concatenation;

	private RegexNode _unit;

	private string _pattern;

	private int _currentPos;

	private CultureInfo _culture;

	private int _autocap;

	private int _capcount;

	private int _captop;

	private int _capsize;

	private Hashtable _caps;

	private Hashtable _capnames;

	private int[] _capnumlist;

	private List<string> _capnamelist;

	private RegexOptions _options;

	private List<RegexOptions> _optionsStack;

	private bool _ignoreNextParen;

	private static readonly byte[] s_category;

	public static RegexTree Parse(string re, RegexOptions op)
	{
		RegexParser regexParser = new RegexParser(((op & RegexOptions.CultureInvariant) != RegexOptions.None) ? CultureInfo.InvariantCulture : CultureInfo.CurrentCulture);
		regexParser._options = op;
		regexParser.SetPattern(re);
		regexParser.CountCaptures();
		regexParser.Reset(op);
		return new RegexTree(regexParser.ScanRegex(), capsList: (regexParser._capnamelist != null) ? regexParser._capnamelist.ToArray() : null, caps: regexParser._caps, capNumList: regexParser._capnumlist, capTop: regexParser._captop, capNames: regexParser._capnames, options: op);
	}

	public static RegexReplacement ParseReplacement(string rep, Hashtable caps, int capsize, Hashtable capnames, RegexOptions op)
	{
		RegexParser regexParser = new RegexParser(((op & RegexOptions.CultureInvariant) != RegexOptions.None) ? CultureInfo.InvariantCulture : CultureInfo.CurrentCulture);
		regexParser._options = op;
		regexParser.NoteCaptures(caps, capsize, capnames);
		regexParser.SetPattern(rep);
		RegexNode concat = regexParser.ScanReplacement();
		return new RegexReplacement(rep, concat, caps);
	}

	public static string Escape(string input)
	{
		for (int i = 0; i < input.Length; i++)
		{
			if (!IsMetachar(input[i]))
			{
				continue;
			}
			StringBuilder stringBuilder = StringBuilderCache.Acquire();
			char c = input[i];
			stringBuilder.Append(input, 0, i);
			do
			{
				stringBuilder.Append('\\');
				switch (c)
				{
				case '\n':
					c = 'n';
					break;
				case '\r':
					c = 'r';
					break;
				case '\t':
					c = 't';
					break;
				case '\f':
					c = 'f';
					break;
				}
				stringBuilder.Append(c);
				i++;
				int num = i;
				for (; i < input.Length; i++)
				{
					c = input[i];
					if (IsMetachar(c))
					{
						break;
					}
				}
				stringBuilder.Append(input, num, i - num);
			}
			while (i < input.Length);
			return StringBuilderCache.GetStringAndRelease(stringBuilder);
		}
		return input;
	}

	public static string Unescape(string input)
	{
		for (int i = 0; i < input.Length; i++)
		{
			if (input[i] != '\\')
			{
				continue;
			}
			StringBuilder stringBuilder = StringBuilderCache.Acquire();
			RegexParser regexParser = new RegexParser(CultureInfo.InvariantCulture);
			regexParser.SetPattern(input);
			stringBuilder.Append(input, 0, i);
			do
			{
				i++;
				regexParser.Textto(i);
				if (i < input.Length)
				{
					stringBuilder.Append(regexParser.ScanCharEscape());
				}
				i = regexParser.Textpos();
				int num = i;
				for (; i < input.Length && input[i] != '\\'; i++)
				{
				}
				stringBuilder.Append(input, num, i - num);
			}
			while (i < input.Length);
			return StringBuilderCache.GetStringAndRelease(stringBuilder);
		}
		return input;
	}

	private RegexParser(CultureInfo culture)
	{
		_culture = culture;
		_optionsStack = new List<RegexOptions>();
		_caps = new Hashtable();
	}

	private void SetPattern(string Re)
	{
		if (Re == null)
		{
			Re = string.Empty;
		}
		_pattern = Re;
		_currentPos = 0;
	}

	private void Reset(RegexOptions topopts)
	{
		_currentPos = 0;
		_autocap = 1;
		_ignoreNextParen = false;
		if (_optionsStack.Count > 0)
		{
			_optionsStack.RemoveRange(0, _optionsStack.Count - 1);
		}
		_options = topopts;
		_stack = null;
	}

	private RegexNode ScanRegex()
	{
		char c = '@';
		bool flag = false;
		StartGroup(new RegexNode(28, _options, 0, -1));
		while (CharsRight() > 0)
		{
			bool flag2 = flag;
			flag = false;
			ScanBlank();
			int num = Textpos();
			if (UseOptionX())
			{
				while (CharsRight() > 0 && (!IsStopperX(c = RightChar()) || (c == '{' && !IsTrueQuantifier())))
				{
					MoveRight();
				}
			}
			else
			{
				while (CharsRight() > 0 && (!IsSpecial(c = RightChar()) || (c == '{' && !IsTrueQuantifier())))
				{
					MoveRight();
				}
			}
			int num2 = Textpos();
			ScanBlank();
			if (CharsRight() == 0)
			{
				c = '!';
			}
			else if (IsSpecial(c = RightChar()))
			{
				flag = IsQuantifier(c);
				MoveRight();
			}
			else
			{
				c = ' ';
			}
			if (num < num2)
			{
				int num3 = num2 - num - (flag ? 1 : 0);
				flag2 = false;
				if (num3 > 0)
				{
					AddConcatenate(num, num3, isReplacement: false);
				}
				if (flag)
				{
					AddUnitOne(CharAt(num2 - 1));
				}
			}
			switch (c)
			{
			case '[':
				AddUnitSet(ScanCharClass(UseOptionI(), scanOnly: false).ToStringClass());
				goto IL_02af;
			case '(':
			{
				PushOptions();
				RegexNode openGroup;
				if ((openGroup = ScanGroupOpen()) == null)
				{
					PopKeepOptions();
					continue;
				}
				PushGroup();
				StartGroup(openGroup);
				continue;
			}
			case '|':
				AddAlternate();
				continue;
			case ')':
				if (EmptyStack())
				{
					throw MakeException("Too many )'s.");
				}
				AddGroup();
				PopGroup();
				PopOptions();
				if (Unit() == null)
				{
					continue;
				}
				goto IL_02af;
			case '\\':
				AddUnitNode(ScanBackslash(scanOnly: false));
				goto IL_02af;
			case '^':
				AddUnitType(UseOptionM() ? 14 : 18);
				goto IL_02af;
			case '$':
				AddUnitType(UseOptionM() ? 15 : 20);
				goto IL_02af;
			case '.':
				if (UseOptionS())
				{
					AddUnitSet("\0\u0001\0\0");
				}
				else
				{
					AddUnitNotone('\n');
				}
				goto IL_02af;
			case '*':
			case '+':
			case '?':
			case '{':
				if (Unit() == null)
				{
					throw MakeException(flag2 ? global::SR.Format("Nested quantifier {0}.", c.ToString()) : "Quantifier {x,y} following nothing.");
				}
				MoveLeft();
				goto IL_02af;
			default:
				throw MakeException("Internal error in ScanRegex.");
			case ' ':
				continue;
			case '!':
				break;
				IL_02af:
				ScanBlank();
				if (CharsRight() == 0 || !(flag = IsTrueQuantifier()))
				{
					AddConcatenate();
					continue;
				}
				c = RightCharMoveRight();
				while (Unit() != null)
				{
					int num4;
					int num5;
					if ((uint)c <= 43u)
					{
						if (c != '*')
						{
							if (c != '+')
							{
								goto IL_03ad;
							}
							num4 = 1;
							num5 = int.MaxValue;
						}
						else
						{
							num4 = 0;
							num5 = int.MaxValue;
						}
					}
					else if (c != '?')
					{
						if (c != '{')
						{
							goto IL_03ad;
						}
						num = Textpos();
						num5 = (num4 = ScanDecimal());
						if (num < Textpos() && CharsRight() > 0 && RightChar() == ',')
						{
							MoveRight();
							num5 = ((CharsRight() != 0 && RightChar() != '}') ? ScanDecimal() : int.MaxValue);
						}
						if (num == Textpos() || CharsRight() == 0 || RightCharMoveRight() != '}')
						{
							AddConcatenate();
							Textto(num - 1);
							break;
						}
					}
					else
					{
						num4 = 0;
						num5 = 1;
					}
					ScanBlank();
					bool lazy;
					if (CharsRight() == 0 || RightChar() != '?')
					{
						lazy = false;
					}
					else
					{
						MoveRight();
						lazy = true;
					}
					if (num4 > num5)
					{
						throw MakeException("Illegal {x,y} with x > y.");
					}
					AddConcatenate(lazy, num4, num5);
					continue;
					IL_03ad:
					throw MakeException("Internal error in ScanRegex.");
				}
				continue;
			}
			break;
		}
		if (!EmptyStack())
		{
			throw MakeException("Not enough )'s.");
		}
		AddGroup();
		return Unit();
	}

	private RegexNode ScanReplacement()
	{
		_concatenation = new RegexNode(25, _options);
		while (true)
		{
			int num = CharsRight();
			if (num == 0)
			{
				break;
			}
			int num2 = Textpos();
			while (num > 0 && RightChar() != '$')
			{
				MoveRight();
				num--;
			}
			AddConcatenate(num2, Textpos() - num2, isReplacement: true);
			if (num > 0)
			{
				if (RightCharMoveRight() == '$')
				{
					AddUnitNode(ScanDollar());
				}
				AddConcatenate();
			}
		}
		return _concatenation;
	}

	private RegexCharClass ScanCharClass(bool caseInsensitive, bool scanOnly)
	{
		char c = '\0';
		char c2 = '\0';
		bool flag = false;
		bool flag2 = true;
		bool flag3 = false;
		RegexCharClass regexCharClass = (scanOnly ? null : new RegexCharClass());
		if (CharsRight() > 0 && RightChar() == '^')
		{
			MoveRight();
			if (!scanOnly)
			{
				regexCharClass.Negate = true;
			}
		}
		for (; CharsRight() > 0; flag2 = false)
		{
			bool flag4 = false;
			c = RightCharMoveRight();
			if (c == ']')
			{
				if (!flag2)
				{
					flag3 = true;
					break;
				}
			}
			else if (c == '\\' && CharsRight() > 0)
			{
				switch (c = RightCharMoveRight())
				{
				case 'D':
				case 'd':
					if (!scanOnly)
					{
						if (flag)
						{
							throw MakeException(global::SR.Format("Cannot include class \\{0} in character range.", c.ToString()));
						}
						regexCharClass.AddDigit(UseOptionE(), c == 'D', _pattern);
					}
					continue;
				case 'S':
				case 's':
					if (!scanOnly)
					{
						if (flag)
						{
							throw MakeException(global::SR.Format("Cannot include class \\{0} in character range.", c.ToString()));
						}
						regexCharClass.AddSpace(UseOptionE(), c == 'S');
					}
					continue;
				case 'W':
				case 'w':
					if (!scanOnly)
					{
						if (flag)
						{
							throw MakeException(global::SR.Format("Cannot include class \\{0} in character range.", c.ToString()));
						}
						regexCharClass.AddWord(UseOptionE(), c == 'W');
					}
					continue;
				case 'P':
				case 'p':
					if (!scanOnly)
					{
						if (flag)
						{
							throw MakeException(global::SR.Format("Cannot include class \\{0} in character range.", c.ToString()));
						}
						regexCharClass.AddCategoryFromName(ParseProperty(), c != 'p', caseInsensitive, _pattern);
					}
					else
					{
						ParseProperty();
					}
					continue;
				case '-':
					if (!scanOnly)
					{
						regexCharClass.AddRange(c, c);
					}
					continue;
				}
				MoveLeft();
				c = ScanCharEscape();
				flag4 = true;
			}
			else if (c == '[' && CharsRight() > 0 && RightChar() == ':' && !flag)
			{
				int pos = Textpos();
				MoveRight();
				ScanCapname();
				if (CharsRight() < 2 || RightCharMoveRight() != ':' || RightCharMoveRight() != ']')
				{
					Textto(pos);
				}
			}
			if (flag)
			{
				flag = false;
				if (scanOnly)
				{
					continue;
				}
				if (c == '[' && !flag4 && !flag2)
				{
					regexCharClass.AddChar(c2);
					regexCharClass.AddSubtraction(ScanCharClass(caseInsensitive, scanOnly));
					if (CharsRight() > 0 && RightChar() != ']')
					{
						throw MakeException("A subtraction must be the last element in a character class.");
					}
				}
				else
				{
					if (c2 > c)
					{
						throw MakeException("[x-y] range in reverse order.");
					}
					regexCharClass.AddRange(c2, c);
				}
			}
			else if (CharsRight() >= 2 && RightChar() == '-' && RightChar(1) != ']')
			{
				c2 = c;
				flag = true;
				MoveRight();
			}
			else if (CharsRight() >= 1 && c == '-' && !flag4 && RightChar() == '[' && !flag2)
			{
				if (!scanOnly)
				{
					MoveRight(1);
					regexCharClass.AddSubtraction(ScanCharClass(caseInsensitive, scanOnly));
					if (CharsRight() > 0 && RightChar() != ']')
					{
						throw MakeException("A subtraction must be the last element in a character class.");
					}
				}
				else
				{
					MoveRight(1);
					ScanCharClass(caseInsensitive, scanOnly);
				}
			}
			else if (!scanOnly)
			{
				regexCharClass.AddRange(c, c);
			}
		}
		if (!flag3)
		{
			throw MakeException("Unterminated [] set.");
		}
		if (!scanOnly & caseInsensitive)
		{
			regexCharClass.AddLowercase(_culture);
		}
		return regexCharClass;
	}

	private RegexNode ScanGroupOpen()
	{
		char c = '\0';
		char c2 = '>';
		if (CharsRight() == 0 || RightChar() != '?' || (RightChar() == '?' && CharsRight() > 1 && RightChar(1) == ')'))
		{
			if (UseOptionN() || _ignoreNextParen)
			{
				_ignoreNextParen = false;
				return new RegexNode(29, _options);
			}
			return new RegexNode(28, _options, _autocap++, -1);
		}
		MoveRight();
		if (CharsRight() != 0)
		{
			int type;
			switch (c = RightCharMoveRight())
			{
			case ':':
				type = 29;
				goto IL_04fa;
			case '=':
				_options &= ~RegexOptions.RightToLeft;
				type = 30;
				goto IL_04fa;
			case '!':
				_options &= ~RegexOptions.RightToLeft;
				type = 31;
				goto IL_04fa;
			case '>':
				type = 32;
				goto IL_04fa;
			case '\'':
				c2 = '\'';
				goto case '<';
			case '<':
			{
				if (CharsRight() == 0)
				{
					break;
				}
				char c3 = (c = RightCharMoveRight());
				if (c3 != '!')
				{
					if (c3 != '=')
					{
						MoveLeft();
						int num = -1;
						int num2 = -1;
						bool flag = false;
						if (c >= '0' && c <= '9')
						{
							num = ScanDecimal();
							if (!IsCaptureSlot(num))
							{
								num = -1;
							}
							if (CharsRight() > 0 && RightChar() != c2 && RightChar() != '-')
							{
								throw MakeException("Invalid group name: Group names must begin with a word character.");
							}
							if (num == 0)
							{
								throw MakeException("Capture number cannot be zero.");
							}
						}
						else if (RegexCharClass.IsWordChar(c))
						{
							string capname = ScanCapname();
							if (IsCaptureName(capname))
							{
								num = CaptureSlotFromName(capname);
							}
							if (CharsRight() > 0 && RightChar() != c2 && RightChar() != '-')
							{
								throw MakeException("Invalid group name: Group names must begin with a word character.");
							}
						}
						else
						{
							if (c != '-')
							{
								throw MakeException("Invalid group name: Group names must begin with a word character.");
							}
							flag = true;
						}
						if ((num != -1 || flag) && CharsRight() > 1 && RightChar() == '-')
						{
							MoveRight();
							c = RightChar();
							if (c >= '0' && c <= '9')
							{
								num2 = ScanDecimal();
								if (!IsCaptureSlot(num2))
								{
									throw MakeException(global::SR.Format("Reference to undefined group number {0}.", num2));
								}
								if (CharsRight() > 0 && RightChar() != c2)
								{
									throw MakeException("Invalid group name: Group names must begin with a word character.");
								}
							}
							else
							{
								if (!RegexCharClass.IsWordChar(c))
								{
									throw MakeException("Invalid group name: Group names must begin with a word character.");
								}
								string text = ScanCapname();
								if (!IsCaptureName(text))
								{
									throw MakeException(global::SR.Format("Reference to undefined group name {0}.", text));
								}
								num2 = CaptureSlotFromName(text);
								if (CharsRight() > 0 && RightChar() != c2)
								{
									throw MakeException("Invalid group name: Group names must begin with a word character.");
								}
							}
						}
						if ((num != -1 || num2 != -1) && CharsRight() > 0 && RightCharMoveRight() == c2)
						{
							return new RegexNode(28, _options, num, num2);
						}
						break;
					}
					if (c2 == '\'')
					{
						break;
					}
					_options |= RegexOptions.RightToLeft;
					type = 30;
				}
				else
				{
					if (c2 == '\'')
					{
						break;
					}
					_options |= RegexOptions.RightToLeft;
					type = 31;
				}
				goto IL_04fa;
			}
			case '(':
			{
				int num3 = Textpos();
				if (CharsRight() > 0)
				{
					c = RightChar();
					if (c >= '0' && c <= '9')
					{
						int num4 = ScanDecimal();
						if (CharsRight() > 0 && RightCharMoveRight() == ')')
						{
							if (IsCaptureSlot(num4))
							{
								return new RegexNode(33, _options, num4);
							}
							throw MakeException(global::SR.Format("(?({0}) ) reference to undefined group.", num4.ToString(CultureInfo.CurrentCulture)));
						}
						throw MakeException(global::SR.Format("(?({0}) ) malformed.", num4.ToString(CultureInfo.CurrentCulture)));
					}
					if (RegexCharClass.IsWordChar(c))
					{
						string capname2 = ScanCapname();
						if (IsCaptureName(capname2) && CharsRight() > 0 && RightCharMoveRight() == ')')
						{
							return new RegexNode(33, _options, CaptureSlotFromName(capname2));
						}
					}
				}
				type = 34;
				Textto(num3 - 1);
				_ignoreNextParen = true;
				int num5 = CharsRight();
				if (num5 >= 3 && RightChar(1) == '?')
				{
					char c4 = RightChar(2);
					switch (c4)
					{
					case '#':
						throw MakeException("Alternation conditions cannot be comments.");
					case '\'':
						throw MakeException("Alternation conditions do not capture and cannot be named.");
					}
					if (num5 >= 4 && c4 == '<' && RightChar(3) != '!' && RightChar(3) != '=')
					{
						throw MakeException("Alternation conditions do not capture and cannot be named.");
					}
				}
				goto IL_04fa;
			}
			default:
				{
					MoveLeft();
					type = 29;
					if (_group.NType != 34)
					{
						ScanOptions();
					}
					if (CharsRight() == 0)
					{
						break;
					}
					if ((c = RightCharMoveRight()) == ')')
					{
						return null;
					}
					if (c != ':')
					{
						break;
					}
					goto IL_04fa;
				}
				IL_04fa:
				return new RegexNode(type, _options);
			}
		}
		throw MakeException("Unrecognized grouping construct.");
	}

	private void ScanBlank()
	{
		if (UseOptionX())
		{
			while (true)
			{
				if (CharsRight() > 0 && IsSpace(RightChar()))
				{
					MoveRight();
					continue;
				}
				if (CharsRight() == 0)
				{
					break;
				}
				if (RightChar() == '#')
				{
					while (CharsRight() > 0 && RightChar() != '\n')
					{
						MoveRight();
					}
					continue;
				}
				if (CharsRight() >= 3 && RightChar(2) == '#' && RightChar(1) == '?' && RightChar() == '(')
				{
					while (CharsRight() > 0 && RightChar() != ')')
					{
						MoveRight();
					}
					if (CharsRight() == 0)
					{
						throw MakeException("Unterminated (?#...) comment.");
					}
					MoveRight();
					continue;
				}
				break;
			}
			return;
		}
		while (true)
		{
			if (CharsRight() < 3 || RightChar(2) != '#' || RightChar(1) != '?' || RightChar() != '(')
			{
				return;
			}
			while (CharsRight() > 0 && RightChar() != ')')
			{
				MoveRight();
			}
			if (CharsRight() == 0)
			{
				break;
			}
			MoveRight();
		}
		throw MakeException("Unterminated (?#...) comment.");
	}

	private RegexNode ScanBackslash(bool scanOnly)
	{
		if (CharsRight() == 0)
		{
			throw MakeException("Illegal \\ at end of pattern.");
		}
		char c;
		switch (c = RightChar())
		{
		case 'A':
		case 'B':
		case 'G':
		case 'Z':
		case 'b':
		case 'z':
			MoveRight();
			if (scanOnly)
			{
				return null;
			}
			return new RegexNode(TypeFromCode(c), _options);
		case 'w':
			MoveRight();
			if (scanOnly)
			{
				return null;
			}
			if (UseOptionE())
			{
				return new RegexNode(11, _options, "\0\n\00:A[_`a{İı");
			}
			return new RegexNode(11, _options, RegexCharClass.WordClass);
		case 'W':
			MoveRight();
			if (scanOnly)
			{
				return null;
			}
			if (UseOptionE())
			{
				return new RegexNode(11, _options, "\u0001\n\00:A[_`a{İı");
			}
			return new RegexNode(11, _options, RegexCharClass.NotWordClass);
		case 's':
			MoveRight();
			if (scanOnly)
			{
				return null;
			}
			if (UseOptionE())
			{
				return new RegexNode(11, _options, "\0\u0004\0\t\u000e !");
			}
			return new RegexNode(11, _options, RegexCharClass.SpaceClass);
		case 'S':
			MoveRight();
			if (scanOnly)
			{
				return null;
			}
			if (UseOptionE())
			{
				return new RegexNode(11, _options, "\u0001\u0004\0\t\u000e !");
			}
			return new RegexNode(11, _options, RegexCharClass.NotSpaceClass);
		case 'd':
			MoveRight();
			if (scanOnly)
			{
				return null;
			}
			if (UseOptionE())
			{
				return new RegexNode(11, _options, "\0\u0002\00:");
			}
			return new RegexNode(11, _options, RegexCharClass.DigitClass);
		case 'D':
			MoveRight();
			if (scanOnly)
			{
				return null;
			}
			if (UseOptionE())
			{
				return new RegexNode(11, _options, "\u0001\u0002\00:");
			}
			return new RegexNode(11, _options, RegexCharClass.NotDigitClass);
		case 'P':
		case 'p':
		{
			MoveRight();
			if (scanOnly)
			{
				return null;
			}
			RegexCharClass regexCharClass = new RegexCharClass();
			regexCharClass.AddCategoryFromName(ParseProperty(), c != 'p', UseOptionI(), _pattern);
			if (UseOptionI())
			{
				regexCharClass.AddLowercase(_culture);
			}
			return new RegexNode(11, _options, regexCharClass.ToStringClass());
		}
		default:
			return ScanBasicBackslash(scanOnly);
		}
	}

	private RegexNode ScanBasicBackslash(bool scanOnly)
	{
		if (CharsRight() == 0)
		{
			throw MakeException("Illegal \\ at end of pattern.");
		}
		bool flag = false;
		char c = '\0';
		int pos = Textpos();
		char c2 = RightChar();
		switch (c2)
		{
		case 'k':
			if (CharsRight() >= 2)
			{
				MoveRight();
				c2 = RightCharMoveRight();
				if (c2 == '<' || c2 == '\'')
				{
					flag = true;
					c = ((c2 == '\'') ? '\'' : '>');
				}
			}
			if (!flag || CharsRight() <= 0)
			{
				throw MakeException("Malformed \\k<...> named back reference.");
			}
			c2 = RightChar();
			break;
		case '\'':
		case '<':
			if (CharsRight() > 1)
			{
				flag = true;
				c = ((c2 == '\'') ? '\'' : '>');
				MoveRight();
				c2 = RightChar();
			}
			break;
		}
		if (flag && c2 >= '0' && c2 <= '9')
		{
			int num = ScanDecimal();
			if (CharsRight() > 0 && RightCharMoveRight() == c)
			{
				if (scanOnly)
				{
					return null;
				}
				if (IsCaptureSlot(num))
				{
					return new RegexNode(13, _options, num);
				}
				throw MakeException(global::SR.Format("Reference to undefined group number {0}.", num.ToString(CultureInfo.CurrentCulture)));
			}
		}
		else if (!flag && c2 >= '1' && c2 <= '9')
		{
			if (UseOptionE())
			{
				int num2 = -1;
				int num3 = c2 - 48;
				int num4 = Textpos() - 1;
				while (num3 <= _captop)
				{
					if (IsCaptureSlot(num3) && (_caps == null || (int)_caps[num3] < num4))
					{
						num2 = num3;
					}
					MoveRight();
					if (CharsRight() == 0 || (c2 = RightChar()) < '0' || c2 > '9')
					{
						break;
					}
					num3 = num3 * 10 + (c2 - 48);
				}
				if (num2 >= 0)
				{
					if (!scanOnly)
					{
						return new RegexNode(13, _options, num2);
					}
					return null;
				}
			}
			else
			{
				int num5 = ScanDecimal();
				if (scanOnly)
				{
					return null;
				}
				if (IsCaptureSlot(num5))
				{
					return new RegexNode(13, _options, num5);
				}
				if (num5 <= 9)
				{
					throw MakeException(global::SR.Format("Reference to undefined group number {0}.", num5.ToString(CultureInfo.CurrentCulture)));
				}
			}
		}
		else if (flag && RegexCharClass.IsWordChar(c2))
		{
			string text = ScanCapname();
			if (CharsRight() > 0 && RightCharMoveRight() == c)
			{
				if (scanOnly)
				{
					return null;
				}
				if (IsCaptureName(text))
				{
					return new RegexNode(13, _options, CaptureSlotFromName(text));
				}
				throw MakeException(global::SR.Format("Reference to undefined group name {0}.", text));
			}
		}
		Textto(pos);
		c2 = ScanCharEscape();
		if (UseOptionI())
		{
			c2 = _culture.TextInfo.ToLower(c2);
		}
		if (!scanOnly)
		{
			return new RegexNode(9, _options, c2);
		}
		return null;
	}

	private RegexNode ScanDollar()
	{
		if (CharsRight() == 0)
		{
			return new RegexNode(9, _options, '$');
		}
		char c = RightChar();
		int num = Textpos();
		int pos = num;
		bool flag;
		if (c == '{' && CharsRight() > 1)
		{
			flag = true;
			MoveRight();
			c = RightChar();
		}
		else
		{
			flag = false;
		}
		if (c >= '0' && c <= '9')
		{
			if (!flag && UseOptionE())
			{
				int num2 = -1;
				int num3 = c - 48;
				MoveRight();
				if (IsCaptureSlot(num3))
				{
					num2 = num3;
					pos = Textpos();
				}
				while (CharsRight() > 0 && (c = RightChar()) >= '0' && c <= '9')
				{
					int num4 = c - 48;
					if (num3 > 214748364 || (num3 == 214748364 && num4 > 7))
					{
						throw MakeException("Capture group numbers must be less than or equal to Int32.MaxValue.");
					}
					num3 = num3 * 10 + num4;
					MoveRight();
					if (IsCaptureSlot(num3))
					{
						num2 = num3;
						pos = Textpos();
					}
				}
				Textto(pos);
				if (num2 >= 0)
				{
					return new RegexNode(13, _options, num2);
				}
			}
			else
			{
				int num5 = ScanDecimal();
				if ((!flag || (CharsRight() > 0 && RightCharMoveRight() == '}')) && IsCaptureSlot(num5))
				{
					return new RegexNode(13, _options, num5);
				}
			}
		}
		else if (flag && RegexCharClass.IsWordChar(c))
		{
			string capname = ScanCapname();
			if (CharsRight() > 0 && RightCharMoveRight() == '}' && IsCaptureName(capname))
			{
				return new RegexNode(13, _options, CaptureSlotFromName(capname));
			}
		}
		else if (!flag)
		{
			int num6 = 1;
			switch (c)
			{
			case '$':
				MoveRight();
				return new RegexNode(9, _options, '$');
			case '&':
				num6 = 0;
				break;
			case '`':
				num6 = -1;
				break;
			case '\'':
				num6 = -2;
				break;
			case '+':
				num6 = -3;
				break;
			case '_':
				num6 = -4;
				break;
			}
			if (num6 != 1)
			{
				MoveRight();
				return new RegexNode(13, _options, num6);
			}
		}
		Textto(num);
		return new RegexNode(9, _options, '$');
	}

	private string ScanCapname()
	{
		int num = Textpos();
		while (CharsRight() > 0)
		{
			if (!RegexCharClass.IsWordChar(RightCharMoveRight()))
			{
				MoveLeft();
				break;
			}
		}
		return _pattern.Substring(num, Textpos() - num);
	}

	private char ScanOctal()
	{
		int num = 3;
		if (num > CharsRight())
		{
			num = CharsRight();
		}
		int num2 = 0;
		int num3;
		while (num > 0 && (uint)(num3 = RightChar() - 48) <= 7u)
		{
			MoveRight();
			num2 *= 8;
			num2 += num3;
			if (UseOptionE() && num2 >= 32)
			{
				break;
			}
			num--;
		}
		num2 &= 0xFF;
		return (char)num2;
	}

	private int ScanDecimal()
	{
		int num = 0;
		int num2;
		while (CharsRight() > 0 && (uint)(num2 = (ushort)(RightChar() - 48)) <= 9u)
		{
			MoveRight();
			if (num > 214748364 || (num == 214748364 && num2 > 7))
			{
				throw MakeException("Capture group numbers must be less than or equal to Int32.MaxValue.");
			}
			num *= 10;
			num += num2;
		}
		return num;
	}

	private char ScanHex(int c)
	{
		int num = 0;
		if (CharsRight() >= c)
		{
			int num2;
			while (c > 0 && (num2 = HexDigit(RightCharMoveRight())) >= 0)
			{
				num *= 16;
				num += num2;
				c--;
			}
		}
		if (c > 0)
		{
			throw MakeException("Insufficient hexadecimal digits.");
		}
		return (char)num;
	}

	private static int HexDigit(char ch)
	{
		int result;
		if ((uint)(result = ch - 48) <= 9u)
		{
			return result;
		}
		if ((uint)(result = ch - 97) <= 5u)
		{
			return result + 10;
		}
		if ((uint)(result = ch - 65) <= 5u)
		{
			return result + 10;
		}
		return -1;
	}

	private char ScanControl()
	{
		if (CharsRight() <= 0)
		{
			throw MakeException("Missing control character.");
		}
		char c = RightCharMoveRight();
		if (c >= 'a' && c <= 'z')
		{
			c = (char)(c - 32);
		}
		if ((c = (char)(c - 64)) < ' ')
		{
			return c;
		}
		throw MakeException("Unrecognized control character.");
	}

	private bool IsOnlyTopOption(RegexOptions option)
	{
		if (option != RegexOptions.RightToLeft && option != RegexOptions.CultureInvariant)
		{
			return option == RegexOptions.ECMAScript;
		}
		return true;
	}

	private void ScanOptions()
	{
		bool flag = false;
		while (CharsRight() > 0)
		{
			char c = RightChar();
			switch (c)
			{
			case '-':
				flag = true;
				break;
			case '+':
				flag = false;
				break;
			default:
			{
				RegexOptions regexOptions = OptionFromCode(c);
				if (regexOptions == RegexOptions.None || IsOnlyTopOption(regexOptions))
				{
					return;
				}
				if (flag)
				{
					_options &= ~regexOptions;
				}
				else
				{
					_options |= regexOptions;
				}
				break;
			}
			}
			MoveRight();
		}
	}

	private char ScanCharEscape()
	{
		char c = RightCharMoveRight();
		if (c >= '0' && c <= '7')
		{
			MoveLeft();
			return ScanOctal();
		}
		switch (c)
		{
		case 'x':
			return ScanHex(2);
		case 'u':
			return ScanHex(4);
		case 'a':
			return '\a';
		case 'b':
			return '\b';
		case 'e':
			return '\u001b';
		case 'f':
			return '\f';
		case 'n':
			return '\n';
		case 'r':
			return '\r';
		case 't':
			return '\t';
		case 'v':
			return '\v';
		case 'c':
			return ScanControl();
		default:
			if (!UseOptionE() && RegexCharClass.IsWordChar(c))
			{
				throw MakeException(global::SR.Format("Unrecognized escape sequence \\{0}.", c.ToString()));
			}
			return c;
		}
	}

	private string ParseProperty()
	{
		if (CharsRight() < 3)
		{
			throw MakeException("Incomplete \\p{X} character escape.");
		}
		char c = RightCharMoveRight();
		if (c != '{')
		{
			throw MakeException("Malformed \\p{X} character escape.");
		}
		int num = Textpos();
		while (CharsRight() > 0)
		{
			c = RightCharMoveRight();
			if (!RegexCharClass.IsWordChar(c) && c != '-')
			{
				MoveLeft();
				break;
			}
		}
		string result = _pattern.Substring(num, Textpos() - num);
		if (CharsRight() == 0 || RightCharMoveRight() != '}')
		{
			throw MakeException("Incomplete \\p{X} character escape.");
		}
		return result;
	}

	private int TypeFromCode(char ch)
	{
		switch (ch)
		{
		case 'b':
			if (!UseOptionE())
			{
				return 16;
			}
			return 41;
		case 'B':
			if (!UseOptionE())
			{
				return 17;
			}
			return 42;
		case 'A':
			return 18;
		case 'G':
			return 19;
		case 'Z':
			return 20;
		case 'z':
			return 21;
		default:
			return 22;
		}
	}

	private static RegexOptions OptionFromCode(char ch)
	{
		if (ch >= 'A' && ch <= 'Z')
		{
			ch = (char)(ch + 32);
		}
		return ch switch
		{
			'i' => RegexOptions.IgnoreCase, 
			'r' => RegexOptions.RightToLeft, 
			'm' => RegexOptions.Multiline, 
			'n' => RegexOptions.ExplicitCapture, 
			's' => RegexOptions.Singleline, 
			'x' => RegexOptions.IgnorePatternWhitespace, 
			'e' => RegexOptions.ECMAScript, 
			_ => RegexOptions.None, 
		};
	}

	private void CountCaptures()
	{
		NoteCaptureSlot(0, 0);
		_autocap = 1;
		while (CharsRight() > 0)
		{
			int pos = Textpos();
			switch (RightCharMoveRight())
			{
			case '\\':
				if (CharsRight() > 0)
				{
					ScanBackslash(scanOnly: true);
				}
				break;
			case '#':
				if (UseOptionX())
				{
					MoveLeft();
					ScanBlank();
				}
				break;
			case '[':
				ScanCharClass(caseInsensitive: false, scanOnly: true);
				break;
			case ')':
				if (!EmptyOptionsStack())
				{
					PopOptions();
				}
				break;
			case '(':
				if (CharsRight() >= 2 && RightChar(1) == '#' && RightChar() == '?')
				{
					MoveLeft();
					ScanBlank();
				}
				else
				{
					PushOptions();
					if (CharsRight() > 0 && RightChar() == '?')
					{
						MoveRight();
						if (CharsRight() > 1 && (RightChar() == '<' || RightChar() == '\''))
						{
							MoveRight();
							char c = RightChar();
							if (c != '0' && RegexCharClass.IsWordChar(c))
							{
								if (c >= '1' && c <= '9')
								{
									NoteCaptureSlot(ScanDecimal(), pos);
								}
								else
								{
									NoteCaptureName(ScanCapname(), pos);
								}
							}
						}
						else
						{
							ScanOptions();
							if (CharsRight() > 0)
							{
								if (RightChar() == ')')
								{
									MoveRight();
									PopKeepOptions();
								}
								else if (RightChar() == '(')
								{
									_ignoreNextParen = true;
									break;
								}
							}
						}
					}
					else if (!UseOptionN() && !_ignoreNextParen)
					{
						NoteCaptureSlot(_autocap++, pos);
					}
				}
				_ignoreNextParen = false;
				break;
			}
		}
		AssignNameSlots();
	}

	private void NoteCaptureSlot(int i, int pos)
	{
		if (_caps.ContainsKey(i))
		{
			return;
		}
		_caps.Add(i, pos);
		_capcount++;
		if (_captop <= i)
		{
			if (i == int.MaxValue)
			{
				_captop = i;
			}
			else
			{
				_captop = i + 1;
			}
		}
	}

	private void NoteCaptureName(string name, int pos)
	{
		if (_capnames == null)
		{
			_capnames = new Hashtable();
			_capnamelist = new List<string>();
		}
		if (!_capnames.ContainsKey(name))
		{
			_capnames.Add(name, pos);
			_capnamelist.Add(name);
		}
	}

	private void NoteCaptures(Hashtable caps, int capsize, Hashtable capnames)
	{
		_caps = caps;
		_capsize = capsize;
		_capnames = capnames;
	}

	private void AssignNameSlots()
	{
		if (_capnames != null)
		{
			for (int i = 0; i < _capnamelist.Count; i++)
			{
				while (IsCaptureSlot(_autocap))
				{
					_autocap++;
				}
				string key = _capnamelist[i];
				int pos = (int)_capnames[key];
				_capnames[key] = _autocap;
				NoteCaptureSlot(_autocap, pos);
				_autocap++;
			}
		}
		if (_capcount < _captop)
		{
			_capnumlist = new int[_capcount];
			int num = 0;
			IDictionaryEnumerator enumerator = _caps.GetEnumerator();
			while (enumerator.MoveNext())
			{
				_capnumlist[num++] = (int)enumerator.Key;
			}
			Array.Sort(_capnumlist, Comparer<int>.Default);
		}
		if (_capnames == null && _capnumlist == null)
		{
			return;
		}
		int num2 = 0;
		List<string> list;
		int num3;
		if (_capnames == null)
		{
			list = null;
			_capnames = new Hashtable();
			_capnamelist = new List<string>();
			num3 = -1;
		}
		else
		{
			list = _capnamelist;
			_capnamelist = new List<string>();
			num3 = (int)_capnames[list[0]];
		}
		for (int j = 0; j < _capcount; j++)
		{
			int num4 = ((_capnumlist == null) ? j : _capnumlist[j]);
			if (num3 == num4)
			{
				_capnamelist.Add(list[num2++]);
				num3 = ((num2 == list.Count) ? (-1) : ((int)_capnames[list[num2]]));
			}
			else
			{
				string text = Convert.ToString(num4, _culture);
				_capnamelist.Add(text);
				_capnames[text] = num4;
			}
		}
	}

	private int CaptureSlotFromName(string capname)
	{
		return (int)_capnames[capname];
	}

	private bool IsCaptureSlot(int i)
	{
		if (_caps != null)
		{
			return _caps.ContainsKey(i);
		}
		if (i >= 0)
		{
			return i < _capsize;
		}
		return false;
	}

	private bool IsCaptureName(string capname)
	{
		if (_capnames == null)
		{
			return false;
		}
		return _capnames.ContainsKey(capname);
	}

	private bool UseOptionN()
	{
		return (_options & RegexOptions.ExplicitCapture) != 0;
	}

	private bool UseOptionI()
	{
		return (_options & RegexOptions.IgnoreCase) != 0;
	}

	private bool UseOptionM()
	{
		return (_options & RegexOptions.Multiline) != 0;
	}

	private bool UseOptionS()
	{
		return (_options & RegexOptions.Singleline) != 0;
	}

	private bool UseOptionX()
	{
		return (_options & RegexOptions.IgnorePatternWhitespace) != 0;
	}

	private bool UseOptionE()
	{
		return (_options & RegexOptions.ECMAScript) != 0;
	}

	private static bool IsSpecial(char ch)
	{
		if (ch <= '|')
		{
			return s_category[(uint)ch] >= 4;
		}
		return false;
	}

	private static bool IsStopperX(char ch)
	{
		if (ch <= '|')
		{
			return s_category[(uint)ch] >= 2;
		}
		return false;
	}

	private static bool IsQuantifier(char ch)
	{
		if (ch <= '{')
		{
			return s_category[(uint)ch] >= 5;
		}
		return false;
	}

	private bool IsTrueQuantifier()
	{
		int num = CharsRight();
		if (num == 0)
		{
			return false;
		}
		int num2 = Textpos();
		char c = CharAt(num2);
		if (c != '{')
		{
			if (c <= '{')
			{
				return s_category[(uint)c] >= 5;
			}
			return false;
		}
		int num3 = num2;
		while (--num > 0 && (c = CharAt(++num3)) >= '0' && c <= '9')
		{
		}
		if (num == 0 || num3 - num2 == 1)
		{
			return false;
		}
		switch (c)
		{
		case '}':
			return true;
		default:
			return false;
		case ',':
			break;
		}
		while (--num > 0 && (c = CharAt(++num3)) >= '0' && c <= '9')
		{
		}
		if (num > 0)
		{
			return c == '}';
		}
		return false;
	}

	private static bool IsSpace(char ch)
	{
		if (ch <= ' ')
		{
			return s_category[(uint)ch] == 2;
		}
		return false;
	}

	private static bool IsMetachar(char ch)
	{
		if (ch <= '|')
		{
			return s_category[(uint)ch] >= 1;
		}
		return false;
	}

	private void AddConcatenate(int pos, int cch, bool isReplacement)
	{
		if (cch == 0)
		{
			return;
		}
		RegexNode newChild;
		if (cch > 1)
		{
			string text = _pattern.Substring(pos, cch);
			if (UseOptionI() && !isReplacement)
			{
				StringBuilder stringBuilder = StringBuilderCache.Acquire(text.Length);
				for (int i = 0; i < text.Length; i++)
				{
					stringBuilder.Append(_culture.TextInfo.ToLower(text[i]));
				}
				text = StringBuilderCache.GetStringAndRelease(stringBuilder);
			}
			newChild = new RegexNode(12, _options, text);
		}
		else
		{
			char c = _pattern[pos];
			if (UseOptionI() && !isReplacement)
			{
				c = _culture.TextInfo.ToLower(c);
			}
			newChild = new RegexNode(9, _options, c);
		}
		_concatenation.AddChild(newChild);
	}

	private void PushGroup()
	{
		_group.Next = _stack;
		_alternation.Next = _group;
		_concatenation.Next = _alternation;
		_stack = _concatenation;
	}

	private void PopGroup()
	{
		_concatenation = _stack;
		_alternation = _concatenation.Next;
		_group = _alternation.Next;
		_stack = _group.Next;
		if (_group.Type() == 34 && _group.ChildCount() == 0)
		{
			if (_unit == null)
			{
				throw MakeException("Illegal conditional (?(...)) expression.");
			}
			_group.AddChild(_unit);
			_unit = null;
		}
	}

	private bool EmptyStack()
	{
		return _stack == null;
	}

	private void StartGroup(RegexNode openGroup)
	{
		_group = openGroup;
		_alternation = new RegexNode(24, _options);
		_concatenation = new RegexNode(25, _options);
	}

	private void AddAlternate()
	{
		if (_group.Type() == 34 || _group.Type() == 33)
		{
			_group.AddChild(_concatenation.ReverseLeft());
		}
		else
		{
			_alternation.AddChild(_concatenation.ReverseLeft());
		}
		_concatenation = new RegexNode(25, _options);
	}

	private void AddConcatenate()
	{
		_concatenation.AddChild(_unit);
		_unit = null;
	}

	private void AddConcatenate(bool lazy, int min, int max)
	{
		_concatenation.AddChild(_unit.MakeQuantifier(lazy, min, max));
		_unit = null;
	}

	private RegexNode Unit()
	{
		return _unit;
	}

	private void AddUnitOne(char ch)
	{
		if (UseOptionI())
		{
			ch = _culture.TextInfo.ToLower(ch);
		}
		_unit = new RegexNode(9, _options, ch);
	}

	private void AddUnitNotone(char ch)
	{
		if (UseOptionI())
		{
			ch = _culture.TextInfo.ToLower(ch);
		}
		_unit = new RegexNode(10, _options, ch);
	}

	private void AddUnitSet(string cc)
	{
		_unit = new RegexNode(11, _options, cc);
	}

	private void AddUnitNode(RegexNode node)
	{
		_unit = node;
	}

	private void AddUnitType(int type)
	{
		_unit = new RegexNode(type, _options);
	}

	private void AddGroup()
	{
		if (_group.Type() == 34 || _group.Type() == 33)
		{
			_group.AddChild(_concatenation.ReverseLeft());
			if ((_group.Type() == 33 && _group.ChildCount() > 2) || _group.ChildCount() > 3)
			{
				throw MakeException("Too many | in (?()|).");
			}
		}
		else
		{
			_alternation.AddChild(_concatenation.ReverseLeft());
			_group.AddChild(_alternation);
		}
		_unit = _group;
	}

	private void PushOptions()
	{
		_optionsStack.Add(_options);
	}

	private void PopOptions()
	{
		_options = _optionsStack[_optionsStack.Count - 1];
		_optionsStack.RemoveAt(_optionsStack.Count - 1);
	}

	private bool EmptyOptionsStack()
	{
		return _optionsStack.Count == 0;
	}

	private void PopKeepOptions()
	{
		_optionsStack.RemoveAt(_optionsStack.Count - 1);
	}

	private ArgumentException MakeException(string message)
	{
		return new ArgumentException(global::SR.Format("parsing \"{0}\" - {1}", _pattern, message));
	}

	private int Textpos()
	{
		return _currentPos;
	}

	private void Textto(int pos)
	{
		_currentPos = pos;
	}

	private char RightCharMoveRight()
	{
		return _pattern[_currentPos++];
	}

	private void MoveRight()
	{
		MoveRight(1);
	}

	private void MoveRight(int i)
	{
		_currentPos += i;
	}

	private void MoveLeft()
	{
		_currentPos--;
	}

	private char CharAt(int i)
	{
		return _pattern[i];
	}

	internal char RightChar()
	{
		return _pattern[_currentPos];
	}

	private char RightChar(int i)
	{
		return _pattern[_currentPos + i];
	}

	private int CharsRight()
	{
		return _pattern.Length - _currentPos;
	}

	static RegexParser()
	{
		//IL_0010: Field data (rva=0x820) could not be found in any section!
		//IL_0010: Field data (rva=0x820) could not be found in any section!
		byte[] array = new byte[128];
		RuntimeHelpers.InitializeArray(array, (RuntimeFieldHandle)/*OpCode not supported: LdMemberToken*/);
		s_category = array;
	}
}
