using System;
using System.Collections;
using System.Collections.Specialized;

namespace GameFramework.Runtime;

public class IntItemNodeProxy : ItemNodeProxy<int>
{
	public IntItemNodeProxy(ICollection source, int key, IProxyItemInfo itemInfo)
		: base(source, key, itemInfo)
	{
	}

	protected override void OnCollectionChanged(object sender, NotifyCollectionChangedEventArgs e)
	{
		if (isList)
		{
			switch (e.Action)
			{
			case NotifyCollectionChangedAction.Reset:
				RaiseValueChanged();
				break;
			case NotifyCollectionChangedAction.Remove:
			case NotifyCollectionChangedAction.Replace:
				if (key == e.OldStartingIndex || key == e.NewStartingIndex)
				{
					RaiseValueChanged();
				}
				break;
			case NotifyCollectionChangedAction.Move:
				if (key == e.OldStartingIndex || key == e.NewStartingIndex)
				{
					RaiseValueChanged();
				}
				break;
			case NotifyCollectionChangedAction.Add:
			{
				int num = ((e.NewItems != null) ? (e.NewStartingIndex + e.NewItems.Count) : (e.NewStartingIndex + 1));
				if (key >= e.NewStartingIndex && key < num)
				{
					RaiseValueChanged();
				}
				break;
			}
			}
			return;
		}
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
			throw new MemberAccessException();
		}
		if (itemInfo is IProxyItemInfo<int, TValue> proxyItemInfo)
		{
			return proxyItemInfo.GetValue(source, key);
		}
		return (TValue)itemInfo.GetValue(source, key);
	}

	public override void SetValue<TValue>(TValue value)
	{
		if (itemInfo is IProxyItemInfo<int, TValue> proxyItemInfo)
		{
			proxyItemInfo.SetValue(source, key, value);
		}
		else
		{
			itemInfo.SetValue(source, key, value);
		}
	}
}
