using System;
using System.Collections.Generic;

namespace GameFramework.Runtime;

public class DefaultSerializer : ISerializer
{
	private class ComparerImpl<T> : IComparer<T> where T : ITypeEncoder
	{
		public int Compare(T x, T y)
		{
			return y.Priority.CompareTo(x.Priority);
		}
	}

	private readonly object _lock = new object();

	private static readonly ComparerImpl<ITypeEncoder> comparer = new ComparerImpl<ITypeEncoder>();

	private List<ITypeEncoder> encoders = new List<ITypeEncoder>();

	public DefaultSerializer()
	{
		AddTypeEncoder(new PrimitiveTypeEncoder());
		AddTypeEncoder(new VersionTypeEncoder());
		AddTypeEncoder(new EnumTypeEncoder());
		AddTypeEncoder(new JsonTypeEncoder());
	}

	public virtual void AddTypeEncoder(ITypeEncoder encoder)
	{
		lock (_lock)
		{
			if (!encoders.Contains(encoder))
			{
				encoders.Add(encoder);
				encoders.Sort(comparer);
			}
		}
	}

	public virtual void RemoveTypeEncoder(ITypeEncoder encoder)
	{
		lock (_lock)
		{
			if (encoders.Contains(encoder))
			{
				encoders.Remove(encoder);
			}
		}
	}

	public virtual object Deserialize(string input, Type type)
	{
		lock (_lock)
		{
			for (int i = 0; i < encoders.Count; i++)
			{
				try
				{
					ITypeEncoder typeEncoder = encoders[i];
					if (!typeEncoder.IsSupport(type))
					{
						continue;
					}
					return typeEncoder.Decode(type, input);
				}
				catch (Exception)
				{
				}
			}
		}
		throw new NotSupportedException($"This value \"{input}\" cannot be converted to the type \"{type.Name}\"");
	}

	public virtual string Serialize(object value)
	{
		lock (_lock)
		{
			for (int i = 0; i < encoders.Count; i++)
			{
				try
				{
					ITypeEncoder typeEncoder = encoders[i];
					if (!typeEncoder.IsSupport(value.GetType()))
					{
						continue;
					}
					return typeEncoder.Encode(value);
				}
				catch (Exception)
				{
				}
			}
		}
		throw new NotSupportedException($"Unsupported type, this value \"{value}\" cannot be serialized");
	}
}
