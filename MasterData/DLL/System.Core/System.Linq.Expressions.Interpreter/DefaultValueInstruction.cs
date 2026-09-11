namespace System.Linq.Expressions.Interpreter;

internal sealed class DefaultValueInstruction : Instruction
{
	private readonly Type _type;

	public override int ProducedStack => 1;

	public override string InstructionName => "DefaultValue";

	internal DefaultValueInstruction(Type type)
	{
		_type = type;
	}

	public override int Run(InterpretedFrame frame)
	{
		frame.Push(Activator.CreateInstance(_type));
		return 1;
	}

	public override string ToString()
	{
		return "DefaultValue " + _type;
	}
}
