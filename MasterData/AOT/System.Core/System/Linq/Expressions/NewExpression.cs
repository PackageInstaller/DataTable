using System.Collections.Generic;
using System.Diagnostics;
using System.Reflection;

namespace System.Linq.Expressions;

[DebuggerTypeProxy(typeof(NewExpressionProxy))]
public class NewExpression : Expression
{
	private IReadOnlyList<Expression> _arguments;

	public ConstructorInfo Constructor { get; }

	public Expression GetArgument(int index)
	{
		return _arguments[index];
	}
}
