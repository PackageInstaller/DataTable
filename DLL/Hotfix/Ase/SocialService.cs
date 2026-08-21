#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class SocialService : ISocialService
{
	private FriendViewModel friendViewModel;

	private readonly IMessenger messenger;

	private ISubscription<GetFriendListInfoNotify> _getFriendListInfoNotify;

	private ISubscription<SOOpenNotifyMessager> subscription_SONotify;

	private ISubscription<UserFriendChangeNotify> _userFriendChangeNotify;

	private ISubscription<FriendChatMessageNotify> _friendChatMessageNotify;

	private ISubscription<FriendSendEnergyNotify> _friendSendEnergyNotify;

	private ISubscription<GameSettingConfigHelper.SettingData> _friendSettingChanged;

	private bool autoRefuseFriendApplication;

	public IMessenger GetMessager()
	{
		return messenger;
	}

	public SocialService()
	{
		friendViewModel = new FriendViewModel();
		messenger = Context.GetApplicationContext().GetService<IMessenger>();
		subscription_SONotify = messenger.Subscribe<SOOpenNotifyMessager>(OnSystemOpen);
		_getFriendListInfoNotify = Singleton<NetworkSystem>.Instance.Subscribe<GetFriendListInfoNotify>(FriendListInfoNotify);
		_userFriendChangeNotify = Singleton<NetworkSystem>.Instance.Subscribe<UserFriendChangeNotify>(UserFriendChangeNotify);
		_friendChatMessageNotify = Singleton<NetworkSystem>.Instance.Subscribe<FriendChatMessageNotify>(FriendChatMessageNotify);
		_friendSendEnergyNotify = Singleton<NetworkSystem>.Instance.Subscribe<FriendSendEnergyNotify>(FriendSendEnergyNotify);
		_friendSettingChanged = messenger.Subscribe("GameSetting_自动拒绝好友申请", delegate(GameSettingConfigHelper.SettingData setting)
		{
			FriendSettingChanged(setting.Value > 0f);
		});
		autoRefuseFriendApplication = GameEntry.Setting.GetBool("自动拒绝好友申请");
		Singleton<ServiceSystem>.Instance.GetService<ITimeService>()?.AddDailyUpdateAction(OnDailyUpdated);
	}

	private async void OnSystemOpen(SOOpenNotifyMessager messager)
	{
		if (messager.state && 70001 == messager.serviceId)
		{
			await RequestDatas();
		}
	}

	public async UniTask<bool> RequestDatas()
	{
		if (!Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(70001))
		{
			return true;
		}
		return await RequestFriendsData() & await RequestFriendApplyData() & await RequestBlackListData() & await RequestFriendChatData();
	}

	public void PublishSocialMessage(SocialMessageEnum messageEnum, object args)
	{
		messenger?.Publish(new SocialMessage(this, messageEnum, args));
	}

	private async void OnDailyUpdated()
	{
		await RequestFriendsData();
	}

	public void Dispose()
	{
		Singleton<ServiceSystem>.Instance.GetService<ITimeService>()?.RemoveDailyUpdateAction(OnDailyUpdated);
	}

	public FriendViewModel GetFriendViewModel()
	{
		return friendViewModel;
	}

	private void FriendListInfoNotify(GetFriendListInfoNotify notify)
	{
		if (notify == null)
		{
			return;
		}
		if (notify.FriendListType == 1)
		{
			List<PlayerData> list = new List<PlayerData>();
			if (notify.Friends != null)
			{
				foreach (PbFriendItemInfo friend in notify.Friends)
				{
					PlayerData item = new PlayerData(friend, PlayerData.RelationState.Friend).SetState(friend.State).SetEnergyReceiveState(friend.EnergyReceiveState).SetEnergySendState(friend.EnergySendState);
					list.Add(item);
				}
			}
			friendViewModel.InitFriendData(list);
		}
		else
		{
			if (notify.FriendListType != 2)
			{
				return;
			}
			List<PlayerData> list2 = new List<PlayerData>();
			if (notify.Friends != null)
			{
				foreach (PbFriendItemInfo friend2 in notify.Friends)
				{
					PlayerData.RelationState relationShip = ((!friendViewModel.CheckFriendExist(friend2.UserId)) ? PlayerData.RelationState.Stranger : PlayerData.RelationState.Friend);
					PlayerData item2 = new PlayerData(friend2, relationShip).SetState(friend2.State).SetEnergyReceiveState(friend2.EnergyReceiveState).SetEnergySendState(friend2.EnergySendState);
					list2.Add(item2);
				}
			}
			friendViewModel.InitRecentlyPlayerData(list2);
		}
	}

	private async void UserFriendChangeNotify(UserFriendChangeNotify notify)
	{
		PbFriendItemInfo friendInfo = notify.FriendInfo;
		if (notify.ChangeState == 1)
		{
			PlayerData data = new PlayerData(friendInfo, PlayerData.RelationState.Friend, notify.VertifyMessage).SetState(friendInfo.State).SetEnergyReceiveState(friendInfo.EnergyReceiveState).SetEnergySendState(friendInfo.EnergySendState);
			if (friendViewModel.AddFriend(data))
			{
				DeleteFriendApply(friendInfo.UserId);
			}
		}
		else if (notify.ChangeState == 2)
		{
			DeleteFriend(friendInfo.UserId, friendInfo);
		}
		else if (notify.ChangeState == 3)
		{
			if (autoRefuseFriendApplication)
			{
				await ReplyFriendRequest(friendInfo.UserId, reply: false);
				return;
			}
			PlayerData playerData = new PlayerData(friendInfo, PlayerData.RelationState.FriendApplying2Me, notify.VertifyMessage).SetState(friendInfo.State).SetEnergyReceiveState(friendInfo.EnergyReceiveState).SetEnergySendState(friendInfo.EnergySendState);
			AddFriendApply(playerData);
		}
		else if (notify.ChangeState == 4)
		{
			DeleteFriendApply(friendInfo.UserId, friendInfo);
		}
		else if (notify.ChangeState == 5)
		{
			DeleteFriend(friendInfo.UserId, friendInfo);
			DeleteFriendApply(friendInfo.UserId, friendInfo);
		}
	}

	private void FriendChatMessageNotify(FriendChatMessageNotify notify)
	{
		PlayerData targetFriendData = GetTargetFriendData(notify.UserId);
		if (targetFriendData != null)
		{
			bool flag = friendViewModel.CurChatPlayer == null || friendViewModel.CurChatPlayer.Uid != notify.UserId;
			PlayerChatData chatData = new PlayerChatData(targetFriendData, notify.ChatMessage, notify.SendTime, flag, notify.Bubble);
			AddFriendChatData(targetFriendData.Uid, chatData, flag);
		}
	}

	private void FriendSendEnergyNotify(FriendSendEnergyNotify notify)
	{
		if (notify != null && friendViewModel != null)
		{
			PlayerData targetFriendData = friendViewModel.GetTargetFriendData(notify.UserId);
			if (targetFriendData != null)
			{
				targetFriendData.SetEnergyReceiveState(1);
				PublishSocialMessage(SocialMessageEnum.ReceiveFriendSendEnergy, notify.Count);
			}
		}
	}

	private async void FriendSettingChanged(bool value)
	{
		autoRefuseFriendApplication = value;
		if (!autoRefuseFriendApplication || friendViewModel.FriendApplyData == null)
		{
			return;
		}
		List<long> list = new List<long>();
		foreach (PlayerData friendApplyDatum in friendViewModel.FriendApplyData)
		{
			list.Add(friendApplyDatum.Uid);
		}
		foreach (long item in list)
		{
			await ReplyFriendRequest(item, reply: false);
		}
	}

	public async UniTask<bool> RequestFriendsData()
	{
		GetFriendListRequest rst = GetFriendListRequest.Create();
		GetFriendListResponse response = null;
		friendViewModel.ClearFriendData();
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetFriendListResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取好友数据") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取好友数据失败"))
			{
				List<PlayerData> list = new List<PlayerData>();
				if (response.Friends != null)
				{
					foreach (PbFriendItemInfo friend in response.Friends)
					{
						PlayerData item = new PlayerData(friend, PlayerData.RelationState.Friend).SetState(friend.State).SetEnergyReceiveState(friend.EnergyReceiveState).SetEnergySendState(friend.EnergySendState);
						list.Add(item);
					}
				}
				friendViewModel.InitFriendData(list);
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<bool> RequestFriendApplyData()
	{
		GetFriendApplicationRequest rst = GetFriendApplicationRequest.Create();
		GetFriendApplicationResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetFriendApplicationResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取好友申请数据") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取好友申请数据失败"))
			{
				List<PlayerData> friendApplyDatas = new List<PlayerData>();
				if (response.Friends != null)
				{
					foreach (PbFriendApplicationInfo friend in response.Friends)
					{
						PbFriendItemInfo friendInfo = friend.FriendInfo;
						if (autoRefuseFriendApplication)
						{
							await ReplyFriendRequest(friendInfo.UserId, reply: false);
							continue;
						}
						PlayerData item = new PlayerData(friendInfo, PlayerData.RelationState.FriendApplying2Me, friend.VertifyMessage).SetState(friendInfo.State).SetEnergyReceiveState(friendInfo.EnergyReceiveState).SetEnergySendState(friendInfo.EnergySendState);
						friendApplyDatas.Add(item);
					}
				}
				friendViewModel.InitApplyData(friendApplyDatas);
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<bool> RequestBlackListData()
	{
		GetFriendBlackListRequest rst = GetFriendBlackListRequest.Create();
		GetFriendBlackListResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetFriendBlackListResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取好友黑名单数据") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取好友黑名单数据失败"))
			{
				List<PlayerData> list = new List<PlayerData>();
				if (response.FriendInfo != null)
				{
					foreach (PbFriendItemInfo item2 in response.FriendInfo)
					{
						PlayerData item = new PlayerData(item2, PlayerData.RelationState.BlackList).SetState(item2.State).SetEnergyReceiveState(item2.EnergyReceiveState).SetEnergySendState(item2.EnergySendState);
						list.Add(item);
					}
				}
				friendViewModel.InitBlackListData(list);
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<bool> RequestFriendChatData()
	{
		Dictionary<long, List<PlayerChatData>> chatData = new Dictionary<long, List<PlayerChatData>>();
		GetFriendChatHistoryMessageRequest rst = GetFriendChatHistoryMessageRequest.Create();
		GetFriendChatHistoryMessageResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetFriendChatHistoryMessageResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取未读聊天数据") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取未读聊天数据失败"))
			{
				if (response.Messages == null)
				{
					return true;
				}
				foreach (PbFriendChatHistoryMessage message in response.Messages)
				{
					if (message.UnreadMessage == null)
					{
						continue;
					}
					PlayerData targetFriendData = friendViewModel.GetTargetFriendData(message.UserId);
					if (targetFriendData == null)
					{
						continue;
					}
					if (!chatData.ContainsKey(message.UserId))
					{
						chatData.Add(message.UserId, new List<PlayerChatData>());
					}
					foreach (PbFriendChatMessage item in message.UnreadMessage)
					{
						chatData[message.UserId].Add(new PlayerChatData(targetFriendData, item.ChatMessage, item.SendTime, unRead: true, item.Bubble));
					}
				}
				foreach (long key in chatData.Keys)
				{
					chatData[key].Sort((PlayerChatData a, PlayerChatData b) => a.ChatTime.CompareTo(b.ChatTime));
				}
				friendViewModel.InitFriendChatData(chatData);
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<bool> AddFriend(PlayerData playerData, string verifyMessage)
	{
		if (friendViewModel.CheckFriendExist(playerData.Uid))
		{
			return false;
		}
		ApplyFriendRequest rst = ApplyFriendRequest.Create();
		rst.UserId = playerData.Uid;
		rst.VerifyMessage = verifyMessage;
		ApplyFriendResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<ApplyFriendResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "好友申请") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "好友申请失败"))
			{
				Toast.ShowInfo("已向对方发送好友申请");
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<bool> AddFriend(long uid, string verifyMessage)
	{
		if (friendViewModel.CheckFriendExist(uid))
		{
			return false;
		}
		ApplyFriendRequest rst = ApplyFriendRequest.Create();
		rst.UserId = uid;
		rst.VerifyMessage = verifyMessage;
		ApplyFriendResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<ApplyFriendResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "好友申请") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "好友申请失败"))
			{
				Toast.ShowInfo("已向对方发送好友申请");
				return true;
			}
			Toast.ShowInfo("发送好友申请失败");
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<bool> DelFriend(long uid)
	{
		if (!friendViewModel.CheckFriendExist(uid))
		{
			return false;
		}
		DeleteFriendRequest rst = DeleteFriendRequest.Create();
		rst.UserId = uid;
		DeleteFriendResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<DeleteFriendResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "删除好友") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "删除好友失败"))
			{
				return friendViewModel.DeleteFriend(uid);
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<bool> HandleFriendBlackList(PlayerData playerData, bool ope)
	{
		bool flag = friendViewModel.CheckBlackListExist(playerData.Uid);
		if ((ope & flag) || (!ope && !flag))
		{
			return false;
		}
		int ope2 = (ope ? 1 : 2);
		string handleType = (ope ? "拉黑玩家" : "解除拉黑");
		HandleFriendBlackListRequest rst = HandleFriendBlackListRequest.Create();
		rst.Ope = ope2;
		rst.UserId = playerData.Uid;
		HandleFriendBlackListResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<HandleFriendBlackListResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, handleType) && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, handleType + "失败"))
			{
				_ = response.FriendInfo;
				if (!ope)
				{
					return friendViewModel.RemovePlayerFromBlackList(playerData.Uid);
				}
				DeleteFriend(playerData.Uid, playerData);
				DeleteFriendApply(playerData.Uid, playerData);
				return friendViewModel.AddPlayerToBlackList(playerData.SetRelationShip(PlayerData.RelationState.BlackList));
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<bool> SendFriendChatMessage(long uid, string chatMessage)
	{
		SendFriendChatMessageRequest rst = SendFriendChatMessageRequest.Create();
		rst.UserId = uid;
		rst.ChatMessage = chatMessage;
		SendFriendChatMessageResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<SendFriendChatMessageResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "发送好友信息") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "发送好友信息失败"))
			{
				PlayerData playerData = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().GetPlayerData();
				AddFriendChatData(uid, new PlayerChatData(playerData, response.ChatMessage, TimeHelper.ClientNowSeconds(), unRead: false, Singleton<ServiceSystem>.Instance.GetService<IBFBEService>()?.GetChatBubble() ?? 0));
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<PlayerData> RequestSearchPlayer(long uid)
	{
		SearchUserForApplyFriendsRequest rst = SearchUserForApplyFriendsRequest.Create();
		rst.UserId = uid;
		PlayerData playerData = null;
		SearchUserForApplyFriendsResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<SearchUserForApplyFriendsResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "搜索玩家并进行好友操作") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "搜索玩家数据失败", showToast: false))
			{
				long userId = response.FriendInfo.UserId;
				playerData = new PlayerData(relationShip: friendViewModel.CheckFriendExist(userId) ? PlayerData.RelationState.Friend : (friendViewModel.CheckApplyExist(userId) ? PlayerData.RelationState.FriendApplying2Me : ((!friendViewModel.CheckBlackListExist(userId)) ? PlayerData.RelationState.Stranger : PlayerData.RelationState.BlackList)), friendInfo: response.FriendInfo);
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return playerData;
	}

	public async UniTask<bool> ReplyFriendRequest(long uid, bool reply)
	{
		int ope = (reply ? 1 : 2);
		HandleFriendApplicationRequest rst = HandleFriendApplicationRequest.Create();
		rst.UserId = uid;
		rst.Ope = ope;
		HandleFriendApplicationResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<HandleFriendApplicationResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "回应好友申请") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "回应好友申请失败"))
			{
				bool num = DeleteFriendApply(uid);
				bool flag = true;
				if (reply)
				{
					PbFriendItemInfo friendInfo = response.FriendInfo;
					PlayerData data = new PlayerData(friendInfo, PlayerData.RelationState.Friend).SetState(friendInfo.State).SetEnergyReceiveState(friendInfo.EnergyReceiveState).SetEnergySendState(friendInfo.EnergySendState);
					flag = friendViewModel.AddFriend(data);
				}
				return num & flag;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public PlayerData GetTargetFriendData(long uid)
	{
		return friendViewModel.GetTargetFriendData(uid);
	}

	public PlayerData GetTargetFriendApplyData(long uid)
	{
		return friendViewModel.GetTargetApplyData(uid);
	}

	public List<PlayerChatData> GetFriendChatDatas(long uid)
	{
		return friendViewModel?.GetFriendChatData(uid);
	}

	public void SetChatDataReadStateWithFriend(long uid, bool read)
	{
		friendViewModel?.SetChatDataReadStateWithFriend(uid, read);
		PublishSocialMessage(SocialMessageEnum.ReadFriendChat, uid);
	}

	public async UniTask<bool> RequestSendFriendEnergy(long uid)
	{
		SendFriendEnergyRequest rst = SendFriendEnergyRequest.Create();
		rst.TargetUserId = uid;
		SendFriendEnergyResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<SendFriendEnergyResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "赠送好友体力") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "赠送好友体力失败"))
			{
				if (uid > 0)
				{
					Toast.ShowInfo("已向对方赠送体力");
					friendViewModel.GetTargetFriendData(uid)?.SetEnergySendState(1);
				}
				else
				{
					Toast.ShowInfo("已赠送体力");
					friendViewModel.SendAllFriendEnergy();
				}
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<bool> RequestGetFriendSendEnergy(long uid)
	{
		GetFriendSendEnergyRequest rst = GetFriendSendEnergyRequest.Create();
		rst.TargetUserId = uid;
		GetFriendSendEnergyResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetFriendSendEnergyResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, $"领取好友{uid}赠送的体力") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, $"领取好友{uid}赠送的体力失败"))
			{
				Toast.ShowInfo("领取成功");
				if (uid > 0)
				{
					friendViewModel.GetTargetFriendData(uid)?.SetEnergyReceiveState(2);
				}
				else
				{
					friendViewModel.ReceiveAllFriendEnergy();
				}
				MoneyDefinition.AddMoney(RoleMoneyEnum.Energy, response.EnergyDelta);
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<PlayerData> GetTargetGameUserInfo(long uid)
	{
		GetFriendDetailInfoRequest rst = GetFriendDetailInfoRequest.Create();
		rst.UserId = uid;
		GetFriendDetailInfoResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetFriendDetailInfoResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, $"获取{uid}玩家的信息") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, $"获取{uid}玩家的信息失败"))
			{
				long userId = response.FriendDetailInfo.UserId;
				new PlayerData(relationShip: friendViewModel.CheckFriendExist(userId) ? PlayerData.RelationState.Friend : (friendViewModel.CheckApplyExist(userId) ? PlayerData.RelationState.FriendApplying2Me : ((!friendViewModel.CheckBlackListExist(userId)) ? PlayerData.RelationState.Stranger : PlayerData.RelationState.BlackList)), friendInfo: response.FriendDetailInfo);
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return null;
	}

	private bool DeleteFriend(long uid, object arg = null)
	{
		bool num = friendViewModel.DeleteFriend(uid);
		if (num)
		{
			PublishSocialMessage(SocialMessageEnum.DelFriend, arg);
		}
		return num;
	}

	private void AddFriendChatData(long uid, PlayerChatData chatData, bool publish = false)
	{
		friendViewModel.AddFriendChatData(uid, chatData);
		if (publish)
		{
			PublishSocialMessage(SocialMessageEnum.ReceiveFriendChat, chatData);
		}
	}

	private bool AddFriendApply(PlayerData playerData)
	{
		bool num = friendViewModel.AddApply(playerData);
		if (num)
		{
			PublishSocialMessage(SocialMessageEnum.AddFriendApplication, playerData);
		}
		return num;
	}

	private bool DeleteFriendApply(long uid, object arg = null)
	{
		bool num = friendViewModel.DeleteApply(uid);
		if (num)
		{
			PublishSocialMessage(SocialMessageEnum.DelFriendApplication, arg);
		}
		return num;
	}
}
