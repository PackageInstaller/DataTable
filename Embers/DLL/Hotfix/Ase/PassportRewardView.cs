using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class PassportRewardView : UGuiView
{
	[SerializeField]
	private LoopGridView passportLevelItemList;

	[SerializeField]
	private PassportLevelItem passportLevelItem;

	[SerializeField]
	private Button btnGetAllReward;

	[SerializeField]
	private Button btnBuyPassport;

	[SerializeField]
	private TextMeshProUGUI btnBuyPassportText;

	[SerializeField]
	private GameObject buyPassportObj;

	[SerializeField]
	private GameObject buyPassportTipObj;

	[SerializeField]
	private GameObject btnGetAllRewardObj;

	[SerializeField]
	private RollingView rollingView;

	private PassportRewardViewModel viewModel;

	private int lastValue;

	public void Init(PassportRewardViewModel viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<PassportRewardView, PassportRewardViewModel> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind(btnBuyPassport).For((Button v) => v.onClick).To((PassportRewardViewModel vm) => vm.OpenPassportWindow);
		bindingSet.Bind<TextMeshProUGUI>(btnBuyPassportText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PassportRewardViewModel vm) => vm.BuyPassportText);
		bindingSet.Bind(buyPassportObj).For((GameObject v) => v.activeSelf).To((PassportRewardViewModel vm) => vm.BuyPassport);
		bindingSet.Bind(buyPassportTipObj).For((GameObject v) => v.activeSelf).To((PassportRewardViewModel vm) => vm.BuyPassportTip);
		bindingSet.Bind(btnGetAllReward).For((Button v) => v.onClick).To((PassportRewardViewModel vm) => vm.BtnGetAllRewardCmd);
		bindingSet.Bind(btnGetAllRewardObj).For((GameObject v) => v.activeSelf).To((PassportRewardViewModel vm) => vm.ShowGetAllReward);
		bindingSet.Bind(this).For((PassportRewardView v) => v.RefreshImportItem).To((PassportRewardViewModel vm) => vm.RefreshImportItemRequest);
		bindingSet.Build();
		passportLevelItemList.InitGridView(viewModel.PassportLevelItemDataList.Count, OnLevelItemByIndex);
		passportLevelItem.Init(viewModel.ImportLevelItemData);
		InitRollingView();
	}

	private void RefreshImportItem(object sender, InteractionEventArgs args)
	{
		passportLevelItem.RefreshLevelData(viewModel.ImportLevelItemData);
	}

	protected override void OnVisibilityChanged()
	{
		base.OnVisibilityChanged();
		if (viewModel?.PassportInfo != null)
		{
			lastValue = 0;
			int itemIndex = ((viewModel.PassportInfo.Level != 0) ? (viewModel.PassportInfo.Level - 1) : 0);
			passportLevelItemList.MovePanelToItemByIndex(itemIndex);
			FixSpecialItem();
		}
	}

	private void InitRollingView()
	{
		List<string> list = new List<string>();
		DRWeaponShow[] allDataRow = GameEntry.DataTable.GetAllDataRow<DRWeaponShow>();
		foreach (DRWeaponShow dRWeaponShow in allDataRow)
		{
			DRWeapon dataRow = GameEntry.DataTable.GetDataRow<DRWeapon>(dRWeaponShow.Id);
			if (dataRow != null)
			{
				list.Add(dataRow.Icon);
			}
		}
		rollingView.Init(new RollingViewModel(null, list, 1, 2, 0, 1f, "PassportWindow"));
	}

	private void Update()
	{
		FixSpecialItem();
	}

	private void FixSpecialItem()
	{
		float value = passportLevelItemList.ScrollRect.horizontalScrollbar.value;
		int num = (int)Math.Round((float)viewModel.PassportLevelItemDataList.Count * value);
		if (value >= 0f && num != lastValue)
		{
			lastValue = num;
			viewModel.SetImportItem(lastValue, needFix: true);
		}
	}

	private LoopGridViewItem OnLevelItemByIndex(LoopGridView arg1, int index, int row, int column)
	{
		PassportLevelItemData passportLevelItemData = viewModel.PassportLevelItemDataList[index];
		if (passportLevelItemData == null)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = passportLevelItemList.NewListViewItem("LevelItem");
		PassportLevelItem component = loopGridViewItem.GetComponent<PassportLevelItem>();
		if (!loopGridViewItem.IsInitHandlerCalled)
		{
			loopGridViewItem.IsInitHandlerCalled = true;
			component.Init(passportLevelItemData);
		}
		else
		{
			component.RefreshLevelData(passportLevelItemData);
		}
		return loopGridViewItem;
	}
}
