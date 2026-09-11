namespace System.Linq.Expressions.Interpreter;

internal sealed class LeaveFaultInstruction : Instruction
{
	internal static readonly Instruction Instance = new LeaveFaultInstruction();

	public override int ConsumedStack => 2;

	public override int ConsumedContinuations => 1;

	public override string InstructionName => "LeaveFault";

	private LeaveFaultInstruction()
	{
	}

	public override int Run(InterpretedFrame frame)
	{
		frame.PopPendingContinuation();
		return 1;
	}
}
