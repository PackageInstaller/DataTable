#define ENABLE_LOG
using System;
using System.Collections.Generic;
using GameFramework.Runtime.Proxy;

namespace GameFramework.Runtime;

public class SourceProxyFactory : ISourceProxyFactory, ISourceProxyFactoryRegistry
{
	private struct PriorityFactoryPair(ISourceProxyFactory factory, int priority)
	{
		public int priority = priority;

		public ISourceProxyFactory factory = factory;
	}

	private List<PriorityFactoryPair> factories = new List<PriorityFactoryPair>();

	public ISourceProxy CreateProxy(object source, SourceDescription description)
	{
		try
		{
			if (!description.IsStatic && source == null)
			{
				return new EmptSourceProxy(description);
			}
			ISourceProxy proxy = null;
			if (TryCreateProxy(source, description, out proxy))
			{
				return proxy;
			}
			throw new NotSupportedException("Not found available proxy factory.");
		}
		catch (Exception exception)
		{
			throw new ProxyException(exception, "An exception occurred while creating a proxy for the \"{0}\".", description.ToString());
		}
	}

	protected virtual bool TryCreateProxy(object source, SourceDescription description, out ISourceProxy proxy)
	{
		proxy = null;
		foreach (PriorityFactoryPair factory2 in factories)
		{
			ISourceProxyFactory factory = factory2.factory;
			if (factory == null)
			{
				continue;
			}
			try
			{
				proxy = factory.CreateProxy(source, description);
				if (proxy != null)
				{
					return true;
				}
			}
			catch (MissingMemberException ex)
			{
				throw ex;
			}
			catch (NullReferenceException ex2)
			{
				throw ex2;
			}
			catch (Exception arg)
			{
				Log.Warning("An exception occurred when using the \"{0}\" factory to create a proxy for the \"{1}\";exception:{2}", factory.GetType().Name, description.ToString(), arg);
			}
		}
		proxy = null;
		return false;
	}

	public void Register(ISourceProxyFactory factory, int priority = 100)
	{
		if (factory != null)
		{
			factories.Add(new PriorityFactoryPair(factory, priority));
			factories.Sort((PriorityFactoryPair x, PriorityFactoryPair y) => y.priority.CompareTo(x.priority));
		}
	}

	public void Unregister(ISourceProxyFactory factory)
	{
		if (factory != null)
		{
			factories.RemoveAll((PriorityFactoryPair pair) => pair.factory == factory);
		}
	}
}
