namespace System.Linq.Expressions.Interpreter;

internal sealed class TypeIsInstruction : Instruction
{
	private readonly Type _type;

	public override int ConsumedStack => 1;

	public override int ProducedStack => 1;

	public override string InstructionName => "TypeIs";

	internal TypeIsInstruction(Type type)
	{
		_type = type;
	}

	public override int Run(InterpretedFrame frame)
	{
		frame.Push(_type.IsInstanceOfType(frame.Pop()));
		return 1;
	}

	public override string ToString()
	{
		return "TypeIs " + _type.ToString();
	}
}
