using System.Collections.Generic;

namespace System.Linq.Expressions.Interpreter;

internal abstract class LocalAccessInstruction : Instruction
{
	internal readonly int _index;

	protected LocalAccessInstruction(int index)
	{
		_index = index;
	}

	public override string ToDebugString(int instructionIndex, object cookie, Func<int, int> labelIndexer, IReadOnlyList<object> objects)
	{
		if (cookie != null)
		{
			return InstructionName + "(" + cookie?.ToString() + ": " + _index + ")";
		}
		return InstructionName + "(" + _index + ")";
	}
}
