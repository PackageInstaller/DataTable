using System.Text;

namespace System;

internal static class PasteArguments
{
	internal static void AppendArgument(StringBuilder stringBuilder, string argument)
	{
		if (stringBuilder.Length != 0)
		{
			stringBuilder.Append(' ');
		}
		if (argument.Length != 0 && ContainsNoWhitespaceOrQuotes(argument))
		{
			stringBuilder.Append(argument);
			return;
		}
		stringBuilder.Append('"');
		int num = 0;
		while (num < argument.Length)
		{
			char c = argument[num++];
			switch (c)
			{
			case '\\':
			{
				int num2 = 1;
				while (num < argument.Length && argument[num] == '\\')
				{
					num++;
					num2++;
				}
				if (num == argument.Length)
				{
					stringBuilder.Append('\\', num2 * 2);
				}
				else if (argument[num] == '"')
				{
					stringBuilder.Append('\\', num2 * 2 + 1);
					stringBuilder.Append('"');
					num++;
				}
				else
				{
					stringBuilder.Append('\\', num2);
				}
				break;
			}
			case '"':
				stringBuilder.Append('\\');
				stringBuilder.Append('"');
				break;
			default:
				stringBuilder.Append(c);
				break;
			}
		}
		stringBuilder.Append('"');
	}

	private static bool ContainsNoWhitespaceOrQuotes(string s)
	{
		foreach (char c in s)
		{
			if (char.IsWhiteSpace(c) || c == '"')
			{
				return false;
			}
		}
		return true;
	}
}
