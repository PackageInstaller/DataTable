using System.Diagnostics;

namespace System.Linq.Expressions;

[DebuggerTypeProxy(typeof(ConditionalExpressionProxy))]
public class ConditionalExpression : Expression
{
	public sealed override ExpressionType NodeType => ExpressionType.Conditional;

	public override Type Type => IfTrue.Type;

	public Expression Test { get; }

	public Expression IfTrue { get; }

	public Expression IfFalse => GetFalse();

	internal ConditionalExpression(Expression test, Expression ifTrue)
	{
		Test = test;
		IfTrue = ifTrue;
	}

	internal static ConditionalExpression Make(Expression test, Expression ifTrue, Expression ifFalse, Type type)
	{
		if (ifTrue.Type != type || ifFalse.Type != type)
		{
			return new FullConditionalExpressionWithType(test, ifTrue, ifFalse, type);
		}
		if (ifFalse is DefaultExpression && ifFalse.Type == typeof(void))
		{
			return new ConditionalExpression(test, ifTrue);
		}
		return new FullConditionalExpression(test, ifTrue, ifFalse);
	}

	internal virtual Expression GetFalse()
	{
		return Utils.Empty;
	}

	protected internal override Expression Accept(ExpressionVisitor visitor)
	{
		return visitor.VisitConditional(this);
	}

	public ConditionalExpression Update(Expression test, Expression ifTrue, Expression ifFalse)
	{
		if (test == Test && ifTrue == IfTrue && ifFalse == IfFalse)
		{
			return this;
		}
		return Expression.Condition(test, ifTrue, ifFalse, Type);
	}
}
