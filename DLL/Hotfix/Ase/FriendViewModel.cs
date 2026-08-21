using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class FriendViewModel : OptionBase
{
	private int maxFriendCount = -1;

	private int maxFriendApplyCount = -1;

	private int maxFriendBlacklistCount = -1;

	private int maxRecentlyPlayerCount = -1;

	private List<PlayerData> _friendsData = new List<PlayerData>();

	private List<PlayerData> _friendApplyData = new List<PlayerData>();

	private List<PlayerData> _blackListData = new List<PlayerData>();

	private List<PlayerData> _recentlyPlayerData = new List<PlayerData>();

	private Dictionary<long, List<PlayerChatData>> _friendChatData = new Dictionary<long, List<PlayerChatData>>();

	private InteractionRequest<PlayerInfoViewModel> openPlayerInfoRequest = new InteractionRequest<PlayerInfoViewModel>();

	private InteractionRequest friendListChangeRequest = new InteractionRequest();

	private InteractionRequest friendApplyListChangeRequest = new InteractionRequest();

	private InteractionRequest blackListChangeRequest = new InteractionRequest();

	private InteractionRequest recentlyPlayerChangeRst = new InteractionRequest();

	private InteractionRequest<long> friendChatDataChangeRequest = new InteractionRequest<long>();

	private PlayerData curChatPlayer;

	public PlayerData CurChatPlayer => curChatPlayer;

	public int MaxFriendCount
	{
		get
		{
			if (maxFriendCount < 0)
			{
				maxFriendCount = Singleton<OuterSystem>.Instance.GetConstantConfigInt(Constant.ConstantConfig.MaxCountFriend, 20);
			}
			return maxFriendCount;
		}
	}

	public int MaxFriendApplyCount
	{
		get
		{
			if (maxFriendApplyCount < 0)
			{
				maxFriendApplyCount = Singleton<OuterSystem>.Instance.GetConstantConfigInt(Constant.ConstantConfig.MaxCountFriendApply, 20);
			}
			return maxFriendApplyCount;
		}
	}

	public int MaxFriendBlacklistCount
	{
		get
		{
			if (maxFriendBlacklistCount < 0)
			{
				maxFriendBlacklistCount = Singleton<OuterSystem>.Instance.GetConstantConfigInt(Constant.ConstantConfig.MaxCountBlack, 20);
			}
			return maxFriendBlacklistCount;
		}
	}

	public int MaxRecentlyPlayerCount
	{
		get
		{
			if (maxRecentlyPlayerCount < 0)
			{
				maxRecentlyPlayerCount = Singleton<OuterSystem>.Instance.GetConstantConfigInt(Constant.ConstantConfig.MaxCountRecentTeam, 20);
			}
			return maxRecentlyPlayerCount;
		}
	}

	public List<PlayerData> FriendsData => _friendsData;

	public List<PlayerData> FriendApplyData => _friendApplyData;

	public List<PlayerData> BlackListData => _blackListData;

	public List<PlayerData> RecentlyPlayerData => _recentlyPlayerData;

	public InteractionRequest<PlayerInfoViewModel> OpenPlayerInfoRequest => openPlayerInfoRequest;

	public InteractionRequest FriendListChangeRequest => friendListChangeRequest;

	public InteractionRequest FriendApplyListChangeRequest => friendApplyListChangeRequest;

	public InteractionRequest BlackListChangeRequest => blackListChangeRequest;

	public InteractionRequest RecentlyPlayerChangeRst => recentlyPlayerChangeRst;

	public InteractionRequest<long> FriendChatDataChangeRequest => friendChatDataChangeRequest;

	public void ClearFriendData()
	{
		_friendsData?.Clear();
	}

	public void InitFriendData(List<PlayerData> friendDatas)
	{
		if (friendDatas != null)
		{
			foreach (PlayerData friendData in friendDatas)
			{
				AddFriend(friendData, uiNotify: false);
			}
		}
		FriendListChangeRequest.Raise();
		RecentlyPlayerChangeRst.Raise();
	}

	public void InitApplyData(List<PlayerData> applyDatas)
	{
		_friendApplyData.Clear();
		if (applyDatas != null)
		{
			_friendApplyData = applyDatas;
		}
	}

	public void InitBlackListData(List<PlayerData> blackList)
	{
		_blackListData.Clear();
		if (blackList != null)
		{
			_blackListData = blackList;
		}
	}

	public void InitRecentlyPlayerData(List<PlayerData> recentlyDatas)
	{
		_recentlyPlayerData.Clear();
		if (recentlyDatas != null)
		{
			_recentlyPlayerData = recentlyDatas;
		}
		RecentlyPlayerChangeRst.Raise();
	}

	public void InitFriendChatData(Dictionary<long, List<PlayerChatData>> chatData)
	{
		_friendChatData.Clear();
		if (chatData != null)
		{
			_friendChatData = chatData;
		}
	}

	public bool CheckFriendExist(long uid)
	{
		return _friendsData.Exists((PlayerData p) => p.Uid.Equals(uid));
	}

	public bool CheckApplyExist(long uid)
	{
		return _friendApplyData.Exists((PlayerData p) => p.Uid.Equals(uid));
	}

	public bool CheckBlackListExist(long uid)
	{
		return _blackListData.Exists((PlayerData p) => p.Uid.Equals(uid));
	}

	public bool CheckRecentlyPlayerExist(long uid)
	{
		return _recentlyPlayerData.Exists((PlayerData p) => p.Uid.Equals(uid));
	}

	public bool AddFriend(PlayerData data, bool uiNotify = true)
	{
		if (CheckFriendExist(data.Uid))
		{
			return false;
		}
		_friendsData.Add(data);
		if (uiNotify)
		{
			FriendListChangeRequest.Raise();
		}
		if (CheckRecentlyPlayerExist(data.Uid))
		{
			GetTargetRecentlyPlayer(data.Uid).SetRelationShip(PlayerData.RelationState.Friend);
			if (uiNotify)
			{
				RecentlyPlayerChangeRst.Raise();
			}
		}
		return true;
	}

	public bool DeleteFriend(long uid)
	{
		if (_friendsData.RemoveAll((PlayerData p) => p.Uid.Equals(uid)) > 0)
		{
			DeleteFriendChatData(uid);
			FriendListChangeRequest.Raise();
			if (CheckRecentlyPlayerExist(uid))
			{
				GetTargetRecentlyPlayer(uid).SetRelationShip(PlayerData.RelationState.Stranger);
				RecentlyPlayerChangeRst.Raise();
			}
			return true;
		}
		return false;
	}

	public bool AddApply(PlayerData data)
	{
		DeleteApply(data.Uid, onchangedRaise: false);
		if (_friendApplyData.Count > MaxFriendApplyCount - 1)
		{
			_friendApplyData.RemoveAll((PlayerData x) => _friendApplyData.IndexOf(x) >= maxFriendApplyCount - 1);
		}
		_friendApplyData.Insert(0, data);
		FriendApplyListChangeRequest.Raise();
		return true;
	}

	public bool DeleteApply(long uid, bool onchangedRaise = true)
	{
		if (_friendApplyData.RemoveAll((PlayerData p) => p.Uid.Equals(uid)) > 0)
		{
			if (onchangedRaise)
			{
				FriendApplyListChangeRequest.Raise();
			}
			return true;
		}
		return false;
	}

	public bool AddPlayerToBlackList(PlayerData data)
	{
		if (CheckBlackListExist(data.Uid))
		{
			return false;
		}
		DeleteRecentlyPlayer(data.Uid);
		_blackListData.Add(data);
		BlackListChangeRequest.Raise();
		return true;
	}

	public bool RemovePlayerFromBlackList(long uid)
	{
		if (_blackListData.RemoveAll((PlayerData p) => p.Uid.Equals(uid)) > 0)
		{
			BlackListChangeRequest.Raise();
			return true;
		}
		return false;
	}

	public bool AddRecentlyPlayer(PlayerData data)
	{
		if (CheckRecentlyPlayerExist(data.Uid))
		{
			return false;
		}
		_recentlyPlayerData.Add(data);
		RecentlyPlayerChangeRst.Raise();
		return true;
	}

	public bool DeleteRecentlyPlayer(long uid)
	{
		if (_recentlyPlayerData.RemoveAll((PlayerData p) => p.Uid.Equals(uid)) > 0)
		{
			RecentlyPlayerChangeRst.Raise();
			return true;
		}
		return false;
	}

	public void AddFriendChatData(long uid, PlayerChatData chatData)
	{
		if (!_friendChatData.ContainsKey(uid))
		{
			_friendChatData.Add(uid, new List<PlayerChatData>());
		}
		_friendChatData[uid].Add(chatData);
		friendChatDataChangeRequest.Raise(uid);
	}

	public void AddFriendChatData(long uid, List<PlayerChatData> chatDatas)
	{
		if (chatDatas == null)
		{
			return;
		}
		if (!_friendChatData.ContainsKey(uid))
		{
			_friendChatData[uid] = chatDatas;
		}
		else
		{
			foreach (PlayerChatData chatData in chatDatas)
			{
				_friendChatData[uid].Add(chatData);
			}
		}
		friendChatDataChangeRequest.Raise(uid);
	}

	public bool DeleteFriendChatData(long uid)
	{
		return _friendChatData.Remove(uid);
	}

	public void SetChatDataReadStateWithFriend(long uid, bool read)
	{
		if (!_friendChatData.ContainsKey(uid) || _friendChatData[uid] == null)
		{
			return;
		}
		foreach (PlayerChatData item in _friendChatData[uid])
		{
			item.SetReadState(read);
		}
	}

	public PlayerData GetTargetFriendData(long uid)
	{
		return _friendsData.Find((PlayerData p) => p.Uid.Equals(uid));
	}

	public PlayerData GetTargetApplyData(long uid)
	{
		return _friendApplyData.Find((PlayerData p) => p.Uid.Equals(uid));
	}

	public void ReceiveAllFriendEnergy()
	{
		_friendsData?.ForEach(delegate(PlayerData data)
		{
			data?.SetEnergyReceiveState(2);
		});
	}

	public void SendAllFriendEnergy()
	{
		_friendsData?.ForEach(delegate(PlayerData data)
		{
			data?.SetEnergySendState(1);
		});
	}

	public PlayerData GetTargetBlackListData(long uid)
	{
		return _blackListData.Find((PlayerData p) => p.Uid.Equals(uid));
	}

	public PlayerData GetTargetRecentlyPlayer(long uid)
	{
		return _recentlyPlayerData.Find((PlayerData p) => p.Uid.Equals(uid));
	}

	public List<PlayerChatData> GetFriendChatData(long uid)
	{
		if (_friendChatData.ContainsKey(uid))
		{
			return _friendChatData[uid];
		}
		return null;
	}

	public Dictionary<long, List<PlayerChatData>> GetAllFriendChatData()
	{
		return _friendChatData;
	}

	public List<PlayerData> GetAllFriendApplyData()
	{
		return _friendApplyData;
	}

	public void SetCurChatPlayer(PlayerData player)
	{
		curChatPlayer = player;
	}

	public void ResetCurChatPlayer()
	{
		curChatPlayer = null;
	}
}
