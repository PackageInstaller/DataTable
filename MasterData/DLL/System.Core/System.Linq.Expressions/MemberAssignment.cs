using System.Reflection;

namespace System.Linq.Expressions;

public sealed class MemberAssignment : MemberBinding
{
	private readonly Expression _expression;

	public Expression Expression => _expression;

	internal MemberAssignment(MemberInfo member, Expression expression)
		: base(MemberBindingType.Assignment, member)
	{
		_expression = expression;
	}

	public MemberAssignment Update(Expression expression)
	{
		if (expression == Expression)
		{
			return this;
		}
		return Expression.Bind(base.Member, expression);
	}

	internal override void ValidateAsDefinedHere(int index)
	{
	}
}
