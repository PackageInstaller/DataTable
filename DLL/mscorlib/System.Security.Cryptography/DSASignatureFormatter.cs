using System.Runtime.InteropServices;

namespace System.Security.Cryptography;

[ComVisible(true)]
public class DSASignatureFormatter : AsymmetricSignatureFormatter
{
	private string _oid;

	public DSASignatureFormatter()
	{
		_oid = CryptoConfig.MapNameToOID("SHA1");
	}
}
