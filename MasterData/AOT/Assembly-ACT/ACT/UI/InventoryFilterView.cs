using System;
using System.Collections.Generic;
using ACT.Core;
using ACT.Model;
using ACT.UI.ViewComponent.InventoryView;
using ACT.Utility;
using Fundamental;
using Sirenix.Serialization;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class InventoryFilterView : LuminSerializedMonoBehaviour
{
	[OdinSerialize]
	public LocalizeStringEvent Title;

	[OdinSerialize]
	public Dictionary<FilterType, List<GameObject>> FilterGameObjects;

	[OdinSerialize]
	public Dictionary<FilterType, Dictionary<int, InventoryFilterCell>> InventoryFilterCells;

	public GameObject SuitTitle;

	public RectTransform Suitparent;

	public InventoryEquipSuitItem EquipSuitItem;

	public ActButton AddSuitButton;

	public GameObject EquipStateTitle;

	public RectTransform QualityParent;

	public GameObject QualityItem;

	[OdinSerialize]
	public Dictionary<InventoryTab, Dictionary<MonoInventoryView.InventoryState, List<FilterType>>> filterTypeDic;

	public ActButton ResetButton;

	public ActButton ConfirmButton;

	[OdinSerialize]
	public Dictionary<FilterType, LocalizeStringEvent> FilterTitleName;

	private BaseUIComponent monoInventoryView;

	private Dictionary<FilterType, List<int>> filterDic;

	private Dictionary<FilterType, List<int>> oriFilterDic;

	private List<InventoryEquipSuitItem> InventoryEquipSuitItems;

	private InventoryTab inventoryTab;

	private static readonly Dictionary<FilterType, (int, int, int)> EquipFilterCommonIds = new Dictionary<FilterType, (int, int, int)>
	{
		{
			FilterType.LockState,
			(2310, 2311, 2312)
		},
		{
			FilterType.LevelState,
			(2314, 2315, 2316)
		},
		{
			FilterType.EquipedState,
			(2317, 2318, 2319)
		}
	};

	private static readonly Dictionary<FilterType, (int, int, int)> DiskFilterCommonIds = new Dictionary<FilterType, (int, int, int)>
	{
		{
			FilterType.LockState,
			(2310, 2311, 2312)
		},
		{
			FilterType.LevelState,
			(0, 2315, 2316)
		},
		{
			FilterType.EquipedState,
			(2335, 2336, 2337)
		}
	};

	private void OnClickAddSuitButtonHandle()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_INVENTORYEQUIPSUITFILTER, new InventoryEquipSuitFilterViewData
		{
			EquipSuitIds = filterDic[FilterType.Suit]
		});
	}

	public void OnClickResetButtonHandle()
	{
		ClearEquipSuitItem();
		foreach (KeyValuePair<FilterType, Dictionary<int, InventoryFilterCell>> inventoryFilterCell in InventoryFilterCells)
		{
			foreach (KeyValuePair<int, InventoryFilterCell> item in inventoryFilterCell.Value)
			{
				item.Value.SetIsOn(val: false);
			}
		}
		foreach (KeyValuePair<FilterType, List<int>> item2 in filterDic)
		{
			item2.Value.Clear();
		}
	}

	public void OnClickConfirmButtonHandle()
	{
		Close();
		Model<InventoryModel>.Interface.CopyDictionary(filterDic, oriFilterDic);
		if (monoInventoryView is MonoInventoryView)
		{
			((MonoInventoryView)monoInventoryView).OnFilter(oriFilterDic);
			Model<InventoryModel>.Interface.UpdateFilterComp(oriFilterDic);
		}
		else if (monoInventoryView is EquipDecomposeView)
		{
			((EquipDecomposeView)monoInventoryView).OnFilter(oriFilterDic);
		}
	}

	public void Close()
	{
		gameObject.SetActive(value: false);
		foreach (KeyValuePair<FilterType, Dictionary<int, InventoryFilterCell>> inventoryFilterCell in InventoryFilterCells)
		{
			_ = inventoryFilterCell.Key;
			foreach (KeyValuePair<int, InventoryFilterCell> item in inventoryFilterCell.Value)
			{
				item.Value.onValueChanged.RemoveAllListeners();
			}
		}
		ClearEquipSuitItem();
		ListPool<InventoryEquipSuitItem>.Release(InventoryEquipSuitItems);
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Bag/Window_Close");
	}

	private void ClearEquipSuitItem()
	{
		for (int num = InventoryEquipSuitItems.Count - 1; num >= 0; num--)
		{
			UnityEngine.Object.Destroy(InventoryEquipSuitItems[num].gameObject);
		}
		InventoryEquipSuitItems.Clear();
	}

	public void RefreshUI<T>(BaseUIView<T> monoInventoryView, InventoryTab inventoryTab, MonoInventoryView.InventoryState inventoryState, Dictionary<FilterType, List<int>> oriFilterDic) where T : class, IInputController, new()
	{
		this.monoInventoryView = monoInventoryView;
		InventoryEquipSuitItems = ListPool<InventoryEquipSuitItem>.Get();
		this.oriFilterDic = oriFilterDic;
		filterDic = DictionaryPool<FilterType, List<int>>.Get();
		this.inventoryTab = inventoryTab;
		Model<InventoryModel>.Interface.CopyDictionary(oriFilterDic, filterDic);
		if (!filterTypeDic.TryGetValue(inventoryTab, out var value) || !value.TryGetValue(inventoryState, out var value2))
		{
			return;
		}
		AddSuitButton.SetBtnClick(OnClickAddSuitButtonHandle, "event:/UI/Interface/Bag/Click");
		ResetButton.SetBtnClick(OnClickResetButtonHandle, "event:/UI/Interface/Bag/Clear");
		ConfirmButton.SetBtnClick(OnClickConfirmButtonHandle, "event:/UI/Interface/Bag/Confirm");
		Title.StringReference.TableEntryReference = ((inventoryTab == InventoryTab.Equip) ? 2307 : 2334);
		SuitTitle.SetActive(inventoryTab == InventoryTab.Equip);
		EquipStateTitle.SetActive(inventoryTab == InventoryTab.Equip);
		foreach (KeyValuePair<FilterType, List<GameObject>> filterGameObject in FilterGameObjects)
		{
			bool active = value2.Contains(filterGameObject.Key);
			for (int i = 0; i < filterGameObject.Value.Count; i++)
			{
				filterGameObject.Value[i].SetActive(active);
			}
		}
		if (value2.Contains(FilterType.Suit))
		{
			RefreshEquipSuitFilter();
		}
		if (value2.Contains(FilterType.Quality))
		{
			List<int> list = null;
			switch (inventoryTab)
			{
			case InventoryTab.Equip:
				list = Model<InventoryModel>.Interface.GetEquipAllQuality();
				break;
			case InventoryTab.Disk:
				list = Model<InventoryModel>.Interface.GetGemAllQuality();
				break;
			}
			if (!InventoryFilterCells.ContainsKey(FilterType.Quality))
			{
				InventoryFilterCells.Add(FilterType.Quality, DictionaryPool<int, InventoryFilterCell>.Get());
			}
			foreach (KeyValuePair<int, InventoryFilterCell> item in InventoryFilterCells[FilterType.Quality])
			{
				UnityEngine.Object.Destroy(item.Value.gameObject);
			}
			InventoryFilterCells[FilterType.Quality].Clear();
			list?.Sort((int x, int y) => y.CompareTo(x));
			for (int num = 0; num < list.Count; num++)
			{
				int num2 = list[num];
				InventoryFilterCell component = UnityEngine.Object.Instantiate(QualityItem, QualityParent).GetComponent<InventoryFilterCell>();
				component.gameObject.SetActive(value: true);
				component.Value = num2;
				int num3 = CoreUtils.GetData(num2, RuntimeConfigs.data.itemQualitys).name;
				LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, num3);
				component.UpdateName(LocalizationUtility.localizeTableName_shortcommon, num3);
				component.SetIsOn(val: false);
				InventoryFilterCells[FilterType.Quality].Add(num2, component);
				if (filterDic.TryGetValue(FilterType.Quality, out var value3))
				{
					component.SetIsOn(value3.Contains(num2));
				}
			}
			for (int num4 = list.Count - 1; num4 < InventoryFilterCells[FilterType.Quality].Count - 1; num4++)
			{
				InventoryFilterCells[FilterType.Quality][num4].gameObject.SetActive(value: false);
			}
		}
		RefreshFilterState(FilterType.LockState);
		RefreshFilterState(FilterType.LevelState);
		RefreshFilterState(FilterType.EquipedState);
		foreach (KeyValuePair<FilterType, Dictionary<int, InventoryFilterCell>> inventoryFilterCell in InventoryFilterCells)
		{
			FilterType filterType = inventoryFilterCell.Key;
			foreach (KeyValuePair<int, InventoryFilterCell> _item in inventoryFilterCell.Value)
			{
				_item.Value.onValueChanged.RemoveAllListeners();
				_item.Value.onValueChanged.AddListener((bool isSelect) =>
				{
					OnClickInventoryFilterCell(filterType, _item.Value.Value, isSelect);
				});
			}
		}
	}

	public void RefreshEquipSuitFilter()
	{
		ClearEquipSuitItem();
		if (!filterDic.TryGetValue(FilterType.Suit, out var _))
		{
			filterDic.Add(FilterType.Suit, ListPool<int>.Get());
			return;
		}
		for (int i = 0; i < filterDic[FilterType.Suit].Count; i++)
		{
			int key = filterDic[FilterType.Suit][i];
			GameObject gameObject = UnityEngine.Object.Instantiate(EquipSuitItem.gameObject, Suitparent);
			gameObject.SetActive(value: true);
			InventoryEquipSuitItem inventoryEquipSuitItem = gameObject.GetComponent<InventoryEquipSuitItem>();
			inventoryEquipSuitItem.Station = monoInventoryView.Station;
			inventoryEquipSuitItem.OnToggleValueChanged = null;
			inventoryEquipSuitItem.SuitData = RuntimeConfigs.data.equipSuitDatas[key];
			inventoryEquipSuitItem.toggle.SetIsOn(val: true);
			InventoryEquipSuitItem inventoryEquipSuitItem2 = inventoryEquipSuitItem;
			inventoryEquipSuitItem2.OnToggleValueChanged = (UnityAction<bool>)Delegate.Combine(inventoryEquipSuitItem2.OnToggleValueChanged, (UnityAction<bool>)((bool arg0) =>
			{
				inventoryEquipSuitItem.toggle.SetIsOnWithoutNotify(val: true);
				OnClickAddSuitButtonHandle();
				Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Bag/Click");
			}));
			InventoryEquipSuitItems.Add(inventoryEquipSuitItem);
		}
	}

	private void RefreshFilterState(FilterType filterType)
	{
		if (((inventoryTab == InventoryTab.Equip) ? EquipFilterCommonIds : DiskFilterCommonIds).TryGetValue(filterType, out var value))
		{
			for (int i = 0; i < InventoryFilterCells[filterType].Count; i++)
			{
				InventoryFilterCells[filterType][i].UpdateName(id: (i == 0) ? value.Item2 : value.Item3, table: LocalizationUtility.localizeTableName_Common);
			}
			if (FilterTitleName.TryGetValue(filterType, out var value2) && value.Item1 != 0)
			{
				value2.SetTable(LocalizationUtility.localizeTableName_Common);
				value2.StringReference.TableEntryReference = value.Item1;
			}
		}
		if (filterDic.ContainsKey(filterType))
		{
			List<int> list = filterDic[filterType];
			{
				foreach (KeyValuePair<int, InventoryFilterCell> item in InventoryFilterCells[filterType])
				{
					item.Value.SetIsOn(list.Contains(item.Key));
				}
				return;
			}
		}
		foreach (KeyValuePair<int, InventoryFilterCell> item2 in InventoryFilterCells[filterType])
		{
			item2.Value.SetIsOn(val: false);
		}
	}

	private void OnClickInventoryFilterCell(FilterType filterType, int value, bool isSelect)
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Bag/Click");
		if (!filterDic.ContainsKey(filterType))
		{
			filterDic.Add(filterType, ListPool<int>.Get());
		}
		List<int> list = filterDic[filterType];
		if (isSelect)
		{
			if (filterType != FilterType.Quality)
			{
				for (int i = 0; i < list.Count; i++)
				{
					InventoryFilterCells[filterType][list[i]].SetIsOn(val: false);
				}
				list.Clear();
			}
			list.Add(value);
		}
		else
		{
			list.Remove(value);
		}
	}
}
