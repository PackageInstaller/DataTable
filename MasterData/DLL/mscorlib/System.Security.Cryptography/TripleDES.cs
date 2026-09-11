using System.Runtime.InteropServices;

namespace System.Security.Cryptography;

[ComVisible(true)]
public abstract class TripleDES : SymmetricAlgorithm
{
	private static KeySizes[] s_legalBlockSizes = new KeySizes[1]
	{
		new KeySizes(64, 64, 0)
	};

	private static KeySizes[] s_legalKeySizes = new KeySizes[1]
	{
		new KeySizes(128, 192, 64)
	};

	public override byte[] Key
	{
		get
		{
			if (KeyValue == null)
			{
				do
				{
					GenerateKey();
				}
				while (IsWeakKey(KeyValue));
			}
			return (byte[])KeyValue.Clone();
		}
		set
		{
			if (value == null)
			{
				throw new ArgumentNullException("value");
			}
			if (!ValidKeySize(value.Length * 8))
			{
				throw new CryptographicException(Environment.GetResourceString("Specified key is not a valid size for this algorithm."));
			}
			if (IsWeakKey(value))
			{
				throw new CryptographicException(Environment.GetResourceString("Specified key is a known weak key for '{0}' and cannot be used."), "TripleDES");
			}
			KeyValue = (byte[])value.Clone();
			KeySizeValue = value.Length * 8;
		}
	}

	protected TripleDES()
	{
		KeySizeValue = 192;
		BlockSizeValue = 64;
		FeedbackSizeValue = BlockSizeValue;
		LegalBlockSizesValue = s_legalBlockSizes;
		LegalKeySizesValue = s_legalKeySizes;
	}

	public static TripleDES Create()
	{
		return new TripleDESCryptoServiceProvider();
	}

	public static bool IsWeakKey(byte[] rgbKey)
	{
		if (!IsLegalKeySize(rgbKey))
		{
			throw new CryptographicException(Environment.GetResourceString("Specified key is not a valid size for this algorithm."));
		}
		byte[] array = Utils.FixupKeyParity(rgbKey);
		if (EqualBytes(array, 0, 8, 8))
		{
			return true;
		}
		if (array.Length == 24 && EqualBytes(array, 8, 16, 8))
		{
			return true;
		}
		return false;
	}

	private static bool EqualBytes(byte[] rgbKey, int start1, int start2, int count)
	{
		if (start1 < 0)
		{
			throw new ArgumentOutOfRangeException("start1", Environment.GetResourceString("Non-negative number required."));
		}
		if (start2 < 0)
		{
			throw new ArgumentOutOfRangeException("start2", Environment.GetResourceString("Non-negative number required."));
		}
		if (start1 + count > rgbKey.Length)
		{
			throw new ArgumentException(Environment.GetResourceString("Value was invalid."));
		}
		if (start2 + count > rgbKey.Length)
		{
			throw new ArgumentException(Environment.GetResourceString("Value was invalid."));
		}
		for (int i = 0; i < count; i++)
		{
			if (rgbKey[start1 + i] != rgbKey[start2 + i])
			{
				return false;
			}
		}
		return true;
	}

	private static bool IsLegalKeySize(byte[] rgbKey)
	{
		if (rgbKey != null && (rgbKey.Length == 16 || rgbKey.Length == 24))
		{
			return true;
		}
		return false;
	}
}
