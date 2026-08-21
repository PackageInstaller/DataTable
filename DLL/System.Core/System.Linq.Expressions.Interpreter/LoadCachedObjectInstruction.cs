using System.Collections.Generic;
using System.Globalization;

namespace System.Linq.Expressions.Interpreter;

internal sealed class LoadCachedObjectInstruction : Instruction
{
	private readonly uint _index;

	public override int ProducedStack => 1;

	public override string InstructionName => "LoadCachedObject";

	internal LoadCachedObjectInstruction(uint index)
	{
		_index = index;
	}

	public override int Run(InterpretedFrame frame)
	{
		frame.Data[frame.StackIndex++] = frame.Interpreter._objects[_index];
		return 1;
	}

	public override string ToDebugString(int instructionIndex, object cookie, Func<int, int> labelIndexer, IReadOnlyList<object> objects)
	{
		return string.Format(CultureInfo.InvariantCulture, "LoadCached({0}: {1})", _index, objects[(int)_index]);
	}

	public override string ToString()
	{
		return "LoadCached(" + _index + ")";
	}
}
