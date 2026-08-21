namespace System.Linq.Expressions.Interpreter;

internal sealed class TypeEqualsInstruction : Instruction
{
	public static readonly TypeEqualsInstruction Instance = new TypeEqualsInstruction();

	public override int ConsumedStack => 2;

	public override int ProducedStack => 1;

	public override string InstructionName => "TypeEquals";

	private TypeEqualsInstruction()
	{
	}

	public override int Run(InterpretedFrame frame)
	{
		object obj = frame.Pop();
		frame.Push(frame.Pop()?.GetType() == obj);
		return 1;
	}
}
