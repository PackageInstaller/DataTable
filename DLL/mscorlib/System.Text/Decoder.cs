using System.Runtime.InteropServices;

namespace System.Text;

[Serializable]
public abstract class Decoder
{
	internal DecoderFallback _fallback;

	internal DecoderFallbackBuffer _fallbackBuffer;

	public DecoderFallback Fallback => _fallback;

	public DecoderFallbackBuffer FallbackBuffer
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
					_fallbackBuffer = DecoderFallback.ReplacementFallback.CreateFallbackBuffer();
				}
			}
			return _fallbackBuffer;
		}
	}

	internal bool InternalHasFallbackBuffer => _fallbackBuffer != null;

	public virtual void Reset()
	{
		byte[] bytes = Array.Empty<byte>();
		char[] chars = new char[GetCharCount(bytes, 0, 0, flush: true)];
		GetChars(bytes, 0, 0, chars, 0, flush: true);
		_fallbackBuffer?.Reset();
	}

	public abstract int GetCharCount(byte[] bytes, int index, int count);

	public virtual int GetCharCount(byte[] bytes, int index, int count, bool flush)
	{
		return GetCharCount(bytes, index, count);
	}

	[CLSCompliant(false)]
	public unsafe virtual int GetCharCount(byte* bytes, int count, bool flush)
	{
		if (bytes == null)
		{
			throw new ArgumentNullException("bytes", "Array cannot be null.");
		}
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count", "Non-negative number required.");
		}
		byte[] array = new byte[count];
		for (int i = 0; i < count; i++)
		{
			array[i] = bytes[i];
		}
		return GetCharCount(array, 0, count);
	}

	public abstract int GetChars(byte[] bytes, int byteIndex, int byteCount, char[] chars, int charIndex);

	public virtual int GetChars(byte[] bytes, int byteIndex, int byteCount, char[] chars, int charIndex, bool flush)
	{
		return GetChars(bytes, byteIndex, byteCount, chars, charIndex);
	}

	[CLSCompliant(false)]
	public unsafe virtual int GetChars(byte* bytes, int byteCount, char* chars, int charCount, bool flush)
	{
		if (chars == null || bytes == null)
		{
			throw new ArgumentNullException((chars == null) ? "chars" : "bytes", "Array cannot be null.");
		}
		if (byteCount < 0 || charCount < 0)
		{
			throw new ArgumentOutOfRangeException((byteCount < 0) ? "byteCount" : "charCount", "Non-negative number required.");
		}
		byte[] array = new byte[byteCount];
		for (int i = 0; i < byteCount; i++)
		{
			array[i] = bytes[i];
		}
		char[] array2 = new char[charCount];
		int chars2 = GetChars(array, 0, byteCount, array2, 0, flush);
		if (chars2 < charCount)
		{
			charCount = chars2;
		}
		for (int i = 0; i < charCount; i++)
		{
			chars[i] = array2[i];
		}
		return charCount;
	}

	public unsafe virtual int GetChars(ReadOnlySpan<byte> bytes, Span<char> chars, bool flush)
	{
		fixed (byte* nonNullPinnableReference = &MemoryMarshal.GetNonNullPinnableReference(bytes))
		{
			fixed (char* nonNullPinnableReference2 = &MemoryMarshal.GetNonNullPinnableReference(chars))
			{
				return GetChars(nonNullPinnableReference, bytes.Length, nonNullPinnableReference2, chars.Length, flush);
			}
		}
	}

	public virtual void Convert(byte[] bytes, int byteIndex, int byteCount, char[] chars, int charIndex, int charCount, bool flush, out int bytesUsed, out int charsUsed, out bool completed)
	{
		if (bytes == null || chars == null)
		{
			throw new ArgumentNullException((bytes == null) ? "bytes" : "chars", "Array cannot be null.");
		}
		if (byteIndex < 0 || byteCount < 0)
		{
			throw new ArgumentOutOfRangeException((byteIndex < 0) ? "byteIndex" : "byteCount", "Non-negative number required.");
		}
		if (charIndex < 0 || charCount < 0)
		{
			throw new ArgumentOutOfRangeException((charIndex < 0) ? "charIndex" : "charCount", "Non-negative number required.");
		}
		if (bytes.Length - byteIndex < byteCount)
		{
			throw new ArgumentOutOfRangeException("bytes", "Index and count must refer to a location within the buffer.");
		}
		if (chars.Length - charIndex < charCount)
		{
			throw new ArgumentOutOfRangeException("chars", "Index and count must refer to a location within the buffer.");
		}
		for (bytesUsed = byteCount; bytesUsed > 0; bytesUsed /= 2)
		{
			if (GetCharCount(bytes, byteIndex, bytesUsed, flush) <= charCount)
			{
				charsUsed = GetChars(bytes, byteIndex, bytesUsed, chars, charIndex, flush);
				completed = bytesUsed == byteCount && (_fallbackBuffer == null || _fallbackBuffer.Remaining == 0);
				return;
			}
			flush = false;
		}
		throw new ArgumentException("Conversion buffer overflow.");
	}

	[CLSCompliant(false)]
	public unsafe virtual void Convert(byte* bytes, int byteCount, char* chars, int charCount, bool flush, out int bytesUsed, out int charsUsed, out bool completed)
	{
		if (chars == null || bytes == null)
		{
			throw new ArgumentNullException((chars == null) ? "chars" : "bytes", "Array cannot be null.");
		}
		if (byteCount < 0 || charCount < 0)
		{
			throw new ArgumentOutOfRangeException((byteCount < 0) ? "byteCount" : "charCount", "Non-negative number required.");
		}
		for (bytesUsed = byteCount; bytesUsed > 0; bytesUsed /= 2)
		{
			if (GetCharCount(bytes, bytesUsed, flush) <= charCount)
			{
				charsUsed = GetChars(bytes, bytesUsed, chars, charCount, flush);
				completed = bytesUsed == byteCount && (_fallbackBuffer == null || _fallbackBuffer.Remaining == 0);
				return;
			}
			flush = false;
		}
		throw new ArgumentException("Conversion buffer overflow.");
	}
}
