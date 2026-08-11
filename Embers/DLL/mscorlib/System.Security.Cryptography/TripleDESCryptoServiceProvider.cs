using System.Runtime.InteropServices;

namespace System.Security.Cryptography;

[ComVisible(true)]
public sealed class TripleDESCryptoServiceProvider : TripleDES
{
	public TripleDESCryptoServiceProvider()
	{
		if (!Utils.HasAlgorithm(26115, 0))
		{
			throw new CryptographicException(Environment.GetResourceString("Cryptographic service provider (CSP) could not be found for this algorithm."));
		}
		FeedbackSizeValue = 8;
	}

	public override ICryptoTransform CreateEncryptor(byte[] rgbKey, byte[] rgbIV)
	{
		if (TripleDES.IsWeakKey(rgbKey))
		{
			throw new CryptographicException(Environment.GetResourceString("Specified key is a known weak key for '{0}' and cannot be used."), "TripleDES");
		}
		return new TripleDESTransform(this, encryption: true, rgbKey, rgbIV);
	}

	public override ICryptoTransform CreateDecryptor(byte[] rgbKey, byte[] rgbIV)
	{
		if (TripleDES.IsWeakKey(rgbKey))
		{
			throw new CryptographicException(Environment.GetResourceString("Specified key is a known weak key for '{0}' and cannot be used."), "TripleDES");
		}
		return new TripleDESTransform(this, encryption: false, rgbKey, rgbIV);
	}

	public override void GenerateKey()
	{
		KeyValue = new byte[KeySizeValue / 8];
		Utils.StaticRandomNumberGenerator.GetBytes(KeyValue);
		while (TripleDES.IsWeakKey(KeyValue))
		{
			Utils.StaticRandomNumberGenerator.GetBytes(KeyValue);
		}
	}

	public override void GenerateIV()
	{
		IVValue = new byte[8];
		Utils.StaticRandomNumberGenerator.GetBytes(IVValue);
	}
}
