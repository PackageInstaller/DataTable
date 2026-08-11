using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class MultiRoomInviteViewModel : OptionBase
{
	private List<MultiRoomInviteItemData> _multiRoomInviteItemData;

	private List<MultiRoomInviteItemData> _friendsList;

	private List<MultiRoomInviteItemData> _guildList;

	private List<MultiRoomInviteItemData> _recentFriendList;

	private string _remind;

	private InteractionRequest _refreshFriendsRequest;

	public List<MultiRoomInviteItemData> MultiRoomInviteItemData
	{
		get
		{
			return _multiRoomInviteItemData;
		}
		set
		{
			Set(ref _multiRoomInviteItemData, value, "MultiRoomInviteItemData");
		}
	}

	public List<MultiRoomInviteItemData> FriendsList
	{
		get
		{
			return _friendsList;
		}
		set
		{
			Set(ref _friendsList, value, "FriendsList");
		}
	}

	public List<MultiRoomInviteItemData> RecentFriendList
	{
		get
		{
			return _recentFriendList;
		}
		set
		{
			Set(ref _recentFriendList, value, "RecentFriendList");
		}
	}

	public List<MultiRoomInviteItemData> GuildList
	{
		get
		{
			return _guildList;
		}
		set
		{
			Set(ref _guildList, value, "GuildList");
		}
	}

	public string Remind
	{
		get
		{
			return _remind;
		}
		set
		{
			Set(ref _remind, value, "Remind");
		}
	}

	public InteractionRequest RefreshFriendsRequest => _refreshFriendsRequest;

	public MultiRoomInviteViewModel()
	{
	}

	public MultiRoomInviteViewModel(OptionBase parent, List<PbLongIdValue> longIdValues, List<PbMultiFightFriendInfo> recentFriendInfo, List<PbLongIdValue> guildPlayerInfos, int copyMainId)
	{
		base.parent = parent;
		_friendsList = new List<MultiRoomInviteItemData>();
		_guildList = new List<MultiRoomInviteItemData>();
		_recentFriendList = new List<MultiRoomInviteItemData>();
		_refreshFriendsRequest = new InteractionRequest();
		LoadFriendInfo(longIdValues, recentFriendInfo, guildPlayerInfos, copyMainId);
		ChangeFriends(0);
		DeBugInfoTest();
	}

	private void DeBugInfoTest()
	{
		foreach (MultiRoomInviteItemData friends in _friendsList)
		{
			_ = friends;
		}
		foreach (MultiRoomInviteItemData guild in _guildList)
		{
			_ = guild;
		}
		foreach (MultiRoomInviteItemData recentFriend in _recentFriendList)
		{
			_ = recentFriend;
		}
	}

	private void LoadFriendInfo(List<PbLongIdValue> longIdValues, List<PbMultiFightFriendInfo> recentFriendInfo, List<PbLongIdValue> guildPlayerInfos, int copyMainId)
	{
		if (_multiRoomInviteItemData == null)
		{
			_multiRoomInviteItemData = new List<MultiRoomInviteItemData>();
		}
		else
		{
			_multiRoomInviteItemData.Clear();
		}
		bool flag = copyMainId == Constant.ConstantConfig.GuildCopyType;
		List<PlayerData> blackListData = Singleton<ServiceSystem>.Instance.GetService<ISocialService>().GetFriendViewModel().BlackListData;
		List<PlayerData> friendsData = Singleton<ServiceSystem>.Instance.GetService<ISocialService>().GetFriendViewModel().FriendsData;
		List<GuildMemberData> list = Singleton<ServiceSystem>.Instance.GetService<IGuildService>().GetMyGuildData()?.Members;
		List<MultiRoomPlayerViewModel> gamerInfoList = Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().GetMultiRoomViewModel().GamerInfoList;
		foreach (PbLongIdValue longIdValue in longIdValues)
		{
			if (flag && guildPlayerInfos.FindIndex((PbLongIdValue p) => p.Id == longIdValue.Id) < 0)
			{
				continue;
			}
			foreach (PlayerData item in friendsData)
			{
				if (longIdValue.Id == item.Uid)
				{
					int num = gamerInfoList.FindIndex((MultiRoomPlayerViewModel p) => p.GamerUid == longIdValue.Id);
					int num2 = blackListData.FindIndex((PlayerData p) => p.Uid == longIdValue.Id);
					if (num < 0 && num2 < 0)
					{
						_friendsList.Add(new MultiRoomInviteItemData(this, item, longIdValue.Value));
						break;
					}
				}
			}
		}
		foreach (PbLongIdValue guildPlayerInfo in guildPlayerInfos)
		{
			if (list == null)
			{
				continue;
			}
			foreach (GuildMemberData item2 in list)
			{
				if (guildPlayerInfo.Id == item2.Uid)
				{
					int num3 = gamerInfoList.FindIndex((MultiRoomPlayerViewModel p) => p.GamerUid == guildPlayerInfo.Id);
					int num4 = blackListData.FindIndex((PlayerData p) => p.Uid == guildPlayerInfo.Id);
					if (num3 < 0 && num4 < 0)
					{
						_guildList.Add(new MultiRoomInviteItemData(this, item2, guildPlayerInfo.Value));
						break;
					}
				}
			}
		}
		foreach (PbMultiFightFriendInfo info in recentFriendInfo)
		{
			if (!flag || guildPlayerInfos.FindIndex((PbLongIdValue p) => p.Id == info.FrienInfo.UserId) >= 0)
			{
				int num5 = gamerInfoList.FindIndex((MultiRoomPlayerViewModel p) => p.GamerUid == info.FrienInfo.UserId);
				int num6 = blackListData.FindIndex((PlayerData p) => p.Uid == info.FrienInfo.UserId);
				if (num5 < 0 && num6 < 0)
				{
					_recentFriendList.Add(new MultiRoomInviteItemData(this, info));
				}
			}
		}
	}

	public void ChangeFriends(int index)
	{
		foreach (MultiRoomInviteItemData multiRoomInviteItemDatum in MultiRoomInviteItemData)
		{
			multiRoomInviteItemDatum.IsSelected = false;
		}
		switch (index)
		{
		case 0:
			MultiRoomInviteItemData = FriendsList;
			break;
		case 1:
			MultiRoomInviteItemData = GuildList;
			break;
		case 2:
			MultiRoomInviteItemData = RecentFriendList;
			break;
		}
		Remind = ((MultiRoomInviteItemData.Count == 0) ? "暂无该类玩家" : "");
		RefreshFriendsRequest.Raise();
	}

	public void CancelOnclick()
	{
		foreach (MultiRoomInviteItemData multiRoomInviteItemDatum in MultiRoomInviteItemData)
		{
			multiRoomInviteItemDatum.IsSelected = false;
		}
		Close();
	}

	public void InviteOnclick()
	{
		parent.ItemOnClick(this);
		Close();
	}
}
