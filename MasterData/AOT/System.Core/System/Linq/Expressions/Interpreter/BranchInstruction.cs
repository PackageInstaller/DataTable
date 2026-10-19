namespace System.Linq.Expressions.Interpreter;

internal class BranchInstruction : OffsetInstruction
{
	private static Instruction[][][] s_caches;

	internal readonly bool _hasResult;

	internal readonly bool _hasValue;

	public override Instruction[] Cache
	{
		get
		{
			if (s_caches == null)
			{
				s_caches = new Instruction[2][][]
				{
					new Instruction[2][],
					new Instruction[2][]
				};
			}
			return s_caches[ConsumedStack][ProducedStack] ?? (s_caches[ConsumedStack][ProducedStack] = new Instruction[32]);
		}
	}

	public override string InstructionName => "Branch";

	public override int ConsumedStack
	{
		get
		{
			if (!_hasValue)
			{
				return 0;
			}
			return 1;
		}
	}

	public override int ProducedStack
	{
		get
		{
			if (!_hasResult)
			{
				return 0;
			}
			return 1;
		}
	}

	internal BranchInstruction()
		: this(hasResult: false, hasValue: false)
	{
	}

	public BranchInstruction(bool hasResult, bool hasValue)
	{
		_hasResult = hasResult;
		_hasValue = hasValue;
	}

	public override int Run(InterpretedFrame frame)
	{
		return _offset;
	}
}
