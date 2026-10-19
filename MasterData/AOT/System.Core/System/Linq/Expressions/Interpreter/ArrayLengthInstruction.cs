namespace System.Linq.Expressions.Interpreter;

internal sealed class ArrayLengthInstruction : Instruction
{
	public static readonly ArrayLengthInstruction Instance = new ArrayLengthInstruction();

	public override int ConsumedStack => 1;

	public override int ProducedStack => 1;

	public override string InstructionName => "ArrayLength";

	private ArrayLengthInstruction()
	{
	}

	public override int Run(InterpretedFrame frame)
	{
		object obj = frame.Pop();
		frame.Push(((Array)obj).Length);
		return 1;
	}
}
