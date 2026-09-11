using System.Runtime.Serialization;

namespace System;

[Serializable]
public class ArgumentException : SystemException
{
	private string _paramName;

	public override string Message
	{
		get
		{
			string message = base.Message;
			if (!string.IsNullOrEmpty(_paramName))
			{
				string text = SR.Format("Parameter name: {0}", _paramName);
				return message + Environment.NewLine + text;
			}
			return message;
		}
	}

	public virtual string ParamName => _paramName;

	public ArgumentException()
		: base("Value does not fall within the expected range.")
	{
		base.HResult = -2147024809;
	}

	public ArgumentException(string message)
		: base(message)
	{
		base.HResult = -2147024809;
	}

	public ArgumentException(string message, Exception innerException)
		: base(message, innerException)
	{
		base.HResult = -2147024809;
	}

	public ArgumentException(string message, string paramName, Exception innerException)
		: base(message, innerException)
	{
		_paramName = paramName;
		base.HResult = -2147024809;
	}

	public ArgumentException(string message, string paramName)
		: base(message)
	{
		_paramName = paramName;
		base.HResult = -2147024809;
	}

	protected ArgumentException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
		_paramName = info.GetString("ParamName");
	}

	public override void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		base.GetObjectData(info, context);
		info.AddValue("ParamName", _paramName, typeof(string));
	}
}
