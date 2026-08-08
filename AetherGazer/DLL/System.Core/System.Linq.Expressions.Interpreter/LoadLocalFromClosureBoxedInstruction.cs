using System.Runtime.CompilerServices;

namespace System.Linq.Expressions.Interpreter;

internal sealed class LoadLocalFromClosureBoxedInstruction : LocalAccessInstruction
{
	public override int ProducedStack => 1;

	public override string InstructionName => "LoadLocal";

	internal LoadLocalFromClosureBoxedInstruction(int index)
		: base(index)
	{
	}

	public override int Run(InterpretedFrame frame)
	{
		IStrongBox strongBox = frame.Closure[_index];
		frame.Data[frame.StackIndex++] = strongBox;
		return 1;
	}
}
