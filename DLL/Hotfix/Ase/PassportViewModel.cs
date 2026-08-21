using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using GameFramework.Runtime;

namespace Ase;

public class PassportViewModel : OptionBase
{
	private bool showLevel;

	private long leftTime;

	private string leftTimeText;

	private int level;

	private int curExp;

	private int curExpLevelMax;

	private float sliderFillAmount;

	private float oldSliderFillAmount;

	private string expText;

	private int oldExp;

	private int oldLevel;

	private int curExpWeek;

	private int curExpWeekMax;

	private string expWeekText;

	private List<TabItemNormalData> tabList;

	private TabItemNormalData curTab;

	private PassportRewardViewModel passportRewardViewModel;

	private PassportTaskViewModel passportTaskViewModel;

	private PassportShowViewModel passportShowViewModel;

	private PassportInfo passportInfo;

	private SimpleCommand openGameTipCmd;

	private Timer timer;

	private bool levelUp;

	private InteractionRequest playExpAddRequest;

	private InteractionRequest playLevelUpRequest;

	private bool redPoint;

	private readonly IMessenger messenger;

	public bool ShowLevel
	{
		get
		{
			return showLevel;
		}
		private set
		{
			Set(ref showLevel, value, "ShowLevel");
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

	public float SliderFillAmount => sliderFillAmount;

	public float OldSliderFillAmount => oldSliderFillAmount;

	public string ExpText
	{
		get
		{
			return expText;
		}
		private set
		{
			Set(ref expText, value, "ExpText");
		}
	}

	public string ExpWeekText
	{
		get
		{
			return expWeekText;
		}
		private set
		{
			Set(ref expWeekText, value, "ExpWeekText");
		}
	}

	public string LeftTimeText
	{
		get
		{
			return leftTimeText;
		}
		private set
		{
			Set(ref leftTimeText, value, "LeftTimeText");
		}
	}

	public bool RedPoint
	{
		get
		{
			return redPoint;
		}
		private set
		{
			Set(ref redPoint, value, "RedPoint");
		}
	}

	public PassportRewardViewModel PassportRewardViewModel => passportRewardViewModel;

	public PassportTaskViewModel PassportTaskViewModel => passportTaskViewModel;

	public PassportShowViewModel PassportShowViewModel => passportShowViewModel;

	public List<TabItemNormalData> TabList => tabList;

	public SimpleCommand OpenGameTipCmd => openGameTipCmd;

	public InteractionRequest PlayExpAddRequest => playExpAddRequest;

	public InteractionRequest PlayLevelUpRequest => playLevelUpRequest;

	public bool LevelUp => levelUp;

	public int OldExp => oldExp;

	public PassportViewModel(OptionBase parent)
	{
		base.parent = parent;
		messenger = Context.GetApplicationContext().GetService<IMessenger>();
		passportInfo = Singleton<ServiceSystem>.Instance.GetService<IPassportService>().GetPassportInfo();
		InitTabList();
		passportRewardViewModel = new PassportRewardViewModel(this, passportInfo);
		InitLevel();
		passportTaskViewModel = new PassportTaskViewModel(this);
		passportShowViewModel = new PassportShowViewModel(this);
		openGameTipCmd = new SimpleCommand(OpenGameTip);
		playExpAddRequest = new InteractionRequest();
		playLevelUpRequest = new InteractionRequest();
		OpenTimer();
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is TabItemNormalData tabItemNormalData)
		{
			curTab.SetSelected(value: false);
			curTab = tabItemNormalData;
			curTab.SetSelected(value: true);
			ShowLevel = curTab.ID != 2;
		}
		else if (obj is OptionArg optionArg)
		{
			if (optionArg.Obj is PassportTaskViewModel)
			{
				if (optionArg.OptionName.Equals("RefreshLevel"))
				{
					RefreshLevelByPoint();
				}
				else if (optionArg.OptionName.Equals("RecordInfo"))
				{
					RecordInfo();
				}
			}
			else if (optionArg.Obj is PassportRewardViewModel && optionArg.OptionName.Equals("BuyPassportSuccess"))
			{
				passportInfo = Singleton<ServiceSystem>.Instance.GetService<IPassportService>().GetPassportInfo();
				Level = passportInfo.Level;
				passportRewardViewModel.CheckBuyPassport(passportInfo);
			}
		}
		else if (obj is string text)
		{
			if (text.Equals("RedPoint"))
			{
				CheckRedPoint();
			}
		}
		else if (obj is OpenViewArg context)
		{
			openWindowRequest.Raise(context);
		}
		else if (obj is PassportTaskItemData passportTaskItemData)
		{
			OpenJumpWindow(passportTaskItemData);
		}
	}

	private void OpenTimer()
	{
		DateTime dateTime = new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Unspecified);
		long num = (long)(DateTime.UtcNow - dateTime).TotalSeconds;
		leftTime = passportInfo.EndTime - num;
		RefreshTime();
		timer = Timer.Register(1f, RefreshTime, null, isLooped: true, useRealTime: true);
	}

	private void RefreshTime()
	{
		if (leftTime <= 0)
		{
			LeftTimeText = "";
			Timer.Cancel(timer);
			timer = null;
			Close();
		}
		else
		{
			leftTime--;
			LeftTimeText = Utility.DateTime.GetLeftDateHourExact(leftTime, "dd\\天hh\\时mm\\分");
		}
	}

	public void BuyLevelOnclick()
	{
		oldLevel = passportInfo.Level;
		int maxLevel = GameEntry.DataTable.GetDataTable<DRPassportReward>().GetDataRows((DRPassportReward p) => p.Grade == 1).Length;
		BuyPassportLevelViewModel userData = new BuyPassportLevelViewModel(this, level, maxLevel, passportInfo.Grade);
		openWindowRequest.Raise(new OpenViewArg(typeof(BuyPassportLevelWindow), userData), delegate
		{
			RefreshLevel();
		});
	}

	private void RefreshLevel()
	{
		passportInfo = Singleton<ServiceSystem>.Instance.GetService<IPassportService>().GetPassportInfo();
		Level = passportInfo.Level;
		passportRewardViewModel.SetLevel(Level);
		if (oldLevel < Level)
		{
			playLevelUpRequest.Raise();
		}
	}

	private void OpenGameTip()
	{
		GamePlayTipsViewModel userData = new GamePlayTipsViewModel(this, 1001);
		openWindowRequest.Raise(new OpenViewArg(typeof(GamePlayTipsWindow), userData));
	}

	private void RefreshLevelByPoint()
	{
		passportInfo = Singleton<ServiceSystem>.Instance.GetService<IPassportService>().GetPassportInfo();
		Level = passportInfo.Level;
		curExp = passportInfo.Point;
		levelUp = oldLevel < Level;
		SetLevel();
		playExpAddRequest.Raise();
	}

	private void RecordInfo()
	{
		oldLevel = passportInfo.Level;
		oldExp = passportInfo.Point;
		oldSliderFillAmount = sliderFillAmount;
	}

	private void SetLevel()
	{
		int num = GameEntry.DataTable.GetDataRows((DRPassportReward p) => p.Grade == 1).Length;
		int queryLevel = ((Level + 1 < num) ? (Level + 1) : num);
		curExpLevelMax = GameEntry.DataTable.GetDataRow((DRPassportReward p) => p.Grade == 1 && p.Level == queryLevel)?.PointNeed ?? 1;
		ExpText = ((curExp > curExpLevelMax) ? $"{curExpLevelMax}/{curExpLevelMax}" : $"{curExp}/{curExpLevelMax}");
		sliderFillAmount = (float)curExp / (float)curExpLevelMax;
		ExpWeekText = ((passportInfo.WeeklyPoint > curExpWeekMax) ? $"{curExpWeekMax}/{curExpWeekMax}" : $"{passportInfo.WeeklyPoint}/{curExpWeekMax}");
		passportRewardViewModel.SetLevel(Level);
	}

	private void InitLevel()
	{
		passportInfo = Singleton<ServiceSystem>.Instance.GetService<IPassportService>().GetPassportInfo();
		oldLevel = passportInfo.Level;
		oldExp = passportInfo.Point;
		Level = passportInfo.Level;
		curExp = passportInfo.Point;
		curExpWeekMax = GameEntry.DataTable.GetAllDataRow<DRPassportShow>()[0].ExpLimit;
		SetLevel();
		oldSliderFillAmount = sliderFillAmount;
	}

	private void InitTabList()
	{
		tabList = new List<TabItemNormalData>();
		for (int i = 0; i < 3; i++)
		{
			TabItemNormalData item = new TabItemNormalData(this, "empty", i);
			tabList.Add(item);
		}
		curTab = tabList[0];
		curTab.SetSelected(value: true);
		ShowLevel = true;
	}

	private void CheckRedPoint()
	{
		if (passportRewardViewModel != null)
		{
			TabList[0].RedPoint = passportRewardViewModel.ShowGetAllReward;
		}
		if (passportTaskViewModel != null)
		{
			TabList[1].RedPoint = passportTaskViewModel.RedPoint;
		}
		RedPoint = TabList[0].RedPoint || TabList[1].RedPoint;
		messenger?.Publish(new RedPointMessage(this, RedPointMessageEnum.Passport));
	}

	private async void OpenJumpWindow(PassportTaskItemData passportTaskItemData)
	{
		Loading loading = await Loading.Show();
		OpenViewArg openViewArg = await new UIJumpHelper().CreateViewJumpData(new JumpWindowParams(passportTaskItemData.JumpWindow, passportTaskItemData.JumpFlagValueList), this, "Passport");
		if (openViewArg != null)
		{
			openWindowRequest.Raise(openViewArg, delegate
			{
				Refresh();
			});
			object userData = openViewArg.UserData;
			if (userData is DrawCardViewModel drawCardViewModel)
			{
				await Task.Delay(100);
				drawCardViewModel.OnShow();
			}
		}
		loading.Dispose();
		passportTaskItemData.canOnClick = true;
	}

	public async void Refresh()
	{
		try
		{
			if (await Singleton<ServiceSystem>.Instance.GetService<IPassportService>().SendGetPassportTaskRequest())
			{
				passportTaskViewModel?.RefreshTask();
			}
			passportInfo = Singleton<ServiceSystem>.Instance.GetService<IPassportService>().GetPassportInfo();
			if (passportInfo != null)
			{
				Level = passportInfo.Level;
				passportRewardViewModel?.CheckBuyPassport(passportInfo);
				passportRewardViewModel?.SetGrade(passportInfo.Grade);
				passportRewardViewModel?.SetLevel(passportInfo.Level);
				CheckRedPoint();
			}
		}
		catch (Exception value)
		{
			Console.WriteLine(value);
			throw;
		}
	}

	public void ReSetTab()
	{
		tabList[0].ItemOnclick();
	}

	public override void Close()
	{
		Timer.Cancel(timer);
		timer = null;
		base.Close();
	}
}
