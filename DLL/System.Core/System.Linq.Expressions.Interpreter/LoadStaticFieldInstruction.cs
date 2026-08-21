using System.Reflection;

namespace System.Linq.Expressions.Interpreter;

internal sealed class LoadStaticFieldInstruction : FieldInstruction
{
	public override string InstructionName => "LoadStaticField";

	public override int ProducedStack => 1;

	public LoadStaticFieldInstruction(FieldInfo field)
		: base(field)
	{
	}

	public override int Run(InterpretedFrame frame)
	{
		frame.Push(_field.GetValue(null));
		return 1;
	}
}
