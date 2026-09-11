using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Diagnostics;
using System.Dynamic.Utils;

namespace System.Linq.Expressions;

[DebuggerTypeProxy(typeof(NewArrayExpressionProxy))]
public class NewArrayExpression : Expression
{
	public sealed override Type Type { get; }

	public ReadOnlyCollection<Expression> Expressions { get; }

	internal NewArrayExpression(Type type, ReadOnlyCollection<Expression> expressions)
	{
		Expressions = expressions;
		Type = type;
	}

	internal static NewArrayExpression Make(ExpressionType nodeType, Type type, ReadOnlyCollection<Expression> expressions)
	{
		if (nodeType == ExpressionType.NewArrayInit)
		{
			return new NewArrayInitExpression(type, expressions);
		}
		return new NewArrayBoundsExpression(type, expressions);
	}

	protected internal override Expression Accept(ExpressionVisitor visitor)
	{
		return visitor.VisitNewArray(this);
	}

	public NewArrayExpression Update(IEnumerable<Expression> expressions)
	{
		ContractUtils.RequiresNotNull(expressions, "expressions");
		if (ExpressionUtils.SameElements(ref expressions, Expressions))
		{
			return this;
		}
		if (NodeType != ExpressionType.NewArrayInit)
		{
			return Expression.NewArrayBounds(Type.GetElementType(), expressions);
		}
		return Expression.NewArrayInit(Type.GetElementType(), expressions);
	}
}
