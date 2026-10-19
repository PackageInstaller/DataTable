using System;
using System.Collections.Generic;
using System.Globalization;
using System.Text;
using Unity.VisualScripting.Antlr3.Runtime;
using Unity.VisualScripting.Antlr3.Runtime.Tree;

namespace Unity.VisualScripting.Dependencies.NCalc;

public class NCalcParser : Parser
{
	public class ncalcExpression_return : ParserRuleReturnScope
	{
		public LogicalExpression value;

		private CommonTree tree;

		public override object Tree
		{
			get
			{
				return tree;
			}
			set
			{
				tree = (CommonTree)value;
			}
		}
	}

	public class logicalExpression_return : ParserRuleReturnScope
	{
		public LogicalExpression value;

		private CommonTree tree;

		public override object Tree
		{
			get
			{
				return tree;
			}
			set
			{
				tree = (CommonTree)value;
			}
		}
	}

	public class conditionalExpression_return : ParserRuleReturnScope
	{
		public LogicalExpression value;

		private CommonTree tree;

		public override object Tree
		{
			get
			{
				return tree;
			}
			set
			{
				tree = (CommonTree)value;
			}
		}
	}

	public class booleanAndExpression_return : ParserRuleReturnScope
	{
		public LogicalExpression value;

		private CommonTree tree;

		public override object Tree
		{
			get
			{
				return tree;
			}
			set
			{
				tree = (CommonTree)value;
			}
		}
	}

	public class bitwiseOrExpression_return : ParserRuleReturnScope
	{
		public LogicalExpression value;

		private CommonTree tree;

		public override object Tree
		{
			get
			{
				return tree;
			}
			set
			{
				tree = (CommonTree)value;
			}
		}
	}

	public class bitwiseXOrExpression_return : ParserRuleReturnScope
	{
		public LogicalExpression value;

		private CommonTree tree;

		public override object Tree
		{
			get
			{
				return tree;
			}
			set
			{
				tree = (CommonTree)value;
			}
		}
	}

	public class bitwiseAndExpression_return : ParserRuleReturnScope
	{
		public LogicalExpression value;

		private CommonTree tree;

		public override object Tree
		{
			get
			{
				return tree;
			}
			set
			{
				tree = (CommonTree)value;
			}
		}
	}

	public class equalityExpression_return : ParserRuleReturnScope
	{
		public LogicalExpression value;

		private CommonTree tree;

		public override object Tree
		{
			get
			{
				return tree;
			}
			set
			{
				tree = (CommonTree)value;
			}
		}
	}

	public class relationalExpression_return : ParserRuleReturnScope
	{
		public LogicalExpression value;

		private CommonTree tree;

		public override object Tree
		{
			get
			{
				return tree;
			}
			set
			{
				tree = (CommonTree)value;
			}
		}
	}

	public class shiftExpression_return : ParserRuleReturnScope
	{
		public LogicalExpression value;

		private CommonTree tree;

		public override object Tree
		{
			get
			{
				return tree;
			}
			set
			{
				tree = (CommonTree)value;
			}
		}
	}

	public class additiveExpression_return : ParserRuleReturnScope
	{
		public LogicalExpression value;

		private CommonTree tree;

		public override object Tree
		{
			get
			{
				return tree;
			}
			set
			{
				tree = (CommonTree)value;
			}
		}
	}

	public class multiplicativeExpression_return : ParserRuleReturnScope
	{
		public LogicalExpression value;

		private CommonTree tree;

		public override object Tree
		{
			get
			{
				return tree;
			}
			set
			{
				tree = (CommonTree)value;
			}
		}
	}

	public class unaryExpression_return : ParserRuleReturnScope
	{
		public LogicalExpression value;

		private CommonTree tree;

		public override object Tree
		{
			get
			{
				return tree;
			}
			set
			{
				tree = (CommonTree)value;
			}
		}
	}

	public class primaryExpression_return : ParserRuleReturnScope
	{
		public LogicalExpression value;

		private CommonTree tree;

		public override object Tree
		{
			get
			{
				return tree;
			}
			set
			{
				tree = (CommonTree)value;
			}
		}
	}

	public class value_return : ParserRuleReturnScope
	{
		public ValueExpression value;

		private CommonTree tree;

		public override object Tree
		{
			get
			{
				return tree;
			}
			set
			{
				tree = (CommonTree)value;
			}
		}
	}

	public class identifier_return : ParserRuleReturnScope
	{
		public IdentifierExpression value;

		private CommonTree tree;

		public override object Tree
		{
			get
			{
				return tree;
			}
			set
			{
				tree = (CommonTree)value;
			}
		}
	}

	public class expressionList_return : ParserRuleReturnScope
	{
		public List<LogicalExpression> value;

		private CommonTree tree;

		public override object Tree
		{
			get
			{
				return tree;
			}
			set
			{
				tree = (CommonTree)value;
			}
		}
	}

	public class arguments_return : ParserRuleReturnScope
	{
		public List<LogicalExpression> value;

		private CommonTree tree;

		public override object Tree
		{
			get
			{
				return tree;
			}
			set
			{
				tree = (CommonTree)value;
			}
		}
	}

	protected ITreeAdaptor adaptor = new CommonTreeAdaptor();

	public const int T__29 = 29;

	public const int T__28 = 28;

	public const int T__27 = 27;

	public const int T__26 = 26;

	public const int T__25 = 25;

	public const int T__24 = 24;

	public const int T__23 = 23;

	public const int LETTER = 12;

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

	private const char BS = '\\';

	public static readonly string[] tokenNames = new string[49]
	{
		"<invalid>", "<EOR>", "<DOWN>", "<UP>", "INTEGER", "FLOAT", "STRING", "DATETIME", "TRUE", "FALSE",
		"ID", "NAME", "LETTER", "DIGIT", "E", "EscapeSequence", "UnicodeEscape", "HexDigit", "WS", "'?'",
		"':'", "'||'", "'or'", "'&&'", "'and'", "'|'", "'^'", "'&'", "'=='", "'='",
		"'!='", "'<>'", "'<'", "'<='", "'>'", "'>='", "'<<'", "'>>'", "'+'", "'-'",
		"'*'", "'/'", "'%'", "'!'", "'not'", "'~'", "'('", "')'", "','"
	};

	private static NumberFormatInfo numberFormatInfo = new NumberFormatInfo();

	public static readonly BitSet FOLLOW_logicalExpression_in_ncalcExpression56 = new BitSet(new ulong[1]);

	public static readonly BitSet FOLLOW_EOF_in_ncalcExpression58 = new BitSet(new ulong[1] { 2uL });

	public static readonly BitSet FOLLOW_conditionalExpression_in_logicalExpression78 = new BitSet(new ulong[1] { 524290uL });

	public static readonly BitSet FOLLOW_19_in_logicalExpression84 = new BitSet(new ulong[1] { 132491151151088uL });

	public static readonly BitSet FOLLOW_conditionalExpression_in_logicalExpression88 = new BitSet(new ulong[1] { 1048576uL });

	public static readonly BitSet FOLLOW_20_in_logicalExpression90 = new BitSet(new ulong[1] { 132491151151088uL });

	public static readonly BitSet FOLLOW_conditionalExpression_in_logicalExpression94 = new BitSet(new ulong[1] { 2uL });

	public static readonly BitSet FOLLOW_booleanAndExpression_in_conditionalExpression121 = new BitSet(new ulong[1] { 6291458uL });

	public static readonly BitSet FOLLOW_set_in_conditionalExpression130 = new BitSet(new ulong[1] { 132491151151088uL });

	public static readonly BitSet FOLLOW_conditionalExpression_in_conditionalExpression146 = new BitSet(new ulong[1] { 6291458uL });

	public static readonly BitSet FOLLOW_bitwiseOrExpression_in_booleanAndExpression180 = new BitSet(new ulong[1] { 25165826uL });

	public static readonly BitSet FOLLOW_set_in_booleanAndExpression189 = new BitSet(new ulong[1] { 132491151151088uL });

	public static readonly BitSet FOLLOW_bitwiseOrExpression_in_booleanAndExpression205 = new BitSet(new ulong[1] { 25165826uL });

	public static readonly BitSet FOLLOW_bitwiseXOrExpression_in_bitwiseOrExpression237 = new BitSet(new ulong[1] { 33554434uL });

	public static readonly BitSet FOLLOW_25_in_bitwiseOrExpression246 = new BitSet(new ulong[1] { 132491151151088uL });

	public static readonly BitSet FOLLOW_bitwiseOrExpression_in_bitwiseOrExpression256 = new BitSet(new ulong[1] { 33554434uL });

	public static readonly BitSet FOLLOW_bitwiseAndExpression_in_bitwiseXOrExpression290 = new BitSet(new ulong[1] { 67108866uL });

	public static readonly BitSet FOLLOW_26_in_bitwiseXOrExpression299 = new BitSet(new ulong[1] { 132491151151088uL });

	public static readonly BitSet FOLLOW_bitwiseAndExpression_in_bitwiseXOrExpression309 = new BitSet(new ulong[1] { 67108866uL });

	public static readonly BitSet FOLLOW_equalityExpression_in_bitwiseAndExpression341 = new BitSet(new ulong[1] { 134217730uL });

	public static readonly BitSet FOLLOW_27_in_bitwiseAndExpression350 = new BitSet(new ulong[1] { 132491151151088uL });

	public static readonly BitSet FOLLOW_equalityExpression_in_bitwiseAndExpression360 = new BitSet(new ulong[1] { 134217730uL });

	public static readonly BitSet FOLLOW_relationalExpression_in_equalityExpression394 = new BitSet(new ulong[1] { 4026531842uL });

	public static readonly BitSet FOLLOW_set_in_equalityExpression405 = new BitSet(new ulong[1] { 132491151151088uL });

	public static readonly BitSet FOLLOW_set_in_equalityExpression422 = new BitSet(new ulong[1] { 132491151151088uL });

	public static readonly BitSet FOLLOW_relationalExpression_in_equalityExpression441 = new BitSet(new ulong[1] { 4026531842uL });

	public static readonly BitSet FOLLOW_shiftExpression_in_relationalExpression474 = new BitSet(new ulong[1] { 64424509442uL });

	public static readonly BitSet FOLLOW_32_in_relationalExpression485 = new BitSet(new ulong[1] { 132491151151088uL });

	public static readonly BitSet FOLLOW_33_in_relationalExpression495 = new BitSet(new ulong[1] { 132491151151088uL });

	public static readonly BitSet FOLLOW_34_in_relationalExpression506 = new BitSet(new ulong[1] { 132491151151088uL });

	public static readonly BitSet FOLLOW_35_in_relationalExpression516 = new BitSet(new ulong[1] { 132491151151088uL });

	public static readonly BitSet FOLLOW_shiftExpression_in_relationalExpression528 = new BitSet(new ulong[1] { 64424509442uL });

	public static readonly BitSet FOLLOW_additiveExpression_in_shiftExpression560 = new BitSet(new ulong[1] { 206158430210uL });

	public static readonly BitSet FOLLOW_36_in_shiftExpression571 = new BitSet(new ulong[1] { 132491151151088uL });

	public static readonly BitSet FOLLOW_37_in_shiftExpression581 = new BitSet(new ulong[1] { 132491151151088uL });

	public static readonly BitSet FOLLOW_additiveExpression_in_shiftExpression593 = new BitSet(new ulong[1] { 206158430210uL });

	public static readonly BitSet FOLLOW_multiplicativeExpression_in_additiveExpression625 = new BitSet(new ulong[1] { 824633720834uL });

	public static readonly BitSet FOLLOW_38_in_additiveExpression636 = new BitSet(new ulong[1] { 132491151151088uL });

	public static readonly BitSet FOLLOW_39_in_additiveExpression646 = new BitSet(new ulong[1] { 132491151151088uL });

	public static readonly BitSet FOLLOW_multiplicativeExpression_in_additiveExpression658 = new BitSet(new ulong[1] { 824633720834uL });

	public static readonly BitSet FOLLOW_unaryExpression_in_multiplicativeExpression690 = new BitSet(new ulong[1] { 7696581394434uL });

	public static readonly BitSet FOLLOW_40_in_multiplicativeExpression701 = new BitSet(new ulong[1] { 132491151151088uL });

	public static readonly BitSet FOLLOW_41_in_multiplicativeExpression711 = new BitSet(new ulong[1] { 132491151151088uL });

	public static readonly BitSet FOLLOW_42_in_multiplicativeExpression721 = new BitSet(new ulong[1] { 132491151151088uL });

	public static readonly BitSet FOLLOW_unaryExpression_in_multiplicativeExpression733 = new BitSet(new ulong[1] { 7696581394434uL });

	public static readonly BitSet FOLLOW_primaryExpression_in_unaryExpression760 = new BitSet(new ulong[1] { 2uL });

	public static readonly BitSet FOLLOW_set_in_unaryExpression771 = new BitSet(new ulong[1] { 70368744181744uL });

	public static readonly BitSet FOLLOW_primaryExpression_in_unaryExpression779 = new BitSet(new ulong[1] { 2uL });

	public static readonly BitSet FOLLOW_45_in_unaryExpression791 = new BitSet(new ulong[1] { 70368744181744uL });

	public static readonly BitSet FOLLOW_primaryExpression_in_unaryExpression794 = new BitSet(new ulong[1] { 2uL });

	public static readonly BitSet FOLLOW_39_in_unaryExpression805 = new BitSet(new ulong[1] { 70368744181744uL });

	public static readonly BitSet FOLLOW_primaryExpression_in_unaryExpression807 = new BitSet(new ulong[1] { 2uL });

	public static readonly BitSet FOLLOW_46_in_primaryExpression829 = new BitSet(new ulong[1] { 132491151151088uL });

	public static readonly BitSet FOLLOW_logicalExpression_in_primaryExpression831 = new BitSet(new ulong[1] { 140737488355328uL });

	public static readonly BitSet FOLLOW_47_in_primaryExpression833 = new BitSet(new ulong[1] { 2uL });

	public static readonly BitSet FOLLOW_value_in_primaryExpression843 = new BitSet(new ulong[1] { 2uL });

	public static readonly BitSet FOLLOW_identifier_in_primaryExpression851 = new BitSet(new ulong[1] { 70368744177666uL });

	public static readonly BitSet FOLLOW_arguments_in_primaryExpression856 = new BitSet(new ulong[1] { 2uL });

	public static readonly BitSet FOLLOW_INTEGER_in_value876 = new BitSet(new ulong[1] { 2uL });

	public static readonly BitSet FOLLOW_FLOAT_in_value884 = new BitSet(new ulong[1] { 2uL });

	public static readonly BitSet FOLLOW_STRING_in_value892 = new BitSet(new ulong[1] { 2uL });

	public static readonly BitSet FOLLOW_DATETIME_in_value901 = new BitSet(new ulong[1] { 2uL });

	public static readonly BitSet FOLLOW_TRUE_in_value908 = new BitSet(new ulong[1] { 2uL });

	public static readonly BitSet FOLLOW_FALSE_in_value916 = new BitSet(new ulong[1] { 2uL });

	public static readonly BitSet FOLLOW_ID_in_identifier934 = new BitSet(new ulong[1] { 2uL });

	public static readonly BitSet FOLLOW_NAME_in_identifier942 = new BitSet(new ulong[1] { 2uL });

	public static readonly BitSet FOLLOW_logicalExpression_in_expressionList966 = new BitSet(new ulong[1] { 281474976710658uL });

	public static readonly BitSet FOLLOW_48_in_expressionList973 = new BitSet(new ulong[1] { 132491151151088uL });

	public static readonly BitSet FOLLOW_logicalExpression_in_expressionList977 = new BitSet(new ulong[1] { 281474976710658uL });

	public static readonly BitSet FOLLOW_46_in_arguments1006 = new BitSet(new ulong[1] { 273228639506416uL });

	public static readonly BitSet FOLLOW_expressionList_in_arguments1010 = new BitSet(new ulong[1] { 140737488355328uL });

	public static readonly BitSet FOLLOW_47_in_arguments1017 = new BitSet(new ulong[1] { 2uL });

	public ITreeAdaptor TreeAdaptor
	{
		get
		{
			return adaptor;
		}
		set
		{
			adaptor = value;
		}
	}

	public override string[] TokenNames => tokenNames;

	public override string GrammarFileName => "C:\\Users\\s.ros\\Documents\\D\ufffdveloppement\\NCalc\\Grammar\\NCalc.g";

	public List<string> Errors { get; private set; }

	public NCalcParser(ITokenStream input)
		: this(input, new RecognizerSharedState())
	{
	}

	public NCalcParser(ITokenStream input, RecognizerSharedState state)
		: base(input, state)
	{
		InitializeCyclicDFAs();
	}

	private void InitializeCyclicDFAs()
	{
	}

	private string extractString(string text)
	{
		StringBuilder stringBuilder = new StringBuilder(text);
		int startIndex = 1;
		int num = -1;
		while ((num = stringBuilder.ToString().IndexOf('\\', startIndex)) != -1)
		{
			char c = stringBuilder[num + 1];
			switch (c)
			{
			case 'u':
			{
				string text2 = string.Concat(stringBuilder[num + 4], stringBuilder[num + 5]);
				string text3 = string.Concat(stringBuilder[num + 2], stringBuilder[num + 3]);
				char c2 = Encoding.Unicode.GetChars(new byte[2]
				{
					Convert.ToByte(text2, 16),
					Convert.ToByte(text3, 16)
				})[0];
				stringBuilder.Remove(num, 6).Insert(num, c2);
				break;
			}
			case 'n':
				stringBuilder.Remove(num, 2).Insert(num, '\n');
				break;
			case 'r':
				stringBuilder.Remove(num, 2).Insert(num, '\r');
				break;
			case 't':
				stringBuilder.Remove(num, 2).Insert(num, '\t');
				break;
			case '\'':
				stringBuilder.Remove(num, 2).Insert(num, '\'');
				break;
			case '\\':
				stringBuilder.Remove(num, 2).Insert(num, '\\');
				break;
			default:
				throw new RecognitionException("Unvalid escape sequence: \\" + c);
			}
			startIndex = num + 1;
		}
		stringBuilder.Remove(0, 1);
		stringBuilder.Remove(stringBuilder.Length - 1, 1);
		return stringBuilder.ToString();
	}

	public override void DisplayRecognitionError(string[] tokenNames, RecognitionException e)
	{
		base.DisplayRecognitionError(tokenNames, e);
		if (Errors == null)
		{
			Errors = new List<string>();
		}
		string errorHeader = GetErrorHeader(e);
		string errorMessage = GetErrorMessage(e, tokenNames);
		Errors.Add(errorMessage + " at " + errorHeader);
	}

	public ncalcExpression_return ncalcExpression()
	{
		ncalcExpression_return ncalcExpression_return2 = new ncalcExpression_return();
		ncalcExpression_return2.Start = input.LT(1);
		CommonTree commonTree = null;
		logicalExpression_return logicalExpression_return2 = null;
		try
		{
			commonTree = (CommonTree)adaptor.GetNilNode();
			PushFollow(FOLLOW_logicalExpression_in_ncalcExpression56);
			logicalExpression_return2 = logicalExpression();
			state.followingStackPointer--;
			adaptor.AddChild(commonTree, logicalExpression_return2.Tree);
			_ = (IToken)Match(input, -1, FOLLOW_EOF_in_ncalcExpression58);
			ncalcExpression_return2.value = logicalExpression_return2?.value;
			ncalcExpression_return2.Stop = input.LT(-1);
			ncalcExpression_return2.Tree = (CommonTree)adaptor.RulePostProcessing(commonTree);
			adaptor.SetTokenBoundaries(ncalcExpression_return2.Tree, (IToken)ncalcExpression_return2.Start, (IToken)ncalcExpression_return2.Stop);
		}
		catch (RecognitionException ex)
		{
			ReportError(ex);
			Recover(input, ex);
			ncalcExpression_return2.Tree = (CommonTree)adaptor.ErrorNode(input, (IToken)ncalcExpression_return2.Start, input.LT(-1), ex);
		}
		return ncalcExpression_return2;
	}

	public logicalExpression_return logicalExpression()
	{
		logicalExpression_return logicalExpression_return2 = new logicalExpression_return();
		logicalExpression_return2.Start = input.LT(1);
		CommonTree commonTree = null;
		IToken token = null;
		IToken token2 = null;
		conditionalExpression_return conditionalExpression_return2 = null;
		conditionalExpression_return conditionalExpression_return3 = null;
		conditionalExpression_return conditionalExpression_return4 = null;
		CommonTree commonTree2 = null;
		CommonTree commonTree3 = null;
		try
		{
			commonTree = (CommonTree)adaptor.GetNilNode();
			PushFollow(FOLLOW_conditionalExpression_in_logicalExpression78);
			conditionalExpression_return2 = conditionalExpression();
			state.followingStackPointer--;
			adaptor.AddChild(commonTree, conditionalExpression_return2.Tree);
			logicalExpression_return2.value = conditionalExpression_return2?.value;
			int num = 2;
			if (input.LA(1) == 19)
			{
				num = 1;
			}
			if (num == 1)
			{
				token = (IToken)Match(input, 19, FOLLOW_19_in_logicalExpression84);
				commonTree2 = (CommonTree)adaptor.Create(token);
				adaptor.AddChild(commonTree, commonTree2);
				PushFollow(FOLLOW_conditionalExpression_in_logicalExpression88);
				conditionalExpression_return3 = conditionalExpression();
				state.followingStackPointer--;
				adaptor.AddChild(commonTree, conditionalExpression_return3.Tree);
				token2 = (IToken)Match(input, 20, FOLLOW_20_in_logicalExpression90);
				commonTree3 = (CommonTree)adaptor.Create(token2);
				adaptor.AddChild(commonTree, commonTree3);
				PushFollow(FOLLOW_conditionalExpression_in_logicalExpression94);
				conditionalExpression_return4 = conditionalExpression();
				state.followingStackPointer--;
				adaptor.AddChild(commonTree, conditionalExpression_return4.Tree);
				logicalExpression_return2.value = new TernaryExpression(conditionalExpression_return2?.value, conditionalExpression_return3?.value, conditionalExpression_return4?.value);
			}
			logicalExpression_return2.Stop = input.LT(-1);
			logicalExpression_return2.Tree = (CommonTree)adaptor.RulePostProcessing(commonTree);
			adaptor.SetTokenBoundaries(logicalExpression_return2.Tree, (IToken)logicalExpression_return2.Start, (IToken)logicalExpression_return2.Stop);
		}
		catch (RecognitionException ex)
		{
			ReportError(ex);
			Recover(input, ex);
			logicalExpression_return2.Tree = (CommonTree)adaptor.ErrorNode(input, (IToken)logicalExpression_return2.Start, input.LT(-1), ex);
		}
		return logicalExpression_return2;
	}

	public conditionalExpression_return conditionalExpression()
	{
		conditionalExpression_return conditionalExpression_return2 = new conditionalExpression_return();
		conditionalExpression_return2.Start = input.LT(1);
		CommonTree commonTree = null;
		IToken token = null;
		booleanAndExpression_return booleanAndExpression_return2 = null;
		conditionalExpression_return conditionalExpression_return3 = null;
		BinaryExpressionType binaryExpressionType = BinaryExpressionType.Unknown;
		try
		{
			commonTree = (CommonTree)adaptor.GetNilNode();
			PushFollow(FOLLOW_booleanAndExpression_in_conditionalExpression121);
			booleanAndExpression_return2 = booleanAndExpression();
			state.followingStackPointer--;
			adaptor.AddChild(commonTree, booleanAndExpression_return2.Tree);
			conditionalExpression_return2.value = booleanAndExpression_return2?.value;
			while (true)
			{
				int num = 2;
				int num2 = input.LA(1);
				if (num2 >= 21 && num2 <= 22)
				{
					num = 1;
				}
				if (num != 1)
				{
					break;
				}
				token = input.LT(1);
				if (input.LA(1) >= 21 && input.LA(1) <= 22)
				{
					input.Consume();
					adaptor.AddChild(commonTree, (CommonTree)adaptor.Create(token));
					state.errorRecovery = false;
					binaryExpressionType = BinaryExpressionType.Or;
					PushFollow(FOLLOW_conditionalExpression_in_conditionalExpression146);
					conditionalExpression_return3 = conditionalExpression();
					state.followingStackPointer--;
					adaptor.AddChild(commonTree, conditionalExpression_return3.Tree);
					conditionalExpression_return2.value = new BinaryExpression(binaryExpressionType, conditionalExpression_return2.value, conditionalExpression_return3?.value);
					continue;
				}
				throw new MismatchedSetException(null, input);
			}
			conditionalExpression_return2.Stop = input.LT(-1);
			conditionalExpression_return2.Tree = (CommonTree)adaptor.RulePostProcessing(commonTree);
			adaptor.SetTokenBoundaries(conditionalExpression_return2.Tree, (IToken)conditionalExpression_return2.Start, (IToken)conditionalExpression_return2.Stop);
		}
		catch (RecognitionException ex)
		{
			ReportError(ex);
			Recover(input, ex);
			conditionalExpression_return2.Tree = (CommonTree)adaptor.ErrorNode(input, (IToken)conditionalExpression_return2.Start, input.LT(-1), ex);
		}
		return conditionalExpression_return2;
	}

	public booleanAndExpression_return booleanAndExpression()
	{
		booleanAndExpression_return booleanAndExpression_return2 = new booleanAndExpression_return();
		booleanAndExpression_return2.Start = input.LT(1);
		CommonTree commonTree = null;
		IToken token = null;
		bitwiseOrExpression_return bitwiseOrExpression_return2 = null;
		bitwiseOrExpression_return bitwiseOrExpression_return3 = null;
		BinaryExpressionType binaryExpressionType = BinaryExpressionType.Unknown;
		try
		{
			commonTree = (CommonTree)adaptor.GetNilNode();
			PushFollow(FOLLOW_bitwiseOrExpression_in_booleanAndExpression180);
			bitwiseOrExpression_return2 = bitwiseOrExpression();
			state.followingStackPointer--;
			adaptor.AddChild(commonTree, bitwiseOrExpression_return2.Tree);
			booleanAndExpression_return2.value = bitwiseOrExpression_return2?.value;
			while (true)
			{
				int num = 2;
				int num2 = input.LA(1);
				if (num2 >= 23 && num2 <= 24)
				{
					num = 1;
				}
				if (num != 1)
				{
					break;
				}
				token = input.LT(1);
				if (input.LA(1) >= 23 && input.LA(1) <= 24)
				{
					input.Consume();
					adaptor.AddChild(commonTree, (CommonTree)adaptor.Create(token));
					state.errorRecovery = false;
					binaryExpressionType = BinaryExpressionType.And;
					PushFollow(FOLLOW_bitwiseOrExpression_in_booleanAndExpression205);
					bitwiseOrExpression_return3 = bitwiseOrExpression();
					state.followingStackPointer--;
					adaptor.AddChild(commonTree, bitwiseOrExpression_return3.Tree);
					booleanAndExpression_return2.value = new BinaryExpression(binaryExpressionType, booleanAndExpression_return2.value, bitwiseOrExpression_return3?.value);
					continue;
				}
				throw new MismatchedSetException(null, input);
			}
			booleanAndExpression_return2.Stop = input.LT(-1);
			booleanAndExpression_return2.Tree = (CommonTree)adaptor.RulePostProcessing(commonTree);
			adaptor.SetTokenBoundaries(booleanAndExpression_return2.Tree, (IToken)booleanAndExpression_return2.Start, (IToken)booleanAndExpression_return2.Stop);
		}
		catch (RecognitionException ex)
		{
			ReportError(ex);
			Recover(input, ex);
			booleanAndExpression_return2.Tree = (CommonTree)adaptor.ErrorNode(input, (IToken)booleanAndExpression_return2.Start, input.LT(-1), ex);
		}
		return booleanAndExpression_return2;
	}

	public bitwiseOrExpression_return bitwiseOrExpression()
	{
		bitwiseOrExpression_return bitwiseOrExpression_return2 = new bitwiseOrExpression_return();
		bitwiseOrExpression_return2.Start = input.LT(1);
		CommonTree commonTree = null;
		IToken token = null;
		bitwiseXOrExpression_return bitwiseXOrExpression_return2 = null;
		bitwiseOrExpression_return bitwiseOrExpression_return3 = null;
		CommonTree commonTree2 = null;
		BinaryExpressionType binaryExpressionType = BinaryExpressionType.Unknown;
		try
		{
			commonTree = (CommonTree)adaptor.GetNilNode();
			PushFollow(FOLLOW_bitwiseXOrExpression_in_bitwiseOrExpression237);
			bitwiseXOrExpression_return2 = bitwiseXOrExpression();
			state.followingStackPointer--;
			adaptor.AddChild(commonTree, bitwiseXOrExpression_return2.Tree);
			bitwiseOrExpression_return2.value = bitwiseXOrExpression_return2?.value;
			while (true)
			{
				int num = 2;
				if (input.LA(1) == 25)
				{
					num = 1;
				}
				if (num != 1)
				{
					break;
				}
				token = (IToken)Match(input, 25, FOLLOW_25_in_bitwiseOrExpression246);
				commonTree2 = (CommonTree)adaptor.Create(token);
				adaptor.AddChild(commonTree, commonTree2);
				binaryExpressionType = BinaryExpressionType.BitwiseOr;
				PushFollow(FOLLOW_bitwiseOrExpression_in_bitwiseOrExpression256);
				bitwiseOrExpression_return3 = bitwiseOrExpression();
				state.followingStackPointer--;
				adaptor.AddChild(commonTree, bitwiseOrExpression_return3.Tree);
				bitwiseOrExpression_return2.value = new BinaryExpression(binaryExpressionType, bitwiseOrExpression_return2.value, bitwiseOrExpression_return3?.value);
			}
			bitwiseOrExpression_return2.Stop = input.LT(-1);
			bitwiseOrExpression_return2.Tree = (CommonTree)adaptor.RulePostProcessing(commonTree);
			adaptor.SetTokenBoundaries(bitwiseOrExpression_return2.Tree, (IToken)bitwiseOrExpression_return2.Start, (IToken)bitwiseOrExpression_return2.Stop);
		}
		catch (RecognitionException ex)
		{
			ReportError(ex);
			Recover(input, ex);
			bitwiseOrExpression_return2.Tree = (CommonTree)adaptor.ErrorNode(input, (IToken)bitwiseOrExpression_return2.Start, input.LT(-1), ex);
		}
		return bitwiseOrExpression_return2;
	}

	public bitwiseXOrExpression_return bitwiseXOrExpression()
	{
		bitwiseXOrExpression_return bitwiseXOrExpression_return2 = new bitwiseXOrExpression_return();
		bitwiseXOrExpression_return2.Start = input.LT(1);
		CommonTree commonTree = null;
		IToken token = null;
		bitwiseAndExpression_return bitwiseAndExpression_return2 = null;
		bitwiseAndExpression_return bitwiseAndExpression_return3 = null;
		CommonTree commonTree2 = null;
		BinaryExpressionType binaryExpressionType = BinaryExpressionType.Unknown;
		try
		{
			commonTree = (CommonTree)adaptor.GetNilNode();
			PushFollow(FOLLOW_bitwiseAndExpression_in_bitwiseXOrExpression290);
			bitwiseAndExpression_return2 = bitwiseAndExpression();
			state.followingStackPointer--;
			adaptor.AddChild(commonTree, bitwiseAndExpression_return2.Tree);
			bitwiseXOrExpression_return2.value = bitwiseAndExpression_return2?.value;
			while (true)
			{
				int num = 2;
				if (input.LA(1) == 26)
				{
					num = 1;
				}
				if (num != 1)
				{
					break;
				}
				token = (IToken)Match(input, 26, FOLLOW_26_in_bitwiseXOrExpression299);
				commonTree2 = (CommonTree)adaptor.Create(token);
				adaptor.AddChild(commonTree, commonTree2);
				binaryExpressionType = BinaryExpressionType.BitwiseXOr;
				PushFollow(FOLLOW_bitwiseAndExpression_in_bitwiseXOrExpression309);
				bitwiseAndExpression_return3 = bitwiseAndExpression();
				state.followingStackPointer--;
				adaptor.AddChild(commonTree, bitwiseAndExpression_return3.Tree);
				bitwiseXOrExpression_return2.value = new BinaryExpression(binaryExpressionType, bitwiseXOrExpression_return2.value, bitwiseAndExpression_return3?.value);
			}
			bitwiseXOrExpression_return2.Stop = input.LT(-1);
			bitwiseXOrExpression_return2.Tree = (CommonTree)adaptor.RulePostProcessing(commonTree);
			adaptor.SetTokenBoundaries(bitwiseXOrExpression_return2.Tree, (IToken)bitwiseXOrExpression_return2.Start, (IToken)bitwiseXOrExpression_return2.Stop);
		}
		catch (RecognitionException ex)
		{
			ReportError(ex);
			Recover(input, ex);
			bitwiseXOrExpression_return2.Tree = (CommonTree)adaptor.ErrorNode(input, (IToken)bitwiseXOrExpression_return2.Start, input.LT(-1), ex);
		}
		return bitwiseXOrExpression_return2;
	}

	public bitwiseAndExpression_return bitwiseAndExpression()
	{
		bitwiseAndExpression_return bitwiseAndExpression_return2 = new bitwiseAndExpression_return();
		bitwiseAndExpression_return2.Start = input.LT(1);
		CommonTree commonTree = null;
		IToken token = null;
		equalityExpression_return equalityExpression_return2 = null;
		equalityExpression_return equalityExpression_return3 = null;
		CommonTree commonTree2 = null;
		BinaryExpressionType binaryExpressionType = BinaryExpressionType.Unknown;
		try
		{
			commonTree = (CommonTree)adaptor.GetNilNode();
			PushFollow(FOLLOW_equalityExpression_in_bitwiseAndExpression341);
			equalityExpression_return2 = equalityExpression();
			state.followingStackPointer--;
			adaptor.AddChild(commonTree, equalityExpression_return2.Tree);
			bitwiseAndExpression_return2.value = equalityExpression_return2?.value;
			while (true)
			{
				int num = 2;
				if (input.LA(1) == 27)
				{
					num = 1;
				}
				if (num != 1)
				{
					break;
				}
				token = (IToken)Match(input, 27, FOLLOW_27_in_bitwiseAndExpression350);
				commonTree2 = (CommonTree)adaptor.Create(token);
				adaptor.AddChild(commonTree, commonTree2);
				binaryExpressionType = BinaryExpressionType.BitwiseAnd;
				PushFollow(FOLLOW_equalityExpression_in_bitwiseAndExpression360);
				equalityExpression_return3 = equalityExpression();
				state.followingStackPointer--;
				adaptor.AddChild(commonTree, equalityExpression_return3.Tree);
				bitwiseAndExpression_return2.value = new BinaryExpression(binaryExpressionType, bitwiseAndExpression_return2.value, equalityExpression_return3?.value);
			}
			bitwiseAndExpression_return2.Stop = input.LT(-1);
			bitwiseAndExpression_return2.Tree = (CommonTree)adaptor.RulePostProcessing(commonTree);
			adaptor.SetTokenBoundaries(bitwiseAndExpression_return2.Tree, (IToken)bitwiseAndExpression_return2.Start, (IToken)bitwiseAndExpression_return2.Stop);
		}
		catch (RecognitionException ex)
		{
			ReportError(ex);
			Recover(input, ex);
			bitwiseAndExpression_return2.Tree = (CommonTree)adaptor.ErrorNode(input, (IToken)bitwiseAndExpression_return2.Start, input.LT(-1), ex);
		}
		return bitwiseAndExpression_return2;
	}

	public equalityExpression_return equalityExpression()
	{
		equalityExpression_return equalityExpression_return2 = new equalityExpression_return();
		equalityExpression_return2.Start = input.LT(1);
		CommonTree commonTree = null;
		IToken token = null;
		IToken token2 = null;
		relationalExpression_return relationalExpression_return2 = null;
		relationalExpression_return relationalExpression_return3 = null;
		BinaryExpressionType type = BinaryExpressionType.Unknown;
		try
		{
			commonTree = (CommonTree)adaptor.GetNilNode();
			PushFollow(FOLLOW_relationalExpression_in_equalityExpression394);
			relationalExpression_return2 = relationalExpression();
			state.followingStackPointer--;
			adaptor.AddChild(commonTree, relationalExpression_return2.Tree);
			equalityExpression_return2.value = relationalExpression_return2?.value;
			while (true)
			{
				int num = 2;
				int num2 = input.LA(1);
				if (num2 >= 28 && num2 <= 31)
				{
					num = 1;
				}
				if (num != 1)
				{
					break;
				}
				int num3 = 2;
				int num4 = input.LA(1);
				if (num4 >= 28 && num4 <= 29)
				{
					num3 = 1;
				}
				else
				{
					if (num4 < 30 || num4 > 31)
					{
						throw new NoViableAltException("", 7, 0, input);
					}
					num3 = 2;
				}
				switch (num3)
				{
				case 1:
					token = input.LT(1);
					if (input.LA(1) >= 28 && input.LA(1) <= 29)
					{
						input.Consume();
						adaptor.AddChild(commonTree, (CommonTree)adaptor.Create(token));
						state.errorRecovery = false;
						type = BinaryExpressionType.Equal;
						break;
					}
					throw new MismatchedSetException(null, input);
				case 2:
					token2 = input.LT(1);
					if (input.LA(1) >= 30 && input.LA(1) <= 31)
					{
						input.Consume();
						adaptor.AddChild(commonTree, (CommonTree)adaptor.Create(token2));
						state.errorRecovery = false;
						type = BinaryExpressionType.NotEqual;
						break;
					}
					throw new MismatchedSetException(null, input);
				}
				PushFollow(FOLLOW_relationalExpression_in_equalityExpression441);
				relationalExpression_return3 = relationalExpression();
				state.followingStackPointer--;
				adaptor.AddChild(commonTree, relationalExpression_return3.Tree);
				equalityExpression_return2.value = new BinaryExpression(type, equalityExpression_return2.value, relationalExpression_return3?.value);
			}
			equalityExpression_return2.Stop = input.LT(-1);
			equalityExpression_return2.Tree = (CommonTree)adaptor.RulePostProcessing(commonTree);
			adaptor.SetTokenBoundaries(equalityExpression_return2.Tree, (IToken)equalityExpression_return2.Start, (IToken)equalityExpression_return2.Stop);
		}
		catch (RecognitionException ex)
		{
			ReportError(ex);
			Recover(input, ex);
			equalityExpression_return2.Tree = (CommonTree)adaptor.ErrorNode(input, (IToken)equalityExpression_return2.Start, input.LT(-1), ex);
		}
		return equalityExpression_return2;
	}

	public relationalExpression_return relationalExpression()
	{
		relationalExpression_return relationalExpression_return2 = new relationalExpression_return();
		relationalExpression_return2.Start = input.LT(1);
		CommonTree commonTree = null;
		IToken token = null;
		IToken token2 = null;
		IToken token3 = null;
		IToken token4 = null;
		shiftExpression_return shiftExpression_return2 = null;
		shiftExpression_return shiftExpression_return3 = null;
		CommonTree commonTree2 = null;
		CommonTree commonTree3 = null;
		CommonTree commonTree4 = null;
		CommonTree commonTree5 = null;
		BinaryExpressionType type = BinaryExpressionType.Unknown;
		try
		{
			commonTree = (CommonTree)adaptor.GetNilNode();
			PushFollow(FOLLOW_shiftExpression_in_relationalExpression474);
			shiftExpression_return2 = shiftExpression();
			state.followingStackPointer--;
			adaptor.AddChild(commonTree, shiftExpression_return2.Tree);
			relationalExpression_return2.value = shiftExpression_return2?.value;
			while (true)
			{
				int num = 2;
				int num2 = input.LA(1);
				if (num2 >= 32 && num2 <= 35)
				{
					num = 1;
				}
				if (num != 1)
				{
					break;
				}
				int num3 = 4;
				switch (input.LA(1) switch
				{
					32 => 1, 
					33 => 2, 
					34 => 3, 
					35 => 4, 
					_ => throw new NoViableAltException("", 9, 0, input), 
				})
				{
				case 1:
					token = (IToken)Match(input, 32, FOLLOW_32_in_relationalExpression485);
					commonTree2 = (CommonTree)adaptor.Create(token);
					adaptor.AddChild(commonTree, commonTree2);
					type = BinaryExpressionType.Lesser;
					break;
				case 2:
					token2 = (IToken)Match(input, 33, FOLLOW_33_in_relationalExpression495);
					commonTree3 = (CommonTree)adaptor.Create(token2);
					adaptor.AddChild(commonTree, commonTree3);
					type = BinaryExpressionType.LesserOrEqual;
					break;
				case 3:
					token3 = (IToken)Match(input, 34, FOLLOW_34_in_relationalExpression506);
					commonTree4 = (CommonTree)adaptor.Create(token3);
					adaptor.AddChild(commonTree, commonTree4);
					type = BinaryExpressionType.Greater;
					break;
				case 4:
					token4 = (IToken)Match(input, 35, FOLLOW_35_in_relationalExpression516);
					commonTree5 = (CommonTree)adaptor.Create(token4);
					adaptor.AddChild(commonTree, commonTree5);
					type = BinaryExpressionType.GreaterOrEqual;
					break;
				}
				PushFollow(FOLLOW_shiftExpression_in_relationalExpression528);
				shiftExpression_return3 = shiftExpression();
				state.followingStackPointer--;
				adaptor.AddChild(commonTree, shiftExpression_return3.Tree);
				relationalExpression_return2.value = new BinaryExpression(type, relationalExpression_return2.value, shiftExpression_return3?.value);
			}
			relationalExpression_return2.Stop = input.LT(-1);
			relationalExpression_return2.Tree = (CommonTree)adaptor.RulePostProcessing(commonTree);
			adaptor.SetTokenBoundaries(relationalExpression_return2.Tree, (IToken)relationalExpression_return2.Start, (IToken)relationalExpression_return2.Stop);
		}
		catch (RecognitionException ex)
		{
			ReportError(ex);
			Recover(input, ex);
			relationalExpression_return2.Tree = (CommonTree)adaptor.ErrorNode(input, (IToken)relationalExpression_return2.Start, input.LT(-1), ex);
		}
		return relationalExpression_return2;
	}

	public shiftExpression_return shiftExpression()
	{
		shiftExpression_return shiftExpression_return2 = new shiftExpression_return();
		shiftExpression_return2.Start = input.LT(1);
		CommonTree commonTree = null;
		IToken token = null;
		IToken token2 = null;
		additiveExpression_return additiveExpression_return2 = null;
		additiveExpression_return additiveExpression_return3 = null;
		CommonTree commonTree2 = null;
		CommonTree commonTree3 = null;
		BinaryExpressionType type = BinaryExpressionType.Unknown;
		try
		{
			commonTree = (CommonTree)adaptor.GetNilNode();
			PushFollow(FOLLOW_additiveExpression_in_shiftExpression560);
			additiveExpression_return2 = additiveExpression();
			state.followingStackPointer--;
			adaptor.AddChild(commonTree, additiveExpression_return2.Tree);
			shiftExpression_return2.value = additiveExpression_return2?.value;
			while (true)
			{
				int num = 2;
				int num2 = input.LA(1);
				if (num2 >= 36 && num2 <= 37)
				{
					num = 1;
				}
				if (num != 1)
				{
					break;
				}
				int num3 = 2;
				switch (input.LA(1) switch
				{
					36 => 1, 
					37 => 2, 
					_ => throw new NoViableAltException("", 11, 0, input), 
				})
				{
				case 1:
					token = (IToken)Match(input, 36, FOLLOW_36_in_shiftExpression571);
					commonTree2 = (CommonTree)adaptor.Create(token);
					adaptor.AddChild(commonTree, commonTree2);
					type = BinaryExpressionType.LeftShift;
					break;
				case 2:
					token2 = (IToken)Match(input, 37, FOLLOW_37_in_shiftExpression581);
					commonTree3 = (CommonTree)adaptor.Create(token2);
					adaptor.AddChild(commonTree, commonTree3);
					type = BinaryExpressionType.RightShift;
					break;
				}
				PushFollow(FOLLOW_additiveExpression_in_shiftExpression593);
				additiveExpression_return3 = additiveExpression();
				state.followingStackPointer--;
				adaptor.AddChild(commonTree, additiveExpression_return3.Tree);
				shiftExpression_return2.value = new BinaryExpression(type, shiftExpression_return2.value, additiveExpression_return3?.value);
			}
			shiftExpression_return2.Stop = input.LT(-1);
			shiftExpression_return2.Tree = (CommonTree)adaptor.RulePostProcessing(commonTree);
			adaptor.SetTokenBoundaries(shiftExpression_return2.Tree, (IToken)shiftExpression_return2.Start, (IToken)shiftExpression_return2.Stop);
		}
		catch (RecognitionException ex)
		{
			ReportError(ex);
			Recover(input, ex);
			shiftExpression_return2.Tree = (CommonTree)adaptor.ErrorNode(input, (IToken)shiftExpression_return2.Start, input.LT(-1), ex);
		}
		return shiftExpression_return2;
	}

	public additiveExpression_return additiveExpression()
	{
		additiveExpression_return additiveExpression_return2 = new additiveExpression_return();
		additiveExpression_return2.Start = input.LT(1);
		CommonTree commonTree = null;
		IToken token = null;
		IToken token2 = null;
		multiplicativeExpression_return multiplicativeExpression_return2 = null;
		multiplicativeExpression_return multiplicativeExpression_return3 = null;
		CommonTree commonTree2 = null;
		CommonTree commonTree3 = null;
		BinaryExpressionType type = BinaryExpressionType.Unknown;
		try
		{
			commonTree = (CommonTree)adaptor.GetNilNode();
			PushFollow(FOLLOW_multiplicativeExpression_in_additiveExpression625);
			multiplicativeExpression_return2 = multiplicativeExpression();
			state.followingStackPointer--;
			adaptor.AddChild(commonTree, multiplicativeExpression_return2.Tree);
			additiveExpression_return2.value = multiplicativeExpression_return2?.value;
			while (true)
			{
				int num = 2;
				int num2 = input.LA(1);
				if (num2 >= 38 && num2 <= 39)
				{
					num = 1;
				}
				if (num != 1)
				{
					break;
				}
				int num3 = 2;
				switch (input.LA(1) switch
				{
					38 => 1, 
					39 => 2, 
					_ => throw new NoViableAltException("", 13, 0, input), 
				})
				{
				case 1:
					token = (IToken)Match(input, 38, FOLLOW_38_in_additiveExpression636);
					commonTree2 = (CommonTree)adaptor.Create(token);
					adaptor.AddChild(commonTree, commonTree2);
					type = BinaryExpressionType.Plus;
					break;
				case 2:
					token2 = (IToken)Match(input, 39, FOLLOW_39_in_additiveExpression646);
					commonTree3 = (CommonTree)adaptor.Create(token2);
					adaptor.AddChild(commonTree, commonTree3);
					type = BinaryExpressionType.Minus;
					break;
				}
				PushFollow(FOLLOW_multiplicativeExpression_in_additiveExpression658);
				multiplicativeExpression_return3 = multiplicativeExpression();
				state.followingStackPointer--;
				adaptor.AddChild(commonTree, multiplicativeExpression_return3.Tree);
				additiveExpression_return2.value = new BinaryExpression(type, additiveExpression_return2.value, multiplicativeExpression_return3?.value);
			}
			additiveExpression_return2.Stop = input.LT(-1);
			additiveExpression_return2.Tree = (CommonTree)adaptor.RulePostProcessing(commonTree);
			adaptor.SetTokenBoundaries(additiveExpression_return2.Tree, (IToken)additiveExpression_return2.Start, (IToken)additiveExpression_return2.Stop);
		}
		catch (RecognitionException ex)
		{
			ReportError(ex);
			Recover(input, ex);
			additiveExpression_return2.Tree = (CommonTree)adaptor.ErrorNode(input, (IToken)additiveExpression_return2.Start, input.LT(-1), ex);
		}
		return additiveExpression_return2;
	}

	public multiplicativeExpression_return multiplicativeExpression()
	{
		multiplicativeExpression_return multiplicativeExpression_return2 = new multiplicativeExpression_return();
		multiplicativeExpression_return2.Start = input.LT(1);
		CommonTree commonTree = null;
		IToken token = null;
		IToken token2 = null;
		IToken token3 = null;
		unaryExpression_return unaryExpression_return2 = null;
		unaryExpression_return unaryExpression_return3 = null;
		CommonTree commonTree2 = null;
		CommonTree commonTree3 = null;
		CommonTree commonTree4 = null;
		BinaryExpressionType type = BinaryExpressionType.Unknown;
		try
		{
			commonTree = (CommonTree)adaptor.GetNilNode();
			PushFollow(FOLLOW_unaryExpression_in_multiplicativeExpression690);
			unaryExpression_return2 = unaryExpression();
			state.followingStackPointer--;
			adaptor.AddChild(commonTree, unaryExpression_return2.Tree);
			multiplicativeExpression_return2.value = unaryExpression_return2?.value;
			while (true)
			{
				int num = 2;
				int num2 = input.LA(1);
				if (num2 >= 40 && num2 <= 42)
				{
					num = 1;
				}
				if (num != 1)
				{
					break;
				}
				int num3 = 3;
				switch (input.LA(1) switch
				{
					40 => 1, 
					41 => 2, 
					42 => 3, 
					_ => throw new NoViableAltException("", 15, 0, input), 
				})
				{
				case 1:
					token = (IToken)Match(input, 40, FOLLOW_40_in_multiplicativeExpression701);
					commonTree2 = (CommonTree)adaptor.Create(token);
					adaptor.AddChild(commonTree, commonTree2);
					type = BinaryExpressionType.Times;
					break;
				case 2:
					token2 = (IToken)Match(input, 41, FOLLOW_41_in_multiplicativeExpression711);
					commonTree3 = (CommonTree)adaptor.Create(token2);
					adaptor.AddChild(commonTree, commonTree3);
					type = BinaryExpressionType.Div;
					break;
				case 3:
					token3 = (IToken)Match(input, 42, FOLLOW_42_in_multiplicativeExpression721);
					commonTree4 = (CommonTree)adaptor.Create(token3);
					adaptor.AddChild(commonTree, commonTree4);
					type = BinaryExpressionType.Modulo;
					break;
				}
				PushFollow(FOLLOW_unaryExpression_in_multiplicativeExpression733);
				unaryExpression_return3 = unaryExpression();
				state.followingStackPointer--;
				adaptor.AddChild(commonTree, unaryExpression_return3.Tree);
				multiplicativeExpression_return2.value = new BinaryExpression(type, multiplicativeExpression_return2.value, unaryExpression_return3?.value);
			}
			multiplicativeExpression_return2.Stop = input.LT(-1);
			multiplicativeExpression_return2.Tree = (CommonTree)adaptor.RulePostProcessing(commonTree);
			adaptor.SetTokenBoundaries(multiplicativeExpression_return2.Tree, (IToken)multiplicativeExpression_return2.Start, (IToken)multiplicativeExpression_return2.Stop);
		}
		catch (RecognitionException ex)
		{
			ReportError(ex);
			Recover(input, ex);
			multiplicativeExpression_return2.Tree = (CommonTree)adaptor.ErrorNode(input, (IToken)multiplicativeExpression_return2.Start, input.LT(-1), ex);
		}
		return multiplicativeExpression_return2;
	}

	public unaryExpression_return unaryExpression()
	{
		unaryExpression_return unaryExpression_return2 = new unaryExpression_return();
		unaryExpression_return2.Start = input.LT(1);
		CommonTree commonTree = null;
		IToken token = null;
		IToken token2 = null;
		IToken token3 = null;
		primaryExpression_return primaryExpression_return2 = null;
		primaryExpression_return primaryExpression_return3 = null;
		primaryExpression_return primaryExpression_return4 = null;
		primaryExpression_return primaryExpression_return5 = null;
		CommonTree commonTree2 = null;
		CommonTree commonTree3 = null;
		try
		{
			int num = 4;
			switch (input.LA(1))
			{
			case 4:
			case 5:
			case 6:
			case 7:
			case 8:
			case 9:
			case 10:
			case 11:
			case 46:
				num = 1;
				break;
			case 43:
			case 44:
				num = 2;
				break;
			case 45:
				num = 3;
				break;
			case 39:
				num = 4;
				break;
			default:
				throw new NoViableAltException("", 17, 0, input);
			}
			switch (num)
			{
			case 1:
				commonTree = (CommonTree)adaptor.GetNilNode();
				PushFollow(FOLLOW_primaryExpression_in_unaryExpression760);
				primaryExpression_return2 = primaryExpression();
				state.followingStackPointer--;
				adaptor.AddChild(commonTree, primaryExpression_return2.Tree);
				unaryExpression_return2.value = primaryExpression_return2?.value;
				break;
			case 2:
				commonTree = (CommonTree)adaptor.GetNilNode();
				token = input.LT(1);
				if (input.LA(1) >= 43 && input.LA(1) <= 44)
				{
					input.Consume();
					adaptor.AddChild(commonTree, (CommonTree)adaptor.Create(token));
					state.errorRecovery = false;
					PushFollow(FOLLOW_primaryExpression_in_unaryExpression779);
					primaryExpression_return3 = primaryExpression();
					state.followingStackPointer--;
					adaptor.AddChild(commonTree, primaryExpression_return3.Tree);
					unaryExpression_return2.value = new UnaryExpression(UnaryExpressionType.Not, primaryExpression_return3?.value);
					break;
				}
				throw new MismatchedSetException(null, input);
			case 3:
				commonTree = (CommonTree)adaptor.GetNilNode();
				token2 = (IToken)Match(input, 45, FOLLOW_45_in_unaryExpression791);
				commonTree2 = (CommonTree)adaptor.Create(token2);
				adaptor.AddChild(commonTree, commonTree2);
				PushFollow(FOLLOW_primaryExpression_in_unaryExpression794);
				primaryExpression_return4 = primaryExpression();
				state.followingStackPointer--;
				adaptor.AddChild(commonTree, primaryExpression_return4.Tree);
				unaryExpression_return2.value = new UnaryExpression(UnaryExpressionType.BitwiseNot, primaryExpression_return4?.value);
				break;
			case 4:
				commonTree = (CommonTree)adaptor.GetNilNode();
				token3 = (IToken)Match(input, 39, FOLLOW_39_in_unaryExpression805);
				commonTree3 = (CommonTree)adaptor.Create(token3);
				adaptor.AddChild(commonTree, commonTree3);
				PushFollow(FOLLOW_primaryExpression_in_unaryExpression807);
				primaryExpression_return5 = primaryExpression();
				state.followingStackPointer--;
				adaptor.AddChild(commonTree, primaryExpression_return5.Tree);
				unaryExpression_return2.value = new UnaryExpression(UnaryExpressionType.Negate, primaryExpression_return5?.value);
				break;
			}
			unaryExpression_return2.Stop = input.LT(-1);
			unaryExpression_return2.Tree = (CommonTree)adaptor.RulePostProcessing(commonTree);
			adaptor.SetTokenBoundaries(unaryExpression_return2.Tree, (IToken)unaryExpression_return2.Start, (IToken)unaryExpression_return2.Stop);
		}
		catch (RecognitionException ex)
		{
			ReportError(ex);
			Recover(input, ex);
			unaryExpression_return2.Tree = (CommonTree)adaptor.ErrorNode(input, (IToken)unaryExpression_return2.Start, input.LT(-1), ex);
		}
		return unaryExpression_return2;
	}

	public primaryExpression_return primaryExpression()
	{
		primaryExpression_return primaryExpression_return2 = new primaryExpression_return();
		primaryExpression_return2.Start = input.LT(1);
		CommonTree commonTree = null;
		IToken token = null;
		IToken token2 = null;
		value_return value_return2 = null;
		logicalExpression_return logicalExpression_return2 = null;
		identifier_return identifier_return2 = null;
		arguments_return arguments_return2 = null;
		CommonTree commonTree2 = null;
		CommonTree commonTree3 = null;
		try
		{
			int num = 3;
			switch (input.LA(1))
			{
			case 46:
				num = 1;
				break;
			case 4:
			case 5:
			case 6:
			case 7:
			case 8:
			case 9:
				num = 2;
				break;
			case 10:
			case 11:
				num = 3;
				break;
			default:
				throw new NoViableAltException("", 19, 0, input);
			}
			switch (num)
			{
			case 1:
				commonTree = (CommonTree)adaptor.GetNilNode();
				token = (IToken)Match(input, 46, FOLLOW_46_in_primaryExpression829);
				commonTree2 = (CommonTree)adaptor.Create(token);
				adaptor.AddChild(commonTree, commonTree2);
				PushFollow(FOLLOW_logicalExpression_in_primaryExpression831);
				logicalExpression_return2 = logicalExpression();
				state.followingStackPointer--;
				adaptor.AddChild(commonTree, logicalExpression_return2.Tree);
				token2 = (IToken)Match(input, 47, FOLLOW_47_in_primaryExpression833);
				commonTree3 = (CommonTree)adaptor.Create(token2);
				adaptor.AddChild(commonTree, commonTree3);
				primaryExpression_return2.value = logicalExpression_return2?.value;
				break;
			case 2:
				commonTree = (CommonTree)adaptor.GetNilNode();
				PushFollow(FOLLOW_value_in_primaryExpression843);
				value_return2 = value();
				state.followingStackPointer--;
				adaptor.AddChild(commonTree, value_return2.Tree);
				primaryExpression_return2.value = value_return2?.value;
				break;
			case 3:
			{
				commonTree = (CommonTree)adaptor.GetNilNode();
				PushFollow(FOLLOW_identifier_in_primaryExpression851);
				identifier_return2 = identifier();
				state.followingStackPointer--;
				adaptor.AddChild(commonTree, identifier_return2.Tree);
				primaryExpression_return2.value = identifier_return2?.value;
				int num2 = 2;
				if (input.LA(1) == 46)
				{
					num2 = 1;
				}
				if (num2 == 1)
				{
					PushFollow(FOLLOW_arguments_in_primaryExpression856);
					arguments_return2 = arguments();
					state.followingStackPointer--;
					adaptor.AddChild(commonTree, arguments_return2.Tree);
					primaryExpression_return2.value = new FunctionExpression(identifier_return2?.value, (arguments_return2?.value).ToArray());
				}
				break;
			}
			}
			primaryExpression_return2.Stop = input.LT(-1);
			primaryExpression_return2.Tree = (CommonTree)adaptor.RulePostProcessing(commonTree);
			adaptor.SetTokenBoundaries(primaryExpression_return2.Tree, (IToken)primaryExpression_return2.Start, (IToken)primaryExpression_return2.Stop);
		}
		catch (RecognitionException ex)
		{
			ReportError(ex);
			Recover(input, ex);
			primaryExpression_return2.Tree = (CommonTree)adaptor.ErrorNode(input, (IToken)primaryExpression_return2.Start, input.LT(-1), ex);
		}
		return primaryExpression_return2;
	}

	public value_return value()
	{
		value_return value_return2 = new value_return();
		value_return2.Start = input.LT(1);
		CommonTree commonTree = null;
		IToken token = null;
		IToken token2 = null;
		IToken token3 = null;
		IToken token4 = null;
		IToken token5 = null;
		IToken token6 = null;
		CommonTree commonTree2 = null;
		CommonTree commonTree3 = null;
		CommonTree commonTree4 = null;
		CommonTree commonTree5 = null;
		CommonTree commonTree6 = null;
		CommonTree commonTree7 = null;
		try
		{
			int num = 6;
			switch (input.LA(1) switch
			{
				4 => 1, 
				5 => 2, 
				6 => 3, 
				7 => 4, 
				8 => 5, 
				9 => 6, 
				_ => throw new NoViableAltException("", 20, 0, input), 
			})
			{
			case 1:
				commonTree = (CommonTree)adaptor.GetNilNode();
				token = (IToken)Match(input, 4, FOLLOW_INTEGER_in_value876);
				commonTree2 = (CommonTree)adaptor.Create(token);
				adaptor.AddChild(commonTree, commonTree2);
				try
				{
					value_return2.value = new ValueExpression(int.Parse(token?.Text));
				}
				catch (OverflowException)
				{
					value_return2.value = new ValueExpression(long.Parse(token?.Text));
				}
				break;
			case 2:
				commonTree = (CommonTree)adaptor.GetNilNode();
				token2 = (IToken)Match(input, 5, FOLLOW_FLOAT_in_value884);
				commonTree3 = (CommonTree)adaptor.Create(token2);
				adaptor.AddChild(commonTree, commonTree3);
				value_return2.value = new ValueExpression(double.Parse(token2?.Text, NumberStyles.Float, numberFormatInfo));
				break;
			case 3:
				commonTree = (CommonTree)adaptor.GetNilNode();
				token3 = (IToken)Match(input, 6, FOLLOW_STRING_in_value892);
				commonTree4 = (CommonTree)adaptor.Create(token3);
				adaptor.AddChild(commonTree, commonTree4);
				value_return2.value = new ValueExpression(extractString(token3?.Text));
				break;
			case 4:
				commonTree = (CommonTree)adaptor.GetNilNode();
				token4 = (IToken)Match(input, 7, FOLLOW_DATETIME_in_value901);
				commonTree5 = (CommonTree)adaptor.Create(token4);
				adaptor.AddChild(commonTree, commonTree5);
				value_return2.value = new ValueExpression(DateTime.Parse((token4?.Text).Substring(1, (token4?.Text).Length - 2)));
				break;
			case 5:
				commonTree = (CommonTree)adaptor.GetNilNode();
				token5 = (IToken)Match(input, 8, FOLLOW_TRUE_in_value908);
				commonTree6 = (CommonTree)adaptor.Create(token5);
				adaptor.AddChild(commonTree, commonTree6);
				value_return2.value = new ValueExpression(value: true);
				break;
			case 6:
				commonTree = (CommonTree)adaptor.GetNilNode();
				token6 = (IToken)Match(input, 9, FOLLOW_FALSE_in_value916);
				commonTree7 = (CommonTree)adaptor.Create(token6);
				adaptor.AddChild(commonTree, commonTree7);
				value_return2.value = new ValueExpression(value: false);
				break;
			}
			value_return2.Stop = input.LT(-1);
			value_return2.Tree = (CommonTree)adaptor.RulePostProcessing(commonTree);
			adaptor.SetTokenBoundaries(value_return2.Tree, (IToken)value_return2.Start, (IToken)value_return2.Stop);
		}
		catch (RecognitionException ex2)
		{
			ReportError(ex2);
			Recover(input, ex2);
			value_return2.Tree = (CommonTree)adaptor.ErrorNode(input, (IToken)value_return2.Start, input.LT(-1), ex2);
		}
		return value_return2;
	}

	public identifier_return identifier()
	{
		identifier_return identifier_return2 = new identifier_return();
		identifier_return2.Start = input.LT(1);
		CommonTree commonTree = null;
		IToken token = null;
		IToken token2 = null;
		CommonTree commonTree2 = null;
		CommonTree commonTree3 = null;
		try
		{
			int num = 2;
			switch (input.LA(1) switch
			{
				10 => 1, 
				11 => 2, 
				_ => throw new NoViableAltException("", 21, 0, input), 
			})
			{
			case 1:
				commonTree = (CommonTree)adaptor.GetNilNode();
				token = (IToken)Match(input, 10, FOLLOW_ID_in_identifier934);
				commonTree2 = (CommonTree)adaptor.Create(token);
				adaptor.AddChild(commonTree, commonTree2);
				identifier_return2.value = new IdentifierExpression(token?.Text);
				break;
			case 2:
				commonTree = (CommonTree)adaptor.GetNilNode();
				token2 = (IToken)Match(input, 11, FOLLOW_NAME_in_identifier942);
				commonTree3 = (CommonTree)adaptor.Create(token2);
				adaptor.AddChild(commonTree, commonTree3);
				identifier_return2.value = new IdentifierExpression((token2?.Text).Substring(1, (token2?.Text).Length - 2));
				break;
			}
			identifier_return2.Stop = input.LT(-1);
			identifier_return2.Tree = (CommonTree)adaptor.RulePostProcessing(commonTree);
			adaptor.SetTokenBoundaries(identifier_return2.Tree, (IToken)identifier_return2.Start, (IToken)identifier_return2.Stop);
		}
		catch (RecognitionException ex)
		{
			ReportError(ex);
			Recover(input, ex);
			identifier_return2.Tree = (CommonTree)adaptor.ErrorNode(input, (IToken)identifier_return2.Start, input.LT(-1), ex);
		}
		return identifier_return2;
	}

	public expressionList_return expressionList()
	{
		expressionList_return expressionList_return2 = new expressionList_return();
		expressionList_return2.Start = input.LT(1);
		CommonTree commonTree = null;
		IToken token = null;
		logicalExpression_return logicalExpression_return2 = null;
		logicalExpression_return logicalExpression_return3 = null;
		CommonTree commonTree2 = null;
		List<LogicalExpression> list = new List<LogicalExpression>();
		try
		{
			commonTree = (CommonTree)adaptor.GetNilNode();
			PushFollow(FOLLOW_logicalExpression_in_expressionList966);
			logicalExpression_return2 = logicalExpression();
			state.followingStackPointer--;
			adaptor.AddChild(commonTree, logicalExpression_return2.Tree);
			list.Add(logicalExpression_return2?.value);
			while (true)
			{
				int num = 2;
				if (input.LA(1) == 48)
				{
					num = 1;
				}
				if (num != 1)
				{
					break;
				}
				token = (IToken)Match(input, 48, FOLLOW_48_in_expressionList973);
				commonTree2 = (CommonTree)adaptor.Create(token);
				adaptor.AddChild(commonTree, commonTree2);
				PushFollow(FOLLOW_logicalExpression_in_expressionList977);
				logicalExpression_return3 = logicalExpression();
				state.followingStackPointer--;
				adaptor.AddChild(commonTree, logicalExpression_return3.Tree);
				list.Add(logicalExpression_return3?.value);
			}
			expressionList_return2.value = list;
			expressionList_return2.Stop = input.LT(-1);
			expressionList_return2.Tree = (CommonTree)adaptor.RulePostProcessing(commonTree);
			adaptor.SetTokenBoundaries(expressionList_return2.Tree, (IToken)expressionList_return2.Start, (IToken)expressionList_return2.Stop);
		}
		catch (RecognitionException ex)
		{
			ReportError(ex);
			Recover(input, ex);
			expressionList_return2.Tree = (CommonTree)adaptor.ErrorNode(input, (IToken)expressionList_return2.Start, input.LT(-1), ex);
		}
		return expressionList_return2;
	}

	public arguments_return arguments()
	{
		arguments_return arguments_return2 = new arguments_return();
		arguments_return2.Start = input.LT(1);
		CommonTree commonTree = null;
		IToken token = null;
		IToken token2 = null;
		expressionList_return expressionList_return2 = null;
		CommonTree commonTree2 = null;
		CommonTree commonTree3 = null;
		arguments_return2.value = new List<LogicalExpression>();
		try
		{
			commonTree = (CommonTree)adaptor.GetNilNode();
			token = (IToken)Match(input, 46, FOLLOW_46_in_arguments1006);
			commonTree2 = (CommonTree)adaptor.Create(token);
			adaptor.AddChild(commonTree, commonTree2);
			int num = 2;
			int num2 = input.LA(1);
			if ((num2 >= 4 && num2 <= 11) || num2 == 39 || (num2 >= 43 && num2 <= 46))
			{
				num = 1;
			}
			if (num == 1)
			{
				PushFollow(FOLLOW_expressionList_in_arguments1010);
				expressionList_return2 = expressionList();
				state.followingStackPointer--;
				adaptor.AddChild(commonTree, expressionList_return2.Tree);
				arguments_return2.value = expressionList_return2?.value;
			}
			token2 = (IToken)Match(input, 47, FOLLOW_47_in_arguments1017);
			commonTree3 = (CommonTree)adaptor.Create(token2);
			adaptor.AddChild(commonTree, commonTree3);
			arguments_return2.Stop = input.LT(-1);
			arguments_return2.Tree = (CommonTree)adaptor.RulePostProcessing(commonTree);
			adaptor.SetTokenBoundaries(arguments_return2.Tree, (IToken)arguments_return2.Start, (IToken)arguments_return2.Stop);
		}
		catch (RecognitionException ex)
		{
			ReportError(ex);
			Recover(input, ex);
			arguments_return2.Tree = (CommonTree)adaptor.ErrorNode(input, (IToken)arguments_return2.Start, input.LT(-1), ex);
		}
		return arguments_return2;
	}
}
