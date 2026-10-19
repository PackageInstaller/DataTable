using System.Dynamic.Utils;
using System.Reflection;

namespace System.Linq.Expressions.Interpreter;

internal sealed class PropertyByRefUpdater : ByRefUpdater
{
	private readonly LocalDefinition? _object;

	private readonly PropertyInfo _property;

	public PropertyByRefUpdater(LocalDefinition? obj, PropertyInfo property, int argumentIndex)
		: base(argumentIndex)
	{
		_object = obj;
		_property = property;
	}

	public override void Update(InterpretedFrame frame, object value)
	{
		object obj = ((!_object.HasValue) ? null : frame.Data[_object.GetValueOrDefault().Index]);
		try
		{
			_property.SetValue(obj, value);
		}
		catch (TargetInvocationException exception)
		{
			ExceptionHelpers.UnwrapAndRethrow(exception);
			throw ContractUtils.Unreachable;
		}
	}

	public override void UndefineTemps(InstructionList instructions, LocalVariables locals)
	{
		if (_object.HasValue)
		{
			locals.UndefineLocal(_object.GetValueOrDefault(), instructions.Count);
		}
	}
}
