using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class ChatBarViewModel : OptionBase
{
	private int roomType;

	private ChatViewModel chatViewModel;

	private SimpleCommand openChatCmd;

	private string msgContent = "";

	private string msgName = "";

	private bool isNew;

	private List<ChatChannel> channels;

	private ChatChannel curChannel;

	public ChatChannel ChatChannel => curChannel;

	public ICommand OpenChatCmd => openChatCmd;

	public string MsgName
	{
		get
		{
			return msgName;
		}
		private set
		{
			Set(ref msgName, value, "MsgName");
		}
	}

	public bool IsNew
	{
		get
		{
			return isNew;
		}
		private set
		{
			Set(ref isNew, value, "IsNew");
		}
	}

	public string MsgContent
	{
		get
		{
			return msgContent;
		}
		private set
		{
			Set(ref msgContent, value, "MsgContent");
		}
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is MultiRoomData multiRoomData)
		{
			parent?.ItemOnClick(multiRoomData);
		}
	}

	public ChatBarViewModel()
	{
	}

	public ChatBarViewModel(OptionBase parent)
	{
		base.parent = parent;
		openChatCmd = new SimpleCommand(OpenChatWindow);
	}

	public void InitChatBarChannel(ChatChannel defaultChannel, List<ChatChannel> openChatChannels)
	{
		curChannel = defaultChannel;
		channels = openChatChannels;
		chatViewModel = Singleton<ServiceSystem>.Instance.GetService<IChatService>().GetChatViewModel();
		chatViewModel.AddBar(this, defaultChannel);
		ChatData newMsgRecord = chatViewModel.GetNewMsgRecord(defaultChannel);
		GetNewMsg(newMsgRecord, defaultChannel);
		chatViewModel.AddNewMsgAction(GetNewMsg);
	}

	public void ClearChatMsg(ChatChannel chatChannel)
	{
		if (chatViewModel != null)
		{
			chatViewModel.ClearChatMsg(chatChannel);
			chatViewModel.Close();
		}
	}

	public void OpenChatWindow()
	{
		openChatCmd.Enabled = false;
		IsNew = false;
		chatViewModel.AddBar(this, curChannel);
		chatViewModel.ChatBarOpenWindow(curChannel, channels);
		parent.ItemOnClick(chatViewModel);
	}

	public void GetNewMsg(ChatData chatData, ChatChannel msgChannel)
	{
		if (msgChannel != curChannel || chatData == null || chatData.ArgEnum == ChatMessageArgEnum.System)
		{
			return;
		}
		if (curChannel == ChatChannel.World && Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Level < chatViewModel.WorldOpenLevel)
		{
			MsgName = "";
			MsgContent = "";
			IsNew = false;
			return;
		}
		if (!string.IsNullOrEmpty(chatData.name))
		{
			MsgName = chatData.name + "：";
		}
		else
		{
			MsgName = "";
		}
		MsgContent = chatData.msg;
		IsNew = chatData.isNew;
	}

	public void CancelNew()
	{
		IsNew = false;
	}

	public void ActiveChatCommand()
	{
		openChatCmd.Enabled = true;
	}

	public override void Dispose()
	{
		base.Dispose();
		chatViewModel.RemoveBar(this);
	}
}
