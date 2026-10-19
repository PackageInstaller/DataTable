namespace System.Linq.Expressions;

public sealed class MemberAssignment : MemberBinding
{
	private readonly Expression _expression;

	public Expression Expression => _expression;
}
