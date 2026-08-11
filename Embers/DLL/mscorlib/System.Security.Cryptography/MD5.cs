using System.Runtime.InteropServices;

namespace System.Security.Cryptography;

[ComVisible(true)]
public abstract class MD5 : HashAlgorithm
{
	protected MD5()
	{
		HashSizeValue = 128;
	}

	public new static MD5 Create()
	{
		return new MD5CryptoServiceProvider();
	}
}
