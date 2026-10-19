using System.Diagnostics;

namespace System.Linq.Expressions;

[DebuggerTypeProxy(typeof(DefaultExpressionProxy))]
public sealed class DefaultExpression : Expression
{
	public sealed override Type Type { get; }

	public sealed override ExpressionType NodeType => ExpressionType.Default;

	internal DefaultExpression(Type type)
	{
		Type = type;
	}

	protected internal override Expression Accept(ExpressionVisitor visitor)
	{
		return visitor.VisitDefault(this);
	}
}
