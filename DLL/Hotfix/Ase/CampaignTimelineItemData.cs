using System.Collections.Generic;

namespace Ase;

public class CampaignTimelineItemData : OptionBase
{
	private int id;

	private string iconPath;

	private bool isNew;

	private bool upDown;

	private bool isLock;

	private List<int> timelineIds = new List<int>();

	public int Id => id;

	public string IconPath => iconPath;

	public List<int> TimelineIds => timelineIds;

	public bool UpDown
	{
		get
		{
			return upDown;
		}
		set
		{
			Set(ref upDown, value, "UpDown");
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

	public bool IsLock
	{
		get
		{
			return isLock;
		}
		set
		{
			Set(ref isLock, value, "IsLock");
		}
	}

	public CampaignTimelineItemData(OptionBase parent, DRCampaign cf)
	{
		base.parent = parent;
		if (cf != null)
		{
			id = cf.Id;
			iconPath = cf.StoryIcon;
			timelineIds = cf.CurStory;
		}
	}

	public void SetIsNew(bool value)
	{
		IsNew = value;
	}

	public void OnClick()
	{
		if (isLock)
		{
			Toast.ShowInfo("未解锁改剧情");
		}
		else
		{
			parent?.ItemOnClick(new OptionArg(this, "Open"));
		}
	}

	public void SetRedPoint()
	{
		if (IsNew)
		{
			IsNew = false;
		}
	}
}
