namespace System.Linq.Expressions.Interpreter;

internal sealed class CoalescingBranchInstruction : OffsetInstruction
{
	private static Instruction[] s_cache;

	public override Instruction[] Cache
	{
		get
		{
			if (s_cache == null)
			{
				s_cache = new Instruction[32];
			}
			return s_cache;
		}
	}

	public override string InstructionName => "CoalescingBranch";

	public override int ConsumedStack => 1;

	public override int ProducedStack => 1;

	public override int Run(InterpretedFrame frame)
	{
		if (frame.Peek() != null)
		{
			return _offset;
		}
		return 1;
	}
}
