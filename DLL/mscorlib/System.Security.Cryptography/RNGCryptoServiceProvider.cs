using System.Runtime.CompilerServices;

namespace System.Security.Cryptography;

public sealed class RNGCryptoServiceProvider : RandomNumberGenerator
{
	private static object _lock;

	private IntPtr _handle;

	static RNGCryptoServiceProvider()
	{
		if (RngOpen())
		{
			_lock = new object();
		}
	}

	public unsafe RNGCryptoServiceProvider()
	{
		_handle = RngInitialize(null, IntPtr.Zero);
		Check();
	}

	private void Check()
	{
		if (_handle == IntPtr.Zero)
		{
			throw new CryptographicException(Locale.GetText("Couldn't access random source."));
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool RngOpen();

	[MethodImpl((MethodImplOptions)4096)]
	private unsafe static extern IntPtr RngInitialize(byte* seed, IntPtr seed_length);

	[MethodImpl((MethodImplOptions)4096)]
	private unsafe static extern IntPtr RngGetBytes(IntPtr handle, byte* data, IntPtr data_length);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void RngClose(IntPtr handle);

	public unsafe override void GetBytes(byte[] data)
	{
		if (data == null)
		{
			throw new ArgumentNullException("data");
		}
		fixed (byte* data2 = data)
		{
			if (_lock == null)
			{
				_handle = RngGetBytes(_handle, data2, (IntPtr)data.LongLength);
			}
			else
			{
				lock (_lock)
				{
					_handle = RngGetBytes(_handle, data2, (IntPtr)data.LongLength);
				}
			}
		}
		Check();
	}

	~RNGCryptoServiceProvider()
	{
		if (_handle != IntPtr.Zero)
		{
			RngClose(_handle);
			_handle = IntPtr.Zero;
		}
	}

	protected override void Dispose(bool disposing)
	{
		base.Dispose(disposing);
	}
}
