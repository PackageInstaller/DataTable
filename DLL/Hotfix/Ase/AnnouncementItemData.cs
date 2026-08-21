namespace Ase;

public class AnnouncementItemData : OptionBase
{
	private AnnouncementData data;

	private bool isSelected;

	private string startTime;

	public AnnouncementData Data
	{
		get
		{
			return data;
		}
		private set
		{
			Set(ref data, value, "Data");
			StartTime = $"{value.StartTime.Month}月{value.StartTime.Day}日";
		}
	}

	public bool IsSelected
	{
		get
		{
			return isSelected;
		}
		set
		{
			Set(ref isSelected, value, "IsSelected");
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

	public AnnouncementItemData(OptionBase parent, AnnouncementData data)
	{
		base.parent = parent;
		Data = data;
		IsSelected = false;
	}

	public void OnClick()
	{
		parent.ItemOnClick(this);
	}

	public void IsRead()
	{
		Data.IsRead = true;
	}
}
