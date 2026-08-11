using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ActivityTaskItem : UGuiView
{
	[SerializeField]
	private Color colorAccept;

	[SerializeField]
	private Color colorJump;

	[SerializeField]
	private Color colorNormal;

	[SerializeField]
	private Color colorFinish;

	[SerializeField]
	private GameObject redPoint;

	[SerializeField]
	private GameObject normal;

	[SerializeField]
	private GameObject normalAccept;

	[SerializeField]
	private GameObject specialNormalObj;

	[SerializeField]
	private GameObject specialAcceptObj;

	[SerializeField]
	private TextMeshProUGUI taskComplete;

	[SerializeField]
	private TextMeshProUGUI taskName;

	[SerializeField]
	private LoopListView2 rewardItemList;

	[SerializeField]
	private Button stateBtn;

	[SerializeField]
	private TextMeshProUGUI stateText;

	[SerializeField]
	private GameObject stateJump;

	[SerializeField]
	private GameObject stateComplete;

	[SerializeField]
	private GameObject stateFinish;

	[SerializeField]
	private GameObject stateNormal;

	private ActivityTaskItemData viewModel;

	public void Init(ActivityTaskItemData viewModel)
	{
		this.viewModel = viewModel;
		this.viewModel.SetTextColor(colorNormal, colorJump, colorAccept, colorFinish);
		BindingSet<ActivityTaskItem, ActivityTaskItemData> bindingSet = this.CreateBindingSet(this.viewModel);
		if (redPoint != null)
		{
			bindingSet.Bind(redPoint).For((GameObject v) => v.activeSelf).ToExpression((ActivityTaskItemData vm) => (int)vm.TaskState == 0);
		}
		if (normal != null)
		{
			bindingSet.Bind(normal).For((GameObject v) => v.activeSelf).ToExpression((ActivityTaskItemData vm) => !vm.IsPhasedActivityTask);
		}
		if (normalAccept != null)
		{
			bindingSet.Bind(normalAccept).For((GameObject v) => v.activeSelf).ToExpression((ActivityTaskItemData vm) => !vm.IsPhasedActivityTask && (int)vm.TaskState == 0);
		}
		if (specialNormalObj != null)
		{
			bindingSet.Bind(specialNormalObj).For((GameObject v) => v.activeSelf).To((ActivityTaskItemData vm) => vm.IsPhasedActivityTask);
		}
		if (specialAcceptObj != null)
		{
			bindingSet.Bind(specialAcceptObj).For((GameObject v) => v.activeSelf).ToExpression((ActivityTaskItemData vm) => vm.IsPhasedActivityTask && (int)vm.TaskState == 0);
		}
		bindingSet.Bind<TextMeshProUGUI>(taskComplete).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ActivityTaskItemData vm) => vm.TaskCompleteText);
		bindingSet.Bind<TextMeshProUGUI>(taskName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ActivityTaskItemData vm) => vm.TaskName);
		bindingSet.Bind(stateBtn).For((Button v) => v.onClick).To((ActivityTaskItemData vm) => vm.StateOnclickCmd);
		bindingSet.Bind<TextMeshProUGUI>(stateText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ActivityTaskItemData vm) => vm.StateText);
		bindingSet.Bind(stateJump).For((GameObject v) => v.activeSelf).ToExpression((ActivityTaskItemData vm) => (int)vm.TaskState == 2);
		bindingSet.Bind(stateComplete).For((GameObject v) => v.activeSelf).ToExpression((ActivityTaskItemData vm) => (int)vm.TaskState == 0);
		bindingSet.Bind(stateFinish).For((GameObject v) => v.activeSelf).ToExpression((ActivityTaskItemData vm) => (int)vm.TaskState == 3);
		if (stateNormal != null)
		{
			bindingSet.Bind(stateNormal).For((GameObject v) => v.activeSelf).ToExpression((ActivityTaskItemData vm) => (int)vm.TaskState == 1);
		}
		bindingSet.Build();
		rewardItemList.InitListView(viewModel.RewardPropList.Count, OnGetTaskItemByIndex);
	}

	private LoopListViewItem2 OnGetTaskItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.RewardPropList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("RewardItem");
		if (loopListViewItem != null)
		{
			KnapsackItemNew component = loopListViewItem.GetComponent<KnapsackItemNew>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.RewardPropList[index]);
			}
			else
			{
				component.RefreshData(viewModel.RewardPropList[index]);
			}
		}
		return loopListViewItem;
	}

	public void RefreshActivityTaskItem(ActivityTaskItemData data)
	{
		viewModel = data;
		viewModel.SetTextColor(colorNormal, colorJump, colorAccept, colorFinish);
		this.SetDataContext(data);
		rewardItemList.SetListItemCount(viewModel.RewardPropList.Count);
		rewardItemList.RefreshAllShownItem();
	}
}
