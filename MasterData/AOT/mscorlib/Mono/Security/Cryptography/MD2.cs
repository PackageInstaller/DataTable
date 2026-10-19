using System.Security.Cryptography;

namespace Mono.Security.Cryptography;

internal abstract class MD2 : HashAlgorithm
{
	protected MD2()
	{
		HashSizeValue = 128;
	}

	public new static MD2 Create()
	{
		return new MD2Managed();
	}
}
