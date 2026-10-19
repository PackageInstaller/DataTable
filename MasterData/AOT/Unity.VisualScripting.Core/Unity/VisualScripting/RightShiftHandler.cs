namespace Unity.VisualScripting;

public class RightShiftHandler : BinaryOperatorHandler
{
	public RightShiftHandler()
		: base("Right Shift", "Right Shift", ">>", "op_RightShift")
	{
		Handle((byte a, byte b) => a >> (int)b);
		Handle((byte a, sbyte b) => a >> (int)b);
		Handle((byte a, short b) => a >> (int)b);
		Handle((byte a, ushort b) => a >> (int)b);
		Handle((byte a, int b) => a >> b);
		Handle((sbyte a, byte b) => a >> (int)b);
		Handle((sbyte a, sbyte b) => a >> (int)b);
		Handle((sbyte a, short b) => a >> (int)b);
		Handle((sbyte a, ushort b) => a >> (int)b);
		Handle((sbyte a, int b) => a >> b);
		Handle((short a, byte b) => a >> (int)b);
		Handle((short a, sbyte b) => a >> (int)b);
		Handle((short a, short b) => a >> (int)b);
		Handle((short a, ushort b) => a >> (int)b);
		Handle((short a, int b) => a >> b);
		Handle((ushort a, byte b) => a >> (int)b);
		Handle((ushort a, sbyte b) => a >> (int)b);
		Handle((ushort a, short b) => a >> (int)b);
		Handle((ushort a, ushort b) => a >> (int)b);
		Handle((ushort a, int b) => a >> b);
		Handle((int a, byte b) => a >> (int)b);
		Handle((int a, sbyte b) => a >> (int)b);
		Handle((int a, short b) => a >> (int)b);
		Handle((int a, ushort b) => a >> (int)b);
		Handle((int a, int b) => a >> b);
		Handle((uint a, byte b) => a >> (int)b);
		Handle((uint a, sbyte b) => a >> (int)b);
		Handle((uint a, short b) => a >> (int)b);
		Handle((uint a, ushort b) => a >> (int)b);
		Handle((uint a, int b) => a >> b);
		Handle((long a, byte b) => a >> (int)b);
		Handle((long a, sbyte b) => a >> (int)b);
		Handle((long a, short b) => a >> (int)b);
		Handle((long a, ushort b) => a >> (int)b);
		Handle((long a, int b) => a >> b);
		Handle((ulong a, byte b) => a >> (int)b);
		Handle((ulong a, sbyte b) => a >> (int)b);
		Handle((ulong a, short b) => a >> (int)b);
		Handle((ulong a, ushort b) => a >> (int)b);
		Handle((ulong a, int b) => a >> b);
	}
}
