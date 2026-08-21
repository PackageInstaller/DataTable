using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Dynamic.Utils;

namespace System.Linq.Expressions;

internal class ScopeN : ScopeExpression
{
	private IReadOnlyList<Expression> _body;

	protected IReadOnlyList<Expression> Body => _body;

	internal override int ExpressionCount => _body.Count;

	internal ScopeN(IReadOnlyList<ParameterExpression> variables, IReadOnlyList<Expression> body)
		: base(variables)
	{
		_body = body;
	}

	internal override Expression GetExpression(int index)
	{
		return _body[index];
	}

	internal override ReadOnlyCollection<Expression> GetOrMakeExpressions()
	{
		return ExpressionUtils.ReturnReadOnly(ref _body);
	}

	internal override BlockExpression Rewrite(ReadOnlyCollection<ParameterExpression> variables, Expression[] args)
	{
		if (args == null)
		{
			Expression.ValidateVariables(variables, "variables");
			return new ScopeN(variables, _body);
		}
		return new ScopeN(ReuseOrValidateVariables(variables), args);
	}
}
