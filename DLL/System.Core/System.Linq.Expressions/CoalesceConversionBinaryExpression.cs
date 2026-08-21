namespace System.Linq.Expressions;

internal sealed class CoalesceConversionBinaryExpression : BinaryExpression
{
	private readonly LambdaExpression _conversion;

	public sealed override ExpressionType NodeType => ExpressionType.Coalesce;

	public sealed override Type Type => base.Right.Type;

	internal CoalesceConversionBinaryExpression(Expression left, Expression right, LambdaExpression conversion)
		: base(left, right)
	{
		_conversion = conversion;
	}

	internal override LambdaExpression GetConversion()
	{
		return _conversion;
	}
}
