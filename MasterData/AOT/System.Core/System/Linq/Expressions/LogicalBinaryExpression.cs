namespace System.Linq.Expressions;

internal sealed class LogicalBinaryExpression : BinaryExpression
{
	public sealed override Type Type => typeof(bool);

	public sealed override ExpressionType NodeType { get; }

	internal LogicalBinaryExpression(ExpressionType nodeType, Expression left, Expression right)
		: base(left, right)
	{
		NodeType = nodeType;
	}
}
