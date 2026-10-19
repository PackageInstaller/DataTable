using System.Collections.ObjectModel;

namespace System.Linq.Expressions;

internal sealed class NewArrayInitExpression : NewArrayExpression
{
	public sealed override ExpressionType NodeType => ExpressionType.NewArrayInit;

	internal NewArrayInitExpression(Type type, ReadOnlyCollection<Expression> expressions)
		: base(type, expressions)
	{
	}
}
