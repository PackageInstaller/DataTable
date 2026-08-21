using System.Collections.Generic;
using GameFramework.Runtime.Proxy;

namespace GameFramework.Runtime;

public class ObjectSourceProxyFactory : TypedSourceProxyFactory<ObjectSourceDescription>, INodeProxyFactory, INodeProxyFactoryRegister
{
	private struct PriorityFactoryPair(INodeProxyFactory factory, int priority)
	{
		public int priority = priority;

		public INodeProxyFactory factory = factory;
	}

	private List<PriorityFactoryPair> factories = new List<PriorityFactoryPair>();

	protected override bool TryCreateProxy(object source, ObjectSourceDescription description, out ISourceProxy proxy)
	{
		proxy = null;
		Path path = description.Path;
		if (path.Count <= 0)
		{
			throw new ProxyException("The path nodes of the ObjectSourceDescription \"{0}\" is empty.", description.ToString());
		}
		PathToken token = path.AsPathToken();
		if (path.Count == 1)
		{
			proxy = Create(source, token);
			if (proxy != null)
			{
				return true;
			}
			return false;
		}
		proxy = new ChainedObjectSourceProxy(source, token, this);
		return true;
	}

	public virtual ISourceProxy Create(object source, PathToken token)
	{
		ISourceProxy sourceProxy = null;
		foreach (PriorityFactoryPair factory2 in factories)
		{
			INodeProxyFactory factory = factory2.factory;
			if (factory != null)
			{
				sourceProxy = factory.Create(source, token);
				if (sourceProxy != null)
				{
					return sourceProxy;
				}
			}
		}
		return sourceProxy;
	}

	public virtual void Register(INodeProxyFactory factory, int priority = 100)
	{
		if (factory != null)
		{
			factories.Add(new PriorityFactoryPair(factory, priority));
			factories.Sort((PriorityFactoryPair x, PriorityFactoryPair y) => y.priority.CompareTo(x.priority));
		}
	}

	public virtual void Unregister(INodeProxyFactory factory)
	{
		if (factory != null)
		{
			factories.RemoveAll((PriorityFactoryPair pair) => pair.factory == factory);
		}
	}
}
