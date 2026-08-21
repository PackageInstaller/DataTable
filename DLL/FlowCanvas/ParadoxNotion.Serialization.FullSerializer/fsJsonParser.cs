using System;
using System.Collections.Generic;
using System.Text;
using UnityEngine;

namespace ParadoxNotion.Serialization.FullSerializer;

public class fsJsonParser
{
	private int _start;

	private string _input;

	private readonly StringBuilder _cachedStringBuilder = new StringBuilder(256);

	private static fsJsonParser context;

	private fsResult MakeFailure(string message)
	{
		int num = Math.Max(0, _start - 20);
		int length = Math.Min(50, _input.Length - num);
		return fsResult.Fail("Error while parsing: " + message + "; context = <" + _input.Substring(num, length) + ">");
	}

	private bool TryMoveNext()
	{
		if (_start < _input.Length)
		{
			_start++;
			return true;
		}
		return false;
	}

	private bool HasValue()
	{
		return HasValue(0);
	}

	private bool HasValue(int offset)
	{
		if (_start + offset >= 0)
		{
			return _start + offset < _input.Length;
		}
		return false;
	}

	private char Character()
	{
		return Character(0);
	}

	private char Character(int offset)
	{
		return _input[_start + offset];
	}

	private void SkipSpace()
	{
		while (HasValue())
		{
			if (char.IsWhiteSpace(Character()))
			{
				TryMoveNext();
				continue;
			}
			if (!HasValue(1) || Character(0) != '/')
			{
				break;
			}
			if (Character(1) == '/')
			{
				while (HasValue() && !Environment.NewLine.Contains(Character().ToString() ?? ""))
				{
					TryMoveNext();
				}
			}
			else
			{
				if (Character(1) != '*')
				{
					continue;
				}
				TryMoveNext();
				TryMoveNext();
				while (HasValue(1))
				{
					if (Character(0) == '*' && Character(1) == '/')
					{
						TryMoveNext();
						TryMoveNext();
						TryMoveNext();
						break;
					}
					TryMoveNext();
				}
			}
		}
	}

	private fsResult SkipKeyword()
	{
		SkipSpace();
		if (!HasValue())
		{
			return MakeFailure("Unexpected end of input");
		}
		switch (Character())
		{
		case '+':
		case '-':
		case '.':
		case '0':
		case '1':
		case '2':
		case '3':
		case '4':
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
		case 'I':
		case 'N':
			while (TryMoveNext() && HasValue() && !IsSeparator(Character()))
			{
			}
			break;
		case '"':
			while (TryMoveNext() && HasValue() && Character() != '"')
			{
			}
			if (!HasValue() || Character() != '"' || !TryMoveNext())
			{
				return MakeFailure("No closing \" when parsing a string");
			}
			break;
		case '[':
			SkipSpace();
			try
			{
				int num = 1;
				while (TryMoveNext() && HasValue())
				{
					if (Character() == '[')
					{
						num++;
					}
					else if (Character() == ']')
					{
						num--;
					}
					if (num == 0)
					{
						break;
					}
				}
				if (!HasValue() || Character() != ']' || !TryMoveNext())
				{
					return MakeFailure("No closing ] for array");
				}
			}
			catch (Exception ex)
			{
				Debug.LogError(ex.ToString());
			}
			break;
		case '{':
			while (TryMoveNext() && HasValue() && Character() != '}')
			{
				SkipSpace();
			}
			if (!HasValue() || Character() != '}' || !TryMoveNext())
			{
				return MakeFailure("No closing } for object");
			}
			break;
		default:
			return MakeFailure("unable to parse; invalid token \"" + Character() + "\"");
		}
		SkipSpace();
		if (HasValue() && Character() == ',')
		{
			if (!TryMoveNext())
			{
				return fsResult.Fail("不完整的json格式");
			}
			SkipSpace();
		}
		return fsResult.Success;
	}

	private bool IsHex(char c)
	{
		if ((c < '0' || c > '9') && (c < 'a' || c > 'f'))
		{
			if (c >= 'A')
			{
				return c <= 'F';
			}
			return false;
		}
		return true;
	}

	private uint ParseSingleChar(char c1, uint multipliyer)
	{
		uint result = 0u;
		if (c1 >= '0' && c1 <= '9')
		{
			result = (uint)(c1 - 48) * multipliyer;
		}
		else if (c1 >= 'A' && c1 <= 'F')
		{
			result = (uint)(c1 - 65 + 10) * multipliyer;
		}
		else if (c1 >= 'a' && c1 <= 'f')
		{
			result = (uint)(c1 - 97 + 10) * multipliyer;
		}
		return result;
	}

	private uint ParseUnicode(char c1, char c2, char c3, char c4)
	{
		uint num = ParseSingleChar(c1, 4096u);
		uint num2 = ParseSingleChar(c2, 256u);
		uint num3 = ParseSingleChar(c3, 16u);
		uint num4 = ParseSingleChar(c4, 1u);
		return num + num2 + num3 + num4;
	}

	private fsResult TryUnescapeChar(out char escaped)
	{
		TryMoveNext();
		if (!HasValue())
		{
			escaped = ' ';
			return MakeFailure("Unexpected end of input after \\");
		}
		switch (Character())
		{
		case '\\':
			TryMoveNext();
			escaped = '\\';
			return fsResult.Success;
		case '/':
			TryMoveNext();
			escaped = '/';
			return fsResult.Success;
		case '"':
			TryMoveNext();
			escaped = '"';
			return fsResult.Success;
		case 'a':
			TryMoveNext();
			escaped = '\a';
			return fsResult.Success;
		case 'b':
			TryMoveNext();
			escaped = '\b';
			return fsResult.Success;
		case 'f':
			TryMoveNext();
			escaped = '\f';
			return fsResult.Success;
		case 'n':
			TryMoveNext();
			escaped = '\n';
			return fsResult.Success;
		case 'r':
			TryMoveNext();
			escaped = '\r';
			return fsResult.Success;
		case 't':
			TryMoveNext();
			escaped = '\t';
			return fsResult.Success;
		case '0':
			TryMoveNext();
			escaped = '\0';
			return fsResult.Success;
		case 'u':
			TryMoveNext();
			if (IsHex(Character(0)) && IsHex(Character(1)) && IsHex(Character(2)) && IsHex(Character(3)))
			{
				uint num = ParseUnicode(Character(0), Character(1), Character(2), Character(3));
				TryMoveNext();
				TryMoveNext();
				TryMoveNext();
				TryMoveNext();
				escaped = (char)num;
				return fsResult.Success;
			}
			escaped = '\0';
			return MakeFailure($"invalid escape sequence '\\u{Character(0)}{Character(1)}{Character(2)}{Character(3)}'\n");
		default:
			escaped = '\0';
			return MakeFailure($"Invalid escape sequence \\{Character()}");
		}
	}

	private fsResult TryParseExact(string content)
	{
		for (int i = 0; i < content.Length; i++)
		{
			if (Character() != content[i])
			{
				return MakeFailure("Expected " + content[i]);
			}
			if (!TryMoveNext())
			{
				return MakeFailure("Unexpected end of content when parsing " + content);
			}
		}
		return fsResult.Success;
	}

	private fsResult TryParseTrue(out fsData data)
	{
		fsResult result = TryParseExact("true");
		if (result.Succeeded)
		{
			data = new fsData(boolean: true);
			return fsResult.Success;
		}
		data = null;
		return result;
	}

	private fsResult TryParseFalse(out fsData data)
	{
		fsResult result = TryParseExact("false");
		if (result.Succeeded)
		{
			data = new fsData(boolean: false);
			return fsResult.Success;
		}
		data = null;
		return result;
	}

	private fsResult TryParseNull(out fsData data)
	{
		fsResult result = TryParseExact("null");
		if (result.Succeeded)
		{
			data = new fsData();
			return fsResult.Success;
		}
		data = null;
		return result;
	}

	private bool IsSeparator(char c)
	{
		if (!char.IsWhiteSpace(c) && c != ',' && c != '}')
		{
			return c == ']';
		}
		return true;
	}

	private unsafe fsResult TryParseNumber(out fsData data)
	{
		int start = _start;
		while (TryMoveNext() && HasValue() && !IsSeparator(Character()))
		{
		}
		fixed (char* input = _input)
		{
			int num = _start - start;
			if (num == 0)
			{
				data = new fsData(0L);
				return fsResult.Success;
			}
			bool flag = false;
			for (int i = 0; i < num; i++)
			{
				char c = input[start + i];
				if (c == '.' || c == 'e' || c == 'E' || c == 'N' || c == 'I')
				{
					flag = true;
					break;
				}
			}
			char* ptr = stackalloc char[num];
			for (int j = 0; j < num; j++)
			{
				ptr[j] = input[start + j];
			}
			if (flag)
			{
				double f = atof(ptr);
				data = new fsData(f);
				return fsResult.Success;
			}
			long i2 = atol(ptr);
			data = new fsData(i2);
			return fsResult.Success;
		}
	}

	public unsafe static double atof(char* str)
	{
		double num = 0.0;
		double num2 = 10.0;
		int num3 = 0;
		bool flag = false;
		while (char.IsWhiteSpace(*str))
		{
			str++;
		}
		if (*str == '-')
		{
			flag = true;
			str++;
		}
		if (*str == 'I')
		{
			if (flag)
			{
				return double.NegativeInfinity;
			}
			return double.PositiveInfinity;
		}
		if (*str == 'N')
		{
			return double.NaN;
		}
		if (*str < '0' || *str > '9')
		{
			return num;
		}
		while (*str >= '0' && *str <= '9' && *str != '.')
		{
			num = num * 10.0 + (double)(int)(*str) - 48.0;
			str++;
		}
		if (*str == '.')
		{
			str++;
		}
		while (*str >= '0' && *str <= '9')
		{
			num += (double)(*str - 48) / num2;
			num2 *= 10.0;
			str++;
		}
		if (*str == 'e' || *str == 'E')
		{
			str++;
			if (*str == '+')
			{
				str++;
				while (*str >= '0' && *str <= '9')
				{
					num3 = num3 * 10 + *str - 48;
					str++;
				}
				while (num3 > 0)
				{
					num *= 10.0;
					num3--;
				}
			}
			if (*str == '-')
			{
				str++;
				while (*str >= '0' && *str <= '9')
				{
					num3 = num3 * 10 + *str - 48;
					str++;
				}
				while (num3 > 0)
				{
					num /= 10.0;
					num3--;
				}
			}
		}
		return num * (flag ? (-1.0) : 1.0);
	}

	public unsafe static int atoi(char* pstr)
	{
		int num = 0;
		int num2 = 1;
		if (pstr == null)
		{
			Debug.LogError("Pointer is NULL\n");
			return 0;
		}
		while (char.IsWhiteSpace(*pstr))
		{
			pstr++;
		}
		if (*pstr == '-')
		{
			num2 = -1;
		}
		if (*pstr == '-' || *pstr == '+')
		{
			pstr++;
		}
		while (*pstr >= '0' && *pstr <= '9')
		{
			num = num * 10 + *pstr - 48;
			pstr++;
		}
		return num2 * num;
	}

	public unsafe static long atol(char* pstr)
	{
		long num = 0L;
		int num2 = 1;
		if (pstr == null)
		{
			Debug.LogError("Pointer is NULL\n");
			return 0L;
		}
		while (char.IsWhiteSpace(*pstr))
		{
			pstr++;
		}
		if (*pstr == '-')
		{
			num2 = -1;
		}
		if (*pstr == '-' || *pstr == '+')
		{
			pstr++;
		}
		while (*pstr >= '0' && *pstr <= '9')
		{
			num = num * 10 + *pstr - 48;
			pstr++;
		}
		return num2 * num;
	}

	private fsResult TryParseString(out string str)
	{
		_cachedStringBuilder.Length = 0;
		if (Character() != '"' || !TryMoveNext())
		{
			str = string.Empty;
			return MakeFailure("Expected initial \" when parsing a string");
		}
		while (HasValue() && Character() != '"')
		{
			char c = Character();
			if (c == '\\')
			{
				fsResult result = TryUnescapeChar(out var escaped);
				if (result.Failed)
				{
					str = string.Empty;
					return result;
				}
				_cachedStringBuilder.Append(escaped);
			}
			else
			{
				_cachedStringBuilder.Append(c);
				if (!TryMoveNext())
				{
					str = string.Empty;
					return MakeFailure("Unexpected end of input when reading a string");
				}
			}
		}
		if (!HasValue() || Character() != '"' || !TryMoveNext())
		{
			str = string.Empty;
			return MakeFailure("No closing \" when parsing a string");
		}
		str = _cachedStringBuilder.ToString();
		return fsResult.Success;
	}

	private fsResult TryParseArray(out fsData arr)
	{
		if (Character() != '[')
		{
			arr = null;
			return MakeFailure("Expected initial [ when parsing an array");
		}
		if (!TryMoveNext())
		{
			arr = null;
			return MakeFailure("Unexpected end of input when parsing an array");
		}
		SkipSpace();
		List<fsData> list = new List<fsData>();
		while (HasValue() && Character() != ']')
		{
			fsResult result = RunParse(out var data);
			if (result.Failed)
			{
				arr = null;
				return result;
			}
			list.Add(data);
			SkipSpace();
			if (HasValue() && Character() == ',')
			{
				if (!TryMoveNext())
				{
					break;
				}
				SkipSpace();
			}
		}
		if (!HasValue() || Character() != ']' || !TryMoveNext())
		{
			arr = null;
			return MakeFailure("No closing ] for array");
		}
		arr = new fsData(list);
		return fsResult.Success;
	}

	private fsResult TryParseObject(out fsData obj)
	{
		if (Character() != '{')
		{
			obj = null;
			return MakeFailure("Expected initial { when parsing an object");
		}
		if (!TryMoveNext())
		{
			obj = null;
			return MakeFailure("Unexpected end of input when parsing an object");
		}
		SkipSpace();
		Dictionary<string, fsData> dictionary = new Dictionary<string, fsData>(fsGlobalConfig.IsCaseSensitive ? StringComparer.Ordinal : StringComparer.OrdinalIgnoreCase);
		while (HasValue() && Character() != '}')
		{
			SkipSpace();
			fsResult result = TryParseString(out var str);
			if (result.Failed)
			{
				obj = null;
				return result;
			}
			SkipSpace();
			if (!HasValue() || Character() != ':' || !TryMoveNext())
			{
				obj = null;
				return MakeFailure("Expected : after key \"" + str + "\"");
			}
			SkipSpace();
			switch (str)
			{
			case "_position":
				SkipKeyword();
				continue;
			case "_tag":
				SkipKeyword();
				continue;
			case "_color":
				SkipKeyword();
				continue;
			case "_comment":
				SkipKeyword();
				continue;
			case "canvasGroups":
				SkipKeyword();
				continue;
			}
			result = RunParse(out var data);
			if (result.Failed)
			{
				obj = null;
				return result;
			}
			dictionary.Add(str, data);
			SkipSpace();
			if (HasValue() && Character() == ',')
			{
				if (!TryMoveNext())
				{
					break;
				}
				SkipSpace();
			}
		}
		if (!HasValue() || Character() != '}' || !TryMoveNext())
		{
			obj = null;
			return MakeFailure("No closing } for object");
		}
		obj = new fsData(dictionary);
		return fsResult.Success;
	}

	private fsResult RunParse(out fsData data)
	{
		SkipSpace();
		if (!HasValue())
		{
			data = null;
			return MakeFailure("Unexpected end of input");
		}
		switch (Character())
		{
		case '+':
		case '-':
		case '.':
		case '0':
		case '1':
		case '2':
		case '3':
		case '4':
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
		case 'I':
		case 'N':
			return TryParseNumber(out data);
		case '"':
		{
			fsResult result = TryParseString(out var str);
			if (result.Failed)
			{
				data = null;
				return result;
			}
			data = new fsData(str);
			return fsResult.Success;
		}
		case '[':
			return TryParseArray(out data);
		case '{':
			return TryParseObject(out data);
		case 't':
			return TryParseTrue(out data);
		case 'f':
			return TryParseFalse(out data);
		case 'n':
			return TryParseNull(out data);
		default:
			data = null;
			return MakeFailure("unable to parse; invalid token \"" + Character() + "\"");
		}
	}

	public static fsResult Parse(string input, out fsData data)
	{
		if (string.IsNullOrEmpty(input))
		{
			data = null;
			return fsResult.Fail("No input");
		}
		if (context == null)
		{
			context = new fsJsonParser(input);
		}
		context.Reset(input, 0);
		return context.RunParse(out data);
	}

	public static fsData Parse(string input)
	{
		Parse(input, out var data).AssertSuccess();
		return data;
	}

	private fsJsonParser(string input)
	{
		_input = input;
		_start = 0;
	}

	private void Reset(string input, int start)
	{
		_input = input;
		_start = start;
	}
}
