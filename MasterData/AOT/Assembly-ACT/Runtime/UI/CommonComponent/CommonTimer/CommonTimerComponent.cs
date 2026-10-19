using System;
using System.Collections.Generic;
using ACT.UI;
using Bamboo.Chronos;
using Bamboo.NumberString;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace Runtime.UI.CommonComponent.CommonTimer;

public class CommonTimerComponent : BaseUIComponent
{
	[Serializable]
	private struct TimeStyle
	{
		public GameObject root;

		public TMP_Text number;

		public LocalizeStringEvent unit;
	}

	[Header("永久")]
	[SerializeField]
	private GameObject _permanentTimeTip;

	[Header("年")]
	[SerializeField]
	private TimeStyle _yearStyle;

	[Header("月")]
	[SerializeField]
	private TimeStyle _monthStyle;

	[Header("日")]
	[SerializeField]
	private TimeStyle _dayStyle;

	[Header("小时")]
	[SerializeField]
	private TimeStyle _hourStyle;

	[Header("分钟")]
	[SerializeField]
	private TimeStyle _minuteStyle;

	[Header("秒")]
	[SerializeField]
	private TimeStyle _secondStyle;

	private DateTime _time;

	private bool _isCountDown;

	private int _length = 1;

	public Action OnTimeOut;

	private Looper _looper;

	private List<TimeStyle> _timeStyles;

	private float _lastRealtimeSinceStartup;

	private bool _timeOutInvoked;

	public const long PermanentTicks = 3153600000000000L;

	public DateTime Time
	{
		get
		{
			return _time;
		}
		set
		{
			_time = value;
			DateTime time = _time;
			DateTime minValue = DateTime.MinValue;
			if (time >= minValue.AddSeconds(1.0))
			{
				_timeOutInvoked = false;
			}
			Refresh();
		}
	}

	public bool IsCountDown
	{
		get
		{
			return _isCountDown;
		}
		set
		{
			if (value != _isCountDown)
			{
				_isCountDown = value;
				Refresh();
			}
		}
	}

	public int Length
	{
		get
		{
			return _length;
		}
		set
		{
			if (value != _length)
			{
				_length = Mathf.Max(1, value);
				Refresh();
			}
		}
	}

	private void Awake()
	{
		_timeStyles = ListPool<TimeStyle>.Get();
		_timeStyles.Add(_yearStyle);
		_timeStyles.Add(_monthStyle);
		_timeStyles.Add(_dayStyle);
		_timeStyles.Add(_hourStyle);
		_timeStyles.Add(_minuteStyle);
		_timeStyles.Add(_secondStyle);
	}

	private void OnDestroy()
	{
		if (_looper.IsValid())
		{
			_looper.Cancel();
		}
		if (_timeStyles != null)
		{
			_timeStyles.Clear();
			ListPool<TimeStyle>.Release(_timeStyles);
			_timeStyles = null;
		}
	}

	private void Refresh()
	{
		if (_time.Ticks >= 3153600000000000L)
		{
			if ((bool)_permanentTimeTip)
			{
				_permanentTimeTip.SetActive(value: true);
			}
			if (_timeStyles == null)
			{
				return;
			}
			foreach (TimeStyle timeStyle in _timeStyles)
			{
				timeStyle.root.SetActive(value: false);
			}
			if (_looper.IsValid())
			{
				_looper.Cancel();
			}
		}
		else
		{
			if ((bool)_permanentTimeTip)
			{
				_permanentTimeTip.SetActive(value: false);
			}
			if (!_looper.IsValid() && (bool)gameObject)
			{
				_lastRealtimeSinceStartup = UnityEngine.Time.realtimeSinceStartup;
				_looper = UpdateTimer.Default.LoopMs(1000, UpdateDataInternal);
			}
			else
			{
				UpdateDataInternal();
			}
		}
	}

	private void UpdateDataInternal()
	{
		if (!this)
		{
			_looper.Cancel();
			return;
		}
		float realtimeSinceStartup = UnityEngine.Time.realtimeSinceStartup;
		float num = realtimeSinceStartup - _lastRealtimeSinceStartup;
		_lastRealtimeSinceStartup = realtimeSinceStartup;
		DateTime time = _time;
		DateTime minValue = DateTime.MinValue;
		if (time < minValue.AddSeconds(1.0))
		{
			_time = DateTime.MinValue;
			_looper.Cancel();
			UpdateTimeText();
			if (!_timeOutInvoked)
			{
				_timeOutInvoked = true;
				OnTimeOut?.Invoke();
			}
			return;
		}
		DateTime time2 = _time;
		minValue = DateTime.MaxValue;
		if (time2 > minValue.AddSeconds(-1.0))
		{
			_time = DateTime.MaxValue;
			_looper.Cancel();
			UpdateTimeText();
			return;
		}
		if (_isCountDown)
		{
			_time -= TimeSpan.FromSeconds(num);
		}
		else
		{
			_time += TimeSpan.FromSeconds(num);
		}
		UpdateTimeText();
	}

	private void UpdateTimeText()
	{
		if (_timeStyles == null)
		{
			return;
		}
		int year = _time.Year;
		DateTime minValue = DateTime.MinValue;
		int num = year - minValue.Year;
		int month = _time.Month;
		minValue = DateTime.MinValue;
		int num2 = month - minValue.Month;
		int day = _time.Day;
		minValue = DateTime.MinValue;
		int num3 = day - minValue.Day;
		int hour = _time.Hour;
		minValue = DateTime.MinValue;
		int num4 = hour - minValue.Hour;
		int minute = _time.Minute;
		minValue = DateTime.MinValue;
		int num5 = minute - minValue.Minute;
		int second = _time.Second;
		minValue = DateTime.MinValue;
		int num6 = second - minValue.Second;
		int num7 = 4;
		if (num > 0)
		{
			num7 = 0;
		}
		else if (num2 > 0)
		{
			num7 = 1;
		}
		else if (num3 > 0)
		{
			num7 = 2;
		}
		else if (num4 > 0)
		{
			num7 = 3;
		}
		else if (num5 > 0)
		{
			num7 = 4;
		}
		else if (num6 > 0)
		{
			num7 = 5;
		}
		int num8 = Mathf.Clamp(num7 + _length, num7, 5);
		for (int i = 0; i < _timeStyles.Count; i++)
		{
			TimeStyle timeStyle = _timeStyles[i];
			if (i < num7 || i > num8)
			{
				timeStyle.root.SetActive(value: false);
				continue;
			}
			timeStyle.root.SetActive(value: true);
			int value = i switch
			{
				0 => num, 
				1 => num2, 
				2 => num3, 
				3 => num4, 
				4 => num5, 
				5 => num6, 
				_ => throw new ArgumentOutOfRangeException(), 
			};
			timeStyle.number.SetText(value.FastToString());
		}
	}
}
