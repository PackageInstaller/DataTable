using System;
using System.Collections.Generic;
using ACT.Event;
using ACT.Game.Data;
using ACT.Model;
using Fundamental;

namespace ACT.UI;

public class PropPickingManager : Singleton<PropPickingManager>
{
	private readonly List<List<ItemAchieveinfo>> _waitAppendPackageList = new List<List<ItemAchieveinfo>>();

	private readonly List<List<ItemAchieveinfo>> _waitLastPackageShowFinishList = new List<List<ItemAchieveinfo>>();

	private bool _hasOpeningPackage;

	public bool HasOpeningPackage => _hasOpeningPackage;

	public bool HasPendingAppendPackage => _waitAppendPackageList.Count > 0;

	public bool HasPendingBoundaryPackage => _waitLastPackageShowFinishList.Count > 0;

	public event Action AppendPackageQueued;

	public override void Init()
	{
		base.Init();
		_hasOpeningPackage = false;
		ClearAllPendingPackages();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_PropPicking, PickItem);
	}

	public override void UnInit()
	{
		base.UnInit();
		_hasOpeningPackage = false;
		ClearAllPendingPackages();
		AppendPackageQueued = null;
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_PropPicking, PickItem);
	}

	private void PickItem(BaseEventContent baseEvent)
	{
		if (baseEvent is PropPickingEvt { itemList: not null } propPickingEvt)
		{
			PropPickingData propPickingData = BuildPickingData(propPickingEvt);
			if (CanCombine())
			{
				QueuePackageForActiveDisplay(propPickingData.info);
			}
			else
			{
				EnqueueHud(propPickingData);
			}
		}
	}

	private bool CanCombine()
	{
		return _hasOpeningPackage;
	}

	private PropPickingData BuildPickingData(PropPickingEvt evt)
	{
		PropPickingData propPickingData = new PropPickingData
		{
			way = evt.way,
			info = new List<ItemAchieveinfo>(evt.itemList.Count)
		};
		foreach (ItemAchieveinfo item in evt.itemList)
		{
			propPickingData.info.Add(item);
		}
		return propPickingData;
	}

	private void EnqueueHud(PropPickingData data)
	{
		OnHudCpEnqueue evt = Singleton<EventManager>.instance.GetEvt<OnHudCpEnqueue>();
		evt.position = UIPosition.LeftBottom;
		evt.type = HudComponentType.NormalPropPick;
		evt.uiData = data;
		evt.timeOutDuration = 15f;
		evt.priorityInQueue = 2;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_HudUIEnqueue, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	private void QueuePackageForActiveDisplay(List<ItemAchieveinfo> packageItems)
	{
		if (PackageRequiresDisplayBoundary(packageItems))
		{
			_waitLastPackageShowFinishList.Add(packageItems);
			return;
		}
		_waitAppendPackageList.Add(packageItems);
		AppendPackageQueued?.Invoke();
	}

	private bool PackageRequiresDisplayBoundary(List<ItemAchieveinfo> packageItems)
	{
		if (packageItems == null || packageItems.Count <= 0)
		{
			return false;
		}
		foreach (ItemAchieveinfo packageItem in packageItems)
		{
			if (IsSpecialDisplayItem(packageItem) || IsNewDisplayItem(packageItem))
			{
				return true;
			}
		}
		return false;
	}

	private bool IsSpecialDisplayItem(ItemAchieveinfo item)
	{
		if (item != null && item.IsSpecial)
		{
			return !IsTreasureItem(item);
		}
		return false;
	}

	private bool IsNewDisplayItem(ItemAchieveinfo item)
	{
		if (item != null && item.isNew && !item.IsSpecial)
		{
			return !IsTreasureItem(item);
		}
		return false;
	}

	private bool IsTreasureItem(ItemAchieveinfo item)
	{
		if (item == null || !Model<TreasureModel>.HasInstance())
		{
			return false;
		}
		List<Treasure> allTreasures = Model<TreasureModel>.Interface.allTreasures;
		if (allTreasures == null || allTreasures.Count == 0)
		{
			return false;
		}
		for (int i = 0; i < allTreasures.Count; i++)
		{
			Treasure treasure = allTreasures[i];
			if (treasure != null && treasure.GetItemId() == item.itemId)
			{
				return true;
			}
		}
		return false;
	}

	public void UpdateComponentOpenState(bool isOpen)
	{
		_hasOpeningPackage = isOpen;
		if (!isOpen)
		{
			ClearAllPendingPackages();
		}
	}

	public bool TryTakeAppendCommonPackages(List<List<ItemAchieveinfo>> targetPackages)
	{
		return TryDrainPackageQueue(_waitAppendPackageList, targetPackages);
	}

	public bool TryTakeBoundaryPackages(List<List<ItemAchieveinfo>> targetPackages)
	{
		return TryDrainPackageQueue(_waitLastPackageShowFinishList, targetPackages);
	}

	private bool TryDrainPackageQueue(List<List<ItemAchieveinfo>> sourcePackages, List<List<ItemAchieveinfo>> targetPackages)
	{
		if (sourcePackages.Count == 0 || targetPackages == null)
		{
			return false;
		}
		for (int i = 0; i < sourcePackages.Count; i++)
		{
			targetPackages.Add(sourcePackages[i]);
		}
		sourcePackages.Clear();
		return true;
	}

	private void ClearAllPendingPackages()
	{
		_waitAppendPackageList.Clear();
		_waitLastPackageShowFinishList.Clear();
	}
}
