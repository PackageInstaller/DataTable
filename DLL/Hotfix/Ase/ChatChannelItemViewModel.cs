namespace Ase;

public class ChatChannelItemViewModel : OptionBase
{
	private ChatChannel channel;

	private string name;

	private bool isSelected;

	private bool hasNew;

	public string Name
	{
		get
		{
			return name;
		}
		set
		{
			Set(ref name, value, "Name");
		}
	}

	public bool IsSelected
	{
		get
		{
			return isSelected;
		}
		private set
		{
			Set(ref isSelected, value, "IsSelected");
		}
	}

	public bool HasNew
	{
		get
		{
			return hasNew;
		}
		private set
		{
			Set(ref hasNew, value, "HasNew");
		}
	}

	public ChatChannel Channel => channel;

	public override void ItemOnClick(object obj)
	{
	}

	public ChatChannelItemViewModel()
	{
	}

	public ChatChannelItemViewModel(OptionBase parent, ChatChannel channel)
	{
		base.parent = parent;
		this.channel = channel;
		name = GetChannelName(channel);
	}

	public void OnClick()
	{
		IsSelected = true;
		HasNew = false;
		parent.ItemOnClick(this);
	}

	public void SetNew(bool hasNew)
	{
		HasNew = hasNew;
	}

	public void SetSelect(bool isSelect)
	{
		IsSelected = isSelect;
	}

	private string GetChannelName(ChatChannel chatChannel)
	{
		return chatChannel switch
		{
			ChatChannel.None => "默认", 
			ChatChannel.World => "世界", 
			ChatChannel.Team => "队伍", 
			ChatChannel.Guild => "公会", 
			ChatChannel.Recruit => "招募", 
			ChatChannel.Campaign => "守备战", 
			_ => "默认", 
		};
	}
}
