using System;
using System.Collections.Generic;
using GameFramework.Runtime.Proxy;

namespace GameFramework.Runtime;

public class ExpressionSourceProxy : NotifiableSourceProxyBase, IExpressionSourceProxy, ISourceProxy, IBindingProxy, IDisposable, IObtainable, INotifiable
{
	private bool disposed = false;

	private readonly Type type;

	private readonly Func<object[], object> func;

	private readonly List<ISourceProxy> inners = new List<ISourceProxy>();

	private readonly object[] args;

	public override Type Type => type;

	public ExpressionSourceProxy(object source, Func<object[], object> func, Type type, List<ISourceProxy> inners)
		: base(source)
	{
		this.type = type;
		this.func = func;
		this.inners = inners;
		if (source != null)
		{
			args = new object[1] { source };
		}
		else
		{
			args = null;
		}
		if (this.inners == null || this.inners.Count <= 0)
		{
			return;
		}
		foreach (ISourceProxy inner in this.inners)
		{
			if (inner is INotifiable)
			{
				((INotifiable)inner).ValueChanged += OnValueChanged;
			}
		}
	}

	public virtual object GetValue()
	{
		return func(args);
	}

	public virtual TValue GetValue<TValue>()
	{
		return (TValue)GetValue();
	}

	private void OnValueChanged(object sender, EventArgs e)
	{
		RaiseValueChanged();
	}

	protected override void Dispose(bool disposing)
	{
		if (disposed)
		{
			return;
		}
		if (disposing && inners != null && inners.Count > 0)
		{
			foreach (ISourceProxy inner in inners)
			{
				if (inner is INotifiable)
				{
					((INotifiable)inner).ValueChanged -= OnValueChanged;
				}
				inner.Dispose();
			}
			inners.Clear();
		}
		disposed = true;
		base.Dispose(disposing);
	}
}
public class ExpressionSourceProxy<T, TResult> : NotifiableSourceProxyBase, IExpressionSourceProxy, ISourceProxy, IBindingProxy, IDisposable, IObtainable, INotifiable
{
	private bool disposed = false;

	private readonly Func<T, TResult> func;

	private readonly List<ISourceProxy> inners;

	public override Type Type => typeof(TResult);

	public ExpressionSourceProxy(T source, Func<T, TResult> func, List<ISourceProxy> inners)
		: base(source)
	{
		this.func = func;
		this.inners = inners;
		if (this.inners == null || this.inners.Count <= 0)
		{
			return;
		}
		foreach (ISourceProxy inner in this.inners)
		{
			if (inner is INotifiable)
			{
				((INotifiable)inner).ValueChanged += OnValueChanged;
			}
		}
	}

	public virtual object GetValue()
	{
		return func((T)source);
	}

	public virtual TValue GetValue<TValue>()
	{
		return (TValue)GetValue();
	}

	private void OnValueChanged(object sender, EventArgs e)
	{
		RaiseValueChanged();
	}

	protected override void Dispose(bool disposing)
	{
		if (disposed)
		{
			return;
		}
		if (disposing && inners != null && inners.Count > 0)
		{
			foreach (ISourceProxy inner in inners)
			{
				if (inner is INotifiable)
				{
					((INotifiable)inner).ValueChanged -= OnValueChanged;
				}
				inner.Dispose();
			}
			inners.Clear();
		}
		disposed = true;
		base.Dispose(disposing);
	}
}
public class ExpressionSourceProxy<TResult> : NotifiableSourceProxyBase, IExpressionSourceProxy, ISourceProxy, IBindingProxy, IDisposable, IObtainable, INotifiable
{
	private bool disposed = false;

	private readonly Func<TResult> func;

	private readonly List<ISourceProxy> inners;

	public override Type Type => typeof(TResult);

	public ExpressionSourceProxy(Func<TResult> func, List<ISourceProxy> inners)
		: base(null)
	{
		this.func = func;
		this.inners = inners;
		if (this.inners == null || this.inners.Count <= 0)
		{
			return;
		}
		foreach (ISourceProxy inner in this.inners)
		{
			if (inner is INotifiable)
			{
				((INotifiable)inner).ValueChanged += OnValueChanged;
			}
		}
	}

	public virtual object GetValue()
	{
		return func();
	}

	public virtual TValue GetValue<TValue>()
	{
		return (TValue)GetValue();
	}

	private void OnValueChanged(object sender, EventArgs e)
	{
		RaiseValueChanged();
	}

	protected override void Dispose(bool disposing)
	{
		if (disposed)
		{
			return;
		}
		if (disposing && inners != null && inners.Count > 0)
		{
			foreach (ISourceProxy inner in inners)
			{
				if (inner is INotifiable)
				{
					((INotifiable)inner).ValueChanged -= OnValueChanged;
				}
				inner.Dispose();
			}
			inners.Clear();
		}
		disposed = true;
		base.Dispose(disposing);
	}
}
