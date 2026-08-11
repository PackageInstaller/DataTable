namespace System;

internal struct InputRecord
{
	public short EventType;

	public bool KeyDown;

	public short RepeatCount;

	public short VirtualKeyCode;

	public short VirtualScanCode;

	public char Character;

	public int ControlKeyState;

	private int pad1;

	private bool pad2;
}
