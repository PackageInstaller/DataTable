using System.Reflection;

namespace System.Linq.Expressions;

internal sealed class PropertyExpression : MemberExpression
{
	private readonly PropertyInfo _property;

	public sealed override Type Type => _property.PropertyType;

	public PropertyExpression(Expression expression, PropertyInfo member)
		: base(expression)
	{
		_property = member;
	}

	internal override MemberInfo GetMember()
	{
		return _property;
	}
}
