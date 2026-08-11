using System.Collections.Generic;

namespace SharpJson;

public class JsonDecoder
{
	private Lexer lexer;

	public string errorMessage { get; private set; }

	public bool parseNumbersAsFloat { get; set; }

	public JsonDecoder()
	{
		errorMessage = null;
		parseNumbersAsFloat = false;
	}

	public object Decode(string text)
	{
		errorMessage = null;
		lexer = new Lexer(text);
		lexer.parseNumbersAsFloat = parseNumbersAsFloat;
		return ParseValue();
	}

	public static object DecodeText(string text)
	{
		return new JsonDecoder().Decode(text);
	}

	private IDictionary<string, object> ParseObject()
	{
		Dictionary<string, object> dictionary = new Dictionary<string, object>();
		lexer.NextToken();
		while (true)
		{
			switch (lexer.LookAhead())
			{
			case Lexer.Token.None:
				TriggerError("Invalid token");
				return null;
			case Lexer.Token.Comma:
				lexer.NextToken();
				continue;
			case Lexer.Token.CurlyClose:
				lexer.NextToken();
				return dictionary;
			}
			string key = EvalLexer(lexer.ParseString());
			if (errorMessage != null)
			{
				return null;
			}
			Lexer.Token token = lexer.NextToken();
			if (token != Lexer.Token.Colon)
			{
				TriggerError("Invalid token; expected ':'");
				return null;
			}
			object value = ParseValue();
			if (errorMessage != null)
			{
				return null;
			}
			dictionary[key] = value;
		}
	}

	private IList<object> ParseArray()
	{
		List<object> list = new List<object>();
		lexer.NextToken();
		while (true)
		{
			switch (lexer.LookAhead())
			{
			case Lexer.Token.None:
				TriggerError("Invalid token");
				return null;
			case Lexer.Token.Comma:
				lexer.NextToken();
				continue;
			case Lexer.Token.SquaredClose:
				lexer.NextToken();
				return list;
			}
			object item = ParseValue();
			if (errorMessage != null)
			{
				return null;
			}
			list.Add(item);
		}
	}

	private object ParseValue()
	{
		switch (lexer.LookAhead())
		{
		case Lexer.Token.String:
			return EvalLexer(lexer.ParseString());
		case Lexer.Token.Number:
			if (parseNumbersAsFloat)
			{
				return EvalLexer(lexer.ParseFloatNumber());
			}
			return EvalLexer(lexer.ParseDoubleNumber());
		case Lexer.Token.CurlyOpen:
			return ParseObject();
		case Lexer.Token.SquaredOpen:
			return ParseArray();
		case Lexer.Token.True:
			lexer.NextToken();
			return true;
		case Lexer.Token.False:
			lexer.NextToken();
			return false;
		case Lexer.Token.Null:
			lexer.NextToken();
			return null;
		default:
			TriggerError("Unable to parse value");
			return null;
		}
	}

	private void TriggerError(string message)
	{
		errorMessage = $"Error: '{message}' at line {lexer.lineNumber}";
	}

	private T EvalLexer<T>(T value)
	{
		if (lexer.hasError)
		{
			TriggerError("Lexical error ocurred");
		}
		return value;
	}
}
