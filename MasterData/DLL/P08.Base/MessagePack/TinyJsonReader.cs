using System;
using System.Globalization;
using System.IO;
using System.Text;

namespace MessagePack;

internal class TinyJsonReader : IDisposable
{
	private readonly TextReader reader;

	private readonly bool disposeInnerReader;

	private StringBuilder reusableBuilder;

	public TinyJsonToken TokenType { get; private set; }

	public ValueType ValueType { get; private set; }

	public double DoubleValue { get; private set; }

	public long LongValue { get; private set; }

	public ulong ULongValue { get; private set; }

	public decimal DecimalValue { get; private set; }

	public string StringValue { get; private set; }

	public TinyJsonReader(TextReader reader, bool disposeInnerReader = true)
	{
		this.reader = reader;
		this.disposeInnerReader = disposeInnerReader;
	}

	public bool Read()
	{
		ReadNextToken();
		ReadValue();
		return TokenType != TinyJsonToken.None;
	}

	public void Dispose()
	{
		if (reader != null && disposeInnerReader)
		{
			reader.Dispose();
		}
		TokenType = TinyJsonToken.None;
		ValueType = ValueType.Null;
	}

	private void SkipWhiteSpace()
	{
		int num = reader.Peek();
		while (num != -1 && char.IsWhiteSpace((char)num))
		{
			reader.Read();
			num = reader.Peek();
		}
	}

	private char ReadChar()
	{
		return (char)reader.Read();
	}

	private static bool IsWordBreak(char c)
	{
		switch (c)
		{
		case ' ':
		case '"':
		case ',':
		case ':':
		case '[':
		case ']':
		case '{':
		case '}':
			return true;
		default:
			return false;
		}
	}

	private void ReadNextToken()
	{
		SkipWhiteSpace();
		int num = reader.Peek();
		if (num == -1)
		{
			TokenType = TinyJsonToken.None;
			return;
		}
		char c = (char)num;
		switch (c)
		{
		case '{':
			TokenType = TinyJsonToken.StartObject;
			break;
		case '}':
			TokenType = TinyJsonToken.EndObject;
			break;
		case '[':
			TokenType = TinyJsonToken.StartArray;
			break;
		case ']':
			TokenType = TinyJsonToken.EndArray;
			break;
		case '"':
			TokenType = TinyJsonToken.String;
			break;
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
			TokenType = TinyJsonToken.Number;
			break;
		case 't':
			TokenType = TinyJsonToken.True;
			break;
		case 'f':
			TokenType = TinyJsonToken.False;
			break;
		case 'n':
			TokenType = TinyJsonToken.Null;
			break;
		case ',':
		case ':':
			reader.Read();
			ReadNextToken();
			break;
		default:
			throw new TinyJsonException("Invalid String:" + c);
		}
	}

	private void ReadValue()
	{
		ValueType = ValueType.Null;
		switch (TokenType)
		{
		case TinyJsonToken.StartObject:
		case TinyJsonToken.EndObject:
		case TinyJsonToken.StartArray:
		case TinyJsonToken.EndArray:
			reader.Read();
			break;
		case TinyJsonToken.Number:
			ReadNumber();
			break;
		case TinyJsonToken.String:
			ReadString();
			break;
		case TinyJsonToken.True:
			if (ReadChar() != 't')
			{
				throw new TinyJsonException("Invalid Token");
			}
			if (ReadChar() != 'r')
			{
				throw new TinyJsonException("Invalid Token");
			}
			if (ReadChar() != 'u')
			{
				throw new TinyJsonException("Invalid Token");
			}
			if (ReadChar() != 'e')
			{
				throw new TinyJsonException("Invalid Token");
			}
			ValueType = ValueType.True;
			break;
		case TinyJsonToken.False:
			if (ReadChar() != 'f')
			{
				throw new TinyJsonException("Invalid Token");
			}
			if (ReadChar() != 'a')
			{
				throw new TinyJsonException("Invalid Token");
			}
			if (ReadChar() != 'l')
			{
				throw new TinyJsonException("Invalid Token");
			}
			if (ReadChar() != 's')
			{
				throw new TinyJsonException("Invalid Token");
			}
			if (ReadChar() != 'e')
			{
				throw new TinyJsonException("Invalid Token");
			}
			ValueType = ValueType.False;
			break;
		case TinyJsonToken.Null:
			if (ReadChar() != 'n')
			{
				throw new TinyJsonException("Invalid Token");
			}
			if (ReadChar() != 'u')
			{
				throw new TinyJsonException("Invalid Token");
			}
			if (ReadChar() != 'l')
			{
				throw new TinyJsonException("Invalid Token");
			}
			if (ReadChar() != 'l')
			{
				throw new TinyJsonException("Invalid Token");
			}
			ValueType = ValueType.Null;
			break;
		default:
			throw new MessagePackSerializationException("InvalidTokenState:" + TokenType);
		case TinyJsonToken.None:
			break;
		}
	}

	private void ReadNumber()
	{
		StringBuilder stringBuilder;
		if (reusableBuilder == null)
		{
			reusableBuilder = new StringBuilder();
			stringBuilder = reusableBuilder;
		}
		else
		{
			stringBuilder = reusableBuilder;
			stringBuilder.Length = 0;
		}
		bool flag = false;
		int num = reader.Peek();
		while (num != -1 && !IsWordBreak((char)num))
		{
			char c = ReadChar();
			stringBuilder.Append(c);
			if (c == '.' || c == 'e' || c == 'E')
			{
				flag = true;
			}
			num = reader.Peek();
		}
		string s = stringBuilder.ToString();
		long result2;
		ulong result3;
		decimal result4;
		if (flag)
		{
			double.TryParse(s, NumberStyles.Float | NumberStyles.AllowThousands, CultureInfo.InvariantCulture, out var result);
			ValueType = ValueType.Double;
			DoubleValue = result;
		}
		else if (long.TryParse(s, NumberStyles.Integer, CultureInfo.InvariantCulture, out result2))
		{
			ValueType = ValueType.Long;
			LongValue = result2;
		}
		else if (ulong.TryParse(s, NumberStyles.Integer, CultureInfo.InvariantCulture, out result3))
		{
			ValueType = ValueType.ULong;
			ULongValue = result3;
		}
		else if (decimal.TryParse(s, NumberStyles.Number, CultureInfo.InvariantCulture, out result4))
		{
			ValueType = ValueType.Decimal;
			DecimalValue = result4;
		}
	}

	private void ReadString()
	{
		reader.Read();
		StringBuilder stringBuilder;
		if (reusableBuilder == null)
		{
			reusableBuilder = new StringBuilder();
			stringBuilder = reusableBuilder;
		}
		else
		{
			stringBuilder = reusableBuilder;
			stringBuilder.Length = 0;
		}
		while (reader.Peek() != -1)
		{
			char c = ReadChar();
			switch (c)
			{
			case '\\':
				if (reader.Peek() == -1)
				{
					throw new TinyJsonException("Invalid Json String");
				}
				c = ReadChar();
				switch (c)
				{
				case '"':
				case '/':
				case '\\':
					stringBuilder.Append(c);
					break;
				case 'b':
					stringBuilder.Append('\b');
					break;
				case 'f':
					stringBuilder.Append('\f');
					break;
				case 'n':
					stringBuilder.Append('\n');
					break;
				case 'r':
					stringBuilder.Append('\r');
					break;
				case 't':
					stringBuilder.Append('\t');
					break;
				case 'u':
					stringBuilder.Append((char)Convert.ToInt32(new string(new char[4]
					{
						ReadChar(),
						ReadChar(),
						ReadChar(),
						ReadChar()
					}), 16));
					break;
				}
				break;
			default:
				stringBuilder.Append(c);
				break;
			case '"':
				ValueType = ValueType.String;
				StringValue = stringBuilder.ToString();
				return;
			}
		}
		throw new TinyJsonException("Invalid Json String");
	}
}
