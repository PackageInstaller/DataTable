using System.Runtime.InteropServices;

namespace System.Security.Cryptography;

[ComVisible(true)]
public class RSAPKCS1KeyExchangeDeformatter : AsymmetricKeyExchangeDeformatter
{
	private RSA _rsaKey;

	private bool? _rsaOverridesDecrypt;

	private bool OverridesDecrypt
	{
		get
		{
			if (!_rsaOverridesDecrypt.HasValue)
			{
				_rsaOverridesDecrypt = Utils.DoesRsaKeyOverride(_rsaKey, "Decrypt", new Type[2]
				{
					typeof(byte[]),
					typeof(RSAEncryptionPadding)
				});
			}
			return _rsaOverridesDecrypt.Value;
		}
	}

	public RSAPKCS1KeyExchangeDeformatter(AsymmetricAlgorithm key)
	{
		if (key == null)
		{
			throw new ArgumentNullException("key");
		}
		_rsaKey = (RSA)key;
	}

	public override byte[] DecryptKeyExchange(byte[] rgbIn)
	{
		if (_rsaKey == null)
		{
			throw new CryptographicUnexpectedOperationException(Environment.GetResourceString("No asymmetric key object has been associated with this formatter object."));
		}
		byte[] array;
		if (OverridesDecrypt)
		{
			array = _rsaKey.Decrypt(rgbIn, RSAEncryptionPadding.Pkcs1);
		}
		else
		{
			byte[] array2 = _rsaKey.DecryptValue(rgbIn);
			int i;
			for (i = 2; i < array2.Length && array2[i] != 0; i++)
			{
			}
			if (i >= array2.Length)
			{
				throw new CryptographicUnexpectedOperationException(Environment.GetResourceString("Error occurred while decoding PKCS1 padding."));
			}
			i++;
			array = new byte[array2.Length - i];
			Buffer.InternalBlockCopy(array2, i, array, 0, array.Length);
		}
		return array;
	}
}
