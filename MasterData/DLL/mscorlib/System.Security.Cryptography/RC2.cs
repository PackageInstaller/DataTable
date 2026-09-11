using System.Runtime.InteropServices;

namespace System.Security.Cryptography;

[ComVisible(true)]
public abstract class RC2 : SymmetricAlgorithm
{
	protected int EffectiveKeySizeValue;

	private static KeySizes[] s_legalBlockSizes = new KeySizes[1]
	{
		new KeySizes(64, 64, 0)
	};

	private static KeySizes[] s_legalKeySizes = new KeySizes[1]
	{
		new KeySizes(40, 1024, 8)
	};

	public virtual int EffectiveKeySize
	{
		get
		{
			if (EffectiveKeySizeValue == 0)
			{
				return KeySizeValue;
			}
			return EffectiveKeySizeValue;
		}
	}

	public override int KeySize
	{
		get
		{
			return KeySizeValue;
		}
		set
		{
			if (value < EffectiveKeySizeValue)
			{
				throw new CryptographicException(Environment.GetResourceString("EffectiveKeySize value must be at least as large as the KeySize value."));
			}
			base.KeySize = value;
		}
	}

	protected RC2()
	{
		KeySizeValue = 128;
		BlockSizeValue = 64;
		FeedbackSizeValue = BlockSizeValue;
		LegalBlockSizesValue = s_legalBlockSizes;
		LegalKeySizesValue = s_legalKeySizes;
	}
}
