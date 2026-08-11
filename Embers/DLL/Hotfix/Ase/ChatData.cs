using GameFramework.Runtime;

namespace Ase;

public class ChatData : ViewModelBase
{
	public string name;

	public string icon;

	public int emojiId;

	public int level;

	public string msg;

	public string avatar;

	public int titleId;

	public int frameId;

	public int bubble;

	public bool isSend;

	public long uid;

	public long argId;

	public bool isNew;

	public ChatMessageArgEnum argTypeEnum;

	public int copyId;

	public string Name
	{
		get
		{
			return name;
		}
		private set
		{
			Set(ref name, value, "Name");
		}
	}

	public int Level
	{
		get
		{
			return level;
		}
		private set
		{
			Set(ref level, value, "Level");
		}
	}

	public string Msg
	{
		get
		{
			return msg;
		}
		private set
		{
			Set(ref msg, value, "Msg");
		}
	}

	public string Avatar
	{
		get
		{
			return avatar;
		}
		private set
		{
			Set(ref avatar, value, "Avatar");
		}
	}

	public int FrameId
	{
		get
		{
			return frameId;
		}
		private set
		{
			Set(ref frameId, value, "FrameId");
		}
	}

	public int TitleId
	{
		get
		{
			return titleId;
		}
		private set
		{
			Set(ref titleId, value, "TitleId");
		}
	}

	public string Icon
	{
		get
		{
			return icon;
		}
		private set
		{
			Set(ref icon, value, "Icon");
		}
	}

	public int Bubble
	{
		get
		{
			return bubble;
		}
		private set
		{
			Set(ref bubble, value, "Bubble");
		}
	}

	public long ArgId
	{
		get
		{
			return argId;
		}
		private set
		{
			Set(ref argId, value, "ArgId");
		}
	}

	public ChatMessageArgEnum ArgEnum
	{
		get
		{
			return argTypeEnum;
		}
		private set
		{
			Set(ref argTypeEnum, value, "ArgEnum");
		}
	}

	public static ChatData CreateSystem(string msg)
	{
		return new ChatData
		{
			name = "",
			icon = "",
			level = 0,
			msg = msg,
			avatar = "",
			isSend = false,
			uid = 0L,
			argId = 0L,
			isNew = true,
			argTypeEnum = ChatMessageArgEnum.System,
			bubble = 0
		};
	}

	public void SetBubble(int bubbleId, bool send)
	{
		Bubble = bubbleId;
	}

	public void SetNew(bool isNew)
	{
		this.isNew = isNew;
	}
}
