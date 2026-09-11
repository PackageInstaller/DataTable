namespace System;

internal struct MutableDecimal
{
	public uint Flags;

	public uint High;

	public uint Low;

	public uint Mid;

	public bool IsNegative
	{
		get
		{
			return (Flags & 0x80000000u) != 0;
		}
		set
		{
			Flags = (Flags & 0x7FFFFFFF) | (uint)(value ? int.MinValue : 0);
		}
	}

	public int Scale
	{
		get
		{
			return (byte)(Flags >> 16);
		}
		set
		{
			Flags = (Flags & 0xFF00FFFFu) | (uint)(value << 16);
		}
	}
}
