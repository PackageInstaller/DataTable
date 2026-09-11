using System.Reflection;

namespace System.Linq.Expressions;

internal sealed class FieldExpression : MemberExpression
{
	private readonly FieldInfo _field;

	public sealed override Type Type => _field.FieldType;

	public FieldExpression(Expression expression, FieldInfo member)
		: base(expression)
	{
		_field = member;
	}

	internal override MemberInfo GetMember()
	{
		return _field;
	}
}
