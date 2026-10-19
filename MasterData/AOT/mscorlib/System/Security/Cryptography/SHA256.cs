using System.Runtime.InteropServices;

namespace System.Security.Cryptography;

[ComVisible(true)]
public abstract class SHA256 : HashAlgorithm
{
	protected SHA256()
	{
		HashSizeValue = 256;
	}

	public new static SHA256 Create()
	{
		return new SHA256Managed();
	}

	public new static SHA256 Create(string hashName)
	{
		return (SHA256)CryptoConfig.CreateFromName(hashName);
	}
}
