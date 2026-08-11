using System.Runtime.Serialization;

namespace System;

[Serializable]
public class MissingMemberException : MemberAccessException
{
	protected string ClassName;

	protected string MemberName;

	protected byte[] Signature;

	public override string Message
	{
		get
		{
			if (ClassName == null)
			{
				return base.Message;
			}
			return SR.Format("Member '{0}' not found.", ClassName + "." + MemberName + ((Signature != null) ? (" " + FormatSignature(Signature)) : string.Empty));
		}
	}

	public MissingMemberException()
		: base("Attempted to access a missing member.")
	{
		base.HResult = -2146233070;
	}

	public MissingMemberException(string message)
		: base(message)
	{
		base.HResult = -2146233070;
	}

	public MissingMemberException(string className, string memberName)
	{
		ClassName = className;
		MemberName = memberName;
	}

	protected MissingMemberException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
		ClassName = info.GetString("MMClassName");
		MemberName = info.GetString("MMMemberName");
		Signature = (byte[])info.GetValue("MMSignature", typeof(byte[]));
	}

	public override void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		base.GetObjectData(info, context);
		info.AddValue("MMClassName", ClassName, typeof(string));
		info.AddValue("MMMemberName", MemberName, typeof(string));
		info.AddValue("MMSignature", Signature, typeof(byte[]));
	}

	internal static string FormatSignature(byte[] signature)
	{
		return string.Empty;
	}
}
