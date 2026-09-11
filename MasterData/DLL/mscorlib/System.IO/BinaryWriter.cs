using System.Runtime.InteropServices;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;
using Mono.Security;

namespace System.IO;

[Serializable]
[ComVisible(true)]
public class BinaryWriter : IDisposable, IAsyncDisposable
{
	public static readonly BinaryWriter Null = new BinaryWriter();

	protected Stream OutStream;

	private byte[] _buffer;

	private Encoding _encoding;

	private Encoder _encoder;

	[OptionalField]
	private bool _leaveOpen;

	[OptionalField]
	private char[] _tmpOneCharBuffer;

	private byte[] _largeByteBuffer;

	private int _maxChars;

	private const int LargeByteBufferSize = 256;

	public virtual Stream BaseStream
	{
		get
		{
			Flush();
			return OutStream;
		}
	}

	protected BinaryWriter()
	{
		OutStream = Stream.Null;
		_buffer = new byte[16];
		_encoding = new UTF8Encoding(encoderShouldEmitUTF8Identifier: false, throwOnInvalidBytes: true);
		_encoder = _encoding.GetEncoder();
	}

	public BinaryWriter(Stream output)
		: this(output, new UTF8Encoding(encoderShouldEmitUTF8Identifier: false, throwOnInvalidBytes: true), leaveOpen: false)
	{
	}

	public BinaryWriter(Stream output, Encoding encoding)
		: this(output, encoding, leaveOpen: false)
	{
	}

	public BinaryWriter(Stream output, Encoding encoding, bool leaveOpen)
	{
		if (output == null)
		{
			throw new ArgumentNullException("output");
		}
		if (encoding == null)
		{
			throw new ArgumentNullException("encoding");
		}
		if (!output.CanWrite)
		{
			throw new ArgumentException(Environment.GetResourceString("Stream was not writable."));
		}
		OutStream = output;
		_buffer = new byte[16];
		_encoding = encoding;
		_encoder = _encoding.GetEncoder();
		_leaveOpen = leaveOpen;
	}

	public virtual void Close()
	{
		Dispose(disposing: true);
	}

	protected virtual void Dispose(bool disposing)
	{
		if (disposing)
		{
			if (_leaveOpen)
			{
				OutStream.Flush();
			}
			else
			{
				OutStream.Close();
			}
		}
	}

	public void Dispose()
	{
		Dispose(disposing: true);
	}

	public virtual void Flush()
	{
		OutStream.Flush();
	}

	public virtual long Seek(int offset, SeekOrigin origin)
	{
		return OutStream.Seek(offset, origin);
	}

	public virtual void Write(ReadOnlySpan<byte> buffer)
	{
		Write(buffer.ToArray());
	}

	public virtual void Write(ReadOnlySpan<char> buffer)
	{
		Write(buffer.ToArray());
	}

	public virtual ValueTask DisposeAsync()
	{
		try
		{
			if (GetType() == typeof(BinaryWriter))
			{
				if (_leaveOpen)
				{
					return new ValueTask(OutStream.FlushAsync());
				}
				OutStream.Close();
			}
			else
			{
				Dispose();
			}
			return default(ValueTask);
		}
		catch (Exception exception)
		{
			return new ValueTask(Task.FromException(exception));
		}
	}

	public virtual void Write(bool value)
	{
		_buffer[0] = (byte)(value ? 1u : 0u);
		OutStream.Write(_buffer, 0, 1);
	}

	public virtual void Write(byte value)
	{
		OutStream.WriteByte(value);
	}

	[CLSCompliant(false)]
	public virtual void Write(sbyte value)
	{
		OutStream.WriteByte((byte)value);
	}

	public virtual void Write(byte[] buffer)
	{
		if (buffer == null)
		{
			throw new ArgumentNullException("buffer");
		}
		OutStream.Write(buffer, 0, buffer.Length);
	}

	public virtual void Write(byte[] buffer, int index, int count)
	{
		OutStream.Write(buffer, index, count);
	}

	public unsafe virtual void Write(char ch)
	{
		if (char.IsSurrogate(ch))
		{
			throw new ArgumentException(Environment.GetResourceString("Unicode surrogate characters must be written out as pairs together in the same call, not individually. Consider passing in a character array instead."));
		}
		int num = 0;
		fixed (byte* buffer = _buffer)
		{
			num = _encoder.GetBytes(&ch, 1, buffer, _buffer.Length, flush: true);
		}
		OutStream.Write(_buffer, 0, num);
	}

	public virtual void Write(char[] chars)
	{
		if (chars == null)
		{
			throw new ArgumentNullException("chars");
		}
		byte[] bytes = _encoding.GetBytes(chars, 0, chars.Length);
		OutStream.Write(bytes, 0, bytes.Length);
	}

	public virtual void Write(char[] chars, int index, int count)
	{
		byte[] bytes = _encoding.GetBytes(chars, index, count);
		OutStream.Write(bytes, 0, bytes.Length);
	}

	public virtual void Write(double value)
	{
		OutStream.Write(BitConverterLE.GetBytes(value), 0, 8);
	}

	public virtual void Write(decimal value)
	{
		decimal.GetBytes(in value, _buffer);
		OutStream.Write(_buffer, 0, 16);
	}

	public virtual void Write(short value)
	{
		_buffer[0] = (byte)value;
		_buffer[1] = (byte)(value >> 8);
		OutStream.Write(_buffer, 0, 2);
	}

	[CLSCompliant(false)]
	public virtual void Write(ushort value)
	{
		_buffer[0] = (byte)value;
		_buffer[1] = (byte)(value >> 8);
		OutStream.Write(_buffer, 0, 2);
	}

	public virtual void Write(int value)
	{
		_buffer[0] = (byte)value;
		_buffer[1] = (byte)(value >> 8);
		_buffer[2] = (byte)(value >> 16);
		_buffer[3] = (byte)(value >> 24);
		OutStream.Write(_buffer, 0, 4);
	}

	[CLSCompliant(false)]
	public virtual void Write(uint value)
	{
		_buffer[0] = (byte)value;
		_buffer[1] = (byte)(value >> 8);
		_buffer[2] = (byte)(value >> 16);
		_buffer[3] = (byte)(value >> 24);
		OutStream.Write(_buffer, 0, 4);
	}

	public virtual void Write(long value)
	{
		_buffer[0] = (byte)value;
		_buffer[1] = (byte)(value >> 8);
		_buffer[2] = (byte)(value >> 16);
		_buffer[3] = (byte)(value >> 24);
		_buffer[4] = (byte)(value >> 32);
		_buffer[5] = (byte)(value >> 40);
		_buffer[6] = (byte)(value >> 48);
		_buffer[7] = (byte)(value >> 56);
		OutStream.Write(_buffer, 0, 8);
	}

	[CLSCompliant(false)]
	public virtual void Write(ulong value)
	{
		_buffer[0] = (byte)value;
		_buffer[1] = (byte)(value >> 8);
		_buffer[2] = (byte)(value >> 16);
		_buffer[3] = (byte)(value >> 24);
		_buffer[4] = (byte)(value >> 32);
		_buffer[5] = (byte)(value >> 40);
		_buffer[6] = (byte)(value >> 48);
		_buffer[7] = (byte)(value >> 56);
		OutStream.Write(_buffer, 0, 8);
	}

	public virtual void Write(float value)
	{
		OutStream.Write(BitConverterLE.GetBytes(value), 0, 4);
	}

	public unsafe virtual void Write(string value)
	{
		if (value == null)
		{
			throw new ArgumentNullException("value");
		}
		int byteCount = _encoding.GetByteCount(value);
		Write7BitEncodedInt(byteCount);
		if (_largeByteBuffer == null)
		{
			_largeByteBuffer = new byte[256];
			_maxChars = _largeByteBuffer.Length / _encoding.GetMaxByteCount(1);
		}
		if (byteCount <= _largeByteBuffer.Length)
		{
			_encoding.GetBytes(value, 0, value.Length, _largeByteBuffer, 0);
			OutStream.Write(_largeByteBuffer, 0, byteCount);
			return;
		}
		int num = 0;
		int num2 = value.Length;
		while (num2 > 0)
		{
			int num3 = ((num2 > _maxChars) ? _maxChars : num2);
			if (num < 0 || num3 < 0 || checked(num + num3) > value.Length)
			{
				throw new ArgumentOutOfRangeException("charCount");
			}
			int bytes;
			fixed (char* ptr = value)
			{
				fixed (byte* largeByteBuffer = _largeByteBuffer)
				{
					bytes = _encoder.GetBytes((char*)checked(unchecked((nuint)ptr) + unchecked((nuint)checked(unchecked((nint)num) * (nint)2))), num3, largeByteBuffer, _largeByteBuffer.Length, num3 == num2);
				}
			}
			OutStream.Write(_largeByteBuffer, 0, bytes);
			num += num3;
			num2 -= num3;
		}
	}

	protected void Write7BitEncodedInt(int value)
	{
		uint num;
		for (num = (uint)value; num >= 128; num >>= 7)
		{
			Write((byte)(num | 0x80));
		}
		Write((byte)num);
	}
}
