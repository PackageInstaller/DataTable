namespace System.Text;

[Serializable]
public abstract class Encoder
{
	internal EncoderFallback _fallback;

	internal EncoderFallbackBuffer _fallbackBuffer;

	public EncoderFallback Fallback => _fallback;

	public EncoderFallbackBuffer FallbackBuffer
	{
		get
		{
			if (_fallbackBuffer == null)
			{
				if (_fallback != null)
				{
					_fallbackBuffer = _fallback.CreateFallbackBuffer();
				}
				else
				{
					_fallbackBuffer = EncoderFallback.ReplacementFallback.CreateFallbackBuffer();
				}
			}
			return _fallbackBuffer;
		}
	}

	internal bool InternalHasFallbackBuffer => _fallbackBuffer != null;

	public virtual void Reset()
	{
		char[] chars = new char[0];
		byte[] bytes = new byte[GetByteCount(chars, 0, 0, flush: true)];
		GetBytes(chars, 0, 0, bytes, 0, flush: true);
		if (_fallbackBuffer != null)
		{
			_fallbackBuffer.Reset();
		}
	}

	public abstract int GetByteCount(char[] chars, int index, int count, bool flush);

	[CLSCompliant(false)]
	public unsafe virtual int GetByteCount(char* chars, int count, bool flush)
	{
		if (chars == null)
		{
			throw new ArgumentNullException("chars", "Array cannot be null.");
		}
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count", "Non-negative number required.");
		}
		char[] array = new char[count];
		for (int i = 0; i < count; i++)
		{
			array[i] = chars[i];
		}
		return GetByteCount(array, 0, count, flush);
	}

	public abstract int GetBytes(char[] chars, int charIndex, int charCount, byte[] bytes, int byteIndex, bool flush);

	[CLSCompliant(false)]
	public unsafe virtual int GetBytes(char* chars, int charCount, byte* bytes, int byteCount, bool flush)
	{
		if (bytes == null || chars == null)
		{
			throw new ArgumentNullException((bytes == null) ? "bytes" : "chars", "Array cannot be null.");
		}
		if (charCount < 0 || byteCount < 0)
		{
			throw new ArgumentOutOfRangeException((charCount < 0) ? "charCount" : "byteCount", "Non-negative number required.");
		}
		char[] array = new char[charCount];
		for (int i = 0; i < charCount; i++)
		{
			array[i] = chars[i];
		}
		byte[] array2 = new byte[byteCount];
		int bytes2 = GetBytes(array, 0, charCount, array2, 0, flush);
		if (bytes2 < byteCount)
		{
			byteCount = bytes2;
		}
		for (int i = 0; i < byteCount; i++)
		{
			bytes[i] = array2[i];
		}
		return byteCount;
	}

	public virtual void Convert(char[] chars, int charIndex, int charCount, byte[] bytes, int byteIndex, int byteCount, bool flush, out int charsUsed, out int bytesUsed, out bool completed)
	{
		if (chars == null || bytes == null)
		{
			throw new ArgumentNullException((chars == null) ? "chars" : "bytes", "Array cannot be null.");
		}
		if (charIndex < 0 || charCount < 0)
		{
			throw new ArgumentOutOfRangeException((charIndex < 0) ? "charIndex" : "charCount", "Non-negative number required.");
		}
		if (byteIndex < 0 || byteCount < 0)
		{
			throw new ArgumentOutOfRangeException((byteIndex < 0) ? "byteIndex" : "byteCount", "Non-negative number required.");
		}
		if (chars.Length - charIndex < charCount)
		{
			throw new ArgumentOutOfRangeException("chars", "Index and count must refer to a location within the buffer.");
		}
		if (bytes.Length - byteIndex < byteCount)
		{
			throw new ArgumentOutOfRangeException("bytes", "Index and count must refer to a location within the buffer.");
		}
		for (charsUsed = charCount; charsUsed > 0; charsUsed /= 2)
		{
			if (GetByteCount(chars, charIndex, charsUsed, flush) <= byteCount)
			{
				bytesUsed = GetBytes(chars, charIndex, charsUsed, bytes, byteIndex, flush);
				completed = charsUsed == charCount && (_fallbackBuffer == null || _fallbackBuffer.Remaining == 0);
				return;
			}
			flush = false;
		}
		throw new ArgumentException("Conversion buffer overflow.");
	}

	[CLSCompliant(false)]
	public unsafe virtual void Convert(char* chars, int charCount, byte* bytes, int byteCount, bool flush, out int charsUsed, out int bytesUsed, out bool completed)
	{
		if (bytes == null || chars == null)
		{
			throw new ArgumentNullException((bytes == null) ? "bytes" : "chars", "Array cannot be null.");
		}
		if (charCount < 0 || byteCount < 0)
		{
			throw new ArgumentOutOfRangeException((charCount < 0) ? "charCount" : "byteCount", "Non-negative number required.");
		}
		for (charsUsed = charCount; charsUsed > 0; charsUsed /= 2)
		{
			if (GetByteCount(chars, charsUsed, flush) <= byteCount)
			{
				bytesUsed = GetBytes(chars, charsUsed, bytes, byteCount, flush);
				completed = charsUsed == charCount && (_fallbackBuffer == null || _fallbackBuffer.Remaining == 0);
				return;
			}
			flush = false;
		}
		throw new ArgumentException("Conversion buffer overflow.");
	}
}
