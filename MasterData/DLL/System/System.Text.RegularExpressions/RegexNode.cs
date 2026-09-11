using System.Collections.Generic;
using System.Globalization;

namespace System.Text.RegularExpressions;

internal sealed class RegexNode
{
	public int NType;

	public List<RegexNode> Children;

	public string Str;

	public char Ch;

	public int M;

	public int N;

	public readonly RegexOptions Options;

	public RegexNode Next;

	public RegexNode(int type, RegexOptions options)
	{
		NType = type;
		Options = options;
	}

	public RegexNode(int type, RegexOptions options, char ch)
	{
		NType = type;
		Options = options;
		Ch = ch;
	}

	public RegexNode(int type, RegexOptions options, string str)
	{
		NType = type;
		Options = options;
		Str = str;
	}

	public RegexNode(int type, RegexOptions options, int m)
	{
		NType = type;
		Options = options;
		M = m;
	}

	public RegexNode(int type, RegexOptions options, int m, int n)
	{
		NType = type;
		Options = options;
		M = m;
		N = n;
	}

	public bool UseOptionR()
	{
		return (Options & RegexOptions.RightToLeft) != 0;
	}

	public RegexNode ReverseLeft()
	{
		if (UseOptionR() && NType == 25 && Children != null)
		{
			Children.Reverse(0, Children.Count);
		}
		return this;
	}

	private void MakeRep(int type, int min, int max)
	{
		NType += type - 9;
		M = min;
		N = max;
	}

	private RegexNode Reduce()
	{
		switch (Type())
		{
		case 24:
			return ReduceAlternation();
		case 25:
			return ReduceConcatenation();
		case 26:
		case 27:
			return ReduceRep();
		case 29:
			return ReduceGroup();
		case 5:
		case 11:
			return ReduceSet();
		default:
			return this;
		}
	}

	private RegexNode StripEnation(int emptyType)
	{
		return ChildCount() switch
		{
			0 => new RegexNode(emptyType, Options), 
			1 => Child(0), 
			_ => this, 
		};
	}

	private RegexNode ReduceGroup()
	{
		RegexNode regexNode = this;
		while (regexNode.Type() == 29)
		{
			regexNode = regexNode.Child(0);
		}
		return regexNode;
	}

	private RegexNode ReduceRep()
	{
		RegexNode regexNode = this;
		int num = Type();
		int num2 = M;
		int num3 = N;
		while (regexNode.ChildCount() != 0)
		{
			RegexNode regexNode2 = regexNode.Child(0);
			if (regexNode2.Type() != num)
			{
				int num4 = regexNode2.Type();
				if ((num4 < 3 || num4 > 5 || num != 26) && (num4 < 6 || num4 > 8 || num != 27))
				{
					break;
				}
			}
			if ((regexNode.M == 0 && regexNode2.M > 1) || regexNode2.N < regexNode2.M * 2)
			{
				break;
			}
			regexNode = regexNode2;
			if (regexNode.M > 0)
			{
				num2 = (regexNode.M = ((2147483646 / regexNode.M < num2) ? int.MaxValue : (regexNode.M * num2)));
			}
			if (regexNode.N > 0)
			{
				num3 = (regexNode.N = ((2147483646 / regexNode.N < num3) ? int.MaxValue : (regexNode.N * num3)));
			}
		}
		if (num2 != int.MaxValue)
		{
			return regexNode;
		}
		return new RegexNode(22, Options);
	}

	private RegexNode ReduceSet()
	{
		if (RegexCharClass.IsEmpty(Str))
		{
			NType = 22;
			Str = null;
		}
		else if (RegexCharClass.IsSingleton(Str))
		{
			Ch = RegexCharClass.SingletonChar(Str);
			Str = null;
			NType += -2;
		}
		else if (RegexCharClass.IsSingletonInverse(Str))
		{
			Ch = RegexCharClass.SingletonChar(Str);
			Str = null;
			NType += -1;
		}
		return this;
	}

	private RegexNode ReduceAlternation()
	{
		if (Children == null)
		{
			return new RegexNode(22, Options);
		}
		bool flag = false;
		bool flag2 = false;
		RegexOptions regexOptions = RegexOptions.None;
		int i = 0;
		int j;
		for (j = 0; i < Children.Count; i++, j++)
		{
			RegexNode regexNode = Children[i];
			if (j < i)
			{
				Children[j] = regexNode;
			}
			if (regexNode.NType == 24)
			{
				for (int k = 0; k < regexNode.Children.Count; k++)
				{
					regexNode.Children[k].Next = this;
				}
				Children.InsertRange(i + 1, regexNode.Children);
				j--;
			}
			else if (regexNode.NType == 11 || regexNode.NType == 9)
			{
				RegexOptions regexOptions2 = regexNode.Options & (RegexOptions.IgnoreCase | RegexOptions.RightToLeft);
				if (regexNode.NType == 11)
				{
					if (((!flag || regexOptions != regexOptions2) | flag2) || !RegexCharClass.IsMergeable(regexNode.Str))
					{
						flag = true;
						flag2 = !RegexCharClass.IsMergeable(regexNode.Str);
						regexOptions = regexOptions2;
						continue;
					}
				}
				else if ((!flag || regexOptions != regexOptions2) | flag2)
				{
					flag = true;
					flag2 = false;
					regexOptions = regexOptions2;
					continue;
				}
				j--;
				RegexNode regexNode2 = Children[j];
				RegexCharClass regexCharClass;
				if (regexNode2.NType == 9)
				{
					regexCharClass = new RegexCharClass();
					regexCharClass.AddChar(regexNode2.Ch);
				}
				else
				{
					regexCharClass = RegexCharClass.Parse(regexNode2.Str);
				}
				if (regexNode.NType == 9)
				{
					regexCharClass.AddChar(regexNode.Ch);
				}
				else
				{
					RegexCharClass cc = RegexCharClass.Parse(regexNode.Str);
					regexCharClass.AddCharClass(cc);
				}
				regexNode2.NType = 11;
				regexNode2.Str = regexCharClass.ToStringClass();
			}
			else if (regexNode.NType == 22)
			{
				j--;
			}
			else
			{
				flag = false;
				flag2 = false;
			}
		}
		if (j < i)
		{
			Children.RemoveRange(j, i - j);
		}
		return StripEnation(22);
	}

	private RegexNode ReduceConcatenation()
	{
		if (Children == null)
		{
			return new RegexNode(23, Options);
		}
		bool flag = false;
		RegexOptions regexOptions = RegexOptions.None;
		int num = 0;
		int num2 = 0;
		while (num < Children.Count)
		{
			RegexNode regexNode = Children[num];
			if (num2 < num)
			{
				Children[num2] = regexNode;
			}
			if (regexNode.NType == 25 && (regexNode.Options & RegexOptions.RightToLeft) == (Options & RegexOptions.RightToLeft))
			{
				for (int i = 0; i < regexNode.Children.Count; i++)
				{
					regexNode.Children[i].Next = this;
				}
				Children.InsertRange(num + 1, regexNode.Children);
				num2--;
			}
			else if (regexNode.NType == 12 || regexNode.NType == 9)
			{
				RegexOptions regexOptions2 = regexNode.Options & (RegexOptions.IgnoreCase | RegexOptions.RightToLeft);
				if (!flag || regexOptions != regexOptions2)
				{
					flag = true;
					regexOptions = regexOptions2;
				}
				else
				{
					RegexNode regexNode2 = Children[--num2];
					if (regexNode2.NType == 9)
					{
						regexNode2.NType = 12;
						regexNode2.Str = Convert.ToString(regexNode2.Ch, CultureInfo.InvariantCulture);
					}
					if ((regexOptions2 & RegexOptions.RightToLeft) == 0)
					{
						if (regexNode.NType == 9)
						{
							regexNode2.Str += regexNode.Ch;
						}
						else
						{
							regexNode2.Str += regexNode.Str;
						}
					}
					else if (regexNode.NType == 9)
					{
						regexNode2.Str = regexNode.Ch + regexNode2.Str;
					}
					else
					{
						regexNode2.Str = regexNode.Str + regexNode2.Str;
					}
				}
			}
			else if (regexNode.NType == 23)
			{
				num2--;
			}
			else
			{
				flag = false;
			}
			num++;
			num2++;
		}
		if (num2 < num)
		{
			Children.RemoveRange(num2, num - num2);
		}
		return StripEnation(23);
	}

	public RegexNode MakeQuantifier(bool lazy, int min, int max)
	{
		if (min == 0 && max == 0)
		{
			return new RegexNode(23, Options);
		}
		if (min == 1 && max == 1)
		{
			return this;
		}
		int nType = NType;
		if ((uint)(nType - 9) <= 2u)
		{
			MakeRep(lazy ? 6 : 3, min, max);
			return this;
		}
		RegexNode regexNode = new RegexNode(lazy ? 27 : 26, Options, min, max);
		regexNode.AddChild(this);
		return regexNode;
	}

	public void AddChild(RegexNode newChild)
	{
		if (Children == null)
		{
			Children = new List<RegexNode>(4);
		}
		RegexNode regexNode = newChild.Reduce();
		Children.Add(regexNode);
		regexNode.Next = this;
	}

	public RegexNode Child(int i)
	{
		return Children[i];
	}

	public int ChildCount()
	{
		if (Children != null)
		{
			return Children.Count;
		}
		return 0;
	}

	public int Type()
	{
		return NType;
	}
}
