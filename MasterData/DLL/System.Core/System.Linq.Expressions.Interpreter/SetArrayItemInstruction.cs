namespace System.Linq.Expressions.Interpreter;

internal sealed class SetArrayItemInstruction : Instruction
{
	internal static readonly SetArrayItemInstruction Instance = new SetArrayItemInstruction();

	public override int ConsumedStack => 3;

	public override string InstructionName => "SetArrayItem";

	private SetArrayItemInstruction()
	{
	}

	public override int Run(InterpretedFrame frame)
	{
		object value = frame.Pop();
		int index = ConvertHelper.ToInt32NoNull(frame.Pop());
		((Array)frame.Pop()).SetValue(value, index);
		return 1;
	}
}
