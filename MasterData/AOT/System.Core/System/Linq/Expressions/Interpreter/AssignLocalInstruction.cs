namespace System.Linq.Expressions.Interpreter;

internal sealed class AssignLocalInstruction : LocalAccessInstruction, IBoxableInstruction
{
	public override int ConsumedStack => 1;

	public override int ProducedStack => 1;

	public override string InstructionName => "AssignLocal";

	internal AssignLocalInstruction(int index)
		: base(index)
	{
	}

	public override int Run(InterpretedFrame frame)
	{
		frame.Data[_index] = frame.Peek();
		return 1;
	}

	public Instruction BoxIfIndexMatches(int index)
	{
		if (index != _index)
		{
			return null;
		}
		return InstructionList.AssignLocalBoxed(index);
	}
}
