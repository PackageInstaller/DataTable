namespace System.Linq.Expressions.Interpreter;

internal sealed class LoadLocalInstruction : LocalAccessInstruction, IBoxableInstruction
{
	public override int ProducedStack => 1;

	public override string InstructionName => "LoadLocal";

	internal LoadLocalInstruction(int index)
		: base(index)
	{
	}

	public override int Run(InterpretedFrame frame)
	{
		frame.Data[frame.StackIndex++] = frame.Data[_index];
		return 1;
	}

	public Instruction BoxIfIndexMatches(int index)
	{
		if (index != _index)
		{
			return null;
		}
		return InstructionList.LoadLocalBoxed(index);
	}
}
