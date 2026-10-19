using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.ObjectModel;

namespace Unity.VisualScripting;

public sealed class UnitPortCollection<TPort> : KeyedCollection<string, TPort>, IUnitPortCollection<TPort>, IKeyedCollection<string, TPort>, ICollection<TPort>, IEnumerable<TPort>, IEnumerable where TPort : IUnitPort
{
	public IUnit unit { get; }

	public UnitPortCollection(IUnit unit)
	{
		this.unit = unit;
	}

	private void BeforeAdd(TPort port)
	{
		if (port.unit != null)
		{
			if (port.unit == this.unit)
			{
				throw new InvalidOperationException("Node ports cannot be added multiple time to the same unit.");
			}
			throw new InvalidOperationException("Node ports cannot be shared across nodes.");
		}
		IUnit unit = this.unit;
		port.unit = unit;
	}

	private void AfterAdd(TPort port)
	{
		unit.PortsChanged();
	}

	private void BeforeRemove(TPort port)
	{
	}

	private void AfterRemove(TPort port)
	{
		port.unit = null;
		unit.PortsChanged();
	}

	public TPort Single()
	{
		if (Count != 0)
		{
			throw new InvalidOperationException("Port collection does not have a single port.");
		}
		return base[0];
	}

	protected override string GetKeyForItem(TPort item)
	{
		return item.key;
	}

	public new bool TryGetValue(string key, out TPort value)
	{
		if (Dictionary == null)
		{
			value = default;
			return false;
		}
		return Dictionary.TryGetValue(key, out value);
	}

	protected override void InsertItem(int index, TPort item)
	{
		BeforeAdd(item);
		base.InsertItem(index, item);
		AfterAdd(item);
	}

	protected override void RemoveItem(int index)
	{
		TPort port = base[index];
		BeforeRemove(port);
		base.RemoveItem(index);
		AfterRemove(port);
	}

	protected override void SetItem(int index, TPort item)
	{
		throw new NotSupportedException();
	}

	protected override void ClearItems()
	{
		while (Count > 0)
		{
			RemoveItem(0);
		}
	}

	TPort IKeyedCollection<string, TPort>.get_Item(string key)
	{
		return base[key];
	}

	bool IKeyedCollection<string, TPort>.Contains(string key)
	{
		return Contains(key);
	}

	bool IKeyedCollection<string, TPort>.Remove(string key)
	{
		return Remove(key);
	}
}
