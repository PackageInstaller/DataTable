using System.Diagnostics;

namespace System.Linq.Expressions;

[DebuggerTypeProxy(typeof(TypeBinaryExpressionProxy))]
public sealed class TypeBinaryExpression : Expression
{
	public sealed override Type Type => typeof(bool);

	public sealed override ExpressionType NodeType { get; }

	public Expression Expression { get; }

	public Type TypeOperand { get; }

	internal TypeBinaryExpression(Expression expression, Type typeOperand, ExpressionType nodeType)
	{
		Expression = expression;
		TypeOperand = typeOperand;
		NodeType = nodeType;
	}

	protected internal override Expression Accept(ExpressionVisitor visitor)
	{
		return visitor.VisitTypeBinary(this);
	}

	public TypeBinaryExpression Update(Expression expression)
	{
		if (expression == Expression)
		{
			return this;
		}
		if (NodeType == ExpressionType.TypeIs)
		{
			return Expression.TypeIs(expression, TypeOperand);
		}
		return Expression.TypeEqual(expression, TypeOperand);
	}
}
