namespace System.Linq.Expressions;

internal class TypedParameterExpression : ParameterExpression
{
	public sealed override Type Type { get; }

	internal TypedParameterExpression(Type type, string name)
		: base(name)
	{
		Type = type;
	}
}
