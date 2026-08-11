using System.Runtime.InteropServices;

namespace Ase.Serializing.Helping;

[StructLayout(LayoutKind.Explicit)]
internal struct UIntDecimal
{
	[FieldOffset(0)]
	public ulong LongValue1;

	[FieldOffset(8)]
	public ulong LongValue2;

	[FieldOffset(0)]
	public decimal DecimalValue;
}
