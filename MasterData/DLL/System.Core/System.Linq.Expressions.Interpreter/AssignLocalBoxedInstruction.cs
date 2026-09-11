using System.Runtime.CompilerServices;

namespace System.Linq.Expressions.Interpreter;

internal sealed class AssignLocalBoxedInstruction : LocalAccessInstruction
{
	public override int ConsumedStack => 1;

	public override int ProducedStack => 1;

	public override string InstructionName => "AssignLocalBox";

	internal AssignLocalBoxedInstruction(int index)
		: base(index)
	{
	}

	public override int Run(InterpretedFrame frame)
	{
		((IStrongBox)frame.Data[_index]).Value = frame.Peek();
		return 1;
	}
}
