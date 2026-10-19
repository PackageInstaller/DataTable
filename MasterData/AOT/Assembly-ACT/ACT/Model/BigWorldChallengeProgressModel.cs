using System;
using System.Collections.Generic;
using ACT.Event;
using Fundamental;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;

namespace ACT.Model;

public class BigWorldChallengeProgressModel : Model<BigWorldChallengeProgressModel>
{
	private BigWordTimeDate _bigWordTimeDateEventData;

	private BigWordProgressData _bigWordProgressEventData_Title;

	private BigWordProgressData _bigWordProgressEventData_Progress;

	private BigWordTitledata _bigWordTitleEventData;

	private Action _onBigWordChangeTimerEventHandler;

	private Action _onRefreshBigWorldProgressTitleEventHandler;

	private Action _onRefreshBigWorldProgressEventHandler;

	private Action _onBigWorldProgressTitleEventHandler;

	private Action _onBigWorldProgressExit;

	public bool useString { get; private set; }

	public List<LocalizedString> stringList { get; private set; }

	public List<LocalizeStringEvent> eventList { get; private set; }

	public bool isInBigWorld { get; set; }

	public BigWordTimeDate BigWordTimeDateEventData
	{
		get
		{
			return _bigWordTimeDateEventData;
		}
		set
		{
			_bigWordTimeDateEventData = value;
		}
	}

	public BigWordProgressData BigWordProgressEventData_Title
	{
		get
		{
			return _bigWordProgressEventData_Title;
		}
		set
		{
			_bigWordProgressEventData_Title = value;
		}
	}

	public BigWordProgressData BigWordProgressEventData_Progress
	{
		get
		{
			return _bigWordProgressEventData_Progress;
		}
		set
		{
			_bigWordProgressEventData_Progress = value;
		}
	}

	public BigWordTitledata BigWordTitleEventData
	{
		get
		{
			return _bigWordTitleEventData;
		}
		set
		{
			_bigWordTitleEventData = value;
		}
	}

	public event Action OnBigWordChangeTimerEventHandler
	{
		add
		{
			_onBigWordChangeTimerEventHandler = (Action)Delegate.Combine(_onBigWordChangeTimerEventHandler, value);
		}
		remove
		{
			_onBigWordChangeTimerEventHandler = (Action)Delegate.Remove(_onBigWordChangeTimerEventHandler, value);
		}
	}

	public event Action OnRefreshBigWorldProgressTitleEventHandler
	{
		add
		{
			_onRefreshBigWorldProgressTitleEventHandler = (Action)Delegate.Combine(_onRefreshBigWorldProgressTitleEventHandler, value);
		}
		remove
		{
			_onRefreshBigWorldProgressTitleEventHandler = (Action)Delegate.Remove(_onRefreshBigWorldProgressTitleEventHandler, value);
		}
	}

	public event Action OnRefreshBigWorldProgressEventHandler
	{
		add
		{
			_onRefreshBigWorldProgressEventHandler = (Action)Delegate.Combine(_onRefreshBigWorldProgressEventHandler, value);
		}
		remove
		{
			_onRefreshBigWorldProgressEventHandler = (Action)Delegate.Remove(_onRefreshBigWorldProgressEventHandler, value);
		}
	}

	public event Action OnBigWorldProgressTitleEventHandlerEventHandler
	{
		add
		{
			_onBigWorldProgressTitleEventHandler = (Action)Delegate.Combine(_onBigWorldProgressTitleEventHandler, value);
		}
		remove
		{
			_onBigWorldProgressTitleEventHandler = (Action)Delegate.Remove(_onBigWorldProgressTitleEventHandler, value);
		}
	}

	public event Action OnBigWorldProgressExit
	{
		add
		{
			_onBigWorldProgressExit = (Action)Delegate.Combine(_onBigWorldProgressExit, value);
		}
		remove
		{
			_onBigWorldProgressExit = (Action)Delegate.Remove(_onBigWorldProgressExit, value);
		}
	}

	protected override void Init()
	{
		stringList = ListPool<LocalizedString>.Get();
		eventList = ListPool<LocalizeStringEvent>.Get();
		AddEventListener();
	}

	private void AddEventListener()
	{
		EventManager instance = Singleton<EventManager>.instance;
		instance.AddEventListener(ClientEvent.UI_BigWordChangeTimer, OnBigWordChangeTimer);
		instance.AddEventListener(ClientEvent.UI_RefreshBigWorldProgressTitle, OnRefreshBigWorldProgressTitle);
		instance.AddEventListener(ClientEvent.UI_RefreshBigWorldProgress, OnBigWorldProgress);
		instance.AddEventListener(ClientEvent.UI_BigWorldProgressTitle, OnBigWorldProgressTitle);
	}

	protected override void UnInit()
	{
		RemoveEventListener();
		ListPool<LocalizedString>.Release(stringList);
		ListPool<LocalizeStringEvent>.Release(eventList);
		_bigWordTimeDateEventData = null;
		_bigWordProgressEventData_Title = null;
		_bigWordProgressEventData_Progress = null;
		_bigWordTitleEventData = null;
	}

	private void RemoveEventListener()
	{
		EventManager instance = Singleton<EventManager>.instance;
		instance.RemoveEventListener(ClientEvent.UI_BigWordChangeTimer, OnBigWordChangeTimer);
		instance.RemoveEventListener(ClientEvent.UI_RefreshBigWorldProgressTitle, OnRefreshBigWorldProgressTitle);
		instance.RemoveEventListener(ClientEvent.UI_RefreshBigWorldProgress, OnBigWorldProgress);
		instance.RemoveEventListener(ClientEvent.UI_BigWorldProgressTitle, OnBigWorldProgressTitle);
	}

	private void OnBigWorldProgressTitle(BaseEventContent obj)
	{
		_bigWordTitleEventData = (BigWordTitledata)obj;
		isInBigWorld = true;
		_onBigWorldProgressTitleEventHandler?.Invoke();
	}

	public void StartChallenge(List<LocalizeStringEvent> list)
	{
		useString = false;
		isInBigWorld = true;
		eventList.Clear();
		eventList.AddRange(list);
		_onBigWorldProgressTitleEventHandler?.Invoke();
	}

	public void StartChallenge(List<LocalizedString> list)
	{
		useString = true;
		isInBigWorld = true;
		stringList.Clear();
		stringList.AddRange(list);
		_onBigWorldProgressTitleEventHandler?.Invoke();
	}

	public void InputStopChallenge()
	{
		if (isInBigWorld)
		{
			_onBigWorldProgressExit?.Invoke();
		}
	}

	private void OnBigWorldProgress(BaseEventContent obj)
	{
		_bigWordProgressEventData_Progress = (BigWordProgressData)obj;
		_onRefreshBigWorldProgressEventHandler?.Invoke();
	}

	private void OnRefreshBigWorldProgressTitle(BaseEventContent obj)
	{
		_bigWordProgressEventData_Title = (BigWordProgressData)obj;
		_onRefreshBigWorldProgressTitleEventHandler?.Invoke();
	}

	private void OnBigWordChangeTimer(BaseEventContent obj)
	{
		_bigWordTimeDateEventData = (BigWordTimeDate)obj;
		if (isInBigWorld)
		{
			_onBigWordChangeTimerEventHandler?.Invoke();
		}
	}
}
