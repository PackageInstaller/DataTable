namespace System.Text;

[Serializable]
internal sealed class InternalDecoderBestFitFallback : DecoderFallback
{
	internal Encoding _encoding;

	internal char[] _arrayBestFit;

	internal char _cReplacement = '?';

	public override int MaxCharCount => 1;

	internal InternalDecoderBestFitFallback(Encoding encoding)
	{
		_encoding = encoding;
	}

	public override DecoderFallbackBuffer CreateFallbackBuffer()
	{
		return new InternalDecoderBestFitFallbackBuffer(this);
	}

	public override bool Equals(object value)
	{
		if (value is InternalDecoderBestFitFallback internalDecoderBestFitFallback)
		{
			return _encoding.CodePage == internalDecoderBestFitFallback._encoding.CodePage;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return _encoding.CodePage;
	}
}
