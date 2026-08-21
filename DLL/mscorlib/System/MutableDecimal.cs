namespace System;

internal struct MutableDecimal
{
	public uint Flags;

	public uint High;

	public uint Low;

	public uint Mid;

	public bool IsNegative => (Flags & 0x80000000u) != 0;

	public int Scale => (byte)(Flags >> 16);
}
