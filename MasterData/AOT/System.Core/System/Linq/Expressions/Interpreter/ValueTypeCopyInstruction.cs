using System.Runtime.CompilerServices;

namespace System.Linq.Expressions.Interpreter;

internal sealed class ValueTypeCopyInstruction : Instruction
{
	public static readonly ValueTypeCopyInstruction Instruction = new ValueTypeCopyInstruction();

	public override int ConsumedStack => 1;

	public override int ProducedStack => 1;

	public override string InstructionName => "ValueTypeCopy";

	public override int Run(InterpretedFrame frame)
	{
		object obj = frame.Pop();
		frame.Push((obj == null) ? obj : RuntimeHelpers.GetObjectValue(obj));
		return 1;
	}
}
