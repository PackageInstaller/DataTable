using Cysharp.Threading.Tasks;

namespace Ase;

public class FriendChatViewModel : OptionBase
{
	private new FriendWindowViewModel parent;

	private PlayerData _playerData;

	private ChatViewModel _chatViewModel;

	private ChatImageViewModel _chatImageViewModel;

	private bool showImgView;

	public PlayerData PlayerData
	{
		get
		{
			return _playerData;
		}
		private set
		{
			Set(ref _playerData, value, "PlayerData");
		}
	}

	public ChatImageViewModel ChatImageViewModel => _chatImageViewModel;

	public bool ShowImgView
	{
		get
		{
			return showImgView;
		}
		set
		{
			Set(ref showImgView, value, "ShowImgView");
		}
	}

	public FriendChatViewModel()
	{
	}

	public FriendChatViewModel(FriendWindowViewModel parent)
	{
		this.parent = parent;
		_chatViewModel = Singleton<ServiceSystem>.Instance.GetService<IChatService>()?.GetChatViewModel();
		_chatImageViewModel = new ChatImageViewModel(this);
	}

	public void RefreshPlayerData(PlayerData playerData)
	{
		PlayerData = playerData;
		ShowImgView = false;
	}

	public void OpenPlayerInfo()
	{
		parent.FriendViewModel.OpenPlayerInfoRequest.Raise(new PlayerInfoViewModel(parent, PlayerData, isSelf: false));
	}

	public void TryJoinFriendTeam()
	{
		parent.TryJoinFriendTeam(PlayerData);
	}

	public void TrySendTeamApply2Friend()
	{
		parent.TrySendTeamApply2Friend(PlayerData);
	}

	public async void OnOpenFace()
	{
		if (_chatViewModel != null)
		{
			await _chatViewModel.RequestEmojiUnlockList();
			_chatImageViewModel.Init(_chatViewModel.UnlockEmojiTypes);
			ShowImgView = true;
		}
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is OptionArg optionArg)
		{
			if (optionArg.OptionName.Equals("SendImage"))
			{
				SendEmoji((CharImageItemViewModel)optionArg.Obj);
			}
			else if (optionArg.OptionName.Equals("CloseChatImage"))
			{
				ShowImgView = false;
			}
		}
	}

	public async UniTask<bool> SendMessage(string message)
	{
		return await Singleton<ServiceSystem>.Instance.GetService<ISocialService>().SendFriendChatMessage(PlayerData.Uid, message);
	}

	private async UniTask<bool> SendEmoji(CharImageItemViewModel charImageItem)
	{
		if (GameEntry.DataTable.GetDataRow((DREmoticon p) => p.Id == charImageItem.ID) != null)
		{
			string chatMessage = ChatHelper.ChangeEmoji2String(charImageItem.ID);
			bool result = await Singleton<ServiceSystem>.Instance.GetService<ISocialService>().SendFriendChatMessage(_playerData.Uid, chatMessage);
			ShowImgView = false;
			return result;
		}
		return false;
	}
}
