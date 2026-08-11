using System;
using GameFramework.Runtime;

namespace Ase;

public class DrawCardPoolInfo : ViewModelBase
{
	public string Name;

	public int Id;

	public string NormalIcon;

	public string SelectedIcon;

	public string Tag;

	public string TagColor;

	public int Type;

	public int DropType;

	public RoleMoneyEnum CostPropType;

	public string CostPropIcon;

	public string Desc;

	public bool HaveSingle;

	public int LotteryMax;

	public int LotteryTotalTimes;

	public int LotteryLeft;

	public int PerCost;

	public int SaleNum;

	public int SaleTime;

	public int SelectUpId;

	public int Trigger;

	public int MaxTrigger;

	private long deadLineTime;

	private Timer timer;

	private Action<int> closePoolAction;

	public long DeadLineTime
	{
		get
		{
			return deadLineTime;
		}
		set
		{
			Set(ref deadLineTime, value, "DeadLineTime");
		}
	}

	public void OpenTimer()
	{
		timer = Timer.Register(1f, RefreshTime, null, isLooped: true, useRealTime: true);
	}

	private void RefreshTime()
	{
		if (DeadLineTime <= 0)
		{
			return;
		}
		DeadLineTime--;
		if (DeadLineTime == 0L)
		{
			if (Singleton<ServiceSystem>.Instance.GetService<IDrawCardService>().ClosePool(Id))
			{
				Context.GetApplicationContext().GetService<IMessenger>()?.Publish(new DrawCardMessage(this, DrawCardMsgEnum.ClosePoolImmediately));
			}
			Timer.Cancel(timer);
			timer = null;
		}
	}

	protected override void Dispose(bool disposing)
	{
		if (timer != null)
		{
			Timer.Cancel(timer);
			timer = null;
		}
		base.Dispose(disposing);
	}
}
