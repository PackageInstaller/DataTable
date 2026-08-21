#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using Newtonsoft.Json;
using UnityEngine;

namespace Ase;

public class GuildService : IGuildService
{
	private string eventMsgPref = "GuildEventMsg_";

	private MyGuildData myGuildData;

	private Dictionary<long, Timer> guildApplyCoolingTimers = new Dictionary<long, Timer>();

	private Dictionary<long, Timer> invitePlayerCoolingTimers = new Dictionary<long, Timer>();

	private readonly IMessenger messenger;

	private ISubscription<UnionChangeNotify> unionChangeNotify;

	private ISubscription<InviteUserToUnionNotify> guildInvitationNotify;

	private ISubscription<UnionNewApplicationNotify> newApplicationNotify;

	private ISubscription<UnionMemberChangeNotify> memberChangeNotify;

	private ISubscription<UnionStateNotify> unionStateNotify;

	private ISubscription<UnionEventNotify> eventNotify;

	private ISubscription<UnionRecruitMemberNotify> recruitMemberNotify;

	private ISubscription<UnionTaskProcessChangeNotify> taskProcessChangeNotify;

	private ISubscription<UnionMemberPositionChangeNotify> positionChangeNotify;

	private ISubscription<UnionInfoChangeNotify> unionInfoChangeNotify;

	private ISubscription<PropChangeMessage> knapsackChangeNotify;

	private ISubscription<ModelChangeNotify> guildActivityChangeNotify;

	private GuildActivityExpeditionData expeditionData;

	public MyGuildData GetMyGuildData()
	{
		return myGuildData;
	}

	public void GetGuildApplicationState(long guildUid, out bool isCooling, out float leftTime)
	{
		isCooling = false;
		leftTime = 0f;
		if (guildApplyCoolingTimers.TryGetValue(guildUid, out var value) && value != null)
		{
			isCooling = !value.isDone;
			leftTime = (value.isDone ? 0f : value.GetTimeRemaining());
		}
	}

	public void GetPlayerInvitationState(long guildUid, out bool isCooling, out float leftTime)
	{
		isCooling = false;
		leftTime = 0f;
		if (invitePlayerCoolingTimers.TryGetValue(guildUid, out var value) && value != null)
		{
			isCooling = !value.isDone;
			leftTime = (value.isDone ? 0f : value.GetTimeRemaining());
		}
	}

	public bool GuildMemberCheck(long playerUid)
	{
		if (myGuildData == null || myGuildData.Members == null)
		{
			return false;
		}
		return myGuildData.Members.Exists((GuildMemberData p) => p.Uid == playerUid);
	}

	public void PublishMessage(GuildMessageEnum messageEnum, object args)
	{
		messenger?.Publish(new GuildMessage(this, messageEnum, args));
	}

	public GuildEventMsgJsonData LoadEventMsgDatas(long uid)
	{
		return JsonConvert.DeserializeObject<GuildEventMsgJsonData>(PlayerPrefs.GetString($"{eventMsgPref}{uid}")) ?? new GuildEventMsgJsonData();
	}

	private bool SaveEventMsgDatas()
	{
		if (myGuildData == null)
		{
			return false;
		}
		string value = JsonConvert.SerializeObject(new GuildEventMsgJsonData
		{
			datas = myGuildData.EventMsgDatas
		});
		PlayerPrefs.SetString($"{eventMsgPref}{myGuildData.Uid}", value);
		return true;
	}

	public GuildService()
	{
		messenger = Context.GetApplicationContext().GetService<IMessenger>();
		unionChangeNotify = Singleton<NetworkSystem>.Instance.Subscribe<UnionChangeNotify>(OnUnionChangeNotify);
		guildInvitationNotify = Singleton<NetworkSystem>.Instance.Subscribe<InviteUserToUnionNotify>(OnGuildInvitationNotify);
		newApplicationNotify = Singleton<NetworkSystem>.Instance.Subscribe<UnionNewApplicationNotify>(OnNewApplicationNotify);
		memberChangeNotify = Singleton<NetworkSystem>.Instance.Subscribe<UnionMemberChangeNotify>(OnMemberChangeNotify);
		unionStateNotify = Singleton<NetworkSystem>.Instance.Subscribe<UnionStateNotify>(OnGuildStateChangeNotify);
		eventNotify = Singleton<NetworkSystem>.Instance.Subscribe<UnionEventNotify>(OnUnionEventNotify);
		recruitMemberNotify = Singleton<NetworkSystem>.Instance.Subscribe<UnionRecruitMemberNotify>(OnRecruitMemberNotify);
		taskProcessChangeNotify = Singleton<NetworkSystem>.Instance.Subscribe<UnionTaskProcessChangeNotify>(OnTaskProcessChangeNotify);
		positionChangeNotify = Singleton<NetworkSystem>.Instance.Subscribe<UnionMemberPositionChangeNotify>(OnGuildPositionChangeNotify);
		unionInfoChangeNotify = Singleton<NetworkSystem>.Instance.Subscribe<UnionInfoChangeNotify>(OnUnionInfoChangeNotify);
		knapsackChangeNotify = Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().GetMessager().Subscribe<PropChangeMessage>(OnKnapsackChanged);
		Singleton<ServiceSystem>.Instance.GetService<ITimeService>()?.AddDailyUpdateAction(OnDailyUpdated);
	}

	private async void OnUnionChangeNotify(UnionChangeNotify notify)
	{
		if (notify.ChangeState == 1)
		{
			await RequestMyGuildData();
			await RequestGuildActivityExpeditionData();
			if (myGuildData != null)
			{
				Toast.ShowInfo("成功加入公会");
				PublishMessage(GuildMessageEnum.JoinInGuild, myGuildData);
			}
		}
		else if (notify.ChangeState == 2)
		{
			ClearActivityExpeditionData();
			myGuildData?.Dispose();
			myGuildData = null;
			GuildMessageEnum messageEnum = GuildMessageEnum.None;
			string text = string.Empty;
			if (notify.Reason == 1)
			{
				text = "公会已解散";
				messageEnum = GuildMessageEnum.GuildDismissed;
			}
			else if (notify.Reason == 2)
			{
				text = "从公会中被请出";
				messageEnum = GuildMessageEnum.Kicked;
			}
			if (!string.IsNullOrEmpty(text))
			{
				Toast.ShowInfo(text);
			}
			PublishMessage(messageEnum, null);
		}
	}

	private void OnGuildInvitationNotify(InviteUserToUnionNotify notify)
	{
		if (Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().GetGameProcess() != GameProcessType.Outer || Singleton<ServiceSystem>.Instance.GetService<ISocialService>().GetFriendViewModel().CheckBlackListExist(notify.SendUserId))
		{
			return;
		}
		IAsyncResult<int> result = CountdownVerifyDialog.Show("公会邀请", notify.UserName, "邀请您加入公会：", notify.UnionName, GuildDefinition.GetInvitationCountdown(), "确定", "Confirm", "取消", "Cancel");
		result.Callbackable().OnCallback(delegate
		{
			if (result.Result == -1)
			{
				TryRequestReplyToInvitation(notify.UnionId, ope: true);
			}
			else if (result.Result == -2)
			{
				TryRequestReplyToInvitation(notify.UnionId, ope: false);
			}
		});
	}

	private async void OnNewApplicationNotify(UnionNewApplicationNotify notify)
	{
		await RequestGuildApplicationData();
		IRedPointService service = Singleton<ServiceSystem>.Instance.GetService<IRedPointService>();
		List<RedPointSave> redPoint = service.GetRedPoint(RedPointLocalSaveKeys.HeroVoiceClick);
		redPoint.RemoveAll((RedPointSave p) => p.keyId.Equals(notify.ApplyUserId));
		service.SaveRedPoint(redPoint, RedPointLocalSaveKeys.HeroVoiceClick);
		PublishMessage(GuildMessageEnum.NewApplication, myGuildData);
	}

	private void OnMemberChangeNotify(UnionMemberChangeNotify notify)
	{
		if (notify.MemberInfo == null)
		{
			myGuildData?.RemoveMember(notify.UserId);
		}
		else
		{
			myGuildData?.AddMember(GuildMemberData.Create(notify.MemberInfo));
		}
		PublishMessage(GuildMessageEnum.MemberChange, myGuildData);
	}

	private async void OnGuildStateChangeNotify(UnionStateNotify notify)
	{
		if (notify.State == 3)
		{
			myGuildData?.Dispose();
			myGuildData = null;
			Toast.ShowInfo("公会已解散");
			PublishMessage(GuildMessageEnum.GuildDismissed, null);
		}
		else if (notify.State == 2)
		{
			myGuildData?.SetLevel(notify.Level);
			await Singleton<ServiceSystem>.Instance.GetService<IShopService>().RequestShopDatas(GuildDefinition.GetGuildMainShopId());
			PublishMessage(GuildMessageEnum.GuildLevelChange, notify.Level);
		}
	}

	private void OnUnionEventNotify(UnionEventNotify notify)
	{
		if (myGuildData != null)
		{
			myGuildData.AddEventMsgDatas(new GuildEventMsgData
			{
				Type = notify.Type,
				Params = notify.Params,
				Time = DateTime.Now
			});
			SaveEventMsgDatas();
			PublishMessage(GuildMessageEnum.GuildEventNotify, notify);
		}
	}

	private void OnRecruitMemberNotify(UnionRecruitMemberNotify notify)
	{
		if (notify?.UserInfo != null)
		{
			FriendViewModel friendViewModel = Singleton<ServiceSystem>.Instance.GetService<ISocialService>()?.GetFriendViewModel();
			if (friendViewModel != null && !friendViewModel.CheckBlackListExist(notify.SendUserId))
			{
				ChatData chatData = new ChatData();
				chatData.name = notify.UserInfo.UserName;
				chatData.level = notify.UserInfo.Level;
				chatData.avatar = PlayerDataBase.GetIcon(notify.UserInfo.Icon);
				chatData.frameId = notify.UserInfo.IconFrame;
				chatData.titleId = notify.UserInfo.TitleId;
				chatData.uid = notify.SendUserId;
				chatData.bubble = notify.UserInfo.Bubble;
				long valueOrDefault = (Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.PlayerInfo?.Uid).GetValueOrDefault();
				chatData.isSend = notify.SendUserId == valueOrDefault;
				chatData.msg = $"公会招募：{notify.UnionName} Lv.{notify.UnionLevel}";
				chatData.argId = notify.UnionId;
				chatData.argTypeEnum = ChatMessageArgEnum.GuildInvite;
				Singleton<ServiceSystem>.Instance.GetService<IChatService>()?.OnReceiveNewMsg(notify.Channel, chatData);
				PublishMessage(GuildMessageEnum.RecruitMemberNotify, notify);
			}
		}
	}

	private void OnTaskProcessChangeNotify(UnionTaskProcessChangeNotify notify)
	{
		if (myGuildData != null && myGuildData.SetDailyTaskProcess(notify.TaskId, notify.Value) && myGuildData.DailyTasks.TryGetValue(notify.TaskId, out var value))
		{
			PublishMessage(GuildMessageEnum.TaskProcessChange, value);
		}
	}

	private async void OnGuildPositionChangeNotify(UnionMemberPositionChangeNotify notify)
	{
		if (notify == null || myGuildData == null)
		{
			return;
		}
		int newPosition = (int)notify.NewPosition;
		if (Enum.IsDefined(typeof(GuildDefinition.GuildPositions), newPosition))
		{
			int position = (int)myGuildData.Position;
			if (newPosition < position)
			{
				await RequestGuildApplicationData();
			}
			myGuildData.SetMyPosition((GuildDefinition.GuildPositions)newPosition);
		}
	}

	private void OnUnionInfoChangeNotify(UnionInfoChangeNotify notify)
	{
		if (notify != null)
		{
			if (notify.Type == 1)
			{
				myGuildData?.SetName(notify.Param);
			}
			else if (notify.Type == 3)
			{
				myGuildData?.SetFlag((GuildDefinition.Flag)notify.Value);
			}
			else if (notify.Type == 4)
			{
				myGuildData?.SetDescription(notify.Param);
			}
			else if (notify.Type == 5)
			{
				myGuildData?.SetFunds(notify.Value);
			}
			else if (notify.Type == 6)
			{
				myGuildData?.SetWeeklyActivePoint(notify.Value);
			}
			PublishMessage(GuildMessageEnum.GuildInfoChanged, myGuildData);
		}
	}

	private async void TryRequestReplyToInvitation(long uid, bool ope)
	{
		Loading loading = await Loading.Show();
		MyGuildData myGuildData = await RequestReplyToInvitation(uid, ope);
		loading?.Dispose();
		if (ope && myGuildData != null)
		{
			Toast.ShowInfo("成功加入公会");
			PublishMessage(GuildMessageEnum.JoinInGuild, this.myGuildData);
		}
	}

	private void OnKnapsackChanged(PropChangeMessage message)
	{
		myGuildData?.UpdateDailyTaskProgress();
	}

	private async void OnDailyUpdated()
	{
		await RequestMyGuildData();
	}

	public async UniTask<bool> RequestInitData()
	{
		await RequestMyGuildData();
		if (myGuildData != null)
		{
			await RequestGuildApplicationData();
			await RequestGuildActivityExpeditionData();
		}
		return true;
	}

	public async UniTask<MyGuildData> RequestMyGuildData()
	{
		if (!Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(70015))
		{
			return null;
		}
		GetUnionInfoRequest rst = GetUnionInfoRequest.Create();
		GetUnionInfoResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetUnionInfoResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取玩家公会数据") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取玩家公会数据失败"))
			{
				if (response.UnionInfo == null)
				{
					myGuildData = null;
					return null;
				}
				myGuildData = MyGuildData.Create(response.UnionInfo);
				myGuildData.SetUserInfo(response.UserUnionInfo);
				myGuildData.SetMembers(response.Members);
				myGuildData.InitDailyTasks(response.DailyTaskIds, response.UserDailyTaskDoneValues, response.DailyActiveRewardState);
				PublishMessage(GuildMessageEnum.GuildDataRefresh, myGuildData);
				return myGuildData;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return null;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return null;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public async UniTask<MyGuildData> RequestMyGuildBaseInfo()
	{
		GetUnionBaseInfoRequest rst = GetUnionBaseInfoRequest.Create();
		GetUnionBaseInfoResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetUnionBaseInfoResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取玩家基础公会数据") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取玩家基础公会数据失败"))
			{
				if (response.UnionInfo == null)
				{
					myGuildData = null;
					return null;
				}
				myGuildData?.SetInfo(response.UnionInfo);
				myGuildData?.SetUserInfo(response.UserUnionInfo);
				myGuildData?.SetMembers(response.Members);
				return myGuildData;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return null;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return null;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public async UniTask<List<PlayerDataBase>> RequestGuildApplicationData()
	{
		GetUnionApplicationsRequest rst = GetUnionApplicationsRequest.Create();
		GetUnionApplicationsResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetUnionApplicationsResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取公会申请数据") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取公会申请数据失败"))
			{
				myGuildData?.SetApplications(response.Applications);
				return myGuildData?.ApplyDatas;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return null;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return null;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public async UniTask<List<GuildData>> RequestRecommendGuildData(int type)
	{
		GetUnionListRequest rst = GetUnionListRequest.Create();
		rst.Type = type;
		GetUnionListResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetUnionListResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取推荐公会数据") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取推荐公会数据失败"))
			{
				List<GuildData> list = new List<GuildData>();
				if (response.UnionInfos != null)
				{
					foreach (PbUnionBaseInfo unionInfo in response.UnionInfos)
					{
						if (unionInfo != null)
						{
							list.Add(GuildData.Create(unionInfo));
						}
					}
				}
				return list;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return null;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return null;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public async UniTask<List<GuildData>> RefreshRecommendGuildData()
	{
		RefreshUnionListRequest rst = RefreshUnionListRequest.Create();
		RefreshUnionListResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<RefreshUnionListResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "刷新推荐公会数据") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "刷新推荐公会数据失败"))
			{
				List<GuildData> list = new List<GuildData>();
				if (response.Unions != null)
				{
					foreach (PbUnionBaseInfo union in response.Unions)
					{
						if (union != null)
						{
							list.Add(GuildData.Create(union));
						}
					}
				}
				return list;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return null;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return null;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public async UniTask<GuildData> RequestSearchGuild(string content)
	{
		SearchUnionRequest rst = SearchUnionRequest.Create();
		if (long.TryParse(content, out var result))
		{
			rst.Uuid = result;
		}
		else
		{
			rst.Name = content;
		}
		SearchUnionResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<SearchUnionResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "搜索公会") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "搜索公会失败") && response.UnionInfo != null)
			{
				return GuildData.Create(response.UnionInfo);
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return null;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return null;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public async UniTask<List<GuildData>> RequestGuildRankData()
	{
		GetUnionRankListRequest rst = GetUnionRankListRequest.Create();
		GetUnionRankListResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetUnionRankListResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "请求公会活跃度排行数据") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "请求公会活跃度排行数据失败"))
			{
				List<GuildData> list = new List<GuildData>();
				List<PbUnionRankInfo> unionRankInfos = response.UnionRankInfos;
				if (unionRankInfos == null)
				{
					return list;
				}
				unionRankInfos.Sort((PbUnionRankInfo x, PbUnionRankInfo y) => x.Rank.CompareTo(y.Rank));
				foreach (PbUnionRankInfo item in unionRankInfos)
				{
					if (item.UnionInfo != null)
					{
						GuildData guildData = GuildData.Create(item.UnionInfo);
						guildData.SetWeeklyActivePoint(item.WeeklyActivePoinit);
						list.Add(guildData);
					}
				}
				return list;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return null;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return null;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public async UniTask<GuildData> RequestCreateGuild(string name, string desc, int flag, int auditType, int levelThreshold)
	{
		CreateUnionRequest rst = CreateUnionRequest.Create();
		rst.Name = name;
		rst.Flag = flag;
		rst.Declaration = desc;
		rst.LevelLimit = levelThreshold;
		rst.Examine = auditType;
		CreateUnionResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<CreateUnionResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "创建公会") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "创建公会失败"))
			{
				if (response.UnionInfo == null)
				{
					return null;
				}
				if (response.CostItem != null)
				{
					PropHelper.AnalyzeRewardFromServer(new List<PbItemChange> { response.CostItem });
				}
				myGuildData = MyGuildData.Create(response.UnionInfo);
				myGuildData.SetMaster(GuildMemberData.Create(response.Member));
				myGuildData.SetMembers(new List<GuildMemberData> { myGuildData.Master });
				myGuildData.InitDailyTasks(response.DailyTaskIds, response.UserDailyTaskDoneValues, response.DailyActiveRewardState);
				PublishMessage(GuildMessageEnum.CreateGuild, myGuildData);
				Toast.ShowInfo("创建公会成功");
				await RequestGuildActivityExpeditionData();
				return myGuildData;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return null;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return null;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public async UniTask<bool> RequestChangeGuildFlag(int newFlag)
	{
		ModifyUnionInfoRequest rst = ModifyUnionInfoRequest.Create();
		rst.ChangeType = 4;
		rst.Flag = newFlag;
		ModifyUnionInfoResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<ModifyUnionInfoResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "修改公会定位") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "修改公会定位失败"))
			{
				myGuildData?.SetFlag((GuildDefinition.Flag)newFlag);
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return false;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<bool> RequestChangeGuildName(string newName)
	{
		ModifyUnionInfoRequest rst = ModifyUnionInfoRequest.Create();
		rst.ChangeType = 1;
		rst.Name = newName;
		ModifyUnionInfoResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<ModifyUnionInfoResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "修改公会名称") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "修改公会名称失败"))
			{
				myGuildData?.SetName(newName);
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return false;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<bool> RequestChangeGuildDesc(string newDesc)
	{
		ModifyUnionInfoRequest rst = ModifyUnionInfoRequest.Create();
		rst.ChangeType = 2;
		rst.Declaration = newDesc;
		ModifyUnionInfoResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<ModifyUnionInfoResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "修改公会宗旨") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "修改公会宗旨失败"))
			{
				myGuildData?.SetDescription(newDesc);
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return false;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<bool> RequestChangeAuditType(int newAuditType, int newLevelThreshold)
	{
		ModifyUnionInfoRequest rst = ModifyUnionInfoRequest.Create();
		rst.ChangeType = 3;
		rst.Examine = newAuditType;
		rst.LevelLimit = newLevelThreshold;
		ModifyUnionInfoResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<ModifyUnionInfoResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "修改公会审核方式") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "修改公会审核方式失败"))
			{
				if (Enum.IsDefined(typeof(GuildDefinition.AuditType), newAuditType))
				{
					myGuildData?.SetAuditInfo((GuildDefinition.AuditType)newAuditType, newLevelThreshold);
				}
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return false;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<MyGuildData> RequestJoinInGuildFast()
	{
		QuickJoinUnionRequest rst = QuickJoinUnionRequest.Create();
		QuickJoinUnionResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<QuickJoinUnionResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "快速加入公会") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "快速加入公会失败"))
			{
				return await RequestMyGuildData();
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return null;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return null;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public async UniTask<bool> RequestJoinInGuild(long uid, Action<long> coolingCompleteCb)
	{
		ApplyUnionRequest rst = ApplyUnionRequest.Create();
		rst.Uuid = uid;
		ApplyUnionResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<ApplyUnionResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "申请加入公会") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "申请加入公会失败"))
			{
				if (guildApplyCoolingTimers.TryGetValue(uid, out var value))
				{
					value.Cancel();
					guildApplyCoolingTimers.Remove(uid);
				}
				guildApplyCoolingTimers.Add(uid, Timer.Register(120f, delegate
				{
					guildApplyCoolingTimers.Remove(uid);
					coolingCompleteCb?.Invoke(uid);
				}, null, isLooped: false, useRealTime: true));
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return false;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<bool> RequestReplyToApplication(long uid, bool ope)
	{
		HandleUnionApplicationRequest rst = HandleUnionApplicationRequest.Create();
		rst.UserId = uid;
		rst.Ope = (ope ? 1 : 2);
		HandleUnionApplicationResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<HandleUnionApplicationResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "处理公会申请"))
			{
				if (Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "处理公会申请失败"))
				{
					myGuildData?.RemoveApplications(response.RemoveUserIds);
					return true;
				}
				myGuildData?.RemoveApplications(response.RemoveUserIds);
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return false;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<bool> RequestCleanApplication()
	{
		HandleUnionApplicationRequest rst = HandleUnionApplicationRequest.Create();
		rst.UserId = -1L;
		rst.Ope = 2;
		HandleUnionApplicationResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<HandleUnionApplicationResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "清空公会申请") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "清空公会申请失败"))
			{
				myGuildData?.RemoveAllApplication();
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return false;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<bool> RequestPassAllApplication()
	{
		HandleUnionApplicationRequest rst = HandleUnionApplicationRequest.Create();
		rst.UserId = -1L;
		rst.Ope = 1;
		HandleUnionApplicationResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<HandleUnionApplicationResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "通过所有公会申请"))
			{
				if (Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "通过所有公会申请失败"))
				{
					myGuildData?.RemoveApplications(response.RemoveUserIds);
					return true;
				}
				myGuildData?.RemoveApplications(response.RemoveUserIds);
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return false;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<bool> RequestInviteToGuild(long uid, bool haveCooling)
	{
		if (haveCooling)
		{
			GetPlayerInvitationState(uid, out var isCooling, out var _);
			if (isCooling)
			{
				Toast.ShowInfo("不可连续邀请");
				return false;
			}
		}
		InviteUserToUnionRequest rst = InviteUserToUnionRequest.Create();
		rst.UserId = new List<long> { uid };
		InviteUserToUnionResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<InviteUserToUnionResponse>(rst);
			myGuildData?.InvitePlayer(uid);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "发送公会邀请") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "发送公会邀请失败"))
			{
				if (haveCooling)
				{
					if (invitePlayerCoolingTimers.TryGetValue(uid, out var value))
					{
						value.Cancel();
						invitePlayerCoolingTimers.Remove(uid);
					}
					invitePlayerCoolingTimers.Add(uid, Timer.Register(20f, delegate
					{
						invitePlayerCoolingTimers.Remove(uid);
					}, null, isLooped: false, useRealTime: true));
				}
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return false;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<MyGuildData> RequestReplyToInvitation(long guildUid, bool ope)
	{
		HandleUnionInvitationRequest rst = HandleUnionInvitationRequest.Create();
		rst.UnionId = guildUid;
		rst.Ope = (ope ? 1 : 2);
		HandleUnionInvitationResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<HandleUnionInvitationResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "回复公会邀请") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "回复公会邀请失败") && ope)
			{
				return await RequestMyGuildData();
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return null;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return null;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public async UniTask<List<PlayerDataBase>> RequestRecommendPlayers()
	{
		GetRecomandMemberRequest rst = GetRecomandMemberRequest.Create();
		GetRecomandMemberResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetRecomandMemberResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取推荐玩家招募数据") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取推荐玩家招募数据失败"))
			{
				List<PlayerDataBase> list = new List<PlayerDataBase>();
				if (response.RecomandUsers != null)
				{
					foreach (PbRecommandUserInfo recomandUser in response.RecomandUsers)
					{
						list.Add(PlayerDataBase.Create(recomandUser.UserId, recomandUser.Name, recomandUser.Level, recomandUser.Icon, recomandUser.Frame));
					}
				}
				myGuildData?.SetRecommendPlayers(list);
				return list;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return null;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return null;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public async UniTask<bool> RequestSendRecruitInfo()
	{
		RecuitUnionMemberRequest rst = RecuitUnionMemberRequest.Create();
		RecuitUnionMemberResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<RecuitUnionMemberResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "发送公会招募") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "发送公会招募失败"))
			{
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return false;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<bool> RequestInviteAll(List<long> uidList)
	{
		InviteUserToUnionRequest rst = InviteUserToUnionRequest.Create();
		rst.UserId = uidList;
		InviteUserToUnionResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<InviteUserToUnionResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "发送公会邀请") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "发送公会邀请失败"))
			{
				myGuildData?.InviteAllPlayer();
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return false;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<bool> RequestBuildGuild()
	{
		UpgradeUnionLevelRequest rst = UpgradeUnionLevelRequest.Create();
		UpgradeUnionLevelResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<UpgradeUnionLevelResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "公会升级") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "公会升级失败"))
			{
				myGuildData.SetLevel(response.Level);
				myGuildData.SetFunds(response.UnionMoney);
				PublishMessage(GuildMessageEnum.GuildLevelChange, response.Level);
				PublishMessage(GuildMessageEnum.GuildAssetChange, myGuildData);
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return false;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<bool> RequestChangeMemberPosition(long memberUid, int newPosition)
	{
		ModifyUnionMemberPositionRequest rst = ModifyUnionMemberPositionRequest.Create();
		rst.UserId = memberUid;
		rst.NewPosition = newPosition;
		ModifyUnionMemberPositionResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<ModifyUnionMemberPositionResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "调整成员职位") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "调整成员职位失败"))
			{
				myGuildData?.ModifyMemberPosition(memberUid, newPosition);
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return false;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<bool> RequestTransMaster(long memberUid)
	{
		TransUnionLeaderRequest rst = TransUnionLeaderRequest.Create();
		rst.NewLeaderId = memberUid;
		TransUnionLeaderResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<TransUnionLeaderResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "转让会长") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "转让会长失败"))
			{
				long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().GetPlayerData()
					.Uid;
				myGuildData?.TransMaster(memberUid, uid);
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return false;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<bool> RequestKickMember(long memberUid)
	{
		KickUnionMemberRequest rst = KickUnionMemberRequest.Create();
		rst.UserId = memberUid;
		KickUnionMemberResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<KickUnionMemberResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "辞退成员") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "辞退成员失败"))
			{
				myGuildData?.KickMember(memberUid);
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return false;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<bool> RequestExitGuild()
	{
		ExitUnionRequest rst = ExitUnionRequest.Create();
		ExitUnionResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<ExitUnionResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "退出公会") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "退出公会失败"))
			{
				myGuildData?.Dispose();
				myGuildData = null;
				Singleton<ServiceSystem>.Instance.GetService<IGuildService>()?.PublishMessage(GuildMessageEnum.ExitGuild, null);
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return false;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<List<GuildTaskData>> RequestGuildTaskData()
	{
		return null;
	}

	public async UniTask<bool> RequestCompleteGuildTask(int taskId)
	{
		UnionTaskCompleteRequest rst = UnionTaskCompleteRequest.Create();
		rst.TaskId = taskId;
		UnionTaskCompleteResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<UnionTaskCompleteResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "完成公会任务") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "完成公会任务失败"))
			{
				if (response.CostItem != null)
				{
					Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>()?.AddProp(KnapsackPropData.Create(response.CostItem.ItemId, (int)response.CostItem.ItemDelta));
				}
				myGuildData?.SetDailyTaskState(taskId, GuildTaskState.Finished);
				myGuildData?.AddMyNewActivePoint(response.ActivePointReward);
				myGuildData?.AddNewActivePoint(response.UnionActivePointReward);
				Singleton<ServiceSystem>.Instance.GetService<IGuildService>()?.PublishMessage(GuildMessageEnum.GuildAssetChange, myGuildData);
				Singleton<ServiceSystem>.Instance.GetService<IGuildService>()?.PublishMessage(GuildMessageEnum.TaskProcessChange, myGuildData);
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return false;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<RewardGetData> RequestGetActivityReward(int rewardLevel)
	{
		GetUnionDailyActiveRewardRequest rst = GetUnionDailyActiveRewardRequest.Create();
		rst.RewardLevel = rewardLevel;
		GetUnionDailyActiveRewardResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetUnionDailyActiveRewardResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "公会活跃度奖励领取") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "公会活跃度奖励领取失败"))
			{
				myGuildData?.SetDailyActiveRewardState(rewardLevel, got: true);
				myGuildData?.SetFunds(response.UnionFund);
				RewardGetData result = await PropHelper.AnalyzeRewardFromServer(response.Rewards);
				Singleton<ServiceSystem>.Instance.GetService<IGuildService>()?.PublishMessage(GuildMessageEnum.GuildAssetChange, myGuildData);
				return result;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return null;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return null;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public async UniTask<RewardGetData> RequestGetAllActivityReward(List<int> levelsCanGet)
	{
		if (levelsCanGet == null || levelsCanGet.Count <= 0)
		{
			return null;
		}
		GetUnionDailyActiveRewardRequest rst = GetUnionDailyActiveRewardRequest.Create();
		rst.RewardLevel = levelsCanGet[0];
		GetUnionDailyActiveRewardResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetUnionDailyActiveRewardResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "公会活跃度奖励领取") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "公会活跃度奖励领取失败"))
			{
				foreach (int item in levelsCanGet)
				{
					myGuildData?.SetDailyActiveRewardState(item, got: true);
				}
				myGuildData?.SetFunds(response.UnionFund);
				RewardGetData result = await PropHelper.AnalyzeRewardFromServer(response.Rewards);
				Singleton<ServiceSystem>.Instance.GetService<IGuildService>()?.PublishMessage(GuildMessageEnum.GuildAssetChange, myGuildData);
				return result;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return null;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return null;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public void Dispose()
	{
		Singleton<ServiceSystem>.Instance.GetService<ITimeService>()?.RemoveDailyUpdateAction(OnDailyUpdated);
	}

	public GuildActivityExpeditionData GetGuildActivityData()
	{
		return CreateExpeditionData();
	}

	private GuildActivityExpeditionData CreateExpeditionData()
	{
		if (expeditionData == null)
		{
			expeditionData = GuildActivityExpeditionData.Create(1);
			expeditionData.AddTimeDuraValid();
		}
		return expeditionData;
	}

	public void OnGuildActivityChange(bool isActive)
	{
		if (isActive && guildActivityChangeNotify == null)
		{
			guildActivityChangeNotify = Singleton<NetworkSystem>.Instance.Subscribe<ModelChangeNotify>(OnGuildActivityChangeNotify);
		}
		if (!isActive && guildActivityChangeNotify != null)
		{
			guildActivityChangeNotify.Dispose();
			guildActivityChangeNotify = null;
		}
	}

	private void ClearActivityExpeditionData()
	{
		if (expeditionData != null)
		{
			expeditionData.Dispose();
		}
		PublishMessage(GuildMessageEnum.GuildActivityChange, null);
	}

	private async void OnGuildActivityChangeNotify(ModelChangeNotify notify)
	{
		await RequestGuildActivityExpeditionData();
	}

	public async UniTask<bool> RequestGuildActivityExpeditionData()
	{
		if (!Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(70015))
		{
			return true;
		}
		C2SGetUnionCopyInfoRequest rst = C2SGetUnionCopyInfoRequest.Create();
		S2CGetUnionCopyInfoResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<S2CGetUnionCopyInfoResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取公会远征数据") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取公会远征数据失败"))
			{
				if (expeditionData == null)
				{
					CreateExpeditionData();
				}
				for (int i = 0; i < response.CopyInfos.Count; i++)
				{
					expeditionData.GetGuildCopyDataByCopyId(response.CopyInfos[i].Id)?.RefreshGuildCopyData(response.CopyInfos[i].Num, response.CopyInfos[i].PassState, response.CopyInfos[i].RewardState);
				}
				expeditionData.RefreshExpeditionData(response.ChallengeNum, response.Score);
				PublishMessage(GuildMessageEnum.GuildActivityChange, null);
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return false;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return true;
	}

	public async UniTask<RewardThings> RequestGuildActivityExpeditionReward(int copyId)
	{
		if (!Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(70015))
		{
			return null;
		}
		C2SGetUnionRewardRequest rst = C2SGetUnionRewardRequest.Create();
		rst.RewardId = copyId;
		rst.RewardType = 0;
		S2CGetUnionRewardResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<S2CGetUnionRewardResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取公会远征副本奖励") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取公会远征副本奖励失败"))
			{
				RewardGetData obj = await PropHelper.AnalyzeRewardFromServer(response.Rewards);
				expeditionData.GetGuildCopyDataByCopyId(response.CopyInfo.Id)?.RefreshGuildCopyData(response.CopyInfo.Num, response.CopyInfo.PassState, response.CopyInfo.RewardState);
				PublishMessage(GuildMessageEnum.GuildActivityChange, null);
				return obj.ConvertToRewardThings();
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return null;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return null;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return null;
	}
}
