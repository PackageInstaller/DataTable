using System.Globalization;
using System.Runtime.InteropServices;
using System.Runtime.Serialization;
using Microsoft.Win32;

namespace System.Security.Cryptography;

[Serializable]
[ComVisible(true)]
public class CryptographicException : SystemException
{
	private const int FORMAT_MESSAGE_IGNORE_INSERTS = 512;

	private const int FORMAT_MESSAGE_FROM_SYSTEM = 4096;

	private const int FORMAT_MESSAGE_ARGUMENT_ARRAY = 8192;

	public CryptographicException()
		: base(Environment.GetResourceString("Error occurred during a cryptographic operation."))
	{
		SetErrorCode(-2146233296);
	}

	public CryptographicException(string message)
		: base(message)
	{
		SetErrorCode(-2146233296);
	}

	public CryptographicException(string format, string insert)
		: base(string.Format(CultureInfo.CurrentCulture, format, insert))
	{
		SetErrorCode(-2146233296);
	}

	public CryptographicException(string message, Exception inner)
		: base(message, inner)
	{
		SetErrorCode(-2146233296);
	}

	public CryptographicException(int hr)
		: this(Win32Native.GetMessage(hr))
	{
		if ((hr & 0x80000000u) != 2147483648u)
		{
			hr = (hr & 0xFFFF) | -2147024896;
		}
		SetErrorCode(hr);
	}

	protected CryptographicException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}

	private static void ThrowCryptographicException(int hr)
	{
		throw new CryptographicException(hr);
	}
}
