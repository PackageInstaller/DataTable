using System;

namespace GameFramework.Network;

public class CodecException : Exception
{
	public CodecException()
	{
	}

	public CodecException(string message)
		: base(message)
	{
	}

	public CodecException(string message, Exception exception)
		: base(message, exception)
	{
	}

	public CodecException(string format, params object[] arguments)
		: base(string.Format(format, arguments))
	{
	}

	public CodecException(Exception exception, string format, params object[] arguments)
		: base(string.Format(format, arguments), exception)
	{
	}
}
