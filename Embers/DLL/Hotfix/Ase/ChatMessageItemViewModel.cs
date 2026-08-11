namespace Ase;

public class ChatMessageItemViewModel : OptionBase
{
	private string btnText;

	private ChatData data;

	public ChatData Data
	{
		get
		{
			return data;
		}
		private set
		{
			Set(ref data, value, "Data");
		}
	}

	public long Uid => data.uid;

	public bool IsSend => data.isSend;

	public string BtnText
	{
		get
		{
			return btnText;
		}
		set
		{
			Set(ref btnText, value, "BtnText");
		}
	}

	public override void ItemOnClick(object obj)
	{
	}

	public ChatMessageItemViewModel()
	{
	}

	public ChatMessageItemViewModel(OptionBase parent, ChatData chatData)
	{
		base.parent = parent;
		RefreshData(chatData);
	}

	public void RefreshData(ChatData chatData)
	{
		data = chatData;
		GetBtnText();
	}

	public void ShowUserInfo()
	{
		parent.ItemOnClick(new OptionArg(this, "ShowUserInfo"));
	}

	public void OnOperateBtnClick()
	{
		if (!IsSend)
		{
			string text = string.Empty;
			switch (data.ArgEnum)
			{
			case ChatMessageArgEnum.TeamInvite:
				text = "ReceiveBattleInvite";
				break;
			case ChatMessageArgEnum.GuildInvite:
				text = "GuildRecruit";
				break;
			}
			if (!string.IsNullOrEmpty(text))
			{
				parent.ItemOnClick(new OptionArg(this, text));
			}
		}
	}

	public void OnReport()
	{
		parent.ItemOnClick(new OptionArg(this, "OnReport"));
	}

	private void GetBtnText()
	{
		switch (data.ArgEnum)
		{
		case ChatMessageArgEnum.TeamInvite:
			BtnText = "[点击组队]";
			break;
		case ChatMessageArgEnum.GuildInvite:
			BtnText = "[点击加入]";
			break;
		case ChatMessageArgEnum.None:
			break;
		}
	}
}
