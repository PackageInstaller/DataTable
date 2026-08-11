#define ENABLE_LOG
using System;
using System.Collections.Generic;

namespace GameFramework.Runtime;

public class BindingContext : IBindingContext, IDisposable
{
	private readonly string DEFAULT_KEY = "_KEY_";

	private readonly Dictionary<object, List<IBinding>> bindings = new Dictionary<object, List<IBinding>>();

	private IBinder binder;

	private object owner;

	private object dataContext;

	private readonly object _lock = new object();

	private EventHandler dataContextChanged;

	private bool disposed = false;

	protected IBinder Binder => binder;

	public object Owner => owner;

	public object DataContext
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
				RaiseDataContextChanged();
			}
		}
	}

	public event EventHandler DataContextChanged
	{
		add
		{
			lock (_lock)
			{
				dataContextChanged = (EventHandler)Delegate.Combine(dataContextChanged, value);
			}
		}
		remove
		{
			lock (_lock)
			{
				dataContextChanged = (EventHandler)Delegate.Remove(dataContextChanged, value);
			}
		}
	}

	public BindingContext(IBinder binder)
		: this((object)null, binder, (object)null)
	{
	}

	public BindingContext(object owner, IBinder binder)
		: this(owner, binder, (object)null)
	{
	}

	public BindingContext(object owner, IBinder binder, object dataContext)
	{
		this.owner = owner;
		this.binder = binder;
		DataContext = dataContext;
	}

	public BindingContext(object owner, IBinder binder, IDictionary<object, IEnumerable<BindingDescription>> firstBindings)
		: this(owner, binder, null, firstBindings)
	{
	}

	public BindingContext(object owner, IBinder binder, object dataContext, IDictionary<object, IEnumerable<BindingDescription>> firstBindings)
	{
		this.owner = owner;
		this.binder = binder;
		DataContext = dataContext;
		if (firstBindings == null || firstBindings.Count <= 0)
		{
			return;
		}
		foreach (KeyValuePair<object, IEnumerable<BindingDescription>> firstBinding in firstBindings)
		{
			Add(firstBinding.Key, firstBinding.Value);
		}
	}

	protected void RaiseDataContextChanged()
	{
		try
		{
			dataContextChanged?.Invoke(this, EventArgs.Empty);
		}
		catch (Exception message)
		{
			Log.Warning(message);
		}
	}

	protected virtual void OnDataContextChanged()
	{
		try
		{
			foreach (KeyValuePair<object, List<IBinding>> binding in bindings)
			{
				foreach (IBinding item in binding.Value)
				{
					item.DataContext = DataContext;
				}
			}
		}
		catch (Exception message)
		{
			Log.Warning(message);
		}
	}

	protected List<IBinding> GetOrCreateList(object key)
	{
		if (key == null)
		{
			key = DEFAULT_KEY;
		}
		if (bindings.TryGetValue(key, out var value))
		{
			return value;
		}
		value = new List<IBinding>();
		bindings.Add(key, value);
		return value;
	}

	public virtual void Add(IBinding binding, object key = null)
	{
		if (binding != null)
		{
			List<IBinding> orCreateList = GetOrCreateList(key);
			binding.BindingContext = this;
			orCreateList.Add(binding);
		}
	}

	public virtual void Add(IEnumerable<IBinding> bindings, object key = null)
	{
		if (bindings == null)
		{
			return;
		}
		List<IBinding> orCreateList = GetOrCreateList(key);
		foreach (IBinding binding in bindings)
		{
			binding.BindingContext = this;
			orCreateList.Add(binding);
		}
	}

	public virtual void Add(object target, BindingDescription description, object key = null)
	{
		IBinding binding = Binder.Bind(this, DataContext, target, description);
		Add(binding, key);
	}

	public virtual void Add(object target, IEnumerable<BindingDescription> descriptions, object key = null)
	{
		IEnumerable<IBinding> enumerable = Binder.Bind(this, DataContext, target, descriptions);
		Add(enumerable, key);
	}

	public virtual void Clear(object key)
	{
		if (key == null)
		{
			return;
		}
		List<IBinding> list = bindings[key];
		if (list != null && list.Count > 0)
		{
			foreach (IBinding item in list)
			{
				item.Dispose();
			}
		}
		bindings.Remove(key);
	}

	public virtual void Clear()
	{
		foreach (KeyValuePair<object, List<IBinding>> binding in bindings)
		{
			foreach (IBinding item in binding.Value)
			{
				item.Dispose();
			}
		}
		bindings.Clear();
	}

	protected virtual void Dispose(bool disposing)
	{
		if (!disposed)
		{
			if (disposing)
			{
				Clear();
				owner = null;
				binder = null;
			}
			disposed = true;
		}
	}

	~BindingContext()
	{
		Dispose(disposing: false);
	}

	public void Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}
}
