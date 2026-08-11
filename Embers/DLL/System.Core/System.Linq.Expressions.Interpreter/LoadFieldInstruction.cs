using System.Reflection;

namespace System.Linq.Expressions.Interpreter;

internal sealed class LoadFieldInstruction : FieldInstruction
{
	public override string InstructionName => "LoadField";

	public override int ConsumedStack => 1;

	public override int ProducedStack => 1;

	public LoadFieldInstruction(FieldInfo field)
		: base(field)
	{
	}

	public override int Run(InterpretedFrame frame)
	{
		object obj = frame.Pop();
		Instruction.NullCheck(obj);
		frame.Push(_field.GetValue(obj));
		return 1;
	}
}
