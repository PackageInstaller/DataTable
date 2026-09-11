using System.Runtime.InteropServices;

namespace System.Security.Cryptography;

[ComVisible(true)]
public abstract class SHA384 : HashAlgorithm
{
	protected SHA384()
	{
		HashSizeValue = 384;
	}

	public new static SHA384 Create()
	{
		return new SHA384Managed();
	}
}
