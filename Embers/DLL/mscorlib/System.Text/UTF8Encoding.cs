using System.Runtime.InteropServices;

namespace System.Text;

[Serializable]
public class UTF8Encoding : Encoding
{
	internal sealed class UTF8EncodingSealed : UTF8Encoding
	{
		public override ReadOnlySpan<byte> Preamble => _emitUTF8Identifier ? s_preamble : Array.Empty<byte>();

		public UTF8EncodingSealed(bool encoderShouldEmitUTF8Identifier)
			: base(encoderShouldEmitUTF8Identifier)
		{
		}
	}

	[Serializable]
	private sealed class UTF8Encoder : EncoderNLS
	{
		internal int surrogateChar;

		internal override bool HasState => surrogateChar != 0;

		public UTF8Encoder(UTF8Encoding encoding)
			: base(encoding)
		{
		}

		public override void Reset()
		{
			surrogateChar = 0;
			if (_fallbackBuffer != null)
			{
				_fallbackBuffer.Reset();
			}
		}
	}

	[Serializable]
	private sealed class UTF8Decoder : DecoderNLS
	{
		internal int bits;

		internal override bool HasState => bits != 0;

		public UTF8Decoder(UTF8Encoding encoding)
			: base(encoding)
		{
		}

		public override void Reset()
		{
			bits = 0;
			if (_fallbackBuffer != null)
			{
				_fallbackBuffer.Reset();
			}
		}
	}

	private const int UTF8_CODEPAGE = 65001;

	internal static readonly UTF8EncodingSealed s_default = new UTF8EncodingSealed(encoderShouldEmitUTF8Identifier: true);

	internal static readonly byte[] s_preamble = new byte[3] { 239, 187, 191 };

	internal readonly bool _emitUTF8Identifier;

	private bool _isThrowException;

	private const int FinalByte = 536870912;

	private const int SupplimentarySeq = 268435456;

	private const int ThreeByteSeq = 134217728;

	public override ReadOnlySpan<byte> Preamble => (GetType() != typeof(UTF8Encoding)) ? GetPreamble() : (_emitUTF8Identifier ? s_preamble : Array.Empty<byte>());

	public UTF8Encoding()
		: this(encoderShouldEmitUTF8Identifier: false)
	{
	}

	public UTF8Encoding(bool encoderShouldEmitUTF8Identifier)
		: this(encoderShouldEmitUTF8Identifier, throwOnInvalidBytes: false)
	{
	}

	public UTF8Encoding(bool encoderShouldEmitUTF8Identifier, bool throwOnInvalidBytes)
		: base(65001)
	{
		_emitUTF8Identifier = encoderShouldEmitUTF8Identifier;
		_isThrowException = throwOnInvalidBytes;
		if (_isThrowException)
		{
			SetDefaultFallbacks();
		}
	}

	internal override void SetDefaultFallbacks()
	{
		if (_isThrowException)
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

	public unsafe override int GetByteCount(string chars)
	{
		if (chars == null)
		{
			throw new ArgumentNullException("s");
		}
		fixed (char* chars2 = chars)
		{
			return GetByteCount(chars2, chars.Length, null);
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
		EncoderFallbackBuffer encoderFallbackBuffer = null;
		char* ptr = chars;
		char* ptr2 = ptr + count;
		int num = count;
		int num2 = 0;
		if (baseEncoder != null)
		{
			UTF8Encoder uTF8Encoder = (UTF8Encoder)baseEncoder;
			num2 = uTF8Encoder.surrogateChar;
			if (uTF8Encoder.InternalHasFallbackBuffer)
			{
				encoderFallbackBuffer = uTF8Encoder.FallbackBuffer;
				if (encoderFallbackBuffer.Remaining > 0)
				{
					throw new ArgumentException(SR.Format("Must complete Convert() operation or call Encoder.Reset() before calling GetBytes() or GetByteCount(). Encoder '{0}' fallback '{1}'.", EncodingName, uTF8Encoder.Fallback.GetType()));
				}
				encoderFallbackBuffer.InternalInitialize(chars, ptr2, uTF8Encoder, setEncoder: false);
			}
		}
		while (true)
		{
			if (ptr >= ptr2)
			{
				if (num2 == 0)
				{
					num2 = encoderFallbackBuffer?.InternalGetNextChar() ?? '\0';
					if (num2 <= 0)
					{
						goto IL_00e3;
					}
					num++;
				}
				else
				{
					if (encoderFallbackBuffer == null || !encoderFallbackBuffer.bFallingBack)
					{
						goto IL_00e3;
					}
					num2 = encoderFallbackBuffer.InternalGetNextChar();
					num++;
					if (InRange(num2, 56320, 57343))
					{
						num2 = 65533;
						num++;
						goto IL_016a;
					}
					if (num2 <= 0)
					{
						num--;
						break;
					}
				}
			}
			else
			{
				if (num2 > 0)
				{
					char ch = *ptr;
					num++;
					if (InRange(ch, 56320, 57343))
					{
						num2 = 65533;
						ptr++;
					}
					goto IL_016a;
				}
				if (encoderFallbackBuffer != null)
				{
					num2 = encoderFallbackBuffer.InternalGetNextChar();
					if (num2 > 0)
					{
						num++;
						goto IL_014c;
					}
				}
				num2 = *ptr;
				ptr++;
			}
			goto IL_014c;
			IL_014c:
			if (InRange(num2, 55296, 56319))
			{
				num--;
				continue;
			}
			goto IL_016a;
			IL_016a:
			if (InRange(num2, 55296, 57343))
			{
				if (encoderFallbackBuffer == null)
				{
					encoderFallbackBuffer = ((baseEncoder != null) ? baseEncoder.FallbackBuffer : encoderFallback.CreateFallbackBuffer());
					encoderFallbackBuffer.InternalInitialize(chars, chars + count, baseEncoder, setEncoder: false);
				}
				char* chars2 = ptr;
				encoderFallbackBuffer.InternalFallback((char)num2, ref chars2);
				ptr = chars2;
				num--;
				num2 = 0;
				continue;
			}
			if (num2 > 127)
			{
				if (num2 > 2047)
				{
					num++;
				}
				num++;
			}
			if (num < 0)
			{
				break;
			}
			if (encoderFallbackBuffer != null && (num2 = encoderFallbackBuffer.InternalGetNextChar()) != 0)
			{
				num++;
				goto IL_014c;
			}
			int num3 = PtrDiff(ptr2, ptr);
			if (num3 <= 13)
			{
				char* ptr3 = ptr2;
				while (ptr < ptr3)
				{
					num2 = *ptr;
					ptr++;
					if (num2 <= 127)
					{
						continue;
					}
					goto IL_014c;
				}
				break;
			}
			num3 &= 0xFFFFFFF;
			char* ptr4 = ptr + num3 - 7;
			while (ptr < ptr4)
			{
				num2 = *ptr;
				ptr++;
				if (num2 > 127)
				{
					if (num2 > 2047)
					{
						if ((num2 & 0xF800) == 55296)
						{
							goto IL_03d0;
						}
						num++;
					}
					num++;
				}
				if (((int)ptr & 2) != 0)
				{
					num2 = *ptr;
					ptr++;
					if (num2 > 127)
					{
						if (num2 > 2047)
						{
							if ((num2 & 0xF800) == 55296)
							{
								goto IL_03d0;
							}
							num++;
						}
						num++;
					}
				}
				for (; ptr < ptr4; ptr += 4)
				{
					num2 = *(int*)ptr;
					int num4 = *(int*)(ptr + 2);
					if (((num2 | num4) & -8323200) != 0)
					{
						if (((num2 | num4) & -134154240) != 0)
						{
							goto IL_03b1;
						}
						if ((num2 & -8388608) != 0)
						{
							num++;
						}
						if ((num2 & 0xFF80) != 0)
						{
							num++;
						}
						if ((num4 & -8388608) != 0)
						{
							num++;
						}
						if ((num4 & 0xFF80) != 0)
						{
							num++;
						}
					}
					ptr += 4;
					num2 = *(int*)ptr;
					num4 = *(int*)(ptr + 2);
					if (((num2 | num4) & -8323200) == 0)
					{
						continue;
					}
					if (((num2 | num4) & -134154240) == 0)
					{
						if ((num2 & -8388608) != 0)
						{
							num++;
						}
						if ((num2 & 0xFF80) != 0)
						{
							num++;
						}
						if ((num4 & -8388608) != 0)
						{
							num++;
						}
						if ((num4 & 0xFF80) != 0)
						{
							num++;
						}
						continue;
					}
					goto IL_03b1;
				}
				break;
				IL_03d0:
				if (num2 > 2047)
				{
					if (InRange(num2, 55296, 57343))
					{
						int ch2 = *ptr;
						if (num2 > 56319 || !InRange(ch2, 56320, 57343))
						{
							ptr--;
							break;
						}
						ptr++;
					}
					num++;
				}
				num++;
				continue;
				IL_03b1:
				num2 = ((!BitConverter.IsLittleEndian) ? (num2 >>> 16) : ((ushort)num2));
				ptr++;
				if (num2 <= 127)
				{
					continue;
				}
				goto IL_03d0;
			}
			num2 = 0;
			continue;
			IL_00e3:
			if (num2 <= 0 || (baseEncoder != null && !baseEncoder.MustFlush))
			{
				break;
			}
			num++;
			goto IL_016a;
		}
		if (num < 0)
		{
			throw new ArgumentException("Conversion buffer overflow.");
		}
		return num;
	}

	private unsafe static int PtrDiff(char* a, char* b)
	{
		return (int)((uint)((byte*)a - (byte*)b) >> 1);
	}

	private unsafe static int PtrDiff(byte* a, byte* b)
	{
		return (int)(a - b);
	}

	private static bool InRange(int ch, int start, int end)
	{
		return (uint)(ch - start) <= (uint)(end - start);
	}

	internal unsafe override int GetBytes(char* chars, int charCount, byte* bytes, int byteCount, EncoderNLS baseEncoder)
	{
		UTF8Encoder uTF8Encoder = null;
		EncoderFallbackBuffer encoderFallbackBuffer = null;
		char* ptr = chars;
		byte* ptr2 = bytes;
		char* ptr3 = ptr + charCount;
		byte* ptr4 = ptr2 + byteCount;
		int num = 0;
		if (baseEncoder != null)
		{
			uTF8Encoder = (UTF8Encoder)baseEncoder;
			num = uTF8Encoder.surrogateChar;
			if (uTF8Encoder.InternalHasFallbackBuffer)
			{
				encoderFallbackBuffer = uTF8Encoder.FallbackBuffer;
				if (encoderFallbackBuffer.Remaining > 0 && uTF8Encoder._throwOnOverflow)
				{
					throw new ArgumentException(SR.Format("Must complete Convert() operation or call Encoder.Reset() before calling GetBytes() or GetByteCount(). Encoder '{0}' fallback '{1}'.", EncodingName, uTF8Encoder.Fallback.GetType()));
				}
				encoderFallbackBuffer.InternalInitialize(chars, ptr3, uTF8Encoder, setEncoder: true);
			}
		}
		while (true)
		{
			if (ptr >= ptr3)
			{
				if (num == 0)
				{
					num = encoderFallbackBuffer?.InternalGetNextChar() ?? '\0';
					if (num <= 0)
					{
						goto IL_00e5;
					}
				}
				else
				{
					if (encoderFallbackBuffer == null || !encoderFallbackBuffer.bFallingBack)
					{
						goto IL_00e5;
					}
					int num2 = num;
					num = encoderFallbackBuffer.InternalGetNextChar();
					if (InRange(num, 56320, 57343))
					{
						num = num + (num2 << 10) + -56613888;
						goto IL_015d;
					}
					if (num <= 0)
					{
						break;
					}
				}
			}
			else
			{
				if (num > 0)
				{
					int num3 = *ptr;
					if (InRange(num3, 56320, 57343))
					{
						num = num3 + (num << 10) + -56613888;
						ptr++;
					}
					goto IL_015d;
				}
				if (encoderFallbackBuffer != null)
				{
					num = encoderFallbackBuffer.InternalGetNextChar();
					if (num > 0)
					{
						goto IL_0147;
					}
				}
				num = *ptr;
				ptr++;
			}
			goto IL_0147;
			IL_015d:
			if (InRange(num, 55296, 57343))
			{
				if (encoderFallbackBuffer == null)
				{
					encoderFallbackBuffer = ((baseEncoder != null) ? baseEncoder.FallbackBuffer : encoderFallback.CreateFallbackBuffer());
					encoderFallbackBuffer.InternalInitialize(chars, ptr3, baseEncoder, setEncoder: true);
				}
				char* chars2 = ptr;
				encoderFallbackBuffer.InternalFallback((char)num, ref chars2);
				ptr = chars2;
				num = 0;
				continue;
			}
			int num4 = 1;
			if (num > 127)
			{
				if (num > 2047)
				{
					if (num > 65535)
					{
						num4++;
					}
					num4++;
				}
				num4++;
			}
			if (ptr2 > ptr4 - num4)
			{
				if (encoderFallbackBuffer != null && encoderFallbackBuffer.bFallingBack)
				{
					encoderFallbackBuffer.MovePrevious();
					if (num > 65535)
					{
						encoderFallbackBuffer.MovePrevious();
					}
				}
				else
				{
					ptr--;
					if (num > 65535)
					{
						ptr--;
					}
				}
				ThrowBytesOverflow(uTF8Encoder, ptr2 == bytes);
				num = 0;
				break;
			}
			if (num <= 127)
			{
				*ptr2 = (byte)num;
			}
			else
			{
				int num5;
				if (num <= 2047)
				{
					num5 = (byte)(-64 | (num >> 6));
				}
				else
				{
					if (num <= 65535)
					{
						num5 = (byte)(-32 | (num >> 12));
					}
					else
					{
						*ptr2 = (byte)(-16 | (num >> 18));
						ptr2++;
						num5 = -128 | ((num >> 12) & 0x3F);
					}
					*ptr2 = (byte)num5;
					ptr2++;
					num5 = -128 | ((num >> 6) & 0x3F);
				}
				*ptr2 = (byte)num5;
				ptr2++;
				*ptr2 = (byte)(-128 | (num & 0x3F));
			}
			ptr2++;
			if (encoderFallbackBuffer == null || (num = encoderFallbackBuffer.InternalGetNextChar()) == 0)
			{
				int num6 = PtrDiff(ptr3, ptr);
				int num7 = PtrDiff(ptr4, ptr2);
				if (num6 <= 13)
				{
					if (num7 < num6)
					{
						num = 0;
						continue;
					}
					char* ptr5 = ptr3;
					while (ptr < ptr5)
					{
						num = *ptr;
						ptr++;
						if (num <= 127)
						{
							*ptr2 = (byte)num;
							ptr2++;
							continue;
						}
						goto IL_0147;
					}
					num = 0;
					break;
				}
				if (num7 < num6)
				{
					num6 = num7;
				}
				char* ptr6 = ptr + num6 - 5;
				while (ptr < ptr6)
				{
					num = *ptr;
					ptr++;
					if (num <= 127)
					{
						*ptr2 = (byte)num;
						ptr2++;
						if (((int)ptr & 2) != 0)
						{
							num = *ptr;
							ptr++;
							if (num > 127)
							{
								goto IL_044f;
							}
							*ptr2 = (byte)num;
							ptr2++;
						}
						while (ptr < ptr6)
						{
							num = *(int*)ptr;
							int num8 = *(int*)(ptr + 2);
							if (((num | num8) & -8323200) == 0)
							{
								if (BitConverter.IsLittleEndian)
								{
									*ptr2 = (byte)num;
									ptr2[1] = (byte)(num >> 16);
									ptr += 4;
									ptr2[2] = (byte)num8;
									ptr2[3] = (byte)(num8 >> 16);
									ptr2 += 4;
								}
								else
								{
									*ptr2 = (byte)(num >> 16);
									ptr2[1] = (byte)num;
									ptr += 4;
									ptr2[2] = (byte)(num8 >> 16);
									ptr2[3] = (byte)num8;
									ptr2 += 4;
								}
								continue;
							}
							goto IL_041f;
						}
						continue;
					}
					goto IL_044f;
					IL_041f:
					num = ((!BitConverter.IsLittleEndian) ? (num >>> 16) : ((ushort)num));
					ptr++;
					if (num <= 127)
					{
						*ptr2 = (byte)num;
						ptr2++;
						continue;
					}
					goto IL_044f;
					IL_044f:
					int num9;
					if (num <= 2047)
					{
						num9 = -64 | (num >> 6);
					}
					else
					{
						if (!InRange(num, 55296, 57343))
						{
							num9 = -32 | (num >> 12);
						}
						else
						{
							if (num > 56319)
							{
								ptr--;
								break;
							}
							num9 = *ptr;
							ptr++;
							if (!InRange(num9, 56320, 57343))
							{
								ptr -= 2;
								break;
							}
							num = num9 + (num << 10) + -56613888;
							*ptr2 = (byte)(-16 | (num >> 18));
							ptr2++;
							num9 = -128 | ((num >> 12) & 0x3F);
						}
						*ptr2 = (byte)num9;
						ptr6--;
						ptr2++;
						num9 = -128 | ((num >> 6) & 0x3F);
					}
					*ptr2 = (byte)num9;
					ptr6--;
					ptr2++;
					*ptr2 = (byte)(-128 | (num & 0x3F));
					ptr2++;
				}
				num = 0;
				continue;
			}
			goto IL_0147;
			IL_00e5:
			if (num <= 0 || (uTF8Encoder != null && !uTF8Encoder.MustFlush))
			{
				break;
			}
			goto IL_015d;
			IL_0147:
			if (InRange(num, 55296, 56319))
			{
				continue;
			}
			goto IL_015d;
		}
		if (uTF8Encoder != null)
		{
			uTF8Encoder.surrogateChar = num;
			uTF8Encoder._charsUsed = (int)(ptr - chars);
		}
		return (int)(ptr2 - bytes);
	}

	internal unsafe override int GetCharCount(byte* bytes, int count, DecoderNLS baseDecoder)
	{
		byte* ptr = bytes;
		byte* ptr2 = ptr + count;
		int num = count;
		int num2 = 0;
		DecoderFallbackBuffer decoderFallbackBuffer = null;
		if (baseDecoder != null)
		{
			num2 = ((UTF8Decoder)baseDecoder).bits;
			num -= num2 >> 30;
		}
		while (ptr < ptr2)
		{
			if (num2 != 0)
			{
				int num3 = *ptr;
				ptr++;
				if ((num3 & -64) != 128)
				{
					ptr--;
					num += num2 >> 30;
				}
				else
				{
					num2 = (num2 << 6) | (num3 & 0x3F);
					if ((num2 & 0x20000000) != 0)
					{
						if ((num2 & 0x101F0000) == 268435456)
						{
							num--;
						}
						goto IL_017c;
					}
					if ((num2 & 0x10000000) != 0)
					{
						if ((num2 & 0x800000) != 0 || InRange(num2 & 0x1F0, 16, 256))
						{
							continue;
						}
					}
					else if ((num2 & 0x3E0) != 0 && (num2 & 0x3E0) != 864)
					{
						continue;
					}
				}
				goto IL_00c3;
			}
			num2 = *ptr;
			ptr++;
			goto IL_0106;
			IL_017c:
			int num4 = PtrDiff(ptr2, ptr);
			if (num4 <= 13)
			{
				byte* ptr3 = ptr2;
				while (ptr < ptr3)
				{
					num2 = *ptr;
					ptr++;
					if (num2 <= 127)
					{
						continue;
					}
					goto IL_0106;
				}
				num2 = 0;
				break;
			}
			byte* ptr4 = ptr + num4 - 7;
			while (true)
			{
				if (ptr < ptr4)
				{
					num2 = *ptr;
					ptr++;
					if (num2 > 127)
					{
						goto IL_026f;
					}
					if (((int)ptr & 1) != 0)
					{
						num2 = *ptr;
						ptr++;
						if (num2 > 127)
						{
							goto IL_026f;
						}
					}
					if (((int)ptr & 2) != 0)
					{
						num2 = *(ushort*)ptr;
						if ((num2 & 0x8080) != 0)
						{
							goto IL_024e;
						}
						ptr += 2;
					}
					while (ptr < ptr4)
					{
						num2 = *(int*)ptr;
						int num5 = ((int*)ptr)[1];
						if (((num2 | num5) & -2139062144) == 0)
						{
							ptr += 8;
							if (ptr >= ptr4)
							{
								break;
							}
							num2 = *(int*)ptr;
							num5 = ((int*)ptr)[1];
							if (((num2 | num5) & -2139062144) == 0)
							{
								ptr += 8;
								continue;
							}
						}
						goto IL_0238;
					}
				}
				num2 = 0;
				break;
				IL_024e:
				num2 = ((!BitConverter.IsLittleEndian) ? (num2 >>> 8) : (num2 & 0xFF));
				ptr++;
				if (num2 <= 127)
				{
					continue;
				}
				goto IL_026f;
				IL_026f:
				int num6 = *ptr;
				ptr++;
				if ((num2 & 0x40) != 0 && (num6 & -64) == 128)
				{
					num6 &= 0x3F;
					if ((num2 & 0x20) != 0)
					{
						num6 |= (num2 & 0xF) << 6;
						if ((num2 & 0x10) != 0)
						{
							num2 = *ptr;
							if (InRange(num6 >> 4, 1, 16) && (num2 & -64) == 128)
							{
								num6 = (num6 << 6) | (num2 & 0x3F);
								num2 = ptr[1];
								if ((num2 & -64) == 128)
								{
									ptr += 2;
									num--;
									goto IL_0328;
								}
							}
						}
						else
						{
							num2 = *ptr;
							if ((num6 & 0x3E0) != 0 && (num6 & 0x3E0) != 864 && (num2 & -64) == 128)
							{
								ptr++;
								num--;
								goto IL_0328;
							}
						}
					}
					else if ((num2 & 0x1E) != 0)
					{
						goto IL_0328;
					}
				}
				ptr -= 2;
				num2 = 0;
				break;
				IL_0238:
				num2 = ((!BitConverter.IsLittleEndian) ? (num2 >>> 16) : (num2 & 0xFF));
				goto IL_024e;
				IL_0328:
				num--;
			}
			continue;
			IL_00c3:
			if (decoderFallbackBuffer == null)
			{
				decoderFallbackBuffer = ((baseDecoder != null) ? baseDecoder.FallbackBuffer : decoderFallback.CreateFallbackBuffer());
				decoderFallbackBuffer.InternalInitialize(bytes, null);
			}
			num += FallbackInvalidByteSequence(ptr, num2, decoderFallbackBuffer);
			num2 = 0;
			continue;
			IL_0106:
			if (num2 > 127)
			{
				num--;
				if ((num2 & 0x40) != 0)
				{
					if ((num2 & 0x20) != 0)
					{
						if ((num2 & 0x10) == 0)
						{
							num2 = (num2 & 0xF) | 0x48228000;
							num--;
							continue;
						}
						num2 &= 0xF;
						if (num2 <= 4)
						{
							num2 |= 0x504D0C00;
							num--;
							continue;
						}
						num2 |= 0xF0;
					}
					else
					{
						num2 &= 0x1F;
						if (num2 > 1)
						{
							num2 |= 0x800000;
							continue;
						}
						num2 |= 0xC0;
					}
				}
				goto IL_00c3;
			}
			goto IL_017c;
		}
		if (num2 != 0)
		{
			num += num2 >> 30;
			if (baseDecoder == null || baseDecoder.MustFlush)
			{
				if (decoderFallbackBuffer == null)
				{
					decoderFallbackBuffer = ((baseDecoder != null) ? baseDecoder.FallbackBuffer : decoderFallback.CreateFallbackBuffer());
					decoderFallbackBuffer.InternalInitialize(bytes, null);
				}
				num += FallbackInvalidByteSequence(ptr, num2, decoderFallbackBuffer);
			}
		}
		return num;
	}

	internal unsafe override int GetChars(byte* bytes, int byteCount, char* chars, int charCount, DecoderNLS baseDecoder)
	{
		byte* ptr = bytes;
		char* ptr2 = chars;
		byte* ptr3 = ptr + byteCount;
		char* ptr4 = ptr2 + charCount;
		int num = 0;
		DecoderFallbackBuffer decoderFallbackBuffer = null;
		if (baseDecoder != null)
		{
			num = ((UTF8Decoder)baseDecoder).bits;
		}
		while (ptr < ptr3)
		{
			if (num != 0)
			{
				int num2 = *ptr;
				ptr++;
				if ((num2 & -64) != 128)
				{
					ptr--;
				}
				else
				{
					num = (num << 6) | (num2 & 0x3F);
					if ((num & 0x20000000) != 0)
					{
						if ((num & 0x101F0000) > 268435456 && ptr2 < ptr4)
						{
							*ptr2 = (char)(((num >> 10) & 0x7FF) + -10304);
							ptr2++;
							num = (num & 0x3FF) + 56320;
						}
						goto IL_01ea;
					}
					if ((num & 0x10000000) != 0)
					{
						if ((num & 0x800000) != 0 || InRange(num & 0x1F0, 16, 256))
						{
							continue;
						}
					}
					else if ((num & 0x3E0) != 0 && (num & 0x3E0) != 864)
					{
						continue;
					}
				}
				goto IL_00f9;
			}
			num = *ptr;
			ptr++;
			goto IL_0169;
			IL_01ea:
			if (ptr2 >= ptr4)
			{
				num &= 0x1FFFFF;
				if (num > 127)
				{
					if (num > 2047)
					{
						if (num >= 56320 && num <= 57343)
						{
							ptr--;
							ptr2--;
						}
						else if (num > 65535)
						{
							ptr--;
						}
						ptr--;
					}
					ptr--;
				}
				ptr--;
				ThrowCharsOverflow(baseDecoder, ptr2 == chars);
				num = 0;
				break;
			}
			*ptr2 = (char)num;
			ptr2++;
			int num3 = PtrDiff(ptr4, ptr2);
			int num4 = PtrDiff(ptr3, ptr);
			if (num4 <= 13)
			{
				if (num3 < num4)
				{
					num = 0;
					continue;
				}
				byte* ptr5 = ptr3;
				while (ptr < ptr5)
				{
					num = *ptr;
					ptr++;
					if (num <= 127)
					{
						*ptr2 = (char)num;
						ptr2++;
						continue;
					}
					goto IL_0169;
				}
				num = 0;
				break;
			}
			if (num3 < num4)
			{
				num4 = num3;
			}
			char* ptr6 = ptr2 + num4 - 7;
			while (true)
			{
				if (ptr2 < ptr6)
				{
					num = *ptr;
					ptr++;
					if (num > 127)
					{
						goto IL_04dc;
					}
					*ptr2 = (char)num;
					ptr2++;
					if (((int)ptr & 1) != 0)
					{
						num = *ptr;
						ptr++;
						if (num > 127)
						{
							goto IL_04dc;
						}
						*ptr2 = (char)num;
						ptr2++;
					}
					if (((int)ptr & 2) != 0)
					{
						num = *(ushort*)ptr;
						if ((num & 0x8080) != 0)
						{
							goto IL_04ab;
						}
						if (BitConverter.IsLittleEndian)
						{
							*ptr2 = (char)(num & 0x7F);
							ptr += 2;
							ptr2[1] = (char)((num >> 8) & 0x7F);
							ptr2 += 2;
						}
						else
						{
							*ptr2 = (char)((num >> 8) & 0x7F);
							ptr += 2;
							ptr2[1] = (char)(num & 0x7F);
							ptr2 += 2;
						}
					}
					while (ptr2 < ptr6)
					{
						num = *(int*)ptr;
						int num5 = ((int*)ptr)[1];
						if (((num | num5) & -2139062144) == 0)
						{
							if (BitConverter.IsLittleEndian)
							{
								*ptr2 = (char)(num & 0x7F);
								ptr2[1] = (char)((num >> 8) & 0x7F);
								ptr2[2] = (char)((num >> 16) & 0x7F);
								ptr2[3] = (char)((num >> 24) & 0x7F);
								ptr += 8;
								ptr2[4] = (char)(num5 & 0x7F);
								ptr2[5] = (char)((num5 >> 8) & 0x7F);
								ptr2[6] = (char)((num5 >> 16) & 0x7F);
								ptr2[7] = (char)((num5 >> 24) & 0x7F);
								ptr2 += 8;
							}
							else
							{
								*ptr2 = (char)((num >> 24) & 0x7F);
								ptr2[1] = (char)((num >> 16) & 0x7F);
								ptr2[2] = (char)((num >> 8) & 0x7F);
								ptr2[3] = (char)(num & 0x7F);
								ptr += 8;
								ptr2[4] = (char)((num5 >> 24) & 0x7F);
								ptr2[5] = (char)((num5 >> 16) & 0x7F);
								ptr2[6] = (char)((num5 >> 8) & 0x7F);
								ptr2[7] = (char)(num5 & 0x7F);
								ptr2 += 8;
							}
							continue;
						}
						goto IL_0491;
					}
				}
				num = 0;
				break;
				IL_0491:
				num = ((!BitConverter.IsLittleEndian) ? (num >>> 16) : (num & 0xFF));
				goto IL_04ab;
				IL_05ff:
				*ptr2 = (char)num;
				ptr2++;
				ptr6--;
				continue;
				IL_04ab:
				num = ((!BitConverter.IsLittleEndian) ? (num >>> 8) : (num & 0xFF));
				ptr++;
				if (num <= 127)
				{
					*ptr2 = (char)num;
					ptr2++;
					continue;
				}
				goto IL_04dc;
				IL_04dc:
				int num6 = *ptr;
				ptr++;
				if ((num & 0x40) != 0 && (num6 & -64) == 128)
				{
					num6 &= 0x3F;
					if ((num & 0x20) != 0)
					{
						num6 |= (num & 0xF) << 6;
						if ((num & 0x10) != 0)
						{
							num = *ptr;
							if (InRange(num6 >> 4, 1, 16) && (num & -64) == 128)
							{
								num6 = (num6 << 6) | (num & 0x3F);
								num = ptr[1];
								if ((num & -64) == 128)
								{
									ptr += 2;
									num = (num6 << 6) | (num & 0x3F);
									*ptr2 = (char)(((num >> 10) & 0x7FF) + -10304);
									ptr2++;
									num = (num & 0x3FF) + -9216;
									ptr6--;
									goto IL_05ff;
								}
							}
						}
						else
						{
							num = *ptr;
							if ((num6 & 0x3E0) != 0 && (num6 & 0x3E0) != 864 && (num & -64) == 128)
							{
								ptr++;
								num = (num6 << 6) | (num & 0x3F);
								ptr6--;
								goto IL_05ff;
							}
						}
					}
					else
					{
						num &= 0x1F;
						if (num > 1)
						{
							num = (num << 6) | num6;
							goto IL_05ff;
						}
					}
				}
				ptr -= 2;
				num = 0;
				break;
			}
			continue;
			IL_0169:
			if (num > 127)
			{
				if ((num & 0x40) != 0)
				{
					if ((num & 0x20) != 0)
					{
						if ((num & 0x10) == 0)
						{
							num = (num & 0xF) | 0x48228000;
							continue;
						}
						num &= 0xF;
						if (num <= 4)
						{
							num |= 0x504D0C00;
							continue;
						}
						num |= 0xF0;
					}
					else
					{
						num &= 0x1F;
						if (num > 1)
						{
							num |= 0x800000;
							continue;
						}
						num |= 0xC0;
					}
				}
				goto IL_00f9;
			}
			goto IL_01ea;
			IL_00f9:
			if (decoderFallbackBuffer == null)
			{
				decoderFallbackBuffer = ((baseDecoder != null) ? baseDecoder.FallbackBuffer : decoderFallback.CreateFallbackBuffer());
				decoderFallbackBuffer.InternalInitialize(bytes, ptr4);
			}
			byte* pSrc = ptr;
			char* pTarget = ptr2;
			bool num7 = FallbackInvalidByteSequence(ref pSrc, num, decoderFallbackBuffer, ref pTarget);
			ptr = pSrc;
			ptr2 = pTarget;
			if (!num7)
			{
				decoderFallbackBuffer.InternalReset();
				ThrowCharsOverflow(baseDecoder, ptr2 == chars);
				num = 0;
				break;
			}
			num = 0;
		}
		if (num != 0 && (baseDecoder == null || baseDecoder.MustFlush))
		{
			if (decoderFallbackBuffer == null)
			{
				decoderFallbackBuffer = ((baseDecoder != null) ? baseDecoder.FallbackBuffer : decoderFallback.CreateFallbackBuffer());
				decoderFallbackBuffer.InternalInitialize(bytes, ptr4);
			}
			byte* pSrc = ptr;
			char* pTarget = ptr2;
			bool num8 = FallbackInvalidByteSequence(ref pSrc, num, decoderFallbackBuffer, ref pTarget);
			ptr = pSrc;
			ptr2 = pTarget;
			if (!num8)
			{
				decoderFallbackBuffer.InternalReset();
				ThrowCharsOverflow(baseDecoder, ptr2 == chars);
			}
			num = 0;
		}
		if (baseDecoder != null)
		{
			((UTF8Decoder)baseDecoder).bits = num;
			baseDecoder._bytesUsed = (int)(ptr - bytes);
		}
		return PtrDiff(ptr2, chars);
	}

	private unsafe bool FallbackInvalidByteSequence(ref byte* pSrc, int ch, DecoderFallbackBuffer fallback, ref char* pTarget)
	{
		byte* pSrc2 = pSrc;
		byte[] bytesUnknown = GetBytesUnknown(ref pSrc2, ch);
		if (!fallback.InternalFallback(bytesUnknown, pSrc, ref pTarget))
		{
			pSrc = pSrc2;
			return false;
		}
		return true;
	}

	private unsafe int FallbackInvalidByteSequence(byte* pSrc, int ch, DecoderFallbackBuffer fallback)
	{
		byte[] bytesUnknown = GetBytesUnknown(ref pSrc, ch);
		return fallback.InternalFallback(bytesUnknown, pSrc);
	}

	private unsafe byte[] GetBytesUnknown(ref byte* pSrc, int ch)
	{
		byte[] array = null;
		if (ch < 256 && ch >= 0)
		{
			pSrc--;
			return new byte[1] { (byte)ch };
		}
		if ((ch & 0x18000000) == 0)
		{
			pSrc--;
			return new byte[1] { (byte)((ch & 0x1F) | 0xC0) };
		}
		if ((ch & 0x10000000) != 0)
		{
			if ((ch & 0x800000) != 0)
			{
				pSrc -= 3;
				return new byte[3]
				{
					(byte)(((ch >> 12) & 7) | 0xF0),
					(byte)(((ch >> 6) & 0x3F) | 0x80),
					(byte)((ch & 0x3F) | 0x80)
				};
			}
			if ((ch & 0x20000) != 0)
			{
				pSrc -= 2;
				return new byte[2]
				{
					(byte)(((ch >> 6) & 7) | 0xF0),
					(byte)((ch & 0x3F) | 0x80)
				};
			}
			pSrc--;
			return new byte[1] { (byte)((ch & 7) | 0xF0) };
		}
		if ((ch & 0x800000) != 0)
		{
			pSrc -= 2;
			return new byte[2]
			{
				(byte)(((ch >> 6) & 0xF) | 0xE0),
				(byte)((ch & 0x3F) | 0x80)
			};
		}
		pSrc--;
		return new byte[1] { (byte)((ch & 0xF) | 0xE0) };
	}

	public override Decoder GetDecoder()
	{
		return new UTF8Decoder(this);
	}

	public override Encoder GetEncoder()
	{
		return new UTF8Encoder(this);
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
		num *= 3;
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
		long num = (long)byteCount + 1L;
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

	public override byte[] GetPreamble()
	{
		if (_emitUTF8Identifier)
		{
			return new byte[3] { 239, 187, 191 };
		}
		return Array.Empty<byte>();
	}

	public override bool Equals(object value)
	{
		if (value is UTF8Encoding uTF8Encoding)
		{
			if (_emitUTF8Identifier == uTF8Encoding._emitUTF8Identifier && base.EncoderFallback.Equals(uTF8Encoding.EncoderFallback))
			{
				return base.DecoderFallback.Equals(uTF8Encoding.DecoderFallback);
			}
			return false;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return base.EncoderFallback.GetHashCode() + base.DecoderFallback.GetHashCode() + 65001 + (_emitUTF8Identifier ? 1 : 0);
	}
}
