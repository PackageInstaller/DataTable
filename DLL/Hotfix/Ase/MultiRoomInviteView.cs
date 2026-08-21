using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class MultiRoomInviteView : UGuiWindow
{
	[SerializeField]
	private LoopGridView friendsList;

	[SerializeField]
	private Button cancelBtn;

	[SerializeField]
	private Button inviteBtn;

	[SerializeField]
	private Button closeBtn;

	[SerializeField]
	private Button closeBtn2;

	[SerializeField]
	private List<TabToggle> _tabToggles;

	[SerializeField]
	private TextMeshProUGUI remind;

	private MultiRoomInviteViewModel _viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<MultiRoomInviteViewModel>();
		BindingSet<MultiRoomInviteView, MultiRoomInviteViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(this).For((MultiRoomInviteView v) => v.OnDismissRequest).To((MultiRoomInviteViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(cancelBtn).For((Button v) => v.onClick).To((MultiRoomInviteViewModel vm) => vm.CancelOnclick);
		bindingSet.Bind(inviteBtn).For((Button v) => v.onClick).To((MultiRoomInviteViewModel vm) => vm.InviteOnclick);
		bindingSet.Bind(closeBtn).For((Button v) => v.onClick).To((MultiRoomInviteViewModel vm) => vm.CancelOnclick);
		bindingSet.Bind(closeBtn2).For((Button v) => v.onClick).To((MultiRoomInviteViewModel vm) => vm.CancelOnclick);
		bindingSet.Bind<TextMeshProUGUI>(remind).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((MultiRoomInviteViewModel vm) => vm.Remind);
		bindingSet.Bind(this).For((MultiRoomInviteView v) => v.RefreshFriends).To((MultiRoomInviteViewModel vm) => vm.RefreshFriendsRequest);
		bindingSet.Build();
		friendsList.InitGridView(_viewModel.MultiRoomInviteItemData.Count, OnGetMultiRoomInviteItemByIndex);
		InitToggle();
	}

	private void InitToggle()
	{
		for (int i = 0; i < _tabToggles.Count; i++)
		{
			_tabToggles[i].enumId = i;
			_tabToggles[i].AddSelectedAction(ChangeFriends);
		}
		if (Singleton<ServiceSystem>.Instance.GetService<IGuildService>().GetMyGuildData() == null && _tabToggles.Count == 3)
		{
			_tabToggles[1].gameObject.SetActive(value: false);
		}
	}

	private void ChangeFriends(int index)
	{
		_viewModel.ChangeFriends(index);
	}

	private void RefreshFriends(object sender, InteractionEventArgs e)
	{
		friendsList.SetListItemCount(_viewModel.MultiRoomInviteItemData.Count);
		friendsList.RefreshAllShownItem();
	}

	private LoopGridViewItem OnGetMultiRoomInviteItemByIndex(LoopGridView arg1, int index, int row, int column)
	{
		MultiRoomInviteItemData multiRoomInviteItemData = _viewModel.MultiRoomInviteItemData[index];
		if (multiRoomInviteItemData == null)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = friendsList.NewListViewItem("Gamer");
		MultiRoomInviteItem component = loopGridViewItem.GetComponent<MultiRoomInviteItem>();
		if (!loopGridViewItem.IsInitHandlerCalled)
		{
			loopGridViewItem.IsInitHandlerCalled = true;
			component.Init(multiRoomInviteItemData);
		}
		else
		{
			component.RefreshData(multiRoomInviteItemData);
		}
		return loopGridViewItem;
	}
}
