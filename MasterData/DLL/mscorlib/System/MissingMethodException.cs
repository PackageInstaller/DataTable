using System.Runtime.Serialization;

namespace System;

[Serializable]
public class MissingMethodException : MissingMemberException
{
	public override string Message
	{
		get
		{
			if (ClassName != null)
			{
				return SR.Format("Method '{0}' not found.", ClassName + "." + MemberName + ((Signature != null) ? (" " + MissingMemberException.FormatSignature(Signature)) : string.Empty));
			}
			return base.Message;
		}
	}

	public MissingMethodException()
		: base("Attempted to access a missing method.")
	{
		base.HResult = -2146233069;
	}

	public MissingMethodException(string message)
		: base(message)
	{
		base.HResult = -2146233069;
	}

	public MissingMethodException(string message, Exception inner)
		: base(message, inner)
	{
		base.HResult = -2146233069;
	}

	public MissingMethodException(string className, string methodName)
	{
		ClassName = className;
		MemberName = methodName;
	}

	protected MissingMethodException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
