using System.Collections.Generic;
using System.Text;
using ACT.Core;
using ACT.Model;
using ACT.Model.EquipSuit;
using ACT.Utility;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class InventoryFilterComp : MonoBehaviour
{
	[SerializeField]
	private CanvasGroup _canvasGroup;

	[SerializeField]
	private TextMeshProUGUI _text;

	private StringBuilder _stringBuilder = new StringBuilder();

	private void Awake()
	{
		Model<InventoryModel>.Interface.UpdateFilterCompAction += RefreshComp;
	}

	private void OnDestroy()
	{
		Model<InventoryModel>.Interface.UpdateFilterCompAction -= RefreshComp;
	}

	public void RefreshComp(Dictionary<FilterType, List<int>> filterDic)
	{
		bool flag = HasAnyFilter(filterDic);
		SetVisible(flag);
		if (flag)
		{
			UpdateFilterText(filterDic);
		}
	}

	private void SetVisible(bool visible)
	{
		if (!(_canvasGroup == null))
		{
			_canvasGroup.alpha = (visible ? 1f : 0f);
			_canvasGroup.interactable = visible;
			_canvasGroup.blocksRaycasts = visible;
		}
	}

	private bool HasAnyFilter(Dictionary<FilterType, List<int>> filterDic)
	{
		if (filterDic == null)
		{
			return false;
		}
		foreach (KeyValuePair<FilterType, List<int>> item in filterDic)
		{
			if (item.Value != null && item.Value.Count > 0)
			{
				return true;
			}
		}
		return false;
	}

	private void UpdateFilterText(Dictionary<FilterType, List<int>> filterDic)
	{
		_stringBuilder.Clear();
		_stringBuilder.Append(LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 300));
		foreach (KeyValuePair<FilterType, List<int>> item in filterDic)
		{
			if (item.Value != null && item.Value.Count > 0)
			{
				AppendFilterValues(item);
			}
		}
		_text.text = _stringBuilder.ToString();
		LayoutRebuilder.ForceRebuildLayoutImmediate(_text.rectTransform);
	}

	private void AppendFilterValues(KeyValuePair<FilterType, List<int>> filter)
	{
		switch (filter.Key)
		{
		case FilterType.Suit:
		{
			for (int j = 0; j < filter.Value.Count; j++)
			{
				int localizationName = EquipSuit.GetLocalizationName(filter.Value[j]);
				string localizeString2 = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, localizationName);
				_stringBuilder.Append("/").Append(localizeString2);
			}
			break;
		}
		case FilterType.LockState:
		{
			for (int l = 0; l < filter.Value.Count; l++)
			{
				int localizeId3 = ((filter.Value[l] == 0) ? 2311 : 2312);
				string localizeString4 = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, localizeId3);
				_stringBuilder.Append("/").Append(localizeString4);
			}
			break;
		}
		case FilterType.Quality:
		{
			for (int m = 0; m < filter.Value.Count; m++)
			{
				int localizeId4 = CoreUtils.GetData(filter.Value[m], RuntimeConfigs.data.itemQualitys).name;
				string localizeString5 = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, localizeId4);
				_stringBuilder.Append("/").Append(localizeString5);
			}
			break;
		}
		case FilterType.LevelState:
		{
			for (int k = 0; k < filter.Value.Count; k++)
			{
				int localizeId2 = ((filter.Value[k] == 0) ? 2315 : 2316);
				string localizeString3 = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, localizeId2);
				_stringBuilder.Append("/").Append(localizeString3);
			}
			break;
		}
		case FilterType.EquipedState:
		{
			for (int i = 0; i < filter.Value.Count; i++)
			{
				int num = filter.Value[i];
				int localizeId = 0;
				if (Model<InventoryModel>.Interface.InventoryTab == InventoryTab.Equip)
				{
					localizeId = ((num == 0) ? 2318 : 2319);
				}
				else if (Model<InventoryModel>.Interface.InventoryTab == InventoryTab.Disk)
				{
					localizeId = ((num == 0) ? 2336 : 2337);
				}
				string localizeString = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, localizeId);
				_stringBuilder.Append("/").Append(localizeString);
			}
			break;
		}
		}
	}

	public void Hide()
	{
		SetVisible(visible: false);
	}
}
