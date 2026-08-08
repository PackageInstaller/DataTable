using System;

namespace CriMana;

public struct EventPoint
{
	public IntPtr cueName;

	public uint cueNameSize;

	public ulong time;

	public ulong tunit;

	public int type;

	public IntPtr paramString;

	public uint paramStringSize;

	public uint cntCallback;
}
