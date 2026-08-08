using System.Runtime.InteropServices;

namespace System.Security.Cryptography;

[ComVisible(true)]
public abstract class SHA1 : HashAlgorithm
{
	protected SHA1()
	{
		HashSizeValue = 160;
	}

	public new static SHA1 Create()
	{
		return new SHA1CryptoServiceProvider();
	}
}
