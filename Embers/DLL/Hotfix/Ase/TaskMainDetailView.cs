using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class TaskMainDetailView : UGuiView
{
	[SerializeField]
	private GameObject icon1;

	[SerializeField]
	private GameObject icon2;

	[SerializeField]
	private Button btn;

	[SerializeField]
	private TextMeshProUGUI title;

	[SerializeField]
	private TextMeshProUGUI location1;

	[SerializeField]
	private TextMeshProUGUI location2;

	[SerializeField]
	private TextMeshProUGUI desc;

	[SerializeField]
	private StateItem stateItem;

	[SerializeField]
	private StateItem timeStateItem;

	[SerializeField]
	private TextMeshProUGUI lockText;

	[SerializeField]
	private TextMeshProUGUI timeLockText;

	[SerializeField]
	private LoopListView2 progressList;

	[SerializeField]
	private TextMeshProUGUI occupyText;

	[SerializeField]
	private LoopListView2 rewardList;

	private bool isInit;

	private TaskMainDetailViewModel viewModel;

	public bool IsInit => isInit;

	public void Init(TaskMainDetailViewModel viewModel)
	{
		isInit = true;
		this.viewModel = viewModel;
		BindingSet<TaskMainDetailView, TaskMainDetailViewModel> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind(this).For((TaskMainDetailView v) => v.UpdateTaskInfo).To((TaskMainDetailViewModel vm) => vm.UpdateTaskInfoRequest);
		bindingSet.Bind(btn.gameObject).For((GameObject v) => v.activeSelf).ToExpression((TaskMainDetailViewModel vm) => vm.Data.TaskExtra == 1);
		bindingSet.Bind(btn).For((Button v) => v.onClick).To((TaskMainDetailViewModel vm) => vm.ShowImg);
		bindingSet.Bind(icon2.gameObject).For((GameObject v) => v.activeSelf).ToExpression((TaskMainDetailViewModel vm) => vm.Data.TaskExtra == 1);
		bindingSet.Bind(icon1.gameObject).For((GameObject v) => v.activeSelf).ToExpression((TaskMainDetailViewModel vm) => vm.Data.TaskExtra != 1);
		bindingSet.Bind<TextMeshProUGUI>(title).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TaskMainDetailViewModel vm) => vm.Data.Name);
		bindingSet.Bind<TextMeshProUGUI>(desc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TaskMainDetailViewModel vm) => vm.Desc);
		bindingSet.Bind<TextMeshProUGUI>(location1).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TaskMainDetailViewModel vm) => vm.LocationName1);
		bindingSet.Bind<TextMeshProUGUI>(location2).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TaskMainDetailViewModel vm) => vm.LocationName2);
		bindingSet.Bind(stateItem).For((StateItem v) => v.CurState).To((TaskMainDetailViewModel vm) => vm.Data.TaskState);
		bindingSet.Bind(timeStateItem).For((StateItem v) => v.CurState).To((TaskMainDetailViewModel vm) => vm.Data.TimeLockState);
		bindingSet.Bind<TextMeshProUGUI>(timeLockText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TaskMainDetailViewModel vm) => vm.TimeLockText);
		bindingSet.Bind<TextMeshProUGUI>(lockText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TaskMainDetailViewModel vm) => vm.LockText);
		bindingSet.Bind<TextMeshProUGUI>(occupyText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TaskMainDetailViewModel vm) => vm.OccupyText);
		bindingSet.Build();
		rewardList.InitListView(viewModel.RewardList.Count, OnGetRewardItemByIndex);
		progressList.InitListView(viewModel.TargetTextList.Count, OnGetProgressTextItemByIndex);
	}

	private void UpdateTaskInfo(object sender, InteractionEventArgs e)
	{
		rewardList.SetListItemCount(viewModel.RewardList.Count);
		rewardList.RefreshAllShownItem();
		if (viewModel.Data.TaskState == 0)
		{
			progressList.SetListItemCount(viewModel.TargetTextList.Count);
			progressList.RefreshAllShownItem();
		}
	}

	public void RefreshData(TaskMainDetailViewModel viewModel)
	{
		this.SetDataContext(viewModel);
	}

	private LoopListViewItem2 OnGetRewardItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.RewardList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("PropMiddleItem");
		if (loopListViewItem != null)
		{
			KnapsackItemNew component = loopListViewItem.GetComponent<KnapsackItemNew>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.RewardList[index]);
			}
			else
			{
				component.RefreshData(viewModel.RewardList[index]);
			}
		}
		return loopListViewItem;
	}

	private LoopListViewItem2 OnGetProgressTextItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.TargetTextList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = null;
		loopListViewItem = ((!viewModel.TargetTextList[index].isFinish) ? listView2.NewListViewItem("ProgressItem") : listView2.NewListViewItem("ProgressItemComplete"));
		if (loopListViewItem != null)
		{
			((TMP_Text)loopListViewItem.transform.GetChild(0).GetComponent<TextMeshProUGUI>()).text = viewModel.TargetTextList[index].text;
			Button btn = loopListViewItem.transform.GetComponent<Button>();
			if (btn != null)
			{
				btn.onClick.RemoveAllListeners();
				btn.onClick.AddListener(delegate
				{
					viewModel.TargetTextList[index].OnClick();
					btn.GetComponent<UIAudioPlayer>()?.AudioInvoke();
				});
			}
		}
		return loopListViewItem;
	}
}
