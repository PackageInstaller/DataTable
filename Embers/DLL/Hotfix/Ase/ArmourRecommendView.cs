using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ArmourRecommendView : UGuiView
{
	[Header("Hero")]
	public LoadUISprite heroPortrait;

	public TextMeshProUGUI txtHeroName;

	public Image weaponIcon;

	public Image attrIcon;

	[Header("Recommend")]
	public LoopListView2 recommendAttrList;

	public LoopListView2 recommendEntryList;

	public EntryInfoView entryInfoView;

	public Vector2 entryInfoPos;

	[Header("Button")]
	public Button btnQuickFilter;

	public Button btnQuickFilterWithoutOtherEntry;

	public Button btnBack;

	public Button btnBack2;

	private ArmourRecommendViewModel viewModel;

	private bool recommendAttrListInited;

	private bool recommendEntryListInited;

	private bool entryInfoViewInited;

	protected override void OnInit(object userData)
	{
		viewModel = GetUserData<ArmourRecommendViewModel>(userData);
		if (viewModel == null)
		{
			return;
		}
		BindingSet<ArmourRecommendView, ArmourRecommendViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(heroPortrait).For((LoadUISprite v) => v.Path).To((ArmourRecommendViewModel vm) => vm.HeroPortraitPath);
		bindingSet.Bind<TextMeshProUGUI>(txtHeroName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ArmourRecommendViewModel vm) => vm.HeroName);
		bindingSet.Bind(weaponIcon).For((Image v) => v.sprite).ToExpression((ArmourRecommendViewModel vm) => $"Icon_{vm.Weapon.ToString()}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(attrIcon).For((Image v) => v.sprite).ToExpression((ArmourRecommendViewModel vm) => $"hero_attr_{(int)vm.Attribute}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(btnQuickFilter).For((Button v) => v.onClick).To((ArmourRecommendViewModel vm) => vm.OptCmd)
			.CommandParameter("QuickFilter");
		if (btnQuickFilterWithoutOtherEntry != null)
		{
			bindingSet.Bind(btnQuickFilterWithoutOtherEntry).For((Button v) => v.onClick).To((ArmourRecommendViewModel vm) => vm.OptCmd)
				.CommandParameter("QuickFilterWithoutOtherEntry");
		}
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((ArmourRecommendViewModel vm) => vm.OptCmd)
			.CommandParameter("Back");
		bindingSet.Bind(btnBack2).For((Button v) => v.onClick).To((ArmourRecommendViewModel vm) => vm.OptCmd)
			.CommandParameter("Back");
		bindingSet.Bind(this).For((ArmourRecommendView v) => v.OnOpt).To((ArmourRecommendViewModel vm) => vm.OptRequest);
		bindingSet.Bind(this).For((ArmourRecommendView v) => v.ShowEntryDetail).To((ArmourRecommendViewModel vm) => vm.ShowEntryDetailRequest);
		bindingSet.Bind(this).For((ArmourRecommendView v) => v.HideEntryDetail).To((ArmourRecommendViewModel vm) => vm.HideEntryDetailRequest);
		bindingSet.Build();
		if (entryInfoView != null && !entryInfoViewInited)
		{
			entryInfoView.Init();
			entryInfoView.gameObject.SetActive(value: false);
			entryInfoViewInited = true;
		}
		if (recommendAttrList != null && !recommendAttrListInited)
		{
			recommendAttrList.InitListView(viewModel.RecommendAttrList.Count, OnGetRecommendAttrItem);
			recommendAttrListInited = true;
		}
		else if (recommendAttrList != null)
		{
			recommendAttrList.SetListItemCount(viewModel.RecommendAttrList.Count);
			recommendAttrList.RefreshAllShownItem();
		}
		if (recommendEntryList != null && !recommendEntryListInited)
		{
			recommendEntryList.InitListView(viewModel.RecommendEntryList.Count, OnGetRecommendEntryItem);
			recommendEntryListInited = true;
		}
		else if (recommendEntryList != null)
		{
			recommendEntryList.SetListItemCount(viewModel.RecommendEntryList.Count);
			recommendEntryList.RefreshAllShownItem();
		}
	}

	public override void RefreshData(object userData)
	{
		base.RefreshData(userData);
		viewModel = GetUserData<ArmourRecommendViewModel>(userData);
		this.SetDataContext(viewModel);
		RefreshRecommendLists();
	}

	public override void AfterOpenView()
	{
		base.AfterOpenView();
		if (this.GetDataContext() is ArmourRecommendViewModel armourRecommendViewModel)
		{
			viewModel = armourRecommendViewModel;
		}
		RefreshRecommendLists();
	}

	private void RefreshRecommendLists()
	{
		if (viewModel != null)
		{
			if (recommendAttrList != null)
			{
				recommendAttrList.SetListItemCount(viewModel.RecommendAttrList.Count);
				recommendAttrList.RefreshAllShownItem();
			}
			if (recommendEntryList != null)
			{
				recommendEntryList.SetListItemCount(viewModel.RecommendEntryList.Count);
				recommendEntryList.RefreshAllShownItem();
			}
		}
	}

	private LoopListViewItem2 OnGetRecommendAttrItem(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.RecommendAttrList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("StatusAttrItem");
		if (loopListViewItem == null)
		{
			return null;
		}
		StatusAttrItemView component = loopListViewItem.GetComponent<StatusAttrItemView>();
		if (!loopListViewItem.IsInitHandlerCalled)
		{
			loopListViewItem.IsInitHandlerCalled = true;
			component.Init(viewModel.RecommendAttrList[index]);
		}
		else
		{
			component.RefreshData(viewModel.RecommendAttrList[index]);
		}
		return loopListViewItem;
	}

	private LoopListViewItem2 OnGetRecommendEntryItem(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.RecommendEntryList.Count)
		{
			return null;
		}
		string itemPrefabName = (viewModel.RecommendEntryList[index].IsMainEntry ? "MainEntryItem" : "EntryItem");
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem(itemPrefabName);
		if (loopListViewItem == null)
		{
			return null;
		}
		EntryItem component = loopListViewItem.GetComponent<EntryItem>();
		if (!loopListViewItem.IsInitHandlerCalled)
		{
			loopListViewItem.IsInitHandlerCalled = true;
			component.Init(viewModel.RecommendEntryList[index]);
		}
		else
		{
			component.RefreshEntryItemData(viewModel.RecommendEntryList[index]);
		}
		component.SetOnClickAction(ShowEntryDetailDirect);
		return loopListViewItem;
	}

	private void ShowEntryDetailDirect(EntryItem entryItem)
	{
		EntryItemData entryItemData = entryItem?.ViewModel;
		if (!(entryInfoView == null) && entryItemData != null)
		{
			entryInfoView.Show(entryItemData, null, !entryItemData.IsMainEntry);
		}
	}

	private void ShowEntryDetail(object sender, InteractionEventArgs e)
	{
		EntryItemData entryItemData = e.Context as EntryItemData;
		if (!(entryInfoView == null) && entryItemData != null)
		{
			entryInfoView.Show(entryItemData, null, !entryItemData.IsMainEntry);
		}
	}

	private void HideEntryDetail(object sender, InteractionEventArgs e)
	{
		entryInfoView?.Hide();
	}

	private void OnOpt(object sender, InteractionEventArgs e)
	{
		string value = (string)e.Context;
		if ("RefreshRecommendList".Equals(value))
		{
			RefreshRecommendLists();
		}
	}
}
