using System.IO;
using System.Runtime.Serialization;

namespace System;

[Serializable]
public class BadImageFormatException : SystemException
{
	private string _fileName;

	private string _fusionLog;

	public override string Message
	{
		get
		{
			SetMessageField();
			return _message;
		}
	}

	public BadImageFormatException()
		: base("Format of the executable (.exe) or library (.dll) is invalid.")
	{
		base.HResult = -2147024885;
	}

	public BadImageFormatException(string message)
		: base(message)
	{
		base.HResult = -2147024885;
	}

	public BadImageFormatException(string message, Exception inner)
		: base(message, inner)
	{
		base.HResult = -2147024885;
	}

	public BadImageFormatException(string message, string fileName)
		: base(message)
	{
		base.HResult = -2147024885;
		_fileName = fileName;
	}

	protected BadImageFormatException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
		_fileName = info.GetString("BadImageFormat_FileName");
		_fusionLog = info.GetString("BadImageFormat_FusionLog");
	}

	public override void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		base.GetObjectData(info, context);
		info.AddValue("BadImageFormat_FileName", _fileName, typeof(string));
		info.AddValue("BadImageFormat_FusionLog", _fusionLog, typeof(string));
	}

	private void SetMessageField()
	{
		if (_message == null)
		{
			if (_fileName == null && base.HResult == -2146233088)
			{
				_message = "Format of the executable (.exe) or library (.dll) is invalid.";
			}
			else
			{
				_message = FileLoadException.FormatFileLoadExceptionMessage(_fileName, base.HResult);
			}
		}
	}

	public override string ToString()
	{
		string text = GetType().ToString() + ": " + Message;
		if (_fileName != null && _fileName.Length != 0)
		{
			text = text + Environment.NewLine + SR.Format("File name: '{0}'", _fileName);
		}
		if (base.InnerException != null)
		{
			text = text + " ---> " + base.InnerException.ToString();
		}
		if (StackTrace != null)
		{
			text = text + Environment.NewLine + StackTrace;
		}
		if (_fusionLog != null)
		{
			if (text == null)
			{
				text = " ";
			}
			text += Environment.NewLine;
			text += Environment.NewLine;
			text += _fusionLog;
		}
		return text;
	}
}
