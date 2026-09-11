using System.Runtime.InteropServices;
using System.Runtime.Serialization;

namespace System.ComponentModel.Design;

[Serializable]
public class CheckoutException : ExternalException
{
	public static readonly CheckoutException Canceled = new CheckoutException("The checkout was canceled by the user.", -2147467260);

	public CheckoutException()
	{
	}

	public CheckoutException(string message, int errorCode)
		: base(message, errorCode)
	{
	}

	protected CheckoutException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
