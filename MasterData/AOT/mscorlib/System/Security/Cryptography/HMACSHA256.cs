using System.Runtime.InteropServices;

namespace System.Security.Cryptography;

[ComVisible(true)]
public class HMACSHA256 : HMAC
{
	public HMACSHA256()
		: this(Utils.GenerateRandom(64))
	{
	}

	public HMACSHA256(byte[] key)
	{
		m_hashName = "SHA256";
		m_hash1 = new SHA256Managed();
		m_hash2 = new SHA256Managed();
		HashSizeValue = 256;
		InitializeKey(key);
	}
}
