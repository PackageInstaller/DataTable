using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Dynamic.Utils;
using System.Reflection;

namespace System.Linq.Expressions;

internal sealed class InstanceMethodCallExpression0 : InstanceMethodCallExpression, IArgumentProvider
{
	public override int ArgumentCount => 0;

	public InstanceMethodCallExpression0(MethodInfo method, Expression instance)
		: base(method, instance)
	{
	}

	public override Expression GetArgument(int index)
	{
		throw new ArgumentOutOfRangeException("index");
	}

	internal override ReadOnlyCollection<Expression> GetOrMakeArguments()
	{
		return EmptyReadOnlyCollection<Expression>.Instance;
	}

	internal override bool SameArguments(ICollection<Expression> arguments)
	{
		if (arguments != null)
		{
			return arguments.Count == 0;
		}
		return true;
	}

	internal override MethodCallExpression Rewrite(Expression instance, IReadOnlyList<Expression> args)
	{
		return Expression.Call(instance, base.Method);
	}
}
