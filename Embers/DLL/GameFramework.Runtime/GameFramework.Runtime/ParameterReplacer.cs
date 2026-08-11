using System;
using System.Linq.Expressions;
using System.Runtime.CompilerServices;

namespace GameFramework.Runtime;

internal class ParameterReplacer : ExpressionVisitor
{
	private readonly Scope scope;

	public ParameterReplacer(Scope scope)
	{
		this.scope = scope;
	}

	protected override Expression VisitParameter(ParameterExpression expr)
	{
		if (scope.ContainsKey(expr))
		{
			Type type = typeof(StrongBox<>).MakeGenericType(expr.Type);
			return Expression.Field(Expression.Constant(Activator.CreateInstance(type, scope[expr]), type), "Value");
		}
		return base.VisitParameter(expr);
	}
}
