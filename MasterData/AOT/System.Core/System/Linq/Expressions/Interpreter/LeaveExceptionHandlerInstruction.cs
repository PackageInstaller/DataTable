namespace System.Linq.Expressions.Interpreter;

internal sealed class LeaveExceptionHandlerInstruction : IndexedBranchInstruction
{
	private static readonly LeaveExceptionHandlerInstruction[] s_cache = new LeaveExceptionHandlerInstruction[64];

	private readonly bool _hasValue;

	public override string InstructionName => "LeaveExceptionHandler";

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
			if (!_hasValue)
			{
				return 0;
			}
			return 1;
		}
	}

	private LeaveExceptionHandlerInstruction(int labelIndex, bool hasValue)
		: base(labelIndex)
	{
		_hasValue = hasValue;
	}

	internal static LeaveExceptionHandlerInstruction Create(int labelIndex, bool hasValue)
	{
		if (labelIndex < 32)
		{
			int num = (2 * labelIndex) | (hasValue ? 1 : 0);
			return s_cache[num] ?? (s_cache[num] = new LeaveExceptionHandlerInstruction(labelIndex, hasValue));
		}
		return new LeaveExceptionHandlerInstruction(labelIndex, hasValue);
	}

	public override int Run(InterpretedFrame frame)
	{
		return GetLabel(frame).Index - frame.InstructionIndex;
	}
}
