using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Text;

namespace Google.Protobuf;

internal abstract class JsonTokenizer
{
	private class JsonReplayTokenizer : JsonTokenizer
	{
		private readonly IList<JsonToken> tokens;

		private readonly JsonTokenizer nextTokenizer;

		private int nextTokenIndex;

		internal JsonReplayTokenizer(IList<JsonToken> tokens, JsonTokenizer nextTokenizer)
		{
			this.tokens = tokens;
			this.nextTokenizer = nextTokenizer;
		}

		protected override JsonToken NextImpl()
		{
			if (nextTokenIndex >= tokens.Count)
			{
				return nextTokenizer.Next();
			}
			return tokens[nextTokenIndex++];
		}
	}

	private sealed class JsonTextTokenizer : JsonTokenizer
	{
		private enum ContainerType
		{
			Document,
			Object,
			Array
		}

		[Flags]
		private enum State
		{
			StartOfDocument = 1,
			ExpectedEndOfDocument = 2,
			ReaderExhausted = 4,
			ObjectStart = 8,
			ObjectBeforeColon = 0x10,
			ObjectAfterColon = 0x20,
			ObjectAfterProperty = 0x40,
			ObjectAfterComma = 0x80,
			ArrayStart = 0x100,
			ArrayAfterValue = 0x200,
			ArrayAfterComma = 0x400
		}

		private class PushBackReader
		{
			private readonly TextReader reader;

			private char? nextChar;

			internal PushBackReader(TextReader reader)
			{
				this.reader = reader;
			}

			internal char? Read()
			{
				if (nextChar.HasValue)
				{
					char? result = nextChar;
					nextChar = null;
					return result;
				}
				int num = reader.Read();
				if (num != -1)
				{
					return (char)num;
				}
				return null;
			}

			internal char ReadOrFail(string messageOnFailure)
			{
				char? c = Read();
				if (!c.HasValue)
				{
					throw CreateException(messageOnFailure);
				}
				return c.Value;
			}

			internal void PushBack(char c)
			{
				if (nextChar.HasValue)
				{
					throw new InvalidOperationException("Cannot push back when already buffering a character");
				}
				nextChar = c;
			}

			internal InvalidJsonException CreateException(string message)
			{
				return new InvalidJsonException(message);
			}
		}

		private static readonly State ValueStates = State.StartOfDocument | State.ObjectAfterColon | State.ArrayStart | State.ArrayAfterComma;

		private readonly Stack<ContainerType> containerStack = new Stack<ContainerType>();

		private readonly PushBackReader reader;

		private State state;

		internal JsonTextTokenizer(TextReader reader)
		{
			this.reader = new PushBackReader(reader);
			state = State.StartOfDocument;
			containerStack.Push(ContainerType.Document);
		}

		protected override JsonToken NextImpl()
		{
			if (state == State.ReaderExhausted)
			{
				throw new InvalidOperationException("Next() called after end of document");
			}
			while (true)
			{
				char? c = reader.Read();
				if (!c.HasValue)
				{
					break;
				}
				switch (c.Value)
				{
				case '\t':
				case '\n':
				case '\r':
				case ' ':
					break;
				case ':':
					ValidateState(State.ObjectBeforeColon, "Invalid state to read a colon: ");
					state = State.ObjectAfterColon;
					break;
				case ',':
					ValidateState(State.ObjectAfterProperty | State.ArrayAfterValue, "Invalid state to read a comma: ");
					state = ((state == State.ObjectAfterProperty) ? State.ObjectAfterComma : State.ArrayAfterComma);
					break;
				case '"':
				{
					string text = ReadString();
					if ((state & (State.ObjectStart | State.ObjectAfterComma)) != 0)
					{
						state = State.ObjectBeforeColon;
						return JsonToken.Name(text);
					}
					ValidateAndModifyStateForValue("Invalid state to read a double quote: ");
					return JsonToken.Value(text);
				}
				case '{':
					ValidateState(ValueStates, "Invalid state to read an open brace: ");
					state = State.ObjectStart;
					containerStack.Push(ContainerType.Object);
					return JsonToken.StartObject;
				case '}':
					ValidateState(State.ObjectStart | State.ObjectAfterProperty, "Invalid state to read a close brace: ");
					PopContainer();
					return JsonToken.EndObject;
				case '[':
					ValidateState(ValueStates, "Invalid state to read an open square bracket: ");
					state = State.ArrayStart;
					containerStack.Push(ContainerType.Array);
					return JsonToken.StartArray;
				case ']':
					ValidateState(State.ArrayStart | State.ArrayAfterValue, "Invalid state to read a close square bracket: ");
					PopContainer();
					return JsonToken.EndArray;
				case 'n':
					ConsumeLiteral("null");
					ValidateAndModifyStateForValue("Invalid state to read a null literal: ");
					return JsonToken.Null;
				case 't':
					ConsumeLiteral("true");
					ValidateAndModifyStateForValue("Invalid state to read a true literal: ");
					return JsonToken.True;
				case 'f':
					ConsumeLiteral("false");
					ValidateAndModifyStateForValue("Invalid state to read a false literal: ");
					return JsonToken.False;
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
				{
					double value = ReadNumber(c.Value);
					ValidateAndModifyStateForValue("Invalid state to read a number token: ");
					return JsonToken.Value(value);
				}
				default:
					throw new InvalidJsonException("Invalid first character of token: " + c.Value);
				}
			}
			ValidateState(State.ExpectedEndOfDocument, "Unexpected end of document in state: ");
			state = State.ReaderExhausted;
			return JsonToken.EndDocument;
		}

		private void ValidateState(State validStates, string errorPrefix)
		{
			if ((validStates & state) == 0)
			{
				throw reader.CreateException(errorPrefix + state);
			}
		}

		private string ReadString()
		{
			StringBuilder stringBuilder = new StringBuilder();
			bool flag = false;
			while (true)
			{
				char c = reader.ReadOrFail("Unexpected end of text while reading string");
				if (c < ' ')
				{
					throw reader.CreateException(string.Format(CultureInfo.InvariantCulture, "Invalid character in string literal: U+{0:x4}", new object[1] { (int)c }));
				}
				switch (c)
				{
				case '"':
					if (flag)
					{
						throw reader.CreateException("Invalid use of surrogate pair code units");
					}
					return stringBuilder.ToString();
				case '\\':
					c = ReadEscapedCharacter();
					break;
				}
				if (flag != char.IsLowSurrogate(c))
				{
					break;
				}
				flag = char.IsHighSurrogate(c);
				stringBuilder.Append(c);
			}
			throw reader.CreateException("Invalid use of surrogate pair code units");
		}

		private char ReadEscapedCharacter()
		{
			char c = reader.ReadOrFail("Unexpected end of text while reading character escape sequence");
			return c switch
			{
				'n' => '\n', 
				'\\' => '\\', 
				'b' => '\b', 
				'f' => '\f', 
				'r' => '\r', 
				't' => '\t', 
				'"' => '"', 
				'/' => '/', 
				'u' => ReadUnicodeEscape(), 
				_ => throw reader.CreateException(string.Format(CultureInfo.InvariantCulture, "Invalid character in character escape sequence: U+{0:x4}", new object[1] { (int)c })), 
			};
		}

		private char ReadUnicodeEscape()
		{
			int num = 0;
			for (int i = 0; i < 4; i++)
			{
				char c = reader.ReadOrFail("Unexpected end of text while reading Unicode escape sequence");
				int num2;
				if (c >= '0' && c <= '9')
				{
					num2 = c - 48;
				}
				else if (c >= 'a' && c <= 'f')
				{
					num2 = c - 97 + 10;
				}
				else
				{
					if (c < 'A' || c > 'F')
					{
						throw reader.CreateException(string.Format(CultureInfo.InvariantCulture, "Invalid character in character escape sequence: U+{0:x4}", new object[1] { (int)c }));
					}
					num2 = c - 65 + 10;
				}
				num = (num << 4) + num2;
			}
			return (char)num;
		}

		private void ConsumeLiteral(string text)
		{
			for (int i = 1; i < text.Length; i++)
			{
				char? c = reader.Read();
				if (!c.HasValue)
				{
					throw reader.CreateException("Unexpected end of text while reading literal token " + text);
				}
				if (c.Value != text[i])
				{
					throw reader.CreateException("Unexpected character while reading literal token " + text);
				}
			}
		}

		private double ReadNumber(char initialCharacter)
		{
			StringBuilder stringBuilder = new StringBuilder();
			if (initialCharacter == '-')
			{
				stringBuilder.Append("-");
			}
			else
			{
				reader.PushBack(initialCharacter);
			}
			char? c = ReadInt(stringBuilder);
			if (c == '.')
			{
				c = ReadFrac(stringBuilder);
			}
			if (c == 'e' || c == 'E')
			{
				c = ReadExp(stringBuilder);
			}
			if (c.HasValue)
			{
				reader.PushBack(c.Value);
			}
			try
			{
				return double.Parse(stringBuilder.ToString(), NumberStyles.AllowLeadingSign | NumberStyles.AllowDecimalPoint | NumberStyles.AllowExponent, CultureInfo.InvariantCulture);
			}
			catch (OverflowException)
			{
				throw reader.CreateException("Numeric value out of range: " + stringBuilder);
			}
		}

		private char? ReadInt(StringBuilder builder)
		{
			char c = reader.ReadOrFail("Invalid numeric literal");
			if (c < '0' || c > '9')
			{
				throw reader.CreateException("Invalid numeric literal");
			}
			builder.Append(c);
			char? result = ConsumeDigits(builder, out var count);
			if (c == '0' && count != 0)
			{
				throw reader.CreateException("Invalid numeric literal: leading 0 for non-zero value.");
			}
			return result;
		}

		private char? ReadFrac(StringBuilder builder)
		{
			builder.Append('.');
			char? result = ConsumeDigits(builder, out var count);
			if (count == 0)
			{
				throw reader.CreateException("Invalid numeric literal: fraction with no trailing digits");
			}
			return result;
		}

		private char? ReadExp(StringBuilder builder)
		{
			builder.Append('E');
			char? c = reader.Read();
			if (!c.HasValue)
			{
				throw reader.CreateException("Invalid numeric literal: exponent with no trailing digits");
			}
			if (c == '-' || c == '+')
			{
				builder.Append(c.Value);
			}
			else
			{
				reader.PushBack(c.Value);
			}
			c = ConsumeDigits(builder, out var count);
			if (count == 0)
			{
				throw reader.CreateException("Invalid numeric literal: exponent without value");
			}
			return c;
		}

		private char? ConsumeDigits(StringBuilder builder, out int count)
		{
			count = 0;
			char? result;
			while (true)
			{
				result = reader.Read();
				if (!result.HasValue || result.Value < '0' || result.Value > '9')
				{
					break;
				}
				count++;
				builder.Append(result.Value);
			}
			return result;
		}

		private void ValidateAndModifyStateForValue(string errorPrefix)
		{
			ValidateState(ValueStates, errorPrefix);
			switch (state)
			{
			case State.StartOfDocument:
				state = State.ExpectedEndOfDocument;
				break;
			case State.ObjectAfterColon:
				state = State.ObjectAfterProperty;
				break;
			case State.ArrayStart:
			case State.ArrayAfterComma:
				state = State.ArrayAfterValue;
				break;
			default:
				throw new InvalidOperationException("ValidateAndModifyStateForValue does not handle all value states (and should)");
			}
		}

		private void PopContainer()
		{
			containerStack.Pop();
			ContainerType containerType = containerStack.Peek();
			switch (containerType)
			{
			case ContainerType.Object:
				state = State.ObjectAfterProperty;
				break;
			case ContainerType.Array:
				state = State.ArrayAfterValue;
				break;
			case ContainerType.Document:
				state = State.ExpectedEndOfDocument;
				break;
			default:
				throw new InvalidOperationException("Unexpected container type: " + containerType);
			}
		}
	}

	private JsonToken bufferedToken;

	internal int ObjectDepth { get; private set; }

	internal static JsonTokenizer FromTextReader(TextReader reader)
	{
		return new JsonTextTokenizer(reader);
	}

	internal static JsonTokenizer FromReplayedTokens(IList<JsonToken> tokens, JsonTokenizer continuation)
	{
		return new JsonReplayTokenizer(tokens, continuation);
	}

	internal void PushBack(JsonToken token)
	{
		if (bufferedToken != null)
		{
			throw new InvalidOperationException("Can't push back twice");
		}
		bufferedToken = token;
		if (token.Type == JsonToken.TokenType.StartObject)
		{
			ObjectDepth--;
		}
		else if (token.Type == JsonToken.TokenType.EndObject)
		{
			ObjectDepth++;
		}
	}

	internal JsonToken Next()
	{
		JsonToken jsonToken;
		if (bufferedToken != null)
		{
			jsonToken = bufferedToken;
			bufferedToken = null;
		}
		else
		{
			jsonToken = NextImpl();
		}
		if (jsonToken.Type == JsonToken.TokenType.StartObject)
		{
			ObjectDepth++;
		}
		else if (jsonToken.Type == JsonToken.TokenType.EndObject)
		{
			ObjectDepth--;
		}
		return jsonToken;
	}

	protected abstract JsonToken NextImpl();

	internal void SkipValue()
	{
		int num = 0;
		do
		{
			switch (Next().Type)
			{
			case JsonToken.TokenType.EndObject:
			case JsonToken.TokenType.EndArray:
				num--;
				break;
			case JsonToken.TokenType.StartObject:
			case JsonToken.TokenType.StartArray:
				num++;
				break;
			}
		}
		while (num != 0);
	}
}
