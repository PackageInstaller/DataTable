using System;

namespace UnityEngine.ResourceManagement.Exceptions;

public class OperationException : Exception
{
	public OperationException(string message, Exception innerException = null)
		: base(message, innerException)
	{
	}

	public override string ToString()
	{
		return $"{GetType().Name} : {base.Message}\n{InnerException}";
	}
}
