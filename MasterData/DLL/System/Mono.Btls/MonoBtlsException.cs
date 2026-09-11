using System;

namespace Mono.Btls;

internal class MonoBtlsException : Exception
{
	public MonoBtlsException()
	{
	}

	public MonoBtlsException(MonoBtlsSslError error)
		: base(error.ToString())
	{
	}

	public MonoBtlsException(string message)
		: base(message)
	{
	}

	public MonoBtlsException(string format, params object[] args)
		: base(string.Format(format, args))
	{
	}
}
