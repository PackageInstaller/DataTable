using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ActivityChallengeView : ActivityViewBase
{
	public TextMeshProUGUI activityDesc;

	public GameObject gotoRed;

	public Button btnOpenMain;

	public LoopListView2 rewardList;

	public LoopListView2 openTimeList;

	private ActivityChallengeViewModel viewModel;

	public override void Init(ActivityViewModelBase viewModel)
	{
		this.viewModel = (ActivityChallengeViewModel)viewModel;
		base.Init(viewModel);
		BindingSet<ActivityChallengeView, ActivityChallengeViewModel> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind(this).For((ActivityChallengeView v) => v.OnVisibleChanged).To((ActivityChallengeViewModel vm) => vm.VisibleRequest);
		bindingSet.Bind<TextMeshProUGUI>(activityDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ActivityChallengeViewModel vm) => vm.ActivityDesc);
		bindingSet.Bind(btnOpenMain).For((Button v) => v.onClick).To((ActivityChallengeViewModel vm) => vm.OptCommand)
			.CommandParameter("OpenChallengeMain");
		bindingSet.Bind(gotoRed).For((GameObject v) => v.activeSelf).To((ActivityChallengeViewModel vm) => vm.Red);
		bindingSet.Bind().For((ActivityChallengeView v) => v.OnOpt).To((ActivityChallengeViewModel vm) => vm.OptRequest);
		bindingSet.Build();
		this.viewModel.CreateTimeDura();
		rewardList.InitListView(this.viewModel.RewardItemViewModels.Count, OnGetRewardItemByIndex);
		openTimeList.InitListView(this.viewModel.OpenTimeItemViewModels.Count, OnGetTimeItemByIndex);
	}

	private void OnOpt(object sender, InteractionEventArgs e)
	{
		string optName = (string)e.Context;
		SettleOpt(optName);
	}

	private void SettleOpt(string optName)
	{
	}

	private LoopListViewItem2 OnGetRewardItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.RewardItemViewModels.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = null;
		loopListViewItem = (viewModel.RewardItemViewModels[index].IsLock ? listView2.NewListViewItem("MailAttachmentItemFirst") : ((!string.IsNullOrEmpty(viewModel.RewardItemViewModels[index].CountRange)) ? listView2.NewListViewItem("MailAttachmentItemNormal") : listView2.NewListViewItem("MailAttachmentItemNoBar")));
		if (loopListViewItem != null)
		{
			ReceiveItemView component = loopListViewItem.GetComponent<ReceiveItemView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.RewardItemViewModels[index]);
			}
			else
			{
				component.RefreshData(viewModel.RewardItemViewModels[index]);
			}
		}
		return loopListViewItem;
	}

	private LoopListViewItem2 OnGetTimeItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.OpenTimeItemViewModels.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("OpenTimeItem");
		if (loopListViewItem != null)
		{
			loopListViewItem.GetComponent<TimeDuraValidView>().Init(viewModel.OpenTimeItemViewModels[index]);
		}
		return loopListViewItem;
	}

	protected override void OnDestroy()
	{
		if (viewModel != null)
		{
			viewModel.RemoveTimeDura();
		}
		base.OnDestroy();
	}
}
