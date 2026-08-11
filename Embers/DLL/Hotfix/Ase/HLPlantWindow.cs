using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HLPlantWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private Button btnGamePlay;

	[SerializeField]
	private GameObject seedsViewObj;

	[SerializeField]
	private LoopGridView seedsList;

	[SerializeField]
	private Button confirmBtn;

	[SerializeField]
	private TextMeshProUGUI confirmText;

	[SerializeField]
	private TextMeshProUGUI seedUseTimeText;

	[SerializeField]
	private List<HLPlantItem> HlPlantItemDataList;

	[SerializeField]
	private Button btnGetAllPlant;

	[SerializeField]
	private GameObject btnGetAllPlantObj;

	[SerializeField]
	private Animator animator;

	private HLPlantViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<HLPlantViewModel>();
		BindingSet<HLPlantWindow, HLPlantViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((HLPlantWindow v) => v.CloseWindow).To((HLPlantViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((HLPlantWindow v) => v.OpenUguiWindow).To((HLPlantViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((HLPlantViewModel vm) => vm.BtnBackOnClick);
		bindingSet.Bind(btnGamePlay).For((Button v) => v.onClick).To((HLPlantViewModel vm) => vm.OpenGamePlayWindow);
		bindingSet.Bind(confirmBtn).For((Button v) => v.onClick).To((HLPlantViewModel vm) => vm.ConfirmSeedCmd);
		bindingSet.Bind(btnGetAllPlant).For((Button v) => v.onClick).To((HLPlantViewModel vm) => vm.GetAllPlantCmd);
		bindingSet.Bind(btnGetAllPlantObj).For((GameObject v) => v.activeSelf).ToExpression((HLPlantViewModel vm) => !vm.ShowSeedView);
		bindingSet.Bind<TextMeshProUGUI>(confirmText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HLPlantViewModel vm) => vm.ConfirmText);
		bindingSet.Bind<TextMeshProUGUI>(seedUseTimeText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HLPlantViewModel vm) => vm.SeedUseTimeText);
		bindingSet.Bind(seedsViewObj).For((GameObject v) => v.activeSelf).To((HLPlantViewModel vm) => vm.ShowSeedView);
		bindingSet.Bind(this).For((HLPlantWindow v) => v.PlayAnimation).To((HLPlantViewModel vm) => vm.PlayAnimationRequest);
		bindingSet.Build();
		LoadPlantItem();
		seedsList.InitGridView(viewModel.HlSeedItemDataList.Count, OnGetSeedItemByIndex);
	}

	private void LoadPlantItem()
	{
		for (int i = 0; i < viewModel.HlPlantItemDataList.Count; i++)
		{
			HlPlantItemDataList[i].Init(viewModel.HlPlantItemDataList[i]);
		}
	}

	private void PlayAnimation(object sender, InteractionEventArgs e)
	{
		string text = (viewModel.ShowSeedView ? "Small" : "Big");
		animator.SetTrigger(Animator.StringToHash(text));
	}

	private LoopGridViewItem OnGetSeedItemByIndex(LoopGridView arg1, int index, int row, int column)
	{
		HLSeedItemData hLSeedItemData = viewModel.HlSeedItemDataList[index];
		if (hLSeedItemData == null)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = seedsList.NewListViewItem("SeedItem");
		HLSeedItem component = loopGridViewItem.GetComponent<HLSeedItem>();
		if (!loopGridViewItem.IsInitHandlerCalled)
		{
			loopGridViewItem.IsInitHandlerCalled = true;
			component.Init(hLSeedItemData);
		}
		else
		{
			component.RefreshSeedData(hLSeedItemData);
		}
		return loopGridViewItem;
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		Dismiss();
	}
}
