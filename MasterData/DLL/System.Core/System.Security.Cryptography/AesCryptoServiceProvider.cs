using Mono.Security.Cryptography;

namespace System.Security.Cryptography;

public sealed class AesCryptoServiceProvider : Aes
{
	public override byte[] IV
	{
		get
		{
			return base.IV;
		}
		set
		{
			base.IV = value;
		}
	}

	public override byte[] Key
	{
		get
		{
			return base.Key;
		}
		set
		{
			base.Key = value;
		}
	}

	public override int KeySize
	{
		get
		{
			return base.KeySize;
		}
		set
		{
			base.KeySize = value;
		}
	}

	public override int FeedbackSize => base.FeedbackSize;

	public override CipherMode Mode
	{
		get
		{
			return base.Mode;
		}
		set
		{
			if (value == CipherMode.CTS)
			{
				throw new CryptographicException("CTS is not supported");
			}
			base.Mode = value;
		}
	}

	public override PaddingMode Padding
	{
		get
		{
			return base.Padding;
		}
		set
		{
			base.Padding = value;
		}
	}

	public AesCryptoServiceProvider()
	{
		FeedbackSizeValue = 8;
	}

	public override void GenerateIV()
	{
		IVValue = KeyBuilder.IV(BlockSizeValue >> 3);
	}

	public override void GenerateKey()
	{
		KeyValue = KeyBuilder.Key(KeySizeValue >> 3);
	}

	public override ICryptoTransform CreateDecryptor(byte[] key, byte[] iv)
	{
		if (Mode == CipherMode.CFB && FeedbackSize > 64)
		{
			throw new CryptographicException("CFB with Feedbaack > 64 bits");
		}
		return new AesTransform(this, encryption: false, key, iv);
	}

	public override ICryptoTransform CreateEncryptor(byte[] key, byte[] iv)
	{
		if (Mode == CipherMode.CFB && FeedbackSize > 64)
		{
			throw new CryptographicException("CFB with Feedbaack > 64 bits");
		}
		return new AesTransform(this, encryption: true, key, iv);
	}

	public override ICryptoTransform CreateDecryptor()
	{
		return CreateDecryptor(Key, IV);
	}

	public override ICryptoTransform CreateEncryptor()
	{
		return CreateEncryptor(Key, IV);
	}

	protected override void Dispose(bool disposing)
	{
		base.Dispose(disposing);
	}
}
