namespace System.Linq.Expressions.Interpreter;

internal sealed class NewArrayInitInstruction : Instruction
{
	private readonly Type _elementType;

	private readonly int _elementCount;

	public override int ConsumedStack => _elementCount;

	public override int ProducedStack => 1;

	public override string InstructionName => "NewArrayInit";

	internal NewArrayInitInstruction(Type elementType, int elementCount)
	{
		_elementType = elementType;
		_elementCount = elementCount;
	}

	public override int Run(InterpretedFrame frame)
	{
		Array array = Array.CreateInstance(_elementType, _elementCount);
		for (int num = _elementCount - 1; num >= 0; num--)
		{
			array.SetValue(frame.Pop(), num);
		}
		frame.Push(array);
		return 1;
	}
}
