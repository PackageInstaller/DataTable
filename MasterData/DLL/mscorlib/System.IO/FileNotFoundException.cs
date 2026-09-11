using System.Runtime.Serialization;

namespace System.IO;

[Serializable]
public class FileNotFoundException : IOException
{
	public override string Message
	{
		get
		{
			SetMessageField();
			return _message;
		}
	}

	public string FileName { get; }

	public string FusionLog { get; }

	public FileNotFoundException()
		: base("Unable to find the specified file.")
	{
		base.HResult = -2147024894;
	}

	public FileNotFoundException(string message)
		: base(message)
	{
		base.HResult = -2147024894;
	}

	public FileNotFoundException(string message, string fileName)
		: base(message)
	{
		base.HResult = -2147024894;
		FileName = fileName;
	}

	private void SetMessageField()
	{
		if (_message == null)
		{
			if (FileName == null && base.HResult == -2146233088)
			{
				_message = "Unable to find the specified file.";
			}
			else if (FileName != null)
			{
				_message = FileLoadException.FormatFileLoadExceptionMessage(FileName, base.HResult);
			}
		}
	}

	public override string ToString()
	{
		string text = GetType().ToString() + ": " + Message;
		if (FileName != null && FileName.Length != 0)
		{
			text = text + Environment.NewLine + SR.Format("File name: '{0}'", FileName);
		}
		if (base.InnerException != null)
		{
			text = text + " ---> " + base.InnerException.ToString();
		}
		if (StackTrace != null)
		{
			text = text + Environment.NewLine + StackTrace;
		}
		if (FusionLog != null)
		{
			if (text == null)
			{
				text = " ";
			}
			text += Environment.NewLine;
			text += Environment.NewLine;
			text += FusionLog;
		}
		return text;
	}

	protected FileNotFoundException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
		FileName = info.GetString("FileNotFound_FileName");
		FusionLog = info.GetString("FileNotFound_FusionLog");
	}

	public override void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		base.GetObjectData(info, context);
		info.AddValue("FileNotFound_FileName", FileName, typeof(string));
		info.AddValue("FileNotFound_FusionLog", FusionLog, typeof(string));
	}
}
