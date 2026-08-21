#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using Newtonsoft.Json;
using UnityEngine;

namespace Ase;

public class ChatViewModel : OptionBase
{
	private bool pressEnable = true;

	private bool isShow;

	private Dictionary<ChatChannel, ChatMsgInfo> channelMsgInfos;

	private InteractionRequest<AdjustScrollArgs> refreshChatListRequest;

	private SimpleCommand sendCommand;

	private bool showChangeChildChannel;

	private int curChildChannel;

	private int maxChildChannelCount;

	private string inputChildChannel;

	private int worldOpenLevel = 7;

	private bool canInput;

	private string msg;

	private int newMsgCount;

	private int waitTime;

	private float verticalBarVal;

	private bool isOnBottom = true;

	private List<ChatMessageItemViewModel> chatList;

	private List<ChatChannelItemViewModel> chatChannelList;

	private ChatChannel activeChannel;

	private IChatService chatService;

	private IRoleService roleService;

	private string sendString;

	private const string CampaignPlayerNameColor = "#fff94d";

	private List<ChatBarViewModel> chatBarList;

	private List<ChatChannel> openChatChannels;

	private Action<ChatData, ChatChannel> barNewMsgAction;

	private List<int> unlockEmojiTypes;

	private bool emojiUnlockListDirty;

	private bool isSendEmoji;

	private int emojiId;

	private string emojiIcon;

	private ChatImageViewModel chatImageViewModel;

	private bool showImgView;

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

	public ChatImageViewModel ChatImageVM => chatImageViewModel;

	public List<int> UnlockEmojiTypes => unlockEmojiTypes;

	public string Msg
	{
		get
		{
			return msg;
		}
		set
		{
			if (!string.IsNullOrEmpty(value) && value.Length > 30)
			{
				value = value.Substring(0, 30);
			}
			Set(ref msg, value, "Msg");
		}
	}

	public int MaxChildChannelCount
	{
		get
		{
			return maxChildChannelCount;
		}
		set
		{
			Set(ref maxChildChannelCount, value, "MaxChildChannelCount");
		}
	}

	public bool ShowChangeChildChannel
	{
		get
		{
			return showChangeChildChannel;
		}
		set
		{
			Set(ref showChangeChildChannel, value, "ShowChangeChildChannel");
		}
	}

	public int CurChildChannel
	{
		get
		{
			return curChildChannel;
		}
		set
		{
			Set(ref curChildChannel, value, "CurChildChannel");
		}
	}

	public string InputChildChannel
	{
		get
		{
			return inputChildChannel;
		}
		set
		{
			Set(ref inputChildChannel, value, "InputChildChannel");
			ValidChildChannelInput(value);
		}
	}

	public int NewMsgCount
	{
		get
		{
			return newMsgCount;
		}
		set
		{
			Set(ref newMsgCount, value, "NewMsgCount");
		}
	}

	public int WaitTime
	{
		get
		{
			return waitTime;
		}
		set
		{
			Set(ref waitTime, value, "WaitTime");
		}
	}

	public bool CanInput
	{
		get
		{
			return canInput;
		}
		protected set
		{
			Set(ref canInput, value, "CanInput");
		}
	}

	public float VerticalBarVal
	{
		get
		{
			return verticalBarVal;
		}
		set
		{
			if (value != 1f)
			{
				if (Set(ref verticalBarVal, value, "VerticalBarVal"))
				{
					IsOnBottom = value <= ItemRatio();
				}
				SetOnTop(value >= 1f);
			}
		}
	}

	public bool IsOnBottom
	{
		get
		{
			return isOnBottom;
		}
		set
		{
			isOnBottom = value;
			if (isOnBottom)
			{
				if (newMsgCount > 0)
				{
					UpdateToNewMsg(toBottom: true, newMsgCount);
				}
				NewMsgCount = 0;
			}
		}
	}

	public List<ChatMessageItemViewModel> ChatList => chatList;

	public IInteractionRequest RefreshChatListRequest => refreshChatListRequest;

	public ICommand SendCommand => sendCommand;

	public List<ChatChannel> OpenChatChannels => openChatChannels;

	public int WorldOpenLevel => worldOpenLevel;

	public override void ItemOnClick(object obj)
	{
		if (obj is ChatChannelItemViewModel channelItemViewModel)
		{
			SettleChannelChange(channelItemViewModel);
		}
		else if (obj is OptionArg optionArg)
		{
			if (optionArg.OptionName.Equals("ShowUserInfo"))
			{
				ShowUserInfo((ChatMessageItemViewModel)optionArg.Obj);
			}
			else if (optionArg.OptionName.Equals("ReceiveBattleInvite"))
			{
				AddTeam((ChatMessageItemViewModel)optionArg.Obj);
			}
			else if (optionArg.OptionName.Equals("GuildRecruit"))
			{
				SendGuildApplication((ChatMessageItemViewModel)optionArg.Obj);
			}
			else if (optionArg.OptionName.Equals("OnReport"))
			{
				Report((ChatMessageItemViewModel)optionArg.Obj);
			}
			else if (optionArg.OptionName.Equals("SendImage"))
			{
				SendImage((CharImageItemViewModel)optionArg.Obj);
			}
			else if (optionArg.OptionName.Equals("CloseChatImage"))
			{
				ShowImgView = false;
			}
		}
	}

	private void Report(ChatMessageItemViewModel chatMessageItemView)
	{
		if (pressEnable)
		{
			pressEnable = false;
			openWindowRequest.Raise(new OpenViewArg(typeof(ReportWindow), new ReportViewModel(this, ReportTypeEnum.PlayerChat, chatMessageItemView.Data.Name, chatMessageItemView.Data.uid, chatMessageItemView.Data.Msg)), delegate
			{
				pressEnable = true;
			});
		}
	}

	private async void ShowUserInfo(ChatMessageItemViewModel chatItem)
	{
		if (isShow)
		{
			return;
		}
		isShow = true;
		Loading loading = await Loading.Show();
		RoleViewModel roleViewModel = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData();
		PlayerData playerInfo = roleViewModel.PlayerInfo;
		if (chatItem.Uid == 0L || chatItem.Uid == playerInfo.Uid)
		{
			PlayerInfoViewModel infoViewModel = new PlayerInfoViewModel(this, playerInfo, isSelf: true);
			await infoViewModel.AddSelfShowHeros(roleViewModel.HeroIds);
			await infoViewModel.AddSelfShowAchi(roleViewModel.PlayerInfo.WearMedals);
			openWindowRequest.Raise(new OpenViewArg(typeof(PlayerInfoWindow), infoViewModel));
		}
		else
		{
			PlayerData playerData = await Singleton<ServiceSystem>.Instance.GetService<ISocialService>().RequestSearchPlayer(chatItem.Uid);
			if (playerData == null)
			{
				Toast.ShowInfo("不存在目标玩家");
				loading.Dispose();
				isShow = false;
				return;
			}
			openWindowRequest.Raise(new OpenViewArg(typeof(PlayerInfoWindow), new PlayerInfoViewModel(this, playerData, isSelf: false)));
		}
		loading.Dispose();
		isShow = false;
	}

	private async void AddTeam(ChatMessageItemViewModel chatMessageItemViewModel)
	{
		if (!Singleton<ServiceSystem>.Instance.GetService<ICopyService>().CheckInviteCopyOpen(chatMessageItemViewModel.Data.copyId))
		{
			Toast.ShowInfo("副本未解锁！");
			return;
		}
		long roomId = Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().GetRoomId();
		if (chatMessageItemViewModel.Data.ArgId == roomId)
		{
			Toast.ShowInfo("已在队伍中");
			return;
		}
		Loading loading = await Loading.Show();
		MultiRoomData multiRoomData = await Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().TryJoinFriendTeam(0L, chatMessageItemViewModel.Data.ArgId);
		if (multiRoomData.IsValid())
		{
			parent?.ItemOnClick(multiRoomData);
		}
		loading.Dispose();
	}

	private async void SendGuildApplication(ChatMessageItemViewModel chatMessageItemViewModel)
	{
		Loading loading = await Loading.Show();
		GuildData guildData = await Singleton<ServiceSystem>.Instance.GetService<IGuildService>().RequestSearchGuild(chatMessageItemViewModel.Data.ArgId.ToString());
		if (guildData == null)
		{
			loading?.Dispose();
			return;
		}
		if (!GuildDefinition.GuildApplyConditionChecking(Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo, guildData, out var text))
		{
			if (!string.IsNullOrEmpty(text))
			{
				Toast.ShowInfo(text);
			}
			loading?.Dispose();
			return;
		}
		bool num = await Singleton<ServiceSystem>.Instance.GetService<IGuildService>().RequestJoinInGuild(chatMessageItemViewModel.Data.ArgId, null);
		loading?.Dispose();
		if (num)
		{
			Toast.ShowInfo("成功发送公会申请");
		}
	}

	public ChatViewModel(IChatService chatService)
	{
		refreshChatListRequest = new InteractionRequest<AdjustScrollArgs>();
		sendCommand = new SimpleCommand(OnSendClick);
		chatList = new List<ChatMessageItemViewModel>();
		this.chatService = chatService;
		roleService = Singleton<ServiceSystem>.Instance.GetService<IRoleService>();
		channelMsgInfos = new Dictionary<ChatChannel, ChatMsgInfo>();
		channelMsgInfos.Add(ChatChannel.World, new ChatMsgInfo(ChatChannel.World, canInput: true));
		channelMsgInfos.Add(ChatChannel.Team, new ChatMsgInfo(ChatChannel.Team, canInput: true));
		channelMsgInfos.Add(ChatChannel.Guild, new ChatMsgInfo(ChatChannel.Guild, canInput: true));
		channelMsgInfos.Add(ChatChannel.Recruit, new ChatMsgInfo(ChatChannel.Recruit, canInput: false));
		channelMsgInfos.Add(ChatChannel.Campaign, new ChatMsgInfo(ChatChannel.Campaign, canInput: false));
		channelMsgInfos[ChatChannel.World].SetSendParam();
		channelMsgInfos[ChatChannel.Team].SetSendParam();
		channelMsgInfos[ChatChannel.Guild].SetSendParam();
		chatImageViewModel = new ChatImageViewModel(this);
	}

	public new void OnOpen()
	{
		sendCommand.Enabled = true;
		UpdateToNewMsg(toBottom: true);
	}

	public async void OnSendClick()
	{
		isSendEmoji = false;
		await Send();
	}

	public async Task<bool> Send()
	{
		bool isMsg2Emoji = false;
		if (!isSendEmoji)
		{
			var (num, text) = ChatHelper.ChangeString2Emoji(msg);
			if (num > 0)
			{
				isSendEmoji = true;
				emojiId = num;
				emojiIcon = text;
				isMsg2Emoji = true;
			}
			sendString = msg;
		}
		if (activeChannel == ChatChannel.None || string.IsNullOrEmpty(sendString) || !channelMsgInfos[activeChannel].CanInput)
		{
			isSendEmoji = false;
			return false;
		}
		sendString = sendString.Replace("\n", " ").Replace("\r", " ").Replace("\t", " ");
		if (string.IsNullOrWhiteSpace(sendString))
		{
			isSendEmoji = false;
			Toast.ShowInfo("请勿发送空消息");
			return false;
		}
		if (activeChannel == ChatChannel.World && !isSendEmoji && !channelMsgInfos[activeChannel].CheckMsgValid(sendString))
		{
			Toast.ShowInfo("请勿发送相同内容");
			isSendEmoji = false;
			return false;
		}
		sendCommand.Enabled = false;
		SendMsgResult sendMsgResult = await Singleton<ServiceSystem>.Instance.GetService<IChatService>().SendMsg(activeChannel, roleService.GetRoleData().PlayerInfo, sendString, emojiId, (activeChannel == ChatChannel.Team) ? 1 : 0);
		if (sendMsgResult != null)
		{
			int num2 = (int)sendMsgResult.nextCanSendTime;
			if (num2 > 0)
			{
				SetChannelWaitTime(num2, activeChannel);
				UpdateWaitingTime(num2, activeChannel);
			}
			if (sendMsgResult.sendSuccess)
			{
				num2 = GetSendChannelWaitTime(activeChannel);
				if (num2 > 0)
				{
					SetChannelWaitTime(num2, activeChannel);
					UpdateWaitingTime(num2, activeChannel);
				}
				if (!isSendEmoji)
				{
					AddNewMsgSelf(sendMsgResult.msg);
					Msg = string.Empty;
				}
				else
				{
					AddNewMsgSelf(sendMsgResult.msg, emojiId, emojiIcon);
					if (isMsg2Emoji)
					{
						Msg = string.Empty;
					}
				}
				emojiId = 0;
				emojiIcon = null;
				sendString = null;
			}
			isSendEmoji = false;
			sendCommand.Enabled = true;
			return sendMsgResult.sendSuccess;
		}
		sendCommand.Enabled = true;
		return false;
	}

	private void AddNewMsgSelf(string msg, int emojiId = 0, string emojiIcon = "")
	{
		ChatData chatData = new ChatData();
		chatData.name = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Name;
		chatData.level = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Level;
		chatData.avatar = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Icon;
		chatData.frameId = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.IconFrame;
		chatData.titleId = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Title;
		chatData.msg = msg;
		chatData.emojiId = emojiId;
		chatData.icon = emojiIcon;
		chatData.isSend = true;
		chatData.isNew = false;
		chatData.SetBubble(Singleton<ServiceSystem>.Instance.GetService<IBFBEService>()?.GetChatBubble() ?? 0, send: true);
		channelMsgInfos[activeChannel].ClearNewChatData();
		channelMsgInfos[activeChannel].UpdateLastSendMsg(msg);
		channelMsgInfos[activeChannel].AddNewMsg(chatData);
		UpdateToNewMsg(toBottom: true);
		barNewMsgAction(chatData, activeChannel);
	}

	public void OnNewMsgClick()
	{
		UpdateToNewMsg(toBottom: true);
		NewMsgCount = 0;
		SetToggleNewMsg(activeChannel, isNew: false);
	}

	public void ClearChatMsg(ChatChannel channel)
	{
		channelMsgInfos[channel].Clear();
	}

	public void ReceiveNewMsg(int channelFromServer, ChatData chatData)
	{
		ChatChannel channel = GetChannel(channelFromServer);
		if (channel == ChatChannel.None)
		{
			return;
		}
		if (IsCampaignBossKillMsg(channel, chatData))
		{
			SettleCampaignBossKillMsg(chatData);
		}
		channelMsgInfos[channel].AddNewMsg(chatData);
		if (activeChannel == ChatChannel.None)
		{
			SettleNewMsgBar(chatData, channel);
			return;
		}
		if (channel == activeChannel)
		{
			chatData.isNew = false;
			UpdateToNewMsg(isOnBottom);
		}
		else
		{
			SetToggleNewMsg(channel, isNew: true);
		}
		SettleNewMsgBar(chatData, channel);
	}

	private bool IsCampaignBossKillMsg(ChatChannel channel, ChatData chatData)
	{
		if (channel != ChatChannel.Campaign || chatData == null)
		{
			return false;
		}
		if (chatData.ArgEnum != ChatMessageArgEnum.None || chatData.ArgId > 0 || chatData.copyId > 0)
		{
			return false;
		}
		if (string.IsNullOrEmpty(chatData.name) || !chatData.name.Contains(","))
		{
			return false;
		}
		if (int.TryParse(chatData.msg, out var result))
		{
			return result > 0;
		}
		return false;
	}

	private void SettleCampaignBossKillMsg(ChatData chatData)
	{
		if (chatData == null)
		{
			return;
		}
		string[] array = (string.IsNullOrEmpty(chatData.name) ? Array.Empty<string>() : chatData.name.Split(','));
		string text = string.Empty;
		for (int i = 0; i < array.Length; i++)
		{
			string text2 = array[i]?.Trim();
			if (!string.IsNullOrEmpty(text2))
			{
				text = text + "<color=#fff94d>" + SafeRichText(text2) + "</color>,";
			}
		}
		int result = 0;
		int.TryParse(chatData.msg, out result);
		string campaignBossName = GetCampaignBossName(result);
		chatData.name = string.Empty;
		chatData.msg = text + "成功击退" + campaignBossName + "，为赤潮守备战做出卓越贡献！";
	}

	private string GetCampaignBossName(int copyId)
	{
		if (copyId <= 0)
		{
			return string.Empty;
		}
		DRCopy dataRow = GameEntry.DataTable.GetDataRow<DRCopy>(copyId);
		if (dataRow != null)
		{
			return dataRow.Name;
		}
		return copyId.ToString();
	}

	private void AddSystemNewMsg(string msg, ChatChannel channel, bool toBottom)
	{
		ChatData chatData = ChatData.CreateSystem(msg);
		channelMsgInfos[channel].AddNewMsg(chatData);
		if (activeChannel == ChatChannel.None)
		{
			SettleNewMsgBar(chatData, channel);
			return;
		}
		if (channel == activeChannel)
		{
			chatData.isNew = false;
			UpdateToNewMsg(toBottom);
		}
		else
		{
			SetToggleNewMsg(channel, isNew: true);
		}
		SettleNewMsgBar(chatData, channel);
	}

	private void SettleChannelChange(ChatChannelItemViewModel channelItemViewModel)
	{
		if (activeChannel == channelItemViewModel.Channel)
		{
			return;
		}
		ClearChannelNewChatData();
		ClearChatBarNew(activeChannel);
		for (int i = 0; i < chatChannelList.Count; i++)
		{
			if (activeChannel == chatChannelList[i].Channel)
			{
				chatChannelList[i].SetSelect(isSelect: false);
				break;
			}
		}
		activeChannel = channelItemViewModel.Channel;
		ShowChangeChildChannel = activeChannel == ChatChannel.World;
		UpdateToNewMsg(toBottom: true);
		ClearChatBarNew(activeChannel);
		UpdateWaitingTime(GetChannelWaitTime(activeChannel), activeChannel);
		NewMsgCount = 0;
		CanInput = channelMsgInfos[activeChannel].CanInput;
	}

	private void SetToggleNewMsg(ChatChannel channel, bool isNew)
	{
		if (chatChannelList == null)
		{
			return;
		}
		for (int i = 0; i < chatChannelList.Count && chatChannelList[i] != null; i++)
		{
			if (chatChannelList[i].Channel == channel)
			{
				chatChannelList[i].SetNew(isNew);
				break;
			}
		}
	}

	public void OnSendDisableClick()
	{
		Toast.ShowInfo($"需要{waitTime}s后才可发送消息");
	}

	private void UpdateToNewMsg(bool toBottom, int offset = 0)
	{
		int num = channelMsgInfos[activeChannel].GetNewMsgItem(this, toBottom);
		if (toBottom)
		{
			num = 0;
		}
		RefreshChatList(toBottom, num + offset);
		if (toBottom)
		{
			ClearChannelNewChatData();
		}
		NewMsgCount = channelMsgInfos[activeChannel].GetNewMsgCount();
	}

	public void RefreshChatList(bool toNew, int index)
	{
		chatList = channelMsgInfos[activeChannel].ChatMsgs;
		AdjustScrollArgs adjustScrollArgs = new AdjustScrollArgs();
		adjustScrollArgs.toNew = toNew;
		adjustScrollArgs.moveIndex = index;
		if (!isOnBottom && !toNew)
		{
			NewMsgCount = newMsgCount + 1;
		}
		refreshChatListRequest.Raise(adjustScrollArgs);
	}

	private float ItemRatio()
	{
		int count = channelMsgInfos[activeChannel].ChatMsgs.Count;
		count++;
		return 1f / (float)count;
	}

	public ChatChannel GetChannel(int channelFromServer)
	{
		switch (channelFromServer)
		{
		case 1:
			return ChatChannel.World;
		case 2:
			return ChatChannel.Team;
		case 3:
			return ChatChannel.Guild;
		case 4:
			return ChatChannel.Recruit;
		case 5:
			return ChatChannel.Campaign;
		default:
			Log.Error($"聊天频道不存在，{channelFromServer}");
			return ChatChannel.None;
		}
	}

	public void BarClose()
	{
		if (activeChannel == ChatChannel.Team)
		{
			channelMsgInfos[ChatChannel.Team].Clear();
		}
	}

	public ChatChannelItemViewModel GetChannelItem(ChatChannel channel)
	{
		for (int i = 0; i < chatChannelList.Count; i++)
		{
			if (chatChannelList[i].Channel == channel)
			{
				return chatChannelList[i];
			}
		}
		return null;
	}

	private string SafeRichText(string text)
	{
		if (string.IsNullOrEmpty(text))
		{
			return string.Empty;
		}
		return text.Replace("<", "＜").Replace(">", "＞");
	}

	private void ClearChannelNewChatData()
	{
		if (channelMsgInfos.ContainsKey(activeChannel))
		{
			channelMsgInfos[activeChannel].ClearNewChatData();
		}
	}

	private bool HasChannelNew(ChatChannel channel)
	{
		if (channelMsgInfos.ContainsKey(channel))
		{
			return channelMsgInfos[channel].HasChannelNew();
		}
		return false;
	}

	private void AddMsgCount(ChatChannel chatChannel)
	{
		channelMsgInfos[chatChannel].AddMsgCount();
	}

	private int GetSendChannelWaitTime(ChatChannel chatChannel)
	{
		return channelMsgInfos[chatChannel].GetCurSendInterval();
	}

	private int GetChannelWaitTime(ChatChannel chatChannel)
	{
		return channelMsgInfos[chatChannel].WaitTime;
	}

	private void SetChannelWaitTime(int waitTime, ChatChannel chatChannel)
	{
		channelMsgInfos[chatChannel].SetWaitTime(waitTime);
	}

	public void AddNewMsgAction(Action<ChatData, ChatChannel> barNewMsgAction)
	{
		this.barNewMsgAction = (Action<ChatData, ChatChannel>)Delegate.Combine(this.barNewMsgAction, barNewMsgAction);
	}

	public void AddBar(ChatBarViewModel bar, ChatChannel defaultChannel)
	{
		if (chatBarList == null)
		{
			chatBarList = new List<ChatBarViewModel>();
		}
		for (int i = 0; i < chatBarList.Count; i++)
		{
			if (chatBarList[i] == bar)
			{
				chatBarList.RemoveAt(i);
				break;
			}
		}
		chatBarList.Add(bar);
		SetParent(bar);
	}

	public ChatData GetNewMsgRecord(ChatChannel channel)
	{
		return GetChannelLastMsg(channel);
	}

	private ChatData GetChannelLastMsg(ChatChannel channel)
	{
		if (channelMsgInfos != null && channelMsgInfos.ContainsKey(channel))
		{
			return channelMsgInfos[channel].GetChannelLastMsg();
		}
		return null;
	}

	public void ClearChatLimit(ChatChannel world)
	{
		channelMsgInfos[world].ClearChatLimit();
	}

	public void ChatBarOpenWindow(ChatChannel defaultChannel, List<ChatChannel> openChatChannels)
	{
		List<ChatChannel> list = new List<ChatChannel>();
		for (int i = 0; i < openChatChannels.Count; i++)
		{
			if (openChatChannels[i] == ChatChannel.Guild)
			{
				MyGuildData myGuildData = Singleton<ServiceSystem>.Instance.GetService<IGuildService>().GetMyGuildData();
				if (myGuildData == null || myGuildData.Uid == 0L)
				{
					continue;
				}
			}
			if (openChatChannels[i] != ChatChannel.World || Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Level >= worldOpenLevel)
			{
				list.Add(openChatChannels[i]);
			}
		}
		bool flag = false;
		for (int j = 0; j < list.Count; j++)
		{
			if (list[j] == defaultChannel)
			{
				flag = true;
			}
		}
		if (flag)
		{
			activeChannel = defaultChannel;
		}
		else if (list.Count > 0)
		{
			activeChannel = list[0];
		}
		else
		{
			activeChannel = ChatChannel.None;
		}
		UpdateWaitingTime(GetChannelWaitTime(activeChannel), activeChannel);
		ShowChangeChildChannel = activeChannel == ChatChannel.World;
		this.openChatChannels = list;
		if (chatChannelList == null)
		{
			chatChannelList = new List<ChatChannelItemViewModel>();
		}
		for (int k = 0; k < openChatChannels.Count; k++)
		{
			int num = -1;
			for (int l = 0; l < chatChannelList.Count; l++)
			{
				if (chatChannelList[l].Channel == openChatChannels[k])
				{
					num = l;
				}
			}
			if (num == -1)
			{
				chatChannelList.Add(new ChatChannelItemViewModel(this, openChatChannels[k]));
				num = chatChannelList.Count - 1;
			}
			chatChannelList[num].SetNew(openChatChannels[k] != activeChannel && HasChannelNew(openChatChannels[k]));
			chatChannelList[num].SetSelect(openChatChannels[k] == activeChannel);
		}
		CanInput = channelMsgInfos[activeChannel].CanInput;
	}

	private void SettleNewMsgBar(ChatData chatData, ChatChannel channel)
	{
		if (barNewMsgAction != null)
		{
			barNewMsgAction(chatData, channel);
		}
	}

	private void ClearChatBarNew(ChatChannel channel)
	{
		for (int i = 0; i < chatBarList.Count; i++)
		{
			if (chatBarList[i].ChatChannel == channel)
			{
				chatBarList[i].CancelNew();
				break;
			}
		}
	}

	public void RemoveBar(ChatBarViewModel bar)
	{
		if (chatBarList == null)
		{
			return;
		}
		for (int i = 0; i < chatBarList.Count; i++)
		{
			if (chatBarList[i] == bar)
			{
				chatBarList.RemoveAt(i);
				break;
			}
		}
		barNewMsgAction = (Action<ChatData, ChatChannel>)Delegate.Remove(barNewMsgAction, new Action<ChatData, ChatChannel>(bar.GetNewMsg));
		ChatBarViewModel chatBarViewModel = ((chatBarList.Count > 0) ? chatBarList[chatBarList.Count - 1] : null);
		SetParent(chatBarViewModel);
		if (chatBarViewModel != null)
		{
			activeChannel = chatBarViewModel.ChatChannel;
		}
	}

	public override void Close()
	{
		base.Close();
		ShowImgView = false;
		activeChannel = ChatChannel.None;
	}

	private void UpdateWaitingTime(int waitTime, ChatChannel chatChannel)
	{
		foreach (KeyValuePair<ChatChannel, ChatMsgInfo> channelMsgInfo in channelMsgInfos)
		{
			if (channelMsgInfo.Key != chatChannel)
			{
				channelMsgInfo.Value.RemoveWaitAction();
			}
		}
		WaitTime = channelMsgInfos[chatChannel].WaitTime;
		channelMsgInfos[chatChannel].UpdateWaitingTime(waitTime, delegate(int t)
		{
			WaitTime = t;
		});
	}

	private int RefreshChannelWaitTime()
	{
		int num = 0;
		foreach (KeyValuePair<ChatChannel, ChatMsgInfo> channelMsgInfo in channelMsgInfos)
		{
			num = Mathf.Max(num, channelMsgInfo.Value.RefreshChannelWaitTime());
		}
		return num;
	}

	public void SetWorldChatOpenLevel(int openLevel)
	{
		worldOpenLevel = openLevel;
	}

	private void SetOnTop(bool isTop)
	{
		channelMsgInfos[activeChannel].SetOnTop(isTop);
	}

	public int CheckRemoveHistory()
	{
		return channelMsgInfos[activeChannel].CheckRemoveHistory();
	}

	public void SetCurChildChannel(int curChannel)
	{
		MaxChildChannelCount = Singleton<OuterSystem>.Instance.GetConstantConfigInt(Constant.ConstantConfig.ChatMaxChildChannelCount, 999);
		CurChildChannel = curChannel;
	}

	private async Task ValidChildChannelInput(string value)
	{
		try
		{
			if (string.IsNullOrEmpty(value))
			{
				return;
			}
			int num = int.Parse(value);
			if (num >= 1 && num <= maxChildChannelCount)
			{
				if (num == curChildChannel)
				{
					Toast.ShowInfo("已在对应频道");
					return;
				}
				if (await Singleton<ServiceSystem>.Instance.GetService<IChatService>().ChangeChildChannel(num) == -1)
				{
					Toast.ShowInfo("频道人数已满，切换失败");
					return;
				}
				CurChildChannel = num;
				AddSystemNewMsg($"已切换至频道{num}", ChatChannel.World, toBottom: true);
			}
			else
			{
				Toast.ShowInfo($"请输入1~{maxChildChannelCount}切换频道");
			}
		}
		catch (Exception)
		{
			Toast.ShowInfo($"请输入1~{maxChildChannelCount}切换频道");
		}
	}

	public void InitEmojiTypes()
	{
		unlockEmojiTypes = new List<int>();
	}

	public void MarkEmojiUnlockListDirty()
	{
		emojiUnlockListDirty = true;
	}

	private void ClearEmojiUnlockListDirty()
	{
		emojiUnlockListDirty = false;
	}

	public async void OnOpenFace()
	{
		if (unlockEmojiTypes == null || emojiUnlockListDirty)
		{
			await RequestEmojiUnlockList();
		}
		chatImageViewModel.Init(unlockEmojiTypes);
		ShowImgView = true;
	}

	public async Task RequestEmojiUnlockList()
	{
		Loading loading = await Loading.Show();
		bool flag = false;
		try
		{
			flag = await Singleton<ServiceSystem>.Instance.GetService<IChatService>().GetEmojiUnlockList();
		}
		finally
		{
			loading.Dispose();
		}
		if (flag)
		{
			ClearEmojiUnlockListDirty();
		}
	}

	public void SaveRecentImages(List<int> ids)
	{
		try
		{
			string v = JsonConvert.SerializeObject(ids);
			Singleton<OuterSystem>.Instance.SavePlayerPrefs("ChatRecentImages", v);
		}
		catch (Exception ex)
		{
			Log.Error("保存最近聊天表情包失败！" + ex.Message + " / " + ex.StackTrace);
		}
	}

	public List<int> GetRecentImages()
	{
		try
		{
			List<int> list = JsonConvert.DeserializeObject<List<int>>(Singleton<OuterSystem>.Instance.LoadPlayerPrefs("ChatRecentImages"));
			if (list == null)
			{
				return new List<int>();
			}
			return list;
		}
		catch (Exception ex)
		{
			Log.Error("获取最近聊天表情包失败！" + ex.Message + " / " + ex.StackTrace);
			return new List<int>();
		}
	}

	private async void SendImage(CharImageItemViewModel charImageItem)
	{
		if (WaitTime > 0 && CanInput)
		{
			OnSendDisableClick();
			return;
		}
		DREmoticon dataRow = GameEntry.DataTable.GetDataRow((DREmoticon p) => p.Id == charImageItem.ID);
		if (dataRow != null)
		{
			sendString = dataRow.Unicode ?? "";
			isSendEmoji = true;
			emojiId = charImageItem.ID;
			emojiIcon = charImageItem.Icon;
			if (await Send())
			{
				ShowImgView = false;
			}
		}
	}
}
