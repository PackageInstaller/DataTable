using System.Collections.Generic;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class FriendWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private Transform tabContent;

	[SerializeField]
	private MyFriendView myFriendView;

	[SerializeField]
	private FriendSearchView friendSearchView;

	[SerializeField]
	private FriendBlackListView blackListView;

	[SerializeField]
	private FriendRecentlyView recentlyView;

	[SerializeField]
	private TextMeshProUGUI curAndMaxLimitText;

	private List<TabToggle> tabToggles = new List<TabToggle>();

	private FriendWindowViewModel _viewModel;

	private int curTabIndex;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<FriendWindowViewModel>();
		BindingSet<FriendWindow, FriendViewModel> bindingSet = this.CreateBindingSet(_viewModel.FriendViewModel);
		bindingSet.Bind(this).For((FriendWindow v) => v.OnDismissRequest).To((FriendViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((FriendViewModel vm) => vm.Close);
		bindingSet.Bind().For((FriendWindow v) => v.OpenPlayerInfoWindow).To((FriendViewModel vm) => vm.OpenPlayerInfoRequest);
		bindingSet.Bind().For((FriendWindow v) => v.RefreshLimitText).To((FriendViewModel vm) => vm.FriendListChangeRequest);
		bindingSet.Bind().For((FriendWindow v) => v.RefreshLimitText).To((FriendViewModel vm) => vm.FriendApplyListChangeRequest);
		bindingSet.Bind().For((FriendWindow v) => v.RefreshLimitText).To((FriendViewModel vm) => vm.BlackListChangeRequest);
		bindingSet.Build();
		InitViews();
	}

	private void InitViews()
	{
		myFriendView.Init(_viewModel);
		friendSearchView.Init(_viewModel.FriendViewModel);
		blackListView.Init(_viewModel.FriendViewModel);
		recentlyView.Init(_viewModel.FriendViewModel);
		recentlyView.SetChatFunction(ChatWithFirend);
		for (int i = 0; i < tabContent.childCount; i++)
		{
			TabToggle component = tabContent.GetChild(i).GetComponent<TabToggle>();
			component.enumId = i;
			component.AddSelectedAction(OnTabClick);
			if (i == 1)
			{
				component.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.FriendApplicationUnReply).SetFuncOnMessage((RedPointMessage message) => ((RedPointService)Singleton<ServiceSystem>.Instance.GetService<IRedPointService>()).FriendApplyUnReply)
					.Invoke();
			}
			tabToggles.Add(component);
		}
	}

	private void OnTabClick(int index)
	{
		curTabIndex = index;
		myFriendView.SetVisible(index == 0);
		friendSearchView.CanvasGroup.alpha = ((index == 1) ? 1 : 0);
		friendSearchView.CanvasGroup.blocksRaycasts = index == 1;
		blackListView.CanvasGroup.alpha = ((index == 2) ? 1 : 0);
		blackListView.CanvasGroup.blocksRaycasts = index == 2;
		recentlyView.CanvasGroup.alpha = ((index == 3) ? 1 : 0);
		recentlyView.CanvasGroup.blocksRaycasts = index == 3;
		RefreshLimitText();
	}

	private void RefreshLimitText(object sender = null, InteractionEventArgs e = null)
	{
		if (curTabIndex == 2)
		{
			((TMP_Text)curAndMaxLimitText).text = $"黑名单  {_viewModel.FriendViewModel.BlackListData.Count}/{_viewModel.FriendViewModel.MaxFriendBlacklistCount}";
		}
		else if (curTabIndex == 3)
		{
			((TMP_Text)curAndMaxLimitText).text = $"最近组队  {_viewModel.FriendViewModel.RecentlyPlayerData.Count}/{_viewModel.FriendViewModel.MaxRecentlyPlayerCount}";
		}
		else
		{
			((TMP_Text)curAndMaxLimitText).text = $"我的好友  {_viewModel.FriendViewModel.FriendsData.Count}/{_viewModel.FriendViewModel.MaxFriendCount}";
		}
	}

	private async void OpenPlayerInfoWindow(object sender, InteractionEventArgs e)
	{
		PlayerInfoViewModel userData = (PlayerInfoViewModel)e.Context;
		await GameEntry.UI.OpenWindow<PlayerInfoWindow>("Social/PlayerInfoWindow", "DEFAULT", userData);
	}

	public void ChatWithFirend(long uid)
	{
		if (curTabIndex != 0 && tabToggles.Count > 0)
		{
			tabToggles[0].isOn = true;
		}
		if (myFriendView != null)
		{
			myFriendView.ChatWithFirend(uid);
		}
	}
}
