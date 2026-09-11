namespace System.Linq.Expressions.Interpreter;

internal sealed class NewArrayBoundsInstruction : Instruction
{
	private readonly Type _elementType;

	private readonly int _rank;

	public override int ConsumedStack => _rank;

	public override int ProducedStack => 1;

	public override string InstructionName => "NewArrayBounds";

	internal NewArrayBoundsInstruction(Type elementType, int rank)
	{
		_elementType = elementType;
		_rank = rank;
	}

	public override int Run(InterpretedFrame frame)
	{
		int[] array = new int[_rank];
		for (int num = _rank - 1; num >= 0; num--)
		{
			int num2 = ConvertHelper.ToInt32NoNull(frame.Pop());
			if (num2 < 0)
			{
				throw new OverflowException();
			}
			array[num] = num2;
		}
		Array value = Array.CreateInstance(_elementType, array);
		frame.Push(value);
		return 1;
	}
}
