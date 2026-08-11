using System;
using GameFramework.Runtime.Proxy;

namespace GameFramework.Runtime;

public class ObservableNodeProxy : NotifiableSourceProxyBase, IObtainable, IModifiable, INotifiable
{
	protected IObservableProperty property;

	private bool disposedValue = false;

	public override Type Type => property.Type;

	public ObservableNodeProxy(IObservableProperty property)
		: this(null, property)
	{
	}

	public ObservableNodeProxy(object source, IObservableProperty property)
		: base(source)
	{
		this.property = property;
		this.property.ValueChanged += OnValueChanged;
	}

	protected virtual void OnValueChanged(object sender, EventArgs e)
	{
		RaiseValueChanged();
	}

	public virtual object GetValue()
	{
		return property.Value;
	}

	public virtual TValue GetValue<TValue>()
	{
		if (!(property is IObservableProperty<TValue> { Value: var value }))
		{
			return (TValue)property.Value;
		}
		return value;
	}

	public virtual void SetValue(object value)
	{
		property.Value = value;
	}

	public virtual void SetValue<TValue>(TValue value)
	{
		if (property is IObservableProperty<TValue> observableProperty)
		{
			observableProperty.Value = value;
		}
		else
		{
			property.Value = value;
		}
	}

	protected override void Dispose(bool disposing)
	{
		if (!disposedValue)
		{
			if (property != null)
			{
				property.ValueChanged -= OnValueChanged;
			}
			disposedValue = true;
			base.Dispose(disposing);
		}
	}
}
