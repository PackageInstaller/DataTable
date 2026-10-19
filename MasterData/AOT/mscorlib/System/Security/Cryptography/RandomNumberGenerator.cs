using System.Runtime.InteropServices;

namespace System.Security.Cryptography;

[ComVisible(true)]
public abstract class RandomNumberGenerator : IDisposable
{
	public static RandomNumberGenerator Create()
	{
		return new RNGCryptoServiceProvider();
	}

	public void Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}

	protected virtual void Dispose(bool disposing)
	{
	}

	public abstract void GetBytes(byte[] data);

	public static void Fill(Span<byte> data)
	{
		FillSpan(data);
	}

	internal unsafe static void FillSpan(Span<byte> data)
	{
		if (data.Length > 0)
		{
			fixed (byte* buffer = data)
			{
				Interop.GetRandomBytes(buffer, data.Length);
			}
		}
	}
}
