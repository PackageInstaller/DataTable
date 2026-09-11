using System.Runtime.CompilerServices;

namespace System.Linq.Expressions.Interpreter;

internal sealed class LoadLocalFromClosureInstruction : LocalAccessInstruction
{
	public override int ProducedStack => 1;

	public override string InstructionName => "LoadLocalClosure";

	internal LoadLocalFromClosureInstruction(int index)
		: base(index)
	{
	}

	public override int Run(InterpretedFrame frame)
	{
		IStrongBox strongBox = frame.Closure[_index];
		frame.Data[frame.StackIndex++] = strongBox.Value;
		return 1;
	}
}
