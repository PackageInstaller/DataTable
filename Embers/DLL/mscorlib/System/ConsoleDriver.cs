using System.IO;
using System.Runtime.CompilerServices;

namespace System;

internal static class ConsoleDriver
{
	internal static IConsoleDriver driver;

	private static bool is_console;

	private static bool called_isatty;

	public static bool Initialized => driver.Initialized;

	public static ConsoleColor BackgroundColor
	{
		get
		{
			return driver.BackgroundColor;
		}
		set
		{
			if (value < ConsoleColor.Black || value > ConsoleColor.White)
			{
				throw new ArgumentOutOfRangeException("value", "Not a ConsoleColor value.");
			}
			driver.BackgroundColor = value;
		}
	}

	public static int BufferHeight
	{
		get
		{
			return driver.BufferHeight;
		}
		set
		{
			driver.BufferHeight = value;
		}
	}

	public static int BufferWidth
	{
		get
		{
			return driver.BufferWidth;
		}
		set
		{
			driver.BufferWidth = value;
		}
	}

	public static bool CapsLock => driver.CapsLock;

	public static int CursorLeft
	{
		get
		{
			return driver.CursorLeft;
		}
		set
		{
			driver.CursorLeft = value;
		}
	}

	public static int CursorSize
	{
		get
		{
			return driver.CursorSize;
		}
		set
		{
			driver.CursorSize = value;
		}
	}

	public static int CursorTop
	{
		get
		{
			return driver.CursorTop;
		}
		set
		{
			driver.CursorTop = value;
		}
	}

	public static bool CursorVisible
	{
		get
		{
			return driver.CursorVisible;
		}
		set
		{
			driver.CursorVisible = value;
		}
	}

	public static bool KeyAvailable => driver.KeyAvailable;

	public static ConsoleColor ForegroundColor
	{
		get
		{
			return driver.ForegroundColor;
		}
		set
		{
			if (value < ConsoleColor.Black || value > ConsoleColor.White)
			{
				throw new ArgumentOutOfRangeException("value", "Not a ConsoleColor value.");
			}
			driver.ForegroundColor = value;
		}
	}

	public static int LargestWindowHeight => driver.LargestWindowHeight;

	public static int LargestWindowWidth => driver.LargestWindowWidth;

	public static bool NumberLock => driver.NumberLock;

	public static string Title
	{
		get
		{
			return driver.Title;
		}
		set
		{
			driver.Title = value;
		}
	}

	public static bool TreatControlCAsInput
	{
		get
		{
			return driver.TreatControlCAsInput;
		}
		set
		{
			driver.TreatControlCAsInput = value;
		}
	}

	public static int WindowHeight
	{
		get
		{
			return driver.WindowHeight;
		}
		set
		{
			driver.WindowHeight = value;
		}
	}

	public static int WindowLeft
	{
		get
		{
			return driver.WindowLeft;
		}
		set
		{
			driver.WindowLeft = value;
		}
	}

	public static int WindowTop
	{
		get
		{
			return driver.WindowTop;
		}
		set
		{
			driver.WindowTop = value;
		}
	}

	public static int WindowWidth
	{
		get
		{
			return driver.WindowWidth;
		}
		set
		{
			driver.WindowWidth = value;
		}
	}

	public static bool IsErrorRedirected => !Isatty(MonoIO.ConsoleError);

	public static bool IsOutputRedirected => !Isatty(MonoIO.ConsoleOutput);

	public static bool IsInputRedirected => !Isatty(MonoIO.ConsoleInput);

	public static bool IsConsole
	{
		get
		{
			if (called_isatty)
			{
				return is_console;
			}
			is_console = Isatty(MonoIO.ConsoleOutput) && Isatty(MonoIO.ConsoleInput);
			called_isatty = true;
			return is_console;
		}
	}

	static ConsoleDriver()
	{
		if (!IsConsole)
		{
			driver = CreateNullConsoleDriver();
			return;
		}
		if (Environment.IsRunningOnWindows)
		{
			driver = CreateWindowsConsoleDriver();
			return;
		}
		string environmentVariable = Environment.GetEnvironmentVariable("TERM");
		if (environmentVariable == "dumb")
		{
			is_console = false;
			driver = CreateNullConsoleDriver();
		}
		else
		{
			driver = CreateTermInfoDriver(environmentVariable);
		}
	}

	[MethodImpl((MethodImplOptions)8)]
	private static IConsoleDriver CreateNullConsoleDriver()
	{
		return new NullConsoleDriver();
	}

	[MethodImpl((MethodImplOptions)8)]
	private static IConsoleDriver CreateWindowsConsoleDriver()
	{
		return new WindowsConsoleDriver();
	}

	[MethodImpl((MethodImplOptions)8)]
	private static IConsoleDriver CreateTermInfoDriver(string term)
	{
		return new TermInfoDriver(term);
	}

	public static void Beep(int frequency, int duration)
	{
		driver.Beep(frequency, duration);
	}

	public static void Clear()
	{
		driver.Clear();
	}

	public static void MoveBufferArea(int sourceLeft, int sourceTop, int sourceWidth, int sourceHeight, int targetLeft, int targetTop)
	{
		MoveBufferArea(sourceLeft, sourceTop, sourceWidth, sourceHeight, targetLeft, targetTop, ' ', ConsoleColor.Black, ConsoleColor.Black);
	}

	public static void MoveBufferArea(int sourceLeft, int sourceTop, int sourceWidth, int sourceHeight, int targetLeft, int targetTop, char sourceChar, ConsoleColor sourceForeColor, ConsoleColor sourceBackColor)
	{
		driver.MoveBufferArea(sourceLeft, sourceTop, sourceWidth, sourceHeight, targetLeft, targetTop, sourceChar, sourceForeColor, sourceBackColor);
	}

	public static void Init()
	{
		driver.Init();
	}

	public static int Read()
	{
		return ReadKey(intercept: false).KeyChar;
	}

	public static string ReadLine()
	{
		return driver.ReadLine();
	}

	public static ConsoleKeyInfo ReadKey(bool intercept)
	{
		return driver.ReadKey(intercept);
	}

	public static void ResetColor()
	{
		driver.ResetColor();
	}

	public static void SetBufferSize(int width, int height)
	{
		driver.SetBufferSize(width, height);
	}

	public static void SetCursorPosition(int left, int top)
	{
		driver.SetCursorPosition(left, top);
	}

	public static void SetWindowPosition(int left, int top)
	{
		driver.SetWindowPosition(left, top);
	}

	public static void SetWindowSize(int width, int height)
	{
		driver.SetWindowSize(width, height);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool Isatty(IntPtr handle);

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern int InternalKeyAvailable(int ms_timeout);

	[MethodImpl((MethodImplOptions)4096)]
	internal unsafe static extern bool TtySetup(string keypadXmit, string teardown, out byte[] control_characters, out int* address);

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern bool SetEcho(bool wantEcho);

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern bool SetBreak(bool wantBreak);
}
