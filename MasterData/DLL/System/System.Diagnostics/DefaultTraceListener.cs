using System.IO;
using System.Runtime.CompilerServices;

namespace System.Diagnostics;

public class DefaultTraceListener : TraceListener
{
	private static readonly bool OnWin32;

	private static readonly string MonoTracePrefix;

	private static readonly string MonoTraceFile;

	private string logFileName;

	[System.MonoTODO]
	public string LogFileName => logFileName;

	static DefaultTraceListener()
	{
		OnWin32 = Path.DirectorySeparatorChar == '\\';
		if (OnWin32)
		{
			return;
		}
		string text = Environment.GetEnvironmentVariable("MONO_TRACE_LISTENER");
		if (text == null)
		{
			text = "Console.Out";
		}
		if (text != null)
		{
			string text2 = null;
			string text3 = null;
			if (text.StartsWith("Console.Out"))
			{
				text2 = "Console.Out";
				text3 = GetPrefix(text, "Console.Out");
			}
			else if (text.StartsWith("Console.Error"))
			{
				text2 = "Console.Error";
				text3 = GetPrefix(text, "Console.Error");
			}
			else
			{
				text2 = text;
				text3 = "";
			}
			MonoTraceFile = text2;
			MonoTracePrefix = text3;
		}
	}

	private static string GetPrefix(string var, string target)
	{
		if (var.Length > target.Length)
		{
			return var.Substring(target.Length + 1);
		}
		return "";
	}

	public DefaultTraceListener()
		: base("Default")
	{
	}

	public override void Fail(string message)
	{
		base.Fail(message);
	}

	public override void Fail(string message, string detailMessage)
	{
		base.Fail(message, detailMessage);
		WriteLine(new StackTrace().ToString());
	}

	[MethodImpl((MethodImplOptions)4096)]
	private unsafe static extern void WriteWindowsDebugString(char* message);

	private unsafe void WriteDebugString(string message)
	{
		if (OnWin32)
		{
			fixed (char* message2 = message)
			{
				WriteWindowsDebugString(message2);
			}
		}
		else
		{
			WriteMonoTrace(message);
		}
	}

	private void WriteMonoTrace(string message)
	{
		string monoTraceFile = MonoTraceFile;
		if (!(monoTraceFile == "Console.Out"))
		{
			if (monoTraceFile == "Console.Error")
			{
				Console.Error.Write(message);
			}
			else
			{
				WriteLogFile(message, MonoTraceFile);
			}
		}
		else
		{
			Console.Out.Write(message);
		}
	}

	private void WritePrefix()
	{
		if (!OnWin32)
		{
			WriteMonoTrace(MonoTracePrefix);
		}
	}

	private void WriteImpl(string message)
	{
		if (base.NeedIndent)
		{
			WriteIndent();
			WritePrefix();
		}
		if (Debugger.IsLogging())
		{
			Debugger.Log(0, null, message);
		}
		else
		{
			WriteDebugString(message);
		}
		WriteLogFile(message, LogFileName);
	}

	private void WriteLogFile(string message, string logFile)
	{
		if (logFile != null && logFile.Length != 0)
		{
			FileInfo fileInfo = new FileInfo(logFile);
			StreamWriter streamWriter = null;
			try
			{
				streamWriter = ((!fileInfo.Exists) ? fileInfo.CreateText() : fileInfo.AppendText());
			}
			catch
			{
				return;
			}
			using (streamWriter)
			{
				streamWriter.Write(message);
				streamWriter.Flush();
			}
		}
	}

	public override void Write(string message)
	{
		WriteImpl(message);
	}

	public override void WriteLine(string message)
	{
		string message2 = message + Environment.NewLine;
		WriteImpl(message2);
		base.NeedIndent = true;
	}
}
