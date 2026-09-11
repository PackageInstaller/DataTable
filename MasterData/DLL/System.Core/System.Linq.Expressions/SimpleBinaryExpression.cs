namespace System.Linq.Expressions;

internal class SimpleBinaryExpression : BinaryExpression
{
	public sealed override ExpressionType NodeType { get; }

	public sealed override Type Type { get; }

	internal SimpleBinaryExpression(ExpressionType nodeType, Expression left, Expression right, Type type)
		: base(left, right)
	{
		NodeType = nodeType;
		Type = type;
	}
}
