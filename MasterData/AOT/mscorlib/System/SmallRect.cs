namespace System;

internal struct SmallRect(int left, int top, int right, int bottom)
{
	public short Left = (short)left;

	public short Top = (short)top;

	public short Right = (short)right;

	public short Bottom = (short)bottom;
}
