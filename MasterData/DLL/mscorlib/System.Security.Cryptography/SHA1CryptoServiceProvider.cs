using System.Runtime.InteropServices;

namespace System.Security.Cryptography;

[ComVisible(true)]
public sealed class SHA1CryptoServiceProvider : SHA1
{
	private SHA1Internal sha;

	public SHA1CryptoServiceProvider()
	{
		sha = new SHA1Internal();
	}

	~SHA1CryptoServiceProvider()
	{
		Dispose(disposing: false);
	}

	protected override void Dispose(bool disposing)
	{
		base.Dispose(disposing);
	}

	protected override void HashCore(byte[] rgb, int ibStart, int cbSize)
	{
		State = 1;
		sha.HashCore(rgb, ibStart, cbSize);
	}

	protected override byte[] HashFinal()
	{
		State = 0;
		return sha.HashFinal();
	}

	public override void Initialize()
	{
		sha.Initialize();
	}
}
