namespace System.Linq.Expressions.Interpreter;

internal sealed class GetArrayItemInstruction : Instruction
{
	internal static readonly GetArrayItemInstruction Instance = new GetArrayItemInstruction();

	public override int ConsumedStack => 2;

	public override int ProducedStack => 1;

	public override string InstructionName => "GetArrayItem";

	private GetArrayItemInstruction()
	{
	}

	public override int Run(InterpretedFrame frame)
	{
		int index = ConvertHelper.ToInt32NoNull(frame.Pop());
		Array array = (Array)frame.Pop();
		frame.Push(array.GetValue(index));
		return 1;
	}
}
