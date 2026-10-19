using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model.Jump;
using ACT.UI;
using ACT.UI.DataProxy;
using ACT.Utility;
using Fundamental;
using Google.Protobuf.Collections;
using Pb;
using Runtime.Model.PowerModel;
using Utility;

namespace ACT.Model;

public class InventoryModel : Model<InventoryModel>, IJumpable
{
	private InventoryTab _inventoryTab;

	private Action<Dictionary<FilterType, List<int>>> _updateFilterCompAction;

	private Dictionary<FilterType, List<int>> EquipFilterDic;

	private Dictionary<SortType, List<int>> EquipSortDic;

	private Dictionary<FilterType, List<int>> GemFilterDic;

	private bool GemSortIsReverse;

	private Action<ItemUIComponentBase, bool> _itemSelectedChange;

	private EquipComparer _equipComparer;

	private List<string> limitItemTips = new List<string>();

	private Action _itemCountChange;

	private readonly StringBuilder _redDotPathBuilder = new StringBuilder(32);

	public InventoryTab InventoryTab
	{
		get
		{
			if (_inventoryTab != InventoryTab.None)
			{
				return _inventoryTab;
			}
			return GetInventoryTabBySequence(1);
		}
	}

	public LuminModelType JumpSourceType => LuminModelType.Inventory;

	public event Action<Dictionary<FilterType, List<int>>> UpdateFilterCompAction
	{
		add
		{
			_updateFilterCompAction = (Action<Dictionary<FilterType, List<int>>>)Delegate.Combine(_updateFilterCompAction, value);
		}
		remove
		{
			_updateFilterCompAction = (Action<Dictionary<FilterType, List<int>>>)Delegate.Remove(_updateFilterCompAction, value);
		}
	}

	public event Action<ItemUIComponentBase, bool> ItemSelectedChange
	{
		add
		{
			_itemSelectedChange = (Action<ItemUIComponentBase, bool>)Delegate.Combine(_itemSelectedChange, value);
		}
		remove
		{
			_itemSelectedChange = (Action<ItemUIComponentBase, bool>)Delegate.Remove(_itemSelectedChange, value);
		}
	}

	public event Action ItemCountChange
	{
		add
		{
			_itemCountChange = (Action)Delegate.Combine(_itemCountChange, value);
		}
		remove
		{
			_itemCountChange = (Action)Delegate.Remove(_itemCountChange, value);
		}
	}

	public void UpdateItemCount()
	{
		_itemCountChange?.Invoke();
	}

	public void UpdateInventoryTab(InventoryTab inventoryTab)
	{
		_inventoryTab = inventoryTab;
	}

	public void UpdateFilterComp(Dictionary<FilterType, List<int>> filterDic)
	{
		_updateFilterCompAction?.Invoke(filterDic);
	}

	protected override void Init()
	{
		EquipFilterDic = DictionaryPool<FilterType, List<int>>.Get();
		EquipSortDic = DictionaryPool<SortType, List<int>>.Get();
		GemFilterDic = DictionaryPool<FilterType, List<int>>.Get();
		EquipSortDic.Add(SortType.Assist, ListPool<int>.Get());
		EquipSortDic[SortType.Assist].Add(0);
		EquipSortDic.Add(SortType.SortRule, ListPool<int>.Get());
		EquipSortDic[SortType.SortRule].Add(0);
		GemSortIsReverse = false;
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BagItemChange, OnBagItemChange);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.CharacterDependChange, OnCharacterDependChange);
		OnLoginRefreshRedpoint();
	}

	protected override void UnInit()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BagItemChange, OnBagItemChange);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.CharacterDependChange, OnCharacterDependChange);
		DictionaryPool<FilterType, List<int>>.Release(EquipFilterDic);
		EquipFilterDic = null;
		DictionaryPool<FilterType, List<int>>.Release(GemFilterDic);
		GemFilterDic = null;
		DictionaryPool<SortType, List<int>>.Release(EquipSortDic);
		EquipSortDic = null;
		GemSortIsReverse = false;
	}

	public InventoryTab GetInventoryTabBySequence(int sequence)
	{
		foreach (KeyValuePair<int, Bag> bag in RuntimeConfigs.data.bags)
		{
			if (bag.Value.Sequence == sequence)
			{
				return (InventoryTab)bag.Key;
			}
		}
		return InventoryTab.None;
	}

	public void OnItemSelectedChangeAction(ItemUIComponentBase item, bool selected)
	{
		_itemSelectedChange?.Invoke(item, selected);
	}

	public List<ItemUnifierProxy> GetItemListByInventoryTab(InventoryTab inventoryTab, bool isNeedSort = true)
	{
		List<ItemUnifierProxy> list = new List<ItemUnifierProxy>();
		if (!RuntimeConfigs.data.bags.TryGetValue((int)inventoryTab, out var value))
		{
			return list;
		}
		if (inventoryTab == InventoryTab.Equip)
		{
			ItemUnifierProxy.ItemUnifierPool.GetList(CharacterDependHelper.GetCurWorldAllEquip(), list);
		}
		else if (inventoryTab == InventoryTab.Disk)
		{
			ItemUnifierProxy.ItemUnifierPool.GetList(CharacterDependHelper.GetCurWorldAllGem(), list);
		}
		else if (inventoryTab == InventoryTab.HealingPotion)
		{
			ItemUnifierProxy.ItemUnifierPool.GetList(Model<BloodBottleModel>.Interface.GetAlreadyHaveBottles(), list);
			ItemUnifierProxy.ItemUnifierPool.GetList(G.localPlayer.Inventory.BloodBottleMaterials, list);
		}
		else
		{
			if (inventoryTab == InventoryTab.Valuable)
			{
				ItemUnifierProxy.ItemUnifierPool.GetList(G.localPlayer.Inventory.GiftPackages, list);
			}
			List<Item> list2 = ListPool<Item>.Get();
			foreach (Item item in G.localPlayer.Inventory.Items)
			{
				if (item.Count > 0 && (inventoryTab != InventoryTab.Valuable || item.itemType != 35) && value.showType.Contains(item.itemType) && value.hideOrNo != item.itemType)
				{
					list2.Add(item);
				}
			}
			ItemUnifierProxy.ItemUnifierPool.GetList(list2, list);
			ListPool<Item>.Release(list2);
		}
		if (isNeedSort)
		{
			ItemListNormalSort(list, inventoryTab);
		}
		return list;
	}

	public void ItemListNormalSort(List<ItemUnifierProxy> itemUnifierProxies, InventoryTab inventoryTab)
	{
		switch (inventoryTab)
		{
		case InventoryTab.Equip:
			SortItemList(itemUnifierProxies, EquipSortDic);
			break;
		case InventoryTab.Disk:
			itemUnifierProxies.Sort((ItemUnifierProxy x, ItemUnifierProxy y) => SortUtility.SortInventoryGem(x.As<Gem>(), y.As<Gem>(), !GemSortIsReverse));
			break;
		case InventoryTab.HealingPotion:
			itemUnifierProxies.Sort(SortUtility.SortBottleMatInBag);
			break;
		default:
			itemUnifierProxies.Sort(SortUtility.SortItemUnifierProxyInBag);
			break;
		}
	}

	public Dictionary<FilterType, List<int>> GetEquipFilters()
	{
		return EquipFilterDic;
	}

	public Dictionary<SortType, List<int>> GetEquipSorts()
	{
		return EquipSortDic;
	}

	public List<int> GetEquipAllQuality()
	{
		Dictionary<int, bool> dictionary = DictionaryPool<int, bool>.Get();
		foreach (KeyValuePair<int, EquipData> equipData in RuntimeConfigs.data.equipDatas)
		{
			if (!dictionary.ContainsKey(equipData.Value.quality))
			{
				dictionary.Add(equipData.Value.quality, value: true);
			}
		}
		List<int> result = dictionary.Keys.ToList();
		DictionaryPool<int, bool>.Release(dictionary);
		return result;
	}

	public Dictionary<FilterType, List<int>> GetGemFilters()
	{
		return GemFilterDic;
	}

	public List<int> GetGemAllQuality()
	{
		Dictionary<int, bool> dictionary = DictionaryPool<int, bool>.Get();
		foreach (KeyValuePair<int, EquipGemData> equipGemData in RuntimeConfigs.data.equipGemDatas)
		{
			if (!dictionary.ContainsKey(equipGemData.Value.quality + 2))
			{
				dictionary.Add(equipGemData.Value.quality + 2, value: true);
			}
		}
		List<int> result = dictionary.Keys.ToList();
		DictionaryPool<int, bool>.Release(dictionary);
		return result;
	}

	public void SetGemSortReverse()
	{
		GemSortIsReverse = !GemSortIsReverse;
	}

	public List<ItemUnifierProxy> FilterItems(List<ItemUnifierProxy> items, Dictionary<FilterType, List<int>> filterDic)
	{
		List<ItemUnifierProxy> list = ListPool<ItemUnifierProxy>.Get();
		for (int i = 0; i < items.Count; i++)
		{
			if (FilterItem(items[i], filterDic))
			{
				list.Add(items[i]);
			}
		}
		return list;
	}

	public bool FilterItem(ItemUnifierProxy itemUnifierProxy, Dictionary<FilterType, List<int>> filterDic)
	{
		foreach (KeyValuePair<FilterType, List<int>> item in filterDic)
		{
			switch (item.Key)
			{
			case FilterType.Suit:
				if (!FilterSuit(itemUnifierProxy, item.Value))
				{
					return false;
				}
				break;
			case FilterType.LockState:
				if (!FilterLockState(itemUnifierProxy, item.Value))
				{
					return false;
				}
				break;
			case FilterType.Quality:
				if (!FilterQuality(itemUnifierProxy, item.Value))
				{
					return false;
				}
				break;
			case FilterType.LevelState:
				if (!FilterLevelState(itemUnifierProxy, item.Value))
				{
					return false;
				}
				break;
			case FilterType.EquipedState:
				if (!FilterEquipState(itemUnifierProxy, item.Value))
				{
					return false;
				}
				break;
			}
		}
		return true;
	}

	public bool FilterSuit(ItemUnifierProxy item, List<int> values)
	{
		if (values == null || values.Count <= 0)
		{
			return true;
		}
		if (item.Source is Equip)
		{
			for (int i = 0; i < values.Count; i++)
			{
				if (RuntimeConfigs.data.equipSuitDatas.TryGetValue(values[i], out var value) && value.equipList.Contains(item.Id))
				{
					return true;
				}
			}
		}
		return false;
	}

	public bool FilterLockState(ItemUnifierProxy item, List<int> values)
	{
		if (values == null || values.Count <= 0)
		{
			return true;
		}
		if (item.Source is Equip)
		{
			Equip equip = item.As<Equip>();
			if (!equip.IsLock || values[0] != 0)
			{
				if (!equip.IsLock)
				{
					return values[0] == 1;
				}
				return false;
			}
			return true;
		}
		if (item.Source is Gem)
		{
			Gem gem = item.As<Gem>();
			if (!gem.IsLock || values[0] != 0)
			{
				if (!gem.IsLock)
				{
					return values[0] == 1;
				}
				return false;
			}
			return true;
		}
		return false;
	}

	public bool FilterQuality(ItemUnifierProxy item, List<int> values)
	{
		if (values == null || values.Count <= 0)
		{
			return true;
		}
		if (item.Source is Equip)
		{
			Equip equip = item.As<Equip>();
			if (values.Contains(equip.GetQuality()))
			{
				return true;
			}
		}
		else if (item.Source is Gem)
		{
			Gem gem = item.As<Gem>();
			if (values.Contains(gem.GetQuality()))
			{
				return true;
			}
		}
		return false;
	}

	public bool FilterLevelState(ItemUnifierProxy item, List<int> values)
	{
		if (values == null || values.Count <= 0)
		{
			return true;
		}
		if (item.Source is Equip)
		{
			Equip equip = item.As<Equip>();
			int level = equip.Level;
			int num = RuntimeConfigs.data.game.equipRareLevel[equip.GetQuality() - 1];
			if (level != num || values[0] != 0)
			{
				if (level < num)
				{
					return values[0] == 1;
				}
				return false;
			}
			return true;
		}
		return false;
	}

	public bool FilterEquipState(ItemUnifierProxy item, List<int> values)
	{
		if (values == null || values.Count <= 0)
		{
			return true;
		}
		if (item.Source is Equip)
		{
			Equip equip = item.As<Equip>();
			if (equip.WearCharacter <= 0 || values[0] != 0)
			{
				if (equip.WearCharacter <= 0)
				{
					return values[0] == 1;
				}
				return false;
			}
			return true;
		}
		if (item.Source is Gem)
		{
			Gem gem = item.As<Gem>();
			if (gem.InlayEquip <= 0 || values[0] != 0)
			{
				if (gem.InlayEquip <= 0)
				{
					return values[0] == 1;
				}
				return false;
			}
			return true;
		}
		return false;
	}

	public void CopyDictionary<T>(Dictionary<T, List<int>> oriDic, Dictionary<T, List<int>> newDic)
	{
		foreach (KeyValuePair<T, List<int>> item in oriDic)
		{
			List<int> value = item.Value;
			List<int> list = ListPool<int>.Get();
			for (int i = 0; i < value.Count; i++)
			{
				list.Add(value[i]);
			}
			if (newDic.ContainsKey(item.Key))
			{
				newDic.Remove(item.Key);
			}
			newDic.Add(item.Key, list);
		}
	}

	public void SortItemList(List<ItemUnifierProxy> itemUnifierProxies, Dictionary<SortType, List<int>> sortDic)
	{
		if (itemUnifierProxies != null && itemUnifierProxies.Count > 1)
		{
			if (_equipComparer == null)
			{
				_equipComparer = new EquipComparer(sortDic);
			}
			else
			{
				_equipComparer.SetSortDic(sortDic);
			}
			itemUnifierProxies.Sort(_equipComparer);
		}
	}

	public bool GetItemsIsAllDisabled(List<ItemUnifierProxy> itemUnifierProxies)
	{
		if (itemUnifierProxies == null)
		{
			return true;
		}
		foreach (ItemUnifierProxy itemUnifierProxy in itemUnifierProxies)
		{
			if (!GetItemIsDisabled(itemUnifierProxy))
			{
				return false;
			}
		}
		return true;
	}

	public bool GetItemIsDisabled(ItemUnifierProxy itemUnifierProxy)
	{
		if (itemUnifierProxy == null)
		{
			return false;
		}
		if (RuntimeConfigs.data.itemDatas.TryGetValue(itemUnifierProxy.Id, out var value) && !value.canBeDelete)
		{
			return true;
		}
		if (itemUnifierProxy.Source is Equip)
		{
			Equip equip = itemUnifierProxy.As<Equip>();
			if (equip.IsLock || equip.WearCharacter > 0)
			{
				return true;
			}
			return false;
		}
		if (itemUnifierProxy.Source is Gem)
		{
			Gem gem = itemUnifierProxy.As<Gem>();
			if (gem.IsLock || gem.InlayEquip > 0)
			{
				return true;
			}
			return false;
		}
		if (itemUnifierProxy.Source is BloodBottleData || itemUnifierProxy.Source is BloodBottleMaterial)
		{
			return true;
		}
		return false;
	}

	public bool GetInventoryCapacityIsLimit(List<ItemUnifierProxy> itemUnifierProxies)
	{
		foreach (KeyValuePair<int, Bag> bag in RuntimeConfigs.data.bags)
		{
			bool flag = false;
			int[] showType = bag.Value.showType;
			for (int i = 0; i < itemUnifierProxies.Count; i++)
			{
				if (showType.Contains(itemUnifierProxies[i].ItemData.type))
				{
					flag = true;
					break;
				}
			}
			if (flag && GetInventoryCapacityIsLimit((InventoryTab)bag.Key))
			{
				return true;
			}
		}
		return false;
	}

	public bool GetInventoryCapacityIsLimit(InventoryTab inventoryTab)
	{
		if (!RuntimeConfigs.data.bags.TryGetValue((int)inventoryTab, out var value))
		{
			return false;
		}
		switch (inventoryTab)
		{
		case InventoryTab.Equip:
			return CharacterDependHelper.GetCurWorldAllEquip().Count >= value.capacity;
		case InventoryTab.Disk:
			return CharacterDependHelper.GetCurWorldAllGem().Count >= value.capacity;
		case InventoryTab.HealingPotion:
			return Model<BloodBottleModel>.Interface.alreadyHaveBottles.Count() + Model<BloodBottleModel>.Interface.bottleMaterials.Count >= value.capacity;
		default:
		{
			int num = 0;
			foreach (Item item in G.localPlayer.Inventory.Items)
			{
				if (value.showType.Contains(item.itemType))
				{
					num++;
				}
			}
			return num >= value.capacity;
		}
		}
	}

	public RepeatedField<UniversalItem> InventoryOverflowGetDisplayItems(RepeatedField<UniversalItem> originUniversalItems)
	{
		RepeatedField<UniversalItem> repeatedField = new RepeatedField<UniversalItem>();
		if (originUniversalItems == null || originUniversalItems.Count <= 0)
		{
			return repeatedField;
		}
		RepeatedField<UniversalItem> repeatedField2 = new RepeatedField<UniversalItem>();
		int num = 0;
		foreach (UniversalItem originUniversalItem in originUniversalItems)
		{
			if (originUniversalItem.Count > 0)
			{
				repeatedField.Add(originUniversalItem.Clone());
			}
			if (originUniversalItem.ExtraItems.Count <= 0)
			{
				continue;
			}
			num++;
			if (num % 3 != 0 && num != originUniversalItem.ExtraItems.Count)
			{
				continue;
			}
			foreach (UniversalItem extraItem in originUniversalItem.ExtraItems)
			{
				UniversalItem universalItem = new UniversalItem();
				universalItem.Index = extraItem.Index;
				universalItem.Count = extraItem.Count;
				universalItem.Uid = originUniversalItem.Index;
				repeatedField2.Add(universalItem);
			}
			InventoryOverflowChangedTips(repeatedField2);
			repeatedField2.Clear();
		}
		return repeatedField;
	}

	public RepeatedField<Item> InventoryOverflowHandle(RepeatedField<UniversalItem> originUniversalItems)
	{
		RepeatedField<UniversalItem> repeatedField = InventoryOverflowGetDisplayItems(originUniversalItems);
		RepeatedField<Item> repeatedField2 = new RepeatedField<Item>();
		foreach (UniversalItem item in repeatedField)
		{
			repeatedField2.Add(new Item
			{
				Id = item.Index,
				Count = item.Count,
				IsNew = item.IsNew
			});
		}
		return repeatedField2;
	}

	public RepeatedField<UniversalItem> NewInventoryOverflowHandle(RepeatedField<UniversalItem> originUniversalItems)
	{
		RepeatedField<UniversalItem> repeatedField = InventoryOverflowGetDisplayItems(originUniversalItems);
		RepeatedField<UniversalItem> repeatedField2 = new RepeatedField<UniversalItem>();
		foreach (UniversalItem item in repeatedField)
		{
			repeatedField2.Add(item);
		}
		return repeatedField2;
	}

	public void InventoryOverflowChangedTips(RepeatedField<UniversalItem> changedUniversalItems)
	{
		if (changedUniversalItems != null && changedUniversalItems.Count > 0)
		{
			RepeatedField<UniversalItem> universalItems = MergeUniversalItems(changedUniversalItems);
			GameUtility.OpenToolTip(string.Format(LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2529), MergeItemName(changedUniversalItems, isUid: true), MergeItemName(universalItems)));
		}
	}

	private string MergeItemName(RepeatedField<UniversalItem> universalItems, bool isUid = false)
	{
		if (universalItems == null || universalItems.Count <= 0)
		{
			return string.Empty;
		}
		StringBuilder stringBuilder = new StringBuilder();
		for (int i = 0; i < universalItems.Count; i++)
		{
			ItemData data = CoreUtils.GetData(isUid ? universalItems[i].Uid : universalItems[i].Index, RuntimeConfigs.data.itemDatas);
			stringBuilder.Append(LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, data.nameLocal));
			if (i < universalItems.Count - 1)
			{
				stringBuilder.Append("、");
			}
		}
		return stringBuilder.ToString();
	}

	private RepeatedField<UniversalItem> MergeUniversalItems(RepeatedField<UniversalItem> originUniversalItems)
	{
		Dictionary<int, UniversalItem> dictionary = new Dictionary<int, UniversalItem>();
		foreach (UniversalItem originUniversalItem in originUniversalItems)
		{
			if (dictionary.TryGetValue(originUniversalItem.Index, out var value))
			{
				value.Count += originUniversalItem.Count;
			}
			else
			{
				dictionary.Add(originUniversalItem.Index, originUniversalItem);
			}
		}
		return dictionary.Values.ToRepeatedField();
	}

	public void InvetoryTipsNtfHandle(TipsNtf tipsNtf)
	{
		string empty = string.Empty;
		switch (tipsNtf.ErrCode)
		{
		case "S09-0003":
			empty = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2339);
			break;
		case "S09-0004":
		{
			if (tipsNtf.OverflowItems.Count > 3)
			{
				empty = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2532);
				break;
			}
			string item2 = MergeItemName(tipsNtf.OverflowItems);
			IList<object> list2 = new List<object>();
			list2.Add(item2);
			empty = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2528, list2);
			break;
		}
		case "S09-0005":
		{
			if (tipsNtf.OverflowItems.Count > 3)
			{
				empty = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2527);
				break;
			}
			string item = MergeItemName(tipsNtf.OverflowItems);
			IList<object> list = new List<object>();
			list.Add(item);
			empty = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2527, list);
			break;
		}
		case "S09-0006":
			empty = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2338);
			break;
		default:
			empty = tipsNtf.ErrCode;
			break;
		}
		GameUtility.OpenToolTip(empty);
	}

	public List<ItemUnifierProxy> GetDisuseItems(List<ItemUnifierProxy> oriItems)
	{
		List<ItemUnifierProxy> list = new List<ItemUnifierProxy>();
		foreach (ItemUnifierProxy oriItem in oriItems)
		{
			if (oriItem.Source is Item item && item.IsDisuse())
			{
				list.Add(oriItem);
			}
		}
		return list;
	}

	public void AddLimitItemTips(string content)
	{
		limitItemTips.Add(content);
		if (Model<FacePushModel>.HasInstance())
		{
			Model<FacePushModel>.Interface.RequestCheck();
		}
	}

	public bool HasLimitItemTips()
	{
		if (limitItemTips != null)
		{
			return limitItemTips.Count > 0;
		}
		return false;
	}

	public void PopupLimitItemTips()
	{
		if (limitItemTips == null || limitItemTips.Count <= 0)
		{
			return;
		}
		foreach (string limitItemTip in limitItemTips)
		{
			GameUtility.OpenToolTip(limitItemTip);
		}
		limitItemTips.Clear();
	}

	public int QuickFillItemSort(ItemUnifierProxy left, ItemUnifierProxy right)
	{
		if (left.Quality != right.Quality)
		{
			return left.Quality.CompareTo(right.Quality);
		}
		return left.Id.CompareTo(right.Id);
	}

	public bool CheckPowerIsUseLimit(ItemUIComponentBase itemUIComponentBase)
	{
		if (!(itemUIComponentBase.ItemUnifier.Source is Item item))
		{
			return false;
		}
		if (item.itemType != 23)
		{
			return false;
		}
		if (item.IsDisuse())
		{
			return true;
		}
		ItemData itemData = RuntimeConfigs.data.itemDatas[item.Id];
		int count = RuntimeConfigs.data.collections[itemData.Use].certain[0].count;
		int stackLimit = RuntimeConfigs.data.itemDatas[96].stackLimit;
		if (Model<PowerModel>.Interface.PowerCount + count > stackLimit)
		{
			return true;
		}
		return false;
	}

	public void OnBagItemChange(BaseEventContent baseEventContent)
	{
		if (!(baseEventContent is ItemChangeEvt itemChangeEvt))
		{
			return;
		}
		foreach (ItemUnifierProxy itemProxy in itemChangeEvt.ItemProxies)
		{
			int id = itemProxy.Id;
			int itemCount = G.localPlayer.Inventory.GetItemCount(id);
			bool state = (G.localPlayer.redPoints.Items.TryGetValue(id, out var value) & value) && itemCount > 0;
			RefreshRedpoint(id, state);
		}
	}

	private void OnCharacterDependChange(BaseEventContent baseEventContent)
	{
		if (baseEventContent is CharacterDependChangeEvt characterDependChangeEvt)
		{
			int num = (int)((G.localPlayer.Profile != null) ? G.localPlayer.Profile.SceneStatus : SceneStatus.Main);
			if (characterDependChangeEvt.sceneEnum == num)
			{
				RefreshCharacterDependRedpoint(characterDependChangeEvt.characterDependSnapshot, characterDependChangeEvt.remove);
			}
		}
	}

	private void RefreshCharacterDependRedpoint(CharacterDependSnapshot snapshot, bool remove)
	{
		if (snapshot == null)
		{
			return;
		}
		bool value = default;
		foreach (KeyValuePair<int, Equip> item in snapshot.EquipSnapshot)
		{
			bool active = (!remove && G.localPlayer.redPoints.Equips.TryGetValue(item.Key, out value)) & value;
			Singleton<RedDotManager>.instance.SetLeafNodeActive(GetItemRedDotPath(InventoryTab.Equip, item.Key), active);
		}
		bool value2 = default;
		foreach (KeyValuePair<int, Gem> item2 in snapshot.GemSnapshot)
		{
			bool active2 = (!remove && G.localPlayer.redPoints.Gems.TryGetValue(item2.Key, out value2)) & value2;
			Singleton<RedDotManager>.instance.SetLeafNodeActive(GetItemRedDotPath(InventoryTab.Disk, item2.Key), active2);
		}
	}

	public void RefreshRedpoint(int itemId, bool state)
	{
		InventoryTab inventoryTabByItemId = GetInventoryTabByItemId(itemId);
		if (inventoryTabByItemId != InventoryTab.None)
		{
			Singleton<RedDotManager>.instance.SetLeafNodeActive(GetItemRedDotPath(inventoryTabByItemId, itemId), state);
		}
	}

	private InventoryTab GetInventoryTabByItemId(int itemId)
	{
		if (!RuntimeConfigs.data.itemDatas.TryGetValue(itemId, out var value))
		{
			return InventoryTab.None;
		}
		foreach (Bag value2 in RuntimeConfigs.data.bags.Values)
		{
			if (value2.showType.Contains(value.type))
			{
				if (value.type == value2.hideOrNo)
				{
					return InventoryTab.None;
				}
				return (InventoryTab)value2.id;
			}
		}
		return InventoryTab.None;
	}

	private void OnLoginRefreshRedpoint()
	{
		bool value = default;
		foreach (Item item in G.localPlayer.Inventory.Items)
		{
			if ((item.Count > 0 && G.localPlayer.redPoints.Items.TryGetValue(item.Id, out value)) & value)
			{
				RefreshRedpoint(item.Id, state: true);
			}
		}
		RefreshRedpoint(InventoryTab.Equip);
		RefreshRedpoint(InventoryTab.Disk);
	}

	public void RefreshRedpoint()
	{
		foreach (KeyValuePair<int, Bag> bag in RuntimeConfigs.data.bags)
		{
			InventoryTab id = (InventoryTab)bag.Value.id;
			RefreshRedpoint(id);
		}
	}

	public void RefreshRedpoint(InventoryTab inventoryTab)
	{
		List<ItemUnifierProxy> itemListByInventoryTab = GetItemListByInventoryTab(inventoryTab, isNeedSort: false);
		for (int i = 0; i < itemListByInventoryTab.Count; i++)
		{
			bool itemRedDotState = GetItemRedDotState(itemListByInventoryTab[i]);
			Singleton<RedDotManager>.instance.SetLeafNodeActive(GetItemRedDotPath(inventoryTab, itemListByInventoryTab[i]), itemRedDotState);
		}
	}

	public string GetItemRedDotPath(InventoryTab inventoryTab, ItemUnifierProxy itemUnifierProxy)
	{
		IBagItem source = itemUnifierProxy.Source;
		if (!(source is Item) && !(source is GiftPackage) && !(source is BloodBottleData) && !(source is BloodBottleMaterial))
		{
			if (source is Equip || source is Gem)
			{
				return GetItemRedDotPath(inventoryTab, itemUnifierProxy.Uid);
			}
			return GetItemRedDotPath(inventoryTab, itemUnifierProxy.Id);
		}
		return GetItemRedDotPath(inventoryTab, itemUnifierProxy.Id);
	}

	public string GetItemRedDotPath(InventoryTab inventoryTab, int id)
	{
		_redDotPathBuilder.Clear();
		_redDotPathBuilder.Append(IsPreciousTab(inventoryTab) ? RedDotPathDefine.HasInventory : RedDotPathDefine.NormalInventory);
		_redDotPathBuilder.Append((int)inventoryTab);
		_redDotPathBuilder.Append('|');
		_redDotPathBuilder.Append(id);
		return _redDotPathBuilder.ToString();
	}

	public bool GetItemRedDotState(ItemUnifierProxy itemUnifierProxy)
	{
		bool value = false;
		IBagItem source = itemUnifierProxy.Source;
		if (!(source is Item) && !(source is GiftPackage) && !(source is BloodBottleData) && !(source is BloodBottleMaterial))
		{
			if (!(source is Gem gem))
			{
				if (source is Equip equip)
				{
					if (!G.localPlayer.redPoints.Equips.TryGetValue(equip.Uid, out value))
					{
						return false;
					}
					return value;
				}
				return false;
			}
			if (!G.localPlayer.redPoints.Gems.TryGetValue(gem.Uid, out value))
			{
				return false;
			}
			return value;
		}
		if (!G.localPlayer.redPoints.Items.TryGetValue(itemUnifierProxy.Id, out value))
		{
			return false;
		}
		return value;
	}

	public void SetItemRedDotState(InventoryTab inventoryTab, ItemUnifierProxy itemUnifierProxy)
	{
		bool flag = false;
		bool value = false;
		RedPoints redPoints = new RedPoints();
		switch (inventoryTab)
		{
		case InventoryTab.Equip:
			if (G.localPlayer.redPoints.Equips.TryGetValue(itemUnifierProxy.Uid, out value) & value)
			{
				G.localPlayer.redPoints.Equips[itemUnifierProxy.Uid] = false;
				redPoints.Equips.Add(itemUnifierProxy.Uid, value: false);
				flag = true;
			}
			break;
		case InventoryTab.Disk:
			if (G.localPlayer.redPoints.Gems.TryGetValue(itemUnifierProxy.Uid, out value) & value)
			{
				G.localPlayer.redPoints.Gems[itemUnifierProxy.Uid] = false;
				redPoints.Gems.Add(itemUnifierProxy.Uid, value: false);
				flag = true;
			}
			break;
		default:
			if (G.localPlayer.redPoints.Items.TryGetValue(itemUnifierProxy.Id, out value) & value)
			{
				G.localPlayer.redPoints.Items[itemUnifierProxy.Id] = false;
				redPoints.Items.Add(itemUnifierProxy.Id, value: false);
				flag = true;
			}
			break;
		}
		if (!flag)
		{
			return;
		}
		G.service.RefreshRedDot(redPoints, (bool flag2) =>
		{
			string itemRedDotPath = GetItemRedDotPath(inventoryTab, itemUnifierProxy);
			Singleton<RedDotManager>.instance.SetLeafNodeActive(itemRedDotPath, active: false);
			if (itemUnifierProxy.Context is ItemUIComponentBase itemUIComponentBase)
			{
				itemUIComponentBase.UpdatePerformance();
			}
		});
	}

	public void SetItemsRedDotState(InventoryTab inventoryTab, List<ItemUnifierProxy> itemUnifierProxies)
	{
		if (itemUnifierProxies == null || itemUnifierProxies.Count <= 0)
		{
			return;
		}
		RedPoints redPoints = new RedPoints();
		foreach (ItemUnifierProxy itemUnifierProxy in itemUnifierProxies)
		{
			switch (inventoryTab)
			{
			case InventoryTab.Equip:
				if (G.localPlayer.redPoints.Equips.ContainsKey(itemUnifierProxy.Uid) && !redPoints.Equips.ContainsKey(itemUnifierProxy.Uid))
				{
					G.localPlayer.redPoints.Equips[itemUnifierProxy.Uid] = false;
					redPoints.Equips.Add(itemUnifierProxy.Uid, value: false);
				}
				break;
			case InventoryTab.Disk:
				if (G.localPlayer.redPoints.Gems.ContainsKey(itemUnifierProxy.Uid) && !redPoints.Gems.ContainsKey(itemUnifierProxy.Uid))
				{
					G.localPlayer.redPoints.Gems[itemUnifierProxy.Uid] = false;
					redPoints.Gems.Add(itemUnifierProxy.Uid, value: false);
				}
				break;
			default:
				if (G.localPlayer.redPoints.Items.ContainsKey(itemUnifierProxy.Id) && !redPoints.Items.ContainsKey(itemUnifierProxy.Id))
				{
					G.localPlayer.redPoints.Items[itemUnifierProxy.Id] = false;
					redPoints.Items.Add(itemUnifierProxy.Id, value: false);
				}
				break;
			}
		}
		Action<int> refreshItemReddot = (int id) =>
		{
			string itemRedDotPath = GetItemRedDotPath(inventoryTab, id);
			Singleton<RedDotManager>.instance.SetLeafNodeActive(itemRedDotPath, active: false);
		};
		G.service.RefreshRedDot(redPoints, (bool value) =>
		{
			switch (inventoryTab)
			{
			case InventoryTab.Equip:
			{
				foreach (KeyValuePair<int, bool> equip in redPoints.Equips)
				{
					refreshItemReddot(equip.Key);
				}
				break;
			}
			case InventoryTab.Disk:
			{
				foreach (KeyValuePair<int, bool> gem in redPoints.Gems)
				{
					refreshItemReddot(gem.Key);
				}
				break;
			}
			default:
			{
				foreach (KeyValuePair<int, bool> item in redPoints.Items)
				{
					refreshItemReddot(item.Key);
				}
				break;
			}
			}
		});
	}

	public bool IsPreciousTab(InventoryTab inventoryTab)
	{
		if (inventoryTab == InventoryTab.Disk || inventoryTab == InventoryTab.HealingPotion || inventoryTab == InventoryTab.Valuable)
		{
			return true;
		}
		return false;
	}

	public JumpResult CanJump(RuntimeJumpData jumpData)
	{
		JumpResult result = default;
		if (!Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.Bag))
		{
			result.ShowType = JumpResult.JumpShowType.Hide;
			return result;
		}
		int inventoryTab = jumpData.Params[1];
		int itemId = ((jumpData.Params.Count > 2) ? jumpData.Params[2] : 0);
		if (itemId > 0 && GetItemListByInventoryTab((InventoryTab)inventoryTab).Find((ItemUnifierProxy item) => item.Id == itemId) == null)
		{
			result.ShowType = JumpResult.JumpShowType.Forbidden;
			result.Message = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2699);
			return result;
		}
		result.ShowType = JumpResult.JumpShowType.CanJump;
		return result;
	}

	public void Jump(RuntimeJumpData jumpData)
	{
		int num = jumpData.Params[1];
		int itemId = ((jumpData.Params.Count > 2) ? jumpData.Params[2] : 0);
		num = ((num <= 0) ? 1 : num);
		MonoInventoryData monoInventoryData = new MonoInventoryData();
		monoInventoryData.inventoryTab = (InventoryTab)num;
		monoInventoryData.ItemId = itemId;
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_BAGPANEL, monoInventoryData);
	}
}
