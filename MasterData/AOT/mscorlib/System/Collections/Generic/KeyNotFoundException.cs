using System.Runtime.Serialization;

namespace System.Collections.Generic;

[Serializable]
public class KeyNotFoundException : SystemException
{
	public KeyNotFoundException()
		: base("The given key was not present in the dictionary.")
	{
		HResult = -2146232969;
	}

	public KeyNotFoundException(string message)
		: base(message)
	{
		HResult = -2146232969;
	}

	protected KeyNotFoundException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
