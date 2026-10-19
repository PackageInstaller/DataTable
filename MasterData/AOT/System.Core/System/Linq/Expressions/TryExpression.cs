using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Diagnostics;
using System.Dynamic.Utils;

namespace System.Linq.Expressions;

[DebuggerTypeProxy(typeof(TryExpressionProxy))]
public sealed class TryExpression : Expression
{
	public sealed override Type Type { get; }

	public sealed override ExpressionType NodeType => ExpressionType.Try;

	public Expression Body { get; }

	public ReadOnlyCollection<CatchBlock> Handlers { get; }

	public Expression Finally { get; }

	public Expression Fault { get; }

	internal TryExpression(Type type, Expression body, Expression @finally, Expression fault, ReadOnlyCollection<CatchBlock> handlers)
	{
		Type = type;
		Body = body;
		Handlers = handlers;
		Finally = @finally;
		Fault = fault;
	}

	protected internal override Expression Accept(ExpressionVisitor visitor)
	{
		return visitor.VisitTry(this);
	}

	public TryExpression Update(Expression body, IEnumerable<CatchBlock> handlers, Expression @finally, Expression fault)
	{
		if (((body == Body) & (@finally == Finally) & (fault == Fault)) && ExpressionUtils.SameElements(ref handlers, Handlers))
		{
			return this;
		}
		return Expression.MakeTry(Type, body, @finally, fault, handlers);
	}
}
