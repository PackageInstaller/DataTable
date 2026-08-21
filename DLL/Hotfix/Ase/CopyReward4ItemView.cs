using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class CopyReward4ItemView : UGuiView
{
	public Button btn;

	public TextMeshProUGUI count;

	public GameObject canGet;

	public LoopListView2 rewardList;

	public new TextMeshProUGUI name;

	private CopyReward4ItemViewModel viewModel;

	protected override void OnInit(object userData)
	{
		if (viewModel != null)
		{
			RefreshData(userData);
			return;
		}
		viewModel = GetUserData<CopyReward4ItemViewModel>(userData);
		BindingSet<CopyReward4ItemView, CopyReward4ItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btn).For((Button v) => v.onClick).To((CopyReward4ItemViewModel vm) => vm.OnClick);
		bindingSet.Bind<TextMeshProUGUI>(count).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CopyReward4ItemViewModel vm) => vm.Count);
		bindingSet.Bind(canGet).For((GameObject v) => v.activeSelf).ToExpression((CopyReward4ItemViewModel vm) => vm.State == 1);
		if ((UnityEngine.Object)(object)name != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(name).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CopyReward4ItemViewModel vm) => vm.Name);
		}
		bindingSet.Build();
		rewardList.InitListView(viewModel.RewardItemDatas.Count, OnGetRewardItemByIndex);
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<CopyReward4ItemViewModel>(userData);
		this.SetDataContext(viewModel);
		rewardList.SetListItemCount(viewModel.RewardItemDatas.Count);
		rewardList.RefreshAllShownItem();
	}

	private LoopListViewItem2 OnGetRewardItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.RewardItemDatas.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("MailAttachmentItem");
		if (loopListViewItem != null)
		{
			ReceiveItemView component = loopListViewItem.GetComponent<ReceiveItemView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.RewardItemDatas[index]);
			}
			else
			{
				component.RefreshData(viewModel.RewardItemDatas[index]);
			}
		}
		return loopListViewItem;
	}
}
