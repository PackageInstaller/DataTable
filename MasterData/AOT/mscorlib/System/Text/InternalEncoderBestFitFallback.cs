namespace System.Text;

[Serializable]
internal class InternalEncoderBestFitFallback : EncoderFallback
{
	internal Encoding _encoding;

	internal char[] _arrayBestFit;

	public override int MaxCharCount => 1;

	internal InternalEncoderBestFitFallback(Encoding encoding)
	{
		_encoding = encoding;
	}

	public override EncoderFallbackBuffer CreateFallbackBuffer()
	{
		return new InternalEncoderBestFitFallbackBuffer(this);
	}

	public override bool Equals(object value)
	{
		if (value is InternalEncoderBestFitFallback internalEncoderBestFitFallback)
		{
			return _encoding.CodePage == internalEncoderBestFitFallback._encoding.CodePage;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return _encoding.CodePage;
	}
}
