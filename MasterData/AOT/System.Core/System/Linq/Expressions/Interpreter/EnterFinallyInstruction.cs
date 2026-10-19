namespace System.Linq.Expressions.Interpreter;

internal sealed class EnterFinallyInstruction : IndexedBranchInstruction
{
	private static readonly EnterFinallyInstruction[] s_cache = new EnterFinallyInstruction[32];

	public override string InstructionName => "EnterFinally";

	public override int ProducedStack => 2;

	public override int ConsumedContinuations => 1;

	private EnterFinallyInstruction(int labelIndex)
		: base(labelIndex)
	{
	}

	internal static EnterFinallyInstruction Create(int labelIndex)
	{
		if (labelIndex < 32)
		{
			return s_cache[labelIndex] ?? (s_cache[labelIndex] = new EnterFinallyInstruction(labelIndex));
		}
		return new EnterFinallyInstruction(labelIndex);
	}

	public override int Run(InterpretedFrame frame)
	{
		if (!frame.IsJumpHappened())
		{
			frame.SetStackDepth(GetLabel(frame).StackDepth);
		}
		frame.PushPendingContinuation();
		frame.RemoveContinuation();
		return 1;
	}
}
