using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class TowerRewardItem : UGuiView
{
	[SerializeField]
	private LoopListView2 rewardList;

	[SerializeField]
	private TextMeshProUGUI rewardDesText;

	[SerializeField]
	private Button getTaskRewardBtn;

	[SerializeField]
	private GameObject redPoint;

	[SerializeField]
	private TextMeshProUGUI rewardProgressText;

	private TowerRewardItemData viewModel;

	protected override void OnInit(object userData)
	{
		viewModel = (TowerRewardItemData)userData;
		BindingSet<TowerRewardItem, TowerRewardItemData> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind<TextMeshProUGUI>(rewardDesText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TowerRewardItemData vm) => vm.RewardDes);
		bindingSet.Bind(redPoint).For((GameObject v) => v.activeSelf).To((TowerRewardItemData vm) => vm.RedPoint);
		bindingSet.Bind(getTaskRewardBtn).For((Button v) => v.onClick).To((TowerRewardItemData vm) => vm.SendGetTaskReward);
		bindingSet.Bind<TextMeshProUGUI>(rewardProgressText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TowerRewardItemData vm) => vm.TaskProgressText);
		bindingSet.Build();
		rewardList.InitListView(viewModel.TowerRewardIds.Count, OnGetRewardItemByIndex);
	}

	private LoopListViewItem2 OnGetRewardItemByIndex(LoopListView2 view, int index)
	{
		if (index < 0 || index >= viewModel.TowerRewardIds.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = view.NewListViewItem("MailAttachmentItem");
		if (loopListViewItem != null)
		{
			ReceiveItemView component = loopListViewItem.GetComponent<ReceiveItemView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.DropProps[index]);
			}
			else
			{
				component.RefreshData(viewModel.DropProps[index]);
			}
		}
		return loopListViewItem;
	}

	public override void RefreshData(object userData)
	{
		viewModel = userData as TowerRewardItemData;
		this.SetDataContext(viewModel);
		rewardList.SetListItemCount(viewModel.TowerRewardIds.Count);
		rewardList.RefreshAllShownItem();
	}
}
