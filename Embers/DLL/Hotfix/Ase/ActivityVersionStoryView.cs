using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine.UI;

namespace Ase;

public class ActivityVersionStoryView : UGuiView
{
	public Button btnClose;

	public Button btnView;

	public new TextMeshProUGUI name;

	public TextMeshProUGUI content;

	public LoopListView2 dropList;

	private ActivityVersionStoryViewModel viewModel;

	protected override void OnInit(object userData)
	{
		if (viewModel != null)
		{
			RefreshData(userData);
			return;
		}
		viewModel = GetUserData<ActivityVersionStoryViewModel>(userData);
		BindingSet<ActivityVersionStoryView, ActivityVersionStoryViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btnClose).For((Button v) => v.onClick).To((ActivityVersionStoryViewModel vm) => vm.OptCmd)
			.CommandParameter("CloseStoryView");
		bindingSet.Bind(btnView).For((Button v) => v.onClick).To((ActivityVersionStoryViewModel vm) => vm.OptCmd)
			.CommandParameter("ShowTimeline");
		bindingSet.Bind<TextMeshProUGUI>(name).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ActivityVersionStoryViewModel vm) => vm.Name);
		bindingSet.Bind<TextMeshProUGUI>(content).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ActivityVersionStoryViewModel vm) => vm.Summary);
		bindingSet.Build();
		dropList.InitListView(viewModel.DropProps.Count, OnGetDropItemByIndex);
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<ActivityVersionStoryViewModel>(userData);
		this.SetDataContext(viewModel);
		dropList.SetListItemCount(viewModel.DropProps.Count);
		dropList.RefreshAllShownItem();
	}

	private LoopListViewItem2 OnGetDropItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.DropProps.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = null;
		loopListViewItem = (viewModel.DropProps[index].IsLock ? listView2.NewListViewItem("MailAttachmentItemFirst") : ((!string.IsNullOrEmpty(viewModel.DropProps[index].CountRange)) ? listView2.NewListViewItem("MailAttachmentItemNormal") : listView2.NewListViewItem("MailAttachmentItemNoBar")));
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
}
