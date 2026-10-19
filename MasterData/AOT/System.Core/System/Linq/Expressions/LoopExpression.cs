using System.Diagnostics;

namespace System.Linq.Expressions;

[DebuggerTypeProxy(typeof(LoopExpressionProxy))]
public sealed class LoopExpression : Expression
{
	public sealed override Type Type
	{
		get
		{
			if (BreakLabel != null)
			{
				return BreakLabel.Type;
			}
			return typeof(void);
		}
	}

	public sealed override ExpressionType NodeType => ExpressionType.Loop;

	public Expression Body { get; }

	public LabelTarget BreakLabel { get; }

	public LabelTarget ContinueLabel { get; }

	internal LoopExpression(Expression body, LabelTarget @break, LabelTarget @continue)
	{
		Body = body;
		BreakLabel = @break;
		ContinueLabel = @continue;
	}

	protected internal override Expression Accept(ExpressionVisitor visitor)
	{
		return visitor.VisitLoop(this);
	}

	public LoopExpression Update(LabelTarget breakLabel, LabelTarget continueLabel, Expression body)
	{
		if (breakLabel == BreakLabel && continueLabel == ContinueLabel && body == Body)
		{
			return this;
		}
		return Expression.Loop(body, breakLabel, continueLabel);
	}
}
