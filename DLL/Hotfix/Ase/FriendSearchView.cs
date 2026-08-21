using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class FriendSearchView : UGuiView
{
	[SerializeField]
	private TMP_InputField playerUid;

	[SerializeField]
	private Button searchBtn;

	[SerializeField]
	private LoopListView2 scrollView;

	[SerializeField]
	private TextMeshProUGUI curAndMaxLimitText;

	[SerializeField]
	private GameObject nothing;

	private FriendViewModel _viewModel;

	private long _myUid;

	public void Init(FriendViewModel viewModel)
	{
		_viewModel = viewModel;
		_myUid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Uid;
		BindingSet<FriendSearchView, FriendViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind().For((FriendSearchView v) => v.RefreshFriendApplyList).To((FriendViewModel vm) => vm.FriendApplyListChangeRequest);
		bindingSet.Build();
		searchBtn.onClick.AddListener(OnSearchBtnClick);
		scrollView.InitListView(_viewModel.FriendApplyData.Count, OnGetItemByIndex);
		RefreshFriendApplyList();
	}

	public void RefreshFriendApplyList(object sender = null, InteractionEventArgs e = null)
	{
		scrollView.SetListItemCount(_viewModel.FriendApplyData.Count);
		scrollView.RefreshAllShownItem();
		((TMP_Text)curAndMaxLimitText).text = $"好友申请：{_viewModel.FriendApplyData.Count}/{_viewModel.MaxFriendApplyCount}";
		nothing.SetActive(_viewModel.FriendApplyData.Count <= 0);
	}

	private async void OnSearchBtnClick()
	{
		if (playerUid.text.Length <= 0)
		{
			return;
		}
		if (long.TryParse(playerUid.text, out var uid))
		{
			if (uid.Equals(_myUid))
			{
				Toast.ShowInfo("这是你自己");
				return;
			}
			Loading loading = await Loading.Show();
			PlayerData playerData = await Singleton<ServiceSystem>.Instance.GetService<ISocialService>().RequestSearchPlayer(uid);
			loading.Dispose();
			if (playerData == null)
			{
				Toast.ShowInfo("不存在目标玩家");
			}
			else
			{
				_viewModel.OpenPlayerInfoRequest.Raise(new PlayerInfoViewModel(_viewModel, playerData, isSelf: false));
			}
		}
		else
		{
			Toast.ShowInfo("无效输入");
		}
	}

	private LoopListViewItem2 OnGetItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= _viewModel.FriendApplyData.Count)
		{
			return null;
		}
		PlayerData playerData = _viewModel.FriendApplyData[index];
		if (playerData == null)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = scrollView.NewListViewItem("FriendApplyItem");
		FriendApplyItem component = loopListViewItem.GetComponent<FriendApplyItem>();
		if (!loopListViewItem.IsInitHandlerCalled)
		{
			loopListViewItem.IsInitHandlerCalled = true;
			component.Init(playerData);
		}
		else
		{
			component.Refresh(playerData);
		}
		return loopListViewItem;
	}
}
