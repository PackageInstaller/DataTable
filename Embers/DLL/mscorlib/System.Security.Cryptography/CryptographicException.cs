using System.Globalization;
using System.Runtime.InteropServices;
using System.Runtime.Serialization;

namespace System.Security.Cryptography;

[Serializable]
[ComVisible(true)]
public class CryptographicException : SystemException
{
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

	protected CryptographicException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
