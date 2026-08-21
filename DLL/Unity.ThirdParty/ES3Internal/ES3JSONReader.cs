using System;
using System.Globalization;
using System.IO;
using System.Text;

namespace ES3Internal;

public class ES3JSONReader : ES3Reader
{
	private const char endOfStreamChar = '\uffff';

	public StreamReader baseReader;

	internal ES3JSONReader(Stream stream, ES3Settings settings, bool readHeaderAndFooter = true)
		: base(settings, readHeaderAndFooter)
	{
		baseReader = new StreamReader(stream);
		if (readHeaderAndFooter)
		{
			try
			{
				SkipOpeningBraceOfFile();
			}
			catch
			{
				Dispose();
				throw new FormatException("Cannot load from file because the data in it is not JSON data, or the data is encrypted.\nIf the save data is encrypted, please ensure that encryption is enabled when you load, and that you are using the same password used to encrypt the data.");
			}
		}
	}

	public override string ReadPropertyName()
	{
		char c = PeekCharIgnoreWhitespace();
		if (IsTerminator(c))
		{
			return null;
		}
		if (c == ',')
		{
			ReadCharIgnoreWhitespace();
		}
		else if (!IsQuotationMark(c))
		{
			throw new FormatException("Expected ',' separating properties or '\"' before property name, found '" + c + "'.");
		}
		string text = Read_string();
		if (text == null)
		{
			throw new FormatException("Stream isn't positioned before a property.");
		}
		ES3Debug.Log("<b>" + text + "</b> (reading property)", null, serializationDepth);
		ReadCharIgnoreWhitespace(':');
		return text;
	}

	protected override Type ReadKeyPrefix(bool ignoreType = false)
	{
		StartReadObject();
		Type result = null;
		string text = ReadPropertyName();
		if (text == "__type")
		{
			string typeString = Read_string();
			result = (ignoreType ? null : ES3Reflection.GetType(typeString));
			text = ReadPropertyName();
		}
		if (text != "value")
		{
			throw new FormatException("This data is not Easy Save Key Value data. Expected property name \"value\", found \"" + text + "\".");
		}
		return result;
	}

	protected override void ReadKeySuffix()
	{
		EndReadObject();
	}

	internal override bool StartReadObject()
	{
		base.StartReadObject();
		return ReadNullOrCharIgnoreWhitespace('{');
	}

	internal override void EndReadObject()
	{
		ReadCharIgnoreWhitespace('}');
		base.EndReadObject();
	}

	internal override bool StartReadDictionary()
	{
		return StartReadObject();
	}

	internal override void EndReadDictionary()
	{
	}

	internal override bool StartReadDictionaryKey()
	{
		if (PeekCharIgnoreWhitespace() == '}')
		{
			ReadCharIgnoreWhitespace();
			return false;
		}
		return true;
	}

	internal override void EndReadDictionaryKey()
	{
		ReadCharIgnoreWhitespace(':');
	}

	internal override void StartReadDictionaryValue()
	{
	}

	internal override bool EndReadDictionaryValue()
	{
		char c = ReadCharIgnoreWhitespace();
		return c switch
		{
			'}' => true, 
			',' => false, 
			_ => throw new FormatException("Expected ',' seperating Dictionary items or '}' terminating Dictionary, found '" + c + "'."), 
		};
	}

	internal override bool StartReadCollection()
	{
		return ReadNullOrCharIgnoreWhitespace('[');
	}

	internal override void EndReadCollection()
	{
	}

	internal override bool StartReadCollectionItem()
	{
		if (PeekCharIgnoreWhitespace() == ']')
		{
			ReadCharIgnoreWhitespace();
			return false;
		}
		return true;
	}

	internal override bool EndReadCollectionItem()
	{
		char c = ReadCharIgnoreWhitespace();
		return c switch
		{
			']' => true, 
			',' => false, 
			_ => throw new FormatException("Expected ',' seperating collection items or ']' terminating collection, found '" + c + "'."), 
		};
	}

	private void ReadString(StreamWriter writer, bool skip = false)
	{
		bool flag = false;
		while (!flag)
		{
			char c = ReadOrSkipChar(writer, skip);
			switch (c)
			{
			case '\uffff':
				throw new FormatException("String without closing quotation mark detected.");
			case '\\':
				ReadOrSkipChar(writer, skip);
				continue;
			}
			if (IsQuotationMark(c))
			{
				flag = true;
			}
		}
	}

	internal override byte[] ReadElement(bool skip = false)
	{
		StreamWriter streamWriter = (skip ? null : new StreamWriter(new MemoryStream(settings.bufferSize)));
		using (streamWriter)
		{
			int num = 0;
			char c = (char)baseReader.Peek();
			if (!IsOpeningBrace(c))
			{
				if (c == '"')
				{
					ReadOrSkipChar(streamWriter, skip);
					ReadString(streamWriter, skip);
				}
				else
				{
					while (!IsEndOfValue((char)baseReader.Peek()))
					{
						ReadOrSkipChar(streamWriter, skip);
					}
				}
				if (skip)
				{
					return null;
				}
				streamWriter.Flush();
				return ((MemoryStream)streamWriter.BaseStream).ToArray();
			}
			while (true)
			{
				c = ReadOrSkipChar(streamWriter, skip);
				if (c == '\uffff')
				{
					break;
				}
				if (IsQuotationMark(c))
				{
					ReadString(streamWriter, skip);
					continue;
				}
				switch (c)
				{
				case '[':
				case '{':
					num++;
					break;
				case ']':
				case '}':
					num--;
					if (num < 1)
					{
						if (skip)
						{
							return null;
						}
						streamWriter.Flush();
						return ((MemoryStream)streamWriter.BaseStream).ToArray();
					}
					break;
				}
			}
			throw new FormatException("Missing closing brace detected, as end of stream was reached before finding it.");
		}
	}

	private char ReadOrSkipChar(StreamWriter writer, bool skip)
	{
		char c = (char)baseReader.Read();
		if (!skip)
		{
			writer.Write(c);
		}
		return c;
	}

	private char ReadCharIgnoreWhitespace(bool ignoreTrailingWhitespace = true)
	{
		char result;
		while (IsWhiteSpace(result = (char)baseReader.Read()))
		{
		}
		if (ignoreTrailingWhitespace)
		{
			while (IsWhiteSpace((char)baseReader.Peek()))
			{
				baseReader.Read();
			}
		}
		return result;
	}

	private bool ReadNullOrCharIgnoreWhitespace(char expectedChar)
	{
		char c = ReadCharIgnoreWhitespace();
		if (c == 'n')
		{
			char[] array = new char[3];
			baseReader.ReadBlock(array, 0, 3);
			if (array[0] == 'u' && array[1] == 'l' && array[2] == 'l')
			{
				return true;
			}
		}
		if (c != expectedChar)
		{
			if (c == '\uffff')
			{
				throw new FormatException("End of stream reached when expecting '" + expectedChar + "'.");
			}
			throw new FormatException("Expected '" + expectedChar + "' or \"null\", found '" + c + "'.");
		}
		return false;
	}

	private char ReadCharIgnoreWhitespace(char expectedChar)
	{
		char c = ReadCharIgnoreWhitespace();
		if (c != expectedChar)
		{
			if (c == '\uffff')
			{
				throw new FormatException("End of stream reached when expecting '" + expectedChar + "'.");
			}
			throw new FormatException("Expected '" + expectedChar + "', found '" + c + "'.");
		}
		return c;
	}

	private bool ReadQuotationMarkOrNullIgnoreWhitespace()
	{
		char c = ReadCharIgnoreWhitespace(ignoreTrailingWhitespace: false);
		if (c == 'n')
		{
			char[] array = new char[3];
			baseReader.ReadBlock(array, 0, 3);
			if (array[0] == 'u' && array[1] == 'l' && array[2] == 'l')
			{
				return true;
			}
		}
		else if (!IsQuotationMark(c))
		{
			if (c == '\uffff')
			{
				throw new FormatException("End of stream reached when expecting quotation mark.");
			}
			throw new FormatException("Expected quotation mark, found '" + c + "'.");
		}
		return false;
	}

	private char PeekCharIgnoreWhitespace(char expectedChar)
	{
		char c = PeekCharIgnoreWhitespace();
		if (c != expectedChar)
		{
			if (c == '\uffff')
			{
				throw new FormatException("End of stream reached while peeking, when expecting '" + expectedChar + "'.");
			}
			throw new FormatException("Expected '" + expectedChar + "', found '" + c + "'.");
		}
		return c;
	}

	private char PeekCharIgnoreWhitespace()
	{
		char result;
		while (IsWhiteSpace(result = (char)baseReader.Peek()))
		{
			baseReader.Read();
		}
		return result;
	}

	private void SkipWhiteSpace()
	{
		while (IsWhiteSpace((char)baseReader.Peek()))
		{
			baseReader.Read();
		}
	}

	private void SkipOpeningBraceOfFile()
	{
		char c = ReadCharIgnoreWhitespace();
		if (c != '{')
		{
			throw new FormatException("File is not valid JSON. Expected '{' at beginning of file, but found '" + c + "'.");
		}
	}

	private static bool IsWhiteSpace(char c)
	{
		if (c != ' ' && c != '\t' && c != '\n')
		{
			return c == '\r';
		}
		return true;
	}

	private static bool IsOpeningBrace(char c)
	{
		if (c != '{')
		{
			return c == '[';
		}
		return true;
	}

	private static bool IsEndOfValue(char c)
	{
		if (c != '}' && c != ' ' && c != '\t' && c != ']' && c != ',' && c != ':' && c != '\uffff' && c != '\n')
		{
			return c == '\r';
		}
		return true;
	}

	private static bool IsTerminator(char c)
	{
		if (c != '}')
		{
			return c == ']';
		}
		return true;
	}

	private static bool IsQuotationMark(char c)
	{
		if (c != '"' && c != '“')
		{
			return c == '”';
		}
		return true;
	}

	private static bool IsEndOfStream(char c)
	{
		return c == '\uffff';
	}

	private string GetValueString()
	{
		StringBuilder stringBuilder = new StringBuilder();
		while (!IsEndOfValue(PeekCharIgnoreWhitespace()))
		{
			stringBuilder.Append((char)baseReader.Read());
		}
		if (stringBuilder.Length == 0)
		{
			return null;
		}
		return stringBuilder.ToString();
	}

	internal override string Read_string()
	{
		if (ReadQuotationMarkOrNullIgnoreWhitespace())
		{
			return null;
		}
		StringBuilder stringBuilder = new StringBuilder();
		char c;
		while (!IsQuotationMark(c = (char)baseReader.Read()))
		{
			if (c == '\\')
			{
				c = (char)baseReader.Read();
				if (IsEndOfStream(c))
				{
					throw new FormatException("Reached end of stream while trying to read string literal.");
				}
				switch (c)
				{
				case 'b':
					c = '\b';
					break;
				case 'f':
					c = '\f';
					break;
				case 'n':
					c = '\n';
					break;
				case 'r':
					c = '\r';
					break;
				case 't':
					c = '\t';
					break;
				}
			}
			stringBuilder.Append(c);
		}
		return stringBuilder.ToString();
	}

	internal override long Read_ref()
	{
		if (ES3ReferenceMgrBase.Current == null)
		{
			throw new InvalidOperationException("An Easy Save 3 Manager is required to load references. To add one to your scene, exit playmode and go to Tools > Easy Save 3 > Add Manager to Scene");
		}
		if (IsQuotationMark(PeekCharIgnoreWhitespace()))
		{
			return long.Parse(Read_string());
		}
		return Read_long();
	}

	internal override char Read_char()
	{
		return char.Parse(Read_string());
	}

	internal override float Read_float()
	{
		return float.Parse(GetValueString(), CultureInfo.InvariantCulture);
	}

	internal override int Read_int()
	{
		return int.Parse(GetValueString());
	}

	internal override bool Read_bool()
	{
		return bool.Parse(GetValueString());
	}

	internal override decimal Read_decimal()
	{
		return decimal.Parse(GetValueString(), CultureInfo.InvariantCulture);
	}

	internal override double Read_double()
	{
		return double.Parse(GetValueString(), CultureInfo.InvariantCulture);
	}

	internal override long Read_long()
	{
		return long.Parse(GetValueString());
	}

	internal override ulong Read_ulong()
	{
		return ulong.Parse(GetValueString());
	}

	internal override uint Read_uint()
	{
		return uint.Parse(GetValueString());
	}

	internal override byte Read_byte()
	{
		return (byte)int.Parse(GetValueString());
	}

	internal override sbyte Read_sbyte()
	{
		return (sbyte)int.Parse(GetValueString());
	}

	internal override short Read_short()
	{
		return (short)int.Parse(GetValueString());
	}

	internal override ushort Read_ushort()
	{
		return (ushort)int.Parse(GetValueString());
	}

	internal override byte[] Read_byteArray()
	{
		return Convert.FromBase64String(Read_string());
	}

	public override void Dispose()
	{
		baseReader.Dispose();
	}
}
