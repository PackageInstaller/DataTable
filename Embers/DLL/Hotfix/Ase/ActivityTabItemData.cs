#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using GameFramework;

namespace Ase;

public class ActivityTabItemData : TabItemData
{
	private long _leftActivityTime = -1L;

	private string _timeText;

	private Timer _timer;

	public ActivityTabItem Item;

	public string TimeText
	{
		get
		{
			return _timeText;
		}
		set
		{
			Set(ref _timeText, value, "TimeText");
		}
	}

	public ActivityTabItemData()
	{
	}

	public ActivityTabItemData(OptionBase parent, int tabIndex)
		: base(parent, tabIndex)
	{
	}

	public override void SetSelected(bool selectedState)
	{
		base.IsSelected = selectedState;
		if (Item != null && Item.Selected != selectedState)
		{
			Item.PlayAni(selectedState);
		}
	}

	public bool StartTimer(long leftTime)
	{
		ClearTimer();
		_leftActivityTime = leftTime;
		if (_leftActivityTime < 0)
		{
			return true;
		}
		try
		{
			TimeText = OpActivityDefinition.GetActivityTimeText(_leftActivityTime, 7);
			_timer = Timer.Register(1f, OnComplete, null, isLooped: true, useRealTime: true);
		}
		catch (Exception)
		{
			Log.Error($"ActivityTabItem:{base.TabIndex} ：开启计时器失败");
			return false;
		}
		return true;
	}

	private void OnComplete()
	{
		_leftActivityTime--;
		if (_leftActivityTime < 0)
		{
			_leftActivityTime = 0L;
			TimeText = "已结束";
			ClearTimer();
		}
		else
		{
			TimeText = OpActivityDefinition.GetActivityTimeText(_leftActivityTime, 7);
		}
	}

	public void ClearTimer()
	{
		if (_timer != null)
		{
			_timer.Cancel();
			_timer = null;
		}
	}

	protected override void Dispose(bool disposing)
	{
		ClearTimer();
		base.Dispose(disposing);
	}
}
