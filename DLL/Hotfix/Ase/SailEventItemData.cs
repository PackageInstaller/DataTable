using System.Collections.Generic;

namespace Ase;

public class SailEventItemData : OptionBase
{
	public long uid;

	private int eventId;

	private int rarity;

	private string icon;

	private string eventName;

	private int state;

	private DRSailEvent drSailEvent;

	public int Area;

	private int costTime;

	private long leftTime;

	private string leftTimeText;

	private Timer timer;

	private bool isNew;

	private bool isSelect;

	public List<int> HeroIdList;

	public int EventId => eventId;

	public long Uid => uid;

	public string Icon
	{
		get
		{
			return icon;
		}
		set
		{
			Set(ref icon, value, "Icon");
		}
	}

	public int Rarity
	{
		get
		{
			return rarity;
		}
		set
		{
			Set(ref rarity, value, "Rarity");
		}
	}

	public string EventName
	{
		get
		{
			return eventName;
		}
		set
		{
			Set(ref eventName, value, "EventName");
		}
	}

	public int State
	{
		get
		{
			return state;
		}
		set
		{
			Set(ref state, value, "State");
		}
	}

	public string LeftTimeText
	{
		get
		{
			return leftTimeText;
		}
		set
		{
			Set(ref leftTimeText, value, "LeftTimeText");
		}
	}

	public bool IsNew
	{
		get
		{
			return isNew;
		}
		set
		{
			Set(ref isNew, value, "IsNew");
		}
	}

	public bool IsSelect
	{
		get
		{
			return isSelect;
		}
		private set
		{
			Set(ref isSelect, value, "IsSelect");
		}
	}

	public DRSailEvent DrSailEvent => drSailEvent;

	public SailEventItemData(OptionBase parent)
	{
		base.parent = parent;
		HeroIdList = new List<int>();
	}

	public void LoadBaseInfo(DRSailEvent drSailEvent)
	{
		this.drSailEvent = drSailEvent;
		Rarity = drSailEvent.Rarity;
		Icon = $"SailLight_Faction_{drSailEvent.Area}";
		EventName = drSailEvent.Name;
		costTime = drSailEvent.Time;
		eventId = drSailEvent.Id;
		Area = drSailEvent.Area;
	}

	public void SetInfo(long startTime, List<int> heroIdList, bool isNew = false)
	{
		Timer.Cancel(timer);
		timer = null;
		HeroIdList = heroIdList;
		if (startTime == 0L)
		{
			State = 2;
			return;
		}
		long curServerTime = Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetCurServerTime();
		if (curServerTime - startTime < costTime)
		{
			State = 3;
			leftTime = costTime - (curServerTime - startTime);
			LeftTimeText = Utility.DateTime.GetLeftDateTimeWithLatest(leftTime);
			parent?.ItemOnClick(new OptionArg(this, "TimeRefresh"));
			timer = Timer.Register(1f, RefreshTime, null, isLooped: true, useRealTime: true);
		}
		else
		{
			State = 1;
		}
	}

	private void RefreshTime()
	{
		if (leftTime <= 0)
		{
			State = 1;
			parent?.ItemOnClick(new OptionArg(this, "TimeFinish"));
		}
		else
		{
			leftTime--;
			LeftTimeText = Utility.DateTime.GetLeftDateTimeWithLatest(leftTime);
			parent?.ItemOnClick(new OptionArg(this, "TimeRefresh"));
		}
	}

	public void Onclick()
	{
		parent?.ItemOnClick(new OptionArg(this, "EventOnclick"));
	}

	public void SetSelect(bool value)
	{
		IsSelect = value;
	}
}
