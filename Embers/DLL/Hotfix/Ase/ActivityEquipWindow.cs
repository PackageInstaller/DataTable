#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Linq.Expressions;
using GameFramework;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ActivityEquipWindow : UGuiWindowBase
{
	public Image bgImg;

	public Button btnBack;

	public TextMeshProUGUI activityTime;

	public TextMeshProUGUI bossName;

	public GameObject GoIsFirst;

	public Button btnOpenMulti;

	public CopyItemDetail1View detailView;

	public LoopListView2 heroItemList;

	public ShowInfoItem showInfoItem;

	public TextMeshProUGUI buffDesc;

	private string bgImgPath;

	private ActivityEquipViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<ActivityEquipViewModel>();
		BindingSet<ActivityEquipWindow, ActivityEquipViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((ActivityEquipWindow v) => v.OnDismissRequest).To((ActivityEquipViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((ActivityEquipWindow v) => v.OpenUguiWindow).To((ActivityEquipViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind().For((ActivityEquipWindow v) => v.SetChildViewVisibility).To((ActivityEquipViewModel vm) => vm.ShowViewRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((ActivityEquipViewModel vm) => vm.CloseWindow);
		bindingSet.Bind<TextMeshProUGUI>(buffDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ActivityEquipViewModel vm) => vm.BuffDesc);
		bindingSet.Bind<TextMeshProUGUI>(activityTime).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ActivityEquipViewModel vm) => vm.ActivityTimeText2);
		bindingSet.Bind<TextMeshProUGUI>(bossName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ActivityEquipViewModel vm) => vm.BossName);
		bindingSet.Bind(GoIsFirst).For((GameObject v) => v.activeSelf).To((ActivityEquipViewModel vm) => vm.IsFirst);
		bindingSet.Bind(detailView).For((CopyItemDetail1View v) => v.ViewModel).To((ActivityEquipViewModel vm) => vm.DetailViewModel);
		bindingSet.Bind(this).For((ActivityEquipWindow v) => v.OnOpt).To((ActivityEquipViewModel vm) => vm.OptRequest);
		bindingSet.Bind(btnOpenMulti).For((Button v) => v.onClick).To((ActivityEquipViewModel vm) => vm.OptCommand)
			.CommandParameter("OnMulti");
		bindingSet.Build();
		showInfoItem.Init();
		heroItemList.InitListView(viewModel.HeroEquipItemViewModels.Count, OnGetHeroItemByIndex);
	}

	protected override async void OnShow()
	{
		try
		{
			if (viewModel.BgSprite != null)
			{
				bgImg.sprite = viewModel.BgSprite;
			}
			else
			{
				bgImgPath = ActivityEquipBgIdMapper.GetBgAssetPath(viewModel.ActivityTypeId);
				Image component = (await GameEntry.Resource.LoadAssetAsync<GameObject>(bgImgPath)).GetComponent<Image>();
				bgImg.sprite = component.sprite;
			}
			bgImg.color = new Color(1f, 1f, 1f, 1f);
		}
		catch (Exception ex)
		{
			Log.Error("加载资源发生异常 " + ex.Message + " / " + ex.StackTrace);
		}
		base.OnShow();
	}

	private void OnOpt(object sender, InteractionEventArgs e)
	{
		string optName = (string)e.Context;
		SettleOpt(optName);
	}

	private void SettleOpt(string optName)
	{
		if ("OnDayRefresh".Equals(optName))
		{
			heroItemList.SetListItemCount(viewModel.HeroEquipItemViewModels.Count);
			heroItemList.RefreshAllShownItem();
		}
	}

	private LoopListViewItem2 OnGetHeroItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.HeroEquipItemViewModels.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("HeroItem");
		if (loopListViewItem != null)
		{
			loopListViewItem.GetComponent<HeroEquipItem>().Init(viewModel.HeroEquipItemViewModels[index]);
		}
		return loopListViewItem;
	}

	protected override void OnDestroy()
	{
		bgImg.sprite = null;
		if (!string.IsNullOrEmpty(bgImgPath))
		{
			GameEntry.Resource.UnloadAsset(bgImgPath);
		}
		base.OnDestroy();
	}
}
