using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Dynamic.Utils;

namespace System.Linq.Expressions;

internal sealed class Expression2<TDelegate> : Expression<TDelegate>
{
	private object _par0;

	private readonly ParameterExpression _par1;

	internal override int ParameterCount => 2;

	public Expression2(Expression body, ParameterExpression par0, ParameterExpression par1)
		: base(body)
	{
		_par0 = par0;
		_par1 = par1;
	}

	internal override ParameterExpression GetParameter(int index)
	{
		return index switch
		{
			0 => ExpressionUtils.ReturnObject<ParameterExpression>(_par0), 
			1 => _par1, 
			_ => throw Error.ArgumentOutOfRange("index"), 
		};
	}

	internal override bool SameParameters(ICollection<ParameterExpression> parameters)
	{
		if (parameters != null && parameters.Count == 2)
		{
			if (_par0 is ReadOnlyCollection<ParameterExpression> current)
			{
				return ExpressionUtils.SameElements(parameters, current);
			}
			using IEnumerator<ParameterExpression> enumerator = parameters.GetEnumerator();
			enumerator.MoveNext();
			if (enumerator.Current == _par0)
			{
				enumerator.MoveNext();
				return enumerator.Current == _par1;
			}
		}
		return false;
	}

	internal override ReadOnlyCollection<ParameterExpression> GetOrMakeParameters()
	{
		return ExpressionUtils.ReturnReadOnly(this, ref _par0);
	}

	internal override Expression<TDelegate> Rewrite(Expression body, ParameterExpression[] parameters)
	{
		if (parameters != null)
		{
			return Expression.Lambda<TDelegate>(body, parameters);
		}
		return Expression.Lambda<TDelegate>(body, new ParameterExpression[2]
		{
			ExpressionUtils.ReturnObject<ParameterExpression>(_par0),
			_par1
		});
	}
}
