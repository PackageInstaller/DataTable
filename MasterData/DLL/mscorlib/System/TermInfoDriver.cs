using System.Collections;
using System.IO;
using System.Runtime.InteropServices;
using System.Text;

namespace System;

internal class TermInfoDriver : IConsoleDriver
{
	private unsafe static int* native_terminal_size;

	private static int terminal_size;

	private static readonly string[] locations = new string[4] { "/usr/share/terminfo", "/etc/terminfo", "/usr/lib/terminfo", "/lib/terminfo" };

	private TermInfoReader reader;

	private int cursorLeft;

	private int cursorTop;

	private string title = string.Empty;

	private string titleFormat = string.Empty;

	private bool cursorVisible = true;

	private string csrVisible;

	private string csrInvisible;

	private string clear;

	private string bell;

	private string term;

	private StreamReader stdin;

	private CStreamWriter stdout;

	private int windowWidth;

	private int windowHeight;

	private int bufferHeight;

	private int bufferWidth;

	private char[] buffer;

	private int readpos;

	private int writepos;

	private string keypadXmit;

	private string keypadLocal;

	private bool controlCAsInput;

	private bool inited;

	private object initLock = new object();

	private bool initKeys;

	private string origPair;

	private string origColors;

	private string cursorAddress;

	private ConsoleColor fgcolor = ConsoleColor.White;

	private ConsoleColor bgcolor;

	private string setfgcolor;

	private string setbgcolor;

	private int maxColors;

	private bool noGetPosition;

	private Hashtable keymap;

	private ByteMatcher rootmap;

	private int rl_startx = -1;

	private int rl_starty = -1;

	private byte[] control_characters;

	private static readonly int[] _consoleColorToAnsiCode = new int[16]
	{
		250, 89, 71, 240, 173, 212, 162, 175, 156, 164,
		114, 192, 183, 253, 147, 38
	};

	private char[] echobuf;

	private int echon;

	public bool Initialized => inited;

	public ConsoleColor BackgroundColor
	{
		get
		{
			if (!inited)
			{
				Init();
			}
			return bgcolor;
		}
		set
		{
			if (!inited)
			{
				Init();
			}
			ChangeColor(setbgcolor, value);
			bgcolor = value;
		}
	}

	public ConsoleColor ForegroundColor
	{
		get
		{
			if (!inited)
			{
				Init();
			}
			return fgcolor;
		}
		set
		{
			if (!inited)
			{
				Init();
			}
			ChangeColor(setfgcolor, value);
			fgcolor = value;
		}
	}

	public int BufferHeight
	{
		get
		{
			if (!inited)
			{
				Init();
			}
			CheckWindowDimensions();
			return bufferHeight;
		}
		set
		{
			if (!inited)
			{
				Init();
			}
			throw new NotSupportedException();
		}
	}

	public int BufferWidth
	{
		get
		{
			if (!inited)
			{
				Init();
			}
			CheckWindowDimensions();
			return bufferWidth;
		}
		set
		{
			if (!inited)
			{
				Init();
			}
			throw new NotSupportedException();
		}
	}

	public bool CapsLock
	{
		get
		{
			if (!inited)
			{
				Init();
			}
			return false;
		}
	}

	public int CursorLeft
	{
		get
		{
			if (!inited)
			{
				Init();
			}
			return cursorLeft;
		}
		set
		{
			if (!inited)
			{
				Init();
			}
			SetCursorPosition(value, CursorTop);
		}
	}

	public int CursorTop
	{
		get
		{
			if (!inited)
			{
				Init();
			}
			return cursorTop;
		}
		set
		{
			if (!inited)
			{
				Init();
			}
			SetCursorPosition(CursorLeft, value);
		}
	}

	public bool CursorVisible
	{
		get
		{
			if (!inited)
			{
				Init();
			}
			return cursorVisible;
		}
		set
		{
			if (!inited)
			{
				Init();
			}
			cursorVisible = value;
			WriteConsole(value ? csrVisible : csrInvisible);
		}
	}

	[MonoTODO]
	public int CursorSize
	{
		get
		{
			if (!inited)
			{
				Init();
			}
			return 1;
		}
		set
		{
			if (!inited)
			{
				Init();
			}
		}
	}

	public bool KeyAvailable
	{
		get
		{
			if (!inited)
			{
				Init();
			}
			if (writepos <= readpos)
			{
				return ConsoleDriver.InternalKeyAvailable(0) > 0;
			}
			return true;
		}
	}

	public int LargestWindowHeight => WindowHeight;

	public int LargestWindowWidth => WindowWidth;

	public bool NumberLock
	{
		get
		{
			if (!inited)
			{
				Init();
			}
			return false;
		}
	}

	public string Title
	{
		get
		{
			if (!inited)
			{
				Init();
			}
			return title;
		}
		set
		{
			if (!inited)
			{
				Init();
			}
			title = value;
			WriteConsole(string.Format(titleFormat, value));
		}
	}

	public bool TreatControlCAsInput
	{
		get
		{
			if (!inited)
			{
				Init();
			}
			return controlCAsInput;
		}
		set
		{
			if (!inited)
			{
				Init();
			}
			if (controlCAsInput != value)
			{
				ConsoleDriver.SetBreak(value);
				controlCAsInput = value;
			}
		}
	}

	public int WindowHeight
	{
		get
		{
			if (!inited)
			{
				Init();
			}
			CheckWindowDimensions();
			return windowHeight;
		}
		set
		{
			if (!inited)
			{
				Init();
			}
			throw new NotSupportedException();
		}
	}

	public int WindowLeft
	{
		get
		{
			if (!inited)
			{
				Init();
			}
			return 0;
		}
		set
		{
			if (!inited)
			{
				Init();
			}
			throw new NotSupportedException();
		}
	}

	public int WindowTop
	{
		get
		{
			if (!inited)
			{
				Init();
			}
			return 0;
		}
		set
		{
			if (!inited)
			{
				Init();
			}
			throw new NotSupportedException();
		}
	}

	public int WindowWidth
	{
		get
		{
			if (!inited)
			{
				Init();
			}
			CheckWindowDimensions();
			return windowWidth;
		}
		set
		{
			if (!inited)
			{
				Init();
			}
			throw new NotSupportedException();
		}
	}

	private static string TryTermInfoDir(string dir, string term)
	{
		string text = $"{dir}/{(int)term[0]:x}/{term}";
		if (File.Exists(text))
		{
			return text;
		}
		text = Path.Combine(dir, term.Substring(0, 1), term);
		if (File.Exists(text))
		{
			return text;
		}
		return null;
	}

	private static string SearchTerminfo(string term)
	{
		if (term == null || term == string.Empty)
		{
			return null;
		}
		string environmentVariable = Environment.GetEnvironmentVariable("TERMINFO");
		if (environmentVariable != null && Directory.Exists(environmentVariable))
		{
			string text = TryTermInfoDir(environmentVariable, term);
			if (text != null)
			{
				return text;
			}
		}
		string[] array = locations;
		foreach (string text2 in array)
		{
			if (Directory.Exists(text2))
			{
				string text = TryTermInfoDir(text2, term);
				if (text != null)
				{
					return text;
				}
			}
		}
		return null;
	}

	private void WriteConsole(string str)
	{
		if (str != null)
		{
			stdout.InternalWriteString(str);
		}
	}

	public TermInfoDriver(string term)
	{
		this.term = term;
		string text = SearchTerminfo(term);
		if (text != null)
		{
			reader = new TermInfoReader(term, text);
		}
		else if (term == "xterm")
		{
			reader = new TermInfoReader(term, KnownTerminals.xterm);
		}
		else if (term == "linux")
		{
			reader = new TermInfoReader(term, KnownTerminals.linux);
		}
		if (reader == null)
		{
			reader = new TermInfoReader(term, KnownTerminals.ansi);
		}
		if (!(Console.stdout is CStreamWriter))
		{
			stdout = new CStreamWriter(Console.OpenStandardOutput(0), Console.OutputEncoding, leaveOpen: false);
			stdout.AutoFlush = true;
		}
		else
		{
			stdout = (CStreamWriter)Console.stdout;
		}
	}

	public unsafe void Init()
	{
		if (inited)
		{
			return;
		}
		lock (initLock)
		{
			if (inited)
			{
				return;
			}
			try
			{
				if (!ConsoleDriver.IsConsole)
				{
					throw new IOException("Not a tty.");
				}
				ConsoleDriver.SetEcho(wantEcho: false);
				string text = null;
				keypadXmit = reader.Get(TermInfoStrings.KeypadXmit);
				keypadLocal = reader.Get(TermInfoStrings.KeypadLocal);
				if (keypadXmit != null)
				{
					WriteConsole(keypadXmit);
					if (keypadLocal != null)
					{
						text += keypadLocal;
					}
				}
				origPair = reader.Get(TermInfoStrings.OrigPair);
				origColors = reader.Get(TermInfoStrings.OrigColors);
				setfgcolor = reader.Get(TermInfoStrings.SetAForeground);
				setbgcolor = reader.Get(TermInfoStrings.SetABackground);
				maxColors = reader.Get(TermInfoNumbers.MaxColors);
				maxColors = Math.Max(Math.Min(maxColors, 16), 1);
				string text2 = ((origColors == null) ? origPair : origColors);
				if (text2 != null)
				{
					text += text2;
				}
				if (!ConsoleDriver.TtySetup(keypadXmit, text, out control_characters, out native_terminal_size))
				{
					control_characters = new byte[17];
					native_terminal_size = null;
				}
				stdin = new StreamReader(Console.OpenStandardInput(0), Console.InputEncoding);
				clear = reader.Get(TermInfoStrings.ClearScreen);
				bell = reader.Get(TermInfoStrings.Bell);
				if (clear == null)
				{
					clear = reader.Get(TermInfoStrings.CursorHome);
					clear += reader.Get(TermInfoStrings.ClrEos);
				}
				csrVisible = reader.Get(TermInfoStrings.CursorNormal);
				if (csrVisible == null)
				{
					csrVisible = reader.Get(TermInfoStrings.CursorVisible);
				}
				csrInvisible = reader.Get(TermInfoStrings.CursorInvisible);
				if (term == "cygwin" || term == "linux" || (term != null && term.StartsWith("xterm")) || term == "rxvt" || term == "dtterm")
				{
					titleFormat = "\u001b]0;{0}\a";
				}
				else if (term == "iris-ansi")
				{
					titleFormat = "\u001bP1.y{0}\u001b\\";
				}
				else if (term == "sun-cmd")
				{
					titleFormat = "\u001b]l{0}\u001b\\";
				}
				cursorAddress = reader.Get(TermInfoStrings.CursorAddress);
				GetCursorPosition();
				if (noGetPosition)
				{
					WriteConsole(clear);
					cursorLeft = 0;
					cursorTop = 0;
				}
			}
			finally
			{
				inited = true;
			}
		}
	}

	private void IncrementX()
	{
		cursorLeft++;
		if (cursorLeft < WindowWidth)
		{
			return;
		}
		cursorTop++;
		cursorLeft = 0;
		if (cursorTop >= WindowHeight)
		{
			if (rl_starty != -1)
			{
				rl_starty--;
			}
			cursorTop--;
		}
	}

	public void WriteSpecialKey(ConsoleKeyInfo key)
	{
		switch (key.Key)
		{
		case ConsoleKey.Backspace:
			if (cursorLeft > 0 && (cursorLeft > rl_startx || cursorTop != rl_starty))
			{
				cursorLeft--;
				SetCursorPosition(cursorLeft, cursorTop);
				WriteConsole(" ");
				SetCursorPosition(cursorLeft, cursorTop);
			}
			break;
		case ConsoleKey.Tab:
		{
			int num = 8 - cursorLeft % 8;
			for (int i = 0; i < num; i++)
			{
				IncrementX();
			}
			WriteConsole("\t");
			break;
		}
		case ConsoleKey.Clear:
			WriteConsole(clear);
			cursorLeft = 0;
			cursorTop = 0;
			break;
		case (ConsoleKey)10:
		case (ConsoleKey)11:
		case ConsoleKey.Enter:
			break;
		}
	}

	public void WriteSpecialKey(char c)
	{
		WriteSpecialKey(CreateKeyInfoFromInt(c, alt: false));
	}

	public bool IsSpecialKey(ConsoleKeyInfo key)
	{
		if (!inited)
		{
			return false;
		}
		switch (key.Key)
		{
		case ConsoleKey.Backspace:
			return true;
		case ConsoleKey.Tab:
			return true;
		case ConsoleKey.Clear:
			return true;
		case ConsoleKey.Enter:
			cursorLeft = 0;
			cursorTop++;
			if (cursorTop >= WindowHeight)
			{
				cursorTop--;
			}
			return false;
		default:
			IncrementX();
			return false;
		}
	}

	public bool IsSpecialKey(char c)
	{
		return IsSpecialKey(CreateKeyInfoFromInt(c, alt: false));
	}

	private void ChangeColor(string format, ConsoleColor color)
	{
		if (!string.IsNullOrEmpty(format))
		{
			if ((color & (ConsoleColor)(-16)) != ConsoleColor.Black)
			{
				throw new ArgumentException("Invalid Console Color");
			}
			int num = _consoleColorToAnsiCode[(int)color] % maxColors;
			WriteConsole(ParameterizedStrings.Evaluate(format, num));
		}
	}

	private void GetCursorPosition()
	{
		int num = 0;
		int num2 = 0;
		int num3 = ConsoleDriver.InternalKeyAvailable(0);
		int b;
		while (num3-- > 0)
		{
			b = stdin.Read();
			AddToBuffer(b);
		}
		WriteConsole("\u001b[6n");
		if (ConsoleDriver.InternalKeyAvailable(1000) <= 0)
		{
			noGetPosition = true;
			return;
		}
		for (b = stdin.Read(); b != 27; b = stdin.Read())
		{
			AddToBuffer(b);
			if (ConsoleDriver.InternalKeyAvailable(100) <= 0)
			{
				return;
			}
		}
		b = stdin.Read();
		if (b != 91)
		{
			AddToBuffer(27);
			AddToBuffer(b);
			return;
		}
		b = stdin.Read();
		if (b != 59)
		{
			num = b - 48;
			b = stdin.Read();
			while (b >= 48 && b <= 57)
			{
				num = num * 10 + b - 48;
				b = stdin.Read();
			}
			num--;
		}
		b = stdin.Read();
		if (b != 82)
		{
			num2 = b - 48;
			b = stdin.Read();
			while (b >= 48 && b <= 57)
			{
				num2 = num2 * 10 + b - 48;
				b = stdin.Read();
			}
			num2--;
		}
		cursorLeft = num2;
		cursorTop = num;
	}

	private unsafe void CheckWindowDimensions()
	{
		if (native_terminal_size == null || terminal_size == *native_terminal_size)
		{
			return;
		}
		if (*native_terminal_size == -1)
		{
			int num = reader.Get(TermInfoNumbers.Columns);
			if (num != 0)
			{
				windowWidth = num;
			}
			num = reader.Get(TermInfoNumbers.Lines);
			if (num != 0)
			{
				windowHeight = num;
			}
		}
		else
		{
			terminal_size = *native_terminal_size;
			windowWidth = terminal_size >> 16;
			windowHeight = terminal_size & 0xFFFF;
		}
		bufferHeight = windowHeight;
		bufferWidth = windowWidth;
	}

	public void Clear()
	{
		if (!inited)
		{
			Init();
		}
		WriteConsole(clear);
		cursorLeft = 0;
		cursorTop = 0;
	}

	public void Beep(int frequency, int duration)
	{
		if (!inited)
		{
			Init();
		}
		WriteConsole(bell);
	}

	public void MoveBufferArea(int sourceLeft, int sourceTop, int sourceWidth, int sourceHeight, int targetLeft, int targetTop, char sourceChar, ConsoleColor sourceForeColor, ConsoleColor sourceBackColor)
	{
		if (!inited)
		{
			Init();
		}
		throw new NotImplementedException();
	}

	private void AddToBuffer(int b)
	{
		if (buffer == null)
		{
			buffer = new char[1024];
		}
		else if (writepos >= buffer.Length)
		{
			char[] dst = new char[buffer.Length * 2];
			Buffer.BlockCopy(buffer, 0, dst, 0, buffer.Length);
			buffer = dst;
		}
		buffer[writepos++] = (char)b;
	}

	private void AdjustBuffer()
	{
		if (readpos >= writepos)
		{
			readpos = (writepos = 0);
		}
	}

	private ConsoleKeyInfo CreateKeyInfoFromInt(int n, bool alt)
	{
		char keyChar = (char)n;
		ConsoleKey key = (ConsoleKey)n;
		bool shift = false;
		bool control = false;
		switch (n)
		{
		case 10:
			key = ConsoleKey.Enter;
			break;
		case 32:
			key = ConsoleKey.Spacebar;
			break;
		case 45:
			key = ConsoleKey.Subtract;
			break;
		case 43:
			key = ConsoleKey.Add;
			break;
		case 47:
			key = ConsoleKey.Divide;
			break;
		case 42:
			key = ConsoleKey.Multiply;
			break;
		case 27:
			key = ConsoleKey.Escape;
			break;
		default:
			if (n >= 1 && n <= 26)
			{
				control = true;
				key = (ConsoleKey)(65 + n - 1);
			}
			else if (n >= 97 && n <= 122)
			{
				key = (ConsoleKey)(-32 + n);
			}
			else if (n >= 65 && n <= 90)
			{
				shift = true;
			}
			else if (n < 48 || n > 57)
			{
				key = (ConsoleKey)0;
			}
			break;
		case 8:
		case 9:
		case 12:
		case 13:
		case 19:
			break;
		}
		return new ConsoleKeyInfo(keyChar, key, shift, alt, control);
	}

	private object GetKeyFromBuffer(bool cooked)
	{
		if (readpos >= writepos)
		{
			return null;
		}
		int num = buffer[readpos];
		if (!cooked || !rootmap.StartsWith(num))
		{
			readpos++;
			AdjustBuffer();
			return CreateKeyInfoFromInt(num, alt: false);
		}
		TermInfoStrings termInfoStrings = rootmap.Match(buffer, readpos, writepos - readpos, out var used);
		if (termInfoStrings == (TermInfoStrings)(-1))
		{
			if (buffer[readpos] == '\u001b' && writepos - readpos >= 2)
			{
				readpos += 2;
				AdjustBuffer();
				if (buffer[readpos + 1] == '\u007f')
				{
					return new ConsoleKeyInfo('\b', ConsoleKey.Backspace, shift: false, alt: true, control: false);
				}
				return CreateKeyInfoFromInt(buffer[readpos + 1], alt: true);
			}
			return null;
		}
		if (keymap[termInfoStrings] != null)
		{
			ConsoleKeyInfo consoleKeyInfo = (ConsoleKeyInfo)keymap[termInfoStrings];
			readpos += used;
			AdjustBuffer();
			return consoleKeyInfo;
		}
		readpos++;
		AdjustBuffer();
		return CreateKeyInfoFromInt(num, alt: false);
	}

	private ConsoleKeyInfo ReadKeyInternal(out bool fresh)
	{
		if (!inited)
		{
			Init();
		}
		InitKeys();
		object keyFromBuffer;
		if ((keyFromBuffer = GetKeyFromBuffer(cooked: true)) == null)
		{
			do
			{
				if (ConsoleDriver.InternalKeyAvailable(150) > 0)
				{
					do
					{
						AddToBuffer(stdin.Read());
					}
					while (ConsoleDriver.InternalKeyAvailable(0) > 0);
				}
				else if (stdin.DataAvailable())
				{
					do
					{
						AddToBuffer(stdin.Read());
					}
					while (stdin.DataAvailable());
				}
				else
				{
					if ((keyFromBuffer = GetKeyFromBuffer(cooked: false)) != null)
					{
						break;
					}
					AddToBuffer(stdin.Read());
				}
				keyFromBuffer = GetKeyFromBuffer(cooked: true);
			}
			while (keyFromBuffer == null);
			fresh = true;
		}
		else
		{
			fresh = false;
		}
		return (ConsoleKeyInfo)keyFromBuffer;
	}

	private bool InputPending()
	{
		if (readpos >= writepos)
		{
			return stdin.DataAvailable();
		}
		return true;
	}

	private void QueueEcho(char c)
	{
		if (echobuf == null)
		{
			echobuf = new char[1024];
		}
		echobuf[echon++] = c;
		if (echon == echobuf.Length || !InputPending())
		{
			stdout.InternalWriteChars(echobuf, echon);
			echon = 0;
		}
	}

	private void Echo(ConsoleKeyInfo key)
	{
		if (!IsSpecialKey(key))
		{
			QueueEcho(key.KeyChar);
			return;
		}
		EchoFlush();
		WriteSpecialKey(key);
	}

	private void EchoFlush()
	{
		if (echon != 0)
		{
			stdout.InternalWriteChars(echobuf, echon);
			echon = 0;
		}
	}

	public int Read([In][Out] char[] dest, int index, int count)
	{
		bool flag = false;
		int num = 0;
		StringBuilder stringBuilder = new StringBuilder();
		object keyFromBuffer;
		ConsoleKeyInfo consoleKeyInfo;
		while ((keyFromBuffer = GetKeyFromBuffer(cooked: true)) != null)
		{
			consoleKeyInfo = (ConsoleKeyInfo)keyFromBuffer;
			char keyChar = consoleKeyInfo.KeyChar;
			if (consoleKeyInfo.Key != ConsoleKey.Backspace)
			{
				if (consoleKeyInfo.Key == ConsoleKey.Enter)
				{
					num = stringBuilder.Length;
				}
				stringBuilder.Append(keyChar);
			}
			else if (stringBuilder.Length > num)
			{
				stringBuilder.Length--;
			}
		}
		rl_startx = cursorLeft;
		rl_starty = cursorTop;
		do
		{
			consoleKeyInfo = ReadKeyInternal(out var fresh);
			flag |= fresh;
			char keyChar = consoleKeyInfo.KeyChar;
			if (consoleKeyInfo.Key != ConsoleKey.Backspace)
			{
				if (consoleKeyInfo.Key == ConsoleKey.Enter)
				{
					num = stringBuilder.Length;
				}
				stringBuilder.Append(keyChar);
			}
			else
			{
				if (stringBuilder.Length <= num)
				{
					continue;
				}
				stringBuilder.Length--;
			}
			if (flag)
			{
				Echo(consoleKeyInfo);
			}
		}
		while (consoleKeyInfo.Key != ConsoleKey.Enter);
		EchoFlush();
		rl_startx = -1;
		rl_starty = -1;
		int num2 = 0;
		while (count > 0 && num2 < stringBuilder.Length)
		{
			dest[index + num2] = stringBuilder[num2];
			num2++;
			count--;
		}
		for (int i = num2; i < stringBuilder.Length; i++)
		{
			AddToBuffer(stringBuilder[i]);
		}
		return num2;
	}

	public ConsoleKeyInfo ReadKey(bool intercept)
	{
		ConsoleKeyInfo consoleKeyInfo = ReadKeyInternal(out var fresh);
		if (!intercept & fresh)
		{
			Echo(consoleKeyInfo);
			EchoFlush();
		}
		return consoleKeyInfo;
	}

	public string ReadLine()
	{
		return ReadUntilConditionInternal(haltOnNewLine: true);
	}

	public string ReadToEnd()
	{
		return ReadUntilConditionInternal(haltOnNewLine: false);
	}

	private string ReadUntilConditionInternal(bool haltOnNewLine)
	{
		if (!inited)
		{
			Init();
		}
		GetCursorPosition();
		StringBuilder stringBuilder = new StringBuilder();
		bool flag = false;
		rl_startx = cursorLeft;
		rl_starty = cursorTop;
		char c = (char)control_characters[4];
		int num;
		do
		{
			ConsoleKeyInfo key = ReadKeyInternal(out var fresh);
			flag |= fresh;
			char keyChar = key.KeyChar;
			if (keyChar == c && keyChar != 0 && stringBuilder.Length == 0)
			{
				return null;
			}
			if (haltOnNewLine)
			{
				num = ((key.Key == ConsoleKey.Enter) ? 1 : 0);
				if (num != 0)
				{
					goto IL_00ac;
				}
			}
			else
			{
				num = 0;
			}
			if (key.Key != ConsoleKey.Backspace)
			{
				stringBuilder.Append(keyChar);
			}
			else
			{
				if (stringBuilder.Length <= 0)
				{
					continue;
				}
				stringBuilder.Length--;
			}
			goto IL_00ac;
			IL_00ac:
			if (flag)
			{
				Echo(key);
			}
		}
		while (num == 0);
		EchoFlush();
		rl_startx = -1;
		rl_starty = -1;
		return stringBuilder.ToString();
	}

	public void ResetColor()
	{
		if (!inited)
		{
			Init();
		}
		string str = ((origPair != null) ? origPair : origColors);
		WriteConsole(str);
	}

	public void SetBufferSize(int width, int height)
	{
		if (!inited)
		{
			Init();
		}
		throw new NotImplementedException(string.Empty);
	}

	public void SetCursorPosition(int left, int top)
	{
		if (!inited)
		{
			Init();
		}
		CheckWindowDimensions();
		if (left < 0 || left >= bufferWidth)
		{
			throw new ArgumentOutOfRangeException("left", "Value must be positive and below the buffer width.");
		}
		if (top < 0 || top >= bufferHeight)
		{
			throw new ArgumentOutOfRangeException("top", "Value must be positive and below the buffer height.");
		}
		if (cursorAddress == null)
		{
			throw new NotSupportedException("This terminal does not suport setting the cursor position.");
		}
		WriteConsole(ParameterizedStrings.Evaluate(cursorAddress, top, left));
		cursorLeft = left;
		cursorTop = top;
	}

	public void SetWindowPosition(int left, int top)
	{
		if (!inited)
		{
			Init();
		}
	}

	public void SetWindowSize(int width, int height)
	{
		if (!inited)
		{
			Init();
		}
	}

	private void CreateKeyMap()
	{
		keymap = new Hashtable();
		keymap[TermInfoStrings.KeyBackspace] = new ConsoleKeyInfo('\0', ConsoleKey.Backspace, shift: false, alt: false, control: false);
		keymap[TermInfoStrings.KeyClear] = new ConsoleKeyInfo('\0', ConsoleKey.Clear, shift: false, alt: false, control: false);
		keymap[TermInfoStrings.KeyDown] = new ConsoleKeyInfo('\0', ConsoleKey.DownArrow, shift: false, alt: false, control: false);
		keymap[TermInfoStrings.KeyF1] = new ConsoleKeyInfo('\0', ConsoleKey.F1, shift: false, alt: false, control: false);
		keymap[TermInfoStrings.KeyF10] = new ConsoleKeyInfo('\0', ConsoleKey.F10, shift: false, alt: false, control: false);
		keymap[TermInfoStrings.KeyF2] = new ConsoleKeyInfo('\0', ConsoleKey.F2, shift: false, alt: false, control: false);
		keymap[TermInfoStrings.KeyF3] = new ConsoleKeyInfo('\0', ConsoleKey.F3, shift: false, alt: false, control: false);
		keymap[TermInfoStrings.KeyF4] = new ConsoleKeyInfo('\0', ConsoleKey.F4, shift: false, alt: false, control: false);
		keymap[TermInfoStrings.KeyF5] = new ConsoleKeyInfo('\0', ConsoleKey.F5, shift: false, alt: false, control: false);
		keymap[TermInfoStrings.KeyF6] = new ConsoleKeyInfo('\0', ConsoleKey.F6, shift: false, alt: false, control: false);
		keymap[TermInfoStrings.KeyF7] = new ConsoleKeyInfo('\0', ConsoleKey.F7, shift: false, alt: false, control: false);
		keymap[TermInfoStrings.KeyF8] = new ConsoleKeyInfo('\0', ConsoleKey.F8, shift: false, alt: false, control: false);
		keymap[TermInfoStrings.KeyF9] = new ConsoleKeyInfo('\0', ConsoleKey.F9, shift: false, alt: false, control: false);
		keymap[TermInfoStrings.KeyHome] = new ConsoleKeyInfo('\0', ConsoleKey.Home, shift: false, alt: false, control: false);
		keymap[TermInfoStrings.KeyLeft] = new ConsoleKeyInfo('\0', ConsoleKey.LeftArrow, shift: false, alt: false, control: false);
		keymap[TermInfoStrings.KeyLl] = new ConsoleKeyInfo('\0', ConsoleKey.NumPad1, shift: false, alt: false, control: false);
		keymap[TermInfoStrings.KeyNpage] = new ConsoleKeyInfo('\0', ConsoleKey.PageDown, shift: false, alt: false, control: false);
		keymap[TermInfoStrings.KeyPpage] = new ConsoleKeyInfo('\0', ConsoleKey.PageUp, shift: false, alt: false, control: false);
		keymap[TermInfoStrings.KeyRight] = new ConsoleKeyInfo('\0', ConsoleKey.RightArrow, shift: false, alt: false, control: false);
		keymap[TermInfoStrings.KeySf] = new ConsoleKeyInfo('\0', ConsoleKey.PageDown, shift: false, alt: false, control: false);
		keymap[TermInfoStrings.KeySr] = new ConsoleKeyInfo('\0', ConsoleKey.PageUp, shift: false, alt: false, control: false);
		keymap[TermInfoStrings.KeyUp] = new ConsoleKeyInfo('\0', ConsoleKey.UpArrow, shift: false, alt: false, control: false);
		keymap[TermInfoStrings.KeyA1] = new ConsoleKeyInfo('\0', ConsoleKey.NumPad7, shift: false, alt: false, control: false);
		keymap[TermInfoStrings.KeyA3] = new ConsoleKeyInfo('\0', ConsoleKey.NumPad9, shift: false, alt: false, control: false);
		keymap[TermInfoStrings.KeyB2] = new ConsoleKeyInfo('\0', ConsoleKey.NumPad5, shift: false, alt: false, control: false);
		keymap[TermInfoStrings.KeyC1] = new ConsoleKeyInfo('\0', ConsoleKey.NumPad1, shift: false, alt: false, control: false);
		keymap[TermInfoStrings.KeyC3] = new ConsoleKeyInfo('\0', ConsoleKey.NumPad3, shift: false, alt: false, control: false);
		keymap[TermInfoStrings.KeyBtab] = new ConsoleKeyInfo('\0', ConsoleKey.Tab, shift: true, alt: false, control: false);
		keymap[TermInfoStrings.KeyBeg] = new ConsoleKeyInfo('\0', ConsoleKey.Home, shift: false, alt: false, control: false);
		keymap[TermInfoStrings.KeyCopy] = new ConsoleKeyInfo('C', ConsoleKey.C, shift: false, alt: true, control: false);
		keymap[TermInfoStrings.KeyEnd] = new ConsoleKeyInfo('\0', ConsoleKey.End, shift: false, alt: false, control: false);
		keymap[TermInfoStrings.KeyEnter] = new ConsoleKeyInfo('\n', ConsoleKey.Enter, shift: false, alt: false, control: false);
		keymap[TermInfoStrings.KeyHelp] = new ConsoleKeyInfo('\0', ConsoleKey.Help, shift: false, alt: false, control: false);
		keymap[TermInfoStrings.KeyPrint] = new ConsoleKeyInfo('\0', ConsoleKey.Print, shift: false, alt: false, control: false);
		keymap[TermInfoStrings.KeyUndo] = new ConsoleKeyInfo('Z', ConsoleKey.Z, shift: false, alt: true, control: false);
		keymap[TermInfoStrings.KeySbeg] = new ConsoleKeyInfo('\0', ConsoleKey.Home, shift: true, alt: false, control: false);
		keymap[TermInfoStrings.KeyScopy] = new ConsoleKeyInfo('C', ConsoleKey.C, shift: true, alt: true, control: false);
		keymap[TermInfoStrings.KeySdc] = new ConsoleKeyInfo('\t', ConsoleKey.Delete, shift: true, alt: false, control: false);
		keymap[TermInfoStrings.KeyShelp] = new ConsoleKeyInfo('\0', ConsoleKey.Help, shift: true, alt: false, control: false);
		keymap[TermInfoStrings.KeyShome] = new ConsoleKeyInfo('\0', ConsoleKey.Home, shift: true, alt: false, control: false);
		keymap[TermInfoStrings.KeySleft] = new ConsoleKeyInfo('\0', ConsoleKey.LeftArrow, shift: true, alt: false, control: false);
		keymap[TermInfoStrings.KeySprint] = new ConsoleKeyInfo('\0', ConsoleKey.Print, shift: true, alt: false, control: false);
		keymap[TermInfoStrings.KeySright] = new ConsoleKeyInfo('\0', ConsoleKey.RightArrow, shift: true, alt: false, control: false);
		keymap[TermInfoStrings.KeySundo] = new ConsoleKeyInfo('Z', ConsoleKey.Z, shift: true, alt: false, control: false);
		keymap[TermInfoStrings.KeyF11] = new ConsoleKeyInfo('\0', ConsoleKey.F11, shift: false, alt: false, control: false);
		keymap[TermInfoStrings.KeyF12] = new ConsoleKeyInfo('\0', ConsoleKey.F12, shift: false, alt: false, control: false);
		keymap[TermInfoStrings.KeyF13] = new ConsoleKeyInfo('\0', ConsoleKey.F13, shift: false, alt: false, control: false);
		keymap[TermInfoStrings.KeyF14] = new ConsoleKeyInfo('\0', ConsoleKey.F14, shift: false, alt: false, control: false);
		keymap[TermInfoStrings.KeyF15] = new ConsoleKeyInfo('\0', ConsoleKey.F15, shift: false, alt: false, control: false);
		keymap[TermInfoStrings.KeyF16] = new ConsoleKeyInfo('\0', ConsoleKey.F16, shift: false, alt: false, control: false);
		keymap[TermInfoStrings.KeyF17] = new ConsoleKeyInfo('\0', ConsoleKey.F17, shift: false, alt: false, control: false);
		keymap[TermInfoStrings.KeyF18] = new ConsoleKeyInfo('\0', ConsoleKey.F18, shift: false, alt: false, control: false);
		keymap[TermInfoStrings.KeyF19] = new ConsoleKeyInfo('\0', ConsoleKey.F19, shift: false, alt: false, control: false);
		keymap[TermInfoStrings.KeyF20] = new ConsoleKeyInfo('\0', ConsoleKey.F20, shift: false, alt: false, control: false);
		keymap[TermInfoStrings.KeyF21] = new ConsoleKeyInfo('\0', ConsoleKey.F21, shift: false, alt: false, control: false);
		keymap[TermInfoStrings.KeyF22] = new ConsoleKeyInfo('\0', ConsoleKey.F22, shift: false, alt: false, control: false);
		keymap[TermInfoStrings.KeyF23] = new ConsoleKeyInfo('\0', ConsoleKey.F23, shift: false, alt: false, control: false);
		keymap[TermInfoStrings.KeyF24] = new ConsoleKeyInfo('\0', ConsoleKey.F24, shift: false, alt: false, control: false);
		keymap[TermInfoStrings.KeyDc] = new ConsoleKeyInfo('\0', ConsoleKey.Delete, shift: false, alt: false, control: false);
		keymap[TermInfoStrings.KeyIc] = new ConsoleKeyInfo('\0', ConsoleKey.Insert, shift: false, alt: false, control: false);
	}

	private void InitKeys()
	{
		if (!initKeys)
		{
			CreateKeyMap();
			rootmap = new ByteMatcher();
			TermInfoStrings[] array = new TermInfoStrings[60]
			{
				TermInfoStrings.EnterBlinkMode,
				(TermInfoStrings)59696,
				TermInfoStrings.BackTab,
				TermInfoStrings.CarriageReturn,
				TermInfoStrings.CursorInvisible,
				(TermInfoStrings)54576,
				TermInfoStrings.BackTab,
				TermInfoStrings.CarriageReturn,
				TermInfoStrings.ChangeScrollRegion,
				(TermInfoStrings)23200,
				TermInfoStrings.ChangeScrollRegion,
				TermInfoStrings.Bell,
				TermInfoStrings.DisStatusLine,
				(TermInfoStrings)27472,
				TermInfoStrings.BackTab,
				TermInfoStrings.CarriageReturn,
				TermInfoStrings.CursorDown,
				(TermInfoStrings)38608,
				TermInfoStrings.CursorDown,
				TermInfoStrings.Bell,
				TermInfoStrings.EnterInsertMode,
				(TermInfoStrings)19176,
				TermInfoStrings.BackTab,
				TermInfoStrings.CarriageReturn,
				TermInfoStrings.CursorUp,
				(TermInfoStrings)19152,
				TermInfoStrings.BackTab,
				TermInfoStrings.CarriageReturn,
				TermInfoStrings.ColumnAddress,
				(TermInfoStrings)42192,
				TermInfoStrings.ClrEol,
				TermInfoStrings.Bell,
				TermInfoStrings.EnterCaMode,
				(TermInfoStrings)53848,
				TermInfoStrings.BackTab,
				TermInfoStrings.CarriageReturn,
				TermInfoStrings.CursorMemAddress,
				(TermInfoStrings)53840,
				TermInfoStrings.BackTab,
				TermInfoStrings.CarriageReturn,
				TermInfoStrings.ClearAllTabs,
				(TermInfoStrings)54560,
				TermInfoStrings.ClearScreen,
				TermInfoStrings.Bell,
				TermInfoStrings.DownHalfLine,
				(TermInfoStrings)55968,
				TermInfoStrings.BackTab,
				TermInfoStrings.CarriageReturn,
				TermInfoStrings.CursorHome,
				(TermInfoStrings)46496,
				TermInfoStrings.BackTab,
				TermInfoStrings.CarriageReturn,
				TermInfoStrings.Bell,
				(TermInfoStrings)22224,
				TermInfoStrings.CarriageReturn,
				TermInfoStrings.Bell,
				TermInfoStrings.DeleteLine,
				(TermInfoStrings)19160,
				TermInfoStrings.BackTab,
				TermInfoStrings.CarriageReturn
			};
			foreach (TermInfoStrings s in array)
			{
				AddStringMapping(s);
			}
			rootmap.AddMapping(TermInfoStrings.KeyBackspace, new byte[1] { control_characters[2] });
			rootmap.Sort();
			initKeys = true;
		}
	}

	private void AddStringMapping(TermInfoStrings s)
	{
		byte[] stringBytes = reader.GetStringBytes(s);
		if (stringBytes != null)
		{
			rootmap.AddMapping(s, stringBytes);
		}
	}
}
