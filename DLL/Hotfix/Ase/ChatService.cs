#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using Lockstep.Core;
using Newtonsoft.Json;
using UnityEngine;

namespace Ase;

public class ChatService : IChatService
{
	private ChatViewModel chatViewModel;

	private IMessenger messenger;

	private ISubscription<EmojiUnlockNotify> subscription_EmojiUnlockNotify;

	private ISubscription<SOOpenNotifyMessager> subscription_SONotify;

	private ISubscription<ChatMessageNotify> subscription_ReceiveMsg;

	private ISubscription<RefetchDataNotify> subscription_ReceiveNotify;

	private ISubscription<BattleRecruitMemberNotify> subscription_ReceiveBattleRecruit;

	private string SaveKey = "SendMsgCount_";

	private string systemName = "Chat";

	private string ReportKey = "Report";

	private List<ReportSave> reportSaves;

	public ChatService()
	{
		chatViewModel = new ChatViewModel(this);
		messenger = Context.GetApplicationContext().GetService<IMessenger>();
		subscription_SONotify = messenger.Subscribe<SOOpenNotifyMessager>(OnSystemOpen);
		subscription_ReceiveMsg = Singleton<NetworkSystem>.Instance.Subscribe<ChatMessageNotify>(ReceiveMsg);
		subscription_ReceiveNotify = Singleton<NetworkSystem>.Instance.Subscribe<RefetchDataNotify>(ReceiveNotify);
		subscription_ReceiveBattleRecruit = Singleton<NetworkSystem>.Instance.Subscribe<BattleRecruitMemberNotify>(ReceiveBattleRecruitMsg);
		subscription_EmojiUnlockNotify = Singleton<NetworkSystem>.Instance.Subscribe<EmojiUnlockNotify>(OnEmojiUnlockNotify);
	}

	private void OnSystemOpen(SOOpenNotifyMessager messager)
	{
		if (messager.state)
		{
			_ = 70002;
			_ = messager.serviceId;
		}
	}

	public async UniTask<bool> GetSubChannel()
	{
		GetSubChannelRequest request = GetSubChannelRequest.Create();
		GetSubChannelResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetSubChannelResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取聊天频道") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取聊天频道失败"))
			{
				chatViewModel.SetCurChildChannel(response.SubChannel);
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("获取聊天频道，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async Task<SendMsgResult> SendMsg(ChatChannel channel, PlayerData playerData, string msg, int emojiId, int roomType)
	{
		C2S_ChatMessage c2S_ChatMessage = C2S_ChatMessage.Create();
		c2S_ChatMessage.Channel = (int)channel;
		c2S_ChatMessage.Content = msg;
		c2S_ChatMessage.UserInfo = PbChatUserInfo.Create();
		c2S_ChatMessage.UserInfo.Icon = playerData.IconId;
		c2S_ChatMessage.UserInfo.UserName = playerData.Name;
		c2S_ChatMessage.UserInfo.IconFrame = playerData.IconFrame;
		c2S_ChatMessage.UserInfo.Level = playerData.Level;
		c2S_ChatMessage.UserInfo.TitleId = playerData.Title;
		c2S_ChatMessage.UserInfo.Bubble = Singleton<ServiceSystem>.Instance.GetService<IBFBEService>()?.GetChatBubble() ?? 0;
		c2S_ChatMessage.RoomType = roomType;
		c2S_ChatMessage.EmojiId = emojiId;
		c2S_ChatMessage.SubChannel = ((channel == ChatChannel.World) ? chatViewModel.CurChildChannel : 0);
		if (emojiId > 0)
		{
			c2S_ChatMessage.Content = ChatHelper.ChangeEmoji2String(emojiId);
		}
		try
		{
			S2C_ChatMessage s2C_ChatMessage = null;
			if (channel != ChatChannel.None)
			{
				s2C_ChatMessage = await Singleton<NetworkSystem>.Instance.Call<S2C_ChatMessage>(c2S_ChatMessage);
			}
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(s2C_ChatMessage, "发送聊天消息，请求服务器超时!") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(s2C_ChatMessage.Error, s2C_ChatMessage.Message))
			{
				return new SendMsgResult(s2C_ChatMessage.Content, s2C_ChatMessage.EmojiId, s2C_ChatMessage.SendSuccess, s2C_ChatMessage.NextCanSendTime);
			}
		}
		catch (Exception ex)
		{
			Log.Error("发送聊天消息，发生异常！" + ex.Message + " / " + ex.StackTrace);
		}
		return null;
	}

	private void ReceiveMsg(ChatMessageNotify message)
	{
		if ((chatViewModel.GetChannel(message.Channel) != ChatChannel.World || message.SubChannel == chatViewModel.CurChildChannel) && !Singleton<ServiceSystem>.Instance.GetService<ISocialService>().GetFriendViewModel().CheckBlackListExist(message.SendUserId))
		{
			ChatData chatData = new ChatData();
			chatData.name = message.UserInfo.UserName;
			chatData.level = message.UserInfo.Level;
			chatData.msg = message.Content;
			chatData.avatar = PlayerDataBase.GetIcon(message.UserInfo.Icon);
			chatData.frameId = message.UserInfo.IconFrame;
			chatData.titleId = message.UserInfo.TitleId;
			chatData.uid = message.SendUserId;
			int bubbleId = ((message.UserInfo != null) ? message.UserInfo.Bubble : 0);
			chatData.SetBubble(bubbleId, send: false);
			var (num, icon) = ChatHelper.ChangeString2Emoji(message.Content);
			if (num > 0)
			{
				chatData.emojiId = num;
				chatData.icon = icon;
			}
			chatData.isSend = false;
			chatData.isNew = true;
			chatViewModel.ReceiveNewMsg(message.Channel, chatData);
		}
	}

	private async void ReceiveNotify(RefetchDataNotify message)
	{
		_ = message.Type;
		_ = 1;
		if (message.Type == 13)
		{
			int para = message.Para;
			Log.Error($"更新商店，商店Id{para}");
		}
		else if (message.Type == 3)
		{
			await Singleton<ServiceSystem>.Instance.GetService<IMailService>().RequestMailData();
		}
		else if (message.Type == 7)
		{
			Singleton<ServiceSystem>.Instance.GetService<IRoleService>().UpdateRoleLevelAndExp(message.Para, 0L);
		}
		else if (message.Type != 1 && message.Type != 6 && message.Type == 26 && message.copyInfo != null)
		{
			Singleton<ServiceSystem>.Instance.GetService<ICopyService>().CopyComplete(message.copyInfo.CopyId, message.copyInfo.Star, message.copyInfo.Score, isSingle: false);
		}
	}

	public async Task<bool> SendCopyRecruitMsg()
	{
		RecruitTeamMemberRequest request = RecruitTeamMemberRequest.Create();
		try
		{
			RecruitTeamMemberResponse recruitTeamMemberResponse = await Singleton<NetworkSystem>.Instance.Call<RecruitTeamMemberResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(recruitTeamMemberResponse, "发送副本招募，请求服务器超时!") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(recruitTeamMemberResponse.Error, "发送副本招募失败"))
			{
				return true;
			}
		}
		catch (Exception ex)
		{
			Log.Error("发送聊天消息，发生异常！" + ex.Message + " / " + ex.StackTrace);
		}
		return false;
	}

	private void ReceiveBattleRecruitMsg(BattleRecruitMemberNotify message)
	{
		try
		{
			if (!Singleton<ServiceSystem>.Instance.GetService<IAccountService>().IsLogin || Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData() == null || Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.PlayerInfo == null || Singleton<ServiceSystem>.Instance.GetService<ISocialService>().GetFriendViewModel().CheckBlackListExist(message.SendUserId))
			{
				return;
			}
			ChatData chatData = new ChatData();
			chatData.name = message.UserInfo.UserName;
			chatData.level = message.UserInfo.Level;
			chatData.avatar = PlayerDataBase.GetIcon(message.UserInfo.Icon);
			chatData.frameId = message.UserInfo.IconFrame;
			chatData.titleId = message.UserInfo.TitleId;
			chatData.uid = message.SendUserId;
			long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Uid;
			chatData.isSend = message.SendUserId == uid;
			int num = ((message.UserInfo != null) ? message.UserInfo.Bubble : 0);
			int num2 = Singleton<ServiceSystem>.Instance.GetService<IBFBEService>()?.GetChatBubble() ?? 0;
			chatData.SetBubble(chatData.isSend ? num2 : num, chatData.isSend);
			int channelFromServer = message.Channel;
			DRCopy dataRow = GameEntry.DataTable.GetDataRow<DRCopy>(message.CopyId);
			if (dataRow != null)
			{
				chatData.msg = $"队友招募: {dataRow.Name} ({message.UserCount}/3)";
				if (GameEntry.DataTable.GetDataRow<DRCopyType>(dataRow.CopyType).MainCopyId == Constant.ConstantConfig.GuildCopyType)
				{
					channelFromServer = 3;
				}
			}
			chatData.argId = message.RoomId;
			chatData.argTypeEnum = ChatMessageArgEnum.TeamInvite;
			chatData.copyId = message.CopyId;
			chatViewModel.ReceiveNewMsg(channelFromServer, chatData);
		}
		catch (Exception)
		{
		}
	}

	public void OnReceiveNewMsg(int channelFromServer, ChatData chatData)
	{
		chatViewModel?.ReceiveNewMsg(channelFromServer, chatData);
	}

	public int LoadMsgCountToday()
	{
		try
		{
			long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Uid;
			string text = PlayerPrefs.GetString(SaveKey + $"{uid}_{systemName}", "");
			if (string.IsNullOrEmpty(text))
			{
				return 0;
			}
			string[] array = text.Split('_');
			if (array.Length >= 2)
			{
				int num = int.Parse(array[0]);
				long time = long.Parse(array[1]);
				return (!Singleton<ServiceSystem>.Instance.GetService<ITimeService>().CheckNextDay(time)) ? num : 0;
			}
		}
		catch (Exception ex)
		{
			Log.Error("获取聊天消息保存数据失败！" + systemName + " " + ex.Message + " / " + ex.StackTrace);
		}
		return 0;
	}

	public void SaveMsgCountToday(int msgCountToday)
	{
		string text = null;
		try
		{
			long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Uid;
			long curServerTime = Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetCurServerTime();
			text = $"{msgCountToday}_{curServerTime}";
			PlayerPrefs.SetString(SaveKey + $"{uid}_{systemName}", text);
		}
		catch (Exception)
		{
			Log.Error("保存聊天消息保存数据失败！" + systemName);
		}
	}

	public void ClearChatLimit()
	{
		string text = null;
		try
		{
			long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Uid;
			chatViewModel.ClearChatLimit(ChatChannel.World);
			text = "";
			PlayerPrefs.SetString(SaveKey + $"{uid}_{systemName}", text);
		}
		catch (Exception)
		{
			Log.Error("清除聊天消息保存数据失败！" + systemName);
		}
	}

	private void OnEmojiUnlockNotify(EmojiUnlockNotify notify)
	{
		if (chatViewModel.UnlockEmojiTypes == null)
		{
			chatViewModel.InitEmojiTypes();
		}
		if (!chatViewModel.UnlockEmojiTypes.Contains(notify.EmojiId))
		{
			chatViewModel.UnlockEmojiTypes.Add(notify.EmojiId);
		}
	}

	public async Task<bool> GetEmojiUnlockList()
	{
		GetIconOrTitleListRequest rst = GetIconOrTitleListRequest.Create();
		rst.Type = 7;
		GetIconOrTitleListResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetIconOrTitleListResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取聊天表情包") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取聊天表情包失败"))
			{
				if (chatViewModel.UnlockEmojiTypes == null)
				{
					chatViewModel.InitEmojiTypes();
				}
				else
				{
					chatViewModel.UnlockEmojiTypes.Clear();
				}
				if (response.ExtraItemInfos != null)
				{
					for (int i = 0; i < response.ExtraItemInfos.Count; i++)
					{
						chatViewModel.UnlockEmojiTypes.Add(response.ExtraItemInfos[i].Id);
					}
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

	public async Task<long> Report(ReportTypeEnum reportType, long uid, int reportId, string reportRemark)
	{
		try
		{
			long uid2 = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Uid;
			long curServerTime = Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetCurServerTime();
			string key = ReportKey + $"{uid2}_{systemName}";
			string value;
			if (reportSaves == null)
			{
				value = PlayerPrefs.GetString(key, "");
				if (!string.IsNullOrEmpty(value))
				{
					reportSaves = JsonConvert.DeserializeObject<List<ReportSave>>(value) ?? new List<ReportSave>();
				}
				else
				{
					reportSaves = new List<ReportSave>();
				}
			}
			int num = -1;
			if (reportSaves.Count > 0)
			{
				for (int i = 0; i < reportSaves.Count; i++)
				{
					if (reportSaves[i].reportUid == uid)
					{
						num = i;
						if (curServerTime - reportSaves[i].reportTime < 3600)
						{
							return reportSaves[i].reportTime + 3600;
						}
					}
				}
			}
			TDAHandler.Instance.SendReport(reportType.ToInt(), uid2, uid, reportId, reportRemark);
			if (num == -1)
			{
				reportSaves.Add(new ReportSave
				{
					reportTime = curServerTime,
					reportUid = uid
				});
			}
			else
			{
				reportSaves[num].reportTime = curServerTime;
			}
			value = JsonConvert.SerializeObject(reportSaves);
			PlayerPrefs.SetString(key, value);
			return 0L;
		}
		catch (Exception ex)
		{
			Log.Error("举报数据保存发生异常！ " + ex.Message + " / " + ex.StackTrace);
		}
		return -1L;
	}

	public async Task<int> ChangeChildChannel(int curInput)
	{
		ChangeSubChannelRequest changeSubChannelRequest = ChangeSubChannelRequest.Create();
		changeSubChannelRequest.SubChannel = curInput;
		try
		{
			ChangeSubChannelResponse changeSubChannelResponse = await Singleton<NetworkSystem>.Instance.Call<ChangeSubChannelResponse>(changeSubChannelRequest);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(changeSubChannelResponse, "切换聊天子频道，请求服务器超时!") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(changeSubChannelResponse.Error, "切换聊天子频道失败", showToast: false))
			{
				return changeSubChannelResponse.UserNum;
			}
		}
		catch (Exception ex)
		{
			Log.Error("发送聊天消息，发生异常！" + ex.Message + " / " + ex.StackTrace);
		}
		return -1;
	}

	public ChatViewModel GetChatViewModel()
	{
		return chatViewModel;
	}
}
