namespace Unity.VisualScripting;

public class ExclusiveOrHandler : BinaryOperatorHandler
{
	public ExclusiveOrHandler()
		: base("Exclusive Or", "Exclusive Or", "^", "op_ExclusiveOr")
	{
		Handle((bool a, bool b) => a ^ b);
		Handle((byte a, byte b) => a ^ b);
		Handle((byte a, sbyte b) => a ^ b);
		Handle((byte a, short b) => a ^ b);
		Handle((byte a, ushort b) => a ^ b);
		Handle((byte a, int b) => a ^ b);
		Handle((byte a, uint b) => a ^ b);
		Handle((byte a, long b) => a ^ b);
		Handle((byte a, ulong b) => a ^ b);
		Handle((sbyte a, byte b) => a ^ b);
		Handle((sbyte a, sbyte b) => a ^ b);
		Handle((sbyte a, short b) => a ^ b);
		Handle((sbyte a, ushort b) => a ^ b);
		Handle((sbyte a, int b) => a ^ b);
		Handle((sbyte a, uint b) => a ^ b);
		Handle((sbyte a, long b) => a ^ b);
		Handle((short a, byte b) => a ^ b);
		Handle((short a, sbyte b) => a ^ b);
		Handle((short a, short b) => a ^ b);
		Handle((short a, ushort b) => a ^ b);
		Handle((short a, int b) => a ^ b);
		Handle((short a, uint b) => a ^ b);
		Handle((short a, long b) => a ^ b);
		Handle((ushort a, byte b) => a ^ b);
		Handle((ushort a, sbyte b) => a ^ b);
		Handle((ushort a, short b) => a ^ b);
		Handle((ushort a, ushort b) => a ^ b);
		Handle((ushort a, int b) => a ^ b);
		Handle((ushort a, uint b) => a ^ b);
		Handle((ushort a, long b) => a ^ b);
		Handle((ushort a, ulong b) => a ^ b);
		Handle((int a, byte b) => a ^ b);
		Handle((int a, sbyte b) => a ^ b);
		Handle((int a, short b) => a ^ b);
		Handle((int a, ushort b) => a ^ b);
		Handle((int a, int b) => a ^ b);
		Handle((int a, uint b) => a ^ b);
		Handle((int a, long b) => a ^ b);
		Handle((uint a, byte b) => a ^ b);
		Handle((uint a, sbyte b) => a ^ b);
		Handle((uint a, short b) => a ^ b);
		Handle((uint a, ushort b) => a ^ b);
		Handle((uint a, int b) => a ^ b);
		Handle((uint a, uint b) => a ^ b);
		Handle((uint a, long b) => a ^ b);
		Handle((uint a, ulong b) => a ^ b);
		Handle((long a, byte b) => a ^ b);
		Handle((long a, sbyte b) => a ^ b);
		Handle((long a, short b) => a ^ b);
		Handle((long a, ushort b) => a ^ b);
		Handle((long a, int b) => a ^ b);
		Handle((long a, uint b) => a ^ b);
		Handle((long a, long b) => a ^ b);
		Handle((ulong a, byte b) => a ^ b);
		Handle((ulong a, ushort b) => a ^ b);
		Handle((ulong a, uint b) => a ^ b);
		Handle((ulong a, ulong b) => a ^ b);
	}
}
