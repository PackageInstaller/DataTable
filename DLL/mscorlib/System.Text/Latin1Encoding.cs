using System.Runtime.Serialization;

namespace System.Text;

[Serializable]
internal class Latin1Encoding : EncodingNLS, ISerializable
{
	internal static readonly Latin1Encoding s_default = new Latin1Encoding();

	private static readonly char[] arrayCharBestFit = new char[604]
	{
		'\u0002', '\0', '鋐', '\0', '\u0002', '\0', '\u0001', '\0', '\u0016', '\0',
		'쥘', '\0', '\0', '\0', '\u0002', '\0', '\n', '\0', '\ua950', '\0',
		'\a', '\0', '\u0001', '\0', '\u001d', '\0', '뒨', '\0', '\0', '\0',
		'\u0002', '\0', '\u0011', '\0', '沠', '\0', '\0', '\0', '\u0002', '\0',
		'\u0006', '\0', '땐', '\0', '\u0005', '\0', '\u0001', '\0', '\u001b', '\0',
		'喨', '\0', '\0', '\0', '\u0002', '\0', '\u000e', '\0', '䶠', '\0',
		'\0', '\0', '\u0002', '\0', '\u0003', '\0', 'ꖰ', '\0', '\u0003', '\0',
		'\u0001', '\0', '\u0018', '\0', '劸', '\0', '\0', '\0', '\u0002', '\0',
		'\f', '\0', '劰', '\0', '\b', '\0', '\u0001', '\0', '\u001f', '\0',
		'\ua950', '\0', '\0', '\0', '\u0002', '\0', '\u0012', '\0', '\ue950', '\0',
		'\0', '\0', '\u0002', '\0', '\b', '\0', '檠', '\0', '\u0006', '\0',
		'\u0001', '\0', '\u001c', '\0', '교', '\0', '\0', '\0', '\u0002', '\0',
		'\u000f', '\0', 'ꭐ', '\0', '\0', '\0', '\u0002', '\0', '\u0005', '\0',
		'䭠', '\0', '\u0004', '\0', '\u0001', '\0', '\u0019', '\0', 'ꕰ', '\0',
		'\0', '\0', '\u0002', '\0', '\r', '\0', 'ꕰ', '\0', '\0', '\0',
		'\u0002', '\0', '\u0002', '\0', '剠', '\0', '\u0003', '\0', '\u0001', '\0',
		'\u0015', '\0', '\ue930', '\0', '\0', '\0', '\u0002', '\0', '\t', '\0',
		'\ud950', '\0', '\a', '\0', '\u0001', '\0', '\u001e', '\0', '媨', '\0',
		'\0', '\0', '\u0002', '\0', '\u0011', '\0', '嚠', '\0', '\0', '\0',
		'\u0002', '\0', '\u0006', '\0', '雐', '\0', '\u0005', '\0', '\u0001', '\0',
		'\u001b', '\0', '䫨', '\0', '\0', '\0', '\u0002', '\0', '\u000f', '\0',
		'䫐', '\0', '\0', '\0', '\u0002', '\0', '\u0003', '\0', 'ꓐ', '\0',
		'\u0004', '\0', '\u0001', '\0', '\u0017', '\0', '퉨', '\0', '\0', '\0',
		'\u0002', '\0', '\v', '\0', '퉐', '\0', '\b', '\0', '\u0001', '\0',
		'\u001f', '\0', '픨', '\0', '\0', '\0', '\u0002', '\0', '\u0012', '\0',
		'땀', '\0', '\0', '\0', '\u0002', '\0', '\a', '\0', '뚠', '\0',
		'\u0006', '\0', '\u0001', '\0', '\u001c', '\0', '雐', '\0', '\0', '\0',
		'\u0002', '\0', '\u0010', '\0', '閰', '\0', '\0', '\0', '\u0002', '\0',
		'\u0005', '\0', '䦰', '\0', '\u0004', '\0', '\u0001', '\0', '\u0019', '\0',
		'꒸', '\0', '\0', '\0', '\u0002', '\0', '\r', '\0', '꒰', '\0',
		'\n', '\0', '\u0002', '\0', '\u0002', '\0', '뉘', '\0', '\0', '\0',
		'\u0002', '\0', '\u0014', '\0', '橐', '\0', '\0', '\0', '\u0002', '\0',
		'\t', '\0', '浀', '\0', '\u0006', '\0', '\u0001', '\0', '\u001d', '\0',
		'궠', '\0', '\0', '\0', '\u0002', '\0', '\u0011', '\0', 'ꭠ', '\0',
		'\0', '\0', '\u0002', '\0', '\u0006', '\0', '镰', '\0', '\u0005', '\0',
		'\u0001', '\0', '\u001b', '\0', '䥸', '\0', '\0', '\0', '\u0002', '\0',
		'\u000f', '\0', '䥰', '\0', '\0', '\0', '\u0002', '\0', '\u0004', '\0',
		'撰', '\0', '\u0003', '\0', '\u0001', '\0', '\u0017', '\0', '橐', '\0',
		'\0', '\0', '\u0002', '\0', '\n', '\0', '\uea50', '\0', '\b', '\0',
		'\u0001', '\0', '\u001f', '\0', '欨', '\0', '\0', '\0', '\u0002', '\0',
		'\u0013', '\0', '嫀', '\0', '\0', '\0', '\u0002', '\0', '\a', '\0',
		'ꭠ', '\0', '\u0005', '\0', '\u0001', '\0', '\u001c', '\0', '鍨', '\0',
		'\0', '\0', '\u0002', '\0', '\u0010', '\0', '鋠', '\0', '\0', '\0',
		'\u0002', '\0', '\u0005', '\0', '쥠', '\0', '\u0004', '\0', '\u0001', '\0',
		'\u0018', '\0', '풨', '\0', '\0', '\0', '\u0002', '\0', '\f', '\0',
		'풠', '\0', '\0', '\0', '\u0002', '\0', '\u0001', '\0', '\uda50', '\0',
		'\u0002', '\0', '\u0001', '\0', '\u0016', '\0', '媨', '\0', '\0', '\0',
		'\u0002', '\0', '\t', '\0', '嚠', '\0', '\a', '\0', '\u0001', '\0',
		'\u001d', '\0', '\uaad8', '\0', '\0', '\0', '\u0002', '\0', '\u0012', '\0',
		'◐', '\0', '\0', '\0', '\u0002', '\0', '\a', '\0', '鋐', '\0',
		'\u0005', '\0', '\u0001', '\0', '\u001a', '\0', '쥘', '\0', '\0', '\0',
		'\u0002', '\0', '\u000e', '\0', '\ua950', '\0', '\0', '\0', '\u0002', '\0',
		'\u0003', '\0', '뒠', '\0', '\u0004', '\0', '\u0001', '\0', '\u0017', '\0',
		'땐', '\0', '\0', '\0', '\u0002', '\0', '\n', '\0', '교', '\0',
		'\t', '\0', '\u0001', '\0', '\u001f', '\0', '喨', '\0', '\0', '\0',
		'\u0002', '\0', '\u0013', '\0', '䮠', '\0', '\0', '\0', '\u0002', '\0',
		'\b', '\0', 'ꖰ', '\0', '\u0006', '\0', '\u0001', '\0', '\u001c', '\0',
		'劸', '\0', '\0', '\0', '\u0002', '\0', '\u0010', '\0', '劰', '\0',
		'\0', '\0', '\u0002', '\0', '\u0005', '\0', 'ꤰ', '\0', '\u0004', '\0',
		'\u0001', '\0', '\u0019', '\0', '璨', '\0', '\0', '\0', '\u0002', '\0',
		'\f', '\0', '檠', '\0'
	};

	public override bool IsSingleByte => true;

	public Latin1Encoding()
		: base(28591)
	{
	}

	internal Latin1Encoding(SerializationInfo info, StreamingContext context)
		: base(28591)
	{
		DeserializeEncoding(info, context);
	}

	void ISerializable.GetObjectData(SerializationInfo info, StreamingContext context)
	{
		SerializeEncoding(info, context);
		info.AddValue("CodePageEncoding+maxCharSize", 1);
		info.AddValue("CodePageEncoding+m_codePage", CodePage);
		info.AddValue("CodePageEncoding+dataItem", null);
	}

	internal unsafe override int GetByteCount(char* chars, int charCount, EncoderNLS encoder)
	{
		char c = '\0';
		EncoderReplacementFallback encoderReplacementFallback;
		if (encoder != null)
		{
			c = encoder._charLeftOver;
			encoderReplacementFallback = encoder.Fallback as EncoderReplacementFallback;
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
		char* ptr = chars + charCount;
		EncoderFallbackBuffer encoderFallbackBuffer = null;
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
			if (c2 > 'ÿ')
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
		if (encoder != null)
		{
			c = encoder._charLeftOver;
			encoderReplacementFallback = encoder.Fallback as EncoderReplacementFallback;
		}
		else
		{
			encoderReplacementFallback = base.EncoderFallback as EncoderReplacementFallback;
		}
		char* ptr = chars + charCount;
		byte* ptr2 = bytes;
		char* ptr3 = chars;
		if (encoderReplacementFallback != null && encoderReplacementFallback.MaxCharCount == 1)
		{
			char c2 = encoderReplacementFallback.DefaultString[0];
			if (c2 <= 'ÿ')
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
					if (c3 > 'ÿ')
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
		EncoderFallbackBuffer encoderFallbackBuffer = null;
		if (c > '\0')
		{
			encoderFallbackBuffer = encoder.FallbackBuffer;
			encoderFallbackBuffer.InternalInitialize(chars, ptr, encoder, setEncoder: true);
			char* chars2 = chars;
			encoderFallbackBuffer.InternalFallback(c, ref chars2);
			chars = chars2;
			if (encoderFallbackBuffer.Remaining > ptr4 - bytes)
			{
				ThrowBytesOverflow(encoder, nothingEncoded: true);
			}
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
			if (c4 > 'ÿ')
			{
				if (encoderFallbackBuffer == null)
				{
					encoderFallbackBuffer = ((encoder != null) ? encoder.FallbackBuffer : encoderFallback.CreateFallbackBuffer());
					encoderFallbackBuffer.InternalInitialize(ptr - charCount, ptr, encoder, setEncoder: true);
				}
				char* chars2 = chars;
				encoderFallbackBuffer.InternalFallback(c4, ref chars2);
				chars = chars2;
				if (encoderFallbackBuffer.Remaining > ptr4 - bytes)
				{
					chars--;
					encoderFallbackBuffer.InternalReset();
					ThrowBytesOverflow(encoder, chars == ptr3);
					break;
				}
				continue;
			}
			if (bytes >= ptr4)
			{
				if (encoderFallbackBuffer == null || !encoderFallbackBuffer.bFallingBack)
				{
					chars--;
				}
				ThrowBytesOverflow(encoder, chars == ptr3);
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
		return count;
	}

	internal unsafe override int GetChars(byte* bytes, int byteCount, char* chars, int charCount, DecoderNLS decoder)
	{
		if (charCount < byteCount)
		{
			ThrowCharsOverflow(decoder, charCount < 1);
			byteCount = charCount;
		}
		byte* ptr = bytes + byteCount;
		while (bytes < ptr)
		{
			*chars = (char)(*bytes);
			chars++;
			bytes++;
		}
		if (decoder != null)
		{
			decoder._bytesUsed = byteCount;
		}
		return byteCount;
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

	public override bool IsAlwaysNormalized(NormalizationForm form)
	{
		return form == NormalizationForm.FormC;
	}

	internal override char[] GetBestFitUnicodeToBytesData()
	{
		return arrayCharBestFit;
	}
}
