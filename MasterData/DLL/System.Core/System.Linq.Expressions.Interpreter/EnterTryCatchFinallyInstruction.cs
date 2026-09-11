namespace System.Linq.Expressions.Interpreter;

internal sealed class EnterTryCatchFinallyInstruction : IndexedBranchInstruction
{
	private readonly bool _hasFinally;

	private TryCatchFinallyHandler _tryHandler;

	internal TryCatchFinallyHandler Handler => _tryHandler;

	public override int ProducedContinuations
	{
		get
		{
			if (!_hasFinally)
			{
				return 0;
			}
			return 1;
		}
	}

	public override string InstructionName
	{
		get
		{
			if (!_hasFinally)
			{
				return "EnterTryCatch";
			}
			return "EnterTryFinally";
		}
	}

	internal void SetTryHandler(TryCatchFinallyHandler tryHandler)
	{
		_tryHandler = tryHandler;
	}

	private EnterTryCatchFinallyInstruction(int targetIndex, bool hasFinally)
		: base(targetIndex)
	{
		_hasFinally = hasFinally;
	}

	internal static EnterTryCatchFinallyInstruction CreateTryFinally(int labelIndex)
	{
		return new EnterTryCatchFinallyInstruction(labelIndex, hasFinally: true);
	}

	internal static EnterTryCatchFinallyInstruction CreateTryCatch()
	{
		return new EnterTryCatchFinallyInstruction(int.MaxValue, hasFinally: false);
	}

	public override int Run(InterpretedFrame frame)
	{
		if (_hasFinally)
		{
			frame.PushContinuation(_labelIndex);
		}
		int instructionIndex = frame.InstructionIndex;
		frame.InstructionIndex++;
		Instruction[] instructions = frame.Interpreter.Instructions.Instructions;
		ExceptionHandler handler;
		object unwrappedException;
		try
		{
			int num = frame.InstructionIndex;
			while (num >= _tryHandler.TryStartIndex && num < _tryHandler.TryEndIndex)
			{
				num = (frame.InstructionIndex = num + instructions[num].Run(frame));
			}
			if (num == _tryHandler.GotoEndTargetIndex)
			{
				frame.InstructionIndex += instructions[num].Run(frame);
			}
		}
		catch (Exception exception) when (_tryHandler.HasHandler(frame, exception, out handler, out unwrappedException))
		{
			frame.InstructionIndex += frame.Goto(handler.LabelIndex, unwrappedException, gotoExceptionHandler: true);
			bool flag = false;
			try
			{
				int num2 = frame.InstructionIndex;
				while (num2 >= handler.HandlerStartIndex && num2 < handler.HandlerEndIndex)
				{
					num2 = (frame.InstructionIndex = num2 + instructions[num2].Run(frame));
				}
				if (num2 == _tryHandler.GotoEndTargetIndex)
				{
					frame.InstructionIndex += instructions[num2].Run(frame);
				}
			}
			catch (RethrowException)
			{
				flag = true;
			}
			if (flag)
			{
				throw;
			}
		}
		finally
		{
			if (_tryHandler.IsFinallyBlockExist)
			{
				int num3 = (frame.InstructionIndex = _tryHandler.FinallyStartIndex);
				while (num3 >= _tryHandler.FinallyStartIndex && num3 < _tryHandler.FinallyEndIndex)
				{
					num3 = (frame.InstructionIndex = num3 + instructions[num3].Run(frame));
				}
			}
		}
		return frame.InstructionIndex - instructionIndex;
	}

	public override string ToString()
	{
		if (!_hasFinally)
		{
			return "EnterTryCatch";
		}
		return "EnterTryFinally[" + _labelIndex + "]";
	}
}
