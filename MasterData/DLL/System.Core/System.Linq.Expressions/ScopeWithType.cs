using System.Collections.Generic;
using System.Collections.ObjectModel;

namespace System.Linq.Expressions;

internal sealed class ScopeWithType : ScopeN
{
	public sealed override Type Type { get; }

	internal ScopeWithType(IReadOnlyList<ParameterExpression> variables, IReadOnlyList<Expression> expressions, Type type)
		: base(variables, expressions)
	{
		Type = type;
	}

	internal override BlockExpression Rewrite(ReadOnlyCollection<ParameterExpression> variables, Expression[] args)
	{
		if (args == null)
		{
			Expression.ValidateVariables(variables, "variables");
			return new ScopeWithType(variables, base.Body, Type);
		}
		return new ScopeWithType(ReuseOrValidateVariables(variables), args, Type);
	}
}
