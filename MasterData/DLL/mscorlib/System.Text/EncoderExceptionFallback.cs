namespace System.Text;

[Serializable]
public sealed class EncoderExceptionFallback : EncoderFallback
{
	public override int MaxCharCount => 0;

	public override EncoderFallbackBuffer CreateFallbackBuffer()
	{
		return new EncoderExceptionFallbackBuffer();
	}

	public override bool Equals(object value)
	{
		if (value is EncoderExceptionFallback)
		{
			return true;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return 654;
	}
}
