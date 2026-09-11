using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Dynamic.Utils;

namespace System.Linq.Expressions;

internal class BlockN : BlockExpression
{
	private IReadOnlyList<Expression> _expressions;

	internal override int ExpressionCount => _expressions.Count;

	internal BlockN(IReadOnlyList<Expression> expressions)
	{
		_expressions = expressions;
	}

	internal override Expression GetExpression(int index)
	{
		return _expressions[index];
	}

	internal override ReadOnlyCollection<Expression> GetOrMakeExpressions()
	{
		return ExpressionUtils.ReturnReadOnly(ref _expressions);
	}

	internal override BlockExpression Rewrite(ReadOnlyCollection<ParameterExpression> variables, Expression[] args)
	{
		return new BlockN(args);
	}
}
