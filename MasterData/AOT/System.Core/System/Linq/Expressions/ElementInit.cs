using System.Collections.ObjectModel;
using System.Reflection;

namespace System.Linq.Expressions;

public sealed class ElementInit : IArgumentProvider
{
	public MethodInfo AddMethod { get; }

	public ReadOnlyCollection<Expression> Arguments { get; }

	public int ArgumentCount => Arguments.Count;

	public Expression GetArgument(int index)
	{
		return Arguments[index];
	}
}
