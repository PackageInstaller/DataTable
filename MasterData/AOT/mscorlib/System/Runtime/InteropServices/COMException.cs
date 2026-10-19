using System.Globalization;
using System.Runtime.Serialization;

namespace System.Runtime.InteropServices;

[Serializable]
public class COMException : ExternalException
{
	public COMException()
	{
	}

	public COMException(string message, int errorCode)
		: base(message)
	{
		HResult = errorCode;
	}

	protected COMException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}

	public override string ToString()
	{
		string message = Message;
		string text = GetType().ToString() + " (0x" + HResult.ToString("X8", CultureInfo.InvariantCulture) + ")";
		if (message != null && message.Length > 0)
		{
			text = text + ": " + message;
		}
		Exception innerException = InnerException;
		if (innerException != null)
		{
			text = text + " ---> " + innerException.ToString();
		}
		if (StackTrace != null)
		{
			text = text + Environment.NewLine + StackTrace;
		}
		return text;
	}
}
