using System.Reflection;

namespace System.Linq.Expressions;

internal sealed class OpAssignMethodConversionBinaryExpression : MethodBinaryExpression
{
	private readonly LambdaExpression _conversion;

	internal OpAssignMethodConversionBinaryExpression(ExpressionType nodeType, Expression left, Expression right, Type type, MethodInfo method, LambdaExpression conversion)
		: base(nodeType, left, right, type, method)
	{
		_conversion = conversion;
	}

	internal override LambdaExpression GetConversion()
	{
		return _conversion;
	}
}
