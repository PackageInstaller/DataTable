using System;

public static class StringExtensions
{
	public static string Reverse(this string str)
	{
		char[] array = str.ToCharArray();
		Array.Reverse(array);
		return new string(array);
	}
}
