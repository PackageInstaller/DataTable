using GameFramework.Runtime;

namespace Ase;

public class PlayerChatData : ViewModelBase
{
	private PlayerData _playerData;

	private string _chatText;

	private long _chatTime;

	private bool _unRead;

	private bool _isMsg;

	private bool _isEmoji;

	private string _emoji;

	private int _bubble;

	private string _chatBubble = "";

	public string Emoji
	{
		get
		{
			return _emoji;
		}
		private set
		{
			Set(ref _emoji, value, "Emoji");
		}
	}

	public int Bubble
	{
		get
		{
			return _bubble;
		}
		set
		{
			Set(ref _bubble, value, "Bubble");
		}
	}

	public string ChatBubble
	{
		get
		{
			return _chatBubble;
		}
		set
		{
			Set(ref _chatBubble, value, "ChatBubble");
		}
	}

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

	public string ChatText
	{
		get
		{
			return _chatText;
		}
		private set
		{
			Set(ref _chatText, value, "ChatText");
		}
	}

	public long ChatTime
	{
		get
		{
			return _chatTime;
		}
		private set
		{
			Set(ref _chatTime, value, "ChatTime");
		}
	}

	public bool UnRead
	{
		get
		{
			return _unRead;
		}
		private set
		{
			Set(ref _unRead, value, "UnRead");
		}
	}

	public bool IsMsg
	{
		get
		{
			return _isMsg;
		}
		private set
		{
			Set(ref _isMsg, value, "IsMsg");
		}
	}

	public bool IsEmoji
	{
		get
		{
			return _isEmoji;
		}
		private set
		{
			Set(ref _isEmoji, value, "IsEmoji");
		}
	}

	public PlayerChatData(PlayerData playerData, string chatText, long chatTime, bool unRead, int chatBubble = 0)
	{
		PlayerData = playerData;
		ChatText = chatText;
		ChatTime = chatTime;
		UnRead = unRead;
		(int, string) tuple = ChatHelper.ChangeString2Emoji(ChatText);
		int item = tuple.Item1;
		string item2 = tuple.Item2;
		IsEmoji = item > 0;
		IsMsg = !IsEmoji;
		Emoji = item2;
		Bubble = chatBubble;
		if (IsMsg)
		{
			ChatBubble = GameEntry.DataTable.GetDataRow<DRChatBox>(Bubble)?.ResPath2 ?? "";
		}
	}

	public void SetReadState(bool read)
	{
		UnRead = !read;
	}
}
