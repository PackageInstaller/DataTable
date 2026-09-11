namespace System.Linq.Expressions.Interpreter;

internal sealed class EnterFaultInstruction : IndexedBranchInstruction
{
	private static readonly EnterFaultInstruction[] s_cache = new EnterFaultInstruction[32];

	public override string InstructionName => "EnterFault";

	public override int ProducedStack => 2;

	private EnterFaultInstruction(int labelIndex)
		: base(labelIndex)
	{
	}

	internal static EnterFaultInstruction Create(int labelIndex)
	{
		if (labelIndex < 32)
		{
			return s_cache[labelIndex] ?? (s_cache[labelIndex] = new EnterFaultInstruction(labelIndex));
		}
		return new EnterFaultInstruction(labelIndex);
	}

	public override int Run(InterpretedFrame frame)
	{
		frame.SetStackDepth(GetLabel(frame).StackDepth);
		frame.PushPendingContinuation();
		frame.RemoveContinuation();
		return 1;
	}
}
