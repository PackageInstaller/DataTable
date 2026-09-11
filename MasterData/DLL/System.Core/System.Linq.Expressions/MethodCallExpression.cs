using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Diagnostics;
using System.Diagnostics.CodeAnalysis;
using System.Dynamic.Utils;
using System.Reflection;

namespace System.Linq.Expressions;

[DebuggerTypeProxy(typeof(MethodCallExpressionProxy))]
public class MethodCallExpression : Expression, IArgumentProvider
{
	public sealed override ExpressionType NodeType => ExpressionType.Call;

	public sealed override Type Type => Method.ReturnType;

	public MethodInfo Method { get; }

	public Expression Object => GetInstance();

	public ReadOnlyCollection<Expression> Arguments => GetOrMakeArguments();

	[ExcludeFromCodeCoverage]
	public virtual int ArgumentCount
	{
		get
		{
			throw ContractUtils.Unreachable;
		}
	}

	internal MethodCallExpression(MethodInfo method)
	{
		Method = method;
	}

	internal virtual Expression GetInstance()
	{
		return null;
	}

	[ExcludeFromCodeCoverage]
	internal virtual ReadOnlyCollection<Expression> GetOrMakeArguments()
	{
		throw ContractUtils.Unreachable;
	}

	protected internal override Expression Accept(ExpressionVisitor visitor)
	{
		return visitor.VisitMethodCall(this);
	}

	[ExcludeFromCodeCoverage]
	internal virtual MethodCallExpression Rewrite(Expression instance, IReadOnlyList<Expression> args)
	{
		throw ContractUtils.Unreachable;
	}

	[ExcludeFromCodeCoverage]
	public virtual Expression GetArgument(int index)
	{
		throw ContractUtils.Unreachable;
	}
}
