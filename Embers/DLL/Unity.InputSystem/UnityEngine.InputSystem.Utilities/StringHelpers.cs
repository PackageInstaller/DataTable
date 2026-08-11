using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using System.Text;

namespace UnityEngine.InputSystem.Utilities;

internal static class StringHelpers
{
	public static string Escape(this string str, string chars = "\n\t\r\\\"", string replacements = "ntr\\\"")
	{
		if (str == null)
		{
			return null;
		}
		bool flag = false;
		string text = str;
		foreach (char value in text)
		{
			if (chars.Contains(value))
			{
				flag = true;
				break;
			}
		}
		if (!flag)
		{
			return str;
		}
		StringBuilder stringBuilder = new StringBuilder();
		text = str;
		foreach (char value2 in text)
		{
			int num = chars.IndexOf(value2);
			if (num == -1)
			{
				stringBuilder.Append(value2);
				continue;
			}
			stringBuilder.Append('\\');
			stringBuilder.Append(replacements[num]);
		}
		return stringBuilder.ToString();
	}

	public static string Unescape(this string str, string chars = "ntr\\\"", string replacements = "\n\t\r\\\"")
	{
		if (str == null)
		{
			return str;
		}
		if (!str.Contains('\\'))
		{
			return str;
		}
		StringBuilder stringBuilder = new StringBuilder();
		for (int i = 0; i < str.Length; i++)
		{
			char c = str[i];
			if (c == '\\' && i < str.Length - 2)
			{
				i++;
				c = str[i];
				int num = chars.IndexOf(c);
				if (num != -1)
				{
					stringBuilder.Append(replacements[num]);
				}
				else
				{
					stringBuilder.Append(c);
				}
			}
			else
			{
				stringBuilder.Append(c);
			}
		}
		return stringBuilder.ToString();
	}

	public static bool Contains(this string str, char ch)
	{
		if (str == null)
		{
			return false;
		}
		return str.IndexOf(ch) != -1;
	}

	public static bool Contains(this string str, string text, StringComparison comparison)
	{
		if (str == null)
		{
			return false;
		}
		return str.IndexOf(text, comparison) != -1;
	}

	public static string GetPlural(this string str)
	{
		if (str == null)
		{
			throw new ArgumentNullException("str");
		}
		return str switch
		{
			"Mouse" => "Mice", 
			"mouse" => "mice", 
			"Axis" => "Axes", 
			"axis" => "axes", 
			_ => str + "s", 
		};
	}

	public static string NicifyMemorySize(long numBytes)
	{
		if (numBytes > 1073741824)
		{
			long num = numBytes / 1073741824;
			float num2 = (float)(numBytes % 1073741824) / 1f;
			return $"{(float)num + num2} GB";
		}
		if (numBytes > 1048576)
		{
			long num3 = numBytes / 1048576;
			float num4 = (float)(numBytes % 1048576) / 1f;
			return $"{(float)num3 + num4} MB";
		}
		if (numBytes > 1024)
		{
			long num5 = numBytes / 1024;
			float num6 = (float)(numBytes % 1024) / 1f;
			return $"{(float)num5 + num6} KB";
		}
		return $"{numBytes} Bytes";
	}

	public static bool FromNicifiedMemorySize(string text, out long result, long defaultMultiplier = 1L)
	{
		text = text.Trim();
		long num = defaultMultiplier;
		if (text.EndsWith("MB", StringComparison.InvariantCultureIgnoreCase))
		{
			num = 1048576L;
			text = text.Substring(0, text.Length - 2);
		}
		else if (text.EndsWith("GB", StringComparison.InvariantCultureIgnoreCase))
		{
			num = 1073741824L;
			text = text.Substring(0, text.Length - 2);
		}
		else if (text.EndsWith("KB", StringComparison.InvariantCultureIgnoreCase))
		{
			num = 1024L;
			text = text.Substring(0, text.Length - 2);
		}
		else if (text.EndsWith("Bytes", StringComparison.InvariantCultureIgnoreCase))
		{
			num = 1L;
			text = text.Substring(0, text.Length - "Bytes".Length);
		}
		if (!long.TryParse(text, out var result2))
		{
			result = 0L;
			return false;
		}
		result = result2 * num;
		return true;
	}

	public static int CountOccurrences(this string str, char ch)
	{
		if (str == null)
		{
			return 0;
		}
		int length = str.Length;
		int num = 0;
		int num2 = 0;
		while (num < length)
		{
			int num3 = str.IndexOf(ch, num);
			if (num3 == -1)
			{
				break;
			}
			num2++;
			num = num3 + 1;
		}
		return num2;
	}

	public static IEnumerable<Substring> Tokenize(this string str)
	{
		int i = 0;
		int length = str.Length;
		while (i < length)
		{
			for (; i < length && char.IsWhiteSpace(str[i]); i++)
			{
			}
			if (i == length)
			{
				break;
			}
			if (str[i] == '"')
			{
				i++;
				int endPos = i;
				while (endPos < length && str[endPos] != '"')
				{
					int num;
					if (str[endPos] == '\\' && endPos < length - 1)
					{
						num = endPos + 1;
						endPos = num;
					}
					num = endPos + 1;
					endPos = num;
				}
				yield return new Substring(str, i, endPos - i);
				i = endPos + 1;
			}
			else
			{
				int endPos = i;
				while (endPos < length && !char.IsWhiteSpace(str[endPos]))
				{
					int num = endPos + 1;
					endPos = num;
				}
				yield return new Substring(str, i, endPos - i);
				i = endPos;
			}
		}
	}

	public static IEnumerable<string> Split(this string str, Func<char, bool> predicate)
	{
		if (string.IsNullOrEmpty(str))
		{
			yield break;
		}
		int length = str.Length;
		int position = 0;
		while (position < length)
		{
			char arg = str[position];
			int num;
			if (predicate(arg))
			{
				num = position + 1;
				position = num;
				continue;
			}
			int num2 = position;
			num = position + 1;
			for (position = num; position < length; position = num)
			{
				arg = str[position];
				if (predicate(arg))
				{
					break;
				}
				num = position + 1;
			}
			yield return str.Substring(num2, position - num2);
		}
	}

	public static string Join<TValue>(string separator, params TValue[] values)
	{
		return Join(values, separator);
	}

	public static string Join<TValue>(IEnumerable<TValue> values, string separator)
	{
		string text = null;
		int num = 0;
		StringBuilder stringBuilder = null;
		foreach (TValue value in values)
		{
			if (value == null)
			{
				continue;
			}
			string text2 = value.ToString();
			if (!string.IsNullOrEmpty(text2))
			{
				num++;
				switch (num)
				{
				case 1:
					text = text2;
					continue;
				case 2:
					stringBuilder = new StringBuilder();
					stringBuilder.Append(text);
					break;
				}
				stringBuilder.Append(separator);
				stringBuilder.Append(text2);
			}
		}
		return num switch
		{
			0 => null, 
			1 => text, 
			_ => stringBuilder.ToString(), 
		};
	}

	public static string MakeUniqueName<TExisting>(string baseName, IEnumerable<TExisting> existingSet, Func<TExisting, string> getNameFunc)
	{
		if (getNameFunc == null)
		{
			throw new ArgumentNullException("getNameFunc");
		}
		if (existingSet == null)
		{
			return baseName;
		}
		string text = baseName;
		string text2 = text.ToLower();
		bool flag = false;
		int num = 1;
		if (baseName.Length > 0)
		{
			int num2 = baseName.Length;
			while (num2 > 0 && char.IsDigit(baseName[num2 - 1]))
			{
				num2--;
			}
			if (num2 != baseName.Length)
			{
				num = int.Parse(baseName.Substring(num2)) + 1;
				baseName = baseName.Substring(0, num2);
			}
		}
		while (!flag)
		{
			flag = true;
			foreach (TExisting item in existingSet)
			{
				if (getNameFunc(item).ToLower() == text2)
				{
					text = $"{baseName}{num}";
					text2 = text.ToLower();
					flag = false;
					num++;
					break;
				}
			}
		}
		return text;
	}

	public static bool CharacterSeparatedListsHaveAtLeastOneCommonElement(string firstList, string secondList, char separator)
	{
		if (firstList == null)
		{
			throw new ArgumentNullException("firstList");
		}
		if (secondList == null)
		{
			throw new ArgumentNullException("secondList");
		}
		int num = 0;
		int length = firstList.Length;
		int length2 = secondList.Length;
		while (num < length)
		{
			if (firstList[num] == separator)
			{
				num++;
			}
			int i;
			for (i = num + 1; i < length && firstList[i] != separator; i++)
			{
			}
			int num2 = i - num;
			int num3 = 0;
			while (num3 < length2)
			{
				if (secondList[num3] == separator)
				{
					num3++;
				}
				int j;
				for (j = num3 + 1; j < length2 && secondList[j] != separator; j++)
				{
				}
				int num4 = j - num3;
				if (num2 == num4)
				{
					int num5 = num;
					int num6 = num3;
					bool flag = true;
					for (int k = 0; k < num2; k++)
					{
						char c = firstList[num5 + k];
						char c2 = secondList[num6 + k];
						if (char.ToLowerInvariant(c) != char.ToLowerInvariant(c2))
						{
							flag = false;
							break;
						}
					}
					if (flag)
					{
						return true;
					}
				}
				num3 = j + 1;
			}
			num = i + 1;
		}
		return false;
	}

	public static int ParseInt(string str, int pos)
	{
		int num = 1;
		int num2 = 0;
		int length = str.Length;
		while (pos < length)
		{
			int num3 = str[pos] - 48;
			if (num3 < 0 || num3 > 9)
			{
				break;
			}
			num2 = num2 * num + num3;
			num *= 10;
			pos++;
		}
		return num2;
	}

	public static bool WriteStringToBuffer(string text, IntPtr buffer, int bufferSizeInCharacters)
	{
		uint offset = 0u;
		return WriteStringToBuffer(text, buffer, bufferSizeInCharacters, ref offset);
	}

	public unsafe static bool WriteStringToBuffer(string text, IntPtr buffer, int bufferSizeInCharacters, ref uint offset)
	{
		if (buffer == IntPtr.Zero)
		{
			throw new ArgumentNullException("buffer");
		}
		int num = ((!string.IsNullOrEmpty(text)) ? text.Length : 0);
		if (num > 65535)
		{
			throw new ArgumentException($"String exceeds max size of {ushort.MaxValue} characters", "text");
		}
		long num2 = offset + 2 * num + 4;
		if (num2 > bufferSizeInCharacters)
		{
			return false;
		}
		byte* ptr = (byte*)(void*)buffer + offset;
		*(ushort*)ptr = (ushort)num;
		ptr += 2;
		int num3 = 0;
		while (num3 < num)
		{
			*(char*)ptr = text[num3];
			num3++;
			ptr += 2;
		}
		offset = (uint)num2;
		return true;
	}

	public static string ReadStringFromBuffer(IntPtr buffer, int bufferSize)
	{
		uint offset = 0u;
		return ReadStringFromBuffer(buffer, bufferSize, ref offset);
	}

	public unsafe static string ReadStringFromBuffer(IntPtr buffer, int bufferSize, ref uint offset)
	{
		if (buffer == IntPtr.Zero)
		{
			throw new ArgumentNullException("buffer");
		}
		if (offset + 4 > bufferSize)
		{
			return null;
		}
		byte* ptr = (byte*)(void*)buffer + offset;
		ushort num = *(ushort*)ptr;
		ptr += 2;
		if (num == 0)
		{
			return null;
		}
		long num2 = offset + 2 * num + 4;
		if (num2 > bufferSize)
		{
			return null;
		}
		string result = Marshal.PtrToStringUni(new IntPtr(ptr), num);
		offset = (uint)num2;
		return result;
	}

	public static bool IsPrintable(this char ch)
	{
		if (!char.IsControl(ch))
		{
			return !char.IsWhiteSpace(ch);
		}
		return false;
	}

	public static string WithAllWhitespaceStripped(this string str)
	{
		StringBuilder stringBuilder = new StringBuilder();
		foreach (char c in str)
		{
			if (!char.IsWhiteSpace(c))
			{
				stringBuilder.Append(c);
			}
		}
		return stringBuilder.ToString();
	}

	public static bool InvariantEqualsIgnoreCase(this string left, string right)
	{
		if (string.IsNullOrEmpty(left))
		{
			return string.IsNullOrEmpty(right);
		}
		return string.Equals(left, right, StringComparison.InvariantCultureIgnoreCase);
	}

	public static string ExpandTemplateString(string template, Func<string, string> mapFunc)
	{
		if (string.IsNullOrEmpty(template))
		{
			throw new ArgumentNullException("template");
		}
		if (mapFunc == null)
		{
			throw new ArgumentNullException("mapFunc");
		}
		StringBuilder stringBuilder = new StringBuilder();
		int length = template.Length;
		for (int i = 0; i < length; i++)
		{
			char c = template[i];
			if (c != '{')
			{
				stringBuilder.Append(c);
				continue;
			}
			i++;
			int num = i;
			for (; i < length && template[i] != '}'; i++)
			{
			}
			string arg = template.Substring(num, i - num);
			string value = mapFunc(arg);
			stringBuilder.Append(value);
		}
		return stringBuilder.ToString();
	}
}
