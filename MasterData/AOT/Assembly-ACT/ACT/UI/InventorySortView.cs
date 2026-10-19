using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.Utility;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization;

namespace ACT.UI;

public class InventorySortView : BaseUIComponent
{
	public RectTransform PropertyParent;

	public InventorySortCell PropertyCell;

	public Dictionary<SortType, List<InventorySortCell>> InventorySortCells;

	public ActButton ConfirmButton;

	private MonoInventoryView monoInventoryView;

	private Dictionary<SortType, List<int>> equipSortDic;

	private Dictionary<SortType, List<int>> oriEquipSortDic;

	private const int MaxPropetySortCount = 3;

	public void OnClickConfirmBtnHandle()
	{
		Model<InventoryModel>.Interface.CopyDictionary(equipSortDic, oriEquipSortDic);
		monoInventoryView.OnSort(oriEquipSortDic);
		Close();
	}

	public void Close()
	{
		gameObject.SetActive(value: false);
		for (int i = 0; i < InventorySortCells[SortType.Propety].Count; i++)
		{
			Object.Destroy(InventorySortCells[SortType.Propety][i].gameObject);
		}
		InventorySortCells[SortType.Propety].Clear();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Bag/Window_Close");
	}

	public void RefreshUI(MonoInventoryView monoInventoryView, Dictionary<SortType, List<int>> oriEquipSortDic)
	{
		this.monoInventoryView = monoInventoryView;
		this.oriEquipSortDic = oriEquipSortDic;
		equipSortDic = DictionaryPool<SortType, List<int>>.Get();
		Model<InventoryModel>.Interface.CopyDictionary(oriEquipSortDic, equipSortDic);
		ConfirmButton.SetBtnClick(OnClickConfirmBtnHandle);
		List<PropertyData> list = ListPool<PropertyData>.Get();
		foreach (KeyValuePair<int, PropertyData> propertyData2 in RuntimeConfigs.data.propertyDatas)
		{
			if (propertyData2.Value.sort != 0)
			{
				list.Add(propertyData2.Value);
			}
		}
		list.Sort((PropertyData l, PropertyData r) => l.sort - r.sort);
		if (!equipSortDic.TryGetValue(SortType.Propety, out var value))
		{
			equipSortDic.Add(SortType.Propety, ListPool<int>.Get());
		}
		for (int num = 0; num < list.Count; num++)
		{
			PropertyData propertyData = list[num];
			GameObject gameObject = Object.Instantiate(PropertyCell.gameObject, PropertyParent);
			gameObject.SetActive(value: true);
			InventorySortCell sortCell = gameObject.GetComponent<InventorySortCell>();
			sortCell.ResetIndex(num);
			sortCell.PropertyID = propertyData.id;
			sortCell.optionName.SetTable("shortcommon");
			sortCell.optionName.StringReference.TableEntryReference = propertyData.descLocal;
			sortCell.SetIsOn(equipSortDic[SortType.Propety].Contains(propertyData.id));
			sortCell.onValueChanged.RemoveAllListeners();
			sortCell.onValueChanged.AddListener((bool isOn) =>
			{
				OnClickInventorySortCell(SortType.Propety, isOn, sortCell);
			});
			InventorySortCells[SortType.Propety].Add(sortCell);
		}
		RefreshPropetyCellIndex();
		foreach (KeyValuePair<SortType, List<InventorySortCell>> item in InventorySortCells)
		{
			if (item.Key == SortType.Propety)
			{
				continue;
			}
			if (!equipSortDic.TryGetValue(item.Key, out value))
			{
				equipSortDic.Add(item.Key, ListPool<int>.Get());
			}
			List<InventorySortCell> value2 = item.Value;
			for (int num2 = 0; num2 < value2.Count; num2++)
			{
				InventorySortCell inventorySortCell = value2[num2];
				inventorySortCell.PropertyID = num2;
				inventorySortCell.SetIsOn(equipSortDic[item.Key].Contains(num2));
				inventorySortCell.onValueChanged.RemoveAllListeners();
				inventorySortCell.onValueChanged.AddListener((bool isOn) =>
				{
					OnClickInventorySortCell(item.Key, isOn, inventorySortCell);
				});
			}
		}
	}

	private void RefreshPropetyCellIndex()
	{
		for (int i = 0; i < equipSortDic[SortType.Propety].Count; i++)
		{
			int num = equipSortDic[SortType.Propety][i];
			foreach (InventorySortCell item in InventorySortCells[SortType.Propety])
			{
				if (item.PropertyID == num)
				{
					item.Priority = i + 1;
					break;
				}
			}
		}
	}

	public void OnClickInventorySortCell(SortType sortType, bool isOn, InventorySortCell inventorySortCell)
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Bag/Click");
		if (!equipSortDic.TryGetValue(sortType, out var value))
		{
			value = ListPool<int>.Get();
		}
		if (sortType == SortType.Propety)
		{
			if (isOn)
			{
				if (equipSortDic[SortType.Propety].Count >= 3)
				{
					GameUtility.OpenToolTip(LocalizationCommonData.CommonString.PropertyMaxCount);
					inventorySortCell.SetIsOn(val: false);
				}
				else
				{
					equipSortDic[SortType.Propety].Add(inventorySortCell.PropertyID);
					RefreshPropetyCellIndex();
				}
			}
			else
			{
				inventorySortCell.Priority = 0;
				equipSortDic[SortType.Propety].Remove(inventorySortCell.PropertyID);
				RefreshPropetyCellIndex();
			}
		}
		else if (isOn)
		{
			if (equipSortDic[sortType][0] != inventorySortCell.PropertyID)
			{
				int index = ((value.Count > 0) ? value[0] : (-1));
				equipSortDic[sortType].Clear();
				equipSortDic[sortType].Add(inventorySortCell.PropertyID);
				InventorySortCells[sortType][index].SetIsOn(val: false);
			}
		}
		else if (equipSortDic[sortType][0] == inventorySortCell.PropertyID)
		{
			InventorySortCells[sortType][0].SetIsOn(val: true);
		}
	}
}
