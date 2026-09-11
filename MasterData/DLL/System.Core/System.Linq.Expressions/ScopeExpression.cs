using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Dynamic.Utils;

namespace System.Linq.Expressions;

internal class ScopeExpression : BlockExpression
{
	private IReadOnlyList<ParameterExpression> _variables;

	protected IReadOnlyList<ParameterExpression> VariablesList => _variables;

	internal ScopeExpression(IReadOnlyList<ParameterExpression> variables)
	{
		_variables = variables;
	}

	internal override ReadOnlyCollection<ParameterExpression> GetOrMakeVariables()
	{
		return ExpressionUtils.ReturnReadOnly(ref _variables);
	}

	internal IReadOnlyList<ParameterExpression> ReuseOrValidateVariables(ReadOnlyCollection<ParameterExpression> variables)
	{
		if (variables != null && variables != VariablesList)
		{
			Expression.ValidateVariables(variables, "variables");
			return variables;
		}
		return VariablesList;
	}
}
