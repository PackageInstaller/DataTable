using System;

namespace GameFramework.Runtime.Parameters;

public class ExpressionCommandParameter<TParam> : ICommandParameter
{
	private Func<TParam> expression;

	public ExpressionCommandParameter(Func<TParam> expression)
	{
		this.expression = expression;
	}

	public object GetValue()
	{
		return expression();
	}

	public Type GetValueType()
	{
		return typeof(TParam);
	}
}
