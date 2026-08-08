using System.Runtime.InteropServices;

namespace System.Text;

internal class DecoderNLS : Decoder
{
	private Encoding _encoding;

	private bool _mustFlush;

	internal bool _throwOnOverflow;

	internal int _bytesUsed;

	public bool MustFlush => _mustFlush;

	internal virtual bool HasState => false;

	internal DecoderNLS(Encoding encoding)
	{
		_encoding = encoding;
		_fallback = _encoding.DecoderFallback;
		Reset();
	}

	public override void Reset()
	{
		_fallbackBuffer?.Reset();
	}

	public override int GetCharCount(byte[] bytes, int index, int count)
	{
		return GetCharCount(bytes, index, count, flush: false);
	}

	public unsafe override int GetCharCount(byte[] bytes, int index, int count, bool flush)
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
		fixed (byte* reference = &MemoryMarshal.GetReference((Span<byte>)bytes))
		{
			return GetCharCount(reference + index, count, flush);
		}
	}

	public unsafe override int GetCharCount(byte* bytes, int count, bool flush)
	{
		if (bytes == null)
		{
			throw new ArgumentNullException("bytes", "Array cannot be null.");
		}
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count", "Non-negative number required.");
		}
		_mustFlush = flush;
		_throwOnOverflow = true;
		return _encoding.GetCharCount(bytes, count, this);
	}

	public override int GetChars(byte[] bytes, int byteIndex, int byteCount, char[] chars, int charIndex)
	{
		return GetChars(bytes, byteIndex, byteCount, chars, charIndex, flush: false);
	}

	public unsafe override int GetChars(byte[] bytes, int byteIndex, int byteCount, char[] chars, int charIndex, bool flush)
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
		int charCount = chars.Length - charIndex;
		fixed (byte* reference = &MemoryMarshal.GetReference((Span<byte>)bytes))
		{
			fixed (char* reference2 = &MemoryMarshal.GetReference((Span<char>)chars))
			{
				return GetChars(reference + byteIndex, byteCount, reference2 + charIndex, charCount, flush);
			}
		}
	}

	public unsafe override int GetChars(byte* bytes, int byteCount, char* chars, int charCount, bool flush)
	{
		if (chars == null || bytes == null)
		{
			throw new ArgumentNullException((chars == null) ? "chars" : "bytes", "Array cannot be null.");
		}
		if (byteCount < 0 || charCount < 0)
		{
			throw new ArgumentOutOfRangeException((byteCount < 0) ? "byteCount" : "charCount", "Non-negative number required.");
		}
		_mustFlush = flush;
		_throwOnOverflow = true;
		return _encoding.GetChars(bytes, byteCount, chars, charCount, this);
	}

	public unsafe override void Convert(byte[] bytes, int byteIndex, int byteCount, char[] chars, int charIndex, int charCount, bool flush, out int bytesUsed, out int charsUsed, out bool completed)
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
		fixed (byte* reference = &MemoryMarshal.GetReference((Span<byte>)bytes))
		{
			fixed (char* reference2 = &MemoryMarshal.GetReference((Span<char>)chars))
			{
				Convert(reference + byteIndex, byteCount, reference2 + charIndex, charCount, flush, out bytesUsed, out charsUsed, out completed);
			}
		}
	}

	public unsafe override void Convert(byte* bytes, int byteCount, char* chars, int charCount, bool flush, out int bytesUsed, out int charsUsed, out bool completed)
	{
		if (chars == null || bytes == null)
		{
			throw new ArgumentNullException((chars == null) ? "chars" : "bytes", "Array cannot be null.");
		}
		if (byteCount < 0 || charCount < 0)
		{
			throw new ArgumentOutOfRangeException((byteCount < 0) ? "byteCount" : "charCount", "Non-negative number required.");
		}
		_mustFlush = flush;
		_throwOnOverflow = false;
		_bytesUsed = 0;
		charsUsed = _encoding.GetChars(bytes, byteCount, chars, charCount, this);
		bytesUsed = _bytesUsed;
		completed = bytesUsed == byteCount && (!flush || !HasState) && (_fallbackBuffer == null || _fallbackBuffer.Remaining == 0);
	}

	internal void ClearMustFlush()
	{
		_mustFlush = false;
	}
}
