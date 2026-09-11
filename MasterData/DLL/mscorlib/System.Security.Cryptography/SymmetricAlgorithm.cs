using System.Runtime.InteropServices;

namespace System.Security.Cryptography;

[ComVisible(true)]
public abstract class SymmetricAlgorithm : IDisposable
{
	protected int BlockSizeValue;

	protected int FeedbackSizeValue;

	protected byte[] IVValue;

	protected byte[] KeyValue;

	protected KeySizes[] LegalBlockSizesValue;

	protected KeySizes[] LegalKeySizesValue;

	protected int KeySizeValue;

	protected CipherMode ModeValue;

	protected PaddingMode PaddingValue;

	public virtual int BlockSize
	{
		get
		{
			return BlockSizeValue;
		}
		set
		{
			for (int i = 0; i < LegalBlockSizesValue.Length; i++)
			{
				if (LegalBlockSizesValue[i].SkipSize == 0)
				{
					if (LegalBlockSizesValue[i].MinSize == value)
					{
						BlockSizeValue = value;
						IVValue = null;
						return;
					}
					continue;
				}
				for (int j = LegalBlockSizesValue[i].MinSize; j <= LegalBlockSizesValue[i].MaxSize; j += LegalBlockSizesValue[i].SkipSize)
				{
					if (j == value)
					{
						if (BlockSizeValue != value)
						{
							BlockSizeValue = value;
							IVValue = null;
						}
						return;
					}
				}
			}
			throw new CryptographicException(Environment.GetResourceString("Specified block size is not valid for this algorithm."));
		}
	}

	public virtual int FeedbackSize => FeedbackSizeValue;

	public virtual byte[] IV
	{
		get
		{
			if (IVValue == null)
			{
				GenerateIV();
			}
			return (byte[])IVValue.Clone();
		}
		set
		{
			if (value == null)
			{
				throw new ArgumentNullException("value");
			}
			if (value.Length != BlockSizeValue / 8)
			{
				throw new CryptographicException(Environment.GetResourceString("Specified initialization vector (IV) does not match the block size for this algorithm."));
			}
			IVValue = (byte[])value.Clone();
		}
	}

	public virtual byte[] Key
	{
		get
		{
			if (KeyValue == null)
			{
				GenerateKey();
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
			KeyValue = (byte[])value.Clone();
			KeySizeValue = value.Length * 8;
		}
	}

	public virtual KeySizes[] LegalBlockSizes => (KeySizes[])LegalBlockSizesValue.Clone();

	public virtual KeySizes[] LegalKeySizes => (KeySizes[])LegalKeySizesValue.Clone();

	public virtual int KeySize
	{
		get
		{
			return KeySizeValue;
		}
		set
		{
			if (!ValidKeySize(value))
			{
				throw new CryptographicException(Environment.GetResourceString("Specified key is not a valid size for this algorithm."));
			}
			KeySizeValue = value;
			KeyValue = null;
		}
	}

	public virtual CipherMode Mode
	{
		get
		{
			return ModeValue;
		}
		set
		{
			if (value < CipherMode.CBC || CipherMode.CFB < value)
			{
				throw new CryptographicException(Environment.GetResourceString("Specified cipher mode is not valid for this algorithm."));
			}
			ModeValue = value;
		}
	}

	public virtual PaddingMode Padding
	{
		get
		{
			return PaddingValue;
		}
		set
		{
			if (value < PaddingMode.None || PaddingMode.ISO10126 < value)
			{
				throw new CryptographicException(Environment.GetResourceString("Specified padding mode is not valid for this algorithm."));
			}
			PaddingValue = value;
		}
	}

	protected SymmetricAlgorithm()
	{
		ModeValue = CipherMode.CBC;
		PaddingValue = PaddingMode.PKCS7;
	}

	public void Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}

	public void Clear()
	{
		((IDisposable)this).Dispose();
	}

	protected virtual void Dispose(bool disposing)
	{
		if (disposing)
		{
			if (KeyValue != null)
			{
				Array.Clear(KeyValue, 0, KeyValue.Length);
				KeyValue = null;
			}
			if (IVValue != null)
			{
				Array.Clear(IVValue, 0, IVValue.Length);
				IVValue = null;
			}
		}
	}

	public bool ValidKeySize(int bitLength)
	{
		KeySizes[] legalKeySizes = LegalKeySizes;
		if (legalKeySizes == null)
		{
			return false;
		}
		for (int i = 0; i < legalKeySizes.Length; i++)
		{
			if (legalKeySizes[i].SkipSize == 0)
			{
				if (legalKeySizes[i].MinSize == bitLength)
				{
					return true;
				}
				continue;
			}
			for (int j = legalKeySizes[i].MinSize; j <= legalKeySizes[i].MaxSize; j += legalKeySizes[i].SkipSize)
			{
				if (j == bitLength)
				{
					return true;
				}
			}
		}
		return false;
	}

	public static SymmetricAlgorithm Create(string algName)
	{
		return (SymmetricAlgorithm)CryptoConfig.CreateFromName(algName);
	}

	public virtual ICryptoTransform CreateEncryptor()
	{
		return CreateEncryptor(Key, IV);
	}

	public abstract ICryptoTransform CreateEncryptor(byte[] rgbKey, byte[] rgbIV);

	public virtual ICryptoTransform CreateDecryptor()
	{
		return CreateDecryptor(Key, IV);
	}

	public abstract ICryptoTransform CreateDecryptor(byte[] rgbKey, byte[] rgbIV);

	public abstract void GenerateKey();

	public abstract void GenerateIV();
}
