using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Diagnostics;
using System.Dynamic.Utils;
using System.Runtime.CompilerServices;

namespace System.Linq.Expressions;

[DebuggerTypeProxy(typeof(RuntimeVariablesExpressionProxy))]
public sealed class RuntimeVariablesExpression : Expression
{
	public sealed override Type Type => typeof(IRuntimeVariables);

	public sealed override ExpressionType NodeType => ExpressionType.RuntimeVariables;

	public ReadOnlyCollection<ParameterExpression> Variables { get; }

	internal RuntimeVariablesExpression(ReadOnlyCollection<ParameterExpression> variables)
	{
		Variables = variables;
	}

	protected internal override Expression Accept(ExpressionVisitor visitor)
	{
		return visitor.VisitRuntimeVariables(this);
	}

	public RuntimeVariablesExpression Update(IEnumerable<ParameterExpression> variables)
	{
		if (variables != null && ExpressionUtils.SameElements(ref variables, Variables))
		{
			return this;
		}
		return Expression.RuntimeVariables(variables);
	}
}
