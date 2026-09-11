using System.Runtime.InteropServices;

namespace System.Text;

[Serializable]
public class ASCIIEncoding : Encoding
{
	internal sealed class ASCIIEncodingSealed : ASCIIEncoding
	{
	}

	internal static readonly ASCIIEncodingSealed s_default = new ASCIIEncodingSealed();

	public override bool IsSingleByte => true;

	public ASCIIEncoding()
		: base(20127)
	{
	}

	internal override void SetDefaultFallbacks()
	{
		encoderFallback = EncoderFallback.ReplacementFallback;
		decoderFallback = DecoderFallback.ReplacementFallback;
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
			throw new ArgumentNullException("chars");
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

	public unsafe override int GetBytes(string chars, int charIndex, int charCount, byte[] bytes, int byteIndex)
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
			throw new ArgumentOutOfRangeException("chars", "Index and count must refer to a location within the string.");
		}
		if (byteIndex < 0 || byteIndex > bytes.Length)
		{
			throw new ArgumentOutOfRangeException("byteIndex", "Index was out of range. Must be non-negative and less than the size of the collection.");
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

	public unsafe override string GetString(byte[] bytes, int byteIndex, int byteCount)
	{
		if (bytes == null)
		{
			throw new ArgumentNullException("bytes", "Array cannot be null.");
		}
		if (byteIndex < 0 || byteCount < 0)
		{
			throw new ArgumentOutOfRangeException((byteIndex < 0) ? "byteIndex" : "byteCount", "Non-negative number required.");
		}
		if (bytes.Length - byteIndex < byteCount)
		{
			throw new ArgumentOutOfRangeException("bytes", "Index and count must refer to a location within the buffer.");
		}
		if (byteCount == 0)
		{
			return string.Empty;
		}
		fixed (byte* ptr = bytes)
		{
			return string.CreateStringFromEncoding(ptr + byteIndex, byteCount, this);
		}
	}

	internal unsafe override int GetByteCount(char* chars, int charCount, EncoderNLS encoder)
	{
		char c = '\0';
		EncoderReplacementFallback encoderReplacementFallback = null;
		char* ptr = chars + charCount;
		EncoderFallbackBuffer encoderFallbackBuffer = null;
		if (encoder != null)
		{
			c = encoder._charLeftOver;
			encoderReplacementFallback = encoder.Fallback as EncoderReplacementFallback;
			if (encoder.InternalHasFallbackBuffer)
			{
				encoderFallbackBuffer = encoder.FallbackBuffer;
				if (encoderFallbackBuffer.Remaining > 0 && encoder._throwOnOverflow)
				{
					throw new ArgumentException(SR.Format("Must complete Convert() operation or call Encoder.Reset() before calling GetBytes() or GetByteCount(). Encoder '{0}' fallback '{1}'.", EncodingName, encoder.Fallback.GetType()));
				}
				encoderFallbackBuffer.InternalInitialize(chars, ptr, encoder, setEncoder: false);
			}
		}
		else
		{
			encoderReplacementFallback = base.EncoderFallback as EncoderReplacementFallback;
		}
		if (encoderReplacementFallback != null && encoderReplacementFallback.MaxCharCount == 1)
		{
			if (c > '\0')
			{
				charCount++;
			}
			return charCount;
		}
		int num = 0;
		if (c > '\0')
		{
			encoderFallbackBuffer = encoder.FallbackBuffer;
			encoderFallbackBuffer.InternalInitialize(chars, ptr, encoder, setEncoder: false);
			char* chars2 = chars;
			encoderFallbackBuffer.InternalFallback(c, ref chars2);
			chars = chars2;
		}
		while (true)
		{
			char num2 = encoderFallbackBuffer?.InternalGetNextChar() ?? '\0';
			char c2 = num2;
			if (num2 == '\0' && chars >= ptr)
			{
				break;
			}
			if (c2 == '\0')
			{
				c2 = *chars;
				chars++;
			}
			if (c2 > '\u007f')
			{
				if (encoderFallbackBuffer == null)
				{
					encoderFallbackBuffer = ((encoder != null) ? encoder.FallbackBuffer : encoderFallback.CreateFallbackBuffer());
					encoderFallbackBuffer.InternalInitialize(ptr - charCount, ptr, encoder, setEncoder: false);
				}
				char* chars2 = chars;
				encoderFallbackBuffer.InternalFallback(c2, ref chars2);
				chars = chars2;
			}
			else
			{
				num++;
			}
		}
		return num;
	}

	internal unsafe override int GetBytes(char* chars, int charCount, byte* bytes, int byteCount, EncoderNLS encoder)
	{
		char c = '\0';
		EncoderReplacementFallback encoderReplacementFallback = null;
		EncoderFallbackBuffer encoderFallbackBuffer = null;
		char* ptr = chars + charCount;
		byte* ptr2 = bytes;
		char* ptr3 = chars;
		if (encoder != null)
		{
			c = encoder._charLeftOver;
			encoderReplacementFallback = encoder.Fallback as EncoderReplacementFallback;
			if (encoder.InternalHasFallbackBuffer)
			{
				encoderFallbackBuffer = encoder.FallbackBuffer;
				if (encoderFallbackBuffer.Remaining > 0 && encoder._throwOnOverflow)
				{
					throw new ArgumentException(SR.Format("Must complete Convert() operation or call Encoder.Reset() before calling GetBytes() or GetByteCount(). Encoder '{0}' fallback '{1}'.", EncodingName, encoder.Fallback.GetType()));
				}
				encoderFallbackBuffer.InternalInitialize(ptr3, ptr, encoder, setEncoder: true);
			}
		}
		else
		{
			encoderReplacementFallback = base.EncoderFallback as EncoderReplacementFallback;
		}
		if (encoderReplacementFallback != null && encoderReplacementFallback.MaxCharCount == 1)
		{
			char c2 = encoderReplacementFallback.DefaultString[0];
			if (c2 <= '\u007f')
			{
				if (c > '\0')
				{
					if (byteCount == 0)
					{
						ThrowBytesOverflow(encoder, nothingEncoded: true);
					}
					*(bytes++) = (byte)c2;
					byteCount--;
				}
				if (byteCount < charCount)
				{
					ThrowBytesOverflow(encoder, byteCount < 1);
					ptr = chars + byteCount;
				}
				while (chars < ptr)
				{
					char c3 = *(chars++);
					if (c3 >= '\u0080')
					{
						*(bytes++) = (byte)c2;
					}
					else
					{
						*(bytes++) = (byte)c3;
					}
				}
				if (encoder != null)
				{
					encoder._charLeftOver = '\0';
					encoder._charsUsed = (int)(chars - ptr3);
				}
				return (int)(bytes - ptr2);
			}
		}
		byte* ptr4 = bytes + byteCount;
		if (c > '\0')
		{
			encoderFallbackBuffer = encoder.FallbackBuffer;
			encoderFallbackBuffer.InternalInitialize(chars, ptr, encoder, setEncoder: true);
			char* chars2 = chars;
			encoderFallbackBuffer.InternalFallback(c, ref chars2);
			chars = chars2;
		}
		while (true)
		{
			char num = encoderFallbackBuffer?.InternalGetNextChar() ?? '\0';
			char c4 = num;
			if (num == '\0' && chars >= ptr)
			{
				break;
			}
			if (c4 == '\0')
			{
				c4 = *chars;
				chars++;
			}
			if (c4 > '\u007f')
			{
				if (encoderFallbackBuffer == null)
				{
					encoderFallbackBuffer = ((encoder != null) ? encoder.FallbackBuffer : encoderFallback.CreateFallbackBuffer());
					encoderFallbackBuffer.InternalInitialize(ptr - charCount, ptr, encoder, setEncoder: true);
				}
				char* chars2 = chars;
				encoderFallbackBuffer.InternalFallback(c4, ref chars2);
				chars = chars2;
				continue;
			}
			if (bytes >= ptr4)
			{
				if (encoderFallbackBuffer == null || !encoderFallbackBuffer.bFallingBack)
				{
					chars--;
				}
				else
				{
					encoderFallbackBuffer.MovePrevious();
				}
				ThrowBytesOverflow(encoder, bytes == ptr2);
				break;
			}
			*bytes = (byte)c4;
			bytes++;
		}
		if (encoder != null)
		{
			if (encoderFallbackBuffer != null && !encoderFallbackBuffer.bUsedEncoder)
			{
				encoder._charLeftOver = '\0';
			}
			encoder._charsUsed = (int)(chars - ptr3);
		}
		return (int)(bytes - ptr2);
	}

	internal unsafe override int GetCharCount(byte* bytes, int count, DecoderNLS decoder)
	{
		DecoderReplacementFallback decoderReplacementFallback = null;
		decoderReplacementFallback = ((decoder != null) ? (decoder.Fallback as DecoderReplacementFallback) : (base.DecoderFallback as DecoderReplacementFallback));
		if (decoderReplacementFallback != null && decoderReplacementFallback.MaxCharCount == 1)
		{
			return count;
		}
		DecoderFallbackBuffer decoderFallbackBuffer = null;
		int num = count;
		byte[] array = new byte[1];
		byte* ptr = bytes + count;
		while (bytes < ptr)
		{
			byte b = *bytes;
			bytes++;
			if (b >= 128)
			{
				if (decoderFallbackBuffer == null)
				{
					decoderFallbackBuffer = ((decoder != null) ? decoder.FallbackBuffer : base.DecoderFallback.CreateFallbackBuffer());
					decoderFallbackBuffer.InternalInitialize(ptr - count, null);
				}
				array[0] = b;
				num--;
				num += decoderFallbackBuffer.InternalFallback(array, bytes);
			}
		}
		return num;
	}

	internal unsafe override int GetChars(byte* bytes, int byteCount, char* chars, int charCount, DecoderNLS decoder)
	{
		byte* ptr = bytes + byteCount;
		byte* ptr2 = bytes;
		char* ptr3 = chars;
		DecoderReplacementFallback decoderReplacementFallback = null;
		decoderReplacementFallback = ((decoder != null) ? (decoder.Fallback as DecoderReplacementFallback) : (base.DecoderFallback as DecoderReplacementFallback));
		if (decoderReplacementFallback != null && decoderReplacementFallback.MaxCharCount == 1)
		{
			char c = decoderReplacementFallback.DefaultString[0];
			if (charCount < byteCount)
			{
				ThrowCharsOverflow(decoder, charCount < 1);
				ptr = bytes + charCount;
			}
			while (bytes < ptr)
			{
				byte b = *(bytes++);
				if (b >= 128)
				{
					*(chars++) = c;
				}
				else
				{
					*(chars++) = (char)b;
				}
			}
			if (decoder != null)
			{
				decoder._bytesUsed = (int)(bytes - ptr2);
			}
			return (int)(chars - ptr3);
		}
		DecoderFallbackBuffer decoderFallbackBuffer = null;
		byte[] array = new byte[1];
		char* ptr4 = chars + charCount;
		while (bytes < ptr)
		{
			byte b2 = *bytes;
			bytes++;
			if (b2 >= 128)
			{
				if (decoderFallbackBuffer == null)
				{
					decoderFallbackBuffer = ((decoder != null) ? decoder.FallbackBuffer : base.DecoderFallback.CreateFallbackBuffer());
					decoderFallbackBuffer.InternalInitialize(ptr - byteCount, ptr4);
				}
				array[0] = b2;
				char* chars2 = chars;
				bool num = decoderFallbackBuffer.InternalFallback(array, bytes, ref chars2);
				chars = chars2;
				if (!num)
				{
					bytes--;
					decoderFallbackBuffer.InternalReset();
					ThrowCharsOverflow(decoder, chars == ptr3);
					break;
				}
			}
			else
			{
				if (chars >= ptr4)
				{
					bytes--;
					ThrowCharsOverflow(decoder, chars == ptr3);
					break;
				}
				*chars = (char)b2;
				chars++;
			}
		}
		if (decoder != null)
		{
			decoder._bytesUsed = (int)(bytes - ptr2);
		}
		return (int)(chars - ptr3);
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
		long num = byteCount;
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

	public override Decoder GetDecoder()
	{
		return new DecoderNLS(this);
	}

	public override Encoder GetEncoder()
	{
		return new EncoderNLS(this);
	}
}
