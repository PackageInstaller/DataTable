using System;
using GameFramework.Runtime;

namespace Ase;

public class HLPlantItemData : OptionBase
{
	private int gridId;

	private int state;

	private string seedIcon;

	private int seedId;

	private int seedRarity;

	private bool isIncrease;

	private bool isShowExBtn;

	private long leftTime;

	private string leftTimeText;

	private string harvestingCount;

	private SimpleCommand abortPlantCmd;

	private SimpleCommand speedUpPlantCmd;

	private bool isMask;

	private Timer timer;

	private bool isSelect;

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

	public bool IsIncrease
	{
		get
		{
			return isIncrease;
		}
		set
		{
			Set(ref isIncrease, value, "IsIncrease");
		}
	}

	public int GridId => gridId;

	public string SeedIcon
	{
		get
		{
			return seedIcon;
		}
		set
		{
			Set(ref seedIcon, value, "SeedIcon");
		}
	}

	public int SeedRarity
	{
		get
		{
			return seedRarity;
		}
		set
		{
			Set(ref seedRarity, value, "SeedRarity");
		}
	}

	public int SeedId
	{
		get
		{
			return seedId;
		}
		set
		{
			Set(ref seedId, value, "SeedId");
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

	public string HarvestingCount
	{
		get
		{
			return harvestingCount;
		}
		set
		{
			Set(ref harvestingCount, value, "HarvestingCount");
		}
	}

	public bool IsShowExBtn
	{
		get
		{
			return isShowExBtn;
		}
		set
		{
			Set(ref isShowExBtn, value, "IsShowExBtn");
		}
	}

	public long LeftTime
	{
		get
		{
			return leftTime;
		}
		set
		{
			Set(ref leftTime, value, "LeftTime");
		}
	}

	public bool IsMask
	{
		get
		{
			return isMask;
		}
		set
		{
			Set(ref isMask, value, "IsMask");
		}
	}

	public bool IsSelect
	{
		get
		{
			return isSelect;
		}
		set
		{
			Set(ref isSelect, value, "IsSelect");
		}
	}

	public SimpleCommand AbortPlantCmd => abortPlantCmd;

	public SimpleCommand SpeedUpPlantCmd => speedUpPlantCmd;

	public HLPlantItemData(OptionBase parent, int gridId)
	{
		base.parent = parent;
		abortPlantCmd = new SimpleCommand(AbortPlant);
		speedUpPlantCmd = new SimpleCommand(SpeedUpPlant);
		this.gridId = gridId;
		seedId = 0;
		seedIcon = "Icon_BattleProp_801001";
		State = 2;
		LeftTimeText = "";
		HarvestingCount = "";
		IsIncrease = false;
	}

	public void SetLeftTime(long time, int state)
	{
		Timer.Cancel(timer);
		State = state;
		DateTime dateTime = new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Unspecified);
		long num = (long)(DateTime.UtcNow - dateTime).TotalSeconds;
		LeftTime = time - num;
		RefreshTime();
		timer = Timer.Register(1f, RefreshTime, null, isLooped: true, useRealTime: true);
	}

	public void SetSeedInfo(string seedIcon, int seedId, int seedRarity)
	{
		SeedIcon = seedIcon;
		SeedId = seedId;
		SeedRarity = seedRarity;
	}

	private void RefreshTime()
	{
		if (LeftTime <= 0)
		{
			State = 4;
			IsShowExBtn = false;
			parent?.ItemOnClick(this);
		}
		else
		{
			LeftTime--;
			LeftTimeText = Utility.DateTime.GetLeftDateTimeWithLatest(LeftTime);
		}
	}

	public void SetCount(long count)
	{
		HarvestingCount = $"x{count}";
	}

	public void SetMask(bool value)
	{
		IsMask = value;
	}

	public void CloseBtn()
	{
		IsShowExBtn = false;
	}

	public void AbortState()
	{
		State = 2;
		isIncrease = false;
		LeftTimeText = "";
		HarvestingCount = "";
		Timer.Cancel(timer);
		CloseBtn();
	}

	public void BtnOnClick()
	{
		parent?.ItemOnClick(new OptionArg(this, "OnClick"));
	}

	private void AbortPlant()
	{
		parent?.ItemOnClick(new OptionArg(this, "Abort"));
	}

	private void SpeedUpPlant()
	{
		parent?.ItemOnClick(new OptionArg(this, "SpeedUp"));
	}
}
