using System;
using System.Collections.Generic;
using System.Linq.Expressions;

namespace GameFramework.Runtime;

internal class Scope
{
	private readonly Scope parent;

	private readonly Dictionary<ParameterExpression, object> values = new Dictionary<ParameterExpression, object>();

	public object this[ParameterExpression key]
	{
		get
		{
			if (values.TryGetValue(key, out var value))
			{
				return value;
			}
			if (parent != null)
			{
				return parent[key];
			}
			throw new InvalidOperationException("Parameter not defined.");
		}
		set
		{
			if (values.ContainsKey(key))
			{
				values[key] = value;
				return;
			}
			if (parent != null)
			{
				parent[key] = value;
				return;
			}
			throw new KeyNotFoundException();
		}
	}

	public Scope()
	{
		parent = null;
	}

	public Scope(Scope parent)
	{
		this.parent = parent;
	}

	public bool ContainsKey(ParameterExpression key)
	{
		return values.ContainsKey(key) || (parent != null && parent.ContainsKey(key));
	}

	public void Register(ParameterExpression expr, object value)
	{
		values[expr] = value;
	}
}
