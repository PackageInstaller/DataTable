using System;
using System.Globalization;
using System.Text;

namespace SharpJson;

internal class Lexer
{
	public enum Token
	{
		None,
		Null,
		True,
		False,
		Colon,
		Comma,
		String,
		Number,
		CurlyOpen,
		CurlyClose,
		SquaredOpen,
		SquaredClose
	}

	private char[] json;

	private int index;

	private bool success = true;

	private char[] stringBuffer = new char[4096];

	public bool hasError => !success;

	public int lineNumber { get; private set; }

	public bool parseNumbersAsFloat { get; set; }

	public Lexer(string text)
	{
		Reset();
		json = text.ToCharArray();
		parseNumbersAsFloat = false;
	}

	public void Reset()
	{
		index = 0;
		lineNumber = 1;
		success = true;
	}

	public string ParseString()
	{
		int num = 0;
		StringBuilder stringBuilder = null;
		SkipWhiteSpaces();
		char c = json[index++];
		bool flag = false;
		bool flag2 = false;
		while (!flag2 && !flag && index != json.Length)
		{
			c = json[index++];
			if (c == '"')
			{
				flag2 = true;
				break;
			}
			if (c == '\\')
			{
				if (index == json.Length)
				{
					break;
				}
				switch (json[index++])
				{
				case '"':
					stringBuffer[num++] = '"';
					break;
				case '\\':
					stringBuffer[num++] = '\\';
					break;
				case '/':
					stringBuffer[num++] = '/';
					break;
				case 'b':
					stringBuffer[num++] = '\b';
					break;
				case 'f':
					stringBuffer[num++] = '\f';
					break;
				case 'n':
					stringBuffer[num++] = '\n';
					break;
				case 'r':
					stringBuffer[num++] = '\r';
					break;
				case 't':
					stringBuffer[num++] = '\t';
					break;
				case 'u':
					if (json.Length - index >= 4)
					{
						string value = new string(json, index, 4);
						stringBuffer[num++] = (char)Convert.ToInt32(value, 16);
						index += 4;
					}
					else
					{
						flag = true;
					}
					break;
				}
			}
			else
			{
				stringBuffer[num++] = c;
			}
			if (num >= stringBuffer.Length)
			{
				if (stringBuilder == null)
				{
					stringBuilder = new StringBuilder();
				}
				stringBuilder.Append(stringBuffer, 0, num);
				num = 0;
			}
		}
		if (!flag2)
		{
			success = false;
			return null;
		}
		if (stringBuilder != null)
		{
			return stringBuilder.ToString();
		}
		return new string(stringBuffer, 0, num);
	}

	private string GetNumberString()
	{
		SkipWhiteSpaces();
		int lastIndexOfNumber = GetLastIndexOfNumber(index);
		int length = lastIndexOfNumber - index + 1;
		string result = new string(json, index, length);
		index = lastIndexOfNumber + 1;
		return result;
	}

	public float ParseFloatNumber()
	{
		if (!float.TryParse(GetNumberString(), NumberStyles.Float, CultureInfo.InvariantCulture, out var result))
		{
			return 0f;
		}
		return result;
	}

	public double ParseDoubleNumber()
	{
		if (!double.TryParse(GetNumberString(), NumberStyles.Any, CultureInfo.InvariantCulture, out var result))
		{
			return 0.0;
		}
		return result;
	}

	private int GetLastIndexOfNumber(int index)
	{
		int i;
		for (i = index; i < json.Length; i++)
		{
			char c = json[i];
			if ((c < '0' || c > '9') && c != '+' && c != '-' && c != '.' && c != 'e' && c != 'E')
			{
				break;
			}
		}
		return i - 1;
	}

	private void SkipWhiteSpaces()
	{
		while (index < json.Length)
		{
			if (json[index] == '\n')
			{
				lineNumber++;
			}
			if (char.IsWhiteSpace(json[index]))
			{
				index++;
				continue;
			}
			break;
		}
	}

	public Token LookAhead()
	{
		SkipWhiteSpaces();
		int num = index;
		return NextToken(json, ref num);
	}

	public Token NextToken()
	{
		SkipWhiteSpaces();
		return NextToken(json, ref index);
	}

	private static Token NextToken(char[] json, ref int index)
	{
		if (index == json.Length)
		{
			return Token.None;
		}
		switch (json[index++])
		{
		case '{':
			return Token.CurlyOpen;
		case '}':
			return Token.CurlyClose;
		case '[':
			return Token.SquaredOpen;
		case ']':
			return Token.SquaredClose;
		case ',':
			return Token.Comma;
		case '"':
			return Token.String;
		case '-':
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
			return Token.Number;
		case ':':
			return Token.Colon;
		default:
		{
			index--;
			int num = json.Length - index;
			if (num >= 5 && json[index] == 'f' && json[index + 1] == 'a' && json[index + 2] == 'l' && json[index + 3] == 's' && json[index + 4] == 'e')
			{
				index += 5;
				return Token.False;
			}
			if (num >= 4 && json[index] == 't' && json[index + 1] == 'r' && json[index + 2] == 'u' && json[index + 3] == 'e')
			{
				index += 4;
				return Token.True;
			}
			if (num >= 4 && json[index] == 'n' && json[index + 1] == 'u' && json[index + 2] == 'l' && json[index + 3] == 'l')
			{
				index += 4;
				return Token.Null;
			}
			return Token.None;
		}
		}
	}
}
