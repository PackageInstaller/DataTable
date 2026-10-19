using Unity.VisualScripting.Antlr3.Runtime;

namespace Unity.VisualScripting.Dependencies.NCalc;

public class NCalcLexer : Lexer
{
	protected class DFA7 : DFA
	{
		public override string Description => "252:1: FLOAT : ( ( DIGIT )* '.' ( DIGIT )+ ( E )? | ( DIGIT )+ E );";

		public DFA7(BaseRecognizer recognizer)
		{
			base.recognizer = recognizer;
			decisionNumber = 7;
			eot = DFA7_eot;
			eof = DFA7_eof;
			min = DFA7_min;
			max = DFA7_max;
			accept = DFA7_accept;
			special = DFA7_special;
			transition = DFA7_transition;
		}
	}

	protected class DFA14 : DFA
	{
		public override string Description => "1:1: Tokens : ( T__19 | T__20 | T__21 | T__22 | T__23 | T__24 | T__25 | T__26 | T__27 | T__28 | T__29 | T__30 | T__31 | T__32 | T__33 | T__34 | T__35 | T__36 | T__37 | T__38 | T__39 | T__40 | T__41 | T__42 | T__43 | T__44 | T__45 | T__46 | T__47 | T__48 | TRUE | FALSE | ID | INTEGER | FLOAT | STRING | DATETIME | NAME | E | WS );";

		public DFA14(BaseRecognizer recognizer)
		{
			base.recognizer = recognizer;
			decisionNumber = 14;
			eot = DFA14_eot;
			eof = DFA14_eof;
			min = DFA14_min;
			max = DFA14_max;
			accept = DFA14_accept;
			special = DFA14_special;
			transition = DFA14_transition;
		}
	}

	protected DFA7 dfa7;

	protected DFA14 dfa14;

	public const int T__29 = 29;

	public const int T__28 = 28;

	public const int T__27 = 27;

	public const int T__26 = 26;

	public const int T__25 = 25;

	public const int T__24 = 24;

	public const int LETTER = 12;

	public const int T__23 = 23;

	public const int T__22 = 22;

	public const int T__21 = 21;

	public const int T__20 = 20;

	public const int FLOAT = 5;

	public const int ID = 10;

	public const int EOF = -1;

	public const int HexDigit = 17;

	public const int T__19 = 19;

	public const int NAME = 11;

	public const int DIGIT = 13;

	public const int T__42 = 42;

	public const int INTEGER = 4;

	public const int E = 14;

	public const int T__43 = 43;

	public const int T__40 = 40;

	public const int T__41 = 41;

	public const int T__46 = 46;

	public const int T__47 = 47;

	public const int T__44 = 44;

	public const int T__45 = 45;

	public const int T__48 = 48;

	public const int DATETIME = 7;

	public const int TRUE = 8;

	public const int T__30 = 30;

	public const int T__31 = 31;

	public const int T__32 = 32;

	public const int WS = 18;

	public const int T__33 = 33;

	public const int T__34 = 34;

	public const int T__35 = 35;

	public const int T__36 = 36;

	public const int T__37 = 37;

	public const int T__38 = 38;

	public const int T__39 = 39;

	public const int UnicodeEscape = 16;

	public const int FALSE = 9;

	public const int EscapeSequence = 15;

	public const int STRING = 6;

	private const string DFA7_eotS = "\u0004\uffff";

	private const string DFA7_eofS = "\u0004\uffff";

	private const string DFA7_minS = "\u0002.\u0002\uffff";

	private const string DFA7_maxS = "\u00019\u0001e\u0002\uffff";

	private const string DFA7_acceptS = "\u0002\uffff\u0001\u0001\u0001\u0002";

	private const string DFA7_specialS = "\u0004\uffff}>";

	private const string DFA14_eotS = "\u0003\uffff\u0001!\u0001\u001e\u0001$\u0001\u001e\u0001\uffff\u0001'\u0001)\u0001-\u00010\u0005\uffff\u0001\u001e\u0004\uffff\u0003\u001e\u00016\b\uffff\u00017\u0002\uffff\u0001\u001e\v\uffff\u0003\u001e\u0001\uffff\u0001\u001e\u0002\uffff\u0001<\u0001=\u0002\u001e\u0002\uffff\u0001@\u0001\u001e\u0001\uffff\u0001B\u0001\uffff";

	private const string DFA14_eofS = "C\uffff";

	private const string DFA14_minS = "\u0001\t\u0002\uffff\u0001|\u0001r\u0001&\u0001n\u0001\uffff\u0002=\u0001<\u0001=\u0005\uffff\u0001o\u0004\uffff\u0001r\u0001a\u0001+\u0001.\b\uffff\u00010\u0002\uffff\u0001d\v\uffff\u0001t\u0001u\u0001l\u0001\uffff\u00010\u0002\uffff\u00020\u0001e\u0001s\u0002\uffff\u00010\u0001e\u0001\uffff\u00010\u0001\uffff";

	private const string DFA14_maxS = "\u0001~\u0002\uffff\u0001|\u0001r\u0001&\u0001n\u0001\uffff\u0002=\u0002>\u0005\uffff\u0001o\u0004\uffff\u0001r\u0001a\u00019\u0001e\b\uffff\u0001z\u0002\uffff\u0001d\v\uffff\u0001t\u0001u\u0001l\u0001\uffff\u00019\u0002\uffff\u0002z\u0001e\u0001s\u0002\uffff\u0001z\u0001e\u0001\uffff\u0001z\u0001\uffff";

	private const string DFA14_acceptS = "\u0001\uffff\u0001\u0001\u0001\u0002\u0004\uffff\u0001\b\u0004\uffff\u0001\u0014\u0001\u0015\u0001\u0016\u0001\u0017\u0001\u0018\u0001\uffff\u0001\u001b\u0001\u001c\u0001\u001d\u0001\u001e\u0004\uffff\u0001#\u0001$\u0001%\u0001&\u0001!\u0001(\u0001\u0003\u0001\a\u0001\uffff\u0001\u0005\u0001\t\u0001\uffff\u0001\n\u0001\v\u0001\f\u0001\u0019\u0001\r\u0001\u000f\u0001\u0012\u0001\u000e\u0001\u0011\u0001\u0013\u0001\u0010\u0003\uffff\u0001'\u0001\uffff\u0001\"\u0001\u0004\u0004\uffff\u0001\u0006\u0001\u001a\u0002\uffff\u0001\u001f\u0001\uffff\u0001 ";

	private const string DFA14_specialS = "C\uffff}>";

	private static readonly string[] DFA7_transitionS = new string[4] { "\u0001\u0002\u0001\uffff\n\u0001", "\u0001\u0002\u0001\uffff\n\u0001\v\uffff\u0001\u0003\u001f\uffff\u0001\u0003", "", "" };

	private static readonly short[] DFA7_eot = DFA.UnpackEncodedString("\u0004\uffff");

	private static readonly short[] DFA7_eof = DFA.UnpackEncodedString("\u0004\uffff");

	private static readonly char[] DFA7_min = DFA.UnpackEncodedStringToUnsignedChars("\u0002.\u0002\uffff");

	private static readonly char[] DFA7_max = DFA.UnpackEncodedStringToUnsignedChars("\u00019\u0001e\u0002\uffff");

	private static readonly short[] DFA7_accept = DFA.UnpackEncodedString("\u0002\uffff\u0001\u0001\u0001\u0002");

	private static readonly short[] DFA7_special = DFA.UnpackEncodedString("\u0004\uffff}>");

	private static readonly short[][] DFA7_transition = DFA.UnpackEncodedStringArray(DFA7_transitionS);

	private static readonly string[] DFA14_transitionS = new string[67]
	{
		"\u0002\u001f\u0001\uffff\u0002\u001f\u0012\uffff\u0001\u001f\u0001\t\u0001\uffff\u0001\u001c\u0001\uffff\u0001\u0010\u0001\u0005\u0001\u001b\u0001\u0013\u0001\u0014\u0001\u000e\u0001\f\u0001\u0015\u0001\r\u0001\u001a\u0001\u000f\n\u0019\u0001\u0002\u0001\uffff\u0001\n\u0001\b\u0001\v\u0001\u0001\u0001\uffff\u0004\u001e\u0001\u0018\u0015\u001e\u0001\u001d\u0002\uffff\u0001\a\u0001\u001e\u0001\uffff\u0001\u0006\u0003\u001e\u0001\u0018\u0001\u0017\a\u001e\u0001\u0011\u0001\u0004\u0004\u001e\u0001\u0016\u0006\u001e\u0001\uffff\u0001\u0003\u0001\uffff\u0001\u0012", "", "", "\u0001 ", "\u0001\"", "\u0001#", "\u0001%", "", "\u0001&", "\u0001(",
		"\u0001,\u0001+\u0001*", "\u0001.\u0001/", "", "", "", "", "", "\u00011", "", "",
		"", "", "\u00012", "\u00013", "\u00014\u0001\uffff\u00014\u0002\uffff\n5", "\u0001\u001a\u0001\uffff\n\u0019\v\uffff\u0001\u001a\u001f\uffff\u0001\u001a", "", "", "", "",
		"", "", "", "", "\n\u001e\a\uffff\u001a\u001e\u0004\uffff\u0001\u001e\u0001\uffff\u001a\u001e", "", "", "\u00018", "", "",
		"", "", "", "", "", "", "", "", "", "\u00019",
		"\u0001:", "\u0001;", "", "\n5", "", "", "\n\u001e\a\uffff\u001a\u001e\u0004\uffff\u0001\u001e\u0001\uffff\u001a\u001e", "\n\u001e\a\uffff\u001a\u001e\u0004\uffff\u0001\u001e\u0001\uffff\u001a\u001e", "\u0001>", "\u0001?",
		"", "", "\n\u001e\a\uffff\u001a\u001e\u0004\uffff\u0001\u001e\u0001\uffff\u001a\u001e", "\u0001A", "", "\n\u001e\a\uffff\u001a\u001e\u0004\uffff\u0001\u001e\u0001\uffff\u001a\u001e", ""
	};

	private static readonly short[] DFA14_eot = DFA.UnpackEncodedString("\u0003\uffff\u0001!\u0001\u001e\u0001$\u0001\u001e\u0001\uffff\u0001'\u0001)\u0001-\u00010\u0005\uffff\u0001\u001e\u0004\uffff\u0003\u001e\u00016\b\uffff\u00017\u0002\uffff\u0001\u001e\v\uffff\u0003\u001e\u0001\uffff\u0001\u001e\u0002\uffff\u0001<\u0001=\u0002\u001e\u0002\uffff\u0001@\u0001\u001e\u0001\uffff\u0001B\u0001\uffff");

	private static readonly short[] DFA14_eof = DFA.UnpackEncodedString("C\uffff");

	private static readonly char[] DFA14_min = DFA.UnpackEncodedStringToUnsignedChars("\u0001\t\u0002\uffff\u0001|\u0001r\u0001&\u0001n\u0001\uffff\u0002=\u0001<\u0001=\u0005\uffff\u0001o\u0004\uffff\u0001r\u0001a\u0001+\u0001.\b\uffff\u00010\u0002\uffff\u0001d\v\uffff\u0001t\u0001u\u0001l\u0001\uffff\u00010\u0002\uffff\u00020\u0001e\u0001s\u0002\uffff\u00010\u0001e\u0001\uffff\u00010\u0001\uffff");

	private static readonly char[] DFA14_max = DFA.UnpackEncodedStringToUnsignedChars("\u0001~\u0002\uffff\u0001|\u0001r\u0001&\u0001n\u0001\uffff\u0002=\u0002>\u0005\uffff\u0001o\u0004\uffff\u0001r\u0001a\u00019\u0001e\b\uffff\u0001z\u0002\uffff\u0001d\v\uffff\u0001t\u0001u\u0001l\u0001\uffff\u00019\u0002\uffff\u0002z\u0001e\u0001s\u0002\uffff\u0001z\u0001e\u0001\uffff\u0001z\u0001\uffff");

	private static readonly short[] DFA14_accept = DFA.UnpackEncodedString("\u0001\uffff\u0001\u0001\u0001\u0002\u0004\uffff\u0001\b\u0004\uffff\u0001\u0014\u0001\u0015\u0001\u0016\u0001\u0017\u0001\u0018\u0001\uffff\u0001\u001b\u0001\u001c\u0001\u001d\u0001\u001e\u0004\uffff\u0001#\u0001$\u0001%\u0001&\u0001!\u0001(\u0001\u0003\u0001\a\u0001\uffff\u0001\u0005\u0001\t\u0001\uffff\u0001\n\u0001\v\u0001\f\u0001\u0019\u0001\r\u0001\u000f\u0001\u0012\u0001\u000e\u0001\u0011\u0001\u0013\u0001\u0010\u0003\uffff\u0001'\u0001\uffff\u0001\"\u0001\u0004\u0004\uffff\u0001\u0006\u0001\u001a\u0002\uffff\u0001\u001f\u0001\uffff\u0001 ");

	private static readonly short[] DFA14_special = DFA.UnpackEncodedString("C\uffff}>");

	private static readonly short[][] DFA14_transition = DFA.UnpackEncodedStringArray(DFA14_transitionS);

	public override string GrammarFileName => "C:\\Users\\s.ros\\Documents\\D\ufffdveloppement\\NCalc\\Grammar\\NCalc.g";

	public NCalcLexer()
	{
		InitializeCyclicDFAs();
	}

	public NCalcLexer(ICharStream input)
		: this(input, null)
	{
	}

	public NCalcLexer(ICharStream input, RecognizerSharedState state)
		: base(input, state)
	{
		InitializeCyclicDFAs();
	}

	private void InitializeCyclicDFAs()
	{
		dfa7 = new DFA7(this);
		dfa14 = new DFA14(this);
	}

	public void mT__19()
	{
		int type = 19;
		int channel = 0;
		Match(63);
		state.type = type;
		state.channel = channel;
	}

	public void mT__20()
	{
		int type = 20;
		int channel = 0;
		Match(58);
		state.type = type;
		state.channel = channel;
	}

	public void mT__21()
	{
		int type = 21;
		int channel = 0;
		Match("||");
		state.type = type;
		state.channel = channel;
	}

	public void mT__22()
	{
		int type = 22;
		int channel = 0;
		Match("or");
		state.type = type;
		state.channel = channel;
	}

	public void mT__23()
	{
		int type = 23;
		int channel = 0;
		Match("&&");
		state.type = type;
		state.channel = channel;
	}

	public void mT__24()
	{
		int type = 24;
		int channel = 0;
		Match("and");
		state.type = type;
		state.channel = channel;
	}

	public void mT__25()
	{
		int type = 25;
		int channel = 0;
		Match(124);
		state.type = type;
		state.channel = channel;
	}

	public void mT__26()
	{
		int type = 26;
		int channel = 0;
		Match(94);
		state.type = type;
		state.channel = channel;
	}

	public void mT__27()
	{
		int type = 27;
		int channel = 0;
		Match(38);
		state.type = type;
		state.channel = channel;
	}

	public void mT__28()
	{
		int type = 28;
		int channel = 0;
		Match("==");
		state.type = type;
		state.channel = channel;
	}

	public void mT__29()
	{
		int type = 29;
		int channel = 0;
		Match(61);
		state.type = type;
		state.channel = channel;
	}

	public void mT__30()
	{
		int type = 30;
		int channel = 0;
		Match("!=");
		state.type = type;
		state.channel = channel;
	}

	public void mT__31()
	{
		int type = 31;
		int channel = 0;
		Match("<>");
		state.type = type;
		state.channel = channel;
	}

	public void mT__32()
	{
		int type = 32;
		int channel = 0;
		Match(60);
		state.type = type;
		state.channel = channel;
	}

	public void mT__33()
	{
		int type = 33;
		int channel = 0;
		Match("<=");
		state.type = type;
		state.channel = channel;
	}

	public void mT__34()
	{
		int type = 34;
		int channel = 0;
		Match(62);
		state.type = type;
		state.channel = channel;
	}

	public void mT__35()
	{
		int type = 35;
		int channel = 0;
		Match(">=");
		state.type = type;
		state.channel = channel;
	}

	public void mT__36()
	{
		int type = 36;
		int channel = 0;
		Match("<<");
		state.type = type;
		state.channel = channel;
	}

	public void mT__37()
	{
		int type = 37;
		int channel = 0;
		Match(">>");
		state.type = type;
		state.channel = channel;
	}

	public void mT__38()
	{
		int type = 38;
		int channel = 0;
		Match(43);
		state.type = type;
		state.channel = channel;
	}

	public void mT__39()
	{
		int type = 39;
		int channel = 0;
		Match(45);
		state.type = type;
		state.channel = channel;
	}

	public void mT__40()
	{
		int type = 40;
		int channel = 0;
		Match(42);
		state.type = type;
		state.channel = channel;
	}

	public void mT__41()
	{
		int type = 41;
		int channel = 0;
		Match(47);
		state.type = type;
		state.channel = channel;
	}

	public void mT__42()
	{
		int type = 42;
		int channel = 0;
		Match(37);
		state.type = type;
		state.channel = channel;
	}

	public void mT__43()
	{
		int type = 43;
		int channel = 0;
		Match(33);
		state.type = type;
		state.channel = channel;
	}

	public void mT__44()
	{
		int type = 44;
		int channel = 0;
		Match("not");
		state.type = type;
		state.channel = channel;
	}

	public void mT__45()
	{
		int type = 45;
		int channel = 0;
		Match(126);
		state.type = type;
		state.channel = channel;
	}

	public void mT__46()
	{
		int type = 46;
		int channel = 0;
		Match(40);
		state.type = type;
		state.channel = channel;
	}

	public void mT__47()
	{
		int type = 47;
		int channel = 0;
		Match(41);
		state.type = type;
		state.channel = channel;
	}

	public void mT__48()
	{
		int type = 48;
		int channel = 0;
		Match(44);
		state.type = type;
		state.channel = channel;
	}

	public void mTRUE()
	{
		int type = 8;
		int channel = 0;
		Match("true");
		state.type = type;
		state.channel = channel;
	}

	public void mFALSE()
	{
		int type = 9;
		int channel = 0;
		Match("false");
		state.type = type;
		state.channel = channel;
	}

	public void mID()
	{
		int type = 10;
		int channel = 0;
		mLETTER();
		while (true)
		{
			int num = 2;
			int num2 = input.LA(1);
			if ((num2 >= 48 && num2 <= 57) || (num2 >= 65 && num2 <= 90) || num2 == 95 || (num2 >= 97 && num2 <= 122))
			{
				num = 1;
			}
			if (num != 1)
			{
				break;
			}
			if ((input.LA(1) >= 48 && input.LA(1) <= 57) || (input.LA(1) >= 65 && input.LA(1) <= 90) || input.LA(1) == 95 || (input.LA(1) >= 97 && input.LA(1) <= 122))
			{
				input.Consume();
				continue;
			}
			MismatchedSetException ex = new MismatchedSetException(null, input);
			Recover(ex);
			throw ex;
		}
		state.type = type;
		state.channel = channel;
	}

	public void mINTEGER()
	{
		int type = 4;
		int channel = 0;
		int num = 0;
		while (true)
		{
			int num2 = 2;
			int num3 = input.LA(1);
			if (num3 >= 48 && num3 <= 57)
			{
				num2 = 1;
			}
			if (num2 != 1)
			{
				break;
			}
			mDIGIT();
			num++;
		}
		if (num < 1)
		{
			throw new EarlyExitException(2, input);
		}
		state.type = type;
		state.channel = channel;
	}

	public void mFLOAT()
	{
		int type = 5;
		int channel = 0;
		int num = 2;
		num = dfa7.Predict(input);
		if (num != 1)
		{
			if (num == 2)
			{
				int num2 = 0;
				while (true)
				{
					int num3 = 2;
					int num4 = input.LA(1);
					if (num4 >= 48 && num4 <= 57)
					{
						num3 = 1;
					}
					if (num3 != 1)
					{
						break;
					}
					mDIGIT();
					num2++;
				}
				if (num2 < 1)
				{
					throw new EarlyExitException(6, input);
				}
				mE();
			}
		}
		else
		{
			while (true)
			{
				int num5 = 2;
				int num6 = input.LA(1);
				if (num6 >= 48 && num6 <= 57)
				{
					num5 = 1;
				}
				if (num5 != 1)
				{
					break;
				}
				mDIGIT();
			}
			Match(46);
			int num7 = 0;
			while (true)
			{
				int num8 = 2;
				int num9 = input.LA(1);
				if (num9 >= 48 && num9 <= 57)
				{
					num8 = 1;
				}
				if (num8 != 1)
				{
					break;
				}
				mDIGIT();
				num7++;
			}
			if (num7 < 1)
			{
				throw new EarlyExitException(4, input);
			}
			int num10 = 2;
			int num11 = input.LA(1);
			if (num11 == 69 || num11 == 101)
			{
				num10 = 1;
			}
			if (num10 == 1)
			{
				mE();
			}
		}
		state.type = type;
		state.channel = channel;
	}

	public void mSTRING()
	{
		int type = 6;
		int channel = 0;
		Match(39);
		while (true)
		{
			int num = 3;
			int num2 = input.LA(1);
			if (num2 == 92)
			{
				num = 1;
			}
			else if ((num2 >= 32 && num2 <= 38) || (num2 >= 40 && num2 <= 91) || (num2 >= 93 && num2 <= 65535))
			{
				num = 2;
			}
			switch (num)
			{
			case 1:
				mEscapeSequence();
				break;
			case 2:
			{
				if ((input.LA(1) >= 32 && input.LA(1) <= 38) || (input.LA(1) >= 40 && input.LA(1) <= 91) || (input.LA(1) >= 93 && input.LA(1) <= 65535))
				{
					input.Consume();
					break;
				}
				MismatchedSetException ex = new MismatchedSetException(null, input);
				Recover(ex);
				throw ex;
			}
			default:
				Match(39);
				state.type = type;
				state.channel = channel;
				return;
			}
		}
	}

	public void mDATETIME()
	{
		int type = 7;
		int channel = 0;
		Match(35);
		while (true)
		{
			int num = 2;
			int num2 = input.LA(1);
			if ((num2 >= 0 && num2 <= 34) || (num2 >= 36 && num2 <= 65535))
			{
				num = 1;
			}
			if (num != 1)
			{
				break;
			}
			if ((input.LA(1) >= 0 && input.LA(1) <= 34) || (input.LA(1) >= 36 && input.LA(1) <= 65535))
			{
				input.Consume();
				continue;
			}
			MismatchedSetException ex = new MismatchedSetException(null, input);
			Recover(ex);
			throw ex;
		}
		Match(35);
		state.type = type;
		state.channel = channel;
	}

	public void mNAME()
	{
		int type = 11;
		int channel = 0;
		Match(91);
		while (true)
		{
			int num = 2;
			int num2 = input.LA(1);
			if ((num2 >= 0 && num2 <= 92) || (num2 >= 94 && num2 <= 65535))
			{
				num = 1;
			}
			if (num != 1)
			{
				break;
			}
			if ((input.LA(1) >= 0 && input.LA(1) <= 92) || (input.LA(1) >= 94 && input.LA(1) <= 65535))
			{
				input.Consume();
				continue;
			}
			MismatchedSetException ex = new MismatchedSetException(null, input);
			Recover(ex);
			throw ex;
		}
		Match(93);
		state.type = type;
		state.channel = channel;
	}

	public void mE()
	{
		int type = 14;
		int channel = 0;
		if (input.LA(1) == 69 || input.LA(1) == 101)
		{
			input.Consume();
			int num = 2;
			int num2 = input.LA(1);
			if (num2 == 43 || num2 == 45)
			{
				num = 1;
			}
			if (num == 1)
			{
				if (input.LA(1) != 43 && input.LA(1) != 45)
				{
					MismatchedSetException ex = new MismatchedSetException(null, input);
					Recover(ex);
					throw ex;
				}
				input.Consume();
			}
			int num3 = 0;
			while (true)
			{
				int num4 = 2;
				int num5 = input.LA(1);
				if (num5 >= 48 && num5 <= 57)
				{
					num4 = 1;
				}
				if (num4 != 1)
				{
					break;
				}
				mDIGIT();
				num3++;
			}
			if (num3 < 1)
			{
				throw new EarlyExitException(12, input);
			}
			state.type = type;
			state.channel = channel;
			return;
		}
		MismatchedSetException ex2 = new MismatchedSetException(null, input);
		Recover(ex2);
		throw ex2;
	}

	public void mLETTER()
	{
		if ((input.LA(1) >= 65 && input.LA(1) <= 90) || input.LA(1) == 95 || (input.LA(1) >= 97 && input.LA(1) <= 122))
		{
			input.Consume();
			return;
		}
		MismatchedSetException ex = new MismatchedSetException(null, input);
		Recover(ex);
		throw ex;
	}

	public void mDIGIT()
	{
		MatchRange(48, 57);
	}

	public void mEscapeSequence()
	{
		Match(92);
		int num = 6;
		switch (input.LA(1) switch
		{
			110 => 1, 
			114 => 2, 
			116 => 3, 
			39 => 4, 
			92 => 5, 
			117 => 6, 
			_ => throw new NoViableAltException("", 13, 0, input), 
		})
		{
		case 1:
			Match(110);
			break;
		case 2:
			Match(114);
			break;
		case 3:
			Match(116);
			break;
		case 4:
			Match(39);
			break;
		case 5:
			Match(92);
			break;
		case 6:
			mUnicodeEscape();
			break;
		}
	}

	public void mHexDigit()
	{
		if ((input.LA(1) >= 48 && input.LA(1) <= 57) || (input.LA(1) >= 65 && input.LA(1) <= 70) || (input.LA(1) >= 97 && input.LA(1) <= 102))
		{
			input.Consume();
			return;
		}
		MismatchedSetException ex = new MismatchedSetException(null, input);
		Recover(ex);
		throw ex;
	}

	public void mUnicodeEscape()
	{
		Match(117);
		mHexDigit();
		mHexDigit();
		mHexDigit();
		mHexDigit();
	}

	public void mWS()
	{
		int type = 18;
		int num = 0;
		if ((input.LA(1) >= 9 && input.LA(1) <= 10) || (input.LA(1) >= 12 && input.LA(1) <= 13) || input.LA(1) == 32)
		{
			input.Consume();
			num = 99;
			state.type = type;
			state.channel = num;
			return;
		}
		MismatchedSetException ex = new MismatchedSetException(null, input);
		Recover(ex);
		throw ex;
	}

	public override void mTokens()
	{
		int num = 40;
		switch (dfa14.Predict(input))
		{
		case 1:
			mT__19();
			break;
		case 2:
			mT__20();
			break;
		case 3:
			mT__21();
			break;
		case 4:
			mT__22();
			break;
		case 5:
			mT__23();
			break;
		case 6:
			mT__24();
			break;
		case 7:
			mT__25();
			break;
		case 8:
			mT__26();
			break;
		case 9:
			mT__27();
			break;
		case 10:
			mT__28();
			break;
		case 11:
			mT__29();
			break;
		case 12:
			mT__30();
			break;
		case 13:
			mT__31();
			break;
		case 14:
			mT__32();
			break;
		case 15:
			mT__33();
			break;
		case 16:
			mT__34();
			break;
		case 17:
			mT__35();
			break;
		case 18:
			mT__36();
			break;
		case 19:
			mT__37();
			break;
		case 20:
			mT__38();
			break;
		case 21:
			mT__39();
			break;
		case 22:
			mT__40();
			break;
		case 23:
			mT__41();
			break;
		case 24:
			mT__42();
			break;
		case 25:
			mT__43();
			break;
		case 26:
			mT__44();
			break;
		case 27:
			mT__45();
			break;
		case 28:
			mT__46();
			break;
		case 29:
			mT__47();
			break;
		case 30:
			mT__48();
			break;
		case 31:
			mTRUE();
			break;
		case 32:
			mFALSE();
			break;
		case 33:
			mID();
			break;
		case 34:
			mINTEGER();
			break;
		case 35:
			mFLOAT();
			break;
		case 36:
			mSTRING();
			break;
		case 37:
			mDATETIME();
			break;
		case 38:
			mNAME();
			break;
		case 39:
			mE();
			break;
		case 40:
			mWS();
			break;
		}
	}
}
