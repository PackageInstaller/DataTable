using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using Spine.Unity;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class SailStateView : UGuiView
{
	[SerializeField]
	private GameObject readyState;

	[SerializeField]
	private GameObject sailingState;

	[SerializeField]
	private GameObject finishState;

	[SerializeField]
	private List<SailHeroItem> selectHeroList;

	[SerializeField]
	private Image sliderFillImg;

	[SerializeField]
	private Image sliderColor;

	[SerializeField]
	private TextMeshProUGUI successText;

	[SerializeField]
	private TextMeshProUGUI sailingLefetTimeText;

	[SerializeField]
	private LoopListView2 sailingHeroList;

	[SerializeField]
	private LoopListView2 finishHeroList;

	[SerializeField]
	private LoopGridView heroItemList;

	[SerializeField]
	private GameObject heroItemListObj;

	[SerializeField]
	private Button btnConfirm;

	[SerializeField]
	private Button btnHide;

	[SerializeField]
	private SkeletonGraphic balloonSkeletonGraphic;

	private SailStateViewModel viewModel;

	public void Init(SailStateViewModel viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<SailStateView, SailStateViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(readyState).For((GameObject v) => v.activeSelf).ToExpression((SailStateViewModel vm) => vm.State == 2);
		bindingSet.Bind(sailingState).For((GameObject v) => v.activeSelf).ToExpression((SailStateViewModel vm) => vm.State == 3);
		bindingSet.Bind(finishState).For((GameObject v) => v.activeSelf).ToExpression((SailStateViewModel vm) => vm.State == 1);
		bindingSet.Bind(sliderFillImg).For((Image v) => v.fillAmount).To((SailStateViewModel vm) => vm.Fill);
		bindingSet.Bind(sliderColor).For((Image v) => v.color).To((SailStateViewModel vm) => vm.Color);
		bindingSet.Bind<TextMeshProUGUI>(successText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((SailStateViewModel vm) => vm.SuccessText);
		bindingSet.Bind<TextMeshProUGUI>(sailingLefetTimeText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((SailStateViewModel vm) => vm.LeftTimeText);
		bindingSet.Bind(heroItemListObj).For((GameObject v) => v.activeSelf).To((SailStateViewModel vm) => vm.ShowHeroItemList);
		bindingSet.Bind(btnConfirm).For((Button v) => v.onClick).To((SailStateViewModel vm) => vm.Confirm);
		bindingSet.Bind(btnHide).For((Button v) => v.onClick).To((SailStateViewModel vm) => vm.HideHeroItemList);
		bindingSet.Bind(this).For((SailStateView v) => v.RefreshHeroItem).To((SailStateViewModel vm) => vm.SelectHeroRequest);
		bindingSet.Bind(this).For((SailStateView v) => v.RefreshHeroItemList).To((SailStateViewModel vm) => vm.RefreshHeroItemRequest);
		bindingSet.Bind(this).For((SailStateView v) => v.PlaySailAnimation).To((SailStateViewModel vm) => vm.PlayAnimationRequest);
		bindingSet.Bind(this).For((SailStateView v) => v.StopSailAnimation).To((SailStateViewModel vm) => vm.StopAnimationRequest);
		bindingSet.Build();
		InitSelectHeroList();
		heroItemList.InitGridView(viewModel.HeroItemViewModelList.Count, OnGetItemByIndex);
		sailingHeroList.InitListView(viewModel.SailHeroItemList.Count, OnGetHeroItemByIndex);
		finishHeroList.InitListView(viewModel.SailHeroItemList.Count, OnGetHeroItemByIndex);
		balloonSkeletonGraphic.AnimationState.SetAnimation(0, "HomeLand_SailLight", loop: false);
	}

	public async void PlaySailAnimation(object sender, InteractionEventArgs args)
	{
		balloonSkeletonGraphic.AnimationState.SetAnimation(0, "HomeLand_SailLight_Fly", loop: false);
		balloonSkeletonGraphic.AnimationState.Complete += delegate
		{
			viewModel.AnimationFinish();
			balloonSkeletonGraphic.AnimationState.SetAnimation(0, "HomeLand_SailLight", loop: false);
		};
	}

	public async void StopSailAnimation(object sender, InteractionEventArgs args)
	{
		balloonSkeletonGraphic.AnimationState.SetAnimation(0, "HomeLand_SailLight", loop: false);
	}

	private void InitSelectHeroList()
	{
		if (selectHeroList.Count == viewModel.HeroItemList.Count)
		{
			for (int i = 0; i < selectHeroList.Count; i++)
			{
				selectHeroList[i].Init(viewModel.HeroItemList[i]);
			}
		}
	}

	private void RefreshHeroItemList(object sender, InteractionEventArgs e)
	{
		heroItemList.SetListItemCount(viewModel.HeroItemViewModelList.Count);
		heroItemList.RefreshAllShownItem();
	}

	private void RefreshHeroItem(object sender, InteractionEventArgs e)
	{
		if (viewModel.State == 2)
		{
			if (selectHeroList.Count == viewModel.HeroItemList.Count)
			{
				for (int i = 0; i < selectHeroList.Count; i++)
				{
					selectHeroList[i].Init(viewModel.HeroItemList[i]);
				}
			}
		}
		else if (viewModel.State == 3)
		{
			sailingHeroList.SetListItemCount(viewModel.SailHeroItemList.Count);
			sailingHeroList.RefreshAllShownItem();
		}
		else if (viewModel.State == 1)
		{
			finishHeroList.SetListItemCount(viewModel.SailHeroItemList.Count);
			finishHeroList.RefreshAllShownItem();
		}
	}

	private LoopListViewItem2 OnGetHeroItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.SailHeroItemList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("HeroItem");
		if (loopListViewItem != null)
		{
			SailHeroItem component = loopListViewItem.GetComponent<SailHeroItem>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.SailHeroItemList[index]);
			}
			else
			{
				component.RefreshHeroData(viewModel.SailHeroItemList[index]);
			}
		}
		return loopListViewItem;
	}

	private LoopGridViewItem OnGetItemByIndex(LoopGridView arg1, int itemIndex, int row, int column)
	{
		if (itemIndex < 0 || itemIndex > viewModel.HeroItemViewModelList.Count)
		{
			return null;
		}
		HeroItemViewModel heroItemViewModel = viewModel.HeroItemViewModelList[itemIndex];
		if (heroItemViewModel == null)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = arg1.NewListViewItem("HeroItem");
		HeroItem component = loopGridViewItem.GetComponent<HeroItem>();
		if (!loopGridViewItem.IsInitHandlerCalled)
		{
			loopGridViewItem.IsInitHandlerCalled = true;
			component.Init(heroItemViewModel);
		}
		else
		{
			component.RefreshData(heroItemViewModel);
		}
		return loopGridViewItem;
	}
}
