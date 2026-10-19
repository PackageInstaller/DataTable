namespace System.Linq.Expressions;

internal class AssignBinaryExpression : BinaryExpression
{
	public sealed override Type Type => Left.Type;

	public sealed override ExpressionType NodeType => ExpressionType.Assign;

	internal AssignBinaryExpression(Expression left, Expression right)
		: base(left, right)
	{
	}
}
