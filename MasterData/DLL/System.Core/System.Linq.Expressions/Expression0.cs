using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Dynamic.Utils;

namespace System.Linq.Expressions;

internal sealed class Expression0<TDelegate> : Expression<TDelegate>
{
	internal override int ParameterCount => 0;

	public Expression0(Expression body)
		: base(body)
	{
	}

	internal override bool SameParameters(ICollection<ParameterExpression> parameters)
	{
		if (parameters != null)
		{
			return parameters.Count == 0;
		}
		return true;
	}

	internal override ParameterExpression GetParameter(int index)
	{
		throw Error.ArgumentOutOfRange("index");
	}

	internal override ReadOnlyCollection<ParameterExpression> GetOrMakeParameters()
	{
		return EmptyReadOnlyCollection<ParameterExpression>.Instance;
	}

	internal override Expression<TDelegate> Rewrite(Expression body, ParameterExpression[] parameters)
	{
		return Expression.Lambda<TDelegate>(body, parameters);
	}
}
