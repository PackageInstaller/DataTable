using System.Runtime.InteropServices;

namespace System;

[StructLayout(LayoutKind.Explicit)]
internal struct Variant
{
	[FieldOffset(0)]
	public short vt;

	[FieldOffset(2)]
	public ushort wReserved1;

	[FieldOffset(4)]
	public ushort wReserved2;

	[FieldOffset(6)]
	public ushort wReserved3;

	[FieldOffset(8)]
	public long llVal;

	[FieldOffset(8)]
	public int lVal;

	[FieldOffset(8)]
	public byte bVal;

	[FieldOffset(8)]
	public short iVal;

	[FieldOffset(8)]
	public float fltVal;

	[FieldOffset(8)]
	public double dblVal;

	[FieldOffset(8)]
	public short boolVal;

	[FieldOffset(8)]
	public IntPtr bstrVal;

	[FieldOffset(8)]
	public sbyte cVal;

	[FieldOffset(8)]
	public ushort uiVal;

	[FieldOffset(8)]
	public uint ulVal;

	[FieldOffset(8)]
	public ulong ullVal;

	[FieldOffset(8)]
	public int intVal;

	[FieldOffset(8)]
	public uint uintVal;

	[FieldOffset(8)]
	public IntPtr pdispVal;

	[FieldOffset(8)]
	public BRECORD bRecord;

	public void Clear()
	{
		if (vt == 8)
		{
			Marshal.FreeBSTR(bstrVal);
		}
		else if ((vt == 9 || vt == 13) && pdispVal != IntPtr.Zero)
		{
			Marshal.Release(pdispVal);
		}
	}
}
