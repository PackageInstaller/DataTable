namespace System.Linq.Expressions.Interpreter;

internal sealed class LeaveFinallyInstruction : Instruction
{
	internal static readonly Instruction Instance = new LeaveFinallyInstruction();

	public override int ConsumedStack => 2;

	public override string InstructionName => "LeaveFinally";

	private LeaveFinallyInstruction()
	{
	}

	public override int Run(InterpretedFrame frame)
	{
		frame.PopPendingContinuation();
		if (!frame.IsJumpHappened())
		{
			return 1;
		}
		return frame.YieldToPendingContinuation();
	}
}
