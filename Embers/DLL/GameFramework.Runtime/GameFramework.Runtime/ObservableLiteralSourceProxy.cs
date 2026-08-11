using System;
using GameFramework.Runtime.Proxy;

namespace GameFramework.Runtime;

public class ObservableLiteralSourceProxy : NotifiableSourceProxyBase, ISourceProxy, IBindingProxy, IDisposable, IObtainable
{
	private IObservableProperty observableProperty;

	private bool disposedValue = false;

	public override Type Type => observableProperty.Type;

	public ObservableLiteralSourceProxy(IObservableProperty source)
		: base(source)
	{
		if (source == null)
		{
			throw new ArgumentNullException("source");
		}
		observableProperty = source;
		observableProperty.ValueChanged += OnValueChanged;
	}

	private void OnValueChanged(object sender, EventArgs e)
	{
		RaiseValueChanged();
	}

	public virtual object GetValue()
	{
		return observableProperty.Value;
	}

	public virtual TValue GetValue<TValue>()
	{
		return (TValue)Convert.ChangeType(observableProperty.Value, typeof(TValue));
	}

	protected override void Dispose(bool disposing)
	{
		if (!disposedValue)
		{
			if (observableProperty != null)
			{
				observableProperty.ValueChanged -= OnValueChanged;
			}
			disposedValue = true;
			base.Dispose(disposing);
		}
	}
}
