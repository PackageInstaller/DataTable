using System.Globalization;
using System.Runtime.Serialization;

namespace System.Runtime.InteropServices;

[Serializable]
public class ExternalException : SystemException
{
	public virtual int ErrorCode => HResult;

	public ExternalException()
		: base("External component has thrown an exception.")
	{
		HResult = -2147467259;
	}

	public ExternalException(string message)
		: base(message)
	{
		HResult = -2147467259;
	}

	public ExternalException(string message, int errorCode)
		: base(message)
	{
		HResult = errorCode;
	}

	protected ExternalException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}

	public override string ToString()
	{
		string message = Message;
		string text = GetType().ToString() + " (0x" + HResult.ToString("X8", CultureInfo.InvariantCulture) + ")";
		if (!string.IsNullOrEmpty(message))
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
