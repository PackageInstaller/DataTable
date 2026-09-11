using System.Collections.Generic;

namespace System.Linq.Expressions;

internal sealed class FullExpression<TDelegate> : ExpressionN<TDelegate>
{
	internal override string NameCore { get; }

	internal override bool TailCallCore { get; }

	public FullExpression(Expression body, string name, bool tailCall, IReadOnlyList<ParameterExpression> parameters)
		: base(body, parameters)
	{
		NameCore = name;
		TailCallCore = tailCall;
	}
}
