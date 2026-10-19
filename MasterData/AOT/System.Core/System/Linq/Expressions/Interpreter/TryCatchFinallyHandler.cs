using System.Runtime.CompilerServices;

namespace System.Linq.Expressions.Interpreter;

internal sealed class TryCatchFinallyHandler
{
	internal readonly int TryStartIndex;

	internal readonly int TryEndIndex;

	internal readonly int FinallyStartIndex;

	internal readonly int FinallyEndIndex;

	internal readonly int GotoEndTargetIndex;

	private readonly ExceptionHandler[] _handlers;

	internal bool IsFinallyBlockExist => FinallyStartIndex != int.MaxValue;

	internal ExceptionHandler[] Handlers => _handlers;

	internal bool IsCatchBlockExist => _handlers != null;

	internal TryCatchFinallyHandler(int tryStart, int tryEnd, int gotoEndTargetIndex, ExceptionHandler[] handlers)
		: this(tryStart, tryEnd, gotoEndTargetIndex, int.MaxValue, int.MaxValue, handlers)
	{
	}

	internal TryCatchFinallyHandler(int tryStart, int tryEnd, int gotoEndLabelIndex, int finallyStart, int finallyEnd, ExceptionHandler[] handlers)
	{
		TryStartIndex = tryStart;
		TryEndIndex = tryEnd;
		FinallyStartIndex = finallyStart;
		FinallyEndIndex = finallyEnd;
		GotoEndTargetIndex = gotoEndLabelIndex;
		_handlers = handlers;
	}

	internal bool HasHandler(InterpretedFrame frame, Exception exception, out ExceptionHandler handler, out object unwrappedException)
	{
		frame.SaveTraceToException(exception);
		if (IsCatchBlockExist)
		{
			RuntimeWrappedException ex = exception as RuntimeWrappedException;
			unwrappedException = ((ex != null) ? ex.WrappedException : exception);
			Type type = unwrappedException.GetType();
			ExceptionHandler[] handlers = _handlers;
			foreach (ExceptionHandler exceptionHandler in handlers)
			{
				if (exceptionHandler.Matches(type) && (exceptionHandler.Filter == null || FilterPasses(frame, ref unwrappedException, exceptionHandler.Filter)))
				{
					handler = exceptionHandler;
					return true;
				}
			}
		}
		else
		{
			unwrappedException = null;
		}
		handler = null;
		return false;
	}

	private static bool FilterPasses(InterpretedFrame frame, ref object exception, ExceptionFilter filter)
	{
		Interpreter interpreter = frame.Interpreter;
		Instruction[] instructions = interpreter.Instructions.Instructions;
		int stackIndex = frame.StackIndex;
		int instructionIndex = frame.InstructionIndex;
		try
		{
			int num = (frame.InstructionIndex = interpreter._labels[filter.LabelIndex].Index);
			frame.Push(exception);
			while (num >= filter.StartIndex && num < filter.EndIndex)
			{
				num = (frame.InstructionIndex = num + instructions[num].Run(frame));
			}
			object obj = frame.Pop();
			if ((bool)frame.Pop())
			{
				exception = obj;
				return true;
			}
		}
		catch
		{
		}
		frame.StackIndex = stackIndex;
		frame.InstructionIndex = instructionIndex;
		return false;
	}
}
