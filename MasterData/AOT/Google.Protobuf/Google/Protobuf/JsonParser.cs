using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using Google.Protobuf.Reflection;
using Google.Protobuf.WellKnownTypes;

namespace Google.Protobuf;

public sealed class JsonParser
{
	public sealed class Settings
	{
		public static Settings Default { get; }

		public int RecursionLimit { get; }

		public TypeRegistry TypeRegistry { get; }

		public bool IgnoreUnknownFields { get; }

		static Settings()
		{
			Default = new Settings(100);
		}

		private Settings(int recursionLimit, TypeRegistry typeRegistry, bool ignoreUnknownFields)
		{
			RecursionLimit = recursionLimit;
			TypeRegistry = ProtoPreconditions.CheckNotNull(typeRegistry, "typeRegistry");
			IgnoreUnknownFields = ignoreUnknownFields;
		}

		public Settings(int recursionLimit)
			: this(recursionLimit, TypeRegistry.Empty)
		{
		}

		public Settings(int recursionLimit, TypeRegistry typeRegistry)
			: this(recursionLimit, typeRegistry, ignoreUnknownFields: false)
		{
		}
	}

	private static readonly Regex TimestampRegex = new Regex("^(?<datetime>[0-9]{4}-[01][0-9]-[0-3][0-9]T[012][0-9]:[0-5][0-9]:[0-5][0-9])(?<subseconds>\\.[0-9]{1,9})?(?<offset>(Z|[+-][0-1][0-9]:[0-5][0-9]))$", FrameworkPortability.CompiledRegexWhereAvailable);

	private static readonly Regex DurationRegex = new Regex("^(?<sign>-)?(?<int>[0-9]{1,12})(?<subseconds>\\.[0-9]{1,9})?s$", FrameworkPortability.CompiledRegexWhereAvailable);

	private static readonly int[] SubsecondScalingFactors = new int[11]
	{
		0, 100000000, 100000000, 10000000, 1000000, 100000, 10000, 1000, 100, 10,
		1
	};

	private static readonly char[] FieldMaskPathSeparators = new char[1] { ',' };

	private static readonly EnumDescriptor NullValueDescriptor = StructReflection.Descriptor.EnumTypes.Single((EnumDescriptor ed) => ed.ClrType == typeof(NullValue));

	private static readonly JsonParser defaultInstance = new JsonParser(Settings.Default);

	private static readonly Dictionary<string, Action<JsonParser, IMessage, JsonTokenizer>> WellKnownTypeHandlers = new Dictionary<string, Action<JsonParser, IMessage, JsonTokenizer>>
	{
		{
			Timestamp.Descriptor.FullName,
			(JsonParser parser, IMessage message, JsonTokenizer tokenizer) =>
			{
				MergeTimestamp(message, tokenizer.Next());
			}
		},
		{
			Duration.Descriptor.FullName,
			(JsonParser parser, IMessage message, JsonTokenizer tokenizer) =>
			{
				MergeDuration(message, tokenizer.Next());
			}
		},
		{
			Value.Descriptor.FullName,
			(JsonParser parser, IMessage message, JsonTokenizer tokenizer) =>
			{
				parser.MergeStructValue(message, tokenizer);
			}
		},
		{
			ListValue.Descriptor.FullName,
			(JsonParser parser, IMessage message, JsonTokenizer tokenizer) =>
			{
				parser.MergeRepeatedField(message, message.Descriptor.Fields[1], tokenizer);
			}
		},
		{
			Struct.Descriptor.FullName,
			(JsonParser parser, IMessage message, JsonTokenizer tokenizer) =>
			{
				parser.MergeStruct(message, tokenizer);
			}
		},
		{
			Any.Descriptor.FullName,
			(JsonParser parser, IMessage message, JsonTokenizer tokenizer) =>
			{
				parser.MergeAny(message, tokenizer);
			}
		},
		{
			FieldMask.Descriptor.FullName,
			(JsonParser parser, IMessage message, JsonTokenizer tokenizer) =>
			{
				MergeFieldMask(message, tokenizer.Next());
			}
		},
		{
			Int32Value.Descriptor.FullName,
			MergeWrapperField
		},
		{
			Int64Value.Descriptor.FullName,
			MergeWrapperField
		},
		{
			UInt32Value.Descriptor.FullName,
			MergeWrapperField
		},
		{
			UInt64Value.Descriptor.FullName,
			MergeWrapperField
		},
		{
			FloatValue.Descriptor.FullName,
			MergeWrapperField
		},
		{
			DoubleValue.Descriptor.FullName,
			MergeWrapperField
		},
		{
			BytesValue.Descriptor.FullName,
			MergeWrapperField
		},
		{
			StringValue.Descriptor.FullName,
			MergeWrapperField
		},
		{
			BoolValue.Descriptor.FullName,
			MergeWrapperField
		}
	};

	private readonly Settings settings;

	public static JsonParser Default => defaultInstance;

	private static void MergeWrapperField(JsonParser parser, IMessage message, JsonTokenizer tokenizer)
	{
		parser.MergeField(message, message.Descriptor.Fields[1], tokenizer);
	}

	public JsonParser(Settings settings)
	{
		this.settings = ProtoPreconditions.CheckNotNull(settings, "settings");
	}

	internal void Merge(IMessage message, string json)
	{
		Merge(message, new StringReader(json));
	}

	internal void Merge(IMessage message, TextReader jsonReader)
	{
		JsonTokenizer jsonTokenizer = JsonTokenizer.FromTextReader(jsonReader);
		Merge(message, jsonTokenizer);
		if (jsonTokenizer.Next() != JsonToken.EndDocument)
		{
			throw new InvalidProtocolBufferException("Expected end of JSON after object");
		}
	}

	private void Merge(IMessage message, JsonTokenizer tokenizer)
	{
		if (tokenizer.ObjectDepth > settings.RecursionLimit)
		{
			throw InvalidProtocolBufferException.JsonRecursionLimitExceeded();
		}
		if (message.Descriptor.IsWellKnownType && WellKnownTypeHandlers.TryGetValue(message.Descriptor.FullName, out var value))
		{
			value(this, message, tokenizer);
			return;
		}
		JsonToken jsonToken = tokenizer.Next();
		if (jsonToken.Type != JsonToken.TokenType.StartObject)
		{
			throw new InvalidProtocolBufferException("Expected an object");
		}
		IDictionary<string, FieldDescriptor> dictionary = message.Descriptor.Fields.ByJsonName();
		HashSet<OneofDescriptor> hashSet = null;
		string stringValue;
		while (true)
		{
			jsonToken = tokenizer.Next();
			if (jsonToken.Type == JsonToken.TokenType.EndObject)
			{
				return;
			}
			if (jsonToken.Type != JsonToken.TokenType.Name)
			{
				throw new InvalidOperationException("Unexpected token type " + jsonToken.Type);
			}
			stringValue = jsonToken.StringValue;
			if (dictionary.TryGetValue(stringValue, out var value2))
			{
				if (value2.ContainingOneof != null)
				{
					if (hashSet == null)
					{
						hashSet = new HashSet<OneofDescriptor>();
					}
					if (!hashSet.Add(value2.ContainingOneof))
					{
						throw new InvalidProtocolBufferException("Multiple values specified for oneof " + value2.ContainingOneof.Name);
					}
				}
				MergeField(message, value2, tokenizer);
			}
			else
			{
				if (!settings.IgnoreUnknownFields)
				{
					break;
				}
				tokenizer.SkipValue();
			}
		}
		throw new InvalidProtocolBufferException("Unknown field: " + stringValue);
	}

	private void MergeField(IMessage message, FieldDescriptor field, JsonTokenizer tokenizer)
	{
		JsonToken jsonToken = tokenizer.Next();
		if (jsonToken.Type == JsonToken.TokenType.Null && (field.IsMap || field.IsRepeated || (!IsGoogleProtobufValueField(field) && !IsGoogleProtobufNullValueField(field))))
		{
			field.Accessor.Clear(message);
			return;
		}
		tokenizer.PushBack(jsonToken);
		if (field.IsMap)
		{
			MergeMapField(message, field, tokenizer);
			return;
		}
		if (field.IsRepeated)
		{
			MergeRepeatedField(message, field, tokenizer);
			return;
		}
		object value = ParseSingleValue(field, tokenizer);
		field.Accessor.SetValue(message, value);
	}

	private void MergeRepeatedField(IMessage message, FieldDescriptor field, JsonTokenizer tokenizer)
	{
		JsonToken jsonToken = tokenizer.Next();
		if (jsonToken.Type != JsonToken.TokenType.StartArray)
		{
			throw new InvalidProtocolBufferException("Repeated field value was not an array. Token type: " + jsonToken.Type);
		}
		IList list = (IList)field.Accessor.GetValue(message);
		while (true)
		{
			jsonToken = tokenizer.Next();
			if (jsonToken.Type == JsonToken.TokenType.EndArray)
			{
				return;
			}
			tokenizer.PushBack(jsonToken);
			object obj = ParseSingleValue(field, tokenizer);
			if (obj == null)
			{
				break;
			}
			list.Add(obj);
		}
		throw new InvalidProtocolBufferException("Repeated field elements cannot be null");
	}

	private void MergeMapField(IMessage message, FieldDescriptor field, JsonTokenizer tokenizer)
	{
		JsonToken jsonToken = tokenizer.Next();
		if (jsonToken.Type != JsonToken.TokenType.StartObject)
		{
			throw new InvalidProtocolBufferException("Expected an object to populate a map");
		}
		MessageDescriptor messageType = field.MessageType;
		FieldDescriptor fieldDescriptor = messageType.FindFieldByNumber(1);
		FieldDescriptor fieldDescriptor2 = messageType.FindFieldByNumber(2);
		if (fieldDescriptor == null || fieldDescriptor2 == null)
		{
			throw new InvalidProtocolBufferException("Invalid map field: " + field.FullName);
		}
		IDictionary dictionary = (IDictionary)field.Accessor.GetValue(message);
		while (true)
		{
			jsonToken = tokenizer.Next();
			if (jsonToken.Type == JsonToken.TokenType.EndObject)
			{
				return;
			}
			object key = ParseMapKey(fieldDescriptor, jsonToken.StringValue);
			object obj = ParseSingleValue(fieldDescriptor2, tokenizer);
			if (obj == null)
			{
				break;
			}
			dictionary[key] = obj;
		}
		throw new InvalidProtocolBufferException("Map values must not be null");
	}

	private static bool IsGoogleProtobufValueField(FieldDescriptor field)
	{
		if (field.FieldType == FieldType.Message)
		{
			return field.MessageType.FullName == Value.Descriptor.FullName;
		}
		return false;
	}

	private static bool IsGoogleProtobufNullValueField(FieldDescriptor field)
	{
		if (field.FieldType == FieldType.Enum)
		{
			return field.EnumType.FullName == NullValueDescriptor.FullName;
		}
		return false;
	}

	private object ParseSingleValue(FieldDescriptor field, JsonTokenizer tokenizer)
	{
		JsonToken jsonToken = tokenizer.Next();
		if (jsonToken.Type == JsonToken.TokenType.Null)
		{
			if (IsGoogleProtobufValueField(field))
			{
				return Value.ForNull();
			}
			if (IsGoogleProtobufNullValueField(field))
			{
				return NullValue.NullValue;
			}
			return null;
		}
		FieldType fieldType = field.FieldType;
		if (fieldType == FieldType.Message)
		{
			if (!field.MessageType.IsWrapperType)
			{
				tokenizer.PushBack(jsonToken);
				IMessage message = NewMessageForField(field);
				Merge(message, tokenizer);
				return message;
			}
			field = field.MessageType.Fields[1];
			fieldType = field.FieldType;
		}
		switch (jsonToken.Type)
		{
		case JsonToken.TokenType.False:
		case JsonToken.TokenType.True:
			if (fieldType == FieldType.Bool)
			{
				return jsonToken.Type == JsonToken.TokenType.True;
			}
			break;
		case JsonToken.TokenType.StringValue:
			return ParseSingleStringValue(field, jsonToken.StringValue);
		case JsonToken.TokenType.Number:
			return ParseSingleNumberValue(field, jsonToken);
		case JsonToken.TokenType.Null:
			throw new NotImplementedException("Haven't worked out what to do for null yet");
		}
		throw new InvalidProtocolBufferException("Unsupported JSON token type " + jsonToken.Type.ToString() + " for field type " + fieldType);
	}

	private void MergeStructValue(IMessage message, JsonTokenizer tokenizer)
	{
		JsonToken jsonToken = tokenizer.Next();
		MessageDescriptor.FieldCollection fields = message.Descriptor.Fields;
		switch (jsonToken.Type)
		{
		case JsonToken.TokenType.Null:
			fields[1].Accessor.SetValue(message, 0);
			break;
		case JsonToken.TokenType.StringValue:
			fields[3].Accessor.SetValue(message, jsonToken.StringValue);
			break;
		case JsonToken.TokenType.Number:
			fields[2].Accessor.SetValue(message, jsonToken.NumberValue);
			break;
		case JsonToken.TokenType.False:
		case JsonToken.TokenType.True:
			fields[4].Accessor.SetValue(message, jsonToken.Type == JsonToken.TokenType.True);
			break;
		case JsonToken.TokenType.StartObject:
		{
			FieldDescriptor fieldDescriptor2 = fields[5];
			IMessage message3 = NewMessageForField(fieldDescriptor2);
			tokenizer.PushBack(jsonToken);
			Merge(message3, tokenizer);
			fieldDescriptor2.Accessor.SetValue(message, message3);
			break;
		}
		case JsonToken.TokenType.StartArray:
		{
			FieldDescriptor fieldDescriptor = fields[6];
			IMessage message2 = NewMessageForField(fieldDescriptor);
			tokenizer.PushBack(jsonToken);
			Merge(message2, tokenizer);
			fieldDescriptor.Accessor.SetValue(message, message2);
			break;
		}
		default:
			throw new InvalidOperationException("Unexpected token type: " + jsonToken.Type);
		}
	}

	private void MergeStruct(IMessage message, JsonTokenizer tokenizer)
	{
		JsonToken jsonToken = tokenizer.Next();
		if (jsonToken.Type != JsonToken.TokenType.StartObject)
		{
			throw new InvalidProtocolBufferException("Expected object value for Struct");
		}
		tokenizer.PushBack(jsonToken);
		FieldDescriptor field = message.Descriptor.Fields[1];
		MergeMapField(message, field, tokenizer);
	}

	private void MergeAny(IMessage message, JsonTokenizer tokenizer)
	{
		List<JsonToken> list = new List<JsonToken>();
		JsonToken jsonToken = tokenizer.Next();
		if (jsonToken.Type != JsonToken.TokenType.StartObject)
		{
			throw new InvalidProtocolBufferException("Expected object value for Any");
		}
		int objectDepth = tokenizer.ObjectDepth;
		while (jsonToken.Type != JsonToken.TokenType.Name || jsonToken.StringValue != "@type" || tokenizer.ObjectDepth != objectDepth)
		{
			list.Add(jsonToken);
			jsonToken = tokenizer.Next();
			if (tokenizer.ObjectDepth < objectDepth)
			{
				throw new InvalidProtocolBufferException("Any message with no @type");
			}
		}
		jsonToken = tokenizer.Next();
		if (jsonToken.Type != JsonToken.TokenType.StringValue)
		{
			throw new InvalidProtocolBufferException("Expected string value for Any.@type");
		}
		string stringValue = jsonToken.StringValue;
		string typeName = Any.GetTypeName(stringValue);
		MessageDescriptor messageDescriptor = settings.TypeRegistry.Find(typeName) ?? throw new InvalidOperationException("Type registry has no descriptor for type name '" + typeName + "'");
		JsonTokenizer tokenizer2 = JsonTokenizer.FromReplayedTokens(list, tokenizer);
		IMessage message2 = messageDescriptor.Parser.CreateTemplate();
		if (messageDescriptor.IsWellKnownType)
		{
			MergeWellKnownTypeAnyBody(message2, tokenizer2);
		}
		else
		{
			Merge(message2, tokenizer2);
		}
		ByteString value = message2.ToByteString();
		message.Descriptor.Fields[1].Accessor.SetValue(message, stringValue);
		message.Descriptor.Fields[2].Accessor.SetValue(message, value);
	}

	private void MergeWellKnownTypeAnyBody(IMessage body, JsonTokenizer tokenizer)
	{
		JsonToken jsonToken = tokenizer.Next();
		jsonToken = tokenizer.Next();
		if (jsonToken.Type != JsonToken.TokenType.Name || jsonToken.StringValue != "value")
		{
			throw new InvalidProtocolBufferException("Expected 'value' property for well-known type Any body");
		}
		Merge(body, tokenizer);
		jsonToken = tokenizer.Next();
		if (jsonToken.Type != JsonToken.TokenType.EndObject)
		{
			throw new InvalidProtocolBufferException("Expected end-object token after @type/value for well-known type");
		}
	}

	private static object ParseMapKey(FieldDescriptor field, string keyText)
	{
		switch (field.FieldType)
		{
		case FieldType.Bool:
			if (keyText == "true")
			{
				return true;
			}
			if (keyText == "false")
			{
				return false;
			}
			throw new InvalidProtocolBufferException("Invalid string for bool map key: " + keyText);
		case FieldType.String:
			return keyText;
		case FieldType.Int32:
		case FieldType.SFixed32:
		case FieldType.SInt32:
			return ParseNumericString(keyText, int.Parse);
		case FieldType.Fixed32:
		case FieldType.UInt32:
			return ParseNumericString(keyText, uint.Parse);
		case FieldType.Int64:
		case FieldType.SFixed64:
		case FieldType.SInt64:
			return ParseNumericString(keyText, long.Parse);
		case FieldType.UInt64:
		case FieldType.Fixed64:
			return ParseNumericString(keyText, ulong.Parse);
		default:
			throw new InvalidProtocolBufferException("Invalid field type for map: " + field.FieldType);
		}
	}

	private static object ParseSingleNumberValue(FieldDescriptor field, JsonToken token)
	{
		double numberValue = token.NumberValue;
		checked
		{
			try
			{
				switch (field.FieldType)
				{
				case FieldType.Int32:
				case FieldType.SFixed32:
				case FieldType.SInt32:
					CheckInteger(numberValue);
					return (int)numberValue;
				case FieldType.Fixed32:
				case FieldType.UInt32:
					CheckInteger(numberValue);
					return (uint)numberValue;
				case FieldType.Int64:
				case FieldType.SFixed64:
				case FieldType.SInt64:
					CheckInteger(numberValue);
					return (long)numberValue;
				case FieldType.UInt64:
				case FieldType.Fixed64:
					CheckInteger(numberValue);
					return (ulong)numberValue;
				case FieldType.Double:
					return numberValue;
				case FieldType.Float:
					if (double.IsNaN(numberValue))
					{
						return float.NaN;
					}
					if (numberValue > 3.4028234663852886E+38 || numberValue < -3.4028234663852886E+38)
					{
						if (double.IsPositiveInfinity(numberValue))
						{
							return float.PositiveInfinity;
						}
						if (double.IsNegativeInfinity(numberValue))
						{
							return float.NegativeInfinity;
						}
						throw new InvalidProtocolBufferException($"Value out of range: {numberValue}");
					}
					return (float)numberValue;
				case FieldType.Enum:
					CheckInteger(numberValue);
					return (int)numberValue;
				default:
					throw new InvalidProtocolBufferException($"Unsupported conversion from JSON number for field type {field.FieldType}");
				}
			}
			catch (OverflowException)
			{
				throw new InvalidProtocolBufferException($"Value out of range: {numberValue}");
			}
		}
	}

	private static void CheckInteger(double value)
	{
		if (double.IsInfinity(value) || double.IsNaN(value))
		{
			throw new InvalidProtocolBufferException($"Value not an integer: {value}");
		}
		if (value != Math.Floor(value))
		{
			throw new InvalidProtocolBufferException($"Value not an integer: {value}");
		}
	}

	private static object ParseSingleStringValue(FieldDescriptor field, string text)
	{
		switch (field.FieldType)
		{
		case FieldType.String:
			return text;
		case FieldType.Bytes:
			try
			{
				return ByteString.FromBase64(text);
			}
			catch (FormatException innerException)
			{
				throw InvalidProtocolBufferException.InvalidBase64(innerException);
			}
		case FieldType.Int32:
		case FieldType.SFixed32:
		case FieldType.SInt32:
			return ParseNumericString(text, int.Parse);
		case FieldType.Fixed32:
		case FieldType.UInt32:
			return ParseNumericString(text, uint.Parse);
		case FieldType.Int64:
		case FieldType.SFixed64:
		case FieldType.SInt64:
			return ParseNumericString(text, long.Parse);
		case FieldType.UInt64:
		case FieldType.Fixed64:
			return ParseNumericString(text, ulong.Parse);
		case FieldType.Double:
		{
			double num2 = ParseNumericString(text, double.Parse);
			ValidateInfinityAndNan(text, double.IsPositiveInfinity(num2), double.IsNegativeInfinity(num2), double.IsNaN(num2));
			return num2;
		}
		case FieldType.Float:
		{
			float num = ParseNumericString(text, float.Parse);
			ValidateInfinityAndNan(text, float.IsPositiveInfinity(num), float.IsNegativeInfinity(num), float.IsNaN(num));
			return num;
		}
		case FieldType.Enum:
			return (field.EnumType.FindValueByName(text) ?? throw new InvalidProtocolBufferException("Invalid enum value: " + text + " for enum type: " + field.EnumType.FullName)).Number;
		default:
			throw new InvalidProtocolBufferException($"Unsupported conversion from JSON string for field type {field.FieldType}");
		}
	}

	private static IMessage NewMessageForField(FieldDescriptor field)
	{
		return field.MessageType.Parser.CreateTemplate();
	}

	private static T ParseNumericString<T>(string text, Func<string, NumberStyles, IFormatProvider, T> parser)
	{
		if (text.StartsWith("+"))
		{
			throw new InvalidProtocolBufferException("Invalid numeric value: " + text);
		}
		if (text.StartsWith("0") && text.Length > 1)
		{
			if (text[1] >= '0' && text[1] <= '9')
			{
				throw new InvalidProtocolBufferException("Invalid numeric value: " + text);
			}
		}
		else if (text.StartsWith("-0") && text.Length > 2 && text[2] >= '0' && text[2] <= '9')
		{
			throw new InvalidProtocolBufferException("Invalid numeric value: " + text);
		}
		try
		{
			return parser(text, NumberStyles.AllowLeadingSign | NumberStyles.AllowDecimalPoint | NumberStyles.AllowExponent, CultureInfo.InvariantCulture);
		}
		catch (FormatException)
		{
			throw new InvalidProtocolBufferException("Invalid numeric value for type: " + text);
		}
		catch (OverflowException)
		{
			throw new InvalidProtocolBufferException("Value out of range: " + text);
		}
	}

	private static void ValidateInfinityAndNan(string text, bool isPositiveInfinity, bool isNegativeInfinity, bool isNaN)
	{
		if ((isPositiveInfinity && text != "Infinity") || (isNegativeInfinity && text != "-Infinity") || (isNaN && text != "NaN"))
		{
			throw new InvalidProtocolBufferException("Invalid numeric value: " + text);
		}
	}

	private static void MergeTimestamp(IMessage message, JsonToken token)
	{
		if (token.Type != JsonToken.TokenType.StringValue)
		{
			throw new InvalidProtocolBufferException("Expected string value for Timestamp");
		}
		Match match = TimestampRegex.Match(token.StringValue);
		if (!match.Success)
		{
			throw new InvalidProtocolBufferException("Invalid Timestamp value: " + token.StringValue);
		}
		string value = match.Groups["datetime"].Value;
		string value2 = match.Groups["subseconds"].Value;
		string value3 = match.Groups["offset"].Value;
		try
		{
			Timestamp timestamp = Timestamp.FromDateTime(DateTime.ParseExact(value, "yyyy-MM-dd'T'HH:mm:ss", CultureInfo.InvariantCulture, DateTimeStyles.AdjustToUniversal | DateTimeStyles.AssumeUniversal));
			int num = 0;
			if (value2 != "")
			{
				num = int.Parse(value2.Substring(1), CultureInfo.InvariantCulture) * SubsecondScalingFactors[value2.Length];
			}
			int num2 = 0;
			if (value3 != "Z")
			{
				int num3 = ((value3[0] == '-') ? 1 : (-1));
				int num4 = int.Parse(value3.Substring(1, 2), CultureInfo.InvariantCulture);
				int num5 = int.Parse(value3.Substring(4, 2));
				int num6 = num4 * 60 + num5;
				if (num6 > 1080)
				{
					throw new InvalidProtocolBufferException("Invalid Timestamp value: " + token.StringValue);
				}
				if (num6 == 0 && num3 == 1)
				{
					throw new InvalidProtocolBufferException("Invalid Timestamp value: " + token.StringValue);
				}
				num2 = num3 * num6 * 60;
			}
			if (num2 < 0 && num > 0)
			{
				num2++;
				num -= 1000000000;
			}
			if (num2 != 0 || num != 0)
			{
				timestamp += new Duration
				{
					Nanos = num,
					Seconds = num2
				};
				if (timestamp.Seconds < -62135596800L || timestamp.Seconds > 253402300799L)
				{
					throw new InvalidProtocolBufferException("Invalid Timestamp value: " + token.StringValue);
				}
			}
			message.Descriptor.Fields[1].Accessor.SetValue(message, timestamp.Seconds);
			message.Descriptor.Fields[2].Accessor.SetValue(message, timestamp.Nanos);
		}
		catch (FormatException)
		{
			throw new InvalidProtocolBufferException("Invalid Timestamp value: " + token.StringValue);
		}
	}

	private static void MergeDuration(IMessage message, JsonToken token)
	{
		if (token.Type != JsonToken.TokenType.StringValue)
		{
			throw new InvalidProtocolBufferException("Expected string value for Duration");
		}
		Match match = DurationRegex.Match(token.StringValue);
		if (!match.Success)
		{
			throw new InvalidProtocolBufferException("Invalid Duration value: " + token.StringValue);
		}
		string value = match.Groups["sign"].Value;
		string value2 = match.Groups["int"].Value;
		if (value2[0] == '0' && value2.Length > 1)
		{
			throw new InvalidProtocolBufferException("Invalid Duration value: " + token.StringValue);
		}
		string value3 = match.Groups["subseconds"].Value;
		int num = ((!(value == "-")) ? 1 : (-1));
		try
		{
			long num2 = long.Parse(value2, CultureInfo.InvariantCulture) * num;
			int num3 = 0;
			if (value3 != "")
			{
				num3 = int.Parse(value3.Substring(1)) * SubsecondScalingFactors[value3.Length] * num;
			}
			if (!Duration.IsNormalized(num2, num3))
			{
				throw new InvalidProtocolBufferException("Invalid Duration value: " + token.StringValue);
			}
			message.Descriptor.Fields[1].Accessor.SetValue(message, num2);
			message.Descriptor.Fields[2].Accessor.SetValue(message, num3);
		}
		catch (FormatException)
		{
			throw new InvalidProtocolBufferException("Invalid Duration value: " + token.StringValue);
		}
	}

	private static void MergeFieldMask(IMessage message, JsonToken token)
	{
		if (token.Type != JsonToken.TokenType.StringValue)
		{
			throw new InvalidProtocolBufferException("Expected string value for FieldMask");
		}
		string[] array = token.StringValue.Split(FieldMaskPathSeparators, StringSplitOptions.RemoveEmptyEntries);
		IList list = (IList)message.Descriptor.Fields[1].Accessor.GetValue(message);
		string[] array2 = array;
		foreach (string text in array2)
		{
			list.Add(ToSnakeCase(text));
		}
	}

	private static string ToSnakeCase(string text)
	{
		StringBuilder stringBuilder = new StringBuilder(text.Length * 2);
		bool flag = false;
		bool flag2 = false;
		for (int i = 0; i < text.Length; i++)
		{
			char c = text[i];
			if (c >= 'A' && c <= 'Z')
			{
				if (flag && (flag2 || (i + 1 < text.Length && text[i + 1] >= 'a' && text[i + 1] <= 'z')))
				{
					stringBuilder.Append('_');
				}
				stringBuilder.Append((char)(c + 97 - 65));
				flag = true;
				flag2 = false;
			}
			else
			{
				stringBuilder.Append(c);
				if (c == '_')
				{
					throw new InvalidProtocolBufferException("Invalid field mask: " + text);
				}
				flag = true;
				flag2 = true;
			}
		}
		return stringBuilder.ToString();
	}
}
