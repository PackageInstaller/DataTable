using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Diagnostics;
using System.Dynamic.Utils;

namespace System.Linq.Expressions;

[DebuggerTypeProxy(typeof(ListInitExpressionProxy))]
public sealed class ListInitExpression : Expression
{
	public sealed override ExpressionType NodeType => ExpressionType.ListInit;

	public sealed override Type Type => NewExpression.Type;

	public override bool CanReduce => true;

	public NewExpression NewExpression { get; }

	public ReadOnlyCollection<ElementInit> Initializers { get; }

	internal ListInitExpression(NewExpression newExpression, ReadOnlyCollection<ElementInit> initializers)
	{
		NewExpression = newExpression;
		Initializers = initializers;
	}

	protected internal override Expression Accept(ExpressionVisitor visitor)
	{
		return visitor.VisitListInit(this);
	}

	public override Expression Reduce()
	{
		return MemberInitExpression.ReduceListInit(NewExpression, Initializers, keepOnStack: true);
	}

	public ListInitExpression Update(NewExpression newExpression, IEnumerable<ElementInit> initializers)
	{
		if (((newExpression == NewExpression) & (initializers != null)) && ExpressionUtils.SameElements(ref initializers, Initializers))
		{
			return this;
		}
		return Expression.ListInit(newExpression, initializers);
	}
}
