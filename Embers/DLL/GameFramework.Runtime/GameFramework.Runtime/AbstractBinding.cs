using System;
using UnityEngine;
using UnityEngine.EventSystems;

namespace GameFramework.Runtime;

public abstract class AbstractBinding : IBinding, IDisposable
{
	private IBindingContext bindingContext;

	private WeakReference target;

	private object dataContext;

	public virtual IBindingContext BindingContext
	{
		get
		{
			return bindingContext;
		}
		set
		{
			bindingContext = value;
		}
	}

	public virtual object Target
	{
		get
		{
			object obj = ((target != null) ? target.Target : null);
			return IsAlive(obj) ? obj : null;
		}
	}

	public virtual object DataContext
	{
		get
		{
			return dataContext;
		}
		set
		{
			if (dataContext != value)
			{
				dataContext = value;
				OnDataContextChanged();
			}
		}
	}

	public AbstractBinding(IBindingContext bindingContext, object dataContext, object target)
	{
		this.bindingContext = bindingContext;
		this.target = new WeakReference(target, trackResurrection: false);
		this.dataContext = dataContext;
	}

	private bool IsAlive(object target)
	{
		try
		{
			if (target is UIBehaviour)
			{
				if (((UIBehaviour)target).IsDestroyed())
				{
					return false;
				}
				return true;
			}
			if (target is UnityEngine.Object)
			{
				string name = ((UnityEngine.Object)target).name;
				return true;
			}
			return target != null;
		}
		catch (Exception)
		{
			return false;
		}
	}

	protected abstract void OnDataContextChanged();

	protected virtual void Dispose(bool disposing)
	{
		bindingContext = null;
		dataContext = null;
		target = null;
	}

	~AbstractBinding()
	{
		Dispose(disposing: false);
	}

	public void Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}
}
