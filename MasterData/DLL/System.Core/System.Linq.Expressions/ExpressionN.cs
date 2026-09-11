using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Dynamic.Utils;

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

	internal override bool SameParameters(ICollection<ParameterExpression> parameters)
	{
		return ExpressionUtils.SameElements(parameters, _parameters);
	}

	internal override ReadOnlyCollection<ParameterExpression> GetOrMakeParameters()
	{
		return ExpressionUtils.ReturnReadOnly(ref _parameters);
	}

	internal override Expression<TDelegate> Rewrite(Expression body, ParameterExpression[] parameters)
	{
		return Expression.Lambda<TDelegate>(body, base.Name, base.TailCall, parameters ?? _parameters);
	}
}
