using System.Runtime.InteropServices;

namespace System.Text;

[Serializable]
public class UnicodeEncoding : Encoding
{
	[Serializable]
	private sealed class Decoder(UnicodeEncoding encoding) : DecoderNLS(encoding)
	{
		internal int lastByte = -1;

		internal char lastChar;

		internal override bool HasState
		{
			get
			{
				if (lastByte == -1)
				{
					return lastChar != '\0';
				}
				return true;
			}
		}

		public override void Reset()
		{
			lastByte = -1;
			lastChar = '\0';
			if (_fallbackBuffer != null)
			{
				_fallbackBuffer.Reset();
			}
		}
	}

	internal static readonly UnicodeEncoding s_bigEndianDefault = new UnicodeEncoding(bigEndian: true, byteOrderMark: true);

	internal static readonly UnicodeEncoding s_littleEndianDefault = new UnicodeEncoding(bigEndian: false, byteOrderMark: true);

	private static readonly byte[] s_bigEndianPreamble = new byte[2] { 254, 255 };

	private static readonly byte[] s_littleEndianPreamble = new byte[2] { 255, 254 };

	internal bool isThrowException;

	internal bool bigEndian;

	internal bool byteOrderMark = true;

	private static readonly ulong highLowPatternMask = (ulong)(-2882066263381583872L | (BitConverter.IsLittleEndian ? 288230376218820608L : 4398046512128L));

	public override ReadOnlySpan<byte> Preamble => (GetType() != typeof(UnicodeEncoding)) ? GetPreamble() : ((!byteOrderMark) ? Array.Empty<byte>() : (bigEndian ? s_bigEndianPreamble : s_littleEndianPreamble));

	public UnicodeEncoding()
		: this(bigEndian: false, byteOrderMark: true)
	{
	}

	public UnicodeEncoding(bool bigEndian, bool byteOrderMark)
		: this(bigEndian, byteOrderMark, throwOnInvalidBytes: false)
	{
	}

	public UnicodeEncoding(bool bigEndian, bool byteOrderMark, bool throwOnInvalidBytes)
		: base(bigEndian ? 1201 : 1200)
	{
		isThrowException = throwOnInvalidBytes;
		this.bigEndian = bigEndian;
		this.byteOrderMark = byteOrderMark;
		if (isThrowException)
		{
			SetDefaultFallbacks();
		}
	}

	internal override void SetDefaultFallbacks()
	{
		if (isThrowException)
		{
			encoderFallback = EncoderFallback.ExceptionFallback;
			decoderFallback = DecoderFallback.ExceptionFallback;
		}
		else
		{
			encoderFallback = new EncoderReplacementFallback("\ufffd");
			decoderFallback = new DecoderReplacementFallback("\ufffd");
		}
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

	internal unsafe override int GetByteCount(char* chars, int count, EncoderNLS encoder)
	{
		int num = count << 1;
		if (num < 0)
		{
			throw new ArgumentOutOfRangeException("count", "Too many characters. The resulting number of bytes is larger than what can be returned as an int.");
		}
		char* charStart = chars;
		char* ptr = chars + count;
		char c = '\0';
		bool flag = false;
		ulong* ptr2 = (ulong*)(ptr - 3);
		EncoderFallbackBuffer encoderFallbackBuffer = null;
		if (encoder != null)
		{
			c = encoder._charLeftOver;
			if (c > '\0')
			{
				num += 2;
			}
			if (encoder.InternalHasFallbackBuffer)
			{
				encoderFallbackBuffer = encoder.FallbackBuffer;
				if (encoderFallbackBuffer.Remaining > 0)
				{
					throw new ArgumentException(SR.Format("Must complete Convert() operation or call Encoder.Reset() before calling GetBytes() or GetByteCount(). Encoder '{0}' fallback '{1}'.", EncodingName, encoder.Fallback.GetType()));
				}
				encoderFallbackBuffer.InternalInitialize(charStart, ptr, encoder, setEncoder: false);
			}
		}
		while (true)
		{
			char num2 = encoderFallbackBuffer?.InternalGetNextChar() ?? '\0';
			char c2 = num2;
			char* chars2;
			if (num2 != 0 || chars < ptr)
			{
				if (c2 == '\0')
				{
					if ((bigEndian ^ BitConverter.IsLittleEndian) && c == '\0' && ((ulong)chars & 7uL) == 0L)
					{
						ulong* ptr3;
						for (ptr3 = (ulong*)chars; ptr3 < ptr2; ptr3++)
						{
							if ((0x8000800080008000uL & *ptr3) != 0L)
							{
								ulong num3 = (0xF800F800F800F800uL & *ptr3) ^ 0xD800D800D800D800uL;
								if (((num3 & 0xFFFF000000000000uL) == 0L || (num3 & 0xFFFF00000000L) == 0L || (num3 & 0xFFFF0000u) == 0L || (num3 & 0xFFFF) == 0L) && ((0xFC00FC00FC00FC00uL & *ptr3) ^ highLowPatternMask) != 0L)
								{
									break;
								}
							}
						}
						chars = (char*)ptr3;
						if (chars >= ptr)
						{
							goto IL_027e;
						}
					}
					c2 = *chars;
					chars++;
				}
				else
				{
					num += 2;
				}
				if (c2 >= '\ud800' && c2 <= '\udfff')
				{
					if (c2 <= '\udbff')
					{
						if (c > '\0')
						{
							chars--;
							num -= 2;
							if (encoderFallbackBuffer == null)
							{
								encoderFallbackBuffer = ((encoder != null) ? encoder.FallbackBuffer : encoderFallback.CreateFallbackBuffer());
								encoderFallbackBuffer.InternalInitialize(charStart, ptr, encoder, setEncoder: false);
							}
							chars2 = chars;
							encoderFallbackBuffer.InternalFallback(c, ref chars2);
							chars = chars2;
							c = '\0';
						}
						else
						{
							c = c2;
						}
					}
					else if (c == '\0')
					{
						num -= 2;
						if (encoderFallbackBuffer == null)
						{
							encoderFallbackBuffer = ((encoder != null) ? encoder.FallbackBuffer : encoderFallback.CreateFallbackBuffer());
							encoderFallbackBuffer.InternalInitialize(charStart, ptr, encoder, setEncoder: false);
						}
						chars2 = chars;
						encoderFallbackBuffer.InternalFallback(c2, ref chars2);
						chars = chars2;
					}
					else
					{
						c = '\0';
					}
				}
				else if (c > '\0')
				{
					chars--;
					if (encoderFallbackBuffer == null)
					{
						encoderFallbackBuffer = ((encoder != null) ? encoder.FallbackBuffer : encoderFallback.CreateFallbackBuffer());
						encoderFallbackBuffer.InternalInitialize(charStart, ptr, encoder, setEncoder: false);
					}
					chars2 = chars;
					encoderFallbackBuffer.InternalFallback(c, ref chars2);
					chars = chars2;
					num -= 2;
					c = '\0';
				}
				continue;
			}
			goto IL_027e;
			IL_027e:
			if (c <= '\0')
			{
				break;
			}
			num -= 2;
			if (encoder != null && !encoder.MustFlush)
			{
				break;
			}
			if (flag)
			{
				throw new ArgumentException(SR.Format("Recursive fallback not allowed for character \\\\u{0:X4}.", c), "chars");
			}
			if (encoderFallbackBuffer == null)
			{
				encoderFallbackBuffer = ((encoder != null) ? encoder.FallbackBuffer : encoderFallback.CreateFallbackBuffer());
				encoderFallbackBuffer.InternalInitialize(charStart, ptr, encoder, setEncoder: false);
			}
			chars2 = chars;
			encoderFallbackBuffer.InternalFallback(c, ref chars2);
			chars = chars2;
			c = '\0';
			flag = true;
		}
		return num;
	}

	internal unsafe override int GetBytes(char* chars, int charCount, byte* bytes, int byteCount, EncoderNLS encoder)
	{
		char c = '\0';
		bool flag = false;
		byte* ptr = bytes + byteCount;
		char* ptr2 = chars + charCount;
		byte* ptr3 = bytes;
		char* ptr4 = chars;
		EncoderFallbackBuffer encoderFallbackBuffer = null;
		if (encoder != null)
		{
			c = encoder._charLeftOver;
			if (encoder.InternalHasFallbackBuffer)
			{
				encoderFallbackBuffer = encoder.FallbackBuffer;
				if (encoderFallbackBuffer.Remaining > 0 && encoder._throwOnOverflow)
				{
					throw new ArgumentException(SR.Format("Must complete Convert() operation or call Encoder.Reset() before calling GetBytes() or GetByteCount(). Encoder '{0}' fallback '{1}'.", EncodingName, encoder.Fallback.GetType()));
				}
				encoderFallbackBuffer.InternalInitialize(ptr4, ptr2, encoder, setEncoder: false);
			}
		}
		while (true)
		{
			char num = encoderFallbackBuffer?.InternalGetNextChar() ?? '\0';
			char c2 = num;
			char* chars2;
			if (num != 0 || chars < ptr2)
			{
				if (c2 == '\0')
				{
					if ((bigEndian ^ BitConverter.IsLittleEndian) && ((ulong)chars & 7uL) == 0L && ((ulong)bytes & 7uL) == 0L && c == '\0')
					{
						ulong* ptr5 = (ulong*)(chars - 3 + ((ptr - bytes >> 1 < ptr2 - chars) ? (ptr - bytes >> 1) : (ptr2 - chars)));
						ulong* ptr6 = (ulong*)chars;
						ulong* ptr7 = (ulong*)bytes;
						while (ptr6 < ptr5)
						{
							if ((0x8000800080008000uL & *ptr6) != 0L)
							{
								ulong num2 = (0xF800F800F800F800uL & *ptr6) ^ 0xD800D800D800D800uL;
								if (((num2 & 0xFFFF000000000000uL) == 0L || (num2 & 0xFFFF00000000L) == 0L || (num2 & 0xFFFF0000u) == 0L || (num2 & 0xFFFF) == 0L) && ((0xFC00FC00FC00FC00uL & *ptr6) ^ highLowPatternMask) != 0L)
								{
									break;
								}
							}
							*ptr7 = *ptr6;
							ptr6++;
							ptr7++;
						}
						chars = (char*)ptr6;
						bytes = (byte*)ptr7;
						if (chars >= ptr2)
						{
							goto IL_0488;
						}
					}
					else if (c == '\0' && (bigEndian ^ BitConverter.IsLittleEndian) && ((ulong)chars & 7uL) != ((ulong)bytes & 7uL) && ((int)bytes & 1) == 0)
					{
						long num3 = ((ptr - bytes >> 1 < ptr2 - chars) ? (ptr - bytes >> 1) : (ptr2 - chars));
						char* ptr8 = (char*)bytes;
						char* ptr9 = chars + num3 - 1;
						while (chars < ptr9)
						{
							if (*chars >= '\ud800' && *chars <= '\udfff')
							{
								if (*chars >= '\udc00' || chars[1] < '\udc00' || chars[1] > '\udfff')
								{
									break;
								}
							}
							else if (chars[1] >= '\ud800' && chars[1] <= '\udfff')
							{
								*ptr8 = *chars;
								ptr8++;
								chars++;
								continue;
							}
							*ptr8 = *chars;
							ptr8[1] = chars[1];
							ptr8 += 2;
							chars += 2;
						}
						bytes = (byte*)ptr8;
						if (chars >= ptr2)
						{
							goto IL_0488;
						}
					}
					c2 = *chars;
					chars++;
				}
				if (c2 >= '\ud800' && c2 <= '\udfff')
				{
					if (c2 <= '\udbff')
					{
						if (c > '\0')
						{
							chars--;
							if (encoderFallbackBuffer == null)
							{
								encoderFallbackBuffer = ((encoder != null) ? encoder.FallbackBuffer : encoderFallback.CreateFallbackBuffer());
								encoderFallbackBuffer.InternalInitialize(ptr4, ptr2, encoder, setEncoder: true);
							}
							chars2 = chars;
							encoderFallbackBuffer.InternalFallback(c, ref chars2);
							chars = chars2;
							c = '\0';
						}
						else
						{
							c = c2;
						}
						continue;
					}
					if (c == '\0')
					{
						if (encoderFallbackBuffer == null)
						{
							encoderFallbackBuffer = ((encoder != null) ? encoder.FallbackBuffer : encoderFallback.CreateFallbackBuffer());
							encoderFallbackBuffer.InternalInitialize(ptr4, ptr2, encoder, setEncoder: true);
						}
						chars2 = chars;
						encoderFallbackBuffer.InternalFallback(c2, ref chars2);
						chars = chars2;
						continue;
					}
					if (bytes + 3 >= ptr)
					{
						if (encoderFallbackBuffer != null && encoderFallbackBuffer.bFallingBack)
						{
							encoderFallbackBuffer.MovePrevious();
							encoderFallbackBuffer.MovePrevious();
						}
						else
						{
							chars -= 2;
						}
						ThrowBytesOverflow(encoder, bytes == ptr3);
						c = '\0';
						goto IL_0488;
					}
					if (bigEndian)
					{
						*(bytes++) = (byte)((int)c >> 8);
						*(bytes++) = (byte)c;
					}
					else
					{
						*(bytes++) = (byte)c;
						*(bytes++) = (byte)((int)c >> 8);
					}
					c = '\0';
				}
				else if (c > '\0')
				{
					chars--;
					if (encoderFallbackBuffer == null)
					{
						encoderFallbackBuffer = ((encoder != null) ? encoder.FallbackBuffer : encoderFallback.CreateFallbackBuffer());
						encoderFallbackBuffer.InternalInitialize(ptr4, ptr2, encoder, setEncoder: true);
					}
					chars2 = chars;
					encoderFallbackBuffer.InternalFallback(c, ref chars2);
					chars = chars2;
					c = '\0';
					continue;
				}
				if (bytes + 1 < ptr)
				{
					if (bigEndian)
					{
						*(bytes++) = (byte)((int)c2 >> 8);
						*(bytes++) = (byte)c2;
					}
					else
					{
						*(bytes++) = (byte)c2;
						*(bytes++) = (byte)((int)c2 >> 8);
					}
					continue;
				}
				if (encoderFallbackBuffer != null && encoderFallbackBuffer.bFallingBack)
				{
					encoderFallbackBuffer.MovePrevious();
				}
				else
				{
					chars--;
				}
				ThrowBytesOverflow(encoder, bytes == ptr3);
			}
			goto IL_0488;
			IL_0488:
			if (c <= '\0' || (encoder != null && !encoder.MustFlush))
			{
				break;
			}
			if (flag)
			{
				throw new ArgumentException(SR.Format("Recursive fallback not allowed for character \\\\u{0:X4}.", c), "chars");
			}
			if (encoderFallbackBuffer == null)
			{
				encoderFallbackBuffer = ((encoder != null) ? encoder.FallbackBuffer : encoderFallback.CreateFallbackBuffer());
				encoderFallbackBuffer.InternalInitialize(ptr4, ptr2, encoder, setEncoder: true);
			}
			chars2 = chars;
			encoderFallbackBuffer.InternalFallback(c, ref chars2);
			chars = chars2;
			c = '\0';
			flag = true;
		}
		if (encoder != null)
		{
			encoder._charLeftOver = c;
			encoder._charsUsed = (int)(chars - ptr4);
		}
		return (int)(bytes - ptr3);
	}

	internal unsafe override int GetCharCount(byte* bytes, int count, DecoderNLS baseDecoder)
	{
		Decoder decoder = (Decoder)baseDecoder;
		byte* ptr = bytes + count;
		byte* byteStart = bytes;
		int num = -1;
		char c = '\0';
		int num2 = count >> 1;
		ulong* ptr2 = (ulong*)(ptr - 7);
		DecoderFallbackBuffer decoderFallbackBuffer = null;
		if (decoder != null)
		{
			num = decoder.lastByte;
			c = decoder.lastChar;
			if (c > '\0')
			{
				num2++;
			}
			if (num >= 0 && (count & 1) == 1)
			{
				num2++;
			}
		}
		while (bytes < ptr)
		{
			if ((bigEndian ^ BitConverter.IsLittleEndian) && ((ulong)bytes & 7uL) == 0L && num == -1 && c == '\0')
			{
				ulong* ptr3;
				for (ptr3 = (ulong*)bytes; ptr3 < ptr2; ptr3++)
				{
					if ((0x8000800080008000uL & *ptr3) != 0L)
					{
						ulong num3 = (0xF800F800F800F800uL & *ptr3) ^ 0xD800D800D800D800uL;
						if (((num3 & 0xFFFF000000000000uL) == 0L || (num3 & 0xFFFF00000000L) == 0L || (num3 & 0xFFFF0000u) == 0L || (num3 & 0xFFFF) == 0L) && ((0xFC00FC00FC00FC00uL & *ptr3) ^ highLowPatternMask) != 0L)
						{
							break;
						}
					}
				}
				bytes = (byte*)ptr3;
				if (bytes >= ptr)
				{
					break;
				}
			}
			if (num < 0)
			{
				num = *(bytes++);
				if (bytes >= ptr)
				{
					break;
				}
			}
			char c2 = ((!bigEndian) ? ((char)((*(bytes++) << 8) | num)) : ((char)((num << 8) | *(bytes++))));
			num = -1;
			if (c2 >= '\ud800' && c2 <= '\udfff')
			{
				if (c2 <= '\udbff')
				{
					if (c > '\0')
					{
						num2--;
						byte[] array = null;
						array = ((!bigEndian) ? new byte[2]
						{
							(byte)c,
							(byte)((int)c >> 8)
						} : new byte[2]
						{
							(byte)((int)c >> 8),
							(byte)c
						});
						if (decoderFallbackBuffer == null)
						{
							decoderFallbackBuffer = ((decoder != null) ? decoder.FallbackBuffer : decoderFallback.CreateFallbackBuffer());
							decoderFallbackBuffer.InternalInitialize(byteStart, null);
						}
						num2 += decoderFallbackBuffer.InternalFallback(array, bytes);
					}
					c = c2;
				}
				else if (c == '\0')
				{
					num2--;
					byte[] array2 = null;
					array2 = ((!bigEndian) ? new byte[2]
					{
						(byte)c2,
						(byte)((int)c2 >> 8)
					} : new byte[2]
					{
						(byte)((int)c2 >> 8),
						(byte)c2
					});
					if (decoderFallbackBuffer == null)
					{
						decoderFallbackBuffer = ((decoder != null) ? decoder.FallbackBuffer : decoderFallback.CreateFallbackBuffer());
						decoderFallbackBuffer.InternalInitialize(byteStart, null);
					}
					num2 += decoderFallbackBuffer.InternalFallback(array2, bytes);
				}
				else
				{
					c = '\0';
				}
			}
			else if (c > '\0')
			{
				num2--;
				byte[] array3 = null;
				array3 = ((!bigEndian) ? new byte[2]
				{
					(byte)c,
					(byte)((int)c >> 8)
				} : new byte[2]
				{
					(byte)((int)c >> 8),
					(byte)c
				});
				if (decoderFallbackBuffer == null)
				{
					decoderFallbackBuffer = ((decoder != null) ? decoder.FallbackBuffer : decoderFallback.CreateFallbackBuffer());
					decoderFallbackBuffer.InternalInitialize(byteStart, null);
				}
				num2 += decoderFallbackBuffer.InternalFallback(array3, bytes);
				c = '\0';
			}
		}
		if (decoder == null || decoder.MustFlush)
		{
			if (c > '\0')
			{
				num2--;
				byte[] array4 = null;
				array4 = ((!bigEndian) ? new byte[2]
				{
					(byte)c,
					(byte)((int)c >> 8)
				} : new byte[2]
				{
					(byte)((int)c >> 8),
					(byte)c
				});
				if (decoderFallbackBuffer == null)
				{
					decoderFallbackBuffer = ((decoder != null) ? decoder.FallbackBuffer : decoderFallback.CreateFallbackBuffer());
					decoderFallbackBuffer.InternalInitialize(byteStart, null);
				}
				num2 += decoderFallbackBuffer.InternalFallback(array4, bytes);
				c = '\0';
			}
			if (num >= 0)
			{
				if (decoderFallbackBuffer == null)
				{
					decoderFallbackBuffer = ((decoder != null) ? decoder.FallbackBuffer : decoderFallback.CreateFallbackBuffer());
					decoderFallbackBuffer.InternalInitialize(byteStart, null);
				}
				num2 += decoderFallbackBuffer.InternalFallback(new byte[1] { (byte)num }, bytes);
				num = -1;
			}
		}
		if (c > '\0')
		{
			num2--;
		}
		return num2;
	}

	internal unsafe override int GetChars(byte* bytes, int byteCount, char* chars, int charCount, DecoderNLS baseDecoder)
	{
		Decoder decoder = (Decoder)baseDecoder;
		int num = -1;
		char c = '\0';
		if (decoder != null)
		{
			num = decoder.lastByte;
			c = decoder.lastChar;
		}
		DecoderFallbackBuffer decoderFallbackBuffer = null;
		byte* ptr = bytes + byteCount;
		char* ptr2 = chars + charCount;
		byte* ptr3 = bytes;
		char* ptr4 = chars;
		while (bytes < ptr)
		{
			if ((bigEndian ^ BitConverter.IsLittleEndian) && ((ulong)chars & 7uL) == 0L && ((ulong)bytes & 7uL) == 0L && num == -1 && c == '\0')
			{
				ulong* ptr5 = (ulong*)(bytes - 7 + ((ptr - bytes >> 1 < ptr2 - chars) ? (ptr - bytes) : (ptr2 - chars << 1)));
				ulong* ptr6 = (ulong*)bytes;
				ulong* ptr7 = (ulong*)chars;
				while (ptr6 < ptr5)
				{
					if ((0x8000800080008000uL & *ptr6) != 0L)
					{
						ulong num2 = (0xF800F800F800F800uL & *ptr6) ^ 0xD800D800D800D800uL;
						if (((num2 & 0xFFFF000000000000uL) == 0L || (num2 & 0xFFFF00000000L) == 0L || (num2 & 0xFFFF0000u) == 0L || (num2 & 0xFFFF) == 0L) && ((0xFC00FC00FC00FC00uL & *ptr6) ^ highLowPatternMask) != 0L)
						{
							break;
						}
					}
					*ptr7 = *ptr6;
					ptr6++;
					ptr7++;
				}
				chars = (char*)ptr7;
				bytes = (byte*)ptr6;
				if (bytes >= ptr)
				{
					break;
				}
			}
			if (num < 0)
			{
				num = *(bytes++);
				continue;
			}
			char c2 = ((!bigEndian) ? ((char)((*(bytes++) << 8) | num)) : ((char)((num << 8) | *(bytes++))));
			num = -1;
			if (c2 >= '\ud800' && c2 <= '\udfff')
			{
				if (c2 <= '\udbff')
				{
					if (c > '\0')
					{
						byte[] array = null;
						array = ((!bigEndian) ? new byte[2]
						{
							(byte)c,
							(byte)((int)c >> 8)
						} : new byte[2]
						{
							(byte)((int)c >> 8),
							(byte)c
						});
						if (decoderFallbackBuffer == null)
						{
							decoderFallbackBuffer = ((decoder != null) ? decoder.FallbackBuffer : decoderFallback.CreateFallbackBuffer());
							decoderFallbackBuffer.InternalInitialize(ptr3, ptr2);
						}
						char* chars2 = chars;
						bool num3 = decoderFallbackBuffer.InternalFallback(array, bytes, ref chars2);
						chars = chars2;
						if (!num3)
						{
							bytes -= 2;
							decoderFallbackBuffer.InternalReset();
							ThrowCharsOverflow(decoder, chars == ptr4);
							break;
						}
					}
					c = c2;
					continue;
				}
				if (c == '\0')
				{
					byte[] array2 = null;
					array2 = ((!bigEndian) ? new byte[2]
					{
						(byte)c2,
						(byte)((int)c2 >> 8)
					} : new byte[2]
					{
						(byte)((int)c2 >> 8),
						(byte)c2
					});
					if (decoderFallbackBuffer == null)
					{
						decoderFallbackBuffer = ((decoder != null) ? decoder.FallbackBuffer : decoderFallback.CreateFallbackBuffer());
						decoderFallbackBuffer.InternalInitialize(ptr3, ptr2);
					}
					char* chars2 = chars;
					bool num4 = decoderFallbackBuffer.InternalFallback(array2, bytes, ref chars2);
					chars = chars2;
					if (!num4)
					{
						bytes -= 2;
						decoderFallbackBuffer.InternalReset();
						ThrowCharsOverflow(decoder, chars == ptr4);
						break;
					}
					continue;
				}
				if (chars >= ptr2 - 1)
				{
					bytes -= 2;
					ThrowCharsOverflow(decoder, chars == ptr4);
					break;
				}
				*(chars++) = c;
				c = '\0';
			}
			else if (c > '\0')
			{
				byte[] array3 = null;
				array3 = ((!bigEndian) ? new byte[2]
				{
					(byte)c,
					(byte)((int)c >> 8)
				} : new byte[2]
				{
					(byte)((int)c >> 8),
					(byte)c
				});
				if (decoderFallbackBuffer == null)
				{
					decoderFallbackBuffer = ((decoder != null) ? decoder.FallbackBuffer : decoderFallback.CreateFallbackBuffer());
					decoderFallbackBuffer.InternalInitialize(ptr3, ptr2);
				}
				char* chars2 = chars;
				bool num5 = decoderFallbackBuffer.InternalFallback(array3, bytes, ref chars2);
				chars = chars2;
				if (!num5)
				{
					bytes -= 2;
					decoderFallbackBuffer.InternalReset();
					ThrowCharsOverflow(decoder, chars == ptr4);
					break;
				}
				c = '\0';
			}
			if (chars >= ptr2)
			{
				bytes -= 2;
				ThrowCharsOverflow(decoder, chars == ptr4);
				break;
			}
			*(chars++) = c2;
		}
		if (decoder == null || decoder.MustFlush)
		{
			if (c > '\0')
			{
				byte[] array4 = null;
				array4 = ((!bigEndian) ? new byte[2]
				{
					(byte)c,
					(byte)((int)c >> 8)
				} : new byte[2]
				{
					(byte)((int)c >> 8),
					(byte)c
				});
				if (decoderFallbackBuffer == null)
				{
					decoderFallbackBuffer = ((decoder != null) ? decoder.FallbackBuffer : decoderFallback.CreateFallbackBuffer());
					decoderFallbackBuffer.InternalInitialize(ptr3, ptr2);
				}
				char* chars2 = chars;
				bool num6 = decoderFallbackBuffer.InternalFallback(array4, bytes, ref chars2);
				chars = chars2;
				if (!num6)
				{
					bytes -= 2;
					if (num >= 0)
					{
						bytes--;
					}
					decoderFallbackBuffer.InternalReset();
					ThrowCharsOverflow(decoder, chars == ptr4);
					bytes += 2;
					if (num >= 0)
					{
						bytes++;
					}
					goto IL_04c7;
				}
				c = '\0';
			}
			if (num >= 0)
			{
				if (decoderFallbackBuffer == null)
				{
					decoderFallbackBuffer = ((decoder != null) ? decoder.FallbackBuffer : decoderFallback.CreateFallbackBuffer());
					decoderFallbackBuffer.InternalInitialize(ptr3, ptr2);
				}
				char* chars2 = chars;
				bool num7 = decoderFallbackBuffer.InternalFallback(new byte[1] { (byte)num }, bytes, ref chars2);
				chars = chars2;
				if (!num7)
				{
					bytes--;
					decoderFallbackBuffer.InternalReset();
					ThrowCharsOverflow(decoder, chars == ptr4);
					bytes++;
				}
				else
				{
					num = -1;
				}
			}
		}
		goto IL_04c7;
		IL_04c7:
		if (decoder != null)
		{
			decoder._bytesUsed = (int)(bytes - ptr3);
			decoder.lastChar = c;
			decoder.lastByte = num;
		}
		return (int)(chars - ptr4);
	}

	public override Encoder GetEncoder()
	{
		return new EncoderNLS(this);
	}

	public override System.Text.Decoder GetDecoder()
	{
		return new Decoder(this);
	}

	public override byte[] GetPreamble()
	{
		if (byteOrderMark)
		{
			if (!bigEndian)
			{
				return new byte[2] { 255, 254 };
			}
			return new byte[2] { 254, 255 };
		}
		return Array.Empty<byte>();
	}

	public override int GetMaxByteCount(int charCount)
	{
		if (charCount < 0)
		{
			throw new ArgumentOutOfRangeException("charCount", "Non-negative number required.");
		}
		long num = (long)charCount + 1L;
		if (base.EncoderFallback.MaxCharCount > 1)
		{
			num *= base.EncoderFallback.MaxCharCount;
		}
		num <<= 1;
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
		long num = (long)(byteCount >> 1) + (long)(byteCount & 1) + 1;
		if (base.DecoderFallback.MaxCharCount > 1)
		{
			num *= base.DecoderFallback.MaxCharCount;
		}
		if (num > int.MaxValue)
		{
			throw new ArgumentOutOfRangeException("byteCount", "Too many bytes. The resulting number of chars is larger than what can be returned as an int.");
		}
		return (int)num;
	}

	public override bool Equals(object value)
	{
		if (value is UnicodeEncoding unicodeEncoding)
		{
			if (CodePage == unicodeEncoding.CodePage && byteOrderMark == unicodeEncoding.byteOrderMark && bigEndian == unicodeEncoding.bigEndian && base.EncoderFallback.Equals(unicodeEncoding.EncoderFallback))
			{
				return base.DecoderFallback.Equals(unicodeEncoding.DecoderFallback);
			}
			return false;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return CodePage + base.EncoderFallback.GetHashCode() + base.DecoderFallback.GetHashCode() + (byteOrderMark ? 4 : 0) + (bigEndian ? 8 : 0);
	}
}
