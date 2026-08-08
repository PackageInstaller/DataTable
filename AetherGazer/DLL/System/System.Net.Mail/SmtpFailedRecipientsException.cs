using System.Runtime.Serialization;

namespace System.Net.Mail;

[Serializable]
public class SmtpFailedRecipientsException : SmtpFailedRecipientException, ISerializable
{
	private SmtpFailedRecipientException[] innerExceptions;

	public SmtpFailedRecipientsException()
	{
	}

	public SmtpFailedRecipientsException(string message, SmtpFailedRecipientException[] innerExceptions)
		: base(message)
	{
		this.innerExceptions = innerExceptions;
	}

	protected SmtpFailedRecipientsException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
		innerExceptions = (SmtpFailedRecipientException[])info.GetValue("innerExceptions", typeof(SmtpFailedRecipientException[]));
	}

	public override void GetObjectData(SerializationInfo serializationInfo, StreamingContext streamingContext)
	{
		if (serializationInfo == null)
		{
			throw new ArgumentNullException("serializationInfo");
		}
		base.GetObjectData(serializationInfo, streamingContext);
		serializationInfo.AddValue("innerExceptions", innerExceptions);
	}

	void ISerializable.GetObjectData(SerializationInfo info, StreamingContext context)
	{
		GetObjectData(info, context);
	}
}
