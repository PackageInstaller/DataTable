using System.Collections.ObjectModel;
using System.Diagnostics;

namespace System.Linq.Expressions;

[DebuggerTypeProxy(typeof(Expression.SwitchCaseProxy))]
public sealed class SwitchCase
{
	public ReadOnlyCollection<Expression> TestValues { get; }

	public Expression Body { get; }
}
