namespace System.Linq.Expressions.Interpreter;

internal sealed class LoadObjectInstruction : Instruction
{
	private readonly object _value;

	public override int ProducedStack => 1;

	public override string InstructionName => "LoadObject";

	internal LoadObjectInstruction(object value)
	{
		_value = value;
	}

	public override int Run(InterpretedFrame frame)
	{
		frame.Data[frame.StackIndex++] = _value;
		return 1;
	}

	public override string ToString()
	{
		return "LoadObject(" + (_value ?? "null")?.ToString() + ")";
	}
}
