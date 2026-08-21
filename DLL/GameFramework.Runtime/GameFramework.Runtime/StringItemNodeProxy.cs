using System;
using System.Collections;
using System.Collections.Specialized;

namespace GameFramework.Runtime;

public class StringItemNodeProxy : ItemNodeProxy<string>
{
	public StringItemNodeProxy(ICollection source, string key, IProxyItemInfo itemInfo)
		: base(source, key, itemInfo)
	{
	}

	protected override void OnCollectionChanged(object sender, NotifyCollectionChangedEventArgs e)
	{
		if (e.Action == NotifyCollectionChangedAction.Reset)
		{
			RaiseValueChanged();
			return;
		}
		if (e.NewItems != null && e.NewItems.Count > 0)
		{
			foreach (object newItem in e.NewItems)
			{
				if (regex.IsMatch(newItem.ToString()))
				{
					RaiseValueChanged();
					return;
				}
			}
		}
		if (e.OldItems == null || e.OldItems.Count <= 0)
		{
			return;
		}
		foreach (object oldItem in e.OldItems)
		{
			if (regex.IsMatch(oldItem.ToString()))
			{
				RaiseValueChanged();
				break;
			}
		}
	}

	public override TValue GetValue<TValue>()
	{
		if (!typeof(TValue).IsAssignableFrom(itemInfo.ValueType))
		{
			throw new InvalidCastException();
		}
		if (itemInfo is IProxyItemInfo<string, TValue> proxyItemInfo)
		{
			return proxyItemInfo.GetValue(source, key);
		}
		return (TValue)itemInfo.GetValue(source, key);
	}

	public override void SetValue<TValue>(TValue value)
	{
		if (itemInfo is IProxyItemInfo<string, TValue> proxyItemInfo)
		{
			proxyItemInfo.SetValue(source, key, value);
		}
		else
		{
			itemInfo.SetValue(source, key, value);
		}
	}
}
