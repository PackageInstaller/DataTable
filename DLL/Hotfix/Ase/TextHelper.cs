using System.Collections;
using System.Collections.Generic;
using System.Linq;

namespace Ase;

public static class TextHelper
{
	public static object[] Format<T>(this IEnumerable<T> paramList)
	{
		T[] array = (paramList as T[]) ?? paramList.ToArray();
		if (!array.Any())
		{
			return null;
		}
		object[] array2 = new object[array.Count()];
		IEnumerator enumerator = array.GetEnumerator();
		int num = 0;
		while (enumerator.MoveNext())
		{
			array2[num++] = enumerator.Current;
		}
		return array2;
	}

	public static string IntToRoman(int num)
	{
		string text = string.Empty;
		List<int> list = new List<int>
		{
			1000, 900, 500, 400, 100, 90, 50, 40, 10, 9,
			5, 4, 1
		};
		List<string> list2 = new List<string>
		{
			"M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX",
			"V", "IV", "I"
		};
		for (int i = 0; i < list.Count; i++)
		{
			while (num >= list[i])
			{
				num -= list[i];
				text += list2[i];
			}
		}
		return text;
	}
}
