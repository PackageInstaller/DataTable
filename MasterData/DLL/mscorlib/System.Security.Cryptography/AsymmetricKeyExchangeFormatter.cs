using System.Runtime.InteropServices;

namespace System.Security.Cryptography;

[ComVisible(true)]
public abstract class AsymmetricKeyExchangeFormatter
{
	public abstract byte[] CreateKeyExchange(byte[] data);
}
