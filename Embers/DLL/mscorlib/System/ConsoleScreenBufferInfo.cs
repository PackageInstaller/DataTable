namespace System;

internal struct ConsoleScreenBufferInfo
{
	public Coord Size;

	public Coord CursorPosition;

	public short Attribute;

	public SmallRect Window;

	public Coord MaxWindowSize;
}
