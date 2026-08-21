namespace Ase;

public class PropTaskInfoViewModel : OptionBase
{
	private string _content;

	private string _icon;

	private bool _showContent;

	private bool _showIcon;

	private string _title;

	public string Title
	{
		get
		{
			return _title;
		}
		set
		{
			Set(ref _title, value, "Title");
		}
	}

	public string Icon
	{
		get
		{
			return _icon;
		}
		set
		{
			Set(ref _icon, value, "Icon");
		}
	}

	public string Content
	{
		get
		{
			return _content;
		}
		set
		{
			Set(ref _content, value, "Content");
		}
	}

	public bool ShowIcon
	{
		get
		{
			return _showIcon;
		}
		set
		{
			Set(ref _showIcon, value, "ShowIcon");
		}
	}

	public bool ShowContent
	{
		get
		{
			return _showContent;
		}
		set
		{
			Set(ref _showContent, value, "ShowContent");
		}
	}

	public PropTaskInfoViewModel()
	{
	}

	public PropTaskInfoViewModel(OptionBase parent, string title, string icon = null, string content = null)
	{
		base.parent = parent;
		Title = title;
		Icon = icon;
		Content = content;
		ShowIcon = !string.IsNullOrEmpty(Icon);
		ShowContent = !string.IsNullOrEmpty(Content);
	}
}
