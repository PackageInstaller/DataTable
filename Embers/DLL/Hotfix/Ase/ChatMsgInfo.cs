#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;

namespace Ase;

public class ChatMsgInfo
{
	private ChatChannel chatChannel;

	private bool canInput;

	private List<ChatMessageItemViewModel> chatMsgs;

	private List<ChatData> newChatData;

	private string lastSendMsg;

	private int waitTime;

	private DateTime lastSendDateTime;

	private int repeatedMsgInterval;

	private bool checkIntervalRepeated;

	private int msgMaxStayCount = 10;

	private int msgCountToday = -1;

	private int msgMaxCount;

	private List<int[]> msgInterval;

	private bool checkInterval;

	private bool checkMsgMax;

	private Timer sendTimer;

	private Action<int> waitAction;

	private bool isOnTop;

	public List<ChatMessageItemViewModel> ChatMsgs => chatMsgs;

	public int WaitTime => waitTime;

	public bool CanInput => canInput;

	public ChatMsgInfo(ChatChannel channel, bool canInput)
	{
		chatChannel = channel;
		chatMsgs = new List<ChatMessageItemViewModel>();
		newChatData = new List<ChatData>();
		this.canInput = canInput;
	}

	public bool CheckMsgValid(string msg)
	{
		if (checkIntervalRepeated)
		{
			if (msg == null)
			{
				Log.Error("消息不能为空！");
			}
			if (msg.Equals(lastSendMsg))
			{
				return DateTime.Now.Subtract(lastSendDateTime).TotalSeconds >= (double)repeatedMsgInterval;
			}
		}
		return true;
	}

	public int GetCurSendInterval()
	{
		if (!checkInterval)
		{
			waitTime = 0;
			return 0;
		}
		int result = 0;
		msgCountToday = GetSendTodayCount();
		msgCountToday++;
		for (int i = 0; i < msgInterval.Count; i++)
		{
			if (msgCountToday >= msgInterval[i][0])
			{
				result = msgInterval[i][1];
			}
		}
		waitTime = result;
		return result;
	}

	public void AddMsgCount()
	{
		msgCountToday++;
	}

	public void SetWaitTime(int waitTime)
	{
		this.waitTime = waitTime;
	}

	public void UpdateWaitingTime(int waitTime, Action<int> action)
	{
		waitAction = action;
		if (sendTimer != null)
		{
			return;
		}
		this.waitTime = waitTime;
		sendTimer = Timer.Register(1f, delegate
		{
			int num = RefreshChannelWaitTime();
			waitAction?.Invoke(this.waitTime);
			if (num <= 0)
			{
				sendTimer.Cancel();
				sendTimer = null;
				RemoveWaitAction();
			}
		}, null, isLooped: true, useRealTime: true);
	}

	public void RemoveWaitAction()
	{
		waitAction = null;
	}

	public int RefreshChannelWaitTime()
	{
		if (waitTime > 0)
		{
			waitTime--;
			return waitTime;
		}
		return 0;
	}

	public void SetSendParam()
	{
		checkInterval = true;
		checkIntervalRepeated = true;
		checkMsgMax = true;
		repeatedMsgInterval = GameEntry.Base.GameConfig.chat_RepeatedMsgInterval;
		msgInterval = new List<int[]>
		{
			new int[2] { 1, 5 },
			new int[2] { 10, 5 },
			new int[2] { 100, 5 }
		};
		msgMaxCount = 300;
	}

	public void ClearChatLimit()
	{
		msgCountToday = -1;
	}

	public int GetSendTodayCount()
	{
		if (chatChannel == ChatChannel.World)
		{
			return Singleton<ServiceSystem>.Instance.GetService<IChatService>().LoadMsgCountToday();
		}
		return 0;
	}

	public void UpdateLastSendMsg(string msg)
	{
		lastSendMsg = msg;
		lastSendDateTime = DateTime.Now;
		if (chatChannel == ChatChannel.World)
		{
			Singleton<ServiceSystem>.Instance.GetService<IChatService>().SaveMsgCountToday(msgCountToday);
		}
	}

	public void SetOnTop(bool isTop)
	{
		isOnTop = isTop;
	}

	public void AddNewMsg(ChatData chatData)
	{
		newChatData.Add(chatData);
		_ = newChatData.Count;
		_ = chatMsgs.Count;
		if (!checkMsgMax)
		{
			return;
		}
		if (isOnTop && checkMsgMax && newChatData.Count > msgMaxCount)
		{
			if (chatMsgs.Count > 0)
			{
				ChatMessageItemViewModel chatMessageItemViewModel = chatMsgs[chatMsgs.Count - 1];
				chatMsgs.RemoveAt(chatMsgs.Count - 1);
				if (newChatData.Count > 0)
				{
					chatMessageItemViewModel.RefreshData(newChatData[0]);
					chatMsgs.Insert(0, chatMessageItemViewModel);
					newChatData.RemoveAt(0);
				}
			}
			else
			{
				newChatData.RemoveAt(0);
			}
		}
		else if (checkMsgMax && newChatData.Count > msgMaxCount)
		{
			newChatData.RemoveAt(0);
		}
	}

	public int CheckRemoveHistory()
	{
		int count = chatMsgs.Count;
		int num = 0;
		if (checkMsgMax && count > msgMaxCount + msgMaxStayCount)
		{
			for (int num2 = chatMsgs.Count - 1; num2 >= msgMaxCount + msgMaxStayCount; num2--)
			{
				chatMsgs.RemoveAt(num2);
				num++;
			}
		}
		return num;
	}

	public int GetNewMsgItem(OptionBase parent, bool isToBottom)
	{
		int result = 0;
		if (isToBottom)
		{
			foreach (ChatData newChatDatum in newChatData)
			{
				ChatMessageItemViewModel item = new ChatMessageItemViewModel(parent, newChatDatum);
				chatMsgs.Insert(0, item);
			}
			newChatData.Clear();
		}
		return result;
	}

	public ChatData GetChannelLastMsg()
	{
		if (newChatData != null && newChatData.Count > 0)
		{
			return newChatData[newChatData.Count - 1];
		}
		if (chatMsgs != null && chatMsgs.Count > 0)
		{
			return chatMsgs[0].Data;
		}
		return null;
	}

	public int GetNewMsgCount()
	{
		if (newChatData != null)
		{
			return newChatData.Count;
		}
		return 0;
	}

	public void ClearNewChatData()
	{
		if (newChatData != null && newChatData.Count > 0)
		{
			for (int i = 0; i < newChatData.Count; i++)
			{
				if (newChatData[i].isNew)
				{
					newChatData[i].SetNew(isNew: false);
				}
			}
			newChatData.Clear();
		}
		if (chatMsgs == null || chatMsgs.Count <= 0)
		{
			return;
		}
		for (int j = 0; j < chatMsgs.Count; j++)
		{
			if (chatMsgs[j].Data.isNew)
			{
				chatMsgs[j].Data.SetNew(isNew: false);
			}
		}
	}

	public bool HasChannelNew()
	{
		if (newChatData != null && newChatData.Count > 0)
		{
			for (int i = 0; i < newChatData.Count; i++)
			{
				if (newChatData[i].isNew)
				{
					return true;
				}
			}
		}
		if (chatMsgs != null && chatMsgs.Count > 0)
		{
			for (int j = 0; j < chatMsgs.Count; j++)
			{
				if (chatMsgs[j].Data.isNew)
				{
					return true;
				}
			}
		}
		return false;
	}

	public void Clear()
	{
		chatMsgs.Clear();
		newChatData.Clear();
	}
}
