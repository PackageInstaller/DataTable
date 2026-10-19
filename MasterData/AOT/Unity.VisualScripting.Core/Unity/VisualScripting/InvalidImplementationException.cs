using System;

namespace Unity.VisualScripting;

public class InvalidImplementationException : Exception
{
	public InvalidImplementationException()
	{
	}

	public InvalidImplementationException(string message)
		: base(message)
	{
	}
}
