namespace Unity.VisualScripting;

public sealed class NumericNegationHandler : UnaryOperatorHandler
{
	public NumericNegationHandler()
		: base("Numeric Negation", "Negate", "-", "op_UnaryNegation")
	{
		Handle((byte a) => -a);
		Handle((sbyte a) => -a);
		Handle((short a) => -a);
		Handle((ushort a) => -a);
		Handle((int a) => -a);
		Handle((uint a) => 0L - (long)a);
		Handle((long a) => -a);
		Handle((float a) => 0f - a);
		Handle((decimal a) => -a);
		Handle((double a) => 0.0 - a);
	}
}
