using System;

namespace GameFramework.Runtime;

[Serializable]
public abstract class ObservablePropertyBase<T>
{
	private readonly object _lock = new object();

	private EventHandler valueChanged;

	protected T _value;

	public virtual Type Type => typeof(T);

	public event EventHandler ValueChanged
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

	public ObservablePropertyBase()
		: this(default(T))
	{
	}

	public ObservablePropertyBase(T value)
	{
		_value = value;
	}

	protected void RaiseValueChanged()
	{
		valueChanged?.Invoke(this, EventArgs.Empty);
	}

	protected virtual bool Equals(T x, T y)
	{
		if (x != null)
		{
			if (y != null)
			{
				return x.Equals(y);
			}
			return false;
		}
		if (y != null)
		{
			return false;
		}
		return true;
	}
}
