using System.Runtime.CompilerServices;

namespace System.Linq.Expressions.Interpreter;

internal sealed class StoreLocalBoxedInstruction : LocalAccessInstruction
{
	public override int ConsumedStack => 1;

	public override string InstructionName => "StoreLocalBox";

	internal StoreLocalBoxedInstruction(int index)
		: base(index)
	{
	}

	public override int Run(InterpretedFrame frame)
	{
		((IStrongBox)frame.Data[_index]).Value = frame.Data[--frame.StackIndex];
		return 1;
	}
}
