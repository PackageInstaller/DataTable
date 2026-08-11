using System;
using System.Collections;
using System.Collections.Generic;

namespace GameFramework.Runtime;

public class Attributes : IAttributes
{
	private class EmptyEnumerator : IEnumerator
	{
		public object Current => null;

		public bool MoveNext()
		{
			return false;
		}

		public void Reset()
		{
		}
	}

	private Dictionary<Type, object> attributes = null;

	public virtual void Add(Type type, object target)
	{
		if (attributes == null)
		{
			attributes = new Dictionary<Type, object>();
		}
		if (!(type == null) && target != null)
		{
			attributes[type] = target;
		}
	}

	public virtual void Add<T>(T target)
	{
		Add(typeof(T), target);
	}

	public virtual object Get(Type type)
	{
		if (type == null || attributes == null || !attributes.ContainsKey(type))
		{
			return null;
		}
		return attributes[type];
	}

	public virtual T Get<T>()
	{
		return (T)Get(typeof(T));
	}

	public virtual object Remove(Type type)
	{
		if (type == null || attributes == null || !attributes.ContainsKey(type))
		{
			return null;
		}
		object result = attributes[type];
		attributes.Remove(type);
		return result;
	}

	public virtual T Remove<T>()
	{
		return (T)Remove(typeof(T));
	}

	public virtual IEnumerator GetEnumerator()
	{
		if (attributes == null)
		{
			return new EmptyEnumerator();
		}
		return attributes.GetEnumerator();
	}
}
