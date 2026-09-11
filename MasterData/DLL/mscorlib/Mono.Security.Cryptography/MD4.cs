using System.Security.Cryptography;

namespace Mono.Security.Cryptography;

internal abstract class MD4 : HashAlgorithm
{
	protected MD4()
	{
		HashSizeValue = 128;
	}

	public new static MD4 Create()
	{
		return new MD4Managed();
	}
}
