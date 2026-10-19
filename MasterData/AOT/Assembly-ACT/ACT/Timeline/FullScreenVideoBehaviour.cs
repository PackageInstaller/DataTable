using System;
using ACT.Drama;
using ACT.Event;
using ACT.UI;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.Playables;
using YooAsset;

namespace ACT.Timeline;

[Serializable]
public class FullScreenVideoBehaviour : PlayableBehaviour
{
	public string address;

	public double startTime;

	public bool showSkipButton;

	public bool keepBgm;

	private FullScreenVideoView _view;

	private bool _played;

	private bool _playRequested;

	private bool _isBehaviourPlaying;

	private bool _initialized;

	private RawFileHandle _rawFileHandle;

	private PlayableDirector _director;

	private PlayableDirector _loadingPausedDirector;

	private const string CGSnap = "snapshot:/CGMuteScene";

	public override void OnGraphStart(Playable playable)
	{
		if (!Application.isPlaying || _initialized)
		{
			return;
		}
		_initialized = true;
		_played = false;
		_playRequested = false;
		_isBehaviourPlaying = false;
		_view = null;
		_director = null;
		_loadingPausedDirector = null;
		if (!string.IsNullOrEmpty(address))
		{
			ResourcePackage resourcePackage = YooAssets.TryGetPackage("RawFile");
			bool flag = GameUtility.TryLoadRawFilePath(address, out _rawFileHandle, out var _);
			if (_rawFileHandle == null)
			{
				Debug.LogError("[FullScreenVideo] RawFile load returned no handle. " + $"address={address}, loaded={flag}, " + $"packageStatus={resourcePackage?.InitializeStatus}, packageValid={resourcePackage?.PackageValid}");
			}
			else if (!flag || _rawFileHandle.Status != EOperationStatus.Succeed)
			{
				AssetInfo assetInfo = _rawFileHandle.GetAssetInfo();
				Debug.LogError("[FullScreenVideo] RawFile load failed. " + $"address={address}, loaded={flag}, status={_rawFileHandle.Status}, " + "error=" + _rawFileHandle.LastError + ", assetPath=" + assetInfo.AssetPath + ", " + $"packageName={assetInfo.PackageName}, packageStatus={resourcePackage?.InitializeStatus}, " + $"packageValid={resourcePackage?.PackageValid}");
			}
		}
	}

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		if (!Application.isPlaying)
		{
			return;
		}
		_isBehaviourPlaying = true;
		if (_played || _playRequested)
		{
			return;
		}
		PlayableDirector playableDirector = (_director = playable.GetGraph().GetResolver() as PlayableDirector);
		if (!TryGetVideoFilePath(out var filePath))
		{
			SkipTimelineAfterVideoFailed();
			return;
		}
		FullScreenVideoView.PlayVideoArgument arg = new FullScreenVideoView.PlayVideoArgument
		{
			showSkipButton = showSkipButton,
			skipTimelineAction = TrySkipTimeline,
			pauseTimelineAction = ((playableDirector != null) ? new Action(playableDirector.Pause) : null),
			resumeTimelineAction = ((playableDirector != null) ? new Action(playableDirector.Play) : null),
			videoStartedAction = ResumeTimelineAfterVideoStarted,
			videoFailedAction = SkipTimelineAfterVideoFailed,
			videoPlaybackFailedAction = SkipTimelineAfterVideoFailed
		};
		if (playableDirector != null && playableDirector.state == UnityEngine.Playables.PlayState.Playing)
		{
			_loadingPausedDirector = playableDirector;
			playableDirector.Pause();
		}
		_playRequested = true;
		PlayWhenViewReady(filePath, arg).Forget();
	}

	public override void OnPlayableDestroy(Playable playable)
	{
		if (Application.isPlaying)
		{
			_initialized = false;
			_isBehaviourPlaying = false;
			_director = null;
			_loadingPausedDirector = null;
			if (_view != null && _view.IsPlaying)
			{
				_view.StopVideo();
			}
			else if (_view != null && _view.ActiveInShowRoot)
			{
				_view.Close();
			}
			if (_played && !keepBgm)
			{
				GameStateChange evt = Singleton<EventManager>.instance.GetEvt<GameStateChange>();
				evt.IsInState = false;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.OnCGStateChange, evt);
				Singleton<EventManager>.instance.ReleaseEvt(evt);
			}
			ReleaseRawFileHandle();
		}
	}

	private bool TryGetVideoFilePath(out string filePath)
	{
		filePath = string.Empty;
		try
		{
			if (_rawFileHandle != null && _rawFileHandle.IsValid && _rawFileHandle.IsDone && _rawFileHandle.Status == EOperationStatus.Succeed)
			{
				filePath = _rawFileHandle.GetRawFilePath();
				if (!string.IsNullOrEmpty(filePath))
				{
					return true;
				}
			}
		}
		catch (Exception arg)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"[FullScreenVideo] 读取视频路径异常，跳过视频。address={address}, error={arg}");
			}
			return false;
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.LogError("[FullScreenVideo] 视频文件未成功加载或路径为空，跳过视频。address=" + address);
		}
		return false;
	}

	private void ReleaseRawFileHandle()
	{
		if (Application.isPlaying && _rawFileHandle != null)
		{
			_rawFileHandle.Release();
			_rawFileHandle = null;
		}
	}

	private async UniTaskVoid PlayWhenViewReady(string filePath, FullScreenVideoView.PlayVideoArgument arg)
	{
		if (string.IsNullOrEmpty(filePath))
		{
			SkipTimelineAfterVideoFailed();
			return;
		}
		NewUIManager manager = Singleton<NewUIManager>.instance;
		if (manager == null)
		{
			SkipTimelineAfterVideoFailed();
			return;
		}
		UIOpenResult openUIResult = manager.OpenUI(UI_TYPE.UI_FULLSCREENVIDEO, new FullScreenVideoViewData());
		if (!openUIResult.IsValid)
		{
			SkipTimelineAfterVideoFailed();
			return;
		}
		await manager.WaitUIOpenAsync(openUIResult);
		_view = manager.FindUIViewByUIType(UI_TYPE.UI_FULLSCREENVIDEO) as FullScreenVideoView;
		if (_played)
		{
			_playRequested = false;
			return;
		}
		if (!_isBehaviourPlaying)
		{
			ResumeTimelineIfNeeded();
			_playRequested = false;
			if (_view != null)
			{
				_view.Close();
			}
			return;
		}
		if (_view == null)
		{
			SkipTimelineAfterVideoFailed();
			return;
		}
		_played = true;
		_playRequested = false;
		PlayableDirector director = _director;
		_view.PlayVideoFromUrl(filePath, startTime, null, arg);
		if (_isBehaviourPlaying && _played && !(_director != director) && _view.IsPlaying && !keepBgm)
		{
			GameStateChange evt = Singleton<EventManager>.instance.GetEvt<GameStateChange>();
			evt.IsInState = true;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.OnCGStateChange, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}

	private bool TrySkipTimeline()
	{
		PlayableDirector director = _director;
		if (director == null || !_isBehaviourPlaying || !_played)
		{
			return false;
		}
		if (Singleton<ConversationManager>.instance.PlayingDialogue is TimelineDialogue timelineDialogue && timelineDialogue.PlayableDirector == director)
		{
			double time = director.time;
			((IDialogueWrapper)timelineDialogue).Skip();
			if (director == null || !director.playableGraph.IsValid())
			{
				return true;
			}
			if (director.time == time)
			{
				return false;
			}
			if (director.time >= director.duration)
			{
				director.Stop();
			}
			return true;
		}
		director.Stop();
		return true;
	}

	private void SkipTimelineAfterVideoFailed()
	{
		if (_isBehaviourPlaying && !(_director == null))
		{
			_loadingPausedDirector = null;
			_playRequested = false;
			_director.Stop();
		}
	}

	private void ResumeTimelineAfterVideoStarted()
	{
		if (_isBehaviourPlaying && _played)
		{
			ResumeTimelineIfNeeded();
		}
	}

	private void ResumeTimelineIfNeeded()
	{
		if (!(_loadingPausedDirector == null))
		{
			PlayableDirector loadingPausedDirector = _loadingPausedDirector;
			_loadingPausedDirector = null;
			loadingPausedDirector.Play();
		}
	}
}
