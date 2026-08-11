namespace Ase;

public class FriendBlackListItemData : ItemOptionBase
{
	private PlayerData playerData;

	public PlayerData PlayerData
	{
		get
		{
			return playerData;
		}
		set
		{
			Set(ref playerData, value, "PlayerData");
		}
	}

	public FriendBlackListItemData()
	{
	}

	public FriendBlackListItemData(OptionBase parent, PlayerData playerData)
	{
		base.parent = parent;
		PlayerData = playerData;
	}

	public void OnLookInfoBtnClick()
	{
		if (parent is FriendViewModel friendViewModel)
		{
			friendViewModel.OpenPlayerInfoRequest.Raise(new PlayerInfoViewModel(friendViewModel, playerData, isSelf: false));
		}
	}

	public async void RemoveFromBlackList()
	{
		if (PlayerData != null)
		{
			Loading loading = await Loading.Show();
			await Singleton<ServiceSystem>.Instance.GetService<ISocialService>().HandleFriendBlackList(PlayerData, ope: false);
			loading.Dispose();
		}
	}
}
