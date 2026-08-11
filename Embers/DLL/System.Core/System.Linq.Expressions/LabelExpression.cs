using System.Diagnostics;

namespace System.Linq.Expressions;

[DebuggerTypeProxy(typeof(LabelExpressionProxy))]
public sealed class LabelExpression : Expression
{
	public sealed override Type Type => Target.Type;

	public sealed override ExpressionType NodeType => ExpressionType.Label;

	public LabelTarget Target { get; }

	public Expression DefaultValue { get; }

	internal LabelExpression(LabelTarget label, Expression defaultValue)
	{
		Target = label;
		DefaultValue = defaultValue;
	}

	protected internal override Expression Accept(ExpressionVisitor visitor)
	{
		return visitor.VisitLabel(this);
	}

	public LabelExpression Update(LabelTarget target, Expression defaultValue)
	{
		if (target == Target && defaultValue == DefaultValue)
		{
			return this;
		}
		return Expression.Label(target, defaultValue);
	}
}
