using System.Reflection;

namespace System.Linq.Expressions;

internal class MethodBinaryExpression : SimpleBinaryExpression
{
	private readonly MethodInfo _method;

	internal MethodBinaryExpression(ExpressionType nodeType, Expression left, Expression right, Type type, MethodInfo method)
		: base(nodeType, left, right, type)
	{
		_method = method;
	}

	internal override MethodInfo GetMethod()
	{
		return _method;
	}
}
