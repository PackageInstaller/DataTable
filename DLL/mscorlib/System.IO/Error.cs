namespace System.IO;

internal static class Error
{
	internal static Exception GetStreamIsClosed()
	{
		return new ObjectDisposedException(null, "Cannot access a closed Stream.");
	}

	internal static Exception GetEndOfFile()
	{
		return new EndOfStreamException("Unable to read beyond the end of the stream.");
	}

	internal static Exception GetReadNotSupported()
	{
		return new NotSupportedException("Stream does not support reading.");
	}

	internal static Exception GetWriteNotSupported()
	{
		return new NotSupportedException("Stream does not support writing.");
	}
}
