using System.Reflection;

namespace System.Linq.Expressions.Interpreter;

internal sealed class StoreStaticFieldInstruction : FieldInstruction
{
	public override string InstructionName => "StoreStaticField";

	public override int ConsumedStack => 1;

	public StoreStaticFieldInstruction(FieldInfo field)
		: base(field)
	{
	}

	public override int Run(InterpretedFrame frame)
	{
		object value = frame.Pop();
		_field.SetValue(null, value);
		return 1;
	}
}
