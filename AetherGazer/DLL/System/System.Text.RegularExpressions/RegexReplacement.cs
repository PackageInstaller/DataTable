using System.Collections;
using System.Collections.Generic;

namespace System.Text.RegularExpressions;

internal sealed class RegexReplacement
{
	private const int Specials = 4;

	public const int LeftPortion = -1;

	public const int RightPortion = -2;

	public const int LastGroup = -3;

	public const int WholeString = -4;

	private readonly List<string> _strings;

	private readonly List<int> _rules;

	public string Pattern { get; }

	public RegexReplacement(string rep, RegexNode concat, Hashtable _caps)
	{
		if (concat.Type() != 25)
		{
			throw new ArgumentException("Replacement pattern error.");
		}
		StringBuilder stringBuilder = StringBuilderCache.Acquire();
		List<string> list = new List<string>();
		List<int> list2 = new List<int>();
		for (int i = 0; i < concat.ChildCount(); i++)
		{
			RegexNode regexNode = concat.Child(i);
			switch (regexNode.Type())
			{
			case 12:
				stringBuilder.Append(regexNode.Str);
				break;
			case 9:
				stringBuilder.Append(regexNode.Ch);
				break;
			case 13:
			{
				if (stringBuilder.Length > 0)
				{
					list2.Add(list.Count);
					list.Add(stringBuilder.ToString());
					stringBuilder.Length = 0;
				}
				int num = regexNode.M;
				if (_caps != null && num >= 0)
				{
					num = (int)_caps[num];
				}
				list2.Add(-5 - num);
				break;
			}
			default:
				throw new ArgumentException("Replacement pattern error.");
			}
		}
		if (stringBuilder.Length > 0)
		{
			list2.Add(list.Count);
			list.Add(stringBuilder.ToString());
		}
		StringBuilderCache.Release(stringBuilder);
		Pattern = rep;
		_strings = list;
		_rules = list2;
	}

	public static RegexReplacement GetOrCreate(WeakReference<RegexReplacement> replRef, string replacement, Hashtable caps, int capsize, Hashtable capnames, RegexOptions roptions)
	{
		if (!replRef.TryGetTarget(out var target) || !target.Pattern.Equals(replacement))
		{
			target = RegexParser.ParseReplacement(replacement, caps, capsize, capnames, roptions);
			replRef.SetTarget(target);
		}
		return target;
	}

	private void ReplacementImpl(StringBuilder sb, Match match)
	{
		for (int i = 0; i < _rules.Count; i++)
		{
			int num = _rules[i];
			if (num >= 0)
			{
				sb.Append(_strings[num]);
				continue;
			}
			if (num < -4)
			{
				sb.Append(match.GroupToStringImpl(-5 - num));
				continue;
			}
			switch (-5 - num)
			{
			case -1:
				sb.Append(match.GetLeftSubstring());
				break;
			case -2:
				sb.Append(match.GetRightSubstring());
				break;
			case -3:
				sb.Append(match.LastGroupToStringImpl());
				break;
			case -4:
				sb.Append(match.Text);
				break;
			}
		}
	}

	private void ReplacementImplRTL(List<string> al, Match match)
	{
		for (int num = _rules.Count - 1; num >= 0; num--)
		{
			int num2 = _rules[num];
			if (num2 >= 0)
			{
				al.Add(_strings[num2]);
			}
			else if (num2 < -4)
			{
				al.Add(match.GroupToStringImpl(-5 - num2).ToString());
			}
			else
			{
				switch (-5 - num2)
				{
				case -1:
					al.Add(match.GetLeftSubstring().ToString());
					break;
				case -2:
					al.Add(match.GetRightSubstring().ToString());
					break;
				case -3:
					al.Add(match.LastGroupToStringImpl().ToString());
					break;
				case -4:
					al.Add(match.Text);
					break;
				}
			}
		}
	}

	public string Replacement(Match match)
	{
		StringBuilder sb = StringBuilderCache.Acquire();
		ReplacementImpl(sb, match);
		return StringBuilderCache.GetStringAndRelease(sb);
	}

	public string Replace(Regex regex, string input, int count, int startat)
	{
		if (count < -1)
		{
			throw new ArgumentOutOfRangeException("count", "Count cannot be less than -1.");
		}
		if (startat < 0 || startat > input.Length)
		{
			throw new ArgumentOutOfRangeException("startat", "Start index cannot be less than 0 or greater than input length.");
		}
		if (count == 0)
		{
			return input;
		}
		Match match = regex.Match(input, startat);
		if (!match.Success)
		{
			return input;
		}
		StringBuilder stringBuilder = StringBuilderCache.Acquire();
		if (!regex.RightToLeft)
		{
			int num = 0;
			do
			{
				if (match.Index != num)
				{
					stringBuilder.Append(input, num, match.Index - num);
				}
				num = match.Index + match.Length;
				ReplacementImpl(stringBuilder, match);
				if (--count == 0)
				{
					break;
				}
				match = match.NextMatch();
			}
			while (match.Success);
			if (num < input.Length)
			{
				stringBuilder.Append(input, num, input.Length - num);
			}
		}
		else
		{
			List<string> list = new List<string>();
			int num2 = input.Length;
			do
			{
				if (match.Index + match.Length != num2)
				{
					list.Add(input.Substring(match.Index + match.Length, num2 - match.Index - match.Length));
				}
				num2 = match.Index;
				ReplacementImplRTL(list, match);
				if (--count == 0)
				{
					break;
				}
				match = match.NextMatch();
			}
			while (match.Success);
			if (num2 > 0)
			{
				stringBuilder.Append(input, 0, num2);
			}
			for (int num3 = list.Count - 1; num3 >= 0; num3--)
			{
				stringBuilder.Append(list[num3]);
			}
		}
		return StringBuilderCache.GetStringAndRelease(stringBuilder);
	}
}
