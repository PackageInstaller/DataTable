namespace System.Linq.Expressions.Interpreter;

internal sealed class StoreLocalInstruction : LocalAccessInstruction, IBoxableInstruction
{
	public override int ConsumedStack => 1;

	public override string InstructionName => "StoreLocal";

	internal StoreLocalInstruction(int index)
		: base(index)
	{
	}

	public override int Run(InterpretedFrame frame)
	{
		frame.Data[_index] = frame.Pop();
		return 1;
	}

	public Instruction BoxIfIndexMatches(int index)
	{
		if (index != _index)
		{
			return null;
		}
		return InstructionList.StoreLocalBoxed(index);
	}
}
