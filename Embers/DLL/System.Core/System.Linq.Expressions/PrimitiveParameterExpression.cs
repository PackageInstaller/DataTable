namespace System.Linq.Expressions;

internal sealed class PrimitiveParameterExpression<T> : ParameterExpression
{
	public sealed override Type Type => typeof(T);

	internal PrimitiveParameterExpression(string name)
		: base(name)
	{
	}
}
