using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Diagnostics;
using System.Dynamic.Utils;

namespace System.Linq.Expressions;

[DebuggerTypeProxy(typeof(Expression.SwitchCaseProxy))]
public sealed class SwitchCase
{
	public ReadOnlyCollection<Expression> TestValues { get; }

	public Expression Body { get; }

	internal SwitchCase(Expression body, ReadOnlyCollection<Expression> testValues)
	{
		Body = body;
		TestValues = testValues;
	}

	public override string ToString()
	{
		return ExpressionStringBuilder.SwitchCaseToString(this);
	}

	public SwitchCase Update(IEnumerable<Expression> testValues, Expression body)
	{
		if (((body == Body) & (testValues != null)) && ExpressionUtils.SameElements(ref testValues, TestValues))
		{
			return this;
		}
		return Expression.SwitchCase(body, testValues);
	}
}
