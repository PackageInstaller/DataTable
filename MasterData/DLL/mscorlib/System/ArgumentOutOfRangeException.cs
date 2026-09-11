using System.Runtime.Serialization;

namespace System;

[Serializable]
public class ArgumentOutOfRangeException : ArgumentException
{
	private object _actualValue;

	public override string Message
	{
		get
		{
			string message = base.Message;
			if (_actualValue != null)
			{
				string text = SR.Format("Actual value was {0}.", _actualValue.ToString());
				if (message == null)
				{
					return text;
				}
				return message + Environment.NewLine + text;
			}
			return message;
		}
	}

	public virtual object ActualValue => _actualValue;

	public ArgumentOutOfRangeException()
		: base("Specified argument was out of the range of valid values.")
	{
		base.HResult = -2146233086;
	}

	public ArgumentOutOfRangeException(string paramName)
		: base("Specified argument was out of the range of valid values.", paramName)
	{
		base.HResult = -2146233086;
	}

	public ArgumentOutOfRangeException(string paramName, string message)
		: base(message, paramName)
	{
		base.HResult = -2146233086;
	}

	public ArgumentOutOfRangeException(string message, Exception innerException)
		: base(message, innerException)
	{
		base.HResult = -2146233086;
	}

	public ArgumentOutOfRangeException(string paramName, object actualValue, string message)
		: base(message, paramName)
	{
		_actualValue = actualValue;
		base.HResult = -2146233086;
	}

	protected ArgumentOutOfRangeException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
		_actualValue = info.GetValue("ActualValue", typeof(object));
	}

	public override void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		base.GetObjectData(info, context);
		info.AddValue("ActualValue", _actualValue, typeof(object));
	}
}
