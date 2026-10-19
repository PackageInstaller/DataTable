using System.Reflection;

namespace System.Linq.Expressions.Interpreter;

internal sealed class FieldByRefUpdater : ByRefUpdater
{
	private readonly LocalDefinition? _object;

	private readonly FieldInfo _field;

	public FieldByRefUpdater(LocalDefinition? obj, FieldInfo field, int argumentIndex)
		: base(argumentIndex)
	{
		_object = obj;
		_field = field;
	}

	public override void Update(InterpretedFrame frame, object value)
	{
		object obj = ((!_object.HasValue) ? null : frame.Data[_object.GetValueOrDefault().Index]);
		_field.SetValue(obj, value);
	}

	public override void UndefineTemps(InstructionList instructions, LocalVariables locals)
	{
		if (_object.HasValue)
		{
			locals.UndefineLocal(_object.GetValueOrDefault(), instructions.Count);
		}
	}
}
