using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Text;

namespace MiniJSON;

public static class Json
{
	private sealed class Parser : IDisposable
	{
		private enum TOKEN
		{
			NONE,
			CURLY_OPEN,
			CURLY_CLOSE,
			SQUARED_OPEN,
			SQUARED_CLOSE,
			COLON,
			COMMA,
			STRING,
			NUMBER,
			TRUE,
			FALSE,
			NULL
		}

		private const string WHITE_SPACE = " \t\n\r";

		private const string WORD_BREAK = " \t\n\r{}[],:\"";

		private StringReader json;

		private char PeekChar => Convert.ToChar(json.Peek());

		private char NextChar => Convert.ToChar(json.Read());

		private string NextWord
		{
			get
			{
				StringBuilder stringBuilder = new StringBuilder();
				while (" \t\n\r{}[],:\"".IndexOf(PeekChar) == -1)
				{
					stringBuilder.Append(NextChar);
					if (json.Peek() == -1)
					{
						break;
					}
				}
				return stringBuilder.ToString();
			}
		}

		private TOKEN NextToken
		{
			get
			{
				EatWhitespace();
				if (json.Peek() == -1)
				{
					return TOKEN.NONE;
				}
				switch (PeekChar)
				{
				case '{':
					return TOKEN.CURLY_OPEN;
				case '}':
					json.Read();
					return TOKEN.CURLY_CLOSE;
				case '[':
					return TOKEN.SQUARED_OPEN;
				case ']':
					json.Read();
					return TOKEN.SQUARED_CLOSE;
				case ',':
					json.Read();
					return TOKEN.COMMA;
				case '"':
					return TOKEN.STRING;
				case ':':
					return TOKEN.COLON;
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
					return TOKEN.NUMBER;
				default:
					return NextWord switch
					{
						"false" => TOKEN.FALSE, 
						"true" => TOKEN.TRUE, 
						"null" => TOKEN.NULL, 
						_ => TOKEN.NONE, 
					};
				}
			}
		}

		private Parser(string jsonString)
		{
			json = new StringReader(jsonString);
		}

		public static object Parse(string jsonString)
		{
			using Parser parser = new Parser(jsonString);
			return parser.ParseValue();
		}

		public void Dispose()
		{
			json.Dispose();
			json = null;
		}

		private Dictionary<string, object> ParseObject()
		{
			Dictionary<string, object> dictionary = new Dictionary<string, object>();
			json.Read();
			while (true)
			{
				switch (NextToken)
				{
				case TOKEN.COMMA:
					continue;
				case TOKEN.NONE:
					return null;
				case TOKEN.CURLY_CLOSE:
					return dictionary;
				}
				string text = ParseString();
				if (text == null)
				{
					return null;
				}
				if (NextToken != TOKEN.COLON)
				{
					return null;
				}
				json.Read();
				dictionary[text] = ParseValue();
			}
		}

		private List<object> ParseArray()
		{
			List<object> list = new List<object>();
			json.Read();
			bool flag = true;
			while (flag)
			{
				TOKEN nextToken = NextToken;
				switch (nextToken)
				{
				case TOKEN.NONE:
					return null;
				case TOKEN.SQUARED_CLOSE:
					flag = false;
					break;
				default:
				{
					object item = ParseByToken(nextToken);
					list.Add(item);
					break;
				}
				case TOKEN.COMMA:
					break;
				}
			}
			return list;
		}

		private object ParseValue()
		{
			TOKEN nextToken = NextToken;
			return ParseByToken(nextToken);
		}

		private object ParseByToken(TOKEN token)
		{
			return token switch
			{
				TOKEN.STRING => ParseString(), 
				TOKEN.NUMBER => ParseNumber(), 
				TOKEN.CURLY_OPEN => ParseObject(), 
				TOKEN.SQUARED_OPEN => ParseArray(), 
				TOKEN.TRUE => true, 
				TOKEN.FALSE => false, 
				TOKEN.NULL => null, 
				_ => null, 
			};
		}

		private string ParseString()
		{
			StringBuilder stringBuilder = new StringBuilder();
			json.Read();
			bool flag = true;
			while (flag)
			{
				if (json.Peek() == -1)
				{
					flag = false;
					break;
				}
				char nextChar = NextChar;
				switch (nextChar)
				{
				case '"':
					flag = false;
					break;
				case '\\':
					if (json.Peek() == -1)
					{
						flag = false;
						break;
					}
					nextChar = NextChar;
					switch (nextChar)
					{
					case '"':
					case '/':
					case '\\':
						stringBuilder.Append(nextChar);
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
					{
						StringBuilder stringBuilder2 = new StringBuilder();
						for (int i = 0; i < 4; i++)
						{
							stringBuilder2.Append(NextChar);
						}
						stringBuilder.Append((char)Convert.ToInt32(stringBuilder2.ToString(), 16));
						break;
					}
					}
					break;
				default:
					stringBuilder.Append(nextChar);
					break;
				}
			}
			return stringBuilder.ToString();
		}

		private object ParseNumber()
		{
			string nextWord = NextWord;
			if (nextWord.IndexOf('.') == -1)
			{
				long.TryParse(nextWord, out var result);
				return result;
			}
			double.TryParse(nextWord, out var result2);
			return result2;
		}

		private void EatWhitespace()
		{
			while (" \t\n\r".IndexOf(PeekChar) != -1)
			{
				json.Read();
				if (json.Peek() == -1)
				{
					break;
				}
			}
		}
	}

	private sealed class Serializer
	{
		private StringBuilder builder;

		private Serializer()
		{
			builder = new StringBuilder();
		}

		public static string Serialize(object obj)
		{
			Serializer serializer = new Serializer();
			serializer.SerializeValue(obj);
			return serializer.builder.ToString();
		}

		private void SerializeValue(object value)
		{
			if (value == null)
			{
				builder.Append("null");
			}
			else if (value is string str)
			{
				SerializeString(str);
			}
			else if (value is bool)
			{
				builder.Append(value.ToString().ToLower());
			}
			else if (value is IList anArray)
			{
				SerializeArray(anArray);
			}
			else if (value is IDictionary obj)
			{
				SerializeObject(obj);
			}
			else if (value is char)
			{
				SerializeString(value.ToString());
			}
			else
			{
				SerializeOther(value);
			}
		}

		private void SerializeObject(IDictionary obj)
		{
			bool flag = true;
			builder.Append('{');
			foreach (object key in obj.Keys)
			{
				if (!flag)
				{
					builder.Append(',');
				}
				SerializeString(key.ToString());
				builder.Append(':');
				SerializeValue(obj[key]);
				flag = false;
			}
			builder.Append('}');
		}

		private void SerializeArray(IList anArray)
		{
			builder.Append('[');
			bool flag = true;
			foreach (object item in anArray)
			{
				if (!flag)
				{
					builder.Append(',');
				}
				SerializeValue(item);
				flag = false;
			}
			builder.Append(']');
		}

		private void SerializeString(string str)
		{
			builder.Append('"');
			char[] array = str.ToCharArray();
			foreach (char c in array)
			{
				switch (c)
				{
				case '"':
					builder.Append("\\\"");
					continue;
				case '\\':
					builder.Append("\\\\");
					continue;
				case '\b':
					builder.Append("\\b");
					continue;
				case '\f':
					builder.Append("\\f");
					continue;
				case '\n':
					builder.Append("\\n");
					continue;
				case '\r':
					builder.Append("\\r");
					continue;
				case '\t':
					builder.Append("\\t");
					continue;
				}
				int num = Convert.ToInt32(c);
				if (num >= 32 && num <= 126)
				{
					builder.Append(c);
				}
				else
				{
					builder.Append("\\u" + Convert.ToString(num, 16).PadLeft(4, '0'));
				}
			}
			builder.Append('"');
		}

		private void SerializeOther(object value)
		{
			if (value is float || value is int || value is uint || value is long || value is double || value is sbyte || value is byte || value is short || value is ushort || value is ulong || value is decimal)
			{
				builder.Append(value.ToString());
			}
			else
			{
				SerializeString(value.ToString());
			}
		}
	}

	public static object Deserialize(string json)
	{
		if (json == null)
		{
			return null;
		}
		return Parser.Parse(json);
	}

	public static string Serialize(object obj)
	{
		return Serializer.Serialize(obj);
	}
}
