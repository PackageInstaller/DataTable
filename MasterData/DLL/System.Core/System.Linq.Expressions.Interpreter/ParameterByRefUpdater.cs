using System.Runtime.CompilerServices;

namespace System.Linq.Expressions.Interpreter;

internal sealed class ParameterByRefUpdater : ByRefUpdater
{
	private readonly LocalVariable _parameter;

	public ParameterByRefUpdater(LocalVariable parameter, int argumentIndex)
		: base(argumentIndex)
	{
		_parameter = parameter;
	}

	public override void Update(InterpretedFrame frame, object value)
	{
		if (_parameter.InClosure)
		{
			frame.Closure[_parameter.Index].Value = value;
		}
		else if (_parameter.IsBoxed)
		{
			((IStrongBox)frame.Data[_parameter.Index]).Value = value;
		}
		else
		{
			frame.Data[_parameter.Index] = value;
		}
	}
}
