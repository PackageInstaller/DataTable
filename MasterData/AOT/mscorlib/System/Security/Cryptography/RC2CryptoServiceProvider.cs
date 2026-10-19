using System.Runtime.InteropServices;

namespace System.Security.Cryptography;

[ComVisible(true)]
public sealed class RC2CryptoServiceProvider : RC2
{
	private bool m_use40bitSalt;

	private static KeySizes[] s_legalKeySizes = new KeySizes[1]
	{
		new KeySizes(40, 128, 8)
	};

	public override int EffectiveKeySize => KeySizeValue;

	public RC2CryptoServiceProvider()
	{
		if (CryptoConfig.AllowOnlyFipsAlgorithms)
		{
			throw new InvalidOperationException(Environment.GetResourceString("This implementation is not part of the Windows Platform FIPS validated cryptographic algorithms."));
		}
		if (!Utils.HasAlgorithm(26114, 0))
		{
			throw new CryptographicException(Environment.GetResourceString("Cryptographic service provider (CSP) could not be found for this algorithm."));
		}
		LegalKeySizesValue = s_legalKeySizes;
		FeedbackSizeValue = 8;
	}

	public override ICryptoTransform CreateEncryptor(byte[] rgbKey, byte[] rgbIV)
	{
		if (m_use40bitSalt)
		{
			throw new NotImplementedException("UseSalt=true is not implemented on Mono yet");
		}
		return new RC2Transform(this, encryption: true, rgbKey, rgbIV);
	}

	public override ICryptoTransform CreateDecryptor(byte[] rgbKey, byte[] rgbIV)
	{
		if (m_use40bitSalt)
		{
			throw new NotImplementedException("UseSalt=true is not implemented on Mono yet");
		}
		return new RC2Transform(this, encryption: false, rgbKey, rgbIV);
	}

	public override void GenerateKey()
	{
		KeyValue = new byte[KeySizeValue / 8];
		Utils.StaticRandomNumberGenerator.GetBytes(KeyValue);
	}

	public override void GenerateIV()
	{
		IVValue = new byte[8];
		Utils.StaticRandomNumberGenerator.GetBytes(IVValue);
	}
}
