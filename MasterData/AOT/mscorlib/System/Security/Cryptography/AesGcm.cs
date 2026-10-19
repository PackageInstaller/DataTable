namespace System.Security.Cryptography;

public sealed class AesGcm : IDisposable
{
	public AesGcm(byte[] key)
	{
		throw new PlatformNotSupportedException();
	}

	public void Decrypt(ReadOnlySpan<byte> nonce, ReadOnlySpan<byte> ciphertext, ReadOnlySpan<byte> tag, Span<byte> plaintext, ReadOnlySpan<byte> associatedData = default(ReadOnlySpan<byte>))
	{
		throw new PlatformNotSupportedException();
	}

	public void Dispose()
	{
	}

	public void Encrypt(byte[] nonce, byte[] plaintext, byte[] ciphertext, byte[] tag, byte[] associatedData = null)
	{
		throw new PlatformNotSupportedException();
	}
}
