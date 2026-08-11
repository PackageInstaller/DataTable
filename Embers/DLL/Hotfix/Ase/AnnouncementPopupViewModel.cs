using GameFramework.Runtime;

namespace Ase;

public class AnnouncementPopupViewModel : ViewModelBase
{
	private string _title;

	private string _date;

	private string _version;

	private string _content;

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

	public string Date
	{
		get
		{
			return _date;
		}
		set
		{
			Set(ref _date, value, "Date");
		}
	}

	public string Version
	{
		get
		{
			return _version;
		}
		set
		{
			Set(ref _version, value, "Version");
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

	public AnnouncementPopupViewModel()
	{
	}

	public AnnouncementPopupViewModel(AnnouncementSetting setting)
	{
		Title = setting.Title;
		Date = setting.Date;
		Version = setting.Version;
		Content = setting.Content;
	}
}
