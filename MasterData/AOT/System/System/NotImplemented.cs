namespace System;

internal static class NotImplemented
{
	internal static Exception ByDesignWithMessage(string message)
	{
		return new NotImplementedException(message);
	}
}
