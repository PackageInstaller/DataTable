using System.Runtime.InteropServices;

namespace System.Security.Cryptography;

[ComVisible(true)]
public sealed class DESCryptoServiceProvider : DES
{
	public DESCryptoServiceProvider()
	{
		if (!Utils.HasAlgorithm(26113, 0))
		{
			throw new CryptographicException(Environment.GetResourceString("Cryptographic service provider (CSP) could not be found for this algorithm."));
		}
		FeedbackSizeValue = 8;
	}

	public override ICryptoTransform CreateEncryptor(byte[] rgbKey, byte[] rgbIV)
	{
		if (DES.IsWeakKey(rgbKey))
		{
			throw new CryptographicException(Environment.GetResourceString("Specified key is a known weak key for '{0}' and cannot be used."), "DES");
		}
		if (DES.IsSemiWeakKey(rgbKey))
		{
			throw new CryptographicException(Environment.GetResourceString("Specified key is a known semi-weak key for '{0}' and cannot be used."), "DES");
		}
		return new DESTransform(this, encryption: true, rgbKey, rgbIV);
	}

	public override ICryptoTransform CreateDecryptor(byte[] rgbKey, byte[] rgbIV)
	{
		if (DES.IsWeakKey(rgbKey))
		{
			throw new CryptographicException(Environment.GetResourceString("Specified key is a known weak key for '{0}' and cannot be used."), "DES");
		}
		if (DES.IsSemiWeakKey(rgbKey))
		{
			throw new CryptographicException(Environment.GetResourceString("Specified key is a known semi-weak key for '{0}' and cannot be used."), "DES");
		}
		return new DESTransform(this, encryption: false, rgbKey, rgbIV);
	}

	public override void GenerateKey()
	{
		KeyValue = new byte[8];
		Utils.StaticRandomNumberGenerator.GetBytes(KeyValue);
		while (DES.IsWeakKey(KeyValue) || DES.IsSemiWeakKey(KeyValue))
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
