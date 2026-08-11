namespace System.Linq.Expressions.Interpreter;

internal sealed class EnterTryFaultInstruction : IndexedBranchInstruction
{
	private TryFaultHandler _tryHandler;

	public override string InstructionName => "EnterTryFault";

	public override int ProducedContinuations => 1;

	internal TryFaultHandler Handler => _tryHandler;

	internal EnterTryFaultInstruction(int targetIndex)
		: base(targetIndex)
	{
	}

	internal void SetTryHandler(TryFaultHandler tryHandler)
	{
		_tryHandler = tryHandler;
	}

	public override int Run(InterpretedFrame frame)
	{
		frame.PushContinuation(_labelIndex);
		int instructionIndex = frame.InstructionIndex;
		frame.InstructionIndex++;
		Instruction[] instructions = frame.Interpreter.Instructions.Instructions;
		bool flag = false;
		try
		{
			int num = frame.InstructionIndex;
			while (num >= _tryHandler.TryStartIndex && num < _tryHandler.TryEndIndex)
			{
				num = (frame.InstructionIndex = num + instructions[num].Run(frame));
			}
			flag = true;
			frame.RemoveContinuation();
			frame.InstructionIndex += instructions[num].Run(frame);
		}
		finally
		{
			if (!flag)
			{
				int num2 = (frame.InstructionIndex = _tryHandler.FinallyStartIndex);
				while (num2 >= _tryHandler.FinallyStartIndex && num2 < _tryHandler.FinallyEndIndex)
				{
					num2 = (frame.InstructionIndex = num2 + instructions[num2].Run(frame));
				}
			}
		}
		return frame.InstructionIndex - instructionIndex;
	}
}
