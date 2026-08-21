using System.Globalization;

namespace System.Text.RegularExpressions;

internal sealed class RegexInterpreter : RegexRunner
{
	private readonly RegexCode _code;

	private readonly CultureInfo _culture;

	private int _operator;

	private int _codepos;

	private bool _rightToLeft;

	private bool _caseInsensitive;

	public RegexInterpreter(RegexCode code, CultureInfo culture)
	{
		_code = code;
		_culture = culture;
	}

	protected override void InitTrackCount()
	{
		runtrackcount = _code.TrackCount;
	}

	private void Advance(int i)
	{
		_codepos += i + 1;
		SetOperator(_code.Codes[_codepos]);
	}

	private void Goto(int newpos)
	{
		if (newpos < _codepos)
		{
			EnsureStorage();
		}
		SetOperator(_code.Codes[newpos]);
		_codepos = newpos;
	}

	private void Textto(int newpos)
	{
		runtextpos = newpos;
	}

	private void Trackto(int newpos)
	{
		runtrackpos = runtrack.Length - newpos;
	}

	private int Textstart()
	{
		return runtextstart;
	}

	private int Textpos()
	{
		return runtextpos;
	}

	private int Trackpos()
	{
		return runtrack.Length - runtrackpos;
	}

	private void TrackPush()
	{
		runtrack[--runtrackpos] = _codepos;
	}

	private void TrackPush(int I1)
	{
		runtrack[--runtrackpos] = I1;
		runtrack[--runtrackpos] = _codepos;
	}

	private void TrackPush(int I1, int I2)
	{
		runtrack[--runtrackpos] = I1;
		runtrack[--runtrackpos] = I2;
		runtrack[--runtrackpos] = _codepos;
	}

	private void TrackPush(int I1, int I2, int I3)
	{
		runtrack[--runtrackpos] = I1;
		runtrack[--runtrackpos] = I2;
		runtrack[--runtrackpos] = I3;
		runtrack[--runtrackpos] = _codepos;
	}

	private void TrackPush2(int I1)
	{
		runtrack[--runtrackpos] = I1;
		runtrack[--runtrackpos] = -_codepos;
	}

	private void TrackPush2(int I1, int I2)
	{
		runtrack[--runtrackpos] = I1;
		runtrack[--runtrackpos] = I2;
		runtrack[--runtrackpos] = -_codepos;
	}

	private void Backtrack()
	{
		int num = runtrack[runtrackpos++];
		if (num < 0)
		{
			num = -num;
			SetOperator(_code.Codes[num] | 0x100);
		}
		else
		{
			SetOperator(_code.Codes[num] | 0x80);
		}
		if (num < _codepos)
		{
			EnsureStorage();
		}
		_codepos = num;
	}

	private void SetOperator(int op)
	{
		_caseInsensitive = (op & 0x200) != 0;
		_rightToLeft = (op & 0x40) != 0;
		_operator = op & -577;
	}

	private void TrackPop()
	{
		runtrackpos++;
	}

	private void TrackPop(int framesize)
	{
		runtrackpos += framesize;
	}

	private int TrackPeek()
	{
		return runtrack[runtrackpos - 1];
	}

	private int TrackPeek(int i)
	{
		return runtrack[runtrackpos - i - 1];
	}

	private void StackPush(int I1)
	{
		runstack[--runstackpos] = I1;
	}

	private void StackPush(int I1, int I2)
	{
		runstack[--runstackpos] = I1;
		runstack[--runstackpos] = I2;
	}

	private void StackPop()
	{
		runstackpos++;
	}

	private void StackPop(int framesize)
	{
		runstackpos += framesize;
	}

	private int StackPeek()
	{
		return runstack[runstackpos - 1];
	}

	private int StackPeek(int i)
	{
		return runstack[runstackpos - i - 1];
	}

	private int Operator()
	{
		return _operator;
	}

	private int Operand(int i)
	{
		return _code.Codes[_codepos + i + 1];
	}

	private int Leftchars()
	{
		return runtextpos - runtextbeg;
	}

	private int Rightchars()
	{
		return runtextend - runtextpos;
	}

	private int Bump()
	{
		if (!_rightToLeft)
		{
			return 1;
		}
		return -1;
	}

	private int Forwardchars()
	{
		if (!_rightToLeft)
		{
			return runtextend - runtextpos;
		}
		return runtextpos - runtextbeg;
	}

	private char Forwardcharnext()
	{
		char c = (_rightToLeft ? runtext[--runtextpos] : runtext[runtextpos++]);
		if (!_caseInsensitive)
		{
			return c;
		}
		return _culture.TextInfo.ToLower(c);
	}

	private bool Stringmatch(string str)
	{
		int num;
		int num2;
		if (!_rightToLeft)
		{
			if (runtextend - runtextpos < (num = str.Length))
			{
				return false;
			}
			num2 = runtextpos + num;
		}
		else
		{
			if (runtextpos - runtextbeg < (num = str.Length))
			{
				return false;
			}
			num2 = runtextpos;
		}
		if (!_caseInsensitive)
		{
			while (num != 0)
			{
				if (str[--num] != runtext[--num2])
				{
					return false;
				}
			}
		}
		else
		{
			while (num != 0)
			{
				if (str[--num] != _culture.TextInfo.ToLower(runtext[--num2]))
				{
					return false;
				}
			}
		}
		if (!_rightToLeft)
		{
			num2 += str.Length;
		}
		runtextpos = num2;
		return true;
	}

	private bool Refmatch(int index, int len)
	{
		int num;
		if (!_rightToLeft)
		{
			if (runtextend - runtextpos < len)
			{
				return false;
			}
			num = runtextpos + len;
		}
		else
		{
			if (runtextpos - runtextbeg < len)
			{
				return false;
			}
			num = runtextpos;
		}
		int num2 = index + len;
		int num3 = len;
		if (!_caseInsensitive)
		{
			while (num3-- != 0)
			{
				if (runtext[--num2] != runtext[--num])
				{
					return false;
				}
			}
		}
		else
		{
			while (num3-- != 0)
			{
				if (_culture.TextInfo.ToLower(runtext[--num2]) != _culture.TextInfo.ToLower(runtext[--num]))
				{
					return false;
				}
			}
		}
		if (!_rightToLeft)
		{
			num += len;
		}
		runtextpos = num;
		return true;
	}

	private void Backwardnext()
	{
		runtextpos += (_rightToLeft ? 1 : (-1));
	}

	private char CharAt(int j)
	{
		return runtext[j];
	}

	protected override bool FindFirstChar()
	{
		if ((_code.Anchors & 0x35) != 0)
		{
			if (!_code.RightToLeft)
			{
				if (((_code.Anchors & 1) != 0 && runtextpos > runtextbeg) || ((_code.Anchors & 4) != 0 && runtextpos > runtextstart))
				{
					runtextpos = runtextend;
					return false;
				}
				if ((_code.Anchors & 0x10) != 0 && runtextpos < runtextend - 1)
				{
					runtextpos = runtextend - 1;
				}
				else if ((_code.Anchors & 0x20) != 0 && runtextpos < runtextend)
				{
					runtextpos = runtextend;
				}
			}
			else
			{
				if (((_code.Anchors & 0x20) != 0 && runtextpos < runtextend) || ((_code.Anchors & 0x10) != 0 && (runtextpos < runtextend - 1 || (runtextpos == runtextend - 1 && CharAt(runtextpos) != '\n'))) || ((_code.Anchors & 4) != 0 && runtextpos < runtextstart))
				{
					runtextpos = runtextbeg;
					return false;
				}
				if ((_code.Anchors & 1) != 0 && runtextpos > runtextbeg)
				{
					runtextpos = runtextbeg;
				}
			}
			if (_code.BMPrefix != null)
			{
				return _code.BMPrefix.IsMatch(runtext, runtextpos, runtextbeg, runtextend);
			}
			return true;
		}
		if (_code.BMPrefix != null)
		{
			runtextpos = _code.BMPrefix.Scan(runtext, runtextpos, runtextbeg, runtextend);
			if (runtextpos == -1)
			{
				runtextpos = (_code.RightToLeft ? runtextbeg : runtextend);
				return false;
			}
			return true;
		}
		if (!_code.FCPrefix.HasValue)
		{
			return true;
		}
		_rightToLeft = _code.RightToLeft;
		_caseInsensitive = _code.FCPrefix.GetValueOrDefault().CaseInsensitive;
		string prefix = _code.FCPrefix.GetValueOrDefault().Prefix;
		if (RegexCharClass.IsSingleton(prefix))
		{
			char c = RegexCharClass.SingletonChar(prefix);
			for (int num = Forwardchars(); num > 0; num--)
			{
				if (c == Forwardcharnext())
				{
					Backwardnext();
					return true;
				}
			}
		}
		else
		{
			for (int num2 = Forwardchars(); num2 > 0; num2--)
			{
				if (RegexCharClass.CharInClass(Forwardcharnext(), prefix))
				{
					Backwardnext();
					return true;
				}
			}
		}
		return false;
	}

	protected override void Go()
	{
		Goto(0);
		int num = -1;
		while (true)
		{
			if (num >= 0)
			{
				Advance(num);
				num = -1;
			}
			CheckTimeout();
			switch (Operator())
			{
			case 40:
				return;
			case 38:
				Goto(Operand(0));
				continue;
			case 37:
				if (IsMatched(Operand(0)))
				{
					num = 1;
					continue;
				}
				break;
			case 23:
				TrackPush(Textpos());
				num = 1;
				continue;
			case 151:
				TrackPop();
				Textto(TrackPeek());
				Goto(Operand(0));
				continue;
			case 31:
				StackPush(Textpos());
				TrackPush();
				num = 0;
				continue;
			case 30:
				StackPush(-1);
				TrackPush();
				num = 0;
				continue;
			case 158:
			case 159:
				StackPop();
				break;
			case 33:
				StackPop();
				TrackPush(StackPeek());
				Textto(StackPeek());
				num = 0;
				continue;
			case 161:
				TrackPop();
				StackPush(TrackPeek());
				break;
			case 32:
				if (Operand(1) == -1 || IsMatched(Operand(1)))
				{
					StackPop();
					if (Operand(1) != -1)
					{
						TransferCapture(Operand(0), Operand(1), StackPeek(), Textpos());
					}
					else
					{
						Capture(Operand(0), StackPeek(), Textpos());
					}
					TrackPush(StackPeek());
					num = 2;
					continue;
				}
				break;
			case 160:
				TrackPop();
				StackPush(TrackPeek());
				Uncapture();
				if (Operand(0) != -1 && Operand(1) != -1)
				{
					Uncapture();
				}
				break;
			case 24:
				StackPop();
				if (Textpos() - StackPeek() != 0)
				{
					TrackPush(StackPeek(), Textpos());
					StackPush(Textpos());
					Goto(Operand(0));
				}
				else
				{
					TrackPush2(StackPeek());
					num = 1;
				}
				continue;
			case 152:
				TrackPop(2);
				StackPop();
				Textto(TrackPeek(1));
				TrackPush2(TrackPeek());
				num = 1;
				continue;
			case 280:
				TrackPop();
				StackPush(TrackPeek());
				break;
			case 25:
			{
				StackPop();
				int num28 = StackPeek();
				if (Textpos() != num28)
				{
					if (num28 != -1)
					{
						TrackPush(num28, Textpos());
					}
					else
					{
						TrackPush(Textpos(), Textpos());
					}
				}
				else
				{
					StackPush(num28);
					TrackPush2(StackPeek());
				}
				num = 1;
				continue;
			}
			case 153:
			{
				TrackPop(2);
				int num26 = TrackPeek(1);
				TrackPush2(TrackPeek());
				StackPush(num26);
				Textto(num26);
				Goto(Operand(0));
				continue;
			}
			case 281:
				StackPop();
				TrackPop();
				StackPush(TrackPeek());
				break;
			case 27:
				StackPush(Textpos(), Operand(0));
				TrackPush();
				num = 1;
				continue;
			case 26:
				StackPush(-1, Operand(0));
				TrackPush();
				num = 1;
				continue;
			case 155:
				StackPop(2);
				break;
			case 154:
				StackPop(2);
				break;
			case 28:
			{
				StackPop(2);
				int num17 = StackPeek();
				int num18 = StackPeek(1);
				int num19 = Textpos() - num17;
				if (num18 >= Operand(1) || (num19 == 0 && num18 >= 0))
				{
					TrackPush2(num17, num18);
					num = 2;
				}
				else
				{
					TrackPush(num17);
					StackPush(Textpos(), num18 + 1);
					Goto(Operand(0));
				}
				continue;
			}
			case 156:
				TrackPop();
				StackPop(2);
				if (StackPeek(1) > 0)
				{
					Textto(StackPeek());
					TrackPush2(TrackPeek(), StackPeek(1) - 1);
					num = 2;
					continue;
				}
				StackPush(TrackPeek(), StackPeek(1) - 1);
				break;
			case 284:
				TrackPop(2);
				StackPush(TrackPeek(), TrackPeek(1));
				break;
			case 29:
			{
				StackPop(2);
				int i = StackPeek();
				int num10 = StackPeek(1);
				if (num10 < 0)
				{
					TrackPush2(i);
					StackPush(Textpos(), num10 + 1);
					Goto(Operand(0));
				}
				else
				{
					TrackPush(i, num10, Textpos());
					num = 2;
				}
				continue;
			}
			case 157:
			{
				TrackPop(3);
				int num6 = TrackPeek();
				int num7 = TrackPeek(2);
				if (TrackPeek(1) < Operand(1) && num7 != num6)
				{
					Textto(num7);
					StackPush(num7, TrackPeek(1) + 1);
					TrackPush2(num6);
					Goto(Operand(0));
					continue;
				}
				StackPush(TrackPeek(), TrackPeek(1));
				break;
			}
			case 285:
				TrackPop();
				StackPop(2);
				StackPush(TrackPeek(), StackPeek(1) - 1);
				break;
			case 34:
				StackPush(Trackpos(), Crawlpos());
				TrackPush();
				num = 0;
				continue;
			case 162:
				StackPop(2);
				break;
			case 35:
				StackPop(2);
				Trackto(StackPeek());
				while (Crawlpos() != StackPeek(1))
				{
					Uncapture();
				}
				break;
			case 36:
				StackPop(2);
				Trackto(StackPeek());
				TrackPush(StackPeek(1));
				num = 0;
				continue;
			case 164:
				TrackPop();
				while (Crawlpos() != TrackPeek())
				{
					Uncapture();
				}
				break;
			case 14:
				if (Leftchars() <= 0 || CharAt(Textpos() - 1) == '\n')
				{
					num = 0;
					continue;
				}
				break;
			case 15:
				if (Rightchars() <= 0 || CharAt(Textpos()) == '\n')
				{
					num = 0;
					continue;
				}
				break;
			case 16:
				if (IsBoundary(Textpos(), runtextbeg, runtextend))
				{
					num = 0;
					continue;
				}
				break;
			case 17:
				if (!IsBoundary(Textpos(), runtextbeg, runtextend))
				{
					num = 0;
					continue;
				}
				break;
			case 41:
				if (IsECMABoundary(Textpos(), runtextbeg, runtextend))
				{
					num = 0;
					continue;
				}
				break;
			case 42:
				if (!IsECMABoundary(Textpos(), runtextbeg, runtextend))
				{
					num = 0;
					continue;
				}
				break;
			case 18:
				if (Leftchars() <= 0)
				{
					num = 0;
					continue;
				}
				break;
			case 19:
				if (Textpos() == Textstart())
				{
					num = 0;
					continue;
				}
				break;
			case 20:
				if (Rightchars() <= 1 && (Rightchars() != 1 || CharAt(Textpos()) == '\n'))
				{
					num = 0;
					continue;
				}
				break;
			case 21:
				if (Rightchars() <= 0)
				{
					num = 0;
					continue;
				}
				break;
			case 9:
				if (Forwardchars() >= 1 && Forwardcharnext() == (ushort)Operand(0))
				{
					num = 1;
					continue;
				}
				break;
			case 10:
				if (Forwardchars() >= 1 && Forwardcharnext() != (ushort)Operand(0))
				{
					num = 1;
					continue;
				}
				break;
			case 11:
				if (Forwardchars() >= 1 && RegexCharClass.CharInClass(Forwardcharnext(), _code.Strings[Operand(0)]))
				{
					num = 1;
					continue;
				}
				break;
			case 12:
				if (Stringmatch(_code.Strings[Operand(0)]))
				{
					num = 1;
					continue;
				}
				break;
			case 13:
			{
				int cap = Operand(0);
				if (IsMatched(cap))
				{
					if (!Refmatch(MatchIndex(cap), MatchLength(cap)))
					{
						break;
					}
				}
				else if ((runregex.roptions & RegexOptions.ECMAScript) == 0)
				{
					break;
				}
				num = 1;
				continue;
			}
			case 0:
			{
				int num30 = Operand(1);
				if (Forwardchars() < num30)
				{
					break;
				}
				char c4 = (char)Operand(0);
				while (num30-- > 0)
				{
					if (Forwardcharnext() != c4)
					{
						goto end_IL_0024;
					}
				}
				num = 2;
				continue;
			}
			case 1:
			{
				int num29 = Operand(1);
				if (Forwardchars() < num29)
				{
					break;
				}
				char c3 = (char)Operand(0);
				while (num29-- > 0)
				{
					if (Forwardcharnext() == c3)
					{
						goto end_IL_0024;
					}
				}
				num = 2;
				continue;
			}
			case 2:
			{
				int num27 = Operand(1);
				if (Forwardchars() < num27)
				{
					break;
				}
				string set2 = _code.Strings[Operand(0)];
				while (num27-- > 0)
				{
					if (!RegexCharClass.CharInClass(Forwardcharnext(), set2))
					{
						goto end_IL_0024;
					}
				}
				num = 2;
				continue;
			}
			case 3:
			{
				int num24 = Operand(1);
				if (num24 > Forwardchars())
				{
					num24 = Forwardchars();
				}
				char c2 = (char)Operand(0);
				int num25;
				for (num25 = num24; num25 > 0; num25--)
				{
					if (Forwardcharnext() != c2)
					{
						Backwardnext();
						break;
					}
				}
				if (num24 > num25)
				{
					TrackPush(num24 - num25 - 1, Textpos() - Bump());
				}
				num = 2;
				continue;
			}
			case 4:
			{
				int num22 = Operand(1);
				if (num22 > Forwardchars())
				{
					num22 = Forwardchars();
				}
				char c = (char)Operand(0);
				int num23;
				for (num23 = num22; num23 > 0; num23--)
				{
					if (Forwardcharnext() == c)
					{
						Backwardnext();
						break;
					}
				}
				if (num22 > num23)
				{
					TrackPush(num22 - num23 - 1, Textpos() - Bump());
				}
				num = 2;
				continue;
			}
			case 5:
			{
				int num20 = Operand(1);
				if (num20 > Forwardchars())
				{
					num20 = Forwardchars();
				}
				string set = _code.Strings[Operand(0)];
				int num21;
				for (num21 = num20; num21 > 0; num21--)
				{
					if (!RegexCharClass.CharInClass(Forwardcharnext(), set))
					{
						Backwardnext();
						break;
					}
				}
				if (num20 > num21)
				{
					TrackPush(num20 - num21 - 1, Textpos() - Bump());
				}
				num = 2;
				continue;
			}
			case 131:
			case 132:
			{
				TrackPop(2);
				int num15 = TrackPeek();
				int num16 = TrackPeek(1);
				Textto(num16);
				if (num15 > 0)
				{
					TrackPush(num15 - 1, num16 - Bump());
				}
				num = 2;
				continue;
			}
			case 133:
			{
				TrackPop(2);
				int num13 = TrackPeek();
				int num14 = TrackPeek(1);
				Textto(num14);
				if (num13 > 0)
				{
					TrackPush(num13 - 1, num14 - Bump());
				}
				num = 2;
				continue;
			}
			case 6:
			case 7:
			{
				int num12 = Operand(1);
				if (num12 > Forwardchars())
				{
					num12 = Forwardchars();
				}
				if (num12 > 0)
				{
					TrackPush(num12 - 1, Textpos());
				}
				num = 2;
				continue;
			}
			case 8:
			{
				int num11 = Operand(1);
				if (num11 > Forwardchars())
				{
					num11 = Forwardchars();
				}
				if (num11 > 0)
				{
					TrackPush(num11 - 1, Textpos());
				}
				num = 2;
				continue;
			}
			case 134:
			{
				TrackPop(2);
				int num8 = TrackPeek(1);
				Textto(num8);
				if (Forwardcharnext() == (ushort)Operand(0))
				{
					int num9 = TrackPeek();
					if (num9 > 0)
					{
						TrackPush(num9 - 1, num8 + Bump());
					}
					num = 2;
					continue;
				}
				break;
			}
			case 135:
			{
				TrackPop(2);
				int num4 = TrackPeek(1);
				Textto(num4);
				if (Forwardcharnext() != (ushort)Operand(0))
				{
					int num5 = TrackPeek();
					if (num5 > 0)
					{
						TrackPush(num5 - 1, num4 + Bump());
					}
					num = 2;
					continue;
				}
				break;
			}
			case 136:
			{
				TrackPop(2);
				int num2 = TrackPeek(1);
				Textto(num2);
				if (RegexCharClass.CharInClass(Forwardcharnext(), _code.Strings[Operand(0)]))
				{
					int num3 = TrackPeek();
					if (num3 > 0)
					{
						TrackPush(num3 - 1, num2 + Bump());
					}
					num = 2;
					continue;
				}
				break;
			}
			default:
				throw System.NotImplemented.ByDesignWithMessage("Unimplemented state.");
			case 22:
				break;
				end_IL_0024:
				break;
			}
			Backtrack();
		}
	}
}
