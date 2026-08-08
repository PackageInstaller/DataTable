using System.Runtime.Serialization;

namespace System.Net.Mail;

[Serializable]
public class SmtpException : Exception, ISerializable
{
	private SmtpStatusCode statusCode;

	public SmtpException()
		: this(SmtpStatusCode.GeneralFailure)
	{
	}

	public SmtpException(SmtpStatusCode statusCode)
		: this(statusCode, "Syntax error, command unrecognized.")
	{
	}

	public SmtpException(string message)
		: this(SmtpStatusCode.GeneralFailure, message)
	{
	}

	protected SmtpException(SerializationInfo serializationInfo, StreamingContext streamingContext)
		: base(serializationInfo, streamingContext)
	{
		try
		{
			statusCode = (SmtpStatusCode)serializationInfo.GetValue("Status", typeof(int));
		}
		catch (SerializationException)
		{
			statusCode = (SmtpStatusCode)serializationInfo.GetValue("statusCode", typeof(SmtpStatusCode));
		}
	}

	public SmtpException(SmtpStatusCode statusCode, string message)
		: base(message)
	{
		this.statusCode = statusCode;
	}

	public SmtpException(string message, Exception innerException)
		: base(message, innerException)
	{
		statusCode = SmtpStatusCode.GeneralFailure;
	}

	public override void GetObjectData(SerializationInfo serializationInfo, StreamingContext streamingContext)
	{
		if (serializationInfo == null)
		{
			throw new ArgumentNullException("serializationInfo");
		}
		base.GetObjectData(serializationInfo, streamingContext);
		serializationInfo.AddValue("Status", statusCode, typeof(int));
	}

	void ISerializable.GetObjectData(SerializationInfo info, StreamingContext context)
	{
		GetObjectData(info, context);
	}
}
