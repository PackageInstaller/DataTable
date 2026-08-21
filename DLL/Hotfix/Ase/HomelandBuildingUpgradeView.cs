using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HomelandBuildingUpgradeView : UGuiView
{
	public TextMeshProUGUI conditionText;

	public Button btnUpgrade;

	public Button btnClose1;

	public Button btnClose2;

	public GameObject disableGo;

	public LoopGridView effectList;

	public LoopListView2 materialList;

	public TextMeshProUGUI coinNeed;

	public TextMeshProUGUI coinMax;

	public List<string> coinColor;

	private HomelandBuildingItemViewModel viewModel;

	protected override void OnInit(object userData)
	{
		if (userData == null)
		{
			return;
		}
		if (viewModel != null)
		{
			RefreshData(userData);
			return;
		}
		viewModel = GetUserData<HomelandBuildingItemViewModel>(userData);
		BindingSet<HomelandBuildingUpgradeView, HomelandBuildingItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind<TextMeshProUGUI>(conditionText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((HomelandBuildingItemViewModel vm) => string.Format("<color={0}>原初之灯达到{1}级</color>", (vm.Data.UpgradeNeedHomelandlevel > vm.HomelandLevel) ? "#FF8A7A" : "#DAD2CD", vm.Data.UpgradeNeedHomelandlevel));
		bindingSet.Bind(disableGo).For((GameObject v) => v.activeSelf).ToExpression((HomelandBuildingItemViewModel vm) => !vm.Data.IsRed);
		bindingSet.Bind(btnClose1).For((Button v) => v.onClick).To((HomelandBuildingItemViewModel vm) => vm.OptCommand)
			.CommandParameter("OnClose");
		bindingSet.Bind(btnClose2).For((Button v) => v.onClick).To((HomelandBuildingItemViewModel vm) => vm.OptCommand)
			.CommandParameter("OnClose");
		bindingSet.Bind(btnUpgrade).For((Button v) => v.onClick).To((HomelandBuildingItemViewModel vm) => vm.OptCommand)
			.CommandParameter("OnBuildingUpgrade");
		bindingSet.Bind().For((HomelandBuildingUpgradeView v) => v.UpdateMaterial).To((HomelandBuildingItemViewModel vm) => vm.UpdateMaterialRequest);
		bindingSet.Bind<TextMeshProUGUI>(coinNeed).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((HomelandBuildingItemViewModel vm) => (vm.HomelandCoin < vm.CoinNeed) ? $"<color=#{coinColor[0]}>{vm.HomelandCoin}</color>" : $"<color=#{coinColor[1]}>{vm.HomelandCoin}</color>");
		bindingSet.Bind<TextMeshProUGUI>(coinMax).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((HomelandBuildingItemViewModel vm) => $"/{vm.CoinNeed}");
		bindingSet.Build();
		UpdateMaterial(null, null);
	}

	public override void RefreshData(object userData)
	{
		if (userData != null)
		{
			base.RefreshData(userData);
			viewModel = GetUserData<HomelandBuildingItemViewModel>(userData);
			this.SetDataContext(viewModel);
			UpdateMaterial(null, null);
		}
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
		if (effectList.MListViewInited)
		{
			effectList.SetListItemCount(viewModel.EffectItemVms.Count);
			effectList.RefreshAllShownItem();
		}
		else
		{
			effectList.InitGridView(viewModel.EffectItemVms.Count, OnGetEffectItemByIndex);
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

	private LoopGridViewItem OnGetEffectItemByIndex(LoopGridView gridView, int index, int row, int column)
	{
		if (index < 0 || index >= viewModel.EffectItemVms.Count)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = gridView.NewListViewItem("BuildingEffectItemView");
		if (loopGridViewItem != null)
		{
			BuildingEffectItemView component = loopGridViewItem.GetComponent<BuildingEffectItemView>();
			if (!loopGridViewItem.IsInitHandlerCalled)
			{
				loopGridViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.EffectItemVms[index]);
			}
			else
			{
				component.RefreshData(viewModel.EffectItemVms[index]);
			}
		}
		return loopGridViewItem;
	}
}
