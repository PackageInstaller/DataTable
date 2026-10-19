using System.Collections.Generic;
using System.Linq;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI;
using ACT.World.StateObject;
using Fundamental;
using Google.Protobuf.Collections;
using UnityEngine.Pool;

namespace ACT.Utility;

public class PropPickingUtility
{
	private static List<int> _canNotShowInPropPickViewItems = new List<int> { 93 };

	private static bool IsRareItem(int itemId)
	{
		return RuntimeConfigs.data.itemDatas[itemId].isNeedRareTip;
	}

	private static bool ShowInPropPickingView(int itemId)
	{
		if (_canNotShowInPropPickViewItems.Contains(itemId))
		{
			return false;
		}
		return true;
	}

	public static void DispatchPropPickingEvt(List<Item> info, PropPickingWay way, StateObjectType stateObjectType = StateObjectType.None)
	{
		List<ItemAchieveinfo> list = CollectionPool<List<ItemAchieveinfo>, ItemAchieveinfo>.Get();
		List<ItemAchieveinfo> list2 = CollectionPool<List<ItemAchieveinfo>, ItemAchieveinfo>.Get();
		info.Sort(SortUtility.DropItemSort);
		foreach (Item item2 in info)
		{
			int id = item2.Id;
			int count = item2.Count;
			if (ShowInPropPickingView(id))
			{
				ItemAchieveinfo item = new ItemAchieveinfo
				{
					itemId = id,
					itemNum = count,
					isNew = !G.localPlayer.GotItems.ContainsKey(id)
				};
				list.Add(item);
				if (way != PropPickingWay.Normal)
				{
					list2.Add(item);
				}
				else if (IsRareItem(id))
				{
					list2.Add(item);
				}
				G.localPlayer.GotItems.TryAdd(id, value: true);
			}
		}
		switch (stateObjectType)
		{
		case StateObjectType.SmallSupplyBox:
		case StateObjectType.PrecisionCore:
		case StateObjectType.MediumSupplyBox:
		case StateObjectType.LargeSupplyBox:
		case StateObjectType.ErosionCrystal:
			Singleton<InteractiveDialogueManager>.instance.DispatchTriggerInteractiveDialogue(1002);
			break;
		}
		RareItemHudEnqueue(list2, way);
		NormalPickItemHudEnqueue(list, way);
		CollectionPool<List<ItemAchieveinfo>, ItemAchieveinfo>.Release(list);
		CollectionPool<List<ItemAchieveinfo>, ItemAchieveinfo>.Release(list2);
	}

	private static void NormalPickItemHudEnqueue(List<ItemAchieveinfo> items, PropPickingWay way)
	{
		if (items != null && items.Count > 0)
		{
			PropPickingEvt evt = Singleton<EventManager>.instance.GetEvt<PropPickingEvt>();
			evt.way = way;
			evt.itemList = items.ToList();
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_PropPicking, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}

	private static void RareItemHudEnqueue(List<ItemAchieveinfo> items, PropPickingWay way)
	{
		if (items != null && items.Count > 0)
		{
			OnHudCpEnqueue evt = Singleton<EventManager>.instance.GetEvt<OnHudCpEnqueue>();
			evt.position = UIPosition.Center;
			evt.priorityInQueue = 2;
			evt.type = HudComponentType.MiddlePropPick;
			MonoMiddlePropPickingData monoMiddlePropPickingData = new MonoMiddlePropPickingData
			{
				info = items.ToList()
			};
			if (way == PropPickingWay.Mission)
			{
				monoMiddlePropPickingData.Content = 690;
			}
			evt.uiData = monoMiddlePropPickingData;
			evt.timeOutDuration = 15f;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_HudUIEnqueue, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}

	public static void OnInteractRewards(RepeatedField<UniversalItem> universalItems)
	{
		if (universalItems != null && universalItems.Count > 0)
		{
			List<Item> list = CollectionPool<List<Item>, Item>.Get();
			for (int i = 0; i < universalItems.Count; i++)
			{
				Item item = new Item
				{
					Id = universalItems[i].Index,
					Count = universalItems[i].Count,
					IsNew = universalItems[i].IsNew
				};
				list.Add(item);
			}
			DispatchPropPickingEvt(list, PropPickingWay.Normal);
			CollectionPool<List<Item>, Item>.Release(list);
		}
	}
}
