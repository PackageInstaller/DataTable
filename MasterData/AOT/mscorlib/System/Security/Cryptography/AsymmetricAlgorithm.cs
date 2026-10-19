using System.Runtime.InteropServices;

namespace System.Security.Cryptography;

[ComVisible(true)]
public abstract class AsymmetricAlgorithm : IDisposable
{
	protected int KeySizeValue;

	protected KeySizes[] LegalKeySizesValue;

	public virtual int KeySize
	{
		get
		{
			return KeySizeValue;
		}
		set
		{
			for (int i = 0; i < LegalKeySizesValue.Length; i++)
			{
				if (LegalKeySizesValue[i].SkipSize == 0)
				{
					if (LegalKeySizesValue[i].MinSize == value)
					{
						KeySizeValue = value;
						return;
					}
					continue;
				}
				for (int j = LegalKeySizesValue[i].MinSize; j <= LegalKeySizesValue[i].MaxSize; j += LegalKeySizesValue[i].SkipSize)
				{
					if (j == value)
					{
						KeySizeValue = value;
						return;
					}
				}
			}
			throw new CryptographicException(Environment.GetResourceString("Specified key is not a valid size for this algorithm."));
		}
	}

	public void Dispose()
	{
		Clear();
	}

	public void Clear()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}

	protected virtual void Dispose(bool disposing)
	{
	}

	public virtual void FromXmlString(string xmlString)
	{
		throw new NotImplementedException();
	}

	public virtual string ToXmlString(bool includePrivateParameters)
	{
		throw new NotImplementedException();
	}
}
