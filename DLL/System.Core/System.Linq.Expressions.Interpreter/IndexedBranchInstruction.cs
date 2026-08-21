using System.Collections.Generic;

namespace System.Linq.Expressions.Interpreter;

internal abstract class IndexedBranchInstruction : Instruction
{
	internal readonly int _labelIndex;

	public IndexedBranchInstruction(int labelIndex)
	{
		_labelIndex = labelIndex;
	}

	public RuntimeLabel GetLabel(InterpretedFrame frame)
	{
		return frame.Interpreter._labels[_labelIndex];
	}

	public override string ToDebugString(int instructionIndex, object cookie, Func<int, int> labelIndexer, IReadOnlyList<object> objects)
	{
		int num = labelIndexer(_labelIndex);
		return ToString() + ((num != int.MinValue) ? (" -> " + num) : "");
	}

	public override string ToString()
	{
		return InstructionName + "[" + _labelIndex + "]";
	}
}
