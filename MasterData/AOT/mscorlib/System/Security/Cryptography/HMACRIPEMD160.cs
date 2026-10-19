using System.Runtime.InteropServices;

namespace System.Security.Cryptography;

[ComVisible(true)]
public class HMACRIPEMD160 : HMAC
{
	public HMACRIPEMD160()
		: this(Utils.GenerateRandom(64))
	{
	}

	public HMACRIPEMD160(byte[] key)
	{
		m_hashName = "RIPEMD160";
		m_hash1 = new RIPEMD160Managed();
		m_hash2 = new RIPEMD160Managed();
		HashSizeValue = 160;
		InitializeKey(key);
	}
}
