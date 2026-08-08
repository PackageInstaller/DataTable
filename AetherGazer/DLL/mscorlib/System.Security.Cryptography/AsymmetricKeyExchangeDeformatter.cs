using System.Runtime.InteropServices;

namespace System.Security.Cryptography;

[ComVisible(true)]
public abstract class AsymmetricKeyExchangeDeformatter
{
	public abstract byte[] DecryptKeyExchange(byte[] rgb);
}
