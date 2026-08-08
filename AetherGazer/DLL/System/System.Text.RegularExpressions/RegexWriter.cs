using System.Collections;
using System.Collections.Generic;
using System.Globalization;

namespace System.Text.RegularExpressions;

internal ref struct RegexWriter
{
	private ValueListBuilder<int> _emitted;

	private ValueListBuilder<int> _intStack;

	private readonly Dictionary<string, int> _stringHash;

	private readonly List<string> _stringTable;

	private Hashtable _caps;

	private int _trackCount;

	private RegexWriter(Span<int> emittedSpan, Span<int> intStackSpan)
	{
		_emitted = new ValueListBuilder<int>(emittedSpan);
		_intStack = new ValueListBuilder<int>(intStackSpan);
		_stringHash = new Dictionary<string, int>();
		_stringTable = new List<string>();
		_caps = null;
		_trackCount = 0;
	}

	public static RegexCode Write(RegexTree tree)
	{
		Span<int> emittedSpan = stackalloc int[56];
		Span<int> intStackSpan = stackalloc int[32];
		RegexWriter regexWriter = new RegexWriter(emittedSpan, intStackSpan);
		RegexCode result = regexWriter.RegexCodeFromRegexTree(tree);
		regexWriter.Dispose();
		return result;
	}

	public void Dispose()
	{
		_emitted.Dispose();
		_intStack.Dispose();
	}

	public RegexCode RegexCodeFromRegexTree(RegexTree tree)
	{
		int capsize;
		if (tree.CapNumList == null || tree.CapTop == tree.CapNumList.Length)
		{
			capsize = tree.CapTop;
			_caps = null;
		}
		else
		{
			capsize = tree.CapNumList.Length;
			_caps = tree.Caps;
			for (int i = 0; i < tree.CapNumList.Length; i++)
			{
				_caps[tree.CapNumList[i]] = i;
			}
		}
		RegexNode regexNode = tree.Root;
		int num = 0;
		Emit(23, 0);
		while (true)
		{
			if (regexNode.Children == null)
			{
				EmitFragment(regexNode.NType, regexNode, 0);
			}
			else if (num < regexNode.Children.Count)
			{
				EmitFragment(regexNode.NType | 0x40, regexNode, num);
				regexNode = regexNode.Children[num];
				_intStack.Append(num);
				num = 0;
				continue;
			}
			if (_intStack.Length == 0)
			{
				break;
			}
			num = _intStack.Pop();
			regexNode = regexNode.Next;
			EmitFragment(regexNode.NType | 0x80, regexNode, num);
			num++;
		}
		PatchJump(0, _emitted.Length);
		Emit(40);
		RegexPrefix? fcPrefix = RegexFCD.FirstChars(tree);
		RegexPrefix regexPrefix = RegexFCD.Prefix(tree);
		bool rightToLeft = (tree.Options & RegexOptions.RightToLeft) != 0;
		CultureInfo culture = (((tree.Options & RegexOptions.CultureInvariant) != RegexOptions.None) ? CultureInfo.InvariantCulture : CultureInfo.CurrentCulture);
		RegexBoyerMoore bmPrefix = ((regexPrefix.Prefix.Length <= 0) ? null : new RegexBoyerMoore(regexPrefix.Prefix, regexPrefix.CaseInsensitive, rightToLeft, culture));
		int anchors = RegexFCD.Anchors(tree);
		return new RegexCode(_emitted.AsSpan().ToArray(), _stringTable, _trackCount, _caps, capsize, bmPrefix, fcPrefix, anchors, rightToLeft);
	}

	private void PatchJump(int offset, int jumpDest)
	{
		_emitted[offset + 1] = jumpDest;
	}

	private void Emit(int op)
	{
		if (RegexCode.OpcodeBacktracks(op))
		{
			_trackCount++;
		}
		_emitted.Append(op);
	}

	private void Emit(int op, int opd1)
	{
		if (RegexCode.OpcodeBacktracks(op))
		{
			_trackCount++;
		}
		_emitted.Append(op);
		_emitted.Append(opd1);
	}

	private void Emit(int op, int opd1, int opd2)
	{
		if (RegexCode.OpcodeBacktracks(op))
		{
			_trackCount++;
		}
		_emitted.Append(op);
		_emitted.Append(opd1);
		_emitted.Append(opd2);
	}

	private int StringCode(string str)
	{
		if (str == null)
		{
			str = string.Empty;
		}
		if (!_stringHash.TryGetValue(str, out var value))
		{
			value = _stringTable.Count;
			_stringHash[str] = value;
			_stringTable.Add(str);
		}
		return value;
	}

	private int MapCapnum(int capnum)
	{
		if (capnum == -1)
		{
			return -1;
		}
		if (_caps != null)
		{
			return (int)_caps[capnum];
		}
		return capnum;
	}

	private void EmitFragment(int nodetype, RegexNode node, int curIndex)
	{
		int num = 0;
		if (nodetype <= 13)
		{
			if (node.UseOptionR())
			{
				num |= 0x40;
			}
			if ((node.Options & RegexOptions.IgnoreCase) != RegexOptions.None)
			{
				num |= 0x200;
			}
		}
		switch (nodetype)
		{
		case 88:
			if (curIndex < node.Children.Count - 1)
			{
				_intStack.Append(_emitted.Length);
				Emit(23, 0);
			}
			break;
		case 152:
			if (curIndex < node.Children.Count - 1)
			{
				int offset = _intStack.Pop();
				_intStack.Append(_emitted.Length);
				Emit(38, 0);
				PatchJump(offset, _emitted.Length);
			}
			else
			{
				for (int i = 0; i < curIndex; i++)
				{
					PatchJump(_intStack.Pop(), _emitted.Length);
				}
			}
			break;
		case 97:
			if (curIndex == 0)
			{
				Emit(34);
				_intStack.Append(_emitted.Length);
				Emit(23, 0);
				Emit(37, MapCapnum(node.M));
				Emit(36);
			}
			break;
		case 161:
			switch (curIndex)
			{
			case 0:
			{
				int offset3 = _intStack.Pop();
				_intStack.Append(_emitted.Length);
				Emit(38, 0);
				PatchJump(offset3, _emitted.Length);
				Emit(36);
				if (node.Children.Count > 1)
				{
					break;
				}
				goto case 1;
			}
			case 1:
				PatchJump(_intStack.Pop(), _emitted.Length);
				break;
			}
			break;
		case 98:
			if (curIndex == 0)
			{
				Emit(34);
				Emit(31);
				_intStack.Append(_emitted.Length);
				Emit(23, 0);
			}
			break;
		case 162:
			switch (curIndex)
			{
			case 0:
				Emit(33);
				Emit(36);
				break;
			case 1:
			{
				int offset2 = _intStack.Pop();
				_intStack.Append(_emitted.Length);
				Emit(38, 0);
				PatchJump(offset2, _emitted.Length);
				Emit(33);
				Emit(36);
				if (node.Children.Count > 2)
				{
					break;
				}
				goto case 2;
			}
			case 2:
				PatchJump(_intStack.Pop(), _emitted.Length);
				break;
			}
			break;
		case 90:
		case 91:
			if (node.N < int.MaxValue || node.M > 1)
			{
				Emit((node.M == 0) ? 26 : 27, (node.M != 0) ? (1 - node.M) : 0);
			}
			else
			{
				Emit((node.M == 0) ? 30 : 31);
			}
			if (node.M == 0)
			{
				_intStack.Append(_emitted.Length);
				Emit(38, 0);
			}
			_intStack.Append(_emitted.Length);
			break;
		case 154:
		case 155:
		{
			int length = _emitted.Length;
			int num2 = nodetype - 154;
			if (node.N < int.MaxValue || node.M > 1)
			{
				Emit(28 + num2, _intStack.Pop(), (node.N == int.MaxValue) ? int.MaxValue : (node.N - node.M));
			}
			else
			{
				Emit(24 + num2, _intStack.Pop());
			}
			if (node.M == 0)
			{
				PatchJump(_intStack.Pop(), length);
			}
			break;
		}
		case 92:
			Emit(31);
			break;
		case 156:
			Emit(32, MapCapnum(node.M), MapCapnum(node.N));
			break;
		case 94:
			Emit(34);
			Emit(31);
			break;
		case 158:
			Emit(33);
			Emit(36);
			break;
		case 95:
			Emit(34);
			_intStack.Append(_emitted.Length);
			Emit(23, 0);
			break;
		case 159:
			Emit(35);
			PatchJump(_intStack.Pop(), _emitted.Length);
			Emit(36);
			break;
		case 96:
			Emit(34);
			break;
		case 160:
			Emit(36);
			break;
		case 9:
		case 10:
			Emit(node.NType | num, node.Ch);
			break;
		case 3:
		case 4:
		case 6:
		case 7:
			if (node.M > 0)
			{
				Emit(((node.NType != 3 && node.NType != 6) ? 1 : 0) | num, node.Ch, node.M);
			}
			if (node.N > node.M)
			{
				Emit(node.NType | num, node.Ch, (node.N == int.MaxValue) ? int.MaxValue : (node.N - node.M));
			}
			break;
		case 5:
		case 8:
			if (node.M > 0)
			{
				Emit(2 | num, StringCode(node.Str), node.M);
			}
			if (node.N > node.M)
			{
				Emit(node.NType | num, StringCode(node.Str), (node.N == int.MaxValue) ? int.MaxValue : (node.N - node.M));
			}
			break;
		case 12:
			Emit(node.NType | num, StringCode(node.Str));
			break;
		case 11:
			Emit(node.NType | num, StringCode(node.Str));
			break;
		case 13:
			Emit(node.NType | num, MapCapnum(node.M));
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
			Emit(node.NType);
			break;
		default:
			throw new ArgumentException(global::SR.Format("Unexpected opcode in regular expression generation: {0}.", nodetype.ToString(CultureInfo.CurrentCulture)));
		case 23:
		case 89:
		case 93:
		case 153:
		case 157:
			break;
		}
	}
}
