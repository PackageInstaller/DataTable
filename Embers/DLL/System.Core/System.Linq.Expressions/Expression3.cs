using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Dynamic.Utils;

namespace System.Linq.Expressions;

internal sealed class Expression3<TDelegate> : Expression<TDelegate>
{
	private object _par0;

	private readonly ParameterExpression _par1;

	private readonly ParameterExpression _par2;

	internal override int ParameterCount => 3;

	public Expression3(Expression body, ParameterExpression par0, ParameterExpression par1, ParameterExpression par2)
		: base(body)
	{
		_par0 = par0;
		_par1 = par1;
		_par2 = par2;
	}

	internal override ParameterExpression GetParameter(int index)
	{
		return index switch
		{
			0 => ExpressionUtils.ReturnObject<ParameterExpression>(_par0), 
			1 => _par1, 
			2 => _par2, 
			_ => throw Error.ArgumentOutOfRange("index"), 
		};
	}

	internal override bool SameParameters(ICollection<ParameterExpression> parameters)
	{
		if (parameters != null && parameters.Count == 3)
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
				if (enumerator.Current == _par1)
				{
					enumerator.MoveNext();
					return enumerator.Current == _par2;
				}
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
		return Expression.Lambda<TDelegate>(body, new ParameterExpression[3]
		{
			ExpressionUtils.ReturnObject<ParameterExpression>(_par0),
			_par1,
			_par2
		});
	}
}
