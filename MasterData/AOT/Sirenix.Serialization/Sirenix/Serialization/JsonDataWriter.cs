using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Text;

namespace Sirenix.Serialization;

public class JsonDataWriter : BaseDataWriter
{
	private static readonly uint[] ByteToHexCharLookup = CreateByteToHexLookup();

	private static readonly string NEW_LINE = Environment.NewLine;

	private bool justStarted;

	private bool forceNoSeparatorNextLine;

	private Dictionary<Type, Delegate> primitiveTypeWriters;

	private Dictionary<Type, int> seenTypes = new Dictionary<Type, int>(16);

	private byte[] buffer = new byte[102400];

	private int bufferIndex;

	public bool FormatAsReadable;

	public bool EnableTypeOptimization;

	public JsonDataWriter()
		: this(null, null)
	{
	}

	public JsonDataWriter(Stream stream, SerializationContext context, bool formatAsReadable = true)
		: base(stream, context)
	{
		FormatAsReadable = formatAsReadable;
		justStarted = true;
		EnableTypeOptimization = true;
		primitiveTypeWriters = new Dictionary<Type, Delegate>
		{
			{
				typeof(char),
				new Action<string, char>(WriteChar)
			},
			{
				typeof(sbyte),
				new Action<string, sbyte>(WriteSByte)
			},
			{
				typeof(short),
				new Action<string, short>(WriteInt16)
			},
			{
				typeof(int),
				new Action<string, int>(WriteInt32)
			},
			{
				typeof(long),
				new Action<string, long>(WriteInt64)
			},
			{
				typeof(byte),
				new Action<string, byte>(WriteByte)
			},
			{
				typeof(ushort),
				new Action<string, ushort>(WriteUInt16)
			},
			{
				typeof(uint),
				new Action<string, uint>(WriteUInt32)
			},
			{
				typeof(ulong),
				new Action<string, ulong>(WriteUInt64)
			},
			{
				typeof(decimal),
				new Action<string, decimal>(WriteDecimal)
			},
			{
				typeof(bool),
				new Action<string, bool>(WriteBoolean)
			},
			{
				typeof(float),
				new Action<string, float>(WriteSingle)
			},
			{
				typeof(double),
				new Action<string, double>(WriteDouble)
			},
			{
				typeof(Guid),
				new Action<string, Guid>(WriteGuid)
			}
		};
	}

	public void MarkJustStarted()
	{
		justStarted = true;
	}

	public override void FlushToStream()
	{
		if (bufferIndex > 0)
		{
			Stream.Write(buffer, 0, bufferIndex);
			bufferIndex = 0;
		}
		base.FlushToStream();
	}

	public override void BeginReferenceNode(string name, Type type, int id)
	{
		WriteEntry(name, "{");
		PushNode(name, id, type);
		forceNoSeparatorNextLine = true;
		WriteInt32("$id", id);
		if (type != null)
		{
			WriteTypeEntry(type);
		}
	}

	public override void BeginStructNode(string name, Type type)
	{
		WriteEntry(name, "{");
		PushNode(name, -1, type);
		forceNoSeparatorNextLine = true;
		if (type != null)
		{
			WriteTypeEntry(type);
		}
	}

	public override void EndNode(string name)
	{
		PopNode(name);
		StartNewLine(noSeparator: true);
		EnsureBufferSpace(1);
		buffer[bufferIndex++] = 125;
	}

	public override void BeginArrayNode(long length)
	{
		WriteInt64("$rlength", length);
		WriteEntry("$rcontent", "[");
		forceNoSeparatorNextLine = true;
		PushArray();
	}

	public override void EndArrayNode()
	{
		PopArray();
		StartNewLine(noSeparator: true);
		EnsureBufferSpace(1);
		buffer[bufferIndex++] = 93;
	}

	public override void WritePrimitiveArray<T>(T[] array)
	{
		if (!FormatterUtilities.IsPrimitiveArrayType(typeof(T)))
		{
			throw new ArgumentException("Type " + typeof(T).Name + " is not a valid primitive array type.");
		}
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		Action<string, T> action = (Action<string, T>)primitiveTypeWriters[typeof(T)];
		WriteInt64("$plength", array.Length);
		WriteEntry("$pcontent", "[");
		forceNoSeparatorNextLine = true;
		PushArray();
		for (int i = 0; i < array.Length; i++)
		{
			action(null, array[i]);
		}
		PopArray();
		StartNewLine(noSeparator: true);
		EnsureBufferSpace(1);
		buffer[bufferIndex++] = 93;
	}

	public override void WriteBoolean(string name, bool value)
	{
		WriteEntry(name, value ? "true" : "false");
	}

	public override void WriteByte(string name, byte value)
	{
		WriteUInt64(name, value);
	}

	public override void WriteChar(string name, char value)
	{
		WriteString(name, value.ToString(CultureInfo.InvariantCulture));
	}

	public override void WriteDecimal(string name, decimal value)
	{
		WriteEntry(name, value.ToString("G", CultureInfo.InvariantCulture));
	}

	public override void WriteDouble(string name, double value)
	{
		WriteEntry(name, value.ToString("R", CultureInfo.InvariantCulture));
	}

	public override void WriteInt32(string name, int value)
	{
		WriteInt64(name, value);
	}

	public override void WriteInt64(string name, long value)
	{
		WriteEntry(name, value.ToString("D", CultureInfo.InvariantCulture));
	}

	public override void WriteNull(string name)
	{
		WriteEntry(name, "null");
	}

	public override void WriteInternalReference(string name, int id)
	{
		WriteEntry(name, "$iref:" + id.ToString("D", CultureInfo.InvariantCulture));
	}

	public override void WriteSByte(string name, sbyte value)
	{
		WriteInt64(name, value);
	}

	public override void WriteInt16(string name, short value)
	{
		WriteInt64(name, value);
	}

	public override void WriteSingle(string name, float value)
	{
		WriteEntry(name, value.ToString("R", CultureInfo.InvariantCulture));
	}

	public override void WriteString(string name, string value)
	{
		StartNewLine();
		if (name != null)
		{
			EnsureBufferSpace(name.Length + value.Length + 6);
			buffer[bufferIndex++] = 34;
			for (int i = 0; i < name.Length; i++)
			{
				buffer[bufferIndex++] = (byte)name[i];
			}
			buffer[bufferIndex++] = 34;
			buffer[bufferIndex++] = 58;
			if (FormatAsReadable)
			{
				buffer[bufferIndex++] = 32;
			}
		}
		else
		{
			EnsureBufferSpace(value.Length + 2);
		}
		buffer[bufferIndex++] = 34;
		Buffer_WriteString_WithEscape(value);
		buffer[bufferIndex++] = 34;
	}

	public override void WriteGuid(string name, Guid value)
	{
		WriteEntry(name, value.ToString("D", CultureInfo.InvariantCulture));
	}

	public override void WriteUInt32(string name, uint value)
	{
		WriteUInt64(name, value);
	}

	public override void WriteUInt64(string name, ulong value)
	{
		WriteEntry(name, value.ToString("D", CultureInfo.InvariantCulture));
	}

	public override void WriteExternalReference(string name, int index)
	{
		WriteEntry(name, "$eref:" + index.ToString("D", CultureInfo.InvariantCulture));
	}

	public override void WriteExternalReference(string name, Guid guid)
	{
		WriteEntry(name, "$guidref:" + guid.ToString("D", CultureInfo.InvariantCulture));
	}

	public override void WriteExternalReference(string name, string id)
	{
		if (id == null)
		{
			throw new ArgumentNullException("id");
		}
		WriteEntry(name, "$fstrref");
		EnsureBufferSpace(id.Length + 3);
		buffer[bufferIndex++] = 58;
		buffer[bufferIndex++] = 34;
		Buffer_WriteString_WithEscape(id);
		buffer[bufferIndex++] = 34;
	}

	public override void WriteUInt16(string name, ushort value)
	{
		WriteUInt64(name, value);
	}

	public override void Dispose()
	{
	}

	public override void PrepareNewSerializationSession()
	{
		base.PrepareNewSerializationSession();
		seenTypes.Clear();
		justStarted = true;
	}

	public override string GetDataDump()
	{
		if (!Stream.CanRead)
		{
			return "Json data stream for writing cannot be read; cannot dump data.";
		}
		if (!Stream.CanSeek)
		{
			return "Json data stream cannot seek; cannot dump data.";
		}
		long position = Stream.Position;
		byte[] array = new byte[position];
		Stream.Position = 0L;
		Stream.Read(array, 0, (int)position);
		Stream.Position = position;
		return "Json: " + Encoding.UTF8.GetString(array, 0, array.Length);
	}

	private void WriteEntry(string name, string contents)
	{
		StartNewLine();
		if (name != null)
		{
			EnsureBufferSpace(name.Length + contents.Length + 4);
			buffer[bufferIndex++] = 34;
			for (int i = 0; i < name.Length; i++)
			{
				buffer[bufferIndex++] = (byte)name[i];
			}
			buffer[bufferIndex++] = 34;
			buffer[bufferIndex++] = 58;
			if (FormatAsReadable)
			{
				buffer[bufferIndex++] = 32;
			}
		}
		else
		{
			EnsureBufferSpace(contents.Length);
		}
		for (int j = 0; j < contents.Length; j++)
		{
			buffer[bufferIndex++] = (byte)contents[j];
		}
	}

	private void WriteEntry(string name, string contents, char surroundContentsWith)
	{
		StartNewLine();
		if (name != null)
		{
			EnsureBufferSpace(name.Length + contents.Length + 6);
			buffer[bufferIndex++] = 34;
			for (int i = 0; i < name.Length; i++)
			{
				buffer[bufferIndex++] = (byte)name[i];
			}
			buffer[bufferIndex++] = 34;
			buffer[bufferIndex++] = 58;
			if (FormatAsReadable)
			{
				buffer[bufferIndex++] = 32;
			}
		}
		else
		{
			EnsureBufferSpace(contents.Length + 2);
		}
		buffer[bufferIndex++] = (byte)surroundContentsWith;
		for (int j = 0; j < contents.Length; j++)
		{
			buffer[bufferIndex++] = (byte)contents[j];
		}
		buffer[bufferIndex++] = (byte)surroundContentsWith;
	}

	private void WriteTypeEntry(Type type)
	{
		if (EnableTypeOptimization)
		{
			if (seenTypes.TryGetValue(type, out var value))
			{
				WriteInt32("$type", value);
				return;
			}
			value = seenTypes.Count;
			seenTypes.Add(type, value);
			WriteString("$type", value + "|" + Context.Binder.BindToName(type, Context.Config.DebugContext));
		}
		else
		{
			WriteString("$type", Context.Binder.BindToName(type, Context.Config.DebugContext));
		}
	}

	private void StartNewLine(bool noSeparator = false)
	{
		if (justStarted)
		{
			justStarted = false;
			return;
		}
		if (!noSeparator && !forceNoSeparatorNextLine)
		{
			EnsureBufferSpace(1);
			buffer[bufferIndex++] = 44;
		}
		forceNoSeparatorNextLine = false;
		if (FormatAsReadable)
		{
			int num = NodeDepth * 4;
			EnsureBufferSpace(NEW_LINE.Length + num);
			for (int i = 0; i < NEW_LINE.Length; i++)
			{
				buffer[bufferIndex++] = (byte)NEW_LINE[i];
			}
			for (int j = 0; j < num; j++)
			{
				buffer[bufferIndex++] = 32;
			}
		}
	}

	private void EnsureBufferSpace(int space)
	{
		int num = buffer.Length;
		if (space > num)
		{
			throw new Exception("Insufficient buffer capacity");
		}
		if (bufferIndex + space > num)
		{
			FlushToStream();
		}
	}

	private void Buffer_WriteString_WithEscape(string str)
	{
		EnsureBufferSpace(str.Length);
		for (int i = 0; i < str.Length; i++)
		{
			char c = str[i];
			if (c < '\0' || c > '\u007f')
			{
				EnsureBufferSpace(str.Length - i + 6);
				buffer[bufferIndex++] = 92;
				buffer[bufferIndex++] = 117;
				int num = (int)c >> 8;
				byte b = (byte)c;
				uint num2 = ByteToHexCharLookup[num];
				buffer[bufferIndex++] = (byte)num2;
				buffer[bufferIndex++] = (byte)(num2 >> 16);
				num2 = ByteToHexCharLookup[b];
				buffer[bufferIndex++] = (byte)num2;
				buffer[bufferIndex++] = (byte)(num2 >> 16);
				continue;
			}
			EnsureBufferSpace(2);
			switch (c)
			{
			case '"':
				buffer[bufferIndex++] = 92;
				buffer[bufferIndex++] = 34;
				break;
			case '\\':
				buffer[bufferIndex++] = 92;
				buffer[bufferIndex++] = 92;
				break;
			case '\a':
				buffer[bufferIndex++] = 92;
				buffer[bufferIndex++] = 97;
				break;
			case '\b':
				buffer[bufferIndex++] = 92;
				buffer[bufferIndex++] = 98;
				break;
			case '\f':
				buffer[bufferIndex++] = 92;
				buffer[bufferIndex++] = 102;
				break;
			case '\n':
				buffer[bufferIndex++] = 92;
				buffer[bufferIndex++] = 110;
				break;
			case '\r':
				buffer[bufferIndex++] = 92;
				buffer[bufferIndex++] = 114;
				break;
			case '\t':
				buffer[bufferIndex++] = 92;
				buffer[bufferIndex++] = 116;
				break;
			case '\0':
				buffer[bufferIndex++] = 92;
				buffer[bufferIndex++] = 48;
				break;
			default:
				buffer[bufferIndex++] = (byte)c;
				break;
			}
		}
	}

	private static uint[] CreateByteToHexLookup()
	{
		uint[] array = new uint[256];
		for (int i = 0; i < 256; i++)
		{
			string text = i.ToString("x2", CultureInfo.InvariantCulture);
			array[i] = text[0] + ((uint)text[1] << 16);
		}
		return array;
	}
}
