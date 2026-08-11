using System;
using System.Collections;
using System.Collections.Specialized;
using System.Text.RegularExpressions;
using GameFramework.Runtime.Proxy;

namespace GameFramework.Runtime;

public abstract class ItemNodeProxy<T> : NotifiableSourceProxyBase, IObtainable, IModifiable, INotifiable
{
	protected T key;

	protected IProxyItemInfo itemInfo;

	protected bool isList;

	protected Regex regex;

	private bool disposedValue = false;

	public override Type Type => itemInfo.ValueType;

	public override TypeCode TypeCode => itemInfo.ValueTypeCode;

	public ItemNodeProxy(ICollection source, T key, IProxyItemInfo itemInfo)
		: base(source)
	{
		this.key = key;
		isList = source is IList;
		this.itemInfo = itemInfo;
		if (base.source != null && base.source is INotifyCollectionChanged)
		{
			INotifyCollectionChanged notifyCollectionChanged = base.source as INotifyCollectionChanged;
			notifyCollectionChanged.CollectionChanged += OnCollectionChanged;
		}
		if (!isList)
		{
			T val = this.key;
			regex = new Regex("\\[" + val?.ToString() + ",", RegexOptions.IgnorePatternWhitespace);
		}
	}

	protected abstract void OnCollectionChanged(object sender, NotifyCollectionChangedEventArgs e);

	public virtual object GetValue()
	{
		return itemInfo.GetValue(source, key);
	}

	public abstract TValue GetValue<TValue>();

	public virtual void SetValue(object value)
	{
		itemInfo.SetValue(source, key, value);
	}

	public abstract void SetValue<TValue>(TValue value);

	protected override void Dispose(bool disposing)
	{
		if (!disposedValue)
		{
			if (source != null && source is INotifyCollectionChanged)
			{
				INotifyCollectionChanged notifyCollectionChanged = source as INotifyCollectionChanged;
				notifyCollectionChanged.CollectionChanged -= OnCollectionChanged;
			}
			disposedValue = true;
			base.Dispose(disposing);
		}
	}
}
