using System.Runtime.CompilerServices;

namespace System.Linq.Expressions.Interpreter;

internal sealed class CreateDelegateInstruction : Instruction
{
	private readonly LightDelegateCreator _creator;

	public override int ConsumedStack => _creator.Interpreter.ClosureSize;

	public override int ProducedStack => 1;

	public override string InstructionName => "CreateDelegate";

	internal CreateDelegateInstruction(LightDelegateCreator delegateCreator)
	{
		_creator = delegateCreator;
	}

	public override int Run(InterpretedFrame frame)
	{
		IStrongBox[] array;
		if (ConsumedStack > 0)
		{
			array = new IStrongBox[ConsumedStack];
			for (int num = array.Length - 1; num >= 0; num--)
			{
				array[num] = (IStrongBox)frame.Pop();
			}
		}
		else
		{
			array = null;
		}
		Delegate value = _creator.CreateDelegate(array);
		frame.Push(value);
		return 1;
	}
}
