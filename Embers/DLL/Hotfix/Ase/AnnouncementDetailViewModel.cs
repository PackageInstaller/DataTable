using GameFramework.Runtime;

namespace Ase;

public class AnnouncementDetailViewModel : OptionBase
{
	private AnnouncementItemData data;

	private InteractionRequest refreshAllRequest = new InteractionRequest();

	private string title;

	private string startTime;

	private string headImage = "";

	public AnnouncementItemData Data
	{
		get
		{
			return data;
		}
		set
		{
			Set(ref data, value, "Data");
			Title = value.Data.Title;
			StartTime = $"{value.Data.StartTime.Month}月{value.Data.StartTime.Day}日";
			HeadImage = ((value.Data == null) ? "" : value.Data.Picture);
			refreshAllRequest.Raise();
		}
	}

	public string Title
	{
		get
		{
			return title;
		}
		set
		{
			Set(ref title, value, "Title");
		}
	}

	public string StartTime
	{
		get
		{
			return startTime;
		}
		set
		{
			Set(ref startTime, value, "StartTime");
		}
	}

	public string HeadImage
	{
		get
		{
			return headImage;
		}
		set
		{
			Set(ref headImage, value, "HeadImage");
		}
	}

	public InteractionRequest RefreshAllRequest => refreshAllRequest;

	public AnnouncementDetailViewModel()
	{
	}

	public AnnouncementDetailViewModel(OptionBase parent)
	{
		base.parent = parent;
	}
}
