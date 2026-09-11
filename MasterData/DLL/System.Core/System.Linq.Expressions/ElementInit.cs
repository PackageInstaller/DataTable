using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Reflection;

namespace System.Linq.Expressions;

public sealed class ElementInit : IArgumentProvider
{
	public MethodInfo AddMethod { get; }

	public ReadOnlyCollection<Expression> Arguments { get; }

	public int ArgumentCount => Arguments.Count;

	internal ElementInit(MethodInfo addMethod, ReadOnlyCollection<Expression> arguments)
	{
		AddMethod = addMethod;
		Arguments = arguments;
	}

	public Expression GetArgument(int index)
	{
		return Arguments[index];
	}

	public override string ToString()
	{
		return ExpressionStringBuilder.ElementInitBindingToString(this);
	}

	public ElementInit Update(IEnumerable<Expression> arguments)
	{
		if (arguments == Arguments)
		{
			return this;
		}
		return Expression.ElementInit(AddMethod, arguments);
	}
}
