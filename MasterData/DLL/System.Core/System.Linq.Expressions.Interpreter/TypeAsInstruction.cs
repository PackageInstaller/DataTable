namespace System.Linq.Expressions.Interpreter;

internal sealed class TypeAsInstruction : Instruction
{
	private readonly Type _type;

	public override int ConsumedStack => 1;

	public override int ProducedStack => 1;

	public override string InstructionName => "TypeAs";

	internal TypeAsInstruction(Type type)
	{
		_type = type;
	}

	public override int Run(InterpretedFrame frame)
	{
		object obj = frame.Pop();
		frame.Push(_type.IsInstanceOfType(obj) ? obj : null);
		return 1;
	}

	public override string ToString()
	{
		return "TypeAs " + _type.ToString();
	}
}
