using System.Diagnostics;
using System.Runtime.InteropServices;

namespace System.Collections.Concurrent;

[StructLayout(LayoutKind.Explicit, Size = 384)]
[DebuggerDisplay("Head = {Head}, Tail = {Tail}")]
internal struct PaddedHeadAndTail
{
	[FieldOffset(128)]
	public int Head;

	[FieldOffset(256)]
	public int Tail;
}
