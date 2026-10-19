using System;
using System.Collections.Generic;
using ACT.Event;
using ACT.Game;
using Fundamental;
using Google.Protobuf.Collections;

namespace ACT.Model;

public class ObtainedItemModel : Model<ObtainedItemModel>
{
	private readonly HashSet<int> _obtainedItemIds = new HashSet<int>();

	public event Action<int> OnObtainedItemAdded;

	protected override void Init()
	{
		_obtainedItemIds.Clear();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.ItemAdd, OnItemAdd);
		SyncFromPlayerGotItems();
	}

	protected override void UnInit()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.ItemAdd, OnItemAdd);
		_obtainedItemIds.Clear();
	}

	public void SyncFromPlayerGotItems()
	{
		MapField<int, bool> mapField = G.localPlayer?.GotItems;
		if (mapField == null)
		{
			return;
		}
		foreach (KeyValuePair<int, bool> item in mapField)
		{
			if (item.Key > 0)
			{
				_obtainedItemIds.Add(item.Key);
			}
		}
	}

	public bool HasObtained(int itemId)
	{
		if (itemId > 0)
		{
			return _obtainedItemIds.Contains(itemId);
		}
		return false;
	}

	private void OnItemAdd(BaseEventContent baseEventContent)
	{
		if (baseEventContent is ItemUnifierProxyEvt { data: not null } itemUnifierProxyEvt)
		{
			int id = itemUnifierProxyEvt.data.Id;
			if (id > 0 && _obtainedItemIds.Add(id))
			{
				OnObtainedItemAdded?.Invoke(id);
			}
		}
	}
}
