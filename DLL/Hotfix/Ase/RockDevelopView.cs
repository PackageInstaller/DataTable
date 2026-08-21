using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class RockDevelopView : UGuiView
{
	[SerializeField]
	private MoneyView MoneyView;

	[SerializeField]
	private Button gamePlayDetailBtn;

	[SerializeField]
	private Button heroAllEntryBtn;

	[SerializeField]
	private Button rockDetailBtn;

	[SerializeField]
	private Button developBtn;

	[SerializeField]
	private TextMeshProUGUI developBtnText;

	[SerializeField]
	private Image costMaterialIcon;

	[SerializeField]
	private TextMeshProUGUI costMaterialText;

	[SerializeField]
	private TextMeshProUGUI costCoinText;

	[SerializeField]
	private List<TabItemNormal> materialItemList;

	[SerializeField]
	private LoopListView2 resultItemList;

	[SerializeField]
	private Image rockImg;

	[SerializeField]
	private Image rockRankImg;

	[SerializeField]
	private TextMeshProUGUI rockRankText;

	[SerializeField]
	private Image rockEntryImg;

	[SerializeField]
	private TextMeshProUGUI entryNumText;

	[SerializeField]
	private TextMeshProUGUI entryLevelText;

	[SerializeField]
	private GameObject resultInfoObj;

	[SerializeField]
	private RockPopupView rockPopupView;

	[SerializeField]
	private GameObject rockPopupViewObj;

	[SerializeField]
	private List<GameObject> effectList;

	private RockDevelopViewModel viewModel;

	public void Init(RockDevelopViewModel viewModel)
	{
		this.viewModel = viewModel;
		Init((object)this.viewModel);
		BindingSet<RockDevelopView, RockDevelopViewModel> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind(this).For((RockDevelopView v) => v.OpenWindow).To((RockDevelopViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(rockDetailBtn).For((Button v) => v.onClick).To((RockDevelopViewModel vm) => vm.OpenRockDetailView);
		bindingSet.Bind(gamePlayDetailBtn).For((Button v) => v.onClick).To((RockDevelopViewModel vm) => vm.GamePlayCmd);
		bindingSet.Bind(heroAllEntryBtn).For((Button v) => v.onClick).To((RockDevelopViewModel vm) => vm.HeroAllEntryDetailCmd);
		bindingSet.Bind(developBtn).For((Button v) => v.onClick).To((RockDevelopViewModel vm) => vm.DevelopCmd);
		bindingSet.Bind<TextMeshProUGUI>(developBtnText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((RockDevelopViewModel vm) => vm.DevelopText);
		if (costMaterialIcon != null)
		{
			bindingSet.Bind(costMaterialIcon).For((Image v) => v.sprite).ToExpression((RockDevelopViewModel vm) => vm.CostMaterialIcon)
				.WithConversion("ItemIcon");
		}
		if ((UnityEngine.Object)(object)costMaterialText != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(costMaterialText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((RockDevelopViewModel vm) => vm.CostMaterialText);
		}
		bindingSet.Bind<TextMeshProUGUI>(costCoinText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((RockDevelopViewModel vm) => vm.CostCoinText);
		bindingSet.Bind(rockImg).For((Image v) => v.sprite).ToExpression((RockDevelopViewModel vm) => vm.ArmourData.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(rockEntryImg).For((Image v) => v.sprite).ToExpression((RockDevelopViewModel vm) => vm.EntryImgPath)
			.WithConversion("ItemIcon");
		bindingSet.Bind(rockRankImg).For((Image v) => v.color).To((RockDevelopViewModel vm) => vm.RankBgColor);
		bindingSet.Bind<TextMeshProUGUI>(rockRankText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((RockDevelopViewModel vm) => $"R{vm.ArmourData.Rank}");
		bindingSet.Bind(this).For((RockDevelopView v) => v.RefreshResult).To((RockDevelopViewModel vm) => vm.RefreshRockResultRequest);
		bindingSet.Bind(this).For((RockDevelopView v) => v.CloseEffect).To((RockDevelopViewModel vm) => vm.CloseEffectRequest);
		bindingSet.Bind(resultInfoObj).For((GameObject v) => v.activeSelf).To((RockDevelopViewModel vm) => vm.ShowResultInfo);
		bindingSet.Bind<TextMeshProUGUI>(entryNumText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((RockDevelopViewModel vm) => vm.EntryNumText);
		bindingSet.Bind<TextMeshProUGUI>(entryLevelText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((RockDevelopViewModel vm) => vm.EntryLevelMaxText);
		bindingSet.Bind(rockPopupViewObj).For((GameObject v) => v.activeSelf).To((RockDevelopViewModel vm) => vm.ShowPopup);
		bindingSet.Build();
		MoneyView.Init(new MoneyViewModel(viewModel.Parent));
		resultItemList.InitListView(viewModel.RockResultItemDataList.Count, OnGetResultItemByIndex);
		rockPopupView.Init(viewModel.RockPopupViewModel);
		for (int num = 0; num < materialItemList.Count; num++)
		{
			materialItemList[num].Init(viewModel.RockMaterialList[num]);
		}
		heroAllEntryBtn.gameObject.SetActive(viewModel.ArmourData.GetOwnerId() != 0);
	}

	private void RefreshResult(object sender, InteractionEventArgs e)
	{
		resultItemList.SetListItemCount(viewModel.RockResultItemDataList.Count);
		resultItemList.RefreshAllShownItem();
		if (effectList.Count == viewModel.RockMaterialList.Count && effectList.Count >= 3)
		{
			effectList[0].gameObject.SetActive(viewModel.RockMaterialList[0].IsSelected);
			effectList[1].gameObject.SetActive(viewModel.RockMaterialList[1].IsSelected);
			effectList[2].gameObject.SetActive(viewModel.RockMaterialList[2].IsSelected);
		}
	}

	private void CloseEffect(object sender, InteractionEventArgs e)
	{
		foreach (GameObject effect in effectList)
		{
			effect.gameObject.SetActive(value: false);
		}
	}

	private LoopListViewItem2 OnGetResultItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.RockResultItemDataList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = ((viewModel.RockResultItemDataList[index].Type == 1) ? listView2.NewListViewItem("ResultIItem") : listView2.NewListViewItem("TextItem"));
		if (loopListViewItem != null)
		{
			RockResultItem component = loopListViewItem.GetComponent<RockResultItem>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.RockResultItemDataList[index]);
			}
			else
			{
				component.RefreshResultData(viewModel.RockResultItemDataList[index]);
			}
		}
		return loopListViewItem;
	}

	private async void OpenWindow(object sender, InteractionEventArgs args)
	{
		Action callback = args.Callback;
		OpenViewArg openViewArg = (OpenViewArg)args.Context;
		_ = openViewArg.Path;
		try
		{
			ViewConfig[] viewConfigs = ViewConfigSetting.GetViewConfigs((ViewConfig p) => p.ViewClass.Equals(openViewArg.ViewName));
			if (viewConfigs == null || viewConfigs.Length == 0)
			{
				throw new Exception("找不到类型" + openViewArg.ViewName + " 的视图路径");
			}
			string viewPath = viewConfigs[0].ViewPath;
			UGuiWindow w = await GameEntry.UI.OpenWindow<UGuiWindow>(viewPath, openViewArg.UiGroupName, openViewArg.UserData);
			if (w != null)
			{
				w.OnDismissed += Handler;
			}
			void Handler(object window, EventArgs e)
			{
				w.OnDismissed -= Handler;
				callback?.Invoke();
			}
		}
		catch (Exception value)
		{
			Console.WriteLine(value);
			throw;
		}
	}
}
