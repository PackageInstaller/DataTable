namespace System.IO;

internal class SearchPattern2
{
	private class Op
	{
		public OpCode Code;

		public string Argument;

		public Op Next;

		public Op(OpCode code)
		{
			Code = code;
			Argument = null;
			Next = null;
		}
	}

	private enum OpCode
	{
		ExactString,
		AnyChar,
		AnyString,
		End,
		True
	}

	private Op ops;

	private bool ignore;

	private bool hasWildcard;

	private string pattern;

	internal static readonly char[] WildcardChars = new char[2] { '*', '?' };

	internal static readonly char[] InvalidChars = new char[2]
	{
		Path.DirectorySeparatorChar,
		Path.AltDirectorySeparatorChar
	};

	public bool HasWildcard => hasWildcard;

	public SearchPattern2(string pattern)
		: this(pattern, ignore: false)
	{
	}

	public SearchPattern2(string pattern, bool ignore)
	{
		this.ignore = ignore;
		this.pattern = pattern;
		Compile(pattern);
	}

	private void Compile(string pattern)
	{
		if (pattern == null || pattern.IndexOfAny(InvalidChars) >= 0)
		{
			throw new ArgumentException("Invalid search pattern: '" + pattern + "'");
		}
		if (pattern == "*")
		{
			ops = new Op(OpCode.True);
			hasWildcard = true;
			return;
		}
		ops = null;
		int num = 0;
		Op op = null;
		while (num < pattern.Length)
		{
			Op op2;
			switch (pattern[num])
			{
			case '?':
				op2 = new Op(OpCode.AnyChar);
				num++;
				hasWildcard = true;
				break;
			case '*':
				op2 = new Op(OpCode.AnyString);
				num++;
				hasWildcard = true;
				break;
			default:
			{
				op2 = new Op(OpCode.ExactString);
				int num2 = pattern.IndexOfAny(WildcardChars, num);
				if (num2 < 0)
				{
					num2 = pattern.Length;
				}
				op2.Argument = pattern.Substring(num, num2 - num);
				if (ignore)
				{
					op2.Argument = op2.Argument.ToLower();
				}
				num = num2;
				break;
			}
			}
			if (op == null)
			{
				ops = op2;
			}
			else
			{
				op.Next = op2;
			}
			op = op2;
		}
		if (op == null)
		{
			ops = new Op(OpCode.End);
		}
		else
		{
			op.Next = new Op(OpCode.End);
		}
	}
}
