namespace System.Linq.Expressions.Interpreter;

internal sealed class BranchFalseInstruction : OffsetInstruction
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

	public override string InstructionName => "BranchFalse";

	public override int ConsumedStack => 1;

	public override int Run(InterpretedFrame frame)
	{
		if (!(bool)frame.Pop())
		{
			return _offset;
		}
		return 1;
	}
}
