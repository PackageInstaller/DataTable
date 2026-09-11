using System;
using System.Buffers;
using System.IO;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading;
using MessagePack.Internal;

namespace MessagePack;

public ref struct MessagePackReader
{
	private SequenceReader<byte> reader;

	public CancellationToken CancellationToken { get; set; }

	public int Depth { get; set; }

	public ReadOnlySequence<byte> Sequence => reader.Sequence;

	public SequencePosition Position => reader.Position;

	public long Consumed => reader.Consumed;

	public bool End => reader.End;

	public bool IsNil => NextCode == 192;

	public MessagePackType NextMessagePackType => MessagePackCode.ToMessagePackType(NextCode);

	public byte NextCode
	{
		get
		{
			ThrowInsufficientBufferUnless(reader.TryPeek(out var value));
			return value;
		}
	}

	public MessagePackReader(ReadOnlyMemory<byte> memory)
	{
		this = default(MessagePackReader);
		reader = new SequenceReader<byte>(memory);
		Depth = 0;
	}

	public MessagePackReader(in ReadOnlySequence<byte> readOnlySequence)
	{
		this = default(MessagePackReader);
		reader = new SequenceReader<byte>(in readOnlySequence);
		Depth = 0;
	}

	public MessagePackReader Clone(in ReadOnlySequence<byte> readOnlySequence)
	{
		MessagePackReader result = new MessagePackReader(in readOnlySequence);
		result.CancellationToken = CancellationToken;
		result.Depth = Depth;
		return result;
	}

	public MessagePackReader CreatePeekReader()
	{
		return this;
	}

	public void Skip()
	{
		ThrowInsufficientBufferUnless(TrySkip());
	}

	internal bool TrySkip()
	{
		if (reader.Remaining == 0L)
		{
			return false;
		}
		byte nextCode = NextCode;
		int length;
		switch (nextCode)
		{
		case 192:
		case 194:
		case 195:
			return reader.TryAdvance(1L);
		case 204:
		case 208:
			return reader.TryAdvance(2L);
		case 205:
		case 209:
			return reader.TryAdvance(3L);
		case 202:
		case 206:
		case 210:
			return reader.TryAdvance(5L);
		case 203:
		case 207:
		case 211:
			return reader.TryAdvance(9L);
		case 222:
		case 223:
			return TrySkipNextMap();
		case 220:
		case 221:
			return TrySkipNextArray();
		case 217:
		case 218:
		case 219:
			if (TryGetStringLengthInBytes(out length))
			{
				return reader.TryAdvance(length);
			}
			return false;
		case 196:
		case 197:
		case 198:
			if (TryGetBytesLength(out length))
			{
				return reader.TryAdvance(length);
			}
			return false;
		case 199:
		case 200:
		case 201:
		case 212:
		case 213:
		case 214:
		case 215:
		case 216:
		{
			if (TryReadExtensionFormatHeader(out var extensionHeader))
			{
				return reader.TryAdvance(extensionHeader.Length);
			}
			return false;
		}
		default:
			if (nextCode < 0 || nextCode > 127)
			{
				break;
			}
			goto case 224;
		case 224:
		case 225:
		case 226:
		case 227:
		case 228:
		case 229:
		case 230:
		case 231:
		case 232:
		case 233:
		case 234:
		case 235:
		case 236:
		case 237:
		case 238:
		case 239:
		case 240:
		case 241:
		case 242:
		case 243:
		case 244:
		case 245:
		case 246:
		case 247:
		case 248:
		case 249:
		case 250:
		case 251:
		case 252:
		case 253:
		case 254:
		case byte.MaxValue:
			return reader.TryAdvance(1L);
		}
		if (nextCode >= 128 && nextCode <= 143)
		{
			return TrySkipNextMap();
		}
		if (nextCode >= 144 && nextCode <= 159)
		{
			return TrySkipNextArray();
		}
		if (nextCode >= 160 && nextCode <= 191)
		{
			if (TryGetStringLengthInBytes(out length))
			{
				return reader.TryAdvance(length);
			}
			return false;
		}
		throw ThrowInvalidCode(nextCode);
	}

	public Nil ReadNil()
	{
		ThrowInsufficientBufferUnless(reader.TryRead(out var value));
		if (value != 192)
		{
			throw ThrowInvalidCode(value);
		}
		return Nil.Default;
	}

	[MethodImpl((MethodImplOptions)256)]
	public bool TryReadNil()
	{
		if (NextCode == 192)
		{
			reader.Advance(1L);
			return true;
		}
		return false;
	}

	public ReadOnlySequence<byte> ReadRaw(long length)
	{
		try
		{
			ReadOnlySequence<byte> result = reader.Sequence.Slice(reader.Position, length);
			reader.Advance(length);
			return result;
		}
		catch (ArgumentOutOfRangeException innerException)
		{
			throw ThrowNotEnoughBytesException(innerException);
		}
	}

	public ReadOnlySequence<byte> ReadRaw()
	{
		SequencePosition position = Position;
		Skip();
		return Sequence.Slice(position, Position);
	}

	public int ReadArrayHeader()
	{
		ThrowInsufficientBufferUnless(TryReadArrayHeader(out var count));
		ThrowInsufficientBufferUnless(reader.Remaining >= count);
		return count;
	}

	[MethodImpl((MethodImplOptions)256)]
	public bool TryReadArrayHeader(out int count)
	{
		count = -1;
		if (!reader.TryRead(out var value))
		{
			return false;
		}
		switch (value)
		{
		case 220:
		{
			if (!reader.TryReadBigEndian(out short value3))
			{
				return false;
			}
			count = (ushort)value3;
			break;
		}
		case 221:
		{
			if (!reader.TryReadBigEndian(out int value2))
			{
				return false;
			}
			count = value2;
			break;
		}
		case 144:
		case 145:
		case 146:
		case 147:
		case 148:
		case 149:
		case 150:
		case 151:
		case 152:
		case 153:
		case 154:
		case 155:
		case 156:
		case 157:
		case 158:
		case 159:
			count = value & 0xF;
			break;
		default:
			throw ThrowInvalidCode(value);
		}
		return true;
	}

	public int ReadMapHeader()
	{
		ThrowInsufficientBufferUnless(TryReadMapHeader(out var count));
		ThrowInsufficientBufferUnless(reader.Remaining >= count * 2);
		return count;
	}

	public bool TryReadMapHeader(out int count)
	{
		count = -1;
		if (!reader.TryRead(out var value))
		{
			return false;
		}
		switch (value)
		{
		case 222:
		{
			if (!reader.TryReadBigEndian(out short value3))
			{
				return false;
			}
			count = (ushort)value3;
			break;
		}
		case 223:
		{
			if (!reader.TryReadBigEndian(out int value2))
			{
				return false;
			}
			count = value2;
			break;
		}
		case 128:
		case 129:
		case 130:
		case 131:
		case 132:
		case 133:
		case 134:
		case 135:
		case 136:
		case 137:
		case 138:
		case 139:
		case 140:
		case 141:
		case 142:
		case 143:
			count = (byte)(value & 0xF);
			break;
		default:
			throw ThrowInvalidCode(value);
		}
		return true;
	}

	public bool ReadBoolean()
	{
		ThrowInsufficientBufferUnless(reader.TryRead(out var value));
		return value switch
		{
			195 => true, 
			194 => false, 
			_ => throw ThrowInvalidCode(value), 
		};
	}

	public char ReadChar()
	{
		return (char)ReadUInt16();
	}

	public float ReadSingle()
	{
		ThrowInsufficientBufferUnless(reader.TryRead(out var value));
		switch (value)
		{
		case 202:
		{
			ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out float value3));
			return value3;
		}
		case 203:
		{
			ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out double value2));
			return (float)value2;
		}
		case 208:
		{
			ThrowInsufficientBufferUnless(SequenceReaderExtensions.TryRead(ref reader, out var value4));
			return value4;
		}
		case 209:
		{
			ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out short value11));
			return value11;
		}
		case 210:
		{
			ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out int value10));
			return value10;
		}
		case 211:
		{
			ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out long value9));
			return value9;
		}
		case 204:
		{
			ThrowInsufficientBufferUnless(reader.TryRead(out var value8));
			return (int)value8;
		}
		case 205:
		{
			ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out ushort value7));
			return (int)value7;
		}
		case 206:
		{
			ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out uint value6));
			return value6;
		}
		case 207:
		{
			ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out ulong value5));
			return value5;
		}
		case 224:
		case 225:
		case 226:
		case 227:
		case 228:
		case 229:
		case 230:
		case 231:
		case 232:
		case 233:
		case 234:
		case 235:
		case 236:
		case 237:
		case 238:
		case 239:
		case 240:
		case 241:
		case 242:
		case 243:
		case 244:
		case 245:
		case 246:
		case 247:
		case 248:
		case 249:
		case 250:
		case 251:
		case 252:
		case 253:
		case 254:
		case byte.MaxValue:
			return (sbyte)value;
		default:
			if (value >= 0 && value <= 127)
			{
				return (int)value;
			}
			throw ThrowInvalidCode(value);
		}
	}

	public double ReadDouble()
	{
		ThrowInsufficientBufferUnless(reader.TryRead(out var value));
		byte value4;
		short value7;
		int value6;
		long value5;
		switch (value)
		{
		case 203:
		{
			ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out double value3));
			return value3;
		}
		case 202:
		{
			ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out float value2));
			return value2;
		}
		case 208:
			ThrowInsufficientBufferUnless(reader.TryRead(out value4));
			return (sbyte)value4;
		case 209:
			ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out value7));
			return value7;
		case 210:
			ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out value6));
			return value6;
		case 211:
			ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out value5));
			return value5;
		case 204:
			ThrowInsufficientBufferUnless(reader.TryRead(out value4));
			return (int)value4;
		case 205:
			ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out value7));
			return (int)(ushort)value7;
		case 206:
			ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out value6));
			return (uint)value6;
		case 207:
			ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out value5));
			return (ulong)value5;
		case 224:
		case 225:
		case 226:
		case 227:
		case 228:
		case 229:
		case 230:
		case 231:
		case 232:
		case 233:
		case 234:
		case 235:
		case 236:
		case 237:
		case 238:
		case 239:
		case 240:
		case 241:
		case 242:
		case 243:
		case 244:
		case 245:
		case 246:
		case 247:
		case 248:
		case 249:
		case 250:
		case 251:
		case 252:
		case 253:
		case 254:
		case byte.MaxValue:
			return (sbyte)value;
		default:
			if (value >= 0 && value <= 127)
			{
				return (int)value;
			}
			throw ThrowInvalidCode(value);
		}
	}

	public DateTime ReadDateTime()
	{
		return ReadDateTime(ReadExtensionFormatHeader());
	}

	public DateTime ReadDateTime(ExtensionHeader header)
	{
		if (header.TypeCode != -1)
		{
			throw new MessagePackSerializationException($"Extension TypeCode is invalid. typeCode: {header.TypeCode}");
		}
		int value;
		long value2;
		switch (header.Length)
		{
		case 4u:
		{
			ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out value));
			DateTime unixEpoch = DateTimeConstants.UnixEpoch;
			return unixEpoch.AddSeconds((uint)value);
		}
		case 8u:
		{
			ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out value2));
			long num2 = value2;
			long num = num2 >>> 34;
			ulong num3 = (ulong)(num2 & 0x3FFFFFFFFL);
			DateTime unixEpoch = DateTimeConstants.UnixEpoch;
			return unixEpoch.AddSeconds(num3).AddTicks(num / 100);
		}
		case 12u:
		{
			ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out value));
			long num = (uint)value;
			ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out value2));
			DateTime unixEpoch = DateTimeConstants.UnixEpoch;
			return unixEpoch.AddSeconds(value2).AddTicks(num / 100);
		}
		default:
			throw new MessagePackSerializationException($"Length of extension was {header.Length}. Either 4 or 8 were expected.");
		}
	}

	public ReadOnlySequence<byte>? ReadBytes()
	{
		if (TryReadNil())
		{
			return null;
		}
		int bytesLength = GetBytesLength();
		ThrowInsufficientBufferUnless(reader.Remaining >= bytesLength);
		ReadOnlySequence<byte> value = reader.Sequence.Slice(reader.Position, bytesLength);
		reader.Advance(bytesLength);
		return value;
	}

	public ReadOnlySequence<byte>? ReadStringSequence()
	{
		if (TryReadNil())
		{
			return null;
		}
		int stringLengthInBytes = GetStringLengthInBytes();
		ThrowInsufficientBufferUnless(reader.Remaining >= stringLengthInBytes);
		ReadOnlySequence<byte> value = reader.Sequence.Slice(reader.Position, stringLengthInBytes);
		reader.Advance(stringLengthInBytes);
		return value;
	}

	public bool TryReadStringSpan(out ReadOnlySpan<byte> span)
	{
		if (IsNil)
		{
			span = default(ReadOnlySpan<byte>);
			return false;
		}
		long consumed = reader.Consumed;
		int stringLengthInBytes = GetStringLengthInBytes();
		ThrowInsufficientBufferUnless(reader.Remaining >= stringLengthInBytes);
		int num = reader.CurrentSpanIndex + stringLengthInBytes;
		ReadOnlySpan<byte> currentSpan = reader.CurrentSpan;
		if (num <= currentSpan.Length)
		{
			currentSpan = reader.CurrentSpan;
			span = currentSpan.Slice(reader.CurrentSpanIndex, stringLengthInBytes);
			reader.Advance(stringLengthInBytes);
			return true;
		}
		reader.Rewind(reader.Consumed - consumed);
		span = default(ReadOnlySpan<byte>);
		return false;
	}

	[MethodImpl((MethodImplOptions)256)]
	public string ReadString()
	{
		if (TryReadNil())
		{
			return null;
		}
		int stringLengthInBytes = GetStringLengthInBytes();
		ReadOnlySpan<byte> unreadSpan = reader.UnreadSpan;
		if (unreadSpan.Length >= stringLengthInBytes)
		{
			string result = StringEncoding.UTF8.GetString(unreadSpan.Slice(0, stringLengthInBytes));
			reader.Advance(stringLengthInBytes);
			return result;
		}
		return ReadStringSlow(stringLengthInBytes);
	}

	public ExtensionHeader ReadExtensionFormatHeader()
	{
		ThrowInsufficientBufferUnless(TryReadExtensionFormatHeader(out var extensionHeader));
		ThrowInsufficientBufferUnless(reader.Remaining >= extensionHeader.Length);
		return extensionHeader;
	}

	public bool TryReadExtensionFormatHeader(out ExtensionHeader extensionHeader)
	{
		extensionHeader = default(ExtensionHeader);
		if (!reader.TryRead(out var value))
		{
			return false;
		}
		uint length;
		switch (value)
		{
		case 212:
			length = 1u;
			break;
		case 213:
			length = 2u;
			break;
		case 214:
			length = 4u;
			break;
		case 215:
			length = 8u;
			break;
		case 216:
			length = 16u;
			break;
		case 199:
		{
			if (!reader.TryRead(out var value4))
			{
				return false;
			}
			length = value4;
			break;
		}
		case 200:
		{
			if (!reader.TryReadBigEndian(out short value3))
			{
				return false;
			}
			length = (ushort)value3;
			break;
		}
		case 201:
		{
			if (!reader.TryReadBigEndian(out int value2))
			{
				return false;
			}
			length = (uint)value2;
			break;
		}
		default:
			throw ThrowInvalidCode(value);
		}
		if (!reader.TryRead(out var value5))
		{
			return false;
		}
		extensionHeader = new ExtensionHeader((sbyte)value5, length);
		return true;
	}

	public ExtensionResult ReadExtensionFormat()
	{
		ExtensionHeader extensionHeader = ReadExtensionFormatHeader();
		try
		{
			ReadOnlySequence<byte> data = reader.Sequence.Slice(reader.Position, extensionHeader.Length);
			reader.Advance(extensionHeader.Length);
			return new ExtensionResult(extensionHeader.TypeCode, data);
		}
		catch (ArgumentOutOfRangeException innerException)
		{
			throw ThrowNotEnoughBytesException(innerException);
		}
	}

	private static EndOfStreamException ThrowNotEnoughBytesException()
	{
		throw new EndOfStreamException();
	}

	private static EndOfStreamException ThrowNotEnoughBytesException(Exception innerException)
	{
		throw new EndOfStreamException(new EndOfStreamException().Message, innerException);
	}

	private static Exception ThrowInvalidCode(byte code)
	{
		throw new MessagePackSerializationException($"Unexpected msgpack code {code} ({MessagePackCode.ToFormatName(code)}) encountered.");
	}

	private static void ThrowInsufficientBufferUnless(bool condition)
	{
		if (!condition)
		{
			ThrowNotEnoughBytesException();
		}
	}

	private int GetBytesLength()
	{
		ThrowInsufficientBufferUnless(TryGetBytesLength(out var length));
		return length;
	}

	private bool TryGetBytesLength(out int length)
	{
		if (!reader.TryRead(out var value))
		{
			length = 0;
			return false;
		}
		switch (value)
		{
		case 196:
		{
			if (reader.TryRead(out var value2))
			{
				length = value2;
				return true;
			}
			break;
		}
		case 197:
		case 218:
		{
			if (reader.TryReadBigEndian(out short value3))
			{
				length = (ushort)value3;
				return true;
			}
			break;
		}
		case 198:
		case 219:
			if (reader.TryReadBigEndian(out length))
			{
				return true;
			}
			break;
		case 160:
		case 161:
		case 162:
		case 163:
		case 164:
		case 165:
		case 166:
		case 167:
		case 168:
		case 169:
		case 170:
		case 171:
		case 172:
		case 173:
		case 174:
		case 175:
		case 176:
		case 177:
		case 178:
		case 179:
		case 180:
		case 181:
		case 182:
		case 183:
		case 184:
		case 185:
		case 186:
		case 187:
		case 188:
		case 189:
		case 190:
		case 191:
			length = value & 0x1F;
			return true;
		default:
			throw ThrowInvalidCode(value);
		}
		length = 0;
		return false;
	}

	[MethodImpl((MethodImplOptions)256)]
	private bool TryGetStringLengthInBytes(out int length)
	{
		if (!reader.TryRead(out var value))
		{
			length = 0;
			return false;
		}
		if (value >= 160 && value <= 191)
		{
			length = value & 0x1F;
			return true;
		}
		return TryGetStringLengthInBytesSlow(value, out length);
	}

	private int GetStringLengthInBytes()
	{
		ThrowInsufficientBufferUnless(TryGetStringLengthInBytes(out var length));
		return length;
	}

	[MethodImpl((MethodImplOptions)256)]
	private bool TryGetStringLengthInBytesSlow(byte code, out int length)
	{
		switch (code)
		{
		case 217:
		{
			if (reader.TryRead(out var value2))
			{
				length = value2;
				return true;
			}
			break;
		}
		case 218:
		{
			if (reader.TryReadBigEndian(out short value3))
			{
				length = (ushort)value3;
				return true;
			}
			break;
		}
		case 219:
		{
			if (reader.TryReadBigEndian(out int value))
			{
				length = value;
				return true;
			}
			break;
		}
		case 160:
		case 161:
		case 162:
		case 163:
		case 164:
		case 165:
		case 166:
		case 167:
		case 168:
		case 169:
		case 170:
		case 171:
		case 172:
		case 173:
		case 174:
		case 175:
		case 176:
		case 177:
		case 178:
		case 179:
		case 180:
		case 181:
		case 182:
		case 183:
		case 184:
		case 185:
		case 186:
		case 187:
		case 188:
		case 189:
		case 190:
		case 191:
			length = code & 0x1F;
			return true;
		default:
			throw ThrowInvalidCode(code);
		}
		length = 0;
		return false;
	}

	private unsafe string ReadStringSlow(int byteLength)
	{
		ThrowInsufficientBufferUnless(reader.Remaining >= byteLength);
		int maxCharCount = StringEncoding.UTF8.GetMaxCharCount(byteLength);
		char[] array = ArrayPool<char>.Shared.Rent(maxCharCount);
		Decoder decoder = StringEncoding.UTF8.GetDecoder();
		int num = byteLength;
		int num2 = 0;
		while (num > 0)
		{
			int val = num;
			ReadOnlySpan<byte> unreadSpan = reader.UnreadSpan;
			int num3 = Math.Min(val, unreadSpan.Length);
			num -= num3;
			bool flush = num == 0;
			unreadSpan = reader.UnreadSpan;
			fixed (byte* bytes = unreadSpan)
			{
				fixed (char* chars = &array[num2])
				{
					num2 += decoder.GetChars(bytes, num3, chars, array.Length - num2, flush);
				}
			}
			reader.Advance(num3);
		}
		string result = new string(array, 0, num2);
		ArrayPool<char>.Shared.Return(array);
		return result;
	}

	private bool TrySkipNextArray()
	{
		if (TryReadArrayHeader(out var count))
		{
			return TrySkip(count);
		}
		return false;
	}

	private bool TrySkipNextMap()
	{
		if (TryReadMapHeader(out var count))
		{
			return TrySkip(count * 2);
		}
		return false;
	}

	private bool TrySkip(int count)
	{
		for (int i = 0; i < count; i++)
		{
			if (!TrySkip())
			{
				return false;
			}
		}
		return true;
	}

	public byte ReadByte()
	{
		ThrowInsufficientBufferUnless(reader.TryRead(out var value));
		checked
		{
			switch (value)
			{
			case 204:
			{
				ThrowInsufficientBufferUnless(reader.TryRead(out var value3));
				return value3;
			}
			case 208:
			{
				ThrowInsufficientBufferUnless(SequenceReaderExtensions.TryRead(ref reader, out var value2));
				return (byte)value2;
			}
			case 205:
			{
				ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out ushort value4));
				return (byte)value4;
			}
			case 209:
			{
				ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out short value9));
				return (byte)value9;
			}
			case 206:
			{
				ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out uint value8));
				return (byte)value8;
			}
			case 210:
			{
				ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out int value7));
				return (byte)value7;
			}
			case 207:
			{
				ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out ulong value6));
				return (byte)value6;
			}
			case 211:
			{
				ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out long value5));
				return (byte)value5;
			}
			case 224:
			case 225:
			case 226:
			case 227:
			case 228:
			case 229:
			case 230:
			case 231:
			case 232:
			case 233:
			case 234:
			case 235:
			case 236:
			case 237:
			case 238:
			case 239:
			case 240:
			case 241:
			case 242:
			case 243:
			case 244:
			case 245:
			case 246:
			case 247:
			case 248:
			case 249:
			case 250:
			case 251:
			case 252:
			case 253:
			case 254:
			case byte.MaxValue:
				return (byte)unchecked((sbyte)value);
			default:
				if (value >= 0 && value <= 127)
				{
					return value;
				}
				throw ThrowInvalidCode(value);
			}
		}
	}

	public ushort ReadUInt16()
	{
		ThrowInsufficientBufferUnless(reader.TryRead(out var value));
		checked
		{
			switch (value)
			{
			case 204:
			{
				ThrowInsufficientBufferUnless(reader.TryRead(out var value3));
				return value3;
			}
			case 208:
			{
				ThrowInsufficientBufferUnless(SequenceReaderExtensions.TryRead(ref reader, out var value2));
				return (ushort)value2;
			}
			case 205:
			{
				ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out ushort value4));
				return value4;
			}
			case 209:
			{
				ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out short value9));
				return (ushort)value9;
			}
			case 206:
			{
				ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out uint value8));
				return (ushort)value8;
			}
			case 210:
			{
				ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out int value7));
				return (ushort)value7;
			}
			case 207:
			{
				ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out ulong value6));
				return (ushort)value6;
			}
			case 211:
			{
				ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out long value5));
				return (ushort)value5;
			}
			case 224:
			case 225:
			case 226:
			case 227:
			case 228:
			case 229:
			case 230:
			case 231:
			case 232:
			case 233:
			case 234:
			case 235:
			case 236:
			case 237:
			case 238:
			case 239:
			case 240:
			case 241:
			case 242:
			case 243:
			case 244:
			case 245:
			case 246:
			case 247:
			case 248:
			case 249:
			case 250:
			case 251:
			case 252:
			case 253:
			case 254:
			case byte.MaxValue:
				return (ushort)unchecked((sbyte)value);
			default:
				if (value >= 0 && value <= 127)
				{
					return value;
				}
				throw ThrowInvalidCode(value);
			}
		}
	}

	public uint ReadUInt32()
	{
		ThrowInsufficientBufferUnless(reader.TryRead(out var value));
		checked
		{
			switch (value)
			{
			case 204:
			{
				ThrowInsufficientBufferUnless(reader.TryRead(out var value3));
				return value3;
			}
			case 208:
			{
				ThrowInsufficientBufferUnless(SequenceReaderExtensions.TryRead(ref reader, out var value2));
				return (uint)value2;
			}
			case 205:
			{
				ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out ushort value4));
				return value4;
			}
			case 209:
			{
				ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out short value9));
				return (uint)value9;
			}
			case 206:
			{
				ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out uint value8));
				return value8;
			}
			case 210:
			{
				ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out int value7));
				return (uint)value7;
			}
			case 207:
			{
				ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out ulong value6));
				return (uint)value6;
			}
			case 211:
			{
				ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out long value5));
				return (uint)value5;
			}
			case 224:
			case 225:
			case 226:
			case 227:
			case 228:
			case 229:
			case 230:
			case 231:
			case 232:
			case 233:
			case 234:
			case 235:
			case 236:
			case 237:
			case 238:
			case 239:
			case 240:
			case 241:
			case 242:
			case 243:
			case 244:
			case 245:
			case 246:
			case 247:
			case 248:
			case 249:
			case 250:
			case 251:
			case 252:
			case 253:
			case 254:
			case byte.MaxValue:
				return (uint)unchecked((sbyte)value);
			default:
				if (value >= 0 && value <= 127)
				{
					return value;
				}
				throw ThrowInvalidCode(value);
			}
		}
	}

	public ulong ReadUInt64()
	{
		ThrowInsufficientBufferUnless(reader.TryRead(out var value));
		checked
		{
			switch (value)
			{
			case 204:
			{
				ThrowInsufficientBufferUnless(reader.TryRead(out var value3));
				return value3;
			}
			case 208:
			{
				ThrowInsufficientBufferUnless(SequenceReaderExtensions.TryRead(ref reader, out var value2));
				return (ulong)value2;
			}
			case 205:
			{
				ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out ushort value4));
				return value4;
			}
			case 209:
			{
				ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out short value9));
				return (ulong)value9;
			}
			case 206:
			{
				ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out uint value8));
				return value8;
			}
			case 210:
			{
				ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out int value7));
				return (ulong)value7;
			}
			case 207:
			{
				ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out ulong value6));
				return value6;
			}
			case 211:
			{
				ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out long value5));
				return (ulong)value5;
			}
			case 224:
			case 225:
			case 226:
			case 227:
			case 228:
			case 229:
			case 230:
			case 231:
			case 232:
			case 233:
			case 234:
			case 235:
			case 236:
			case 237:
			case 238:
			case 239:
			case 240:
			case 241:
			case 242:
			case 243:
			case 244:
			case 245:
			case 246:
			case 247:
			case 248:
			case 249:
			case 250:
			case 251:
			case 252:
			case 253:
			case 254:
			case byte.MaxValue:
				return (ulong)unchecked((sbyte)value);
			default:
				if (value >= 0 && value <= 127)
				{
					return value;
				}
				throw ThrowInvalidCode(value);
			}
		}
	}

	public sbyte ReadSByte()
	{
		ThrowInsufficientBufferUnless(reader.TryRead(out var value));
		checked
		{
			switch (value)
			{
			case 204:
			{
				ThrowInsufficientBufferUnless(reader.TryRead(out var value3));
				return (sbyte)value3;
			}
			case 208:
			{
				ThrowInsufficientBufferUnless(SequenceReaderExtensions.TryRead(ref reader, out var value2));
				return value2;
			}
			case 205:
			{
				ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out ushort value4));
				return (sbyte)value4;
			}
			case 209:
			{
				ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out short value9));
				return (sbyte)value9;
			}
			case 206:
			{
				ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out uint value8));
				return (sbyte)value8;
			}
			case 210:
			{
				ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out int value7));
				return (sbyte)value7;
			}
			case 207:
			{
				ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out ulong value6));
				return (sbyte)value6;
			}
			case 211:
			{
				ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out long value5));
				return (sbyte)value5;
			}
			case 224:
			case 225:
			case 226:
			case 227:
			case 228:
			case 229:
			case 230:
			case 231:
			case 232:
			case 233:
			case 234:
			case 235:
			case 236:
			case 237:
			case 238:
			case 239:
			case 240:
			case 241:
			case 242:
			case 243:
			case 244:
			case 245:
			case 246:
			case 247:
			case 248:
			case 249:
			case 250:
			case 251:
			case 252:
			case 253:
			case 254:
			case byte.MaxValue:
				return unchecked((sbyte)value);
			default:
				if (value >= 0 && value <= 127)
				{
					return unchecked((sbyte)value);
				}
				throw ThrowInvalidCode(value);
			}
		}
	}

	public short ReadInt16()
	{
		ThrowInsufficientBufferUnless(reader.TryRead(out var value));
		checked
		{
			switch (value)
			{
			case 204:
			{
				ThrowInsufficientBufferUnless(reader.TryRead(out var value3));
				return value3;
			}
			case 208:
			{
				ThrowInsufficientBufferUnless(SequenceReaderExtensions.TryRead(ref reader, out var value2));
				return value2;
			}
			case 205:
			{
				ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out ushort value4));
				return (short)value4;
			}
			case 209:
			{
				ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out short value9));
				return value9;
			}
			case 206:
			{
				ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out uint value8));
				return (short)value8;
			}
			case 210:
			{
				ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out int value7));
				return (short)value7;
			}
			case 207:
			{
				ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out ulong value6));
				return (short)value6;
			}
			case 211:
			{
				ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out long value5));
				return (short)value5;
			}
			case 224:
			case 225:
			case 226:
			case 227:
			case 228:
			case 229:
			case 230:
			case 231:
			case 232:
			case 233:
			case 234:
			case 235:
			case 236:
			case 237:
			case 238:
			case 239:
			case 240:
			case 241:
			case 242:
			case 243:
			case 244:
			case 245:
			case 246:
			case 247:
			case 248:
			case 249:
			case 250:
			case 251:
			case 252:
			case 253:
			case 254:
			case byte.MaxValue:
				return unchecked((sbyte)value);
			default:
				if (value >= 0 && value <= 127)
				{
					return value;
				}
				throw ThrowInvalidCode(value);
			}
		}
	}

	public int ReadInt32()
	{
		ThrowInsufficientBufferUnless(reader.TryRead(out var value));
		checked
		{
			switch (value)
			{
			case 204:
			{
				ThrowInsufficientBufferUnless(reader.TryRead(out var value3));
				return value3;
			}
			case 208:
			{
				ThrowInsufficientBufferUnless(SequenceReaderExtensions.TryRead(ref reader, out var value2));
				return value2;
			}
			case 205:
			{
				ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out ushort value4));
				return value4;
			}
			case 209:
			{
				ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out short value9));
				return value9;
			}
			case 206:
			{
				ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out uint value8));
				return (int)value8;
			}
			case 210:
			{
				ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out int value7));
				return value7;
			}
			case 207:
			{
				ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out ulong value6));
				return (int)value6;
			}
			case 211:
			{
				ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out long value5));
				return (int)value5;
			}
			case 224:
			case 225:
			case 226:
			case 227:
			case 228:
			case 229:
			case 230:
			case 231:
			case 232:
			case 233:
			case 234:
			case 235:
			case 236:
			case 237:
			case 238:
			case 239:
			case 240:
			case 241:
			case 242:
			case 243:
			case 244:
			case 245:
			case 246:
			case 247:
			case 248:
			case 249:
			case 250:
			case 251:
			case 252:
			case 253:
			case 254:
			case byte.MaxValue:
				return unchecked((sbyte)value);
			default:
				if (value >= 0 && value <= 127)
				{
					return value;
				}
				throw ThrowInvalidCode(value);
			}
		}
	}

	public long ReadInt64()
	{
		ThrowInsufficientBufferUnless(reader.TryRead(out var value));
		switch (value)
		{
		case 204:
		{
			ThrowInsufficientBufferUnless(reader.TryRead(out var value3));
			return value3;
		}
		case 208:
		{
			ThrowInsufficientBufferUnless(SequenceReaderExtensions.TryRead(ref reader, out var value2));
			return value2;
		}
		case 205:
		{
			ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out ushort value4));
			return value4;
		}
		case 209:
		{
			ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out short value9));
			return value9;
		}
		case 206:
		{
			ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out uint value8));
			return value8;
		}
		case 210:
		{
			ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out int value7));
			return value7;
		}
		case 207:
		{
			ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out ulong value6));
			return checked((long)value6);
		}
		case 211:
		{
			ThrowInsufficientBufferUnless(reader.TryReadBigEndian(out long value5));
			return value5;
		}
		case 224:
		case 225:
		case 226:
		case 227:
		case 228:
		case 229:
		case 230:
		case 231:
		case 232:
		case 233:
		case 234:
		case 235:
		case 236:
		case 237:
		case 238:
		case 239:
		case 240:
		case 241:
		case 242:
		case 243:
		case 244:
		case 245:
		case 246:
		case 247:
		case 248:
		case 249:
		case 250:
		case 251:
		case 252:
		case 253:
		case 254:
		case byte.MaxValue:
			return (sbyte)value;
		default:
			if (value >= 0 && value <= 127)
			{
				return value;
			}
			throw ThrowInvalidCode(value);
		}
	}
}
