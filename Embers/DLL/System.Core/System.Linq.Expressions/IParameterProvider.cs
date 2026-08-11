namespace System.Linq.Expressions;

internal interface IParameterProvider
{
	int ParameterCount { get; }

	ParameterExpression GetParameter(int index);
}
