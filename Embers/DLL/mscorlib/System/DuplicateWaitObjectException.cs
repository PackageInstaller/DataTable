using System.Runtime.Serialization;

namespace System;

[Serializable]
public class DuplicateWaitObjectException : ArgumentException
{
	private static volatile string s_duplicateWaitObjectMessage;

	private static string DuplicateWaitObjectMessage
	{
		get
		{
			if (s_duplicateWaitObjectMessage == null)
			{
				s_duplicateWaitObjectMessage = "Duplicate objects in argument.";
			}
			return s_duplicateWaitObjectMessage;
		}
	}

	public DuplicateWaitObjectException()
		: base(DuplicateWaitObjectMessage)
	{
		base.HResult = -2146233047;
	}

	protected DuplicateWaitObjectException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
