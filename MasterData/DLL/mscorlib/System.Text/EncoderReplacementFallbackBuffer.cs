namespace System.Text;

public sealed class EncoderReplacementFallbackBuffer : EncoderFallbackBuffer
{
	private string _strDefault;

	private int _fallbackCount = -1;

	private int _fallbackIndex = -1;

	public override int Remaining
	{
		get
		{
			if (_fallbackCount >= 0)
			{
				return _fallbackCount;
			}
			return 0;
		}
	}

	public EncoderReplacementFallbackBuffer(EncoderReplacementFallback fallback)
	{
		_strDefault = fallback.DefaultString + fallback.DefaultString;
	}

	public override bool Fallback(char charUnknown, int index)
	{
		if (_fallbackCount >= 1)
		{
			if (char.IsHighSurrogate(charUnknown) && _fallbackCount >= 0 && char.IsLowSurrogate(_strDefault[_fallbackIndex + 1]))
			{
				ThrowLastCharRecursive(char.ConvertToUtf32(charUnknown, _strDefault[_fallbackIndex + 1]));
			}
			ThrowLastCharRecursive(charUnknown);
		}
		_fallbackCount = _strDefault.Length / 2;
		_fallbackIndex = -1;
		return _fallbackCount != 0;
	}

	public override bool Fallback(char charUnknownHigh, char charUnknownLow, int index)
	{
		if (!char.IsHighSurrogate(charUnknownHigh))
		{
			throw new ArgumentOutOfRangeException("charUnknownHigh", SR.Format("Valid values are between {0} and {1}, inclusive.", 55296, 56319));
		}
		if (!char.IsLowSurrogate(charUnknownLow))
		{
			throw new ArgumentOutOfRangeException("charUnknownLow", SR.Format("Valid values are between {0} and {1}, inclusive.", 56320, 57343));
		}
		if (_fallbackCount >= 1)
		{
			ThrowLastCharRecursive(char.ConvertToUtf32(charUnknownHigh, charUnknownLow));
		}
		_fallbackCount = _strDefault.Length;
		_fallbackIndex = -1;
		return _fallbackCount != 0;
	}

	public override char GetNextChar()
	{
		_fallbackCount--;
		_fallbackIndex++;
		if (_fallbackCount < 0)
		{
			return '\0';
		}
		if (_fallbackCount == int.MaxValue)
		{
			_fallbackCount = -1;
			return '\0';
		}
		return _strDefault[_fallbackIndex];
	}

	public override bool MovePrevious()
	{
		if (_fallbackCount >= -1 && _fallbackIndex >= 0)
		{
			_fallbackIndex--;
			_fallbackCount++;
			return true;
		}
		return false;
	}

	public unsafe override void Reset()
	{
		_fallbackCount = -1;
		_fallbackIndex = 0;
		charStart = null;
		bFallingBack = false;
	}
}
