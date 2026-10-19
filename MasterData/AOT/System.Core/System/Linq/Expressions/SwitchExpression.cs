using System.Collections.ObjectModel;
using System.Diagnostics;
using System.Reflection;

namespace System.Linq.Expressions;

[DebuggerTypeProxy(typeof(SwitchExpressionProxy))]
public sealed class SwitchExpression : Expression
{
	public Expression SwitchValue { get; }

	public ReadOnlyCollection<SwitchCase> Cases { get; }

	public Expression DefaultBody { get; }

	public MethodInfo Comparison { get; }
}
