using System.Collections.Generic;
using System.Globalization;

namespace System.Text.RegularExpressions;

internal ref struct RegexFCD
{
	private readonly List<RegexFC> _fcStack;

	private ValueListBuilder<int> _intStack;

	private bool _skipAllChildren;

	private bool _skipchild;

	private bool _failed;

	private RegexFCD(Span<int> intStack)
	{
		_fcStack = new List<RegexFC>(32);
		_intStack = new ValueListBuilder<int>(intStack);
		_failed = false;
		_skipchild = false;
		_skipAllChildren = false;
	}

	public static RegexPrefix? FirstChars(RegexTree t)
	{
		Span<int> intStack = stackalloc int[32];
		RegexFCD regexFCD = new RegexFCD(intStack);
		RegexFC regexFC = regexFCD.RegexFCFromRegexTree(t);
		regexFCD.Dispose();
		if (regexFC == null || regexFC._nullable)
		{
			return null;
		}
		CultureInfo culture = (((t.Options & RegexOptions.CultureInvariant) != RegexOptions.None) ? CultureInfo.InvariantCulture : CultureInfo.CurrentCulture);
		return new RegexPrefix(regexFC.GetFirstChars(culture), regexFC.CaseInsensitive);
	}

	public static RegexPrefix Prefix(RegexTree tree)
	{
		RegexNode regexNode = tree.Root;
		RegexNode regexNode2 = null;
		int num = 0;
		while (true)
		{
			switch (regexNode.NType)
			{
			case 25:
				if (regexNode.ChildCount() > 0)
				{
					regexNode2 = regexNode;
					num = 0;
				}
				break;
			case 28:
			case 32:
				regexNode = regexNode.Child(0);
				regexNode2 = null;
				continue;
			case 3:
			case 6:
				if (regexNode.M > 0 && regexNode.M < 1000000)
				{
					return new RegexPrefix(string.Empty.PadRight(regexNode.M, regexNode.Ch), (regexNode.Options & RegexOptions.IgnoreCase) != 0);
				}
				return RegexPrefix.Empty;
			case 9:
				return new RegexPrefix(regexNode.Ch.ToString(), (regexNode.Options & RegexOptions.IgnoreCase) != 0);
			case 12:
				return new RegexPrefix(regexNode.Str, (regexNode.Options & RegexOptions.IgnoreCase) != 0);
			default:
				return RegexPrefix.Empty;
			case 14:
			case 15:
			case 16:
			case 18:
			case 19:
			case 20:
			case 21:
			case 23:
			case 30:
			case 31:
			case 41:
				break;
			}
			if (regexNode2 == null || num >= regexNode2.ChildCount())
			{
				break;
			}
			regexNode = regexNode2.Child(num++);
		}
		return RegexPrefix.Empty;
	}

	public static int Anchors(RegexTree tree)
	{
		RegexNode regexNode = null;
		int num = 0;
		int num2 = 0;
		RegexNode regexNode2 = tree.Root;
		while (true)
		{
			switch (regexNode2.NType)
			{
			case 25:
				if (regexNode2.ChildCount() > 0)
				{
					regexNode = regexNode2;
					num = 0;
				}
				break;
			case 28:
			case 32:
				regexNode2 = regexNode2.Child(0);
				regexNode = null;
				continue;
			case 14:
			case 15:
			case 16:
			case 18:
			case 19:
			case 20:
			case 21:
			case 41:
				return num2 | AnchorFromType(regexNode2.NType);
			default:
				return num2;
			case 23:
			case 30:
			case 31:
				break;
			}
			if (regexNode == null || num >= regexNode.ChildCount())
			{
				break;
			}
			regexNode2 = regexNode.Child(num++);
		}
		return num2;
	}

	private static int AnchorFromType(int type)
	{
		return type switch
		{
			14 => 2, 
			15 => 8, 
			16 => 64, 
			41 => 128, 
			18 => 1, 
			19 => 4, 
			20 => 16, 
			21 => 32, 
			_ => 0, 
		};
	}

	private void PushInt(int i)
	{
		_intStack.Append(i);
	}

	private bool IntIsEmpty()
	{
		return _intStack.Length == 0;
	}

	private int PopInt()
	{
		return _intStack.Pop();
	}

	private void PushFC(RegexFC fc)
	{
		_fcStack.Add(fc);
	}

	private bool FCIsEmpty()
	{
		return _fcStack.Count == 0;
	}

	private RegexFC PopFC()
	{
		RegexFC result = TopFC();
		_fcStack.RemoveAt(_fcStack.Count - 1);
		return result;
	}

	private RegexFC TopFC()
	{
		return _fcStack[_fcStack.Count - 1];
	}

	public void Dispose()
	{
		_intStack.Dispose();
	}

	private RegexFC RegexFCFromRegexTree(RegexTree tree)
	{
		RegexNode regexNode = tree.Root;
		int num = 0;
		while (true)
		{
			if (regexNode.Children == null)
			{
				CalculateFC(regexNode.NType, regexNode, 0);
			}
			else if (num < regexNode.Children.Count && !_skipAllChildren)
			{
				CalculateFC(regexNode.NType | 0x40, regexNode, num);
				if (!_skipchild)
				{
					regexNode = regexNode.Children[num];
					PushInt(num);
					num = 0;
				}
				else
				{
					num++;
					_skipchild = false;
				}
				continue;
			}
			_skipAllChildren = false;
			if (IntIsEmpty())
			{
				break;
			}
			num = PopInt();
			regexNode = regexNode.Next;
			CalculateFC(regexNode.NType | 0x80, regexNode, num);
			if (_failed)
			{
				return null;
			}
			num++;
		}
		if (FCIsEmpty())
		{
			return null;
		}
		return PopFC();
	}

	private void SkipChild()
	{
		_skipchild = true;
	}

	private void CalculateFC(int NodeType, RegexNode node, int CurIndex)
	{
		bool caseInsensitive = false;
		bool flag = false;
		if (NodeType <= 13)
		{
			if ((node.Options & RegexOptions.IgnoreCase) != RegexOptions.None)
			{
				caseInsensitive = true;
			}
			if ((node.Options & RegexOptions.RightToLeft) != RegexOptions.None)
			{
				flag = true;
			}
		}
		switch (NodeType)
		{
		case 98:
			if (CurIndex == 0)
			{
				SkipChild();
			}
			break;
		case 23:
			PushFC(new RegexFC(nullable: true));
			break;
		case 153:
			if (CurIndex != 0)
			{
				RegexFC fc3 = PopFC();
				RegexFC regexFC3 = TopFC();
				_failed = !regexFC3.AddFC(fc3, concatenate: true);
			}
			if (!TopFC()._nullable)
			{
				_skipAllChildren = true;
			}
			break;
		case 162:
			if (CurIndex > 1)
			{
				RegexFC fc2 = PopFC();
				RegexFC regexFC2 = TopFC();
				_failed = !regexFC2.AddFC(fc2, concatenate: false);
			}
			break;
		case 152:
		case 161:
			if (CurIndex != 0)
			{
				RegexFC fc = PopFC();
				RegexFC regexFC = TopFC();
				_failed = !regexFC.AddFC(fc, concatenate: false);
			}
			break;
		case 154:
		case 155:
			if (node.M == 0)
			{
				TopFC()._nullable = true;
			}
			break;
		case 94:
		case 95:
			SkipChild();
			PushFC(new RegexFC(nullable: true));
			break;
		case 9:
		case 10:
			PushFC(new RegexFC(node.Ch, NodeType == 10, nullable: false, caseInsensitive));
			break;
		case 3:
		case 6:
			PushFC(new RegexFC(node.Ch, not: false, node.M == 0, caseInsensitive));
			break;
		case 4:
		case 7:
			PushFC(new RegexFC(node.Ch, not: true, node.M == 0, caseInsensitive));
			break;
		case 12:
			if (node.Str.Length == 0)
			{
				PushFC(new RegexFC(nullable: true));
			}
			else if (!flag)
			{
				PushFC(new RegexFC(node.Str[0], not: false, nullable: false, caseInsensitive));
			}
			else
			{
				PushFC(new RegexFC(node.Str[node.Str.Length - 1], not: false, nullable: false, caseInsensitive));
			}
			break;
		case 11:
			PushFC(new RegexFC(node.Str, nullable: false, caseInsensitive));
			break;
		case 5:
		case 8:
			PushFC(new RegexFC(node.Str, node.M == 0, caseInsensitive));
			break;
		case 13:
			PushFC(new RegexFC("\0\u0001\0\0", nullable: true, caseInsensitive: false));
			break;
		case 14:
		case 15:
		case 16:
		case 17:
		case 18:
		case 19:
		case 20:
		case 21:
		case 22:
		case 41:
		case 42:
			PushFC(new RegexFC(nullable: true));
			break;
		default:
			throw new ArgumentException(global::SR.Format("Unexpected opcode in regular expression generation: {0}.", NodeType.ToString(CultureInfo.CurrentCulture)));
		case 88:
		case 89:
		case 90:
		case 91:
		case 92:
		case 93:
		case 96:
		case 97:
		case 156:
		case 157:
		case 158:
		case 159:
		case 160:
			break;
		}
	}
}
