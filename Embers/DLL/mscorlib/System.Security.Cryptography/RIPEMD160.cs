using System.Runtime.InteropServices;

namespace System.Security.Cryptography;

[ComVisible(true)]
public abstract class RIPEMD160 : HashAlgorithm
{
	protected RIPEMD160()
	{
		HashSizeValue = 160;
	}

	public new static RIPEMD160 Create()
	{
		return new RIPEMD160Managed();
	}
}
