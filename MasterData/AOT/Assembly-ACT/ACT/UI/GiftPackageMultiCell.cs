using System.Collections.Generic;
using ACT.Core;
using ACT.Game.Data;
using ACT.Utility;
using Bamboo.NumberString;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class GiftPackageMultiCell : LoopScrollBaseItem
{
	public ActButton selfBtn;

	public GameObject select;

	public LocalizeStringEvent giftItemName;

	public GameObject disableMask;

	public GameObject giftItemCanChooseCountRoot;

	public LocalizeStringEvent giftItemCanChooseCountDes;

	public TextMeshProUGUI itemHasCount;

	public ItemUIComponentBase itemCell;

	public PopupMultiBoxView parentView;

	private const int CANCHOOSECOUNT = 2837;

	public bool curSelectedState { get; private set; }

	public PackageMultiCellData data { get; private set; }

	public override void Init(object param)
	{
		base.Init(param);
		if (param is PackageMultiCellData { itemData: not null } packageMultiCellData)
		{
			data = packageMultiCellData;
			RefreshDisPlay(packageMultiCellData.itemData, packageMultiCellData.canChooseCount);
		}
	}

	private void RefreshDisPlay(Item cellItem, int canChooseCount)
	{
		SetSelectedState(state: false);
		selfBtn.SetBtnClick(() =>
		{
			if ((object)parentView != null && parentView.selectItemIndex != index)
			{
				parentView.SetCurSelectItem(cellItem);
				parentView.DisableLastCellSelectedState();
				parentView.selectItemIndex = index;
				SetSelectedState(state: true);
				parentView.RefreshDisPlayOnSelectCell(cellItem);
				parentView.RefreshOnSelectNumText();
			}
		});
		disableMask?.SetActive(canChooseCount == 0);
		giftItemCanChooseCountRoot?.SetActive(canChooseCount != -1);
		if (canChooseCount != -1)
		{
			string text = ((canChooseCount == 0) ? "#FF7272" : "#ffffff");
			string item = "<color=" + text + ">" + canChooseCount.FastToString() + "</color>";
			string localizeString = LocalizationUtility.GetLocalizeString("Common", 2837, new List<object> { item });
			giftItemCanChooseCountDes?.OnUpdateString.Invoke(localizeString);
		}
		giftItemName.SetTable("shortcommon");
		giftItemName.StringReference.TableEntryReference = RuntimeConfigs.data.itemDatas[cellItem.Id].nameLocal;
		itemHasCount.SetText(cellItem.Count.FastToString());
		itemCell.SetData(cellItem, 0L);
		itemCell.UpdatePerformance();
	}

	public void SetSelectedState(bool state)
	{
		curSelectedState = state;
		select.SetActive(state);
	}
}
