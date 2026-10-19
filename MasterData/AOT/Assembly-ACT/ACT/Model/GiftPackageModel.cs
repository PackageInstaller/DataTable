using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.UI;
using ACT.Utility;
using Fundamental;
using Google.Protobuf.Collections;
using Pb;
using UnityEngine;

namespace ACT.Model;

public class GiftPackageModel : Model<GiftPackageModel>
{
	private List<Item> _itemsFromImmediatelyOpen;

	private List<GiftPackage> _packageGifts;

	private bool _rewardsNotFromAutoOpen;

	private BagChestRewardSelectData _selfSelectChestRewardSelectData;

	protected override void Init()
	{
		_itemsFromImmediatelyOpen = ListPool<Item>.Get();
		_packageGifts = ListPool<GiftPackage>.Get();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.PackageGiftGetItems, OnGetPackageGiftItems);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.ItemAdd, OnGetPackageGift);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.ItemMinus, OnMinusPackageGift);
	}

	protected override void UnInit()
	{
		ListPool<Item>.Release(_itemsFromImmediatelyOpen);
		ListPool<GiftPackage>.Release(_packageGifts);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.ItemAdd, OnGetPackageGift);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.ItemMinus, OnMinusPackageGift);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.PackageGiftGetItems, OnGetPackageGiftItems);
	}

	public void RefreshSelfSelectGiftPackageUseData(BagChestRewardSelectCountNtf newData)
	{
		_selfSelectChestRewardSelectData = newData.Data;
	}

	private void OnGetPackageGift(BaseEventContent obj)
	{
		ItemUnifierProxyEvt e = obj as ItemUnifierProxyEvt;
		if (e != null && e.data.ItemData != null && e.data.ItemData.type == 35 && _packageGifts.All((GiftPackage i) => i.GetId() != e.data.Id))
		{
			if (RuntimeConfigs.data.bagChests.TryGetValue(e.data.Id, out var value))
			{
				GiftPackage item = new GiftPackage(e.data.Uid, (GiftPackageType)value.type, e.data.ItemData);
				_packageGifts.Add(item);
				G.localPlayer.Inventory.GiftPackages.Add(item);
			}
			else if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"宝箱表里没有 id :{e.data.Id},检查表或者后端数据");
			}
		}
	}

	private void OnMinusPackageGift(BaseEventContent obj)
	{
		ItemUnifierProxyEvt e = obj as ItemUnifierProxyEvt;
		if (e == null || e.data.ItemData == null || e.data.ItemData.type != 35)
		{
			return;
		}
		GiftPackage giftPackage = _packageGifts.FirstOrDefault((GiftPackage i) => i.GetId() == e.data.Id);
		if (giftPackage == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"id：{e.data.Id}的宝箱和_packageGifts里的数据对不上，获得宝箱填充_packageGifts的时候有问题，检查一下");
			}
		}
		else if (giftPackage.GetCount() == 0)
		{
			_packageGifts.Remove(giftPackage);
			G.localPlayer.Inventory.GiftPackages.Remove(giftPackage);
		}
	}

	private void OnGetPackageGiftItems(BaseEventContent obj)
	{
		if (_rewardsNotFromAutoOpen || !(obj is GetPackageGiftItems { getItems: var getItems } getPackageGiftItems))
		{
			return;
		}
		if (getItems == null || getItems.Count <= 0)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("立即开宝箱获得的道具为空，检查itemNtf");
			}
			return;
		}
		_itemsFromImmediatelyOpen.Clear();
		_itemsFromImmediatelyOpen.AddRange(getPackageGiftItems.getItems);
		GameUtility.OpenPopReward(GameUtility.ToUniversalItems(_itemsFromImmediatelyOpen), notSort: false, () =>
		{
			_itemsFromImmediatelyOpen.Clear();
		});
	}

	public void SendRewardRandomOrInherentGiftPackage(GiftPackage package, int count, Action callback = null)
	{
		if (package == null || G.localPlayer.Inventory.GetItemCount(package.giftItemTableData.id) <= 0)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"宝箱不存在或者{package.giftItemTableData.id}的宝箱数量为0");
			}
			return;
		}
		GiftPackageType type = package.type;
		if (type != GiftPackageType.Random && type != GiftPackageType.Inherent)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"宝箱{package.giftItemTableData.id}不是{package.type}类型宝箱");
			}
			return;
		}
		if (!_rewardsNotFromAutoOpen)
		{
			_rewardsNotFromAutoOpen = true;
		}
		G.service.UseItem(package.GetId(), package.GetUid(), count, 0, (bool b, RepeatedField<Item> _, RepeatedField<UniversalItem> items) =>
		{
			if (b && items != null && items.Count > 0)
			{
				callback?.Invoke();
				OnReward(items.ToList());
			}
			else if (_rewardsNotFromAutoOpen)
			{
				_rewardsNotFromAutoOpen = false;
			}
		});
	}

	public void SendRewardSelfSelectGiftPackage(GiftPackage package, int count, int selectItemId, Action callback = null)
	{
		if (package == null || G.localPlayer.Inventory.GetItemCount(package.giftItemTableData.id) <= 0)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"宝箱不存在或者{package.giftItemTableData.id}的宝箱数量为0");
			}
			return;
		}
		if (package.type != GiftPackageType.SelfSelect)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"宝箱{package.giftItemTableData.id}不是自选类型宝箱");
			}
			return;
		}
		if (!_rewardsNotFromAutoOpen)
		{
			_rewardsNotFromAutoOpen = true;
		}
		G.service.UseItem(package.GetId(), package.GetUid(), count, selectItemId, (bool b, RepeatedField<Item> _, RepeatedField<UniversalItem> items) =>
		{
			if (b && items != null && items.Count > 0)
			{
				callback?.Invoke();
				OnReward(items.ToList());
			}
			else if (_rewardsNotFromAutoOpen)
			{
				_rewardsNotFromAutoOpen = false;
			}
		});
	}

	private void OnReward(List<UniversalItem> items)
	{
		GameUtility.OpenPopReward(items, notSort: false, () =>
		{
			if (_rewardsNotFromAutoOpen)
			{
				_rewardsNotFromAutoOpen = false;
			}
		});
	}

	private void CharacterRewardRefreshDisplay(List<UniversalItem> items)
	{
		UniversalItem universalItem = items[0].Clone();
		for (int i = 1; i < items.Count; i++)
		{
			UniversalItem universalItem2 = items[i];
			if (universalItem2.Uid != universalItem.Uid)
			{
				continue;
			}
			for (int j = 0; j < universalItem2.ExtraItems.Count; j++)
			{
				UniversalItem universalItem3 = universalItem2.ExtraItems[j];
				bool flag = false;
				for (int k = 0; k < universalItem.ExtraItems.Count; k++)
				{
					if (universalItem2.ExtraItems[j].Index == universalItem3.Index)
					{
						universalItem.ExtraItems[k].Count += universalItem3.Count;
						flag = true;
						break;
					}
				}
				if (!flag)
				{
					universalItem.ExtraItems.Add(universalItem3.Clone());
				}
			}
		}
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_COMMONACQUIRECHARACTERSHOW, new CommonAcquireCharacterShowData
		{
			universalItems = new List<UniversalItem> { universalItem }
		});
	}

	public int GetCanChooseCountInSelfSelectBagChest(GiftPackage package, Item selectItem)
	{
		if (selectItem == null || package == null || package.type != GiftPackageType.SelfSelect)
		{
			return 0;
		}
		List<ItemKv> rewardsGainsLimit = package.GetRewardsGainsLimit();
		int result = -1;
		if (rewardsGainsLimit != null && rewardsGainsLimit.Count > 0)
		{
			for (int i = 0; i < rewardsGainsLimit.Count; i++)
			{
				ItemKv itemKv = rewardsGainsLimit[i];
				if (itemKv.id != selectItem.Id)
				{
					continue;
				}
				if (itemKv.count >= 0)
				{
					int value = 0;
					MapField<int, BagChestRewardSelectRecord> mapField = _selfSelectChestRewardSelectData?.ChestRecords;
					if (mapField != null && mapField.TryGetValue(package.GetId(), out var value2))
					{
						value2.RewardSelectCounts.TryGetValue(selectItem.Id, out value);
					}
					result = Math.Max(0, itemKv.count - value);
				}
				break;
			}
		}
		return result;
	}

	public int GetRewardItemCanChooseCount(GiftPackage package, Item selectItem)
	{
		if (selectItem == null || package == null || package.type != GiftPackageType.SelfSelect)
		{
			return 0;
		}
		int count = package.GetCount();
		if (count <= 0)
		{
			return 0;
		}
		int canChooseCountInSelfSelectBagChest = GetCanChooseCountInSelfSelectBagChest(package, selectItem);
		if (canChooseCountInSelfSelectBagChest == 0)
		{
			return 0;
		}
		int num = ((canChooseCountInSelfSelectBagChest < 0) ? count : Math.Min(count, canChooseCountInSelfSelectBagChest));
		ItemKv itemKv = package.GetSelfSelectRewardsData()?.FirstOrDefault((ItemKv i) => i.id == selectItem.Id);
		int num2 = ((itemKv == null || itemKv.count <= 0) ? 1 : itemKv.count);
		ItemData data = CoreUtils.GetData(selectItem.Id, RuntimeConfigs.data.itemDatas);
		if (data == null || data.stackLimit <= 0)
		{
			return num;
		}
		bool num3 = CoreUtils.GetData(data.type, RuntimeConfigs.data.itemTypes)?.CanOverflowConvert ?? false;
		int itemCount = G.localPlayer.Inventory.GetItemCount(selectItem.Id);
		int num4 = Math.Max(0, data.stackLimit - itemCount);
		int val = (num3 ? Mathf.CeilToInt((float)num4 / (float)num2) : Mathf.FloorToInt((float)num4 / (float)num2));
		return Math.Max(0, Math.Min(num, val));
	}

	public bool SelfSelectGiftItemOperationIsValid(GiftPackage package, Item selectItem, int gainCount)
	{
		if (gainCount <= 0)
		{
			return false;
		}
		return gainCount <= GetRewardItemCanChooseCount(package, selectItem);
	}
}
