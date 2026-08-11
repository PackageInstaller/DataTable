using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.Events;

namespace Ase;

public class StatusSettingView : UGuiView
{
	[Header("属性列表")]
	[SerializeField]
	private LoopListView2 attrList;

	[SerializeField]
	private GameObject attrArrowTop;

	[SerializeField]
	private GameObject attrArrowBottom;

	[Header("Buff 列表")]
	[SerializeField]
	private LoopListView2 buffList;

	[SerializeField]
	private GameObject buffArrowTop;

	[SerializeField]
	private GameObject buffArrowBottom;

	[Header("词条列表")]
	[SerializeField]
	private LoopListView2 entryList;

	[SerializeField]
	private GameObject entryArrowTop;

	[SerializeField]
	private GameObject entryArrowBottom;

	[SerializeField]
	private EntryInfoView entryInfoView;

	[Header("角色列表（可选）")]
	[SerializeField]
	private LoopListView2 heroList;

	[SerializeField]
	private TextMeshProUGUI heroNameText;

	[Header("标签栏")]
	[SerializeField]
	private SelectItemView attrTab;

	[SerializeField]
	private SelectItemView buffTab;

	[SerializeField]
	private GameObject attrRoot;

	[SerializeField]
	private GameObject buffEntryRoot;

	[Header("颜色配置")]
	[SerializeField]
	private Color increaseColor = Color.green;

	[SerializeField]
	private Color decreaseColor = Color.red;

	private StatusSettingViewModel viewModel;

	private bool attrArrowHooked;

	private bool buffArrowHooked;

	private bool entryArrowHooked;

	private const float ArrowEpsilon = 1f;

	protected override void OnInit(object userData)
	{
		viewModel = GetUserData<StatusSettingViewModel>(userData);
		this.SetDataContext(viewModel);
		BindingSet<StatusSettingView, StatusSettingViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((StatusSettingView v) => v.OnOpt).To((StatusSettingViewModel vm) => vm.OptRequest);
		if ((UnityEngine.Object)(object)heroNameText != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(heroNameText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((StatusSettingViewModel vm) => vm.HeroName);
		}
		bindingSet.Build();
		attrTab?.Init(viewModel.AttrTabVm);
		buffTab?.Init(viewModel.BuffTabVm);
		entryInfoView?.Init(viewModel.EntryInfoViewModel);
		if (heroList != null && !heroList.IsInited)
		{
			heroList.InitListView(viewModel.TeamItemList.Count, OnGetHeroItemByIndex);
		}
		if (attrList != null && !attrList.IsInited)
		{
			attrList.InitListView(viewModel.AttrItems.Count, OnGetAttrItemByIndex);
		}
		HookArrowListener(attrList, ref attrArrowHooked, UpdateAttrArrow);
		if (buffList != null && !buffList.IsInited)
		{
			buffList.InitListView(viewModel.BuffItems.Count, OnGetBuffItemByIndex);
		}
		if (entryList != null && !entryList.IsInited)
		{
			entryList.InitListView(viewModel.EntryItems.Count, OnGetEntryItemByIndex);
		}
		HookArrowListener(buffList, ref buffArrowHooked, UpdateBuffArrow);
		HookArrowListener(entryList, ref entryArrowHooked, UpdateEntryArrow);
		SettleOpt("ShowAttr", null);
	}

	private void OnOpt(object sender, InteractionEventArgs e)
	{
		if (e?.Context is OptionArg optionArg)
		{
			SettleOpt(optionArg.OptionName, optionArg.Obj);
		}
		else if (e?.Context is string optName)
		{
			SettleOpt(optName, null);
		}
	}

	private void SettleOpt(string optName, object ctx)
	{
		switch (optName)
		{
		case "ResetScroll":
			ResetScrollToTop();
			RefreshAttributeList(viewModel?.AttrItems.Count ?? 0);
			RefreshHeroList(viewModel?.TeamItemList.Count ?? 0);
			RefreshBuffList(0);
			RefreshEntryList(0);
			SetAttributeArrows(topActive: false, bottomActive: false);
			SetBuffArrows(topActive: false, bottomActive: false);
			SetEntryArrows(topActive: false, bottomActive: false);
			break;
		case "ShowAttr":
			if (attrRoot != null)
			{
				attrRoot.SetActive(value: true);
			}
			if (buffEntryRoot != null)
			{
				buffEntryRoot.SetActive(value: false);
			}
			ResetScrollToTop();
			UpdateAttrArrow();
			break;
		case "ShowBuff":
			if (attrRoot != null)
			{
				attrRoot.SetActive(value: false);
			}
			if (buffEntryRoot != null)
			{
				buffEntryRoot.SetActive(value: true);
			}
			EnsureBuffEntryLists();
			ResetScrollToTop();
			UpdateBuffArrow();
			UpdateEntryArrow();
			break;
		case "RefreshAttr":
			OnRefreshAttr(null, null);
			break;
		case "RefreshHero":
			OnRefreshHero(null, null);
			break;
		case "RefreshBuff":
			OnRefreshBuff(null, null);
			break;
		case "RefreshEntry":
			OnRefreshEntry(null, null);
			break;
		case "ShowEntryDetail":
			ShowEntryDetail(ctx as EntryItemData);
			break;
		case "HideEntryDetail":
			HideEntryDetail();
			break;
		}
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<StatusSettingViewModel>(userData);
		this.SetDataContext(viewModel);
	}

	private void Update()
	{
		if (!((UnityEngine.Object)(object)CanvasGroup != null) || !(CanvasGroup.alpha <= 0f))
		{
			viewModel?.TickBuffRealtime();
		}
	}

	private void OnRefreshAttr(object sender, InteractionEventArgs e)
	{
		if (!(attrList == null) && viewModel != null)
		{
			if (!attrList.IsInited)
			{
				attrList.InitListView(viewModel.AttrItems.Count, OnGetAttrItemByIndex);
			}
			else
			{
				attrList.SetListItemCount(viewModel.AttrItems.Count);
				attrList.RefreshAllShownItem();
			}
			UpdateAttrArrow();
		}
	}

	private void OnRefreshHero(object sender, InteractionEventArgs e)
	{
		if (!(heroList == null) && viewModel != null)
		{
			if (!heroList.IsInited)
			{
				heroList.InitListView(viewModel.TeamItemList.Count, OnGetHeroItemByIndex);
				return;
			}
			heroList.SetListItemCount(viewModel.TeamItemList.Count);
			heroList.RefreshAllShownItem();
		}
	}

	private void OnRefreshBuff(object sender, InteractionEventArgs e)
	{
		if (!(buffList == null) && viewModel != null)
		{
			if (!buffList.IsInited)
			{
				buffList.InitListView(viewModel.BuffItems.Count, OnGetBuffItemByIndex);
			}
			else
			{
				buffList.SetListItemCount(viewModel.BuffItems.Count);
				buffList.RefreshAllShownItem();
			}
			UpdateBuffArrow();
		}
	}

	private void OnRefreshEntry(object sender, InteractionEventArgs e)
	{
		if (!(entryList == null) && viewModel != null)
		{
			if (!entryList.IsInited)
			{
				entryList.InitListView(viewModel.EntryItems.Count, OnGetEntryItemByIndex);
			}
			else
			{
				entryList.SetListItemCount(viewModel.EntryItems.Count);
				entryList.RefreshAllShownItem();
			}
			UpdateEntryArrow();
		}
	}

	private void ShowEntryDetail(EntryItemData entryItemData)
	{
		if (!(entryInfoView == null) && entryItemData != null)
		{
			entryInfoView.Show(entryItemData, null, !entryItemData.IsMainEntry);
		}
	}

	private void HideEntryDetail()
	{
	}

	public void ResetScrollToTop()
	{
		ResetList(attrList);
		ResetList(buffList);
		ResetList(entryList);
	}

	public void RefreshAttributeList(int count)
	{
		if (!(attrList == null))
		{
			attrList.SetListItemCount(count);
			attrList.RefreshAllShownItem();
		}
	}

	public void RefreshHeroList(int count)
	{
		if (!(heroList == null))
		{
			heroList.SetListItemCount(count);
			heroList.RefreshAllShownItem();
		}
	}

	public void RefreshBuffList(int count)
	{
		if (!(buffList == null))
		{
			buffList.SetListItemCount(count);
			buffList.RefreshAllShownItem();
		}
	}

	public void RefreshEntryList(int count)
	{
		if (!(entryList == null))
		{
			entryList.SetListItemCount(count);
			entryList.RefreshAllShownItem();
		}
	}

	public void SetAttributeArrows(bool topActive, bool bottomActive)
	{
		if (attrArrowTop != null)
		{
			attrArrowTop.SetActive(topActive);
		}
		if (attrArrowBottom != null)
		{
			attrArrowBottom.SetActive(bottomActive);
		}
	}

	public void SetBuffArrows(bool topActive, bool bottomActive)
	{
		if (buffArrowTop != null)
		{
			buffArrowTop.SetActive(topActive);
		}
		if (buffArrowBottom != null)
		{
			buffArrowBottom.SetActive(bottomActive);
		}
	}

	public void SetEntryArrows(bool topActive, bool bottomActive)
	{
		if (entryArrowTop != null)
		{
			entryArrowTop.SetActive(topActive);
		}
		if (entryArrowBottom != null)
		{
			entryArrowBottom.SetActive(bottomActive);
		}
	}

	private void EnsureBuffEntryLists()
	{
		if (buffList != null)
		{
			if (!buffList.IsInited)
			{
				buffList.InitListView(viewModel?.BuffItems.Count ?? 0, OnGetBuffItemByIndex);
			}
			else
			{
				RefreshBuffList(viewModel?.BuffItems.Count ?? 0);
			}
		}
		if (entryList != null)
		{
			if (!entryList.IsInited)
			{
				entryList.InitListView(viewModel?.EntryItems.Count ?? 0, OnGetEntryItemByIndex);
			}
			else
			{
				RefreshEntryList(viewModel?.EntryItems.Count ?? 0);
			}
		}
		UpdateBuffArrow();
		UpdateEntryArrow();
	}

	private void ResetList(LoopListView2 list)
	{
		if (!(list == null) && !(list.ScrollRect == null))
		{
			list.ScrollRect.normalizedPosition = new Vector2(0f, 1f);
		}
	}

	private void HookArrowListener(LoopListView2 list, ref bool hooked, UnityAction callback)
	{
		if (!((list == null || list.ScrollRect == null) | hooked))
		{
			list.ScrollRect.onValueChanged.AddListener(delegate
			{
				callback?.Invoke();
			});
			hooked = true;
		}
	}

	private void UpdateAttrArrow()
	{
		UpdateArrowForList(attrList, attrArrowTop, attrArrowBottom);
	}

	private void UpdateBuffArrow()
	{
		UpdateArrowForList(buffList, buffArrowTop, buffArrowBottom);
	}

	private void UpdateEntryArrow()
	{
		UpdateArrowForList(entryList, entryArrowTop, entryArrowBottom);
	}

	private void UpdateArrowForList(LoopListView2 list, GameObject topArrow, GameObject bottomArrow)
	{
		if (list == null || list.ScrollRect == null || list.ScrollRect.content == null)
		{
			if (topArrow != null)
			{
				topArrow.SetActive(value: false);
			}
			if (bottomArrow != null)
			{
				bottomArrow.SetActive(value: false);
			}
			return;
		}
		RectTransform rectTransform = list.ScrollRect.viewport;
		if (rectTransform == null)
		{
			rectTransform = list.ScrollRect.GetComponent<RectTransform>();
		}
		float height = rectTransform.rect.height;
		float height2 = list.ScrollRect.content.rect.height;
		float y = list.ScrollRect.content.anchoredPosition.y;
		if (height2 <= height + 1f)
		{
			if (topArrow != null)
			{
				topArrow.SetActive(value: false);
			}
			if (bottomArrow != null)
			{
				bottomArrow.SetActive(value: false);
			}
			return;
		}
		bool active = y > 1f;
		bool active2 = height2 - height - y > 1f;
		if (topArrow != null)
		{
			topArrow.SetActive(active);
		}
		if (bottomArrow != null)
		{
			bottomArrow.SetActive(active2);
		}
	}

	public LoopListViewItem2 OnGetAttrItemByIndex(LoopListView2 listView, int index)
	{
		if (viewModel == null || index < 0 || index >= viewModel.AttrItems.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView.NewListViewItem("StatusAttrItem");
		if (loopListViewItem == null)
		{
			return null;
		}
		StatusAttrItemView component = loopListViewItem.GetComponent<StatusAttrItemView>();
		if (component != null)
		{
			component.SetColors(increaseColor, decreaseColor);
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.AttrItems[index]);
			}
			else
			{
				component.RefreshData(viewModel.AttrItems[index]);
			}
		}
		return loopListViewItem;
	}

	public LoopListViewItem2 OnGetHeroItemByIndex(LoopListView2 listView, int index)
	{
		if (viewModel == null || index < 0 || index >= viewModel.TeamItemList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView.NewListViewItem("TeamItem");
		if (loopListViewItem == null)
		{
			return null;
		}
		CopyTeamItemView component = loopListViewItem.GetComponent<CopyTeamItemView>();
		if (component != null)
		{
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.TeamItemList[index]);
			}
			else
			{
				component.RefreshData(viewModel.TeamItemList[index]);
			}
			component.CurIndex = index;
		}
		return loopListViewItem;
	}

	public LoopListViewItem2 OnGetBuffItemByIndex(LoopListView2 listView, int index)
	{
		if (viewModel == null || index < 0 || index >= viewModel.BuffItems.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView.NewListViewItem("StatusBuffItem");
		if (loopListViewItem == null)
		{
			return null;
		}
		StatusBuffItemView component = loopListViewItem.GetComponent<StatusBuffItemView>();
		if (component != null)
		{
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.BuffItems[index]);
			}
			else
			{
				component.RefreshData(viewModel.BuffItems[index]);
			}
			component.ApplyHeight();
			listView.OnItemSizeChanged(index);
		}
		return loopListViewItem;
	}

	public LoopListViewItem2 OnGetEntryItemByIndex(LoopListView2 listView, int index)
	{
		if (viewModel == null || index < 0 || index >= viewModel.EntryItems.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView.NewListViewItem("EntryLevelItem");
		if (loopListViewItem == null)
		{
			return null;
		}
		EntryLevelItem component = loopListViewItem.GetComponent<EntryLevelItem>();
		if (component != null)
		{
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.InitItem(viewModel.EntryItems[index]);
			}
			else
			{
				component.RefreshEntryLevelItemData(viewModel.EntryItems[index]);
			}
		}
		return loopListViewItem;
	}
}
