using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HomelandUpgradeView : UGuiView
{
	public TextMeshProUGUI levelOld;

	public TextMeshProUGUI levelNew;

	public TextMeshProUGUI conditionText;

	public Button btnUpgrade;

	public Button btnClose1;

	public Button btnClose2;

	public GameObject disableGo;

	public LoopListView2 materialList;

	public TextMeshProUGUI coinNeed;

	public TextMeshProUGUI coinMax;

	public List<string> coinColor;

	private HomelandUpgradeViewModel viewModel;

	protected override void OnInit(object userData)
	{
		if (viewModel != null)
		{
			RefreshData(userData);
			return;
		}
		viewModel = GetUserData<HomelandUpgradeViewModel>(userData);
		BindingSet<HomelandUpgradeView, HomelandUpgradeViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind<TextMeshProUGUI>(levelOld).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((HomelandUpgradeViewModel vm) => $"{vm.LevelOld}");
		bindingSet.Bind<TextMeshProUGUI>(levelNew).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((HomelandUpgradeViewModel vm) => $"{vm.LevelNew}");
		bindingSet.Bind<TextMeshProUGUI>(conditionText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((HomelandUpgradeViewModel vm) => string.Format("<color={0}>传火等级达到{1}级</color>", vm.IsLackLevel ? "#FF8A7A" : "#DAD2CD", vm.ConditionLevel));
		bindingSet.Bind(disableGo).For((GameObject v) => v.activeSelf).ToExpression((HomelandUpgradeViewModel vm) => !vm.EnableUpgrade);
		bindingSet.Bind(btnClose1).For((Button v) => v.onClick).To((HomelandUpgradeViewModel vm) => vm.OptCommand)
			.CommandParameter("OnClose");
		bindingSet.Bind(btnClose2).For((Button v) => v.onClick).To((HomelandUpgradeViewModel vm) => vm.OptCommand)
			.CommandParameter("OnClose");
		bindingSet.Bind(btnUpgrade).For((Button v) => v.onClick).To((HomelandUpgradeViewModel vm) => vm.OptCommand)
			.CommandParameter("OnUpgradeLevel");
		bindingSet.Bind().For((HomelandUpgradeView v) => v.UpdateMaterial).To((HomelandUpgradeViewModel vm) => vm.UpdateMaterialRequest);
		bindingSet.Bind<TextMeshProUGUI>(coinNeed).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((HomelandUpgradeViewModel vm) => vm.IsLackGold ? $"<color=#{coinColor[0]}>{vm.CoinDataAmount}</color>" : $"<color=#{coinColor[1]}>{vm.CoinDataAmount}</color>");
		bindingSet.Bind<TextMeshProUGUI>(coinMax).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((HomelandUpgradeViewModel vm) => $"/{vm.CoinNeed}");
		bindingSet.Build();
		UpdateMaterial(null, null);
	}

	public override void RefreshData(object userData)
	{
		base.RefreshData(userData);
		HomelandUpgradeViewModel userData2 = GetUserData<HomelandUpgradeViewModel>(userData);
		if (viewModel != userData2)
		{
			viewModel = userData2;
			this.SetDataContext(viewModel);
		}
		UpdateMaterial(null, null);
	}

	private void UpdateMaterial(object sender, InteractionEventArgs e)
	{
		if (materialList.IsInited)
		{
			materialList.ChangeArrangeType((viewModel.MaterialItemDatas.Count > 3) ? ListItemArrangeType.LeftToRight : ListItemArrangeType.LeftToRight_Center);
			materialList.SetListItemCount(viewModel.MaterialItemDatas.Count);
			materialList.RefreshAllShownItem();
		}
		else
		{
			materialList.ArrangeType = ((viewModel.MaterialItemDatas.Count > 3) ? ListItemArrangeType.LeftToRight : ListItemArrangeType.LeftToRight_Center);
			materialList.InitListView(viewModel.MaterialItemDatas.Count, OnGetMaterialItemByIndex);
		}
	}

	private LoopListViewItem2 OnGetMaterialItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.MaterialItemDatas.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("CastingMaterialItem");
		if (loopListViewItem != null)
		{
			CastingMaterialItem component = loopListViewItem.GetComponent<CastingMaterialItem>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.MaterialItemDatas[index]);
			}
			else
			{
				component.RefreshData(viewModel.MaterialItemDatas[index]);
			}
		}
		return loopListViewItem;
	}
}
