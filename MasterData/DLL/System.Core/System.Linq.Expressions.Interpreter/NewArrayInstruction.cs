namespace System.Linq.Expressions.Interpreter;

internal sealed class NewArrayInstruction : Instruction
{
	private readonly Type _elementType;

	public override int ConsumedStack => 1;

	public override int ProducedStack => 1;

	public override string InstructionName => "NewArray";

	internal NewArrayInstruction(Type elementType)
	{
		_elementType = elementType;
	}

	public override int Run(InterpretedFrame frame)
	{
		int num = ConvertHelper.ToInt32NoNull(frame.Pop());
		frame.Push((num < 0) ? new int[num] : Array.CreateInstance(_elementType, num));
		return 1;
	}
}
