using System.Collections.Generic;
using System.Runtime.CompilerServices;

namespace System.Linq.Expressions.Interpreter;

internal sealed class InterpretedFrame
{
	[ThreadStatic]
	private static InterpretedFrame s_currentFrame;

	internal readonly Interpreter Interpreter;

	internal InterpretedFrame _parent;

	private readonly int[] _continuations;

	private int _continuationIndex;

	private int _pendingContinuation;

	private object _pendingValue;

	public readonly object[] Data;

	public readonly IStrongBox[] Closure;

	public int StackIndex;

	public int InstructionIndex;

	public string Name => Interpreter.Name;

	public InterpretedFrame Parent => _parent;

	internal InterpretedFrame(Interpreter interpreter, IStrongBox[] closure)
	{
		Interpreter = interpreter;
		StackIndex = interpreter.LocalCount;
		Data = new object[StackIndex + interpreter.Instructions.MaxStackDepth];
		int maxContinuationDepth = interpreter.Instructions.MaxContinuationDepth;
		if (maxContinuationDepth > 0)
		{
			_continuations = new int[maxContinuationDepth];
		}
		Closure = closure;
		_pendingContinuation = -1;
		_pendingValue = Interpreter.NoValue;
	}

	public DebugInfo GetDebugInfo(int instructionIndex)
	{
		return DebugInfo.GetMatchingDebugInfo(Interpreter._debugInfos, instructionIndex);
	}

	public void Push(object value)
	{
		Data[StackIndex++] = value;
	}

	public void Push(bool value)
	{
		Data[StackIndex++] = (value ? Utils.BoxedTrue : Utils.BoxedFalse);
	}

	public void Push(int value)
	{
		Data[StackIndex++] = ScriptingRuntimeHelpers.Int32ToObject(value);
	}

	public void Push(byte value)
	{
		Data[StackIndex++] = value;
	}

	public void Push(sbyte value)
	{
		Data[StackIndex++] = value;
	}

	public void Push(short value)
	{
		Data[StackIndex++] = value;
	}

	public void Push(ushort value)
	{
		Data[StackIndex++] = value;
	}

	public object Pop()
	{
		return Data[--StackIndex];
	}

	internal void SetStackDepth(int depth)
	{
		StackIndex = Interpreter.LocalCount + depth;
	}

	public object Peek()
	{
		return Data[StackIndex - 1];
	}

	public void Dup()
	{
		int stackIndex = StackIndex;
		Data[stackIndex] = Data[stackIndex - 1];
		StackIndex = stackIndex + 1;
	}

	public IEnumerable<InterpretedFrameInfo> GetStackTraceDebugInfo()
	{
		InterpretedFrame frame = this;
		do
		{
			yield return new InterpretedFrameInfo(frame.Name, frame.GetDebugInfo(frame.InstructionIndex));
			frame = frame.Parent;
		}
		while (frame != null);
	}

	internal void SaveTraceToException(Exception exception)
	{
		if (exception.Data[typeof(InterpretedFrameInfo)] == null)
		{
			exception.Data[typeof(InterpretedFrameInfo)] = new List<InterpretedFrameInfo>(GetStackTraceDebugInfo()).ToArray();
		}
	}

	internal InterpretedFrame Enter()
	{
		InterpretedFrame parent = s_currentFrame;
		s_currentFrame = this;
		return _parent = parent;
	}

	internal void Leave(InterpretedFrame prevFrame)
	{
		s_currentFrame = prevFrame;
	}

	internal bool IsJumpHappened()
	{
		return _pendingContinuation >= 0;
	}

	public void RemoveContinuation()
	{
		_continuationIndex--;
	}

	public void PushContinuation(int continuation)
	{
		_continuations[_continuationIndex++] = continuation;
	}

	public int YieldToCurrentContinuation()
	{
		RuntimeLabel runtimeLabel = Interpreter._labels[_continuations[_continuationIndex - 1]];
		SetStackDepth(runtimeLabel.StackDepth);
		return runtimeLabel.Index - InstructionIndex;
	}

	public int YieldToPendingContinuation()
	{
		RuntimeLabel runtimeLabel = Interpreter._labels[_pendingContinuation];
		if (runtimeLabel.ContinuationStackDepth < _continuationIndex)
		{
			RuntimeLabel runtimeLabel2 = Interpreter._labels[_continuations[_continuationIndex - 1]];
			SetStackDepth(runtimeLabel2.StackDepth);
			return runtimeLabel2.Index - InstructionIndex;
		}
		SetStackDepth(runtimeLabel.StackDepth);
		if (_pendingValue != Interpreter.NoValue)
		{
			Data[StackIndex - 1] = _pendingValue;
		}
		_pendingContinuation = -1;
		_pendingValue = Interpreter.NoValue;
		return runtimeLabel.Index - InstructionIndex;
	}

	internal void PushPendingContinuation()
	{
		Push(_pendingContinuation);
		Push(_pendingValue);
		_pendingContinuation = -1;
		_pendingValue = Interpreter.NoValue;
	}

	internal void PopPendingContinuation()
	{
		_pendingValue = Pop();
		_pendingContinuation = (int)Pop();
	}

	public int Goto(int labelIndex, object value, bool gotoExceptionHandler)
	{
		RuntimeLabel runtimeLabel = Interpreter._labels[labelIndex];
		if (_continuationIndex == runtimeLabel.ContinuationStackDepth)
		{
			SetStackDepth(runtimeLabel.StackDepth);
			if (value != Interpreter.NoValue)
			{
				Data[StackIndex - 1] = value;
			}
			return runtimeLabel.Index - InstructionIndex;
		}
		_pendingContinuation = labelIndex;
		_pendingValue = value;
		return YieldToCurrentContinuation();
	}
}
