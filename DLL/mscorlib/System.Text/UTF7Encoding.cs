using System.Runtime.InteropServices;

namespace System.Text;

[Serializable]
public class UTF7Encoding : Encoding
{
	[Serializable]
	private sealed class Decoder : DecoderNLS
	{
		internal int bits;

		internal int bitCount;

		internal bool firstByte;

		internal override bool HasState => bitCount != -1;

		public Decoder(UTF7Encoding encoding)
			: base(encoding)
		{
		}

		public override void Reset()
		{
			bits = 0;
			bitCount = -1;
			firstByte = false;
			if (_fallbackBuffer != null)
			{
				_fallbackBuffer.Reset();
			}
		}
	}

	[Serializable]
	private sealed class Encoder : EncoderNLS
	{
		internal int bits;

		internal int bitCount;

		internal override bool HasState
		{
			get
			{
				if (bits == 0)
				{
					return bitCount != -1;
				}
				return true;
			}
		}

		public Encoder(UTF7Encoding encoding)
			: base(encoding)
		{
		}

		public override void Reset()
		{
			bitCount = -1;
			bits = 0;
			if (_fallbackBuffer != null)
			{
				_fallbackBuffer.Reset();
			}
		}
	}

	[Serializable]
	private sealed class DecoderUTF7Fallback : DecoderFallback
	{
		public override int MaxCharCount => 1;

		public override DecoderFallbackBuffer CreateFallbackBuffer()
		{
			return new DecoderUTF7FallbackBuffer(this);
		}

		public override bool Equals(object value)
		{
			if (value is DecoderUTF7Fallback)
			{
				return true;
			}
			return false;
		}

		public override int GetHashCode()
		{
			return 984;
		}
	}

	private sealed class DecoderUTF7FallbackBuffer(DecoderUTF7Fallback fallback) : DecoderFallbackBuffer
	{
		private char cFallback;

		private int iCount = -1;

		private int iSize;

		public override int Remaining
		{
			get
			{
				if (iCount <= 0)
				{
					return 0;
				}
				return iCount;
			}
		}

		public override bool Fallback(byte[] bytesUnknown, int index)
		{
			cFallback = (char)bytesUnknown[0];
			if (cFallback == '\0')
			{
				return false;
			}
			iCount = (iSize = 1);
			return true;
		}

		public override char GetNextChar()
		{
			if (iCount-- > 0)
			{
				return cFallback;
			}
			return '\0';
		}

		public unsafe override void Reset()
		{
			iCount = -1;
			byteStart = null;
		}

		internal unsafe override int InternalFallback(byte[] bytes, byte* pBytes)
		{
			if (bytes.Length != 1)
			{
				throw new ArgumentException("String contains invalid Unicode code points.");
			}
			if (bytes[0] != 0)
			{
				return 1;
			}
			return 0;
		}
	}

	internal static readonly UTF7Encoding s_default = new UTF7Encoding();

	private byte[] _base64Bytes;

	private sbyte[] _base64Values;

	private bool[] _directEncode;

	private bool _allowOptionals;

	public UTF7Encoding()
		: this(allowOptionals: false)
	{
	}

	public UTF7Encoding(bool allowOptionals)
		: base(65000)
	{
		_allowOptionals = allowOptionals;
		MakeTables();
	}

	private void MakeTables()
	{
		_base64Bytes = new byte[64];
		for (int i = 0; i < 64; i++)
		{
			_base64Bytes[i] = (byte)"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"[i];
		}
		_base64Values = new sbyte[128];
		for (int j = 0; j < 128; j++)
		{
			_base64Values[j] = -1;
		}
		for (int k = 0; k < 64; k++)
		{
			_base64Values[_base64Bytes[k]] = (sbyte)k;
		}
		_directEncode = new bool[128];
		int length = "\t\n\r '(),-./0123456789:?ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz".Length;
		for (int l = 0; l < length; l++)
		{
			_directEncode[(uint)"\t\n\r '(),-./0123456789:?ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"[l]] = true;
		}
		if (_allowOptionals)
		{
			length = "!\"#$%&*;<=>@[]^_`{|}".Length;
			for (int m = 0; m < length; m++)
			{
				_directEncode[(uint)"!\"#$%&*;<=>@[]^_`{|}"[m]] = true;
			}
		}
	}

	internal override void SetDefaultFallbacks()
	{
		encoderFallback = new EncoderReplacementFallback(string.Empty);
		decoderFallback = new DecoderUTF7Fallback();
	}

	public override bool Equals(object value)
	{
		if (value is UTF7Encoding uTF7Encoding)
		{
			if (_allowOptionals == uTF7Encoding._allowOptionals && base.EncoderFallback.Equals(uTF7Encoding.EncoderFallback))
			{
				return base.DecoderFallback.Equals(uTF7Encoding.DecoderFallback);
			}
			return false;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return CodePage + base.EncoderFallback.GetHashCode() + base.DecoderFallback.GetHashCode();
	}

	public unsafe override int GetByteCount(char[] chars, int index, int count)
	{
		if (chars == null)
		{
			throw new ArgumentNullException("chars", "Array cannot be null.");
		}
		if (index < 0 || count < 0)
		{
			throw new ArgumentOutOfRangeException((index < 0) ? "index" : "count", "Non-negative number required.");
		}
		if (chars.Length - index < count)
		{
			throw new ArgumentOutOfRangeException("chars", "Index and count must refer to a location within the buffer.");
		}
		if (count == 0)
		{
			return 0;
		}
		fixed (char* ptr = chars)
		{
			return GetByteCount(ptr + index, count, null);
		}
	}

	public unsafe override int GetByteCount(string s)
	{
		if (s == null)
		{
			throw new ArgumentNullException("s");
		}
		fixed (char* chars = s)
		{
			return GetByteCount(chars, s.Length, null);
		}
	}

	[CLSCompliant(false)]
	public unsafe override int GetByteCount(char* chars, int count)
	{
		if (chars == null)
		{
			throw new ArgumentNullException("chars", "Array cannot be null.");
		}
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count", "Non-negative number required.");
		}
		return GetByteCount(chars, count, null);
	}

	public unsafe override int GetBytes(string s, int charIndex, int charCount, byte[] bytes, int byteIndex)
	{
		if (s == null || bytes == null)
		{
			throw new ArgumentNullException((s == null) ? "s" : "bytes", "Array cannot be null.");
		}
		if (charIndex < 0 || charCount < 0)
		{
			throw new ArgumentOutOfRangeException((charIndex < 0) ? "charIndex" : "charCount", "Non-negative number required.");
		}
		if (s.Length - charIndex < charCount)
		{
			throw new ArgumentOutOfRangeException("s", "Index and count must refer to a location within the string.");
		}
		if (byteIndex < 0 || byteIndex > bytes.Length)
		{
			throw new ArgumentOutOfRangeException("byteIndex", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		int byteCount = bytes.Length - byteIndex;
		fixed (char* ptr = s)
		{
			fixed (byte* reference = &MemoryMarshal.GetReference((Span<byte>)bytes))
			{
				return GetBytes(ptr + charIndex, charCount, reference + byteIndex, byteCount, null);
			}
		}
	}

	public unsafe override int GetBytes(char[] chars, int charIndex, int charCount, byte[] bytes, int byteIndex)
	{
		if (chars == null || bytes == null)
		{
			throw new ArgumentNullException((chars == null) ? "chars" : "bytes", "Array cannot be null.");
		}
		if (charIndex < 0 || charCount < 0)
		{
			throw new ArgumentOutOfRangeException((charIndex < 0) ? "charIndex" : "charCount", "Non-negative number required.");
		}
		if (chars.Length - charIndex < charCount)
		{
			throw new ArgumentOutOfRangeException("chars", "Index and count must refer to a location within the buffer.");
		}
		if (byteIndex < 0 || byteIndex > bytes.Length)
		{
			throw new ArgumentOutOfRangeException("byteIndex", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		if (charCount == 0)
		{
			return 0;
		}
		int byteCount = bytes.Length - byteIndex;
		fixed (char* ptr = chars)
		{
			fixed (byte* reference = &MemoryMarshal.GetReference((Span<byte>)bytes))
			{
				return GetBytes(ptr + charIndex, charCount, reference + byteIndex, byteCount, null);
			}
		}
	}

	[CLSCompliant(false)]
	public unsafe override int GetBytes(char* chars, int charCount, byte* bytes, int byteCount)
	{
		if (bytes == null || chars == null)
		{
			throw new ArgumentNullException((bytes == null) ? "bytes" : "chars", "Array cannot be null.");
		}
		if (charCount < 0 || byteCount < 0)
		{
			throw new ArgumentOutOfRangeException((charCount < 0) ? "charCount" : "byteCount", "Non-negative number required.");
		}
		return GetBytes(chars, charCount, bytes, byteCount, null);
	}

	public unsafe override int GetCharCount(byte[] bytes, int index, int count)
	{
		if (bytes == null)
		{
			throw new ArgumentNullException("bytes", "Array cannot be null.");
		}
		if (index < 0 || count < 0)
		{
			throw new ArgumentOutOfRangeException((index < 0) ? "index" : "count", "Non-negative number required.");
		}
		if (bytes.Length - index < count)
		{
			throw new ArgumentOutOfRangeException("bytes", "Index and count must refer to a location within the buffer.");
		}
		if (count == 0)
		{
			return 0;
		}
		fixed (byte* ptr = bytes)
		{
			return GetCharCount(ptr + index, count, null);
		}
	}

	[CLSCompliant(false)]
	public unsafe override int GetCharCount(byte* bytes, int count)
	{
		if (bytes == null)
		{
			throw new ArgumentNullException("bytes", "Array cannot be null.");
		}
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count", "Non-negative number required.");
		}
		return GetCharCount(bytes, count, null);
	}

	public unsafe override int GetChars(byte[] bytes, int byteIndex, int byteCount, char[] chars, int charIndex)
	{
		if (bytes == null || chars == null)
		{
			throw new ArgumentNullException((bytes == null) ? "bytes" : "chars", "Array cannot be null.");
		}
		if (byteIndex < 0 || byteCount < 0)
		{
			throw new ArgumentOutOfRangeException((byteIndex < 0) ? "byteIndex" : "byteCount", "Non-negative number required.");
		}
		if (bytes.Length - byteIndex < byteCount)
		{
			throw new ArgumentOutOfRangeException("bytes", "Index and count must refer to a location within the buffer.");
		}
		if (charIndex < 0 || charIndex > chars.Length)
		{
			throw new ArgumentOutOfRangeException("charIndex", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		if (byteCount == 0)
		{
			return 0;
		}
		int charCount = chars.Length - charIndex;
		fixed (byte* ptr = bytes)
		{
			fixed (char* reference = &MemoryMarshal.GetReference((Span<char>)chars))
			{
				return GetChars(ptr + byteIndex, byteCount, reference + charIndex, charCount, null);
			}
		}
	}

	[CLSCompliant(false)]
	public unsafe override int GetChars(byte* bytes, int byteCount, char* chars, int charCount)
	{
		if (bytes == null || chars == null)
		{
			throw new ArgumentNullException((bytes == null) ? "bytes" : "chars", "Array cannot be null.");
		}
		if (charCount < 0 || byteCount < 0)
		{
			throw new ArgumentOutOfRangeException((charCount < 0) ? "charCount" : "byteCount", "Non-negative number required.");
		}
		return GetChars(bytes, byteCount, chars, charCount, null);
	}

	public unsafe override string GetString(byte[] bytes, int index, int count)
	{
		if (bytes == null)
		{
			throw new ArgumentNullException("bytes", "Array cannot be null.");
		}
		if (index < 0 || count < 0)
		{
			throw new ArgumentOutOfRangeException((index < 0) ? "index" : "count", "Non-negative number required.");
		}
		if (bytes.Length - index < count)
		{
			throw new ArgumentOutOfRangeException("bytes", "Index and count must refer to a location within the buffer.");
		}
		if (count == 0)
		{
			return string.Empty;
		}
		fixed (byte* ptr = bytes)
		{
			return string.CreateStringFromEncoding(ptr + index, count, this);
		}
	}

	internal unsafe override int GetByteCount(char* chars, int count, EncoderNLS baseEncoder)
	{
		return GetBytes(chars, count, null, 0, baseEncoder);
	}

	internal unsafe override int GetBytes(char* chars, int charCount, byte* bytes, int byteCount, EncoderNLS baseEncoder)
	{
		Encoder encoder = (Encoder)baseEncoder;
		int num = 0;
		int num2 = -1;
		EncodingByteBuffer encodingByteBuffer = new EncodingByteBuffer(this, encoder, bytes, byteCount, chars, charCount);
		if (encoder != null)
		{
			num = encoder.bits;
			num2 = encoder.bitCount;
			while (num2 >= 6)
			{
				num2 -= 6;
				if (!encodingByteBuffer.AddByte(_base64Bytes[(num >> num2) & 0x3F]))
				{
					ThrowBytesOverflow(encoder, encodingByteBuffer.Count == 0);
				}
			}
		}
		while (encodingByteBuffer.MoreData)
		{
			char nextChar = encodingByteBuffer.GetNextChar();
			if (nextChar < '\u0080' && _directEncode[(uint)nextChar])
			{
				if (num2 >= 0)
				{
					if (num2 > 0)
					{
						if (!encodingByteBuffer.AddByte(_base64Bytes[(num << 6 - num2) & 0x3F]))
						{
							break;
						}
						num2 = 0;
					}
					if (!encodingByteBuffer.AddByte(45))
					{
						break;
					}
					num2 = -1;
				}
				if (!encodingByteBuffer.AddByte((byte)nextChar))
				{
					break;
				}
				continue;
			}
			if (num2 < 0 && nextChar == '+')
			{
				if (!encodingByteBuffer.AddByte((byte)43, (byte)45))
				{
					break;
				}
				continue;
			}
			if (num2 < 0)
			{
				if (!encodingByteBuffer.AddByte(43))
				{
					break;
				}
				num2 = 0;
			}
			num = (num << 16) | nextChar;
			num2 += 16;
			while (num2 >= 6)
			{
				num2 -= 6;
				if (!encodingByteBuffer.AddByte(_base64Bytes[(num >> num2) & 0x3F]))
				{
					num2 += 6;
					nextChar = encodingByteBuffer.GetNextChar();
					break;
				}
			}
			if (num2 >= 6)
			{
				break;
			}
		}
		if (num2 >= 0 && (encoder == null || encoder.MustFlush))
		{
			if (num2 > 0 && encodingByteBuffer.AddByte(_base64Bytes[(num << 6 - num2) & 0x3F]))
			{
				num2 = 0;
			}
			if (encodingByteBuffer.AddByte(45))
			{
				num = 0;
				num2 = -1;
			}
			else
			{
				encodingByteBuffer.GetNextChar();
			}
		}
		if (bytes != null && encoder != null)
		{
			encoder.bits = num;
			encoder.bitCount = num2;
			encoder._charsUsed = encodingByteBuffer.CharsUsed;
		}
		return encodingByteBuffer.Count;
	}

	internal unsafe override int GetCharCount(byte* bytes, int count, DecoderNLS baseDecoder)
	{
		return GetChars(bytes, count, null, 0, baseDecoder);
	}

	internal unsafe override int GetChars(byte* bytes, int byteCount, char* chars, int charCount, DecoderNLS baseDecoder)
	{
		Decoder decoder = (Decoder)baseDecoder;
		EncodingCharBuffer encodingCharBuffer = new EncodingCharBuffer(this, decoder, chars, charCount, bytes, byteCount);
		int num = 0;
		int num2 = -1;
		bool flag = false;
		if (decoder != null)
		{
			num = decoder.bits;
			num2 = decoder.bitCount;
			flag = decoder.firstByte;
		}
		if (num2 >= 16)
		{
			if (!encodingCharBuffer.AddChar((char)((num >> num2 - 16) & 0xFFFF)))
			{
				ThrowCharsOverflow(decoder, nothingDecoded: true);
			}
			num2 -= 16;
		}
		while (encodingCharBuffer.MoreData)
		{
			byte nextByte = encodingCharBuffer.GetNextByte();
			int num3;
			if (num2 >= 0)
			{
				sbyte b;
				if (nextByte < 128 && (b = _base64Values[nextByte]) >= 0)
				{
					flag = false;
					num = (num << 6) | (byte)b;
					num2 += 6;
					if (num2 < 16)
					{
						continue;
					}
					num3 = (num >> num2 - 16) & 0xFFFF;
					num2 -= 16;
				}
				else
				{
					num2 = -1;
					if (nextByte != 45)
					{
						if (!encodingCharBuffer.Fallback(nextByte))
						{
							break;
						}
						continue;
					}
					if (!flag)
					{
						continue;
					}
					num3 = 43;
				}
			}
			else
			{
				if (nextByte == 43)
				{
					num2 = 0;
					flag = true;
					continue;
				}
				if (nextByte >= 128)
				{
					if (!encodingCharBuffer.Fallback(nextByte))
					{
						break;
					}
					continue;
				}
				num3 = nextByte;
			}
			if (num3 >= 0 && !encodingCharBuffer.AddChar((char)num3))
			{
				if (num2 >= 0)
				{
					encodingCharBuffer.AdjustBytes(1);
					num2 += 16;
				}
				break;
			}
		}
		if (chars != null && decoder != null)
		{
			if (decoder.MustFlush)
			{
				decoder.bits = 0;
				decoder.bitCount = -1;
				decoder.firstByte = false;
			}
			else
			{
				decoder.bits = num;
				decoder.bitCount = num2;
				decoder.firstByte = flag;
			}
			decoder._bytesUsed = encodingCharBuffer.BytesUsed;
		}
		return encodingCharBuffer.Count;
	}

	public override System.Text.Decoder GetDecoder()
	{
		return new Decoder(this);
	}

	public override System.Text.Encoder GetEncoder()
	{
		return new Encoder(this);
	}

	public override int GetMaxByteCount(int charCount)
	{
		if (charCount < 0)
		{
			throw new ArgumentOutOfRangeException("charCount", "Non-negative number required.");
		}
		long num = (long)charCount * 3L + 2;
		if (num > int.MaxValue)
		{
			throw new ArgumentOutOfRangeException("charCount", "Too many characters. The resulting number of bytes is larger than what can be returned as an int.");
		}
		return (int)num;
	}

	public override int GetMaxCharCount(int byteCount)
	{
		if (byteCount < 0)
		{
			throw new ArgumentOutOfRangeException("byteCount", "Non-negative number required.");
		}
		int num = byteCount;
		if (num == 0)
		{
			num = 1;
		}
		return num;
	}
}
