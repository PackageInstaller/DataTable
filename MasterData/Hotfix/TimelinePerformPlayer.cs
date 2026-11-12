using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

public class TimelinePerformPlayer
{
	private readonly string SIGNALTRACK_NAME = "PerformSignalTrack";

	private readonly float LOADINGVIEW_OPENANIMATION_TIME = 0.76f;

	public const string AVG_START = "StoryDialog_DialogStart";

	public const string AVG_END = "StoryDialog_DialogEnd";

	private PlayableDirector _director;

	private TimelinePerformConfig _performConfig;

	private Action<bool> _onFinish;

	private List<TimelinePerformMarker> _performMarkerList;

	private double _remainingTime;

	private bool _playEndBlackBlock;

	public double RemainingTime => _remainingTime;

	public bool IsPlaying
	{
		get
		{
			if (_director != null)
			{
				return _director.state == PlayState.Playing;
			}
			return false;
		}
	}

	public bool InPerform { get; private set; }

	public void Play(PlayableDirector director, TimelinePerformConfig performConfig, Action<bool> onFinish)
	{
		_director = director;
		_performConfig = performConfig;
		_onFinish = onFinish;
		InitSignalInfo();
		_playEndBlackBlock = false;
		if (_performConfig.isSuspendPlayer)
		{
			SceneSingleton<AdventurePlayerController>.Instance.InputDisable();
			SceneSingleton<AdventureHUDController>.Instance.HideAllHUD();
		}
		InPerform = true;
		if (_performConfig.isUseEnterBlackBlock)
		{
			MonoSingleton<ClientManager>.Instance.OpenLoadingView(OnEnterLoadingViewOpenFinish);
		}
		else
		{
			Play();
		}
	}

	private void InitSignalInfo()
	{
		if (_performMarkerList == null)
		{
			_performMarkerList = new List<TimelinePerformMarker>(10);
		}
		else
		{
			_performMarkerList.Clear();
		}
		foreach (PlayableBinding output in _director.playableAsset.outputs)
		{
			if (!string.Equals(output.streamName, SIGNALTRACK_NAME))
			{
				continue;
			}
			{
				foreach (IMarker marker in (output.sourceObject as SignalTrack).GetMarkers())
				{
					if (marker is TimelinePerformMarker item)
					{
						_performMarkerList.Add(item);
					}
				}
				break;
			}
		}
	}

	private void OnEnterLoadingViewOpenFinish()
	{
		MonoSingleton<ClientManager>.Instance.CloseLoadingView(null);
		Play();
	}

	private void Play()
	{
		AdventureTimelinePlayer.BindCameraBrain(_director, _performConfig.isUseMainCamera ? MonoSingleton<GameCameraStackManager>.Instance.mainCameraBrain : null);
		if (_performConfig.isUseCloseUpCamera)
		{
			AdventurePlayerController instance = SceneSingleton<AdventurePlayerController>.Instance;
			bool isUseMainCamera = _performConfig.isUseMainCamera;
			instance.EnableCloseupCamera(0f, null, isUseMainCamera);
			if (_director.gameObject.layer != 26)
			{
				_director.transform.SetLayerRecursively(26);
			}
		}
		if (_performConfig.isCinemaMode)
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("OpenCinema");
		}
		if (_performConfig.isEnableJump)
		{
			MonoSingleton<LuaManager>.Instance?.FireEvent("ShowJumpTimeline");
		}
		if (_performConfig.isPauseLogic)
		{
			ModuleController<AdventureModuleController>.Instance.PauseLogic();
			ModuleController<AdventureModuleController>.Instance.levelInstance.SetSceneObjectsIndependentUpdate(value: true);
		}
		_director.timeUpdateMode = DirectorUpdateMode.UnscaledGameTime;
		_director.extrapolationMode = DirectorWrapMode.Hold;
		_director.stopped += OnTimelineStop;
		if (!_director.gameObject.activeSelf)
		{
			_director.gameObject.SetActive(value: true);
		}
		_remainingTime = _director.duration;
		_director.Play();
	}

	public void Stop()
	{
		_director?.Stop();
	}

	public void Pause()
	{
		_director?.Pause();
	}

	public void Resume()
	{
		_director?.Resume();
	}

	public void Update()
	{
		if (_director.state == PlayState.Playing)
		{
			TriggerSignal();
			_remainingTime = _director.duration - _director.time;
			if (_performConfig.isUseExitBlackBlock && !_playEndBlackBlock && _remainingTime <= (double)LOADINGVIEW_OPENANIMATION_TIME)
			{
				MonoSingleton<ClientManager>.Instance.OpenLoadingView(null);
				_playEndBlackBlock = true;
			}
			if (_remainingTime <= 0.0)
			{
				_director.Stop();
			}
		}
	}

	private void TriggerSignal()
	{
		if (_performMarkerList.Count <= 0)
		{
			return;
		}
		for (int i = 0; i < _performMarkerList.Count; i++)
		{
			TimelinePerformMarker timelinePerformMarker = _performMarkerList.get_Item(i);
			if (!timelinePerformMarker.HasTriggered && _director.time >= timelinePerformMarker.time)
			{
				timelinePerformMarker.Trigger();
				break;
			}
		}
	}

	private void OnTimelineStop(PlayableDirector director)
	{
		_remainingTime = 0.0;
		if (_performConfig.isPauseLogic)
		{
			ModuleController<AdventureModuleController>.Instance.ResumeLogic();
			ModuleController<AdventureModuleController>.Instance.levelInstance.SetSceneObjectsIndependentUpdate(value: false);
		}
		if (_performConfig.isUseCloseUpCamera)
		{
			SceneSingleton<AdventurePlayerController>.Instance.DisableCloseupCamera(0f);
		}
		if (_performConfig.isCinemaMode)
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("CloseCinema");
		}
		if (_performConfig.isEnableJump)
		{
			MonoSingleton<LuaManager>.Instance?.FireEvent("HideJumpTimeline");
		}
		_performMarkerList?.Clear();
		switch (_performConfig.subsequentActionType)
		{
		case TimelinePerformConfig.SubsequentActionType.PlayAVG:
			PlayAvg();
			MonoSingleton<ClientManager>.Instance.CloseLoadingView(null);
			return;
		case TimelinePerformConfig.SubsequentActionType.PlayOnceTimeline:
			PlayOnceTimeline();
			MonoSingleton<ClientManager>.Instance.CloseLoadingView(null);
			return;
		}
		if (_performConfig.isUseExitBlackBlock && _performConfig.isCloseBlackBlockOnFinish)
		{
			MonoSingleton<ClientManager>.Instance.CloseLoadingView(null);
		}
		Finish();
	}

	private void PlayAvg()
	{
		if (string.IsNullOrEmpty(_performConfig.subsequentAvgId))
		{
			Finish();
			return;
		}
		Singleton<EventDispatchManager>.Instance.AddEventListener("StoryDialog_DialogEnd", OnAvgEnd);
		MonoSingleton<LuaManager>.Instance.FireEvent("StoryDialog_DialogStart", _performConfig.subsequentAvgId);
	}

	private void OnAvgEnd(IEvent evt)
	{
		Singleton<EventDispatchManager>.Instance.RemoveEventListener("StoryDialog_DialogEnd", OnAvgEnd);
		Finish();
	}

	private void PlayOnceTimeline()
	{
		PlayableDirector playableDirector = null;
		switch (_performConfig.subsequentPlayableType)
		{
		case TimelinePerformConfig.PlayableType.Instance:
			playableDirector = _performConfig.subsequentDirector;
			break;
		case TimelinePerformConfig.PlayableType.Path:
			if (!string.IsNullOrEmpty(_performConfig.subsequentDirectorPath))
			{
				playableDirector = GameObject.Find(_performConfig.subsequentDirectorPath)?.GetComponent<PlayableDirector>();
			}
			break;
		}
		playableDirector?.Play();
		Finish();
	}

	private void Finish()
	{
		InPerform = false;
		if (_performConfig.isSuspendPlayer)
		{
			SceneSingleton<AdventurePlayerController>.Instance.InputEnable();
			SceneSingleton<AdventureHUDController>.Instance.ShowAllHUD();
		}
		if (_performConfig.finishDelete)
		{
			_director.gameObject.SetActive(value: false);
		}
		_onFinish?.Invoke(obj: true);
		_onFinish = null;
	}

	public void Clear()
	{
		_director = null;
		_performConfig = null;
		_performMarkerList?.Clear();
		_remainingTime = 0.0;
		_onFinish = null;
	}
}
