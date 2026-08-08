using System.Runtime.InteropServices;

namespace System.Text;

internal class EncoderNLS : Encoder
{
	internal char _charLeftOver;

	private Encoding _encoding;

	private bool _mustFlush;

	internal bool _throwOnOverflow;

	internal int _charsUsed;

	public Encoding Encoding => _encoding;

	public bool MustFlush => _mustFlush;

	internal virtual bool HasState => _charLeftOver != '\0';

	internal EncoderNLS(Encoding encoding)
	{
		_encoding = encoding;
		_fallback = _encoding.EncoderFallback;
		Reset();
	}

	internal EncoderNLS()
	{
		_encoding = null;
		Reset();
	}

	public override void Reset()
	{
		_charLeftOver = '\0';
		if (_fallbackBuffer != null)
		{
			_fallbackBuffer.Reset();
		}
	}

	public unsafe override int GetByteCount(char[] chars, int index, int count, bool flush)
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
		int byteCount;
		fixed (char* reference = &MemoryMarshal.GetReference((Span<char>)chars))
		{
			byteCount = GetByteCount(reference + index, count, flush);
		}
		return byteCount;
	}

	public unsafe override int GetByteCount(char* chars, int count, bool flush)
	{
		if (chars == null)
		{
			throw new ArgumentNullException("chars", "Array cannot be null.");
		}
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count", "Non-negative number required.");
		}
		_mustFlush = flush;
		_throwOnOverflow = true;
		return _encoding.GetByteCount(chars, count, this);
	}

	public unsafe override int GetBytes(char[] chars, int charIndex, int charCount, byte[] bytes, int byteIndex, bool flush)
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
		int byteCount = bytes.Length - byteIndex;
		fixed (char* reference = &MemoryMarshal.GetReference((Span<char>)chars))
		{
			fixed (byte* reference2 = &MemoryMarshal.GetReference((Span<byte>)bytes))
			{
				return GetBytes(reference + charIndex, charCount, reference2 + byteIndex, byteCount, flush);
			}
		}
	}

	public unsafe override int GetBytes(char* chars, int charCount, byte* bytes, int byteCount, bool flush)
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
		return _encoding.GetBytes(chars, charCount, bytes, byteCount, this);
	}

	public unsafe override void Convert(char[] chars, int charIndex, int charCount, byte[] bytes, int byteIndex, int byteCount, bool flush, out int charsUsed, out int bytesUsed, out bool completed)
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
		fixed (char* reference = &MemoryMarshal.GetReference((Span<char>)chars))
		{
			fixed (byte* reference2 = &MemoryMarshal.GetReference((Span<byte>)bytes))
			{
				Convert(reference + charIndex, charCount, reference2 + byteIndex, byteCount, flush, out charsUsed, out bytesUsed, out completed);
			}
		}
	}

	public unsafe override void Convert(char* chars, int charCount, byte* bytes, int byteCount, bool flush, out int charsUsed, out int bytesUsed, out bool completed)
	{
		if (bytes == null || chars == null)
		{
			throw new ArgumentNullException((bytes == null) ? "bytes" : "chars", "Array cannot be null.");
		}
		if (charCount < 0 || byteCount < 0)
		{
			throw new ArgumentOutOfRangeException((charCount < 0) ? "charCount" : "byteCount", "Non-negative number required.");
		}
		_mustFlush = flush;
		_throwOnOverflow = false;
		_charsUsed = 0;
		bytesUsed = _encoding.GetBytes(chars, charCount, bytes, byteCount, this);
		charsUsed = _charsUsed;
		completed = charsUsed == charCount && (!flush || !HasState) && (_fallbackBuffer == null || _fallbackBuffer.Remaining == 0);
	}

	internal void ClearMustFlush()
	{
		_mustFlush = false;
	}
}
