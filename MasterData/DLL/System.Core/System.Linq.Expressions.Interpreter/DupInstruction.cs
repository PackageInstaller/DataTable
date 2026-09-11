namespace System.Linq.Expressions.Interpreter;

internal sealed class DupInstruction : Instruction
{
	internal static readonly DupInstruction Instance = new DupInstruction();

	public override int ProducedStack => 1;

	public override string InstructionName => "Dup";

	private DupInstruction()
	{
	}

	public override int Run(InterpretedFrame frame)
	{
		frame.Dup();
		return 1;
	}
}
