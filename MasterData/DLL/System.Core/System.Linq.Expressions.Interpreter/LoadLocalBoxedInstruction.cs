using System.Runtime.CompilerServices;

namespace System.Linq.Expressions.Interpreter;

internal sealed class LoadLocalBoxedInstruction : LocalAccessInstruction
{
	public override int ProducedStack => 1;

	public override string InstructionName => "LoadLocalBox";

	internal LoadLocalBoxedInstruction(int index)
		: base(index)
	{
	}

	public override int Run(InterpretedFrame frame)
	{
		IStrongBox strongBox = (IStrongBox)frame.Data[_index];
		frame.Data[frame.StackIndex++] = strongBox.Value;
		return 1;
	}
}
