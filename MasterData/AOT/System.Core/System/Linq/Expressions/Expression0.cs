namespace System.Linq.Expressions;

internal sealed class Expression0<TDelegate> : Expression<TDelegate>
{
	internal override int ParameterCount => 0;

	public Expression0(Expression body)
		: base(body)
	{
	}

	internal override ParameterExpression GetParameter(int index)
	{
		throw Error.ArgumentOutOfRange("index");
	}

	internal override Expression<TDelegate> Rewrite(Expression body, ParameterExpression[] parameters)
	{
		return Expression.Lambda<TDelegate>(body, parameters);
	}
}
