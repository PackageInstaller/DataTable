using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ActivityAchievementRewardItem : UGuiView
{
	[SerializeField]
	private TextMeshProUGUI descTxt;

	[SerializeField]
	private TextMeshProUGUI countTxt;

	[SerializeField]
	private LoopListView2 rewardList;

	[SerializeField]
	private GameObject redPoint;

	[SerializeField]
	private Button rewardBtn;

	private ActivityAchievementRewardItemData viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		viewModel = GetUserData<ActivityAchievementRewardItemData>(userData);
		BindingSet<ActivityAchievementRewardItem, ActivityAchievementRewardItemData> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(rewardBtn).For((Button v) => v.onClick).To((ActivityAchievementRewardItemData vm) => vm.OnClick);
		bindingSet.Bind<TextMeshProUGUI>(countTxt).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ActivityAchievementRewardItemData vm) => vm.CountTxt);
		bindingSet.Bind<TextMeshProUGUI>(descTxt).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ActivityAchievementRewardItemData vm) => vm.DescTxt);
		bindingSet.Bind(redPoint).For((GameObject v) => v.activeSelf).To((ActivityAchievementRewardItemData vm) => vm.RedPoint);
		bindingSet.Build();
		rewardList.InitListView(viewModel.DropProps.Count, OnGetRewardItemByIndex);
	}

	private LoopListViewItem2 OnGetRewardItemByIndex(LoopListView2 view, int index)
	{
		if (index < 0 || index >= viewModel.DropProps.Count)
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

	public void Init(ActivityAchievementRewardItemData data)
	{
		OnInit(data);
	}

	public void RefreshData(ActivityAchievementRewardItemData viewModel)
	{
		this.viewModel = viewModel;
		this.SetDataContext(viewModel);
	}
}
