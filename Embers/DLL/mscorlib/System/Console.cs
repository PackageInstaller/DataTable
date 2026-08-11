using System.IO;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading;

namespace System;

public static class Console
{
	private class WindowsConsole
	{
		private delegate bool WindowsCancelHandler(int keyCode);

		public static bool ctrlHandlerAdded = false;

		private static WindowsCancelHandler cancelHandler = DoWindowsConsoleCancelEvent;

		[DllImport("kernel32.dll", CharSet = CharSet.Auto, ExactSpelling = true)]
		private static extern int GetConsoleCP();

		[DllImport("kernel32.dll", CharSet = CharSet.Auto, ExactSpelling = true)]
		private static extern int GetConsoleOutputCP();

		[DllImport("kernel32.dll", CharSet = CharSet.Auto, ExactSpelling = true)]
		private static extern bool SetConsoleCtrlHandler(WindowsCancelHandler handler, bool addHandler);

		private static bool DoWindowsConsoleCancelEvent(int keyCode)
		{
			if (keyCode == 0)
			{
				DoConsoleCancelEvent();
			}
			return keyCode == 0;
		}

		[MethodImpl((MethodImplOptions)8)]
		public static int GetInputCodePage()
		{
			return GetConsoleCP();
		}

		[MethodImpl((MethodImplOptions)8)]
		public static int GetOutputCodePage()
		{
			return GetConsoleOutputCP();
		}

		public static void AddCtrlHandler()
		{
			SetConsoleCtrlHandler(cancelHandler, addHandler: true);
			ctrlHandlerAdded = true;
		}

		public static void RemoveCtrlHandler()
		{
			SetConsoleCtrlHandler(cancelHandler, addHandler: false);
			ctrlHandlerAdded = false;
		}
	}

	internal static TextWriter stdout;

	private static TextWriter stderr;

	private static TextReader stdin;

	private const string LibLog = "/system/lib/liblog.so";

	private const string LibLog64 = "/system/lib64/liblog.so";

	internal static bool IsRunningOnAndroid;

	private static Encoding inputEncoding;

	private static Encoding outputEncoding;

	private static ConsoleCancelEventHandler cancel_event;

	public static TextWriter Error => stderr;

	public static TextWriter Out => stdout;

	public static TextReader In => stdin;

	public static Encoding InputEncoding
	{
		get
		{
			return inputEncoding;
		}
		set
		{
			inputEncoding = value;
			SetupStreams(inputEncoding, outputEncoding);
		}
	}

	public static Encoding OutputEncoding
	{
		get
		{
			return outputEncoding;
		}
		set
		{
			outputEncoding = value;
			SetupStreams(inputEncoding, outputEncoding);
		}
	}

	public static ConsoleColor BackgroundColor
	{
		get
		{
			return ConsoleDriver.BackgroundColor;
		}
		set
		{
			ConsoleDriver.BackgroundColor = value;
		}
	}

	public static int BufferHeight
	{
		get
		{
			return ConsoleDriver.BufferHeight;
		}
		[MonoLimitation("Implemented only on Windows")]
		set
		{
			ConsoleDriver.BufferHeight = value;
		}
	}

	public static int BufferWidth
	{
		get
		{
			return ConsoleDriver.BufferWidth;
		}
		[MonoLimitation("Implemented only on Windows")]
		set
		{
			ConsoleDriver.BufferWidth = value;
		}
	}

	[MonoLimitation("Implemented only on Windows")]
	public static bool CapsLock => ConsoleDriver.CapsLock;

	public static int CursorLeft
	{
		get
		{
			return ConsoleDriver.CursorLeft;
		}
		set
		{
			ConsoleDriver.CursorLeft = value;
		}
	}

	public static int CursorTop
	{
		get
		{
			return ConsoleDriver.CursorTop;
		}
		set
		{
			ConsoleDriver.CursorTop = value;
		}
	}

	public static int CursorSize
	{
		get
		{
			return ConsoleDriver.CursorSize;
		}
		set
		{
			ConsoleDriver.CursorSize = value;
		}
	}

	public static bool CursorVisible
	{
		get
		{
			return ConsoleDriver.CursorVisible;
		}
		set
		{
			ConsoleDriver.CursorVisible = value;
		}
	}

	public static ConsoleColor ForegroundColor
	{
		get
		{
			return ConsoleDriver.ForegroundColor;
		}
		set
		{
			ConsoleDriver.ForegroundColor = value;
		}
	}

	public static bool KeyAvailable => ConsoleDriver.KeyAvailable;

	public static int LargestWindowHeight => ConsoleDriver.LargestWindowHeight;

	public static int LargestWindowWidth => ConsoleDriver.LargestWindowWidth;

	public static bool NumberLock => ConsoleDriver.NumberLock;

	public static string Title
	{
		get
		{
			return ConsoleDriver.Title;
		}
		set
		{
			ConsoleDriver.Title = value;
		}
	}

	public static bool TreatControlCAsInput
	{
		get
		{
			return ConsoleDriver.TreatControlCAsInput;
		}
		set
		{
			ConsoleDriver.TreatControlCAsInput = value;
		}
	}

	public static int WindowHeight
	{
		get
		{
			return ConsoleDriver.WindowHeight;
		}
		set
		{
			ConsoleDriver.WindowHeight = value;
		}
	}

	public static int WindowLeft
	{
		get
		{
			return ConsoleDriver.WindowLeft;
		}
		set
		{
			ConsoleDriver.WindowLeft = value;
		}
	}

	public static int WindowTop
	{
		get
		{
			return ConsoleDriver.WindowTop;
		}
		set
		{
			ConsoleDriver.WindowTop = value;
		}
	}

	public static int WindowWidth
	{
		get
		{
			return ConsoleDriver.WindowWidth;
		}
		set
		{
			ConsoleDriver.WindowWidth = value;
		}
	}

	public static bool IsErrorRedirected => ConsoleDriver.IsErrorRedirected;

	public static bool IsOutputRedirected => ConsoleDriver.IsOutputRedirected;

	public static bool IsInputRedirected => ConsoleDriver.IsInputRedirected;

	public static event ConsoleCancelEventHandler CancelKeyPress
	{
		add
		{
			if (!ConsoleDriver.Initialized)
			{
				ConsoleDriver.Init();
			}
			cancel_event = (ConsoleCancelEventHandler)Delegate.Combine(cancel_event, value);
			if (Environment.IsRunningOnWindows && !WindowsConsole.ctrlHandlerAdded)
			{
				WindowsConsole.AddCtrlHandler();
			}
		}
		remove
		{
			if (!ConsoleDriver.Initialized)
			{
				ConsoleDriver.Init();
			}
			cancel_event = (ConsoleCancelEventHandler)Delegate.Remove(cancel_event, value);
			if (cancel_event == null && Environment.IsRunningOnWindows && WindowsConsole.ctrlHandlerAdded)
			{
				WindowsConsole.RemoveCtrlHandler();
			}
		}
	}

	static Console()
	{
		IsRunningOnAndroid = File.Exists("/system/lib/liblog.so") || File.Exists("/system/lib64/liblog.so");
		if (Environment.IsRunningOnWindows)
		{
			try
			{
				inputEncoding = Encoding.GetEncoding(WindowsConsole.GetInputCodePage());
				outputEncoding = Encoding.GetEncoding(WindowsConsole.GetOutputCodePage());
			}
			catch
			{
				inputEncoding = (outputEncoding = Encoding.Default);
			}
		}
		else
		{
			int code_page = 0;
			EncodingHelper.InternalCodePage(ref code_page);
			if (code_page != -1 && ((code_page & 0xFFFFFFF) == 3 || (code_page & 0x10000000) != 0))
			{
				inputEncoding = (outputEncoding = EncodingHelper.UTF8Unmarked);
			}
			else
			{
				inputEncoding = (outputEncoding = Encoding.Default);
			}
		}
		SetupStreams(inputEncoding, outputEncoding);
	}

	private static void SetupStreams(Encoding inputEncoding, Encoding outputEncoding)
	{
		if (!Environment.IsRunningOnWindows && ConsoleDriver.IsConsole)
		{
			stdin = new CStreamReader(OpenStandardInput(0), inputEncoding);
			stdout = TextWriter.Synchronized(new CStreamWriter(OpenStandardOutput(0), outputEncoding, leaveOpen: true)
			{
				AutoFlush = true
			});
			stderr = TextWriter.Synchronized(new CStreamWriter(OpenStandardError(0), outputEncoding, leaveOpen: true)
			{
				AutoFlush = true
			});
		}
		else
		{
			stdin = TextReader.Synchronized(new UnexceptionalStreamReader(OpenStandardInput(0), inputEncoding));
			stdout = TextWriter.Synchronized(new UnexceptionalStreamWriter(OpenStandardOutput(0), outputEncoding)
			{
				AutoFlush = true
			});
			stderr = TextWriter.Synchronized(new UnexceptionalStreamWriter(OpenStandardError(0), outputEncoding)
			{
				AutoFlush = true
			});
		}
		GC.SuppressFinalize(stdout);
		GC.SuppressFinalize(stderr);
		GC.SuppressFinalize(stdin);
	}

	private static Stream Open(IntPtr handle, FileAccess access, int bufferSize)
	{
		try
		{
			FileStream fileStream = new FileStream(handle, access, ownsHandle: false, bufferSize, isAsync: false, isConsoleWrapper: true);
			GC.SuppressFinalize(fileStream);
			return fileStream;
		}
		catch (IOException)
		{
			return Stream.Null;
		}
	}

	public static Stream OpenStandardError()
	{
		return OpenStandardError(0);
	}

	public static Stream OpenStandardError(int bufferSize)
	{
		return Open(MonoIO.ConsoleError, FileAccess.Write, bufferSize);
	}

	public static Stream OpenStandardInput()
	{
		return OpenStandardInput(0);
	}

	public static Stream OpenStandardInput(int bufferSize)
	{
		return Open(MonoIO.ConsoleInput, FileAccess.Read, bufferSize);
	}

	public static Stream OpenStandardOutput()
	{
		return OpenStandardOutput(0);
	}

	public static Stream OpenStandardOutput(int bufferSize)
	{
		return Open(MonoIO.ConsoleOutput, FileAccess.Write, bufferSize);
	}

	public static void SetError(TextWriter newError)
	{
		if (newError == null)
		{
			throw new ArgumentNullException("newError");
		}
		stderr = TextWriter.Synchronized(newError);
	}

	public static void SetIn(TextReader newIn)
	{
		if (newIn == null)
		{
			throw new ArgumentNullException("newIn");
		}
		stdin = TextReader.Synchronized(newIn);
	}

	public static void SetOut(TextWriter newOut)
	{
		if (newOut == null)
		{
			throw new ArgumentNullException("newOut");
		}
		stdout = TextWriter.Synchronized(newOut);
	}

	public static void Write(bool value)
	{
		stdout.Write(value);
	}

	public static void Write(char value)
	{
		stdout.Write(value);
	}

	public static void Write(char[] buffer)
	{
		stdout.Write(buffer);
	}

	public static void Write(decimal value)
	{
		stdout.Write(value);
	}

	public static void Write(double value)
	{
		stdout.Write(value);
	}

	public static void Write(int value)
	{
		stdout.Write(value);
	}

	public static void Write(long value)
	{
		stdout.Write(value);
	}

	public static void Write(object value)
	{
		stdout.Write(value);
	}

	public static void Write(float value)
	{
		stdout.Write(value);
	}

	public static void Write(string value)
	{
		stdout.Write(value);
	}

	[CLSCompliant(false)]
	public static void Write(uint value)
	{
		stdout.Write(value);
	}

	[CLSCompliant(false)]
	public static void Write(ulong value)
	{
		stdout.Write(value);
	}

	public static void Write(string format, object arg0)
	{
		stdout.Write(format, arg0);
	}

	public static void Write(string format, params object[] arg)
	{
		if (arg == null)
		{
			stdout.Write(format);
		}
		else
		{
			stdout.Write(format, arg);
		}
	}

	public static void Write(char[] buffer, int index, int count)
	{
		stdout.Write(buffer, index, count);
	}

	public static void Write(string format, object arg0, object arg1)
	{
		stdout.Write(format, arg0, arg1);
	}

	public static void Write(string format, object arg0, object arg1, object arg2)
	{
		stdout.Write(format, arg0, arg1, arg2);
	}

	[CLSCompliant(false)]
	public static void Write(string format, object arg0, object arg1, object arg2, object arg3, __arglist)
	{
		ArgIterator argIterator = new ArgIterator(__arglist);
		int remainingCount = argIterator.GetRemainingCount();
		object[] array = new object[remainingCount + 4];
		array[0] = arg0;
		array[1] = arg1;
		array[2] = arg2;
		array[3] = arg3;
		for (int i = 0; i < remainingCount; i++)
		{
			TypedReference nextArg = argIterator.GetNextArg();
			array[i + 4] = TypedReference.ToObject(nextArg);
		}
		stdout.Write(string.Format(format, array));
	}

	public static void WriteLine()
	{
		stdout.WriteLine();
	}

	public static void WriteLine(bool value)
	{
		stdout.WriteLine(value);
	}

	public static void WriteLine(char value)
	{
		stdout.WriteLine(value);
	}

	public static void WriteLine(char[] buffer)
	{
		stdout.WriteLine(buffer);
	}

	public static void WriteLine(decimal value)
	{
		stdout.WriteLine(value);
	}

	public static void WriteLine(double value)
	{
		stdout.WriteLine(value);
	}

	public static void WriteLine(int value)
	{
		stdout.WriteLine(value);
	}

	public static void WriteLine(long value)
	{
		stdout.WriteLine(value);
	}

	public static void WriteLine(object value)
	{
		stdout.WriteLine(value);
	}

	public static void WriteLine(float value)
	{
		stdout.WriteLine(value);
	}

	public static void WriteLine(string value)
	{
		stdout.WriteLine(value);
	}

	[CLSCompliant(false)]
	public static void WriteLine(uint value)
	{
		stdout.WriteLine(value);
	}

	[CLSCompliant(false)]
	public static void WriteLine(ulong value)
	{
		stdout.WriteLine(value);
	}

	public static void WriteLine(string format, object arg0)
	{
		stdout.WriteLine(format, arg0);
	}

	public static void WriteLine(string format, params object[] arg)
	{
		if (arg == null)
		{
			stdout.WriteLine(format);
		}
		else
		{
			stdout.WriteLine(format, arg);
		}
	}

	public static void WriteLine(char[] buffer, int index, int count)
	{
		stdout.WriteLine(buffer, index, count);
	}

	public static void WriteLine(string format, object arg0, object arg1)
	{
		stdout.WriteLine(format, arg0, arg1);
	}

	public static void WriteLine(string format, object arg0, object arg1, object arg2)
	{
		stdout.WriteLine(format, arg0, arg1, arg2);
	}

	[CLSCompliant(false)]
	public static void WriteLine(string format, object arg0, object arg1, object arg2, object arg3, __arglist)
	{
		ArgIterator argIterator = new ArgIterator(__arglist);
		int remainingCount = argIterator.GetRemainingCount();
		object[] array = new object[remainingCount + 4];
		array[0] = arg0;
		array[1] = arg1;
		array[2] = arg2;
		array[3] = arg3;
		for (int i = 0; i < remainingCount; i++)
		{
			TypedReference nextArg = argIterator.GetNextArg();
			array[i + 4] = TypedReference.ToObject(nextArg);
		}
		stdout.WriteLine(string.Format(format, array));
	}

	public static int Read()
	{
		if (stdin is CStreamReader && ConsoleDriver.IsConsole)
		{
			return ConsoleDriver.Read();
		}
		return stdin.Read();
	}

	public static string ReadLine()
	{
		if (stdin is CStreamReader && ConsoleDriver.IsConsole)
		{
			return ConsoleDriver.ReadLine();
		}
		return stdin.ReadLine();
	}

	public static void Beep()
	{
		Beep(1000, 500);
	}

	public static void Beep(int frequency, int duration)
	{
		if (frequency < 37 || frequency > 32767)
		{
			throw new ArgumentOutOfRangeException("frequency");
		}
		if (duration <= 0)
		{
			throw new ArgumentOutOfRangeException("duration");
		}
		ConsoleDriver.Beep(frequency, duration);
	}

	public static void Clear()
	{
		ConsoleDriver.Clear();
	}

	[MonoLimitation("Implemented only on Windows")]
	public static void MoveBufferArea(int sourceLeft, int sourceTop, int sourceWidth, int sourceHeight, int targetLeft, int targetTop)
	{
		ConsoleDriver.MoveBufferArea(sourceLeft, sourceTop, sourceWidth, sourceHeight, targetLeft, targetTop);
	}

	[MonoLimitation("Implemented only on Windows")]
	public static void MoveBufferArea(int sourceLeft, int sourceTop, int sourceWidth, int sourceHeight, int targetLeft, int targetTop, char sourceChar, ConsoleColor sourceForeColor, ConsoleColor sourceBackColor)
	{
		ConsoleDriver.MoveBufferArea(sourceLeft, sourceTop, sourceWidth, sourceHeight, targetLeft, targetTop, sourceChar, sourceForeColor, sourceBackColor);
	}

	public static ConsoleKeyInfo ReadKey()
	{
		return ReadKey(intercept: false);
	}

	public static ConsoleKeyInfo ReadKey(bool intercept)
	{
		return ConsoleDriver.ReadKey(intercept);
	}

	public static void ResetColor()
	{
		ConsoleDriver.ResetColor();
	}

	[MonoLimitation("Only works on windows")]
	public static void SetBufferSize(int width, int height)
	{
		ConsoleDriver.SetBufferSize(width, height);
	}

	public static void SetCursorPosition(int left, int top)
	{
		ConsoleDriver.SetCursorPosition(left, top);
	}

	public static void SetWindowPosition(int left, int top)
	{
		ConsoleDriver.SetWindowPosition(left, top);
	}

	public static void SetWindowSize(int width, int height)
	{
		ConsoleDriver.SetWindowSize(width, height);
	}

	private static void DoConsoleCancelEventInBackground()
	{
		ThreadPool.UnsafeQueueUserWorkItem(delegate
		{
			DoConsoleCancelEvent();
		}, null);
	}

	private static void DoConsoleCancelEvent()
	{
		bool flag = true;
		if (cancel_event != null)
		{
			ConsoleCancelEventArgs e = new ConsoleCancelEventArgs(ConsoleSpecialKey.ControlC);
			Delegate[] invocationList = cancel_event.GetInvocationList();
			for (int i = 0; i < invocationList.Length; i++)
			{
				ConsoleCancelEventHandler consoleCancelEventHandler = (ConsoleCancelEventHandler)invocationList[i];
				try
				{
					consoleCancelEventHandler(null, e);
				}
				catch
				{
				}
			}
			flag = !e.Cancel;
		}
		if (flag)
		{
			Environment.Exit(58);
		}
	}
}
