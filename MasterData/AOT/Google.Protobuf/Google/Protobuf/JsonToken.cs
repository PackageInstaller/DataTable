using System;

namespace Google.Protobuf;

internal sealed class JsonToken : IEquatable<JsonToken>
{
	internal enum TokenType
	{
		Null,
		False,
		True,
		StringValue,
		Number,
		Name,
		StartObject,
		EndObject,
		StartArray,
		EndArray,
		EndDocument
	}

	private static readonly JsonToken _true = new JsonToken(TokenType.True);

	private static readonly JsonToken _false = new JsonToken(TokenType.False);

	private static readonly JsonToken _null = new JsonToken(TokenType.Null);

	private static readonly JsonToken startObject = new JsonToken(TokenType.StartObject);

	private static readonly JsonToken endObject = new JsonToken(TokenType.EndObject);

	private static readonly JsonToken startArray = new JsonToken(TokenType.StartArray);

	private static readonly JsonToken endArray = new JsonToken(TokenType.EndArray);

	private static readonly JsonToken endDocument = new JsonToken(TokenType.EndDocument);

	private readonly TokenType type;

	private readonly string stringValue;

	private readonly double numberValue;

	internal static JsonToken Null => _null;

	internal static JsonToken False => _false;

	internal static JsonToken True => _true;

	internal static JsonToken StartObject => startObject;

	internal static JsonToken EndObject => endObject;

	internal static JsonToken StartArray => startArray;

	internal static JsonToken EndArray => endArray;

	internal static JsonToken EndDocument => endDocument;

	internal TokenType Type => type;

	internal string StringValue => stringValue;

	internal double NumberValue => numberValue;

	internal static JsonToken Name(string name)
	{
		return new JsonToken(TokenType.Name, name);
	}

	internal static JsonToken Value(string value)
	{
		return new JsonToken(TokenType.StringValue, value);
	}

	internal static JsonToken Value(double value)
	{
		return new JsonToken(TokenType.Number, null, value);
	}

	private JsonToken(TokenType type, string stringValue = null, double numberValue = 0.0)
	{
		this.type = type;
		this.stringValue = stringValue;
		this.numberValue = numberValue;
	}

	public override bool Equals(object obj)
	{
		return Equals(obj as JsonToken);
	}

	public override int GetHashCode()
	{
		int num = (((int)(17 * 31 + type) * 31 + stringValue != null) ? stringValue.GetHashCode() : 0) * 31;
		double num2 = numberValue;
		return num + num2.GetHashCode();
	}

	public override string ToString()
	{
		switch (type)
		{
		case TokenType.Null:
			return "null";
		case TokenType.True:
			return "true";
		case TokenType.False:
			return "false";
		case TokenType.Name:
			return "name (" + stringValue + ")";
		case TokenType.StringValue:
			return "value (" + stringValue + ")";
		case TokenType.Number:
		{
			double num = numberValue;
			return "number (" + num + ")";
		}
		case TokenType.StartObject:
			return "start-object";
		case TokenType.EndObject:
			return "end-object";
		case TokenType.StartArray:
			return "start-array";
		case TokenType.EndArray:
			return "end-array";
		case TokenType.EndDocument:
			return "end-document";
		default:
			throw new InvalidOperationException("Token is of unknown type " + type);
		}
	}

	public bool Equals(JsonToken other)
	{
		if (other == null)
		{
			return false;
		}
		if (other.type == type && other.stringValue == stringValue)
		{
			double num = other.numberValue;
			return num.Equals(numberValue);
		}
		return false;
	}
}
