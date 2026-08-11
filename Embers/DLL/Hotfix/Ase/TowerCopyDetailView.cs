using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;

namespace Ase;

public class TowerCopyDetailView : UGuiView
{
	[SerializeField]
	private LoadUISprite sceneIcon;

	[SerializeField]
	private new TextMeshProUGUI name;

	[SerializeField]
	private TextMeshProUGUI desc;

	[SerializeField]
	private LoopListView2 dropList;

	private TowerCopyDetailViewModel viewModel;

	public void Init(TowerCopyDetailViewModel data)
	{
		viewModel = data;
		BindingSet<TowerCopyDetailView, TowerCopyDetailViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(sceneIcon).For((LoadUISprite v) => v.Path).ToExpression((TowerCopyDetailViewModel vm) => $"{vm.Data.BossIconPath}/{vm.Data.BossIcon}");
		bindingSet.Bind().For((TowerCopyDetailView v) => v.OnRefreshReward).To((TowerCopyDetailViewModel vm) => vm.RefreshRewardRequest);
		bindingSet.Bind<TextMeshProUGUI>(name).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TowerCopyDetailViewModel vm) => vm.Data.Name);
		bindingSet.Bind<TextMeshProUGUI>(desc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TowerCopyDetailViewModel vm) => vm.Desc);
		bindingSet.Build();
		dropList.InitListView(viewModel.DropProps.Count, OnGetDropItemByIndex);
	}

	private void OnRefreshReward(object sender, InteractionEventArgs args)
	{
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
