using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using Google.Protobuf.Reflection;
using Google.Protobuf.WellKnownTypes;

namespace Google.Protobuf;

public sealed class JsonFormatter
{
	public sealed class Settings
	{
		public static Settings Default { get; }

		public bool FormatDefaultValues { get; }

		public TypeRegistry TypeRegistry { get; }

		public bool FormatEnumsAsIntegers { get; }

		static Settings()
		{
			Default = new Settings(formatDefaultValues: false);
		}

		public Settings(bool formatDefaultValues)
			: this(formatDefaultValues, TypeRegistry.Empty)
		{
		}

		public Settings(bool formatDefaultValues, TypeRegistry typeRegistry)
			: this(formatDefaultValues, typeRegistry, formatEnumsAsIntegers: false)
		{
		}

		private Settings(bool formatDefaultValues, TypeRegistry typeRegistry, bool formatEnumsAsIntegers)
		{
			FormatDefaultValues = formatDefaultValues;
			TypeRegistry = typeRegistry ?? TypeRegistry.Empty;
			FormatEnumsAsIntegers = formatEnumsAsIntegers;
		}
	}

	private static class OriginalEnumValueHelper
	{
		private static readonly Dictionary<System.Type, Dictionary<object, string>> dictionaries = new Dictionary<System.Type, Dictionary<object, string>>();

		internal static string GetOriginalName(object value)
		{
			System.Type type = value.GetType();
			Dictionary<object, string> value2;
			lock (dictionaries)
			{
				if (!dictionaries.TryGetValue(type, out value2))
				{
					value2 = GetNameMapping(type);
					dictionaries[type] = value2;
				}
			}
			value2.TryGetValue(value, out var value3);
			return value3;
		}

		private static Dictionary<object, string> GetNameMapping(System.Type enumType)
		{
			return (from f in enumType.GetTypeInfo().DeclaredFields
				where f.IsStatic
				where f.GetCustomAttributes<OriginalNameAttribute>().FirstOrDefault()?.PreferredAlias ?? true
				select f).ToDictionary((FieldInfo f) => f.GetValue(null), (FieldInfo f) => f.GetCustomAttributes<OriginalNameAttribute>().FirstOrDefault()?.Name ?? f.Name);
		}
	}

	internal const string AnyTypeUrlField = "@type";

	internal const string AnyDiagnosticValueField = "@value";

	internal const string AnyWellKnownTypeValueField = "value";

	private const string TypeUrlPrefix = "type.googleapis.com";

	private const string NameValueSeparator = ": ";

	private const string PropertySeparator = ", ";

	private static readonly JsonFormatter diagnosticFormatter;

	private static readonly string[] CommonRepresentations;

	private readonly Settings settings;

	private const string Hex = "0123456789abcdef";

	public static JsonFormatter Default { get; }

	private bool DiagnosticOnly => this == diagnosticFormatter;

	static JsonFormatter()
	{
		Default = new JsonFormatter(Settings.Default);
		diagnosticFormatter = new JsonFormatter(Settings.Default);
		CommonRepresentations = new string[160]
		{
			"\\u0000", "\\u0001", "\\u0002", "\\u0003", "\\u0004", "\\u0005", "\\u0006", "\\u0007", "\\b", "\\t",
			"\\n", "\\u000b", "\\f", "\\r", "\\u000e", "\\u000f", "\\u0010", "\\u0011", "\\u0012", "\\u0013",
			"\\u0014", "\\u0015", "\\u0016", "\\u0017", "\\u0018", "\\u0019", "\\u001a", "\\u001b", "\\u001c", "\\u001d",
			"\\u001e", "\\u001f", "", "", "\\\"", "", "", "", "", "",
			"", "", "", "", "", "", "", "", "", "",
			"", "", "", "", "", "", "", "", "", "",
			"\\u003c", "", "\\u003e", "", "", "", "", "", "", "",
			"", "", "", "", "", "", "", "", "", "",
			"", "", "", "", "", "", "", "", "", "",
			"", "", "\\\\", "", "", "", "", "", "", "",
			"", "", "", "", "", "", "", "", "", "",
			"", "", "", "", "", "", "", "", "", "",
			"", "", "", "", "", "", "", "\\u007f", "\\u0080", "\\u0081",
			"\\u0082", "\\u0083", "\\u0084", "\\u0085", "\\u0086", "\\u0087", "\\u0088", "\\u0089", "\\u008a", "\\u008b",
			"\\u008c", "\\u008d", "\\u008e", "\\u008f", "\\u0090", "\\u0091", "\\u0092", "\\u0093", "\\u0094", "\\u0095",
			"\\u0096", "\\u0097", "\\u0098", "\\u0099", "\\u009a", "\\u009b", "\\u009c", "\\u009d", "\\u009e", "\\u009f"
		};
		for (int i = 0; i < CommonRepresentations.Length; i++)
		{
			if (CommonRepresentations[i] == "")
			{
				CommonRepresentations[i] = ((char)i).ToString();
			}
		}
	}

	public JsonFormatter(Settings settings)
	{
		this.settings = ProtoPreconditions.CheckNotNull(settings, "settings");
	}

	public string Format(IMessage message)
	{
		StringWriter stringWriter = new StringWriter();
		Format(message, stringWriter);
		return stringWriter.ToString();
	}

	public void Format(IMessage message, TextWriter writer)
	{
		ProtoPreconditions.CheckNotNull(message, "message");
		ProtoPreconditions.CheckNotNull(writer, "writer");
		if (message.Descriptor.IsWellKnownType)
		{
			WriteWellKnownTypeValue(writer, message.Descriptor, message);
		}
		else
		{
			WriteMessage(writer, message);
		}
	}

	public static string ToDiagnosticString(IMessage message)
	{
		ProtoPreconditions.CheckNotNull(message, "message");
		return diagnosticFormatter.Format(message);
	}

	private void WriteMessage(TextWriter writer, IMessage message)
	{
		if (message == null)
		{
			WriteNull(writer);
			return;
		}
		if (DiagnosticOnly && message is ICustomDiagnosticMessage customDiagnosticMessage)
		{
			writer.Write(customDiagnosticMessage.ToDiagnosticString());
			return;
		}
		writer.Write("{ ");
		bool flag = WriteMessageFields(writer, message, assumeFirstFieldWritten: false);
		writer.Write(flag ? " }" : "}");
	}

	private bool WriteMessageFields(TextWriter writer, IMessage message, bool assumeFirstFieldWritten)
	{
		MessageDescriptor.FieldCollection fields = message.Descriptor.Fields;
		bool flag = !assumeFirstFieldWritten;
		foreach (FieldDescriptor item in fields.InFieldNumberOrder())
		{
			IFieldAccessor accessor = item.Accessor;
			object value = accessor.GetValue(message);
			if (ShouldFormatFieldValue(message, item, value))
			{
				if (!flag)
				{
					writer.Write(", ");
				}
				WriteString(writer, accessor.Descriptor.JsonName);
				writer.Write(": ");
				WriteValue(writer, value);
				flag = false;
			}
		}
		return !flag;
	}

	private bool ShouldFormatFieldValue(IMessage message, FieldDescriptor field, object value)
	{
		if (!field.HasPresence)
		{
			if (!settings.FormatDefaultValues)
			{
				return !IsDefaultValue(field, value);
			}
			return true;
		}
		return field.Accessor.HasValue(message);
	}

	internal static string ToJsonName(string name)
	{
		StringBuilder stringBuilder = new StringBuilder(name.Length);
		bool flag = false;
		foreach (char c in name)
		{
			if (c == '_')
			{
				flag = true;
			}
			else if (flag)
			{
				stringBuilder.Append(char.ToUpperInvariant(c));
				flag = false;
			}
			else
			{
				stringBuilder.Append(c);
			}
		}
		return stringBuilder.ToString();
	}

	internal static string FromJsonName(string name)
	{
		StringBuilder stringBuilder = new StringBuilder(name.Length);
		foreach (char c in name)
		{
			if (char.IsUpper(c))
			{
				stringBuilder.Append('_');
				stringBuilder.Append(char.ToLowerInvariant(c));
			}
			else
			{
				stringBuilder.Append(c);
			}
		}
		return stringBuilder.ToString();
	}

	private static void WriteNull(TextWriter writer)
	{
		writer.Write("null");
	}

	private static bool IsDefaultValue(FieldDescriptor descriptor, object value)
	{
		if (descriptor.IsMap)
		{
			return ((IDictionary)value).Count == 0;
		}
		if (descriptor.IsRepeated)
		{
			return ((IList)value).Count == 0;
		}
		switch (descriptor.FieldType)
		{
		case FieldType.Bool:
			return !(bool)value;
		case FieldType.Bytes:
			return (ByteString)value == ByteString.Empty;
		case FieldType.String:
			return (string)value == "";
		case FieldType.Double:
			return (double)value == 0.0;
		case FieldType.Int32:
		case FieldType.SFixed32:
		case FieldType.SInt32:
		case FieldType.Enum:
			return (int)value == 0;
		case FieldType.Fixed32:
		case FieldType.UInt32:
			return (uint)value == 0;
		case FieldType.UInt64:
		case FieldType.Fixed64:
			return (ulong)value == 0;
		case FieldType.Int64:
		case FieldType.SFixed64:
		case FieldType.SInt64:
			return (long)value == 0;
		case FieldType.Float:
			return (float)value == 0f;
		case FieldType.Group:
		case FieldType.Message:
			return value == null;
		default:
			throw new ArgumentException("Invalid field type");
		}
	}

	public void WriteValue(TextWriter writer, object value)
	{
		if (value == null || value is NullValue)
		{
			WriteNull(writer);
		}
		else if (value is bool)
		{
			writer.Write(((bool)value) ? "true" : "false");
		}
		else if (value is ByteString)
		{
			writer.Write('"');
			writer.Write(((ByteString)value).ToBase64());
			writer.Write('"');
		}
		else if (value is string)
		{
			WriteString(writer, (string)value);
		}
		else if (value is IDictionary)
		{
			WriteDictionary(writer, (IDictionary)value);
		}
		else if (value is IList)
		{
			WriteList(writer, (IList)value);
		}
		else if (value is int || value is uint)
		{
			IFormattable formattable = (IFormattable)value;
			writer.Write(formattable.ToString("d", CultureInfo.InvariantCulture));
		}
		else if (value is long || value is ulong)
		{
			writer.Write('"');
			IFormattable formattable2 = (IFormattable)value;
			writer.Write(formattable2.ToString("d", CultureInfo.InvariantCulture));
			writer.Write('"');
		}
		else if (value is System.Enum)
		{
			if (settings.FormatEnumsAsIntegers)
			{
				WriteValue(writer, (int)value);
				return;
			}
			string originalName = OriginalEnumValueHelper.GetOriginalName(value);
			if (originalName != null)
			{
				WriteString(writer, originalName);
			}
			else
			{
				WriteValue(writer, (int)value);
			}
		}
		else if (value is float || value is double)
		{
			string text = ((IFormattable)value).ToString("r", CultureInfo.InvariantCulture);
			switch (text)
			{
			case "NaN":
			case "Infinity":
			case "-Infinity":
				writer.Write('"');
				writer.Write(text);
				writer.Write('"');
				break;
			default:
				writer.Write(text);
				break;
			}
		}
		else
		{
			if (!(value is IMessage))
			{
				throw new ArgumentException("Unable to format value of type " + value.GetType());
			}
			Format((IMessage)value, writer);
		}
	}

	private void WriteWellKnownTypeValue(TextWriter writer, MessageDescriptor descriptor, object value)
	{
		if (value == null)
		{
			WriteNull(writer);
		}
		else if (descriptor.IsWrapperType)
		{
			if (value is IMessage)
			{
				IMessage message = (IMessage)value;
				value = message.Descriptor.Fields[1].Accessor.GetValue(message);
			}
			WriteValue(writer, value);
		}
		else if (descriptor.FullName == Timestamp.Descriptor.FullName)
		{
			WriteTimestamp(writer, (IMessage)value);
		}
		else if (descriptor.FullName == Duration.Descriptor.FullName)
		{
			WriteDuration(writer, (IMessage)value);
		}
		else if (descriptor.FullName == FieldMask.Descriptor.FullName)
		{
			WriteFieldMask(writer, (IMessage)value);
		}
		else if (descriptor.FullName == Struct.Descriptor.FullName)
		{
			WriteStruct(writer, (IMessage)value);
		}
		else if (descriptor.FullName == ListValue.Descriptor.FullName)
		{
			IFieldAccessor accessor = descriptor.Fields[1].Accessor;
			WriteList(writer, (IList)accessor.GetValue((IMessage)value));
		}
		else if (descriptor.FullName == Value.Descriptor.FullName)
		{
			WriteStructFieldValue(writer, (IMessage)value);
		}
		else if (descriptor.FullName == Any.Descriptor.FullName)
		{
			WriteAny(writer, (IMessage)value);
		}
		else
		{
			WriteMessage(writer, (IMessage)value);
		}
	}

	private void WriteTimestamp(TextWriter writer, IMessage value)
	{
		int nanoseconds = (int)value.Descriptor.Fields[2].Accessor.GetValue(value);
		long seconds = (long)value.Descriptor.Fields[1].Accessor.GetValue(value);
		writer.Write(Timestamp.ToJson(seconds, nanoseconds, DiagnosticOnly));
	}

	private void WriteDuration(TextWriter writer, IMessage value)
	{
		int nanoseconds = (int)value.Descriptor.Fields[2].Accessor.GetValue(value);
		long seconds = (long)value.Descriptor.Fields[1].Accessor.GetValue(value);
		writer.Write(Duration.ToJson(seconds, nanoseconds, DiagnosticOnly));
	}

	private void WriteFieldMask(TextWriter writer, IMessage value)
	{
		IList<string> paths = (IList<string>)value.Descriptor.Fields[1].Accessor.GetValue(value);
		writer.Write(FieldMask.ToJson(paths, DiagnosticOnly));
	}

	private void WriteAny(TextWriter writer, IMessage value)
	{
		if (DiagnosticOnly)
		{
			WriteDiagnosticOnlyAny(writer, value);
			return;
		}
		string text = (string)value.Descriptor.Fields[1].Accessor.GetValue(value);
		ByteString data = (ByteString)value.Descriptor.Fields[2].Accessor.GetValue(value);
		string typeName = Any.GetTypeName(text);
		MessageDescriptor messageDescriptor = settings.TypeRegistry.Find(typeName);
		if (messageDescriptor == null)
		{
			throw new InvalidOperationException("Type registry has no descriptor for type name '" + typeName + "'");
		}
		IMessage message = messageDescriptor.Parser.ParseFrom(data);
		writer.Write("{ ");
		WriteString(writer, "@type");
		writer.Write(": ");
		WriteString(writer, text);
		if (messageDescriptor.IsWellKnownType)
		{
			writer.Write(", ");
			WriteString(writer, "value");
			writer.Write(": ");
			WriteWellKnownTypeValue(writer, messageDescriptor, message);
		}
		else
		{
			WriteMessageFields(writer, message, assumeFirstFieldWritten: true);
		}
		writer.Write(" }");
	}

	private void WriteDiagnosticOnlyAny(TextWriter writer, IMessage value)
	{
		string text = (string)value.Descriptor.Fields[1].Accessor.GetValue(value);
		ByteString byteString = (ByteString)value.Descriptor.Fields[2].Accessor.GetValue(value);
		writer.Write("{ ");
		WriteString(writer, "@type");
		writer.Write(": ");
		WriteString(writer, text);
		writer.Write(", ");
		WriteString(writer, "@value");
		writer.Write(": ");
		writer.Write('"');
		writer.Write(byteString.ToBase64());
		writer.Write('"');
		writer.Write(" }");
	}

	private void WriteStruct(TextWriter writer, IMessage message)
	{
		writer.Write("{ ");
		IDictionary dictionary = (IDictionary)message.Descriptor.Fields[1].Accessor.GetValue(message);
		bool flag = true;
		foreach (DictionaryEntry item in dictionary)
		{
			string text = (string)item.Key;
			IMessage message2 = (IMessage)item.Value;
			if (string.IsNullOrEmpty(text) || message2 == null)
			{
				throw new InvalidOperationException("Struct fields cannot have an empty key or a null value.");
			}
			if (!flag)
			{
				writer.Write(", ");
			}
			WriteString(writer, text);
			writer.Write(": ");
			WriteStructFieldValue(writer, message2);
			flag = false;
		}
		writer.Write(flag ? "}" : " }");
	}

	private void WriteStructFieldValue(TextWriter writer, IMessage message)
	{
		FieldDescriptor caseFieldDescriptor = message.Descriptor.Oneofs[0].Accessor.GetCaseFieldDescriptor(message);
		if (caseFieldDescriptor == null)
		{
			throw new InvalidOperationException("Value message must contain a value for the oneof.");
		}
		object value = caseFieldDescriptor.Accessor.GetValue(message);
		switch (caseFieldDescriptor.FieldNumber)
		{
		case 2:
		case 3:
		case 4:
			WriteValue(writer, value);
			break;
		case 5:
		case 6:
		{
			IMessage message2 = (IMessage)caseFieldDescriptor.Accessor.GetValue(message);
			WriteWellKnownTypeValue(writer, message2.Descriptor, message2);
			break;
		}
		case 1:
			WriteNull(writer);
			break;
		default:
			throw new InvalidOperationException("Unexpected case in struct field: " + caseFieldDescriptor.FieldNumber);
		}
	}

	internal void WriteList(TextWriter writer, IList list)
	{
		writer.Write("[ ");
		bool flag = true;
		foreach (object item in list)
		{
			if (!flag)
			{
				writer.Write(", ");
			}
			WriteValue(writer, item);
			flag = false;
		}
		writer.Write(flag ? "]" : " ]");
	}

	internal void WriteDictionary(TextWriter writer, IDictionary dictionary)
	{
		writer.Write("{ ");
		bool flag = true;
		foreach (DictionaryEntry item in dictionary)
		{
			if (!flag)
			{
				writer.Write(", ");
			}
			string text;
			if (item.Key is string)
			{
				text = (string)item.Key;
			}
			else if (item.Key is bool)
			{
				text = (((bool)item.Key) ? "true" : "false");
			}
			else
			{
				if (!(item.Key is int) && !((item.Key is uint) | (item.Key is long)) && !(item.Key is ulong))
				{
					if (item.Key == null)
					{
						throw new ArgumentException("Dictionary has entry with null key");
					}
					throw new ArgumentException("Unhandled dictionary key type: " + item.Key.GetType());
				}
				text = ((IFormattable)item.Key).ToString("d", CultureInfo.InvariantCulture);
			}
			WriteString(writer, text);
			writer.Write(": ");
			WriteValue(writer, item.Value);
			flag = false;
		}
		writer.Write(flag ? "}" : " }");
	}

	internal static void WriteString(TextWriter writer, string text)
	{
		writer.Write('"');
		for (int i = 0; i < text.Length; i++)
		{
			char c = text[i];
			if (c < '\u00a0')
			{
				writer.Write(CommonRepresentations[(uint)c]);
				continue;
			}
			if (char.IsHighSurrogate(c))
			{
				i++;
				if (i == text.Length || !char.IsLowSurrogate(text[i]))
				{
					throw new ArgumentException("String contains low surrogate not followed by high surrogate");
				}
				HexEncodeUtf16CodeUnit(writer, c);
				HexEncodeUtf16CodeUnit(writer, text[i]);
				continue;
			}
			if (char.IsLowSurrogate(c))
			{
				throw new ArgumentException("String contains high surrogate not preceded by low surrogate");
			}
			switch ((uint)c)
			{
			case 173u:
			case 1757u:
			case 1807u:
			case 6068u:
			case 6069u:
			case 65279u:
			case 65529u:
			case 65530u:
			case 65531u:
				HexEncodeUtf16CodeUnit(writer, c);
				continue;
			}
			if ((c >= '\u0600' && c <= '\u0603') || (c >= '\u200b' && c <= '\u200f') || (c >= '\u2028' && c <= '\u202e') || (c >= '\u2060' && c <= '\u2064') || (c >= '\u206a' && c <= '\u206f'))
			{
				HexEncodeUtf16CodeUnit(writer, c);
			}
			else
			{
				writer.Write(c);
			}
		}
		writer.Write('"');
	}

	private static void HexEncodeUtf16CodeUnit(TextWriter writer, char c)
	{
		writer.Write("\\u");
		writer.Write("0123456789abcdef"[((int)c >> 12) & 0xF]);
		writer.Write("0123456789abcdef"[((int)c >> 8) & 0xF]);
		writer.Write("0123456789abcdef"[((int)c >> 4) & 0xF]);
		writer.Write("0123456789abcdef"[c & 0xF]);
	}
}
