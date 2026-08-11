using System;

namespace Cysharp.Threading.Tasks;

public class ChannelClosedException : InvalidOperationException
{
	public ChannelClosedException()
		: base("Channel is already closed.")
	{
	}

	public ChannelClosedException(string message)
		: base(message)
	{
	}

	public ChannelClosedException(Exception innerException)
		: base("Channel is already closed", innerException)
	{
	}

	public ChannelClosedException(string message, Exception innerException)
		: base(message, innerException)
	{
	}
}
