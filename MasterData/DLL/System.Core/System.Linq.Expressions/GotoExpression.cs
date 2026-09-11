using System.Diagnostics;

namespace System.Linq.Expressions;

[DebuggerTypeProxy(typeof(GotoExpressionProxy))]
public sealed class GotoExpression : Expression
{
	public sealed override Type Type { get; }

	public sealed override ExpressionType NodeType => ExpressionType.Goto;

	public Expression Value { get; }

	public LabelTarget Target { get; }

	public GotoExpressionKind Kind { get; }

	internal GotoExpression(GotoExpressionKind kind, LabelTarget target, Expression value, Type type)
	{
		Kind = kind;
		Value = value;
		Target = target;
		Type = type;
	}

	protected internal override Expression Accept(ExpressionVisitor visitor)
	{
		return visitor.VisitGoto(this);
	}

	public GotoExpression Update(LabelTarget target, Expression value)
	{
		if (target == Target && value == Value)
		{
			return this;
		}
		return Expression.MakeGoto(Kind, target, value, Type);
	}
}
