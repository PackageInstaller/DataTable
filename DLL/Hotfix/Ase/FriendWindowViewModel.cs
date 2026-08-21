using System.Threading.Tasks;

namespace Ase;

public class FriendWindowViewModel : OptionBase
{
	private FriendViewModel _friendViewModel;

	private FriendChatViewModel _friendChatViewModel;

	private long targetUid;

	private bool _requesting;

	public FriendViewModel FriendViewModel => _friendViewModel;

	public FriendChatViewModel FriendChatViewModel => _friendChatViewModel;

	public long TargetUid
	{
		get
		{
			return targetUid;
		}
		set
		{
			targetUid = value;
		}
	}

	public FriendWindowViewModel()
	{
	}

	public FriendWindowViewModel(OptionBase parent)
	{
		base.parent = parent;
		_friendViewModel = Singleton<ServiceSystem>.Instance.GetService<ISocialService>().GetFriendViewModel();
		_friendChatViewModel = new FriendChatViewModel(this);
	}

	public async Task RequestAllFriendData()
	{
		await Singleton<ServiceSystem>.Instance.GetService<ISocialService>().RequestFriendsData();
		await Singleton<ServiceSystem>.Instance.GetService<ISocialService>().RequestFriendApplyData();
		await Singleton<ServiceSystem>.Instance.GetService<ISocialService>().RequestBlackListData();
	}

	public async void TryJoinFriendTeam(PlayerData playerData)
	{
		Loading loading = await Loading.Show();
		MultiRoomData multiRoomData = await Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().TryJoinFriendTeam(playerData.Uid, 0L);
		if (multiRoomData.IsValid())
		{
			FriendViewModel.Close();
			parent?.ItemOnClick(multiRoomData);
		}
		loading.Dispose();
	}

	public async void TrySendTeamApply2Friend(PlayerData playerData)
	{
		if (parent != null && parent is MultiRoomViewModel { IsMatch: not false })
		{
			Toast.ShowInfo("已开始匹配，无法邀请");
			return;
		}
		Loading loading = await Loading.Show();
		await Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().TrySendTeamInvite(playerData.Uid);
		loading.Dispose();
	}

	public async Task<bool> GetAllEnergy()
	{
		if (_requesting)
		{
			return false;
		}
		_requesting = true;
		Loading loading = await Loading.Show();
		bool result = await Singleton<ServiceSystem>.Instance.GetService<ISocialService>().RequestGetFriendSendEnergy(0L);
		loading.Dispose();
		_requesting = false;
		return result;
	}

	public async Task<bool> SendAllEnergy()
	{
		if (_requesting)
		{
			return false;
		}
		_requesting = true;
		Loading loading = await Loading.Show();
		bool result = await Singleton<ServiceSystem>.Instance.GetService<ISocialService>().RequestSendFriendEnergy(0L);
		loading.Dispose();
		_requesting = false;
		return result;
	}

	public void SetTargetUidt(long uid)
	{
		targetUid = uid;
	}
}
