using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class CopySecondType3MultiView : UGuiView
{
	public Button btnBack;

	public Button btnEnter;

	public Button btnRank;

	public LoopListView2 copyItemList;

	public LoopListView2 rewardList;

	public LoopListView2 attributeList;

	public GameObject firstItem;

	public LoadUISprite icon;

	public TextMeshProUGUI nameText;

	public TextMeshProUGUI desc;

	public TextMeshProUGUI score;

	public TextMeshProUGUI entryCountDesc;

	public TextMeshProUGUI entryCount;

	public TextMeshProUGUI timeLeft;

	[SerializeField]
	private List<int> teamTagPropIds = new List<int>();

	private CopySecondType3ViewModel viewModel;

	public CopySecondType3ViewModel ViewModel
	{
		get
		{
			return viewModel;
		}
		set
		{
			if (viewModel == null)
			{
				OnInit(value);
			}
			else
			{
				RefreshData(value);
			}
		}
	}

	protected override void OnInit(object userData)
	{
		if (viewModel != null)
		{
			RefreshData(userData);
			return;
		}
		viewModel = GetUserData<CopySecondType3ViewModel>(userData);
		viewModel.SetTeamTagPropIds(teamTagPropIds);
		BindingSet<CopySecondType3MultiView, CopySecondType3ViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((CopySecondType3MultiView v) => v.OnOpt).To((CopySecondType3ViewModel vm) => vm.OptRequest);
		bindingSet.Bind(icon).For((LoadUISprite v) => v.Path).ToExpression((CopySecondType3ViewModel vm) => $"{vm.CurBossIconPath}/{vm.CurBossIcon}");
		bindingSet.Bind<TextMeshProUGUI>(nameText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CopySecondType3ViewModel vm) => vm.CurBossNameAndLv);
		if ((UnityEngine.Object)(object)desc != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(desc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CopySecondType3ViewModel vm) => vm.CurCopyDesc);
		}
		bindingSet.Bind<TextMeshProUGUI>(timeLeft).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CopySecondType3ViewModel vm) => vm.TimeLeft);
		bindingSet.Bind<TextMeshProUGUI>(score).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CopySecondType3ViewModel vm) => vm.Score);
		if ((UnityEngine.Object)(object)entryCountDesc != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(entryCountDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CopySecondType3ViewModel vm) => vm.EntryCountDesc);
			bindingSet.Bind<TextMeshProUGUI>(entryCountDesc).For((Expression<Func<TextMeshProUGUI, Color>>)((TextMeshProUGUI v) => ((Graphic)v).color)).To((CopySecondType3ViewModel vm) => vm.EntryCountColor);
		}
		bindingSet.Bind<TextMeshProUGUI>(entryCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CopySecondType3ViewModel vm) => vm.EntryCountText);
		bindingSet.Bind<TextMeshProUGUI>(entryCount).For((Expression<Func<TextMeshProUGUI, Color>>)((TextMeshProUGUI v) => ((Graphic)v).color)).To((CopySecondType3ViewModel vm) => vm.EntryCountColor);
		bindingSet.Bind(firstItem).For((GameObject v) => v.activeSelf).To((CopySecondType3ViewModel vm) => vm.ShowFirstItem);
		bindingSet.Bind(btnEnter).For((Button v) => v.onClick).To((CopySecondType3ViewModel vm) => vm.OptCommand)
			.CommandParameter("OnMulti");
		bindingSet.Bind(btnRank).For((Button v) => v.onClick).To((CopySecondType3ViewModel vm) => vm.OptCommand)
			.CommandParameter("OnRank");
		bindingSet.Build();
		copyItemList.InitListView(viewModel.CopyItemVms.Count, OnGetCopyItemItemByIndex);
		if (rewardList != null)
		{
			rewardList.InitListView(viewModel.RewardItems.Count, OnGetRewardItemByIndex);
		}
		if (attributeList != null)
		{
			attributeList.InitListView(viewModel.AdItemList.Count, OnGetAttributeItemByIndex);
		}
		btnBack.onClick.RemoveAllListeners();
		btnBack.onClick.AddListener(delegate
		{
			viewModel.SwitchPage(CopyType3Page.Entry);
		});
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<CopySecondType3ViewModel>(userData);
		viewModel.SetTeamTagPropIds(teamTagPropIds);
		this.SetDataContext(viewModel);
		copyItemList.SetListItemCount(viewModel.CopyItemVms.Count);
		copyItemList.RefreshAllShownItem();
		if (rewardList != null)
		{
			rewardList.SetListItemCount(viewModel.RewardItems.Count);
			rewardList.RefreshAllShownItem();
		}
		if (attributeList != null)
		{
			attributeList.SetListItemCount(viewModel.AdItemList.Count);
			attributeList.RefreshAllShownItem();
		}
	}

	private void OnOpt(object sender, InteractionEventArgs e)
	{
		string value = (string)e.Context;
		if ("RefreshCopy".Equals(value))
		{
			copyItemList.SetListItemCount(viewModel.CopyItemVms.Count);
			copyItemList.RefreshAllShownItem();
			if (rewardList != null)
			{
				rewardList.SetListItemCount(viewModel.RewardItems.Count);
				rewardList.RefreshAllShownItem();
			}
			if (attributeList != null)
			{
				attributeList.SetListItemCount(viewModel.AdItemList.Count);
				attributeList.RefreshAllShownItem();
			}
		}
	}

	private LoopListViewItem2 OnGetCopyItemItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.CopyItemVms.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("CopyItem3View");
		if (loopListViewItem != null)
		{
			CopyItem3View component = loopListViewItem.GetComponent<CopyItem3View>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.CopyItemVms[index]);
			}
			else
			{
				component.RefreshData(viewModel.CopyItemVms[index]);
			}
		}
		return loopListViewItem;
	}

	private LoopListViewItem2 OnGetRewardItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.RewardItems.Count)
		{
			return null;
		}
		ReceiveItemViewModel receiveItemViewModel = viewModel.RewardItems[index];
		LoopListViewItem2 loopListViewItem = (receiveItemViewModel.IsLock ? listView2.NewListViewItem("MailAttachmentItemFirst") : ((!string.IsNullOrEmpty(receiveItemViewModel.CountRange)) ? listView2.NewListViewItem("MailAttachmentItemNormal") : listView2.NewListViewItem("MailAttachmentItemNoBar")));
		if (loopListViewItem != null)
		{
			ReceiveItemView component = loopListViewItem.GetComponent<ReceiveItemView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(receiveItemViewModel);
			}
			else
			{
				component.RefreshData(receiveItemViewModel);
			}
		}
		return loopListViewItem;
	}

	private LoopListViewItem2 OnGetAttributeItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.AdItemList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("AttriItem");
		if (loopListViewItem != null)
		{
			CopyBuffItemView component = loopListViewItem.GetComponent<CopyBuffItemView>();
			component.Init();
			component.SetIcon(viewModel.AdItemList[index]);
		}
		return loopListViewItem;
	}
}
