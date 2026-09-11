using System.Reflection;

namespace System.Linq.Expressions.Interpreter;

internal sealed class StoreFieldInstruction : FieldInstruction
{
	public override string InstructionName => "StoreField";

	public override int ConsumedStack => 2;

	public StoreFieldInstruction(FieldInfo field)
		: base(field)
	{
	}

	public override int Run(InterpretedFrame frame)
	{
		object value = frame.Pop();
		object obj = frame.Pop();
		Instruction.NullCheck(obj);
		_field.SetValue(obj, value);
		return 1;
	}
}
