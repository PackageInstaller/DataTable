using System.Collections.ObjectModel;
using System.Diagnostics;
using System.Diagnostics.CodeAnalysis;
using System.Dynamic.Utils;

namespace System.Linq.Expressions;

[DebuggerTypeProxy(typeof(InvocationExpressionProxy))]
public class InvocationExpression : Expression, IArgumentProvider
{
	public sealed override Type Type { get; }

	public sealed override ExpressionType NodeType => ExpressionType.Invoke;

	public Expression Expression { get; }

	public ReadOnlyCollection<Expression> Arguments => GetOrMakeArguments();

	[ExcludeFromCodeCoverage]
	public virtual int ArgumentCount
	{
		get
		{
			throw ContractUtils.Unreachable;
		}
	}

	internal InvocationExpression(Expression expression, Type returnType)
	{
		Expression = expression;
		Type = returnType;
	}

	[ExcludeFromCodeCoverage]
	internal virtual ReadOnlyCollection<Expression> GetOrMakeArguments()
	{
		throw ContractUtils.Unreachable;
	}

	[ExcludeFromCodeCoverage]
	public virtual Expression GetArgument(int index)
	{
		throw ContractUtils.Unreachable;
	}

	protected internal override Expression Accept(ExpressionVisitor visitor)
	{
		return visitor.VisitInvocation(this);
	}

	[ExcludeFromCodeCoverage]
	internal virtual InvocationExpression Rewrite(Expression lambda, Expression[] arguments)
	{
		throw ContractUtils.Unreachable;
	}
}
