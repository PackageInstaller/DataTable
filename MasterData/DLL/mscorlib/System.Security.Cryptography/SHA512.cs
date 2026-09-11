using System.Runtime.InteropServices;

namespace System.Security.Cryptography;

[ComVisible(true)]
public abstract class SHA512 : HashAlgorithm
{
	protected SHA512()
	{
		HashSizeValue = 512;
	}

	public new static SHA512 Create()
	{
		return new SHA512Managed();
	}
}
