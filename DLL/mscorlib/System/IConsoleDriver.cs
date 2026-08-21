namespace System;

internal interface IConsoleDriver
{
	ConsoleColor BackgroundColor { get; set; }

	int BufferHeight { get; set; }

	int BufferWidth { get; set; }

	bool CapsLock { get; }

	int CursorLeft { get; set; }

	int CursorSize { get; set; }

	int CursorTop { get; set; }

	bool CursorVisible { get; set; }

	ConsoleColor ForegroundColor { get; set; }

	bool KeyAvailable { get; }

	bool Initialized { get; }

	int LargestWindowHeight { get; }

	int LargestWindowWidth { get; }

	bool NumberLock { get; }

	string Title { get; set; }

	bool TreatControlCAsInput { get; set; }

	int WindowHeight { get; set; }

	int WindowLeft { get; set; }

	int WindowTop { get; set; }

	int WindowWidth { get; set; }

	void Init();

	void Beep(int frequency, int duration);

	void Clear();

	void MoveBufferArea(int sourceLeft, int sourceTop, int sourceWidth, int sourceHeight, int targetLeft, int targetTop, char sourceChar, ConsoleColor sourceForeColor, ConsoleColor sourceBackColor);

	ConsoleKeyInfo ReadKey(bool intercept);

	void ResetColor();

	void SetBufferSize(int width, int height);

	void SetCursorPosition(int left, int top);

	void SetWindowPosition(int left, int top);

	void SetWindowSize(int width, int height);

	string ReadLine();
}
