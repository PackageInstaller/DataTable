using System.Runtime.Serialization;

namespace System;

[Serializable]
public class MissingFieldException : MissingMemberException, ISerializable
{
	public override string Message
	{
		get
		{
			if (ClassName == null)
			{
				return base.Message;
			}
			return SR.Format("Field '{0}' not found.", ((Signature != null) ? (MissingMemberException.FormatSignature(Signature) + " ") : "") + ClassName + "." + MemberName);
		}
	}

	public MissingFieldException()
		: base("Attempted to access a non-existing field.")
	{
		base.HResult = -2146233071;
	}

	public MissingFieldException(string message)
		: base(message)
	{
		base.HResult = -2146233071;
	}

	public MissingFieldException(string className, string fieldName)
	{
		ClassName = className;
		MemberName = fieldName;
	}

	protected MissingFieldException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
	}
}
