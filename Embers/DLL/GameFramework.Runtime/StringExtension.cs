public static class StringExtension
{
	public static string ReadLine(this string rawString, ref int position)
	{
		if (position < 0)
		{
			return null;
		}
		int length = rawString.Length;
		int num = position;
		while (num < length)
		{
			char c = rawString[num];
			char c2 = c;
			char c3 = c2;
			if (c3 == '\n' || c3 == '\r')
			{
				if (num > position)
				{
					string result = rawString.Substring(position, num - position);
					position = num + 1;
					if (c == '\r' && position < length && rawString[position] == '\n')
					{
						position++;
					}
					return result;
				}
				num++;
				position++;
			}
			else
			{
				num++;
			}
		}
		if (num > position)
		{
			string result2 = rawString.Substring(position, num - position);
			position = num;
			return result2;
		}
		return null;
	}
}
