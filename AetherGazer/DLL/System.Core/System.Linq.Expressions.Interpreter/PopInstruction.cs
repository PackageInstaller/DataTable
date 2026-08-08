namespace System.Linq.Expressions.Interpreter;

internal sealed class PopInstruction : Instruction
{
	internal static readonly PopInstruction Instance = new PopInstruction();

	public override int ConsumedStack => 1;

	public override string InstructionName => "Pop";

	private PopInstruction()
	{
	}

	public override int Run(InterpretedFrame frame)
	{
		frame.Pop();
		return 1;
	}
}
