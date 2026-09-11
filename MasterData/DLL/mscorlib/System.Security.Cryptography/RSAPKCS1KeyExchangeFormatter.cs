using System.Runtime.InteropServices;

namespace System.Security.Cryptography;

[ComVisible(true)]
public class RSAPKCS1KeyExchangeFormatter : AsymmetricKeyExchangeFormatter
{
	private RandomNumberGenerator RngValue;

	private RSA _rsaKey;

	private bool? _rsaOverridesEncrypt;

	public RandomNumberGenerator Rng => RngValue;

	private bool OverridesEncrypt
	{
		get
		{
			if (!_rsaOverridesEncrypt.HasValue)
			{
				_rsaOverridesEncrypt = Utils.DoesRsaKeyOverride(_rsaKey, "Encrypt", new Type[2]
				{
					typeof(byte[]),
					typeof(RSAEncryptionPadding)
				});
			}
			return _rsaOverridesEncrypt.Value;
		}
	}

	public RSAPKCS1KeyExchangeFormatter(AsymmetricAlgorithm key)
	{
		if (key == null)
		{
			throw new ArgumentNullException("key");
		}
		_rsaKey = (RSA)key;
	}

	public override byte[] CreateKeyExchange(byte[] rgbData)
	{
		if (rgbData == null)
		{
			throw new ArgumentNullException("rgbData");
		}
		if (_rsaKey == null)
		{
			throw new CryptographicUnexpectedOperationException(Environment.GetResourceString("No asymmetric key object has been associated with this formatter object."));
		}
		if (OverridesEncrypt)
		{
			return _rsaKey.Encrypt(rgbData, RSAEncryptionPadding.Pkcs1);
		}
		int num = _rsaKey.KeySize / 8;
		if (rgbData.Length + 11 > num)
		{
			throw new CryptographicException(Environment.GetResourceString("The data to be encrypted exceeds the maximum for this modulus of {0} bytes.", num - 11));
		}
		byte[] array = new byte[num];
		if (RngValue == null)
		{
			RngValue = RandomNumberGenerator.Create();
		}
		Rng.GetNonZeroBytes(array);
		array[0] = 0;
		array[1] = 2;
		array[num - rgbData.Length - 1] = 0;
		Buffer.InternalBlockCopy(rgbData, 0, array, num - rgbData.Length, rgbData.Length);
		return _rsaKey.EncryptValue(array);
	}
}
