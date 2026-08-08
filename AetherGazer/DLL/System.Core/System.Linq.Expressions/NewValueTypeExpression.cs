using System.Collections.ObjectModel;
using System.Reflection;

namespace System.Linq.Expressions;

internal sealed class NewValueTypeExpression : NewExpression
{
	public sealed override Type Type { get; }

	internal NewValueTypeExpression(Type type, ReadOnlyCollection<Expression> arguments, ReadOnlyCollection<MemberInfo> members)
		: base(null, arguments, members)
	{
		Type = type;
	}
}
