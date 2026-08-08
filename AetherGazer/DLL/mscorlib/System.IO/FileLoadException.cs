using System.Runtime.Serialization;

namespace System.IO;

[Serializable]
public class FileLoadException : IOException
{
	public override string Message
	{
		get
		{
			if (_message == null)
			{
				_message = FormatFileLoadExceptionMessage(FileName, base.HResult);
			}
			return _message;
		}
	}

	public string FileName { get; }

	public string FusionLog { get; }

	public FileLoadException()
		: base("Could not load the specified file.")
	{
		base.HResult = -2146232799;
	}

	public FileLoadException(string message)
		: base(message)
	{
		base.HResult = -2146232799;
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

	protected FileLoadException(SerializationInfo info, StreamingContext context)
		: base(info, context)
	{
		FileName = info.GetString("FileLoad_FileName");
		FusionLog = info.GetString("FileLoad_FusionLog");
	}

	public override void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		base.GetObjectData(info, context);
		info.AddValue("FileLoad_FileName", FileName, typeof(string));
		info.AddValue("FileLoad_FusionLog", FusionLog, typeof(string));
	}

	internal static string FormatFileLoadExceptionMessage(string fileName, int hResult)
	{
		if (fileName != null)
		{
			return SR.Format("Could not load the file '{0}'.", fileName);
		}
		return "Could not load the specified file.";
	}
}
