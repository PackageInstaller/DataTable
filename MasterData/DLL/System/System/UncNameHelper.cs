namespace System;

internal class UncNameHelper
{
	internal static string ParseCanonicalName(string str, int start, int end, ref bool loopback)
	{
		return DomainNameHelper.ParseCanonicalName(str, start, end, ref loopback);
	}

	internal unsafe static bool IsValid(char* name, ushort start, ref int returnedEnd, bool notImplicitFile)
	{
		ushort num = (ushort)returnedEnd;
		if (start == num)
		{
			return false;
		}
		bool flag = false;
		ushort num2;
		for (num2 = start; num2 < num; num2++)
		{
			if (name[(int)num2] == '/' || name[(int)num2] == '\\' || (notImplicitFile && (name[(int)num2] == ':' || name[(int)num2] == '?' || name[(int)num2] == '#')))
			{
				num = num2;
				break;
			}
			if (name[(int)num2] == '.')
			{
				num2++;
				break;
			}
			if (char.IsLetter(name[(int)num2]) || name[(int)num2] == '-' || name[(int)num2] == '_')
			{
				flag = true;
			}
			else if (name[(int)num2] < '0' || name[(int)num2] > '9')
			{
				return false;
			}
		}
		if (!flag)
		{
			return false;
		}
		while (num2 < num)
		{
			if (name[(int)num2] == '/' || name[(int)num2] == '\\' || (notImplicitFile && (name[(int)num2] == ':' || name[(int)num2] == '?' || name[(int)num2] == '#')))
			{
				num = num2;
				break;
			}
			if (name[(int)num2] == '.')
			{
				if (!flag || (num2 - 1 >= start && name[num2 - 1] == '.'))
				{
					return false;
				}
				flag = false;
			}
			else if (name[(int)num2] == '-' || name[(int)num2] == '_')
			{
				if (!flag)
				{
					return false;
				}
			}
			else
			{
				if (!char.IsLetter(name[(int)num2]) && (name[(int)num2] < '0' || name[(int)num2] > '9'))
				{
					return false;
				}
				if (!flag)
				{
					flag = true;
				}
			}
			num2++;
		}
		if (num2 - 1 >= start && name[num2 - 1] == '.')
		{
			flag = true;
		}
		if (!flag)
		{
			return false;
		}
		returnedEnd = num;
		return true;
	}
}
