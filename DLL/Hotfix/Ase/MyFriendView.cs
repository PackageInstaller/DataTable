using System.Collections.Generic;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

namespace Ase;

public class MyFriendView : UGuiView
{
	[SerializeField]
	private LoopListView2 scrollView;

	[SerializeField]
	private FriendChatView friendChatView;

	[SerializeField]
	private TMP_InputField filterInputField;

	[SerializeField]
	private Button clearSearchButton;

	[SerializeField]
	private Button btnGetAllEnergy;

	[SerializeField]
	private Button btnSendAllEnergy;

	[SerializeField]
	private GameObject sendAllEnergyMask;

	[SerializeField]
	private GameObject noFriend;

	private FriendWindowViewModel _viewModel;

	public Material greyMaterial;

	private PlayerData _curSelectPlayer;

	private FriendItem _curSelectItem;

	private List<PlayerData> filteredFriendsData;

	public List<PlayerData> FilteredFriendsData
	{
		get
		{
			return filteredFriendsData;
		}
		set
		{
			filteredFriendsData = value;
			filteredFriendsData.Sort(delegate(PlayerData a, PlayerData b)
			{
				bool flag = a.State != 4;
				bool flag2 = b.State != 4;
				if (flag != flag2)
				{
					if (!flag)
					{
						return 1;
					}
					return -1;
				}
				RedPointService obj = (RedPointService)Singleton<ServiceSystem>.Instance.GetService<IRedPointService>();
				bool flag3 = obj.FriendsUnreadChat.Contains(a.Uid);
				bool flag4 = obj.FriendsUnreadChat.Contains(b.Uid);
				if (flag3 != flag4)
				{
					if (!flag3)
					{
						return 1;
					}
					return -1;
				}
				if (a.Level != b.Level)
				{
					return -a.Level.CompareTo(b.Level);
				}
				if (_viewModel.TargetUid > 0)
				{
					PlayerData playerData = null;
					for (int i = 0; i < filteredFriendsData.Count; i++)
					{
						if (filteredFriendsData[i].Uid == _viewModel.TargetUid)
						{
							playerData = filteredFriendsData[i];
							filteredFriendsData.RemoveAt(i);
							break;
						}
					}
					if (playerData != null)
					{
						filteredFriendsData.Insert(0, playerData);
					}
				}
				return -a.LastLoginTime.CompareTo(b.LastLoginTime);
			});
		}
	}

	public void Init(FriendWindowViewModel viewModel)
	{
		_viewModel = viewModel;
		FilteredFriendsData = _viewModel.FriendViewModel.FriendsData;
		BindingSet<MyFriendView, FriendViewModel> bindingSet = this.CreateBindingSet(_viewModel.FriendViewModel);
		bindingSet.Bind().For((MyFriendView v) => v.OnFriendListChanged).To((FriendViewModel vm) => vm.FriendListChangeRequest);
		bindingSet.Bind().For((MyFriendView v) => v.RefreshFriendChatList).To((FriendViewModel vm) => vm.FriendChatDataChangeRequest);
		bindingSet.Build();
		friendChatView.Init(_viewModel.FriendChatViewModel);
		scrollView.InitListView(FilteredFriendsData.Count, OnGetItemByIndex);
		((UnityEvent<string>)(object)filterInputField.onValueChanged).AddListener((UnityAction<string>)OnFilterInputFieldChanged);
		clearSearchButton.onClick.AddListener(delegate
		{
			filterInputField.text = string.Empty;
		});
		UpdateLayout();
		btnGetAllEnergy.onClick.AddListener(GetAllEnergy);
		btnSendAllEnergy.onClick.AddListener(SendAllEnergy);
	}

	private void OnFilterInputFieldChanged(string str)
	{
		if (string.IsNullOrEmpty(str))
		{
			FilteredFriendsData = _viewModel.FriendViewModel.FriendsData;
		}
		else
		{
			FilteredFriendsData = _viewModel.FriendViewModel.FriendsData.FindAll((PlayerData p) => p.Name.Contains(str));
		}
		RefreshFriendList();
	}

	public void OnFriendListChanged(object sender, InteractionEventArgs e)
	{
		OnFilterInputFieldChanged(filterInputField.text);
	}

	private void RefreshFriendList()
	{
		scrollView.SetListItemCount(FilteredFriendsData.Count);
		scrollView.RefreshAllShownItem();
		UpdateLayout();
	}

	public void RefreshFriendChatList(object sender, InteractionEventArgs e)
	{
		long uid = (long)e.Context;
		if (_curSelectPlayer != null && uid.Equals(_curSelectPlayer.Uid))
		{
			friendChatView.Refresh(_viewModel.FriendViewModel.GetTargetFriendData(uid), _viewModel.FriendViewModel.GetFriendChatData(uid));
		}
	}

	private void UpdateLayout()
	{
		List<PlayerData> friendsData = _viewModel.FriendViewModel.FriendsData;
		bool flag = friendsData.Count > 0;
		((Component)(object)filterInputField).gameObject.SetActive(flag);
		noFriend.SetActive(!flag);
		friendChatView.gameObject.SetActive(flag);
		bool flag2 = friendsData.Exists((PlayerData p) => p.EnergyReceiveState == 1);
		bool flag3 = friendsData.Exists((PlayerData p) => p.EnergySendState == 2);
		btnGetAllEnergy.gameObject.SetActive(flag2);
		btnSendAllEnergy.gameObject.SetActive(!flag2 & flag3);
		sendAllEnergyMask.SetActive(!flag2 && !flag3);
	}

	private void OnFriendItemClick(FriendItem item)
	{
		if (_curSelectItem != null)
		{
			_curSelectItem.SetSelected(selected: false);
		}
		_curSelectItem = item;
		_curSelectItem.SetSelected(selected: true);
		_curSelectPlayer = item.ViewModel.FriendData;
		friendChatView.Refresh(_curSelectPlayer, _viewModel.FriendViewModel.GetFriendChatData(_curSelectPlayer.Uid));
		Singleton<ServiceSystem>.Instance.GetService<ISocialService>().SetChatDataReadStateWithFriend(_curSelectPlayer.Uid, read: true);
		friendChatView.gameObject.SetActive(value: true);
	}

	private LoopListViewItem2 OnGetItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= FilteredFriendsData.Count)
		{
			return null;
		}
		PlayerData data = FilteredFriendsData[index];
		if (data == null)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = scrollView.NewListViewItem("FriendItem");
		FriendItemData data2 = new FriendItemData(data)
		{
			EnergyStateChanged = UpdateLayout
		};
		FriendItem component = loopListViewItem.GetComponent<FriendItem>();
		if (!loopListViewItem.IsInitHandlerCalled)
		{
			loopListViewItem.IsInitHandlerCalled = true;
			component.Init(data2, greyMaterial);
			component.SetBtnOnClick(OnFriendItemClick);
			component.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.FriendChatUnread).SetFuncOnMessage((RedPointMessage message) => ((RedPointService)Singleton<ServiceSystem>.Instance.GetService<IRedPointService>()).FriendsUnreadChat.Contains(data.Uid))
				.Invoke();
		}
		component.Refresh(data2);
		if (index == 0)
		{
			OnFriendItemClick(component);
		}
		return loopListViewItem;
	}

	private async void GetAllEnergy()
	{
		if (!(await _viewModel.GetAllEnergy()))
		{
			return;
		}
		UpdateLayout();
		if (scrollView == null || scrollView.ItemList == null)
		{
			return;
		}
		foreach (LoopListViewItem2 item in scrollView.ItemList)
		{
			item.GetComponent<FriendItem>()?.ViewModel?.RefreshEnergyState();
		}
	}

	private async void SendAllEnergy()
	{
		if (!(await _viewModel.SendAllEnergy()))
		{
			return;
		}
		UpdateLayout();
		if (scrollView == null || scrollView.ItemList == null)
		{
			return;
		}
		foreach (LoopListViewItem2 item in scrollView.ItemList)
		{
			item.GetComponent<FriendItem>()?.ViewModel?.RefreshEnergyState();
		}
	}

	public void ChatWithFirend(long uid)
	{
		if (scrollView.ItemList == null)
		{
			return;
		}
		foreach (LoopListViewItem2 item in scrollView.ItemList)
		{
			FriendItem component = item.GetComponent<FriendItem>();
			if (!(component == null) && component.ViewModel.FriendData.Uid.Equals(uid))
			{
				OnFriendItemClick(component);
				break;
			}
		}
	}

	public void SetVisible(bool visible)
	{
		CanvasGroup.alpha = (visible ? 1 : 0);
		CanvasGroup.blocksRaycasts = visible;
		if (visible && friendChatView != null && friendChatView.ViewModel.PlayerData != null)
		{
			Singleton<ServiceSystem>.Instance.GetService<ISocialService>().GetFriendViewModel()?.SetCurChatPlayer(friendChatView.ViewModel.PlayerData);
		}
		else if (!visible)
		{
			Singleton<ServiceSystem>.Instance.GetService<ISocialService>().GetFriendViewModel()?.ResetCurChatPlayer();
		}
	}

	protected override void OnDestroy()
	{
		Singleton<ServiceSystem>.Instance.GetService<ISocialService>().GetFriendViewModel()?.ResetCurChatPlayer();
		base.OnDestroy();
	}
}
