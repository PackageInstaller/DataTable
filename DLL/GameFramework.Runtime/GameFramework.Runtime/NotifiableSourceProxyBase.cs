#define ENABLE_LOG
using System;
using GameFramework.Runtime.Proxy;

namespace GameFramework.Runtime;

public abstract class NotifiableSourceProxyBase : SourceProxyBase, INotifiable
{
	protected readonly object _lock = new object();

	protected EventHandler valueChanged;

	public virtual event EventHandler ValueChanged
	{
		add
		{
			lock (_lock)
			{
				valueChanged = (EventHandler)Delegate.Combine(valueChanged, value);
			}
		}
		remove
		{
			lock (_lock)
			{
				valueChanged = (EventHandler)Delegate.Remove(valueChanged, value);
			}
		}
	}

	public NotifiableSourceProxyBase(object source)
		: base(source)
	{
	}

	protected virtual void RaiseValueChanged()
	{
		try
		{
			if (valueChanged != null)
			{
				valueChanged(this, EventArgs.Empty);
			}
		}
		catch (Exception message)
		{
			Log.Warning(message);
		}
	}
}
