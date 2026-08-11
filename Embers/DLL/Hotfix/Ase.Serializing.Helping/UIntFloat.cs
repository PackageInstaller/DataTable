using System.Runtime.InteropServices;

namespace Ase.Serializing.Helping;

[StructLayout(LayoutKind.Explicit)]
internal struct UIntFloat
{
	[FieldOffset(0)]
	public float FloatValue;

	[FieldOffset(0)]
	public uint UIntValue;
}
