using System;
using System.Collections;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.LocalizationExtension;
using ACT.Model;
using ACT.MultiPlayer;
using ACT.UI.DataProxy;
using ACT.Utility;
using Bamboo.ImageCenter;
using Fundamental;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.Localization;
using UnityEngine.UI;

namespace ACT.UI;

public class MonoScrollBagComponent : BaseUIComponent
{
	public enum SortType
	{
		None,
		Weapon,
		Chip,
		Inventory,
		Team,
		Character,
		CookMainItem,
		OnlyQuality,
		InventoryChip
	}

	public enum FilterType
	{
		None,
		Weapon,
		Chip,
		Inventory,
		Team
	}

	public enum ParamType
	{
		Weapon = 0,
		Chip = 1,
		TeamCharacter = 2,
		Custom = 3,
		ToAdd = 4,
		Material = 5,
		Item = 6,
		SimpleCharacter = 7,
		DetailedCharacter = 8,
		Team = 9,
		TeamInventoryCharacter = 10,
		CookMainItem = 11,
		Default = 13,
		TeamAbyssCharacter = 14,
		ChipMaterial = 15,
		Precious = 17,
		Equip = 18,
		Gem = 19,
		Bloodbottle = 20,
		BloodBottleaterial = 21,
		None = 16,
		Reward = Bloodbottle
	}

	public struct Param
	{
		public enum ItemShowType
		{
			Common,
			None,
			ContrastItem,
			Reward,
			Skin,
			Product,
			TeamCharacter,
			Default
		}

		public ItemCollection allItems;

		public ItemCollection selection;

		public bool isMultiSelect;

		public Action<ItemUIComponentBase> onSelectItem;

		public Action<ItemUIComponentBase> onClickItem;

		public Action<ItemUIComponentBase> onUnSelectItem;

		public Action<ItemUIComponent, bool> showDetial;

		public Action<ItemUIComponentBase, int> onSelectCharacteModel;

		public Action<ItemUIComponent> onSelectCharacter;

		public Action<int, int> onSelectSelf;

		public Action<ItemUIComponentBase> onAdd;

		public Action<ItemUIComponent> onCharacter;

		public int btnIndex;

		public Func<ItemUIComponent, bool> onMultiAddCheck;

		public Func<ItemUIComponent, bool> onClickCheck;

		public Action<ItemCollection> onMultiSelect;

		public Action<List<int>> onCharaSelect;

		public bool isLock;

		public int multiSelectCount;

		public SortType sortType;

		public FilterType filterType;

		public ItemShowType itemShowType;

		public ItemUIComponentBase.ItemCountShowType itemCountShowType;

		public bool isBagItem;

		public int toGrayNum;

		public int[] teamCharacters;

		public int battleTeamIndex;

		public int teamSingleIndex;

		public Element element;

		public int chIndex;

		public ParamType paramType;

		public ItemUIComponentBase.InitType InitType;

		public bool notSort;

		public int teamIndex;

		public bool needRefeshState;

		public bool isComplate;

		public ImageAssetStation station;

		public Action closeCallBack;
	}

	public struct ItemCollection
	{
		public List<Item> items;

		public List<Weapon> weapons;

		public List<Chip> chips;

		public List<Equip> equips;

		public List<Gem> gems;

		public List<Character> characters;

		public List<PresetTeam> teams;

		public void Clear()
		{
			items?.Clear();
			weapons?.Clear();
			chips?.Clear();
			equips?.Clear();
		}
	}

	public LocalizeTMP_Dropdown sortDropdown;

	public LocalizeTMP_Dropdown filterDropDown;

	public Transform content;

	public Toggle curToggle;

	public LoopScrollRect loopScrollRect;

	public ItemUIGroup group;

	private Param m_Param;

	private ItemUIComponentBase.InitType initType;

	private bool isInit;

	private ItemUIComponentBase m_LastChosen;

	private ItemUIComponent m_LastEquipBloodBottle;

	private int m_Reverse = -1;

	private int m_SortValue;

	private List<Chip> chips = new List<Chip>();

	private int[] teamSort = new int[5] { 40, 39, 42, 44, 83 };

	private ParamType m_CurrentPage;

	private int m_Index = -1;

	private int m_Start;

	public int selectedItemIndex
	{
		get
		{
			return m_Index;
		}
		set
		{
			m_Index = value;
			loopScrollRect?.RefreshCells();
		}
	}

	public ItemUIComponent lastEquipBloodBottle
	{
		get
		{
			return m_LastEquipBloodBottle;
		}
		set
		{
			m_LastEquipBloodBottle = value;
		}
	}

	private bool selectionReachMax => selectionCount >= m_Param.multiSelectCount;

	private int selectionCount => ((m_Param.selection.items != null) ? m_Param.selection.items.Count : 0) + ((m_Param.selection.weapons != null) ? m_Param.selection.weapons.Count : 0) + ((m_Param.selection.chips != null) ? m_Param.selection.chips.Count : 0);

	public void Init(Param myParam, int selectedIndex = -1, int reverse = 1, int start = 0, bool autoScrollTo = false)
	{
		loopScrollRect.ClearCells();
		m_Param = myParam;
		m_CurrentPage = m_Param.paramType;
		initType = m_Param.InitType;
		m_Reverse = reverse;
		m_Index = selectedIndex;
		m_Start = 0;
		isInit = true;
		ChangePrefabIndex();
		m_Start = start;
		UnLoadLastChosen();
		if ((m_Param.paramType == ParamType.Team || m_Param.paramType == ParamType.SimpleCharacter) | autoScrollTo)
		{
			ScrollToCellItemByIndex(m_Index);
		}
		else
		{
			loopScrollRect.RefillCells();
		}
		loopScrollRect.ForceUpdateConstraint();
		isInit = false;
	}

	public void ScrollToCellItemByIndex(int index)
	{
		loopScrollRect.RefillCells(index);
		loopScrollRect.ScrollToCell(index, 0f);
	}

	public void Refresh(int itemId = -1, int reverse = 1, int start = 0)
	{
		loopScrollRect.ClearCells();
		m_CurrentPage = m_Param.paramType;
		initType = m_Param.InitType;
		m_Reverse = reverse;
		m_Index = itemId;
		m_Start = 0;
		isInit = true;
		ChangePrefabIndex();
		m_Start = start;
		UnLoadLastChosen();
		loopScrollRect.RefillCells();
	}

	public IEnumerator Co_Init(Param myParam, int itemId = -1)
	{
		m_Param = myParam;
		yield return null;
	}

	public ItemUIComponent GetItemComponent(int itemid)
	{
		return loopScrollRect.GetItem(itemid) as ItemUIComponent;
	}

	public void UnLoadLastChosen()
	{
		if (m_LastChosen != null)
		{
			m_LastChosen.IsHighLight = false;
			m_LastChosen = null;
		}
	}

	public void OnItemChosen(ItemUIComponent chosen)
	{
		if (m_Param.onClickCheck != null && !m_Param.onClickCheck(chosen))
		{
			return;
		}
		Item item = chosen.item;
		if (item != null && item.Count < 1)
		{
			return;
		}
		ItemChosen(chosen);
		if (!m_Param.isMultiSelect)
		{
			return;
		}
		chosen.IsHighLight = true;
		if (m_Param.onMultiAddCheck != null && !m_Param.onMultiAddCheck(chosen))
		{
			return;
		}
		chosen.OnMulitSelect();
		switch (chosen.ItemType)
		{
		case ItemUIComponentBase.InitType.BagItem:
		case ItemUIComponentBase.InitType.CookItem:
		{
			Item selectionItem = GetSelectionItem(chosen.item.Id);
			if (selectionItem == null)
			{
				GameUtility.OpenToolTip(1595);
				if (LuminApplication.LogEnabled)
				{
					Debug.Log("格子满了");
				}
				break;
			}
			if (chosen.count < G.localPlayer.Inventory.GetItemInfo(chosen.item.Id).Count)
			{
				chosen.AddItemSelectCount();
				selectionItem.Count = chosen.count;
				selectionItem.selected = true;
				OnItemMutipleChoose evt = Singleton<EventManager>.instance.GetEvt<OnItemMutipleChoose>();
				evt.itemCount = chosen.count;
				evt.ItemTypeCount = m_Param.selection.items.Count;
				evt.Choose = chosen;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_OnItemUIComentCountChange, evt);
				Singleton<EventManager>.instance.ReleaseEvt(evt);
				break;
			}
			OnItemMutipleChoose evt2 = Singleton<EventManager>.instance.GetEvt<OnItemMutipleChoose>();
			evt2.itemCount = chosen.count;
			evt2.ItemTypeCount = m_Param.selection.items.Count;
			evt2.Choose = chosen;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_OnItemUIComentCountChange, evt2);
			Singleton<EventManager>.instance.ReleaseEvt(evt2);
			return;
		}
		case ItemUIComponentBase.InitType.BagWeapon:
			if (m_Param.selection.weapons.Contains(chosen.weapon))
			{
				break;
			}
			if (selectionReachMax)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.Log("格子满了");
				}
				chosen.SingleSelect();
			}
			else if (chosen.isLock)
			{
				chosen.SingleSelect();
				GameUtility.OpenToolTip(182);
			}
			else
			{
				m_Param.selection.weapons.Add(chosen.weapon);
				OnItemMutipleChoose evt3 = Singleton<EventManager>.instance.GetEvt<OnItemMutipleChoose>();
				evt3.itemCount = 1;
				evt3.ItemTypeCount = m_Param.selection.weapons.Count;
				evt3.Choose = chosen;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_OnItemUIComentCountChange, evt3);
				Singleton<EventManager>.instance.ReleaseEvt(evt3);
			}
			break;
		case ItemUIComponentBase.InitType.BagChip:
			if (!m_Param.selection.chips.Contains(chosen.chip))
			{
				m_Param.selection.chips.Add(chosen.chip);
			}
			break;
		case ItemUIComponentBase.InitType.BagGem:
			if (!m_Param.selection.gems.Contains(chosen.gem))
			{
				m_Param.selection.gems.Add(chosen.gem);
			}
			break;
		case ItemUIComponentBase.InitType.BagEquip:
			if (!m_Param.selection.equips.Contains(chosen.equip))
			{
				m_Param.selection.equips.Add(chosen.equip);
			}
			break;
		}
		m_Param.onMultiSelect?.Invoke(m_Param.selection);
	}

	public void OnItemChosen(ItemUIComponentBase chosen)
	{
		if ((bool)m_LastChosen)
		{
			m_LastChosen.IsHighLight = false;
		}
		chosen.IsHighLight = true;
		m_Param.onClickItem?.Invoke(chosen);
		m_Param.onSelectItem?.Invoke(chosen);
		chosen.UpdatePerformance();
		m_LastChosen = chosen;
		m_Index = chosen.Index;
	}

	private void ItemChosen(ItemUIComponent chosen)
	{
		m_Param.onClickItem?.Invoke(chosen);
		ItemUIComponent itemUIComponent = m_LastChosen as ItemUIComponent;
		if (itemUIComponent != chosen || !chosen.IsHighLight)
		{
			if (itemUIComponent != null && itemUIComponent.IsHighLight)
			{
				itemUIComponent.IsHighLight = false;
				m_Param.onUnSelectItem?.Invoke(m_LastChosen);
			}
			m_LastChosen = chosen;
			chosen.IsHighLight = true;
			m_Param.onSelectItem?.Invoke(m_LastChosen);
			m_Index = chosen.Index;
		}
	}

	public void OnReduceClick(ItemUIComponent chosen)
	{
		if (m_Param.onClickCheck != null && !m_Param.onClickCheck(chosen))
		{
			return;
		}
		chosen.ReduceSelectCount();
		switch (chosen.ItemType)
		{
		case ItemUIComponentBase.InitType.BagItem:
		case ItemUIComponentBase.InitType.CookItem:
		{
			Item selectionItem = GetSelectionItem(chosen.item.Id);
			selectionItem.Count = chosen.count;
			if (chosen.count == 0)
			{
				selectionItem.selected = false;
				m_Param.selection.items.Remove(selectionItem);
			}
			OnItemMutipleChoose evt2 = Singleton<EventManager>.instance.GetEvt<OnItemMutipleChoose>();
			evt2.itemCount = chosen.count;
			evt2.ItemTypeCount = m_Param.selection.items.Count;
			evt2.Choose = chosen;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_OnItemUIComentCountChange, evt2);
			Singleton<EventManager>.instance.ReleaseEvt(evt2);
			break;
		}
		case ItemUIComponentBase.InitType.BagWeapon:
		{
			m_Param.selection.weapons.Remove(chosen.weapon);
			OnItemMutipleChoose evt = Singleton<EventManager>.instance.GetEvt<OnItemMutipleChoose>();
			evt.itemCount = 0;
			evt.ItemTypeCount = m_Param.selection.weapons.Count;
			evt.Choose = chosen;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_OnItemUIComentCountChange, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
			break;
		}
		case ItemUIComponentBase.InitType.BagChip:
			m_Param.selection.chips.Remove(chosen.chip);
			break;
		case ItemUIComponentBase.InitType.BagEquip:
			m_Param.selection.equips.Remove(chosen.equip);
			break;
		case ItemUIComponentBase.InitType.BagGem:
			m_Param.selection.gems.Remove(chosen.gem);
			break;
		}
		m_Param.onMultiSelect?.Invoke(m_Param.selection);
	}

	public void ReleaseAllItemPrefab()
	{
	}

	public void OnSortClick()
	{
		if (gameObject.activeSelf)
		{
			m_Reverse = -m_Reverse;
			ChangePrefabIndex();
			loopScrollRect.RefreshCells();
		}
	}

	public void OnSortTypeChange()
	{
		m_SortValue = sortDropdown.value;
		ChangePrefabIndex();
		loopScrollRect.RefreshCells();
	}

	public void RefreshSortType()
	{
		m_SortValue = sortDropdown.value;
	}

	public void SetSortType(int index)
	{
		m_SortValue = index;
	}

	public void InitSortDropDown(SortType sort)
	{
		List<LocalizeTMP_Dropdown.OptionData> list = new List<LocalizeTMP_Dropdown.OptionData>();
		sortDropdown.ClearOptions();
		switch (sort)
		{
		case SortType.Weapon:
			list.Add(new LocalizeTMP_Dropdown.OptionData(new LocalizedString("Common", 40L)));
			list.Add(new LocalizeTMP_Dropdown.OptionData(new LocalizedString("Common", 39L)));
			sortDropdown.AddOptions(list);
			break;
		case SortType.Chip:
			list.Add(new LocalizeTMP_Dropdown.OptionData(new LocalizedString("Common", 911L)));
			sortDropdown.AddOptions(list);
			break;
		case SortType.InventoryChip:
			list.Add(new LocalizeTMP_Dropdown.OptionData(new LocalizedString("Common", 910L)));
			list.Add(new LocalizeTMP_Dropdown.OptionData(new LocalizedString("Common", 911L)));
			sortDropdown.AddOptions(list);
			break;
		case SortType.Inventory:
			list.Add(new LocalizeTMP_Dropdown.OptionData(new LocalizedString("Common", 40L)));
			list.Add(new LocalizeTMP_Dropdown.OptionData(new LocalizedString("Common", 39L)));
			sortDropdown.AddOptions(list);
			break;
		case SortType.Team:
		{
			for (int i = 0; i < teamSort.Length; i++)
			{
				list.Add(new LocalizeTMP_Dropdown.OptionData(new LocalizedString("Common", teamSort[i])));
			}
			sortDropdown.AddOptions(list);
			break;
		}
		case SortType.Character:
			list.Add(new LocalizeTMP_Dropdown.OptionData(new LocalizedString("Common", 39L)));
			list.Add(new LocalizeTMP_Dropdown.OptionData(new LocalizedString("Common", 40L)));
			sortDropdown.AddOptions(list);
			break;
		case SortType.CookMainItem:
			list.Add(new LocalizeTMP_Dropdown.OptionData(new LocalizedString("Common", 40L)));
			list.Add(new LocalizeTMP_Dropdown.OptionData(new LocalizedString("Common", 807L)));
			sortDropdown.AddOptions(list);
			break;
		case SortType.OnlyQuality:
			list.Add(new LocalizeTMP_Dropdown.OptionData(new LocalizedString("Common", 40L)));
			sortDropdown.AddOptions(list);
			break;
		case SortType.None:
			break;
		}
	}

	public void InitFilterDropDown(FilterType filter)
	{
		List<LocalizeTMP_Dropdown.OptionData> list = new List<LocalizeTMP_Dropdown.OptionData>();
		switch (filter)
		{
		case FilterType.Chip:
		{
			list.Add(new LocalizeTMP_Dropdown.OptionData(new LocalizedString("Common", 37L)));
			for (int i = 1; i <= RuntimeConfigs.data.itemChipSuitDatas.Count; i++)
			{
				list.Add(new LocalizeTMP_Dropdown.OptionData(new LocalizedString("Common", RuntimeConfigs.data.itemChipSuitDatas[i].nameLocal)));
			}
			filterDropDown.AddOptions(list);
			break;
		}
		case FilterType.Inventory:
		{
			list.Add(new LocalizeTMP_Dropdown.OptionData(new LocalizedString("Common", 37L)));
			bool flag = false;
			foreach (ItemChipSuitData value in RuntimeConfigs.data.itemChipSuitDatas.Values)
			{
				if (!flag)
				{
					flag = true;
				}
				else
				{
					list.Add(new LocalizeTMP_Dropdown.OptionData(new LocalizedString("Common", value.nameLocal)));
				}
			}
			filterDropDown.AddOptions(list);
			break;
		}
		case FilterType.None:
		case FilterType.Weapon:
		case FilterType.Team:
			break;
		}
	}

	public void SetSelectedCharacter(Character character)
	{
		m_Index = m_Param.allItems.characters.IndexOf(character);
		UnLoadLastChosen();
		if (enabled)
		{
			loopScrollRect.RefillCells();
		}
	}

	[Obsolete]
	public void SetItemContent(ItemUIComponent btn, int index)
	{
		if ((bool)group)
		{
			btn.group = group;
		}
		btn.gameObject.SetActive(value: true);
		btn.OnItemClick = null;
		if ((bool)btn.reduceBtn)
		{
			btn.reduceBtn.onClick.RemoveAllListeners();
		}
		switch (m_CurrentPage)
		{
		case ParamType.Weapon:
		{
			Weapon weapon = m_Param.allItems.weapons[index];
			btn.BagWeaponInit(weapon, m_Param.needRefeshState);
			if (m_Param.selection.weapons != null && m_Param.selection.weapons.Count > 0)
			{
				foreach (Weapon weapon3 in m_Param.selection.weapons)
				{
					if (weapon3.Uid == btn.weapon.Uid)
					{
						btn.OnMulitSelect();
					}
				}
			}
			ItemUIComponent itemUIComponent10 = btn;
			itemUIComponent10.OnItemClick = (UnityAction<ItemUIComponentBase>)Delegate.Combine(itemUIComponent10.OnItemClick, (UnityAction<ItemUIComponentBase>)((ItemUIComponentBase l) =>
			{
				OnItemChosen(btn);
			}));
			btn.reduceBtn.onClick.AddListener(() =>
			{
				OnReduceClick(btn);
			});
			break;
		}
		case ParamType.Equip:
		{
			Equip equip = m_Param.allItems.equips[index];
			btn.BagEquipInit(equip);
			if (m_Param.selection.equips != null && m_Param.selection.equips.Count > 0)
			{
				foreach (Equip equip2 in m_Param.selection.equips)
				{
					if (equip2.Uid == btn.equip.Uid)
					{
						btn.OnMulitSelect();
					}
				}
			}
			ItemUIComponent itemUIComponent8 = btn;
			itemUIComponent8.OnItemClick = (UnityAction<ItemUIComponentBase>)Delegate.Combine(itemUIComponent8.OnItemClick, (UnityAction<ItemUIComponentBase>)((ItemUIComponentBase l) =>
			{
				OnItemChosen(btn);
			}));
			btn.reduceBtn.onClick.AddListener(() =>
			{
				OnReduceClick(btn);
			});
			break;
		}
		case ParamType.Gem:
		{
			Gem gem = m_Param.allItems.gems[index];
			btn.BagGemInit(gem);
			if (m_Param.selection.gems != null && m_Param.selection.gems.Count > 0)
			{
				foreach (Gem gem2 in m_Param.selection.gems)
				{
					if (gem2.Uid == btn.gem.Uid)
					{
						btn.OnMulitSelect();
					}
				}
			}
			ItemUIComponent itemUIComponent14 = btn;
			itemUIComponent14.OnItemClick = (UnityAction<ItemUIComponentBase>)Delegate.Combine(itemUIComponent14.OnItemClick, (UnityAction<ItemUIComponentBase>)((ItemUIComponentBase l) =>
			{
				OnItemChosen(btn);
			}));
			btn.reduceBtn.onClick.AddListener(() =>
			{
				OnReduceClick(btn);
			});
			break;
		}
		case ParamType.Chip:
		{
			Chip chip = m_Param.allItems.chips[index];
			btn.BagChipInit(chip);
			if (m_Param.selection.chips != null && m_Param.selection.chips.Count > 0)
			{
				foreach (Chip chip2 in m_Param.selection.chips)
				{
					if (chip2.Uid == btn.chip.Uid)
					{
						btn.OnMulitSelect();
					}
				}
			}
			ItemUIComponent itemUIComponent2 = btn;
			itemUIComponent2.OnItemClick = (UnityAction<ItemUIComponentBase>)Delegate.Combine(itemUIComponent2.OnItemClick, (UnityAction<ItemUIComponentBase>)((ItemUIComponentBase l) =>
			{
				OnItemChosen(btn);
			}));
			btn.reduceBtn.onClick.AddListener(() =>
			{
				OnReduceClick(btn);
			});
			break;
		}
		case ParamType.TeamCharacter:
		{
			_ = m_Param.allItems.characters[index];
			for (int num = 0; num < m_Param.teamCharacters.Length; num++)
			{
				if (m_Param.teamCharacters[num] != 0 && m_Param.teamCharacters[num] == btn.character.Id)
				{
					btn.isInTeam = true;
					m_Param.selection.characters.Add(btn.character);
				}
			}
			switch (m_Param.btnIndex)
			{
			case 1:
			{
				for (int num2 = 0; num2 < m_Param.teamCharacters.Length; num2++)
				{
					if (m_Param.teamCharacters[num2] == btn.character.Id)
					{
						btn.positions[num2].gameObject.SetActive(value: true);
					}
				}
				ItemUIComponent itemUIComponent5 = btn;
				itemUIComponent5.OnItemClick = (UnityAction<ItemUIComponentBase>)Delegate.Combine(itemUIComponent5.OnItemClick, (UnityAction<ItemUIComponentBase>)((ItemUIComponentBase l) =>
				{
					OnCharacterChoose(btn);
				}));
				break;
			}
			case 2:
			{
				ItemUIComponent itemUIComponent4 = btn;
				itemUIComponent4.OnItemClick = (UnityAction<ItemUIComponentBase>)Delegate.Combine(itemUIComponent4.OnItemClick, (UnityAction<ItemUIComponentBase>)((ItemUIComponentBase l) =>
				{
					OnAddCharacter(btn);
				}));
				break;
			}
			case 3:
			{
				if (m_Param.teamCharacters[m_Param.chIndex] == btn.character.Id)
				{
					btn.IsHighLight = true;
					m_LastChosen = btn;
					m_Param.onSelectSelf?.Invoke(m_LastChosen.ItemUnifier.Id, m_Param.chIndex);
				}
				ItemUIComponent itemUIComponent3 = btn;
				itemUIComponent3.OnItemClick = (UnityAction<ItemUIComponentBase>)Delegate.Combine(itemUIComponent3.OnItemClick, (UnityAction<ItemUIComponentBase>)((ItemUIComponentBase l) =>
				{
					OnChangeModel(btn);
				}));
				break;
			}
			}
			break;
		}
		case ParamType.Custom:
		{
			if (index < m_Param.allItems.items.Count)
			{
				Item item8 = m_Param.allItems.items[index];
				int selectCount2 = m_Param.selection.items.Find((Item i) => i.Id == item8.Id)?.Count ?? 0;
				btn.SelectMaterialItemInit(item8, selectCount2);
				if (m_Param.selection.items != null && m_Param.selection.items.Count > 0)
				{
					foreach (Item item9 in m_Param.selection.items)
					{
						if (item9.Id == btn.item.Id)
						{
							btn.OnMulitSelect();
						}
					}
				}
			}
			else
			{
				Weapon weapon2 = m_Param.allItems.weapons[index - m_Param.allItems.items.Count];
				btn.BagWeaponInit(weapon2);
				if (m_Param.selection.weapons != null && m_Param.selection.weapons.Count > 0)
				{
					foreach (Weapon weapon4 in m_Param.selection.weapons)
					{
						if (weapon4.Uid == btn.weapon.Uid)
						{
							btn.OnMulitSelect();
						}
					}
				}
			}
			ItemUIComponent itemUIComponent20 = btn;
			itemUIComponent20.OnItemClick = (UnityAction<ItemUIComponentBase>)Delegate.Combine(itemUIComponent20.OnItemClick, (UnityAction<ItemUIComponentBase>)((ItemUIComponentBase l) =>
			{
				OnItemChosen(btn);
			}));
			btn.reduceBtn.onClick.AddListener(() =>
			{
				OnReduceClick(btn);
			});
			break;
		}
		case ParamType.CookMainItem:
		case ParamType.ChipMaterial:
		{
			Item item5 = m_Param.allItems.items[index];
			int selectCount = (m_Param.selection.items?.Find((Item i) => i.Id == item5.Id))?.Count ?? 0;
			btn.SelectMaterialItemInit(item5, selectCount, m_CurrentPage == ParamType.CookMainItem);
			if (m_Param.selection.items != null && m_Param.selection.items.Count > 0)
			{
				foreach (Item item10 in m_Param.selection.items)
				{
					if (item10.Id == btn.item.Id)
					{
						btn.OnMulitSelect();
					}
				}
			}
			ItemUIComponent itemUIComponent13 = btn;
			itemUIComponent13.OnItemClick = (UnityAction<ItemUIComponentBase>)Delegate.Combine(itemUIComponent13.OnItemClick, (UnityAction<ItemUIComponentBase>)((ItemUIComponentBase l) =>
			{
				OnItemChosen(btn);
			}));
			btn.reduceBtn.onClick.AddListener(() =>
			{
				OnReduceClick(btn);
			});
			break;
		}
		case ParamType.ToAdd:
			btn.InitAddItem(isTrue: true);
			break;
		case ParamType.Material:
			if (index < m_Param.allItems.items.Count)
			{
				btn.ShowSelectBar(m_Param.allItems.items[index]);
			}
			else if (index - m_Param.allItems.items.Count < m_Param.allItems.weapons.Count)
			{
				btn.ShowSelectWeaponBar(m_Param.allItems.weapons[index - m_Param.allItems.items.Count]);
			}
			break;
		case ParamType.Item:
		{
			Item item4 = m_Param.allItems.items[index];
			_ = (m_Param.selection.items?.Find((Item i) => i.Id == item4.Id))?.Count;
			btn.BagItemInit(item4, m_Param.needRefeshState);
			if (m_Param.selection.items != null && m_Param.selection.items.Count > 0)
			{
				foreach (Item item11 in m_Param.selection.items)
				{
					if (item11.Id == btn.item.Id)
					{
						btn.OnMulitSelect();
					}
				}
			}
			ItemUIComponent itemUIComponent9 = btn;
			itemUIComponent9.OnItemClick = (UnityAction<ItemUIComponentBase>)Delegate.Combine(itemUIComponent9.OnItemClick, (UnityAction<ItemUIComponentBase>)((ItemUIComponentBase l) =>
			{
				OnItemChosen(btn);
			}));
			btn.reduceBtn.onClick.AddListener(() =>
			{
				OnReduceClick(btn);
			});
			break;
		}
		case ParamType.SimpleCharacter:
		{
			Character character = m_Param.allItems.characters[index];
			btn.SimpleCharacterInit(character);
			ItemUIComponent itemUIComponent11 = btn;
			itemUIComponent11.OnItemClick = (UnityAction<ItemUIComponentBase>)Delegate.Combine(itemUIComponent11.OnItemClick, (UnityAction<ItemUIComponentBase>)((ItemUIComponentBase l) =>
			{
				OnItemChosen(btn);
			}));
			if (isInit)
			{
				btn.anim.SetBool("Switch", value: false);
				btn.anim.Play((btn.Index == m_Index) ? "SelectedShow" : "NormalShow");
			}
			else if (btn.anim.isActiveAndEnabled)
			{
				btn.anim.Play((btn.Index == m_Index) ? "Select" : "NormalExchange");
			}
			break;
		}
		case ParamType.Default:
		{
			Item item3 = m_Param.allItems.items[index];
			btn.BagItemInit(item3, m_Param.needRefeshState);
			if (m_Param.selection.items != null && m_Param.selection.items.Count > 0)
			{
				foreach (Item item12 in m_Param.selection.items)
				{
					if (item12.Id == btn.item.Id)
					{
						btn.OnMulitSelect();
						if (m_Param.needRefeshState)
						{
							btn.UpdateCountTexUI(showMutiple: true, item12.Count);
						}
					}
				}
			}
			else
			{
				btn.count = 0;
			}
			ItemUIComponent itemUIComponent7 = btn;
			itemUIComponent7.OnItemClick = (UnityAction<ItemUIComponentBase>)Delegate.Combine(itemUIComponent7.OnItemClick, (UnityAction<ItemUIComponentBase>)((ItemUIComponentBase l) =>
			{
				OnItemChosen(btn);
			}));
			btn.reduceBtn.onClick.AddListener(() =>
			{
				OnReduceClick(btn);
			});
			break;
		}
		case ParamType.Precious:
		{
			Item item7 = m_Param.allItems.items[index];
			btn.BagItemInit(item7, m_Param.needRefeshState);
			if (m_Param.selection.items != null && m_Param.selection.items.Count > 0)
			{
				foreach (Item item13 in m_Param.selection.items)
				{
					if (item13.Id == btn.item.Id)
					{
						btn.OnMulitSelect();
						if (m_Param.needRefeshState)
						{
							btn.UpdateCountTexUI(showMutiple: true, item13.Count);
						}
					}
				}
			}
			else
			{
				btn.count = 0;
			}
			ItemUIComponent itemUIComponent19 = btn;
			itemUIComponent19.OnItemClick = (UnityAction<ItemUIComponentBase>)Delegate.Combine(itemUIComponent19.OnItemClick, (UnityAction<ItemUIComponentBase>)((ItemUIComponentBase l) =>
			{
				OnItemChosen(btn);
			}));
			break;
		}
		case ParamType.None:
		{
			Item item6 = m_Param.allItems.items[index];
			btn.NoneItemInit(item6);
			ItemUIComponent itemUIComponent18 = btn;
			itemUIComponent18.OnItemClick = (UnityAction<ItemUIComponentBase>)Delegate.Combine(itemUIComponent18.OnItemClick, (UnityAction<ItemUIComponentBase>)((ItemUIComponentBase l) =>
			{
				OnItemChosen(btn);
			}));
			break;
		}
		case ParamType.Team:
		{
			PresetTeam selectTeam = m_Param.allItems.teams[index];
			bool isBattle = index == m_Param.battleTeamIndex;
			btn.InitTeam(selectTeam, isBattle);
			ItemUIComponent itemUIComponent17 = btn;
			itemUIComponent17.OnItemClick = (UnityAction<ItemUIComponentBase>)Delegate.Combine(itemUIComponent17.OnItemClick, (UnityAction<ItemUIComponentBase>)((ItemUIComponentBase l) =>
			{
				OnItemChosen(btn);
			}));
			break;
		}
		case ParamType.DetailedCharacter:
		{
			Character character4 = m_Param.allItems.characters[index];
			btn.BagCharacterInit(character4, m_Param.teamCharacters);
			ItemUIComponent itemUIComponent16 = btn;
			itemUIComponent16.OnItemClick = (UnityAction<ItemUIComponentBase>)Delegate.Combine(itemUIComponent16.OnItemClick, (UnityAction<ItemUIComponentBase>)((ItemUIComponentBase l) =>
			{
				OnItemChosen(btn);
			}));
			break;
		}
		case ParamType.TeamInventoryCharacter:
		{
			Character character3 = m_Param.allItems.characters[index];
			btn.BagCharacterInit(character3, m_Param.teamCharacters, m_Param.teamIndex);
			ItemUIComponent itemUIComponent15 = btn;
			itemUIComponent15.OnItemClick = (UnityAction<ItemUIComponentBase>)Delegate.Combine(itemUIComponent15.OnItemClick, (UnityAction<ItemUIComponentBase>)((ItemUIComponentBase l) =>
			{
				OnItemChosen(btn);
			}));
			break;
		}
		case ParamType.TeamAbyssCharacter:
		{
			Character character2 = m_Param.allItems.characters[index];
			btn.BagCharacterInit(character2, m_Param.teamCharacters);
			if (Model<AbyssModel>.Interface.abyssUsedIds.ContainsKey(character2.Id))
			{
				btn.SetTeam(show: true, Model<AbyssModel>.Interface.abyssUsedIds[character2.Id]);
			}
			ItemUIComponent itemUIComponent12 = btn;
			itemUIComponent12.OnItemClick = (UnityAction<ItemUIComponentBase>)Delegate.Combine(itemUIComponent12.OnItemClick, (UnityAction<ItemUIComponentBase>)((ItemUIComponentBase l) =>
			{
				OnItemChosen(btn);
			}));
			break;
		}
		case ParamType.Bloodbottle:
		{
			Item item2 = m_Param.allItems.items[index];
			if (item2.itemType == 15)
			{
				btn.BloodBottleInit(item2, m_Param.station);
				if (MPPlayer.local.CurrentBattleTeam.EquipPotionId != 0 && (object)m_LastEquipBloodBottle == null)
				{
					m_LastEquipBloodBottle = ((btn.item.Id == CoreUtils.GetData(MPPlayer.local.CurrentBattleTeam.EquipPotionId, RuntimeConfigs.data.potionDatas).itemId) ? btn : null);
				}
			}
			ItemUIComponent itemUIComponent6 = btn;
			itemUIComponent6.OnItemClick = (UnityAction<ItemUIComponentBase>)Delegate.Combine(itemUIComponent6.OnItemClick, (UnityAction<ItemUIComponentBase>)((ItemUIComponentBase l) =>
			{
				OnItemChosen(btn);
			}));
			break;
		}
		case ParamType.BloodBottleaterial:
		{
			Item item = m_Param.allItems.items[index];
			if (item.itemType == 16)
			{
				btn.BloodBottleMaterialInit(item);
			}
			ItemUIComponent itemUIComponent = btn;
			itemUIComponent.OnItemClick = (UnityAction<ItemUIComponentBase>)Delegate.Combine(itemUIComponent.OnItemClick, (UnityAction<ItemUIComponentBase>)((ItemUIComponentBase l) =>
			{
				OnItemChosen(btn);
			}));
			break;
		}
		}
		if (m_Index == btn.Index)
		{
			ItemChosen(btn);
		}
	}

	public void SetItemContent(ItemUIComponentBase btn)
	{
		if ((bool)group)
		{
			btn.group = group;
		}
		btn.Station = m_Param.station;
		btn.gameObject.SetActive(value: true);
		ItemUnifierProxy itemUnifierProxy = null;
		switch (m_CurrentPage)
		{
		case ParamType.Weapon:
			itemUnifierProxy = ItemUnifierProxy.ItemUnifierPool.Get(m_Param.allItems.weapons[btn.Index]);
			btn.SetData(itemUnifierProxy, long.MinValue, ItemUIComponentBase.InitType.BagWeapon);
			break;
		case ParamType.Chip:
			_ = m_Param.allItems.chips[btn.Index];
			break;
		case ParamType.Equip:
			itemUnifierProxy = ItemUnifierProxy.ItemUnifierPool.Get(m_Param.allItems.equips[btn.Index]);
			btn.SetData(itemUnifierProxy, long.MinValue, ItemUIComponentBase.InitType.BagEquip);
			break;
		case ParamType.Gem:
			itemUnifierProxy = ItemUnifierProxy.ItemUnifierPool.Get(m_Param.allItems.gems[btn.Index]);
			btn.SetData(itemUnifierProxy, long.MinValue, ItemUIComponentBase.InitType.BagGem);
			break;
		case ParamType.TeamCharacter:
		{
			_ = m_Param.allItems.characters[btn.Index];
			for (int i = 0; i < m_Param.teamCharacters.Length; i++)
			{
				if (m_Param.teamCharacters[i] != 0 && m_Param.teamCharacters[i] == btn.ItemUnifier.Id)
				{
					m_Param.selection.characters.Add(btn.ItemUnifier.Source as Character);
				}
			}
			switch (m_Param.btnIndex)
			{
			case 1:
			{
				for (int j = 0; j < m_Param.teamCharacters.Length; j++)
				{
					_ = m_Param.teamCharacters[j];
					_ = btn.ItemUnifier.Id;
				}
				break;
			}
			case 3:
				if (m_Param.teamCharacters[m_Param.chIndex] == btn.ItemUnifier.Id)
				{
					btn.IsHighLight = true;
					m_Param.onSelectSelf?.Invoke(m_LastChosen.ItemUnifier.Id, m_Param.chIndex);
				}
				break;
			}
			break;
		}
		case ParamType.Custom:
			if (btn.Index < m_Param.allItems.items.Count)
			{
				Item item4 = m_Param.allItems.items[btn.Index];
				_ = m_Param.selection.items.Find((Item item5) => item5.Id == item4.Id)?.Count;
				if (m_Param.selection.items == null || m_Param.selection.items.Count <= 0)
				{
					break;
				}
				foreach (Item item5 in m_Param.selection.items)
				{
					_ = item5;
				}
				break;
			}
			itemUnifierProxy = ItemUnifierProxy.ItemUnifierPool.Get(m_Param.allItems.weapons[btn.Index - m_Param.allItems.items.Count]);
			btn.SetData(itemUnifierProxy, long.MinValue, ItemUIComponentBase.InitType.BagWeapon);
			if (m_Param.selection.weapons == null || m_Param.selection.weapons.Count <= 0)
			{
				break;
			}
			foreach (Weapon weapon in m_Param.selection.weapons)
			{
				_ = weapon;
			}
			break;
		case ParamType.CookMainItem:
		case ParamType.ChipMaterial:
		{
			Item item2 = m_Param.allItems.items[btn.Index];
			_ = (m_Param.selection.items?.Find((Item item5) => item5.Id == item2.Id))?.Count;
			break;
		}
		case ParamType.Item:
		{
			Item item3 = m_Param.allItems.items[btn.Index];
			_ = (m_Param.selection.items?.Find((Item item5) => item5.Id == item3.Id))?.Count;
			itemUnifierProxy = ItemUnifierProxy.ItemUnifierPool.Get(item3);
			btn.SetData(itemUnifierProxy, G.localPlayer.Inventory.GetItemInfo(item3.Id)?.Count ?? 0, ItemUIComponentBase.InitType.BagItem, m_Param.itemCountShowType);
			if (m_Param.selection.items == null || m_Param.selection.items.Count <= 0)
			{
				break;
			}
			foreach (Item item6 in m_Param.selection.items)
			{
				_ = item6;
			}
			break;
		}
		case ParamType.SimpleCharacter:
			_ = m_Param.allItems.characters[btn.Index];
			break;
		case ParamType.Default:
			itemUnifierProxy = ItemUnifierProxy.ItemUnifierPool.Get(m_Param.allItems.items[btn.Index]);
			btn.SetData(itemUnifierProxy);
			break;
		case ParamType.None:
			itemUnifierProxy = ItemUnifierProxy.ItemUnifierPool.Get(m_Param.allItems.items[btn.Index]);
			btn.SetData(itemUnifierProxy);
			break;
		case ParamType.Bloodbottle:
			itemUnifierProxy = ItemUnifierProxy.ItemUnifierPool.Get(m_Param.allItems.items[btn.Index]);
			btn.SetData(itemUnifierProxy, long.MinValue, m_Param.isComplate ? ItemUIComponentBase.InitType.RewardItemReceived : ItemUIComponentBase.InitType.RewardItem);
			break;
		}
		btn.UpdatePerformance();
		if (itemUnifierProxy != null)
		{
			itemUnifierProxy.OnValueChanged = (ItemUnifierProxy _) =>
			{
				btn.UpdatePerformance();
			};
		}
		btn.OnItemClick = OnItemChosen;
		if (m_Index == btn.Index)
		{
			OnItemChosen(btn);
			return;
		}
		btn.IsHighLight = false;
		btn.UpdatePerformance();
	}

	public void SelectedTarRefresh(ItemUIComponent btn)
	{
		if (m_CurrentPage == ParamType.Chip)
		{
			btn.BagChipInit(btn.chip);
		}
		m_Param.onClickItem?.Invoke(btn);
		m_Param.onSelectItem?.Invoke(btn);
		if (m_LastChosen != null && m_LastChosen.IsHighLight)
		{
			m_LastChosen.IsHighLight = false;
			m_Param.onUnSelectItem?.Invoke(m_LastChosen);
		}
		m_LastChosen = btn;
		m_LastChosen.IsHighLight = true;
		m_Param.onSelectItem?.Invoke(m_LastChosen);
		m_Index = btn.Index;
	}

	public void ResetAnim(ItemUIComponent btn, int index)
	{
		btn.anim.SetBool("Switch", value: false);
		btn.anim.Play("NormalStatus");
	}

	public void OnDestroy()
	{
		UnInit();
	}

	public void UnInit()
	{
		if ((bool)loopScrollRect.gameObject)
		{
			loopScrollRect.ClearCellsPool();
		}
	}

	private void OnAddCharacter(ItemUIComponent chosen)
	{
		if (m_LastChosen != chosen)
		{
			if (m_LastChosen != null && m_LastChosen.IsHighLight)
			{
				m_LastChosen.IsHighLight = false;
			}
			m_LastChosen = chosen;
			m_LastChosen.IsHighLight = true;
			m_Param.onAdd?.Invoke(m_LastChosen);
		}
	}

	private void OnChangeModel(ItemUIComponent chosen)
	{
		if (m_LastChosen != chosen)
		{
			if (m_LastChosen != null && m_LastChosen.IsHighLight)
			{
				m_LastChosen.IsHighLight = false;
			}
			m_LastChosen = chosen;
			m_LastChosen.IsHighLight = true;
			m_Param.onSelectCharacteModel?.Invoke(m_LastChosen, m_Param.chIndex);
		}
	}

	private void OnCharacterChoose(ItemUIComponent chosen)
	{
		m_Param.onSelectCharacter?.Invoke(chosen);
		m_Param.onMultiSelect?.Invoke(m_Param.selection);
	}

	private Item GetSelectionItem(int id)
	{
		Item item = m_Param.selection.items.Find((Item i) => i.Id == id);
		if (item == null)
		{
			if (selectionReachMax)
			{
				return null;
			}
			item = new Item();
			item.Id = id;
			item.Count = 0;
			m_Param.selection.items.Add(item);
		}
		return item;
	}

	private void ChangePrefabIndex()
	{
		switch (m_Param.paramType)
		{
		case ParamType.Weapon:
			loopScrollRect.totalCount = m_Param.allItems.weapons?.Count ?? 0;
			if (m_Index == -1)
			{
				SortCustomWeapon(m_Start);
			}
			else if (m_Param.allItems.weapons != null)
			{
				Weapon item2 = m_Param.allItems.weapons[m_Index];
				SortCustomWeapon(m_Start);
				int index2 = m_Param.allItems.weapons.IndexOf(item2);
				m_Index = index2;
			}
			break;
		case ParamType.Equip:
			loopScrollRect.totalCount = m_Param.allItems.equips.Count;
			if (m_Index == -1)
			{
				SortCustomEquip(m_Start);
			}
			else if (m_Param.allItems.equips != null)
			{
				Equip item8 = m_Param.allItems.equips[m_Index];
				SortCustomEquip(m_Start);
				m_Param.allItems.equips.Remove(item8);
				m_Param.allItems.equips.Insert(0, item8);
				m_Index = 0;
			}
			break;
		case ParamType.Gem:
			loopScrollRect.totalCount = m_Param.allItems.gems.Count;
			if (m_Index == -1)
			{
				SortCustomGem(m_Start);
			}
			else if (m_Param.allItems.gems != null)
			{
				Gem item10 = m_Param.allItems.gems[m_Index];
				SortCustomGem(m_Start);
				m_Param.allItems.gems.Remove(item10);
				m_Param.allItems.gems.Insert(0, item10);
				m_Index = 0;
			}
			break;
		case ParamType.Chip:
		{
			loopScrollRect.totalCount = m_Param.allItems.chips.Count;
			Chip item7 = null;
			if (m_Index != -1 && m_Index != -2 && m_Index < m_Param.allItems.chips.Count)
			{
				item7 = m_Param.allItems.chips[m_Index];
			}
			SetChipSelect();
			if (m_Param.sortType == SortType.Chip)
			{
				SortCustomChip(m_Start);
			}
			if (m_Param.sortType == SortType.InventoryChip)
			{
				SortInventoryChip(m_Start);
			}
			if (m_Index != -1 && m_Index <= m_Param.allItems.chips.Count - 1)
			{
				if (m_Index == -2 && m_Param.allItems.chips.Count > 0)
				{
					m_Index = 0;
					break;
				}
				int index7 = m_Param.allItems.chips.IndexOf(item7);
				m_Index = index7;
			}
			break;
		}
		case ParamType.TeamCharacter:
		{
			loopScrollRect.totalCount = m_Param.allItems.characters.Count;
			if (m_Index == -1)
			{
				SortCustomCharacter(m_Start);
				break;
			}
			Character item3 = m_Param.allItems.characters[m_Index];
			SortCustomCharacter(m_Start);
			int index3 = m_Param.allItems.characters.IndexOf(item3);
			m_Index = index3;
			break;
		}
		case ParamType.Custom:
		{
			loopScrollRect.totalCount = m_Param.allItems.weapons.Count + m_Param.allItems.items.Count;
			if (m_Index == -1)
			{
				SortCustomItem(m_Start);
				SortCustomWeapon(m_Start);
				break;
			}
			Item item4 = null;
			Weapon item5 = null;
			if (m_Index < m_Param.allItems.items.Count)
			{
				item4 = m_Param.allItems.items[m_Index];
			}
			else
			{
				item5 = m_Param.allItems.weapons[m_Index];
			}
			SortCustomItem(m_Start);
			SortCustomWeapon(m_Start);
			if (item4 != null)
			{
				int index4 = m_Param.allItems.items.IndexOf(item4);
				m_Index = index4;
			}
			else
			{
				int index5 = m_Param.allItems.weapons.IndexOf(item5);
				m_Index = index5;
			}
			break;
		}
		case ParamType.Item:
		case ParamType.Default:
		case ParamType.ChipMaterial:
		case ParamType.None:
		case ParamType.Precious:
		case ParamType.Bloodbottle:
		case ParamType.BloodBottleaterial:
			loopScrollRect.totalCount = m_Param.allItems.items.Count;
			if (!m_Param.notSort)
			{
				if (m_Index == -1)
				{
					SortCustomItem(m_Start);
					break;
				}
				Item item9 = m_Param.allItems.items[m_Index];
				SortCustomItem(m_Start);
				int index8 = m_Param.allItems.items.IndexOf(item9);
				m_Index = index8;
			}
			break;
		case ParamType.SimpleCharacter:
		case ParamType.DetailedCharacter:
		case ParamType.TeamAbyssCharacter:
		{
			loopScrollRect.totalCount = m_Param.allItems.characters.Count;
			if (m_Index == -1)
			{
				SortCustomCharacter(m_Start);
				break;
			}
			Character item6 = m_Param.allItems.characters[m_Index];
			SortCustomCharacter(m_Start);
			int index6 = m_Param.allItems.characters.IndexOf(item6);
			m_Index = index6;
			break;
		}
		case ParamType.Team:
			loopScrollRect.totalCount = m_Param.allItems.teams.Count;
			break;
		case ParamType.CookMainItem:
			loopScrollRect.totalCount = m_Param.allItems.items.Count;
			if (!m_Param.notSort)
			{
				if (m_Index == -1)
				{
					SortCustomCookMainItem(m_Start);
					break;
				}
				Item item = m_Param.allItems.items[m_Index];
				SortCustomCookMainItem(m_Start);
				int index = m_Param.allItems.items.IndexOf(item);
				m_Index = index;
			}
			break;
		}
		UnLoadLastChosen();
	}

	private int SortTeam(Character x, Character y)
	{
		for (int i = 0; i < SortUtility.CompareBaseCharacter[m_SortValue].Length; i++)
		{
			int num = SortUtility.CompareBaseCharacter[m_SortValue][i](x, y);
			if (num != 0)
			{
				return num * m_Reverse;
			}
		}
		return 0;
	}

	private int SortItem(Item x, Item y)
	{
		for (int i = 0; i < SortUtility.CompareInventoryItem[0].Length; i++)
		{
			int num = SortUtility.CompareInventoryItem[0][i](x, y);
			if (num != 0)
			{
				return num * -1;
			}
		}
		return 0;
	}

	private int SortCookMainItem(Item x, Item y)
	{
		for (int i = 0; i < SortUtility.CookMainItem[m_SortValue].Length; i++)
		{
			int num = SortUtility.CookMainItem[m_SortValue][i](x, y);
			if (num != 0)
			{
				return num * m_Reverse;
			}
		}
		return 0;
	}

	private int SortWeapon(Weapon x, Weapon y)
	{
		for (int i = 0; i < SortUtility.CompareWeapon[m_SortValue].Length; i++)
		{
			int num = SortUtility.CompareWeapon[m_SortValue][i](x, y);
			if (num != 0)
			{
				return num * m_Reverse;
			}
		}
		return 0;
	}

	private int SortInventoryWeapon(Weapon x, Weapon y)
	{
		for (int i = 0; i < SortUtility.CompareInventoryWeapon[m_SortValue].Length; i++)
		{
			int num = SortUtility.CompareInventoryWeapon[m_SortValue][i](x, y);
			if (num != 0)
			{
				return num * m_Reverse;
			}
		}
		return 0;
	}

	private int Sortchip(Chip x, Chip y)
	{
		for (int i = 0; i < SortUtility.CompareChip[m_SortValue].Length; i++)
		{
			int num = SortUtility.CompareChip[m_SortValue][i](x, y);
			if (num != 0)
			{
				return num * m_Reverse;
			}
		}
		return 0;
	}

	private int SortEquip(Equip x, Equip y)
	{
		for (int i = 0; i < SortUtility.CompareEquip[m_SortValue].Length; i++)
		{
			int num = SortUtility.CompareEquip[m_SortValue][i](x, y);
			if (num != 0)
			{
				return num * m_Reverse;
			}
		}
		return 0;
	}

	private int SortGem(Gem x, Gem y)
	{
		for (int i = 0; i < SortUtility.CompareInventoryGem[m_SortValue].Length; i++)
		{
			int num = SortUtility.CompareInventoryGem[m_SortValue][i](x, y);
			if (num != 0)
			{
				return num * m_Reverse;
			}
		}
		return 0;
	}

	private int SortInventoryChip(Chip x, Chip y)
	{
		for (int i = 0; i < SortUtility.CompareInventoryChip[m_SortValue].Length; i++)
		{
			int num = SortUtility.CompareInventoryChip[m_SortValue][i](x, y);
			if (num != 0)
			{
				return num * m_Reverse;
			}
		}
		return 0;
	}

	private void SortCustomItem(int start = 0)
	{
		List<Item> range = m_Param.allItems.items.GetRange(0, start);
		m_Param.allItems.items.RemoveRange(0, start);
		m_Param.allItems.items.Sort(SortItem);
		m_Param.allItems.items.InsertRange(0, range);
	}

	private void SortCustomWeapon(int start = 0)
	{
		List<Weapon> range = m_Param.allItems.weapons.GetRange(0, start);
		m_Param.allItems.weapons.RemoveRange(0, start);
		m_Param.allItems.weapons.Sort(SortWeapon);
		m_Param.allItems.weapons.InsertRange(0, range);
	}

	private void SortCustomCharacter(int start = 0)
	{
		List<Character> range = m_Param.allItems.characters.GetRange(0, start);
		m_Param.allItems.characters.RemoveRange(0, start);
		m_Param.allItems.characters.Sort(SortTeam);
		m_Param.allItems.characters.InsertRange(0, range);
	}

	private void SortCustomChip(int start = 0)
	{
		List<Chip> range = m_Param.allItems.chips.GetRange(0, start);
		m_Param.allItems.chips.RemoveRange(0, start);
		m_Param.allItems.chips.Sort(Sortchip);
		m_Param.allItems.chips.InsertRange(0, range);
	}

	private void SortCustomEquip(int start = 0)
	{
		List<Equip> range = m_Param.allItems.equips.GetRange(0, start);
		m_Param.allItems.equips.RemoveRange(0, start);
		m_Param.allItems.equips.Sort(SortEquip);
		m_Param.allItems.equips.InsertRange(0, range);
	}

	private void SortCustomGem(int start = 0)
	{
		List<Gem> range = m_Param.allItems.gems.GetRange(0, start);
		m_Param.allItems.gems.RemoveRange(0, start);
		m_Param.allItems.gems.Sort(SortGem);
		m_Param.allItems.gems.InsertRange(0, range);
	}

	private void SetChipSelect()
	{
	}

	private void SortInventoryChip(int start = 0)
	{
		List<Chip> range = m_Param.allItems.chips.GetRange(0, start);
		m_Param.allItems.chips.RemoveRange(0, start);
		m_Param.allItems.chips.Sort(SortInventoryChip);
		m_Param.allItems.chips.InsertRange(0, range);
	}

	private void SortCustomCookMainItem(int start = 0)
	{
		List<Item> range = m_Param.allItems.items.GetRange(0, start);
		m_Param.allItems.items.RemoveRange(0, start);
		m_Param.allItems.items.Sort(SortCookMainItem);
		m_Param.allItems.items.InsertRange(0, range);
	}
}
