using System.Collections.ObjectModel;

namespace System.Linq.Expressions;

internal static class ExpressionCreator<TDelegate>
{
	public static LambdaExpression CreateExpressionFunc(Expression body, string name, bool tailCall, ReadOnlyCollection<ParameterExpression> parameters)
	{
		if (name == null && !tailCall)
		{
			return parameters.Count switch
			{
				0 => new Expression0<TDelegate>(body), 
				1 => new Expression1<TDelegate>(body, parameters[0]), 
				2 => new Expression2<TDelegate>(body, parameters[0], parameters[1]), 
				3 => new Expression3<TDelegate>(body, parameters[0], parameters[1], parameters[2]), 
				_ => new ExpressionN<TDelegate>(body, parameters), 
			};
		}
		return new FullExpression<TDelegate>(body, name, tailCall, parameters);
	}
}
