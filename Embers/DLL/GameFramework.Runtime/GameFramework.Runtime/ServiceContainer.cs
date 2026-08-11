using System;
using System.Collections.Generic;

namespace GameFramework.Runtime;

public class ServiceContainer : IServiceContainer, IServiceLocator, IServiceRegistry, IDisposable
{
	internal interface IFactory : IDisposable
	{
		object Create();
	}

	internal class GenericFactory<T> : IFactory, IDisposable
	{
		private Func<T> func;

		public GenericFactory(Func<T> func)
		{
			this.func = func;
		}

		public virtual object Create()
		{
			return func();
		}

		public void Dispose()
		{
		}
	}

	internal class SingleInstanceFactory : IFactory, IDisposable
	{
		private object target;

		private bool disposed = false;

		public SingleInstanceFactory(object target)
		{
			this.target = target;
		}

		public virtual object Create()
		{
			return target;
		}

		protected virtual void Dispose(bool disposing)
		{
			if (disposed)
			{
				return;
			}
			if (disposing)
			{
				if (target is IDisposable disposable)
				{
					disposable.Dispose();
				}
				target = null;
			}
			disposed = true;
		}

		~SingleInstanceFactory()
		{
			Dispose(disposing: false);
		}

		public void Dispose()
		{
			Dispose(disposing: true);
			GC.SuppressFinalize(this);
		}
	}

	private Dictionary<string, IFactory> services = new Dictionary<string, IFactory>();

	private bool disposed = false;

	public virtual object Resolve(Type type)
	{
		return Resolve<object>(GetServiceName(type));
	}

	public virtual T Resolve<T>()
	{
		return Resolve<T>(GetServiceName(typeof(T)));
	}

	public virtual object Resolve(string name)
	{
		return Resolve<object>(name);
	}

	public virtual T Resolve<T>(string name)
	{
		if (services.TryGetValue(name, out var value))
		{
			return (T)value.Create();
		}
		return default(T);
	}

	public virtual void Register<T>(Func<T> factory)
	{
		Register(GetServiceName(typeof(T)), factory);
	}

	public virtual void Register(Type type, object target)
	{
		this.Register<object>(GetServiceName(type), target);
	}

	public virtual void Register(string name, object target)
	{
		this.Register<object>(name, target);
	}

	public virtual void Register<T>(T target)
	{
		Register(GetServiceName(typeof(T)), target);
	}

	public virtual void Register<T>(string name, Func<T> factory)
	{
		if (services.ContainsKey(name))
		{
			throw new DuplicateRegisterServiceException($"Duplicate key {name}");
		}
		services.Add(name, new GenericFactory<T>(factory));
	}

	public virtual void Register<T>(string name, T target)
	{
		if (services.ContainsKey(name))
		{
			throw new DuplicateRegisterServiceException($"Duplicate key {name}");
		}
		services.Add(name, new SingleInstanceFactory(target));
	}

	public virtual void Unregister(Type type)
	{
		Unregister(GetServiceName(type));
	}

	public virtual void Unregister<T>()
	{
		Unregister(GetServiceName(typeof(T)));
	}

	public virtual void Unregister(string name)
	{
		if (services.TryGetValue(name, out var value))
		{
			value.Dispose();
		}
		services.Remove(name);
	}

	protected virtual string GetServiceName(Type type)
	{
		if (type.IsGenericType)
		{
			return type.ToString();
		}
		return type.Name;
	}

	protected virtual void Dispose(bool disposing)
	{
		if (disposed)
		{
			return;
		}
		if (disposing)
		{
			foreach (KeyValuePair<string, IFactory> service in services)
			{
				service.Value.Dispose();
			}
			services.Clear();
		}
		disposed = true;
	}

	~ServiceContainer()
	{
		Dispose(disposing: false);
	}

	public void Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}
}
