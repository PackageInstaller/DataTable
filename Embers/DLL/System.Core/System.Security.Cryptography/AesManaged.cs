namespace System.Security.Cryptography;

public sealed class AesManaged : Aes
{
	private RijndaelManaged m_rijndael;

	public override int FeedbackSize
	{
		get
		{
			return m_rijndael.FeedbackSize;
		}
		set
		{
			m_rijndael.FeedbackSize = value;
		}
	}

	public override byte[] IV
	{
		get
		{
			return m_rijndael.IV;
		}
		set
		{
			m_rijndael.IV = value;
		}
	}

	public override byte[] Key
	{
		get
		{
			return m_rijndael.Key;
		}
		set
		{
			m_rijndael.Key = value;
		}
	}

	public override int KeySize
	{
		get
		{
			return m_rijndael.KeySize;
		}
		set
		{
			m_rijndael.KeySize = value;
		}
	}

	public override CipherMode Mode
	{
		get
		{
			return m_rijndael.Mode;
		}
		set
		{
			if (value == CipherMode.CFB || value == CipherMode.OFB)
			{
				throw new CryptographicException(SR.GetString("Specified cipher mode is not valid for this algorithm."));
			}
			m_rijndael.Mode = value;
		}
	}

	public override PaddingMode Padding
	{
		get
		{
			return m_rijndael.Padding;
		}
		set
		{
			m_rijndael.Padding = value;
		}
	}

	public AesManaged()
	{
		if (CryptoConfig.AllowOnlyFipsAlgorithms)
		{
			throw new InvalidOperationException(SR.GetString("This implementation is not part of the Windows Platform FIPS validated cryptographic algorithms."));
		}
		m_rijndael = new RijndaelManaged();
		m_rijndael.BlockSize = BlockSize;
		m_rijndael.KeySize = KeySize;
	}

	public override ICryptoTransform CreateDecryptor()
	{
		return m_rijndael.CreateDecryptor();
	}

	public override ICryptoTransform CreateDecryptor(byte[] key, byte[] iv)
	{
		if (key == null)
		{
			throw new ArgumentNullException("key");
		}
		if (!ValidKeySize(key.Length * 8))
		{
			throw new ArgumentException(SR.GetString("Specified key is not a valid size for this algorithm."), "key");
		}
		if (iv != null && iv.Length * 8 != BlockSizeValue)
		{
			throw new ArgumentException(SR.GetString("Specified initialization vector (IV) does not match the block size for this algorithm."), "iv");
		}
		return m_rijndael.CreateDecryptor(key, iv);
	}

	public override ICryptoTransform CreateEncryptor()
	{
		return m_rijndael.CreateEncryptor();
	}

	public override ICryptoTransform CreateEncryptor(byte[] key, byte[] iv)
	{
		if (key == null)
		{
			throw new ArgumentNullException("key");
		}
		if (!ValidKeySize(key.Length * 8))
		{
			throw new ArgumentException(SR.GetString("Specified key is not a valid size for this algorithm."), "key");
		}
		if (iv != null && iv.Length * 8 != BlockSizeValue)
		{
			throw new ArgumentException(SR.GetString("Specified initialization vector (IV) does not match the block size for this algorithm."), "iv");
		}
		return m_rijndael.CreateEncryptor(key, iv);
	}

	protected override void Dispose(bool disposing)
	{
		try
		{
			if (disposing)
			{
				((IDisposable)m_rijndael).Dispose();
			}
		}
		finally
		{
			base.Dispose(disposing);
		}
	}

	public override void GenerateIV()
	{
		m_rijndael.GenerateIV();
	}

	public override void GenerateKey()
	{
		m_rijndael.GenerateKey();
	}
}
