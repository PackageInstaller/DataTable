using System.Globalization;

namespace System.Text;

public sealed class DecoderExceptionFallbackBuffer : DecoderFallbackBuffer
{
	public override int Remaining => 0;

	public override bool Fallback(byte[] bytesUnknown, int index)
	{
		Throw(bytesUnknown, index);
		return true;
	}

	public override char GetNextChar()
	{
		return '\0';
	}

	private void Throw(byte[] bytesUnknown, int index)
	{
		StringBuilder stringBuilder = new StringBuilder(bytesUnknown.Length * 3);
		int i;
		for (i = 0; i < bytesUnknown.Length && i < 20; i++)
		{
			stringBuilder.Append('[');
			stringBuilder.Append(bytesUnknown[i].ToString("X2", CultureInfo.InvariantCulture));
			stringBuilder.Append(']');
		}
		if (i == 20)
		{
			stringBuilder.Append(" ...");
		}
		throw new DecoderFallbackException(SR.Format("Unable to translate bytes {0} at index {1} from specified code page to Unicode.", stringBuilder, index), bytesUnknown, index);
	}
}
