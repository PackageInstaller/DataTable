using System.Collections.Generic;

namespace System.Linq.Expressions;

internal class ExpressionN<TDelegate> : Expression<TDelegate>
{
	private IReadOnlyList<ParameterExpression> _parameters;

	internal override int ParameterCount => _parameters.Count;

	public ExpressionN(Expression body, IReadOnlyList<ParameterExpression> parameters)
		: base(body)
	{
		_parameters = parameters;
	}

	internal override ParameterExpression GetParameter(int index)
	{
		return _parameters[index];
	}

	internal override Expression<TDelegate> Rewrite(Expression body, ParameterExpression[] parameters)
	{
		return Expression.Lambda<TDelegate>(body, Name, TailCall, parameters ?? _parameters);
	}
}
