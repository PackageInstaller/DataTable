using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class BuyPassportLevelWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private Button btnAddProp;

	[SerializeField]
	private Button btnReduceProp;

	[SerializeField]
	private TextMeshProUGUI addLevel;

	[SerializeField]
	private TextMeshProUGUI tip;

	[SerializeField]
	private TextMeshProUGUI cost;

	[SerializeField]
	private LoopGridView rewardList;

	[SerializeField]
	private Button btnConfirm;

	[SerializeField]
	private MoneyView moneyView;

	private BuyPassportLevelViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<BuyPassportLevelViewModel>();
		BindingSet<BuyPassportLevelWindow, BuyPassportLevelViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((BuyPassportLevelViewModel vm) => vm.Close);
		bindingSet.Bind(this).For((BuyPassportLevelWindow v) => v.OpenUguiWindow).To((BuyPassportLevelViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((BuyPassportLevelWindow v) => v.CloseWindow).To((BuyPassportLevelViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(btnAddProp).For((Button v) => v.onClick).To((BuyPassportLevelViewModel vm) => vm.AddLevelCmd);
		bindingSet.Bind(btnReduceProp).For((Button v) => v.onClick).To((BuyPassportLevelViewModel vm) => vm.ReduceLevelCmd);
		bindingSet.Bind<TextMeshProUGUI>(cost).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((BuyPassportLevelViewModel vm) => vm.Cost);
		bindingSet.Bind<TextMeshProUGUI>(tip).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((BuyPassportLevelViewModel vm) => vm.Tip);
		bindingSet.Bind<TextMeshProUGUI>(addLevel).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((BuyPassportLevelViewModel vm) => vm.AddLevel);
		bindingSet.Bind(btnConfirm).For((Button v) => v.onClick).To((BuyPassportLevelViewModel vm) => vm.ConfirmCmd);
		bindingSet.Bind(this).For((BuyPassportLevelWindow v) => v.RefreshReward).To((BuyPassportLevelViewModel vm) => vm.RefreshRewardListRequest);
		bindingSet.Build();
		rewardList.InitGridView(viewModel.RewardList.Count, OnGetRewardItemByIndex);
		moneyView.Init(new MoneyViewModel(viewModel));
	}

	private void RefreshReward(object sender, InteractionEventArgs e)
	{
		rewardList.SetListItemCount(viewModel.RewardList.Count);
		rewardList.RefreshAllShownItem();
	}

	private LoopGridViewItem OnGetRewardItemByIndex(LoopGridView arg1, int index, int row, int column)
	{
		PassportRewardItemData passportRewardItemData = viewModel.RewardList[index];
		if (passportRewardItemData == null)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = rewardList.NewListViewItem("PassportItem");
		PassportRewardItem component = loopGridViewItem.GetComponent<PassportRewardItem>();
		if (!loopGridViewItem.IsInitHandlerCalled)
		{
			loopGridViewItem.IsInitHandlerCalled = true;
			component.Init(passportRewardItemData);
		}
		else
		{
			component.RefreshPassRewardItemData(passportRewardItemData);
		}
		return loopGridViewItem;
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		Dismiss();
	}
}
