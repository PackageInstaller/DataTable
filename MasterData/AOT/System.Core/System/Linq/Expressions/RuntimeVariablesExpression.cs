using System.Collections.ObjectModel;
using System.Diagnostics;

namespace System.Linq.Expressions;

[DebuggerTypeProxy(typeof(RuntimeVariablesExpressionProxy))]
public sealed class RuntimeVariablesExpression : Expression
{
	public ReadOnlyCollection<ParameterExpression> Variables { get; }
}
