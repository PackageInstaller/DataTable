namespace System.Security;

[MonoTODO("work in progress - encryption is missing")]
public sealed class SecureString : IDisposable
{
	private int length;

	private bool disposed;

	private byte[] data;

	public int Length
	{
		get
		{
			if (disposed)
			{
				throw new ObjectDisposedException("SecureString");
			}
			return length;
		}
	}

	public SecureString()
	{
		Alloc(8, realloc: false);
	}

	[CLSCompliant(false)]
	public unsafe SecureString(char* value, int length)
	{
		if (value == null)
		{
			throw new ArgumentNullException("value");
		}
		if (length < 0 || length > 65536)
		{
			throw new ArgumentOutOfRangeException("length", "< 0 || > 65536");
		}
		this.length = length;
		Alloc(length, realloc: false);
		int num = 0;
		for (int i = 0; i < length; i++)
		{
			char c = *(value++);
			data[num++] = (byte)((int)c >> 8);
			data[num++] = (byte)c;
		}
		Encrypt();
	}

	public void Dispose()
	{
		disposed = true;
		if (data != null)
		{
			Array.Clear(data, 0, data.Length);
			data = null;
		}
		length = 0;
	}

	private void Encrypt()
	{
		if (data != null)
		{
			_ = data.LongLength;
		}
	}

	private void Decrypt()
	{
		if (data != null)
		{
			_ = data.LongLength;
		}
	}

	private void Alloc(int length, bool realloc)
	{
		if (length < 0 || length > 65536)
		{
			throw new ArgumentOutOfRangeException("length", "< 0 || > 65536");
		}
		int num = (length >> 3) + (((length & 7) != 0) ? 1 : 0) << 4;
		if (!realloc || data == null || num != data.Length)
		{
			if (realloc)
			{
				byte[] array = new byte[num];
				Array.Copy(data, 0, array, 0, Math.Min(data.Length, array.Length));
				Array.Clear(data, 0, data.Length);
				data = array;
			}
			else
			{
				data = new byte[num];
			}
		}
	}

	internal byte[] GetBuffer()
	{
		byte[] array = new byte[length << 1];
		try
		{
			Decrypt();
			Buffer.BlockCopy(data, 0, array, 0, array.Length);
			return array;
		}
		finally
		{
			Encrypt();
		}
	}
}
