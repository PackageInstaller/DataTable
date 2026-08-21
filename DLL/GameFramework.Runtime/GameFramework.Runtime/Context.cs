using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace GameFramework.Runtime;

public class Context : IDisposable
{
	private static ApplicationContext context;

	private static Dictionary<string, Context> contexts;

	private bool innerContainer = false;

	private Context contextBase;

	private IServiceContainer container;

	private Dictionary<string, object> attributes;

	private bool disposed = false;

	[RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.BeforeSceneLoad)]
	private static void OnInitialize()
	{
		try
		{
			if (context != null)
			{
				context.Dispose();
			}
			if (contexts != null)
			{
				foreach (Context value in contexts.Values)
				{
					value.Dispose();
				}
				contexts.Clear();
			}
		}
		catch (Exception)
		{
		}
		context = new ApplicationContext();
		contexts = new Dictionary<string, Context>();
	}

	public static ApplicationContext GetApplicationContext()
	{
		return context;
	}

	public static void SetApplicationContext(ApplicationContext context)
	{
		Context.context = context;
	}

	public static Context GetContext(string key)
	{
		Context value = null;
		contexts.TryGetValue(key, out value);
		return value;
	}

	public static T GetContext<T>(string key) where T : Context
	{
		return (T)GetContext(key);
	}

	public static void AddContext(string key, Context context)
	{
		contexts.Add(key, context);
	}

	public static void RemoveContext(string key)
	{
		contexts.Remove(key);
	}

	public Context()
		: this(null, null)
	{
	}

	public Context(IServiceContainer container, Context contextBase)
	{
		attributes = new Dictionary<string, object>();
		this.contextBase = contextBase;
		this.container = container;
		if (this.container == null)
		{
			innerContainer = true;
			this.container = new ServiceContainer();
		}
	}

	public virtual bool Contains(string name, bool cascade = true)
	{
		if (attributes.ContainsKey(name))
		{
			return true;
		}
		if (cascade && contextBase != null)
		{
			return contextBase.Contains(name, cascade);
		}
		return false;
	}

	public virtual object Get(string name, bool cascade = true)
	{
		return Get<object>(name, cascade);
	}

	public virtual T Get<T>(string name, bool cascade = true)
	{
		if (attributes.TryGetValue(name, out var value))
		{
			return (T)value;
		}
		if (cascade && contextBase != null)
		{
			return contextBase.Get<T>(name, cascade);
		}
		return default(T);
	}

	public virtual void Set(string name, object value)
	{
		this.Set<object>(name, value);
	}

	public virtual void Set<T>(string name, T value)
	{
		attributes[name] = value;
	}

	public virtual object Remove(string name)
	{
		return Remove<object>(name);
	}

	public virtual T Remove<T>(string name)
	{
		if (!attributes.ContainsKey(name))
		{
			return default(T);
		}
		object obj = attributes[name];
		attributes.Remove(name);
		return (T)obj;
	}

	public virtual IEnumerator GetEnumerator()
	{
		return attributes.GetEnumerator();
	}

	public virtual IServiceContainer GetContainer()
	{
		return container;
	}

	public virtual object GetService(Type type)
	{
		object obj = container.Resolve(type);
		if (obj != null)
		{
			return obj;
		}
		if (contextBase != null)
		{
			return contextBase.GetService(type);
		}
		return null;
	}

	public virtual object GetService(string name)
	{
		object obj = container.Resolve(name);
		if (obj != null)
		{
			return obj;
		}
		if (contextBase != null)
		{
			return contextBase.GetService(name);
		}
		return null;
	}

	public virtual T GetService<T>()
	{
		T val = container.Resolve<T>();
		if (val != null)
		{
			return val;
		}
		if (contextBase != null)
		{
			return contextBase.GetService<T>();
		}
		return default(T);
	}

	public virtual T GetService<T>(string name)
	{
		T val = container.Resolve<T>(name);
		if (val != null)
		{
			return val;
		}
		if (contextBase != null)
		{
			return contextBase.GetService<T>(name);
		}
		return default(T);
	}

	protected virtual void Dispose(bool disposing)
	{
		if (!disposed)
		{
			if (disposing && innerContainer && container != null && container is IDisposable disposable)
			{
				disposable.Dispose();
			}
			disposed = true;
		}
	}

	~Context()
	{
		Dispose(disposing: false);
	}

	public void Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}
}
