namespace Unity.VisualScripting;

public sealed class PlusHandler : UnaryOperatorHandler
{
	public PlusHandler()
		: base("Plus", "Plus", "+", "op_UnaryPlus")
	{
		Handle((byte a) => (int)a);
		Handle((sbyte a) => (int)a);
		Handle((short a) => (int)a);
		Handle((ushort a) => (int)a);
		Handle((int a) => a);
		Handle((uint a) => a);
		Handle((long a) => a);
		Handle((ulong a) => a);
		Handle((float a) => a);
		Handle((decimal a) => a);
		Handle((double a) => a);
	}
}
