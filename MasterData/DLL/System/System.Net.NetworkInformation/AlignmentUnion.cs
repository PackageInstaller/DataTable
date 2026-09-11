using System.Runtime.InteropServices;

namespace System.Net.NetworkInformation;

[StructLayout(LayoutKind.Explicit)]
internal struct AlignmentUnion
{
	[FieldOffset(0)]
	public ulong Alignment;

	[FieldOffset(0)]
	public int Length;

	[FieldOffset(4)]
	public int IfIndex;
}
