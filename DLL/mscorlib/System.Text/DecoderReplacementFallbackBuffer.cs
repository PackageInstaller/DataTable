namespace System.Text;

public sealed class DecoderReplacementFallbackBuffer : DecoderFallbackBuffer
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

	public DecoderReplacementFallbackBuffer(DecoderReplacementFallback fallback)
	{
		_strDefault = fallback.DefaultString;
	}

	public override bool Fallback(byte[] bytesUnknown, int index)
	{
		if (_fallbackCount >= 1)
		{
			ThrowLastBytesRecursive(bytesUnknown);
		}
		if (_strDefault.Length == 0)
		{
			return false;
		}
		_fallbackCount = _strDefault.Length;
		_fallbackIndex = -1;
		return true;
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

	public unsafe override void Reset()
	{
		_fallbackCount = -1;
		_fallbackIndex = -1;
		byteStart = null;
	}

	internal unsafe override int InternalFallback(byte[] bytes, byte* pBytes)
	{
		return _strDefault.Length;
	}
}
