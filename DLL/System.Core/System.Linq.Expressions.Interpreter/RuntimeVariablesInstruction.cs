using System.Runtime.CompilerServices;

namespace System.Linq.Expressions.Interpreter;

internal sealed class RuntimeVariablesInstruction : Instruction
{
	private readonly int _count;

	public override int ProducedStack => 1;

	public override int ConsumedStack => _count;

	public override string InstructionName => "GetRuntimeVariables";

	public RuntimeVariablesInstruction(int count)
	{
		_count = count;
	}

	public override int Run(InterpretedFrame frame)
	{
		IStrongBox[] array = new IStrongBox[_count];
		for (int num = array.Length - 1; num >= 0; num--)
		{
			array[num] = (IStrongBox)frame.Pop();
		}
		frame.Push(RuntimeVariables.Create(array));
		return 1;
	}
}
