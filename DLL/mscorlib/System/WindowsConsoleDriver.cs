using System.Runtime.InteropServices;
using System.Text;

namespace System;

internal class WindowsConsoleDriver : IConsoleDriver
{
	private IntPtr inputHandle;

	private IntPtr outputHandle;

	private short defaultAttribute;

	public ConsoleColor BackgroundColor
	{
		get
		{
			ConsoleScreenBufferInfo info = default(ConsoleScreenBufferInfo);
			GetConsoleScreenBufferInfo(outputHandle, out info);
			return GetBackground(info.Attribute);
		}
		set
		{
			ConsoleScreenBufferInfo info = default(ConsoleScreenBufferInfo);
			GetConsoleScreenBufferInfo(outputHandle, out info);
			short attrBackground = GetAttrBackground(info.Attribute, value);
			SetConsoleTextAttribute(outputHandle, attrBackground);
		}
	}

	public int BufferHeight
	{
		get
		{
			ConsoleScreenBufferInfo info = default(ConsoleScreenBufferInfo);
			GetConsoleScreenBufferInfo(outputHandle, out info);
			return info.Size.Y;
		}
		set
		{
			SetBufferSize(BufferWidth, value);
		}
	}

	public int BufferWidth
	{
		get
		{
			ConsoleScreenBufferInfo info = default(ConsoleScreenBufferInfo);
			GetConsoleScreenBufferInfo(outputHandle, out info);
			return info.Size.X;
		}
		set
		{
			SetBufferSize(value, BufferHeight);
		}
	}

	public bool CapsLock => (GetKeyState(20) & 1) == 1;

	public int CursorLeft
	{
		get
		{
			ConsoleScreenBufferInfo info = default(ConsoleScreenBufferInfo);
			GetConsoleScreenBufferInfo(outputHandle, out info);
			return info.CursorPosition.X;
		}
		set
		{
			SetCursorPosition(value, CursorTop);
		}
	}

	public int CursorSize
	{
		get
		{
			ConsoleCursorInfo info = default(ConsoleCursorInfo);
			GetConsoleCursorInfo(outputHandle, out info);
			return info.Size;
		}
		set
		{
			if (value < 1 || value > 100)
			{
				throw new ArgumentOutOfRangeException("value");
			}
			ConsoleCursorInfo info = default(ConsoleCursorInfo);
			GetConsoleCursorInfo(outputHandle, out info);
			info.Size = value;
			if (!SetConsoleCursorInfo(outputHandle, ref info))
			{
				throw new Exception("SetConsoleCursorInfo failed");
			}
		}
	}

	public int CursorTop
	{
		get
		{
			ConsoleScreenBufferInfo info = default(ConsoleScreenBufferInfo);
			GetConsoleScreenBufferInfo(outputHandle, out info);
			return info.CursorPosition.Y;
		}
		set
		{
			SetCursorPosition(CursorLeft, value);
		}
	}

	public bool CursorVisible
	{
		get
		{
			ConsoleCursorInfo info = default(ConsoleCursorInfo);
			GetConsoleCursorInfo(outputHandle, out info);
			return info.Visible;
		}
		set
		{
			ConsoleCursorInfo info = default(ConsoleCursorInfo);
			GetConsoleCursorInfo(outputHandle, out info);
			if (info.Visible != value)
			{
				info.Visible = value;
				if (!SetConsoleCursorInfo(outputHandle, ref info))
				{
					throw new Exception("SetConsoleCursorInfo failed");
				}
			}
		}
	}

	public ConsoleColor ForegroundColor
	{
		get
		{
			ConsoleScreenBufferInfo info = default(ConsoleScreenBufferInfo);
			GetConsoleScreenBufferInfo(outputHandle, out info);
			return GetForeground(info.Attribute);
		}
		set
		{
			ConsoleScreenBufferInfo info = default(ConsoleScreenBufferInfo);
			GetConsoleScreenBufferInfo(outputHandle, out info);
			short attrForeground = GetAttrForeground(info.Attribute, value);
			SetConsoleTextAttribute(outputHandle, attrForeground);
		}
	}

	public bool KeyAvailable
	{
		get
		{
			InputRecord record = default(InputRecord);
			int eventsRead;
			do
			{
				if (!PeekConsoleInput(inputHandle, out record, 1, out eventsRead))
				{
					throw new InvalidOperationException("Error in PeekConsoleInput " + Marshal.GetLastWin32Error());
				}
				if (eventsRead == 0)
				{
					return false;
				}
				if (record.EventType == 1 && record.KeyDown && !IsModifierKey(record.VirtualKeyCode))
				{
					return true;
				}
			}
			while (ReadConsoleInput(inputHandle, out record, 1, out eventsRead));
			throw new InvalidOperationException("Error in ReadConsoleInput " + Marshal.GetLastWin32Error());
		}
	}

	public bool Initialized => false;

	public int LargestWindowHeight
	{
		get
		{
			Coord largestConsoleWindowSize = GetLargestConsoleWindowSize(outputHandle);
			if (largestConsoleWindowSize.X == 0 && largestConsoleWindowSize.Y == 0)
			{
				throw new Exception("GetLargestConsoleWindowSize" + Marshal.GetLastWin32Error());
			}
			return largestConsoleWindowSize.Y;
		}
	}

	public int LargestWindowWidth
	{
		get
		{
			Coord largestConsoleWindowSize = GetLargestConsoleWindowSize(outputHandle);
			if (largestConsoleWindowSize.X == 0 && largestConsoleWindowSize.Y == 0)
			{
				throw new Exception("GetLargestConsoleWindowSize" + Marshal.GetLastWin32Error());
			}
			return largestConsoleWindowSize.X;
		}
	}

	public bool NumberLock => (GetKeyState(144) & 1) == 1;

	public string Title
	{
		get
		{
			StringBuilder stringBuilder = new StringBuilder(1024);
			if (GetConsoleTitle(stringBuilder, 1024) == 0)
			{
				stringBuilder = new StringBuilder(26001);
				if (GetConsoleTitle(stringBuilder, 26000) == 0)
				{
					throw new Exception("Got " + Marshal.GetLastWin32Error());
				}
			}
			return stringBuilder.ToString();
		}
		set
		{
			if (value == null)
			{
				throw new ArgumentNullException("value");
			}
			if (!SetConsoleTitle(value))
			{
				throw new Exception("Got " + Marshal.GetLastWin32Error());
			}
		}
	}

	public bool TreatControlCAsInput
	{
		get
		{
			if (!GetConsoleMode(inputHandle, out var mode))
			{
				throw new Exception("Failed in GetConsoleMode: " + Marshal.GetLastWin32Error());
			}
			return (mode & 1) == 0;
		}
		set
		{
			if (!GetConsoleMode(inputHandle, out var mode))
			{
				throw new Exception("Failed in GetConsoleMode: " + Marshal.GetLastWin32Error());
			}
			if ((mode & 1) == 0 == value || SetConsoleMode(mode: (!value) ? (mode | 1) : (mode & -2), handle: inputHandle))
			{
				return;
			}
			throw new Exception("Failed in SetConsoleMode: " + Marshal.GetLastWin32Error());
		}
	}

	public int WindowHeight
	{
		get
		{
			ConsoleScreenBufferInfo info = default(ConsoleScreenBufferInfo);
			GetConsoleScreenBufferInfo(outputHandle, out info);
			return info.Window.Bottom - info.Window.Top + 1;
		}
		set
		{
			SetWindowSize(WindowWidth, value);
		}
	}

	public int WindowLeft
	{
		get
		{
			ConsoleScreenBufferInfo info = default(ConsoleScreenBufferInfo);
			GetConsoleScreenBufferInfo(outputHandle, out info);
			return info.Window.Left;
		}
		set
		{
			SetWindowPosition(value, WindowTop);
		}
	}

	public int WindowTop
	{
		get
		{
			ConsoleScreenBufferInfo info = default(ConsoleScreenBufferInfo);
			GetConsoleScreenBufferInfo(outputHandle, out info);
			return info.Window.Top;
		}
		set
		{
			SetWindowPosition(WindowLeft, value);
		}
	}

	public int WindowWidth
	{
		get
		{
			ConsoleScreenBufferInfo info = default(ConsoleScreenBufferInfo);
			GetConsoleScreenBufferInfo(outputHandle, out info);
			return info.Window.Right - info.Window.Left + 1;
		}
		set
		{
			SetWindowSize(value, WindowHeight);
		}
	}

	public WindowsConsoleDriver()
	{
		outputHandle = GetStdHandle(Handles.STD_OUTPUT);
		inputHandle = GetStdHandle(Handles.STD_INPUT);
		ConsoleScreenBufferInfo info = default(ConsoleScreenBufferInfo);
		GetConsoleScreenBufferInfo(outputHandle, out info);
		defaultAttribute = info.Attribute;
	}

	private static ConsoleColor GetForeground(short attr)
	{
		attr &= 0xF;
		return (ConsoleColor)attr;
	}

	private static ConsoleColor GetBackground(short attr)
	{
		attr &= 0xF0;
		attr >>= 4;
		return (ConsoleColor)attr;
	}

	private static short GetAttrForeground(int attr, ConsoleColor color)
	{
		attr &= -16;
		return (short)(attr | (int)color);
	}

	private static short GetAttrBackground(int attr, ConsoleColor color)
	{
		attr &= -241;
		int num = (int)color << 4;
		return (short)(attr | num);
	}

	public void Beep(int frequency, int duration)
	{
		_Beep(frequency, duration);
	}

	public void Clear()
	{
		Coord coord = default(Coord);
		ConsoleScreenBufferInfo info = default(ConsoleScreenBufferInfo);
		GetConsoleScreenBufferInfo(outputHandle, out info);
		int size = info.Size.X * info.Size.Y;
		FillConsoleOutputCharacter(outputHandle, ' ', size, coord, out var written);
		GetConsoleScreenBufferInfo(outputHandle, out info);
		FillConsoleOutputAttribute(outputHandle, info.Attribute, size, coord, out written);
		SetConsoleCursorPosition(outputHandle, coord);
	}

	public unsafe void MoveBufferArea(int sourceLeft, int sourceTop, int sourceWidth, int sourceHeight, int targetLeft, int targetTop, char sourceChar, ConsoleColor sourceForeColor, ConsoleColor sourceBackColor)
	{
		if (sourceForeColor < ConsoleColor.Black)
		{
			throw new ArgumentException("Cannot be less than 0.", "sourceForeColor");
		}
		if (sourceBackColor < ConsoleColor.Black)
		{
			throw new ArgumentException("Cannot be less than 0.", "sourceBackColor");
		}
		if (sourceWidth == 0 || sourceHeight == 0)
		{
			return;
		}
		ConsoleScreenBufferInfo info = default(ConsoleScreenBufferInfo);
		GetConsoleScreenBufferInfo(outputHandle, out info);
		CharInfo[] array = new CharInfo[sourceWidth * sourceHeight];
		Coord bsize = new Coord(sourceWidth, sourceHeight);
		Coord bpos = new Coord(0, 0);
		SmallRect region = new SmallRect(sourceLeft, sourceTop, sourceLeft + sourceWidth - 1, sourceTop + sourceHeight - 1);
		fixed (CharInfo* ptr = &array[0])
		{
			void* buffer = ptr;
			if (!ReadConsoleOutput(outputHandle, buffer, bsize, bpos, ref region))
			{
				throw new ArgumentException(string.Empty, "Cannot read from the specified coordinates.");
			}
		}
		short attrForeground = GetAttrForeground(0, sourceForeColor);
		attrForeground = GetAttrBackground(attrForeground, sourceBackColor);
		bpos = new Coord(sourceLeft, sourceTop);
		int num = 0;
		while (num < sourceHeight)
		{
			FillConsoleOutputCharacter(outputHandle, sourceChar, sourceWidth, bpos, out var written);
			FillConsoleOutputAttribute(outputHandle, attrForeground, sourceWidth, bpos, out written);
			num++;
			bpos.Y++;
		}
		bpos = new Coord(0, 0);
		region = new SmallRect(targetLeft, targetTop, targetLeft + sourceWidth - 1, targetTop + sourceHeight - 1);
		if (WriteConsoleOutput(outputHandle, array, bsize, bpos, ref region))
		{
			return;
		}
		throw new ArgumentException(string.Empty, "Cannot write to the specified coordinates.");
	}

	public void Init()
	{
	}

	public string ReadLine()
	{
		StringBuilder stringBuilder = new StringBuilder();
		bool flag = false;
		do
		{
			ConsoleKeyInfo consoleKeyInfo = ReadKey(intercept: false);
			flag = consoleKeyInfo.KeyChar == '\n';
			if (!flag)
			{
				stringBuilder.Append(consoleKeyInfo.KeyChar);
			}
		}
		while (!flag);
		return stringBuilder.ToString();
	}

	public ConsoleKeyInfo ReadKey(bool intercept)
	{
		InputRecord record = default(InputRecord);
		do
		{
			if (!ReadConsoleInput(inputHandle, out record, 1, out var _))
			{
				throw new InvalidOperationException("Error in ReadConsoleInput " + Marshal.GetLastWin32Error());
			}
		}
		while (!record.KeyDown || record.EventType != 1 || IsModifierKey(record.VirtualKeyCode));
		bool alt = (record.ControlKeyState & 3) != 0;
		bool control = (record.ControlKeyState & 0xC) != 0;
		bool shift = (record.ControlKeyState & 0x10) != 0;
		return new ConsoleKeyInfo(record.Character, (ConsoleKey)record.VirtualKeyCode, shift, alt, control);
	}

	public void ResetColor()
	{
		SetConsoleTextAttribute(outputHandle, defaultAttribute);
	}

	public void SetBufferSize(int width, int height)
	{
		ConsoleScreenBufferInfo info = default(ConsoleScreenBufferInfo);
		GetConsoleScreenBufferInfo(outputHandle, out info);
		if (width - 1 > info.Window.Right)
		{
			throw new ArgumentOutOfRangeException("width");
		}
		if (height - 1 > info.Window.Bottom)
		{
			throw new ArgumentOutOfRangeException("height");
		}
		if (!SetConsoleScreenBufferSize(newSize: new Coord(width, height), handle: outputHandle))
		{
			throw new ArgumentOutOfRangeException("height/width", "Cannot be smaller than the window size.");
		}
	}

	public void SetCursorPosition(int left, int top)
	{
		SetConsoleCursorPosition(coord: new Coord(left, top), handle: outputHandle);
	}

	public void SetWindowPosition(int left, int top)
	{
		ConsoleScreenBufferInfo info = default(ConsoleScreenBufferInfo);
		GetConsoleScreenBufferInfo(outputHandle, out info);
		SmallRect rect = info.Window;
		rect.Left = (short)left;
		rect.Top = (short)top;
		if (!SetConsoleWindowInfo(outputHandle, absolute: true, ref rect))
		{
			throw new ArgumentOutOfRangeException("left/top", "Windows error " + Marshal.GetLastWin32Error());
		}
	}

	public void SetWindowSize(int width, int height)
	{
		ConsoleScreenBufferInfo info = default(ConsoleScreenBufferInfo);
		GetConsoleScreenBufferInfo(outputHandle, out info);
		SmallRect rect = info.Window;
		rect.Right = (short)(rect.Left + width - 1);
		rect.Bottom = (short)(rect.Top + height - 1);
		if (!SetConsoleWindowInfo(outputHandle, absolute: true, ref rect))
		{
			throw new ArgumentOutOfRangeException("left/top", "Windows error " + Marshal.GetLastWin32Error());
		}
	}

	private static bool IsModifierKey(short virtualKeyCode)
	{
		if ((uint)(virtualKeyCode - 16) <= 2u || virtualKeyCode == 20 || (uint)(virtualKeyCode - 144) <= 1u)
		{
			return true;
		}
		return false;
	}

	[DllImport("kernel32.dll", CharSet = CharSet.Unicode, SetLastError = true)]
	private static extern IntPtr GetStdHandle(Handles handle);

	[DllImport("kernel32.dll", CharSet = CharSet.Unicode, EntryPoint = "Beep", SetLastError = true)]
	private static extern void _Beep(int frequency, int duration);

	[DllImport("kernel32.dll", CharSet = CharSet.Unicode, SetLastError = true)]
	private static extern bool GetConsoleScreenBufferInfo(IntPtr handle, out ConsoleScreenBufferInfo info);

	[DllImport("kernel32.dll", CharSet = CharSet.Unicode, SetLastError = true)]
	private static extern bool FillConsoleOutputCharacter(IntPtr handle, char c, int size, Coord coord, out int written);

	[DllImport("kernel32.dll", CharSet = CharSet.Unicode, SetLastError = true)]
	private static extern bool FillConsoleOutputAttribute(IntPtr handle, short c, int size, Coord coord, out int written);

	[DllImport("kernel32.dll", CharSet = CharSet.Unicode, SetLastError = true)]
	private static extern bool SetConsoleCursorPosition(IntPtr handle, Coord coord);

	[DllImport("kernel32.dll", CharSet = CharSet.Unicode, SetLastError = true)]
	private static extern bool SetConsoleTextAttribute(IntPtr handle, short attribute);

	[DllImport("kernel32.dll", CharSet = CharSet.Unicode, SetLastError = true)]
	private static extern bool SetConsoleScreenBufferSize(IntPtr handle, Coord newSize);

	[DllImport("kernel32.dll", CharSet = CharSet.Unicode, SetLastError = true)]
	private static extern bool SetConsoleWindowInfo(IntPtr handle, bool absolute, ref SmallRect rect);

	[DllImport("kernel32.dll", CharSet = CharSet.Unicode, SetLastError = true)]
	private static extern int GetConsoleTitle(StringBuilder sb, int size);

	[DllImport("kernel32.dll", CharSet = CharSet.Unicode, SetLastError = true)]
	private static extern bool SetConsoleTitle(string title);

	[DllImport("kernel32.dll", CharSet = CharSet.Unicode, SetLastError = true)]
	private static extern bool GetConsoleCursorInfo(IntPtr handle, out ConsoleCursorInfo info);

	[DllImport("kernel32.dll", CharSet = CharSet.Unicode, SetLastError = true)]
	private static extern bool SetConsoleCursorInfo(IntPtr handle, ref ConsoleCursorInfo info);

	[DllImport("user32.dll", CharSet = CharSet.Unicode, SetLastError = true)]
	private static extern short GetKeyState(int virtKey);

	[DllImport("kernel32.dll", CharSet = CharSet.Unicode, SetLastError = true)]
	private static extern bool GetConsoleMode(IntPtr handle, out int mode);

	[DllImport("kernel32.dll", CharSet = CharSet.Unicode, SetLastError = true)]
	private static extern bool SetConsoleMode(IntPtr handle, int mode);

	[DllImport("kernel32.dll", CharSet = CharSet.Unicode, SetLastError = true)]
	private static extern bool PeekConsoleInput(IntPtr handle, out InputRecord record, int length, out int eventsRead);

	[DllImport("kernel32.dll", CharSet = CharSet.Unicode, SetLastError = true)]
	private static extern bool ReadConsoleInput(IntPtr handle, out InputRecord record, int length, out int nread);

	[DllImport("kernel32.dll", CharSet = CharSet.Unicode, SetLastError = true)]
	private static extern Coord GetLargestConsoleWindowSize(IntPtr handle);

	[DllImport("kernel32.dll", CharSet = CharSet.Unicode, SetLastError = true)]
	private unsafe static extern bool ReadConsoleOutput(IntPtr handle, void* buffer, Coord bsize, Coord bpos, ref SmallRect region);

	[DllImport("kernel32.dll", CharSet = CharSet.Unicode, SetLastError = true)]
	private static extern bool WriteConsoleOutput(IntPtr handle, CharInfo[] buffer, Coord bsize, Coord bpos, ref SmallRect region);
}
