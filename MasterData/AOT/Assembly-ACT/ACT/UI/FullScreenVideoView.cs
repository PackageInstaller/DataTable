using System;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Drama.Video;
using ACT.Sound;
using ACT.Utility;
using Bamboo.AssetField;
using Cysharp.Threading.Tasks;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.Localization.Components;
using UnityEngine.UI;
using UnityEngine.Video;
using YooAsset;

namespace ACT.UI;

public class FullScreenVideoView : BaseUIView<FullScreenVideoViewInputController>
{
	public struct PlayVideoArgument
	{
		public bool showSkipButton;

		public Func<bool> skipTimelineAction;

		public Action pauseTimelineAction;

		public Action resumeTimelineAction;

		public Action videoStartedAction;

		public Action videoFailedAction;

		public Action videoPlaybackFailedAction;
	}

	[SerializeField]
	private RawImage rawImage;

	[SerializeField]
	private ActButton btnSkip;

	[SerializeField]
	private Image mask;

	[Header("字幕")]
	[SerializeField]
	private TextMeshProUGUI subtitleText;

	[SerializeField]
	private LocalizeStringEvent subtitleLocalize;

	public GameObject hangObject;

	private RenderTexture videoRt;

	private AssetLoadHandle videoConfigHandle;

	private RawFileHandle videoRawFileHandle;

	private VideoPlayer playbackEventSource;

	private PlayVideoArgument arg;

	private Action videoCompleteAction;

	private uint eventInstance;

	private int playVersion;

	private bool isPlaying;

	private bool isUserPaused;

	private bool isApplicationPaused;

	private bool videoInputPaused;

	private bool skipPanelOpened;

	private bool waitingForFirstFrame;

	private bool sendFrameReadyEventsBeforePlayback;

	private bool videoFrameVisible;

	private bool subtitleVisibleRequested;

	public ActButton SkipButton => btnSkip;

	private VideoPlayer VideoPlayer => GameUtility.mainVideoPlayer;

	public bool IsPlaying => isPlaying;

	public override UniTask PreInit()
	{
		ShowBlackScreen();
		if (btnSkip != null)
		{
			btnSkip.OnClick = new UnityEvent();
			btnSkip.OnClick.AddListener(RequestSkipVideo);
		}
		return base.PreInit();
	}

	protected override void Init()
	{
		base.Init();
		ShowBlackScreen();
		ClearSubtitle();
	}

	protected override void UnInit()
	{
		if (isPlaying)
		{
			StopVideoInternal(closeView: false);
		}
		else
		{
			ReleaseAll(clearPlayer: false);
		}
		base.UnInit();
	}

	public void PlayVideo(int longVideoId, Action complete = null, PlayVideoArgument playArgument = default(PlayVideoArgument))
	{
		StopCurrentVideo();
		ShowBlackScreen();
		arg = playArgument;
		videoCompleteAction = complete;
		int version = ++playVersion;
		isPlaying = true;
		isUserPaused = false;
		isApplicationPaused = false;
		PauseVideoInput();
		VideoData data = CoreUtils.GetData(longVideoId, RuntimeConfigs.data.videoDatas);
		if (data == null)
		{
			SkipFailedVideo();
			return;
		}
		videoConfigHandle = AssetStationManager.Root.LoadAsync<VideoContentConfig>(data.configPath, (AssetLoadHandle result) =>
		{
			if (version == playVersion && isPlaying)
			{
				VideoContentConfig videoContentConfig = result.As<VideoContentConfig>();
				if (!TryResolveVideoUrl(videoContentConfig, out var url))
				{
					SkipFailedVideo();
				}
				else
				{
					PrepareVideoFromUrl(version, url, 0.0).Forget();
					if (version == playVersion && isPlaying && !videoContentConfig.audioSoundEvent.IsNull())
					{
						eventInstance = Singleton<GameManager>.instance.audioManager.PlaySound(videoContentConfig.audioSoundEvent, new AudioPlayOptions
						{
							attachTarget = ((Camera.main != null) ? Camera.main.transform : null)
						});
					}
				}
			}
		});
	}

	private bool TryResolveVideoUrl(VideoContentConfig config, out string url)
	{
		url = string.Empty;
		if (config == null)
		{
			return false;
		}
		if (!string.IsNullOrEmpty(config.videoPath))
		{
			return GameUtility.TryLoadRawFilePath(config.videoPath, out videoRawFileHandle, out url);
		}
		return false;
	}

	public void PlayVideoFromUrl(string url, double startTimeSeconds = 0.0, Action complete = null, PlayVideoArgument playArgument = default(PlayVideoArgument))
	{
		StopCurrentVideo();
		ShowBlackScreen();
		arg = playArgument;
		videoCompleteAction = complete;
		int version = ++playVersion;
		isPlaying = true;
		isUserPaused = false;
		isApplicationPaused = false;
		PauseVideoInput();
		if (string.IsNullOrEmpty(url))
		{
			SkipFailedVideo();
		}
		else
		{
			PrepareVideoFromUrl(version, url, startTimeSeconds).Forget();
		}
	}

	private async UniTaskVoid PrepareVideoFromUrl(int version, string url, double startTimeSeconds)
	{
		await UniTask.WaitUntil(() => VideoPlayer != null);
		if (version != playVersion || !isPlaying)
		{
			return;
		}
		GameUtility.PrepareVideoFromUrl(VideoPlayer, url, (VideoPlayer source, RenderTexture rt) =>
		{
			if (version != playVersion || !isPlaying)
			{
				rt.Release();
				UnityEngine.Object.Destroy(rt);
			}
			else
			{
				videoRt = rt;
				if (rawImage != null)
				{
					rawImage.texture = rt;
				}
				double num = Math.Max(0.0, Math.Min(startTimeSeconds, source.length));
				if (source.length > 0.0 && num >= source.length)
				{
					SkipFailedVideo();
				}
				else
				{
					source.time = num;
					RegisterPlaybackEvents(source);
					WaitForFirstVideoFrame();
					source.Play();
				}
			}
		}, (string _) =>
		{
			if (version == playVersion && isPlaying)
			{
				SkipFailedVideo();
			}
		});
	}

	private void StopCurrentVideo()
	{
		if (isPlaying)
		{
			StopVideoInternal(closeView: false);
		}
	}

	private void RegisterPlaybackEvents(VideoPlayer source)
	{
		UnregisterPlaybackEvents();
		playbackEventSource = source;
		source.isLooping = false;
		source.loopPointReached += OnVideoCompleted;
		source.errorReceived += OnVideoPlaybackError;
	}

	private bool IsCurrentPlayback(VideoPlayer source)
	{
		if (isPlaying && source == playbackEventSource && videoRt != null)
		{
			return source.targetTexture == videoRt;
		}
		return false;
	}

	private void OnVideoCompleted(VideoPlayer source)
	{
		if (IsCurrentPlayback(source))
		{
			if (waitingForFirstFrame)
			{
				SkipFailedVideo();
			}
			else
			{
				StopVideo();
			}
		}
	}

	private void OnVideoPlaybackError(VideoPlayer source, string message)
	{
		if (IsCurrentPlayback(source))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"[FullScreenVideo] 视频播放失败，url:{source.url}, time:{source.time}, frame:{source.frame}, error:{message}");
			}
			SkipFailedVideo();
		}
	}

	private void SkipFailedVideo()
	{
		if (!isPlaying)
		{
			return;
		}
		int num = playVersion;
		Action action = (videoFrameVisible ? arg.videoPlaybackFailedAction : arg.videoFailedAction);
		ShowBlackScreen();
		try
		{
			action?.Invoke();
		}
		finally
		{
			if (num == playVersion && isPlaying)
			{
				StopVideo();
			}
		}
	}

	private void UnregisterPlaybackEvents()
	{
		if (!(playbackEventSource == null))
		{
			playbackEventSource.loopPointReached -= OnVideoCompleted;
			playbackEventSource.errorReceived -= OnVideoPlaybackError;
			playbackEventSource = null;
		}
	}

	private void ShowBlackScreen()
	{
		if (mask != null)
		{
			mask.gameObject.SetActive(value: true);
		}
		videoFrameVisible = false;
		btnSkip?.gameObject.SetActive(value: false);
		if (subtitleText != null)
		{
			subtitleText.gameObject.SetActive(value: false);
		}
	}

	private void WaitForFirstVideoFrame()
	{
		StopWaitingForFirstVideoFrame();
		VideoPlayer videoPlayer = VideoPlayer;
		if (!(videoPlayer == null))
		{
			sendFrameReadyEventsBeforePlayback = videoPlayer.sendFrameReadyEvents;
			videoPlayer.sendFrameReadyEvents = true;
			videoPlayer.frameReady += OnFirstVideoFrameReady;
			waitingForFirstFrame = true;
		}
	}

	private void OnFirstVideoFrameReady(VideoPlayer source, long frameIndex)
	{
		if (waitingForFirstFrame && isPlaying && !(source != VideoPlayer) && !(videoRt == null) && !(source.targetTexture != videoRt))
		{
			if (rawImage != null)
			{
				rawImage.texture = videoRt;
			}
			videoFrameVisible = true;
			btnSkip?.gameObject.SetActive(arg.showSkipButton);
			if (subtitleText != null)
			{
				subtitleText.gameObject.SetActive(subtitleVisibleRequested);
			}
			if (mask != null)
			{
				mask.gameObject.SetActive(value: false);
			}
			StopWaitingForFirstVideoFrame();
			arg.videoStartedAction?.Invoke();
		}
	}

	private void StopWaitingForFirstVideoFrame()
	{
		if (waitingForFirstFrame)
		{
			VideoPlayer videoPlayer = VideoPlayer;
			if (videoPlayer != null)
			{
				videoPlayer.frameReady -= OnFirstVideoFrameReady;
				videoPlayer.sendFrameReadyEvents = sendFrameReadyEventsBeforePlayback;
			}
			waitingForFirstFrame = false;
		}
	}

	public void RequestSkipVideo()
	{
		if (isPlaying && arg.showSkipButton && !skipPanelOpened)
		{
			skipPanelOpened = true;
			isUserPaused = true;
			arg.pauseTimelineAction?.Invoke();
			if (eventInstance != 0)
			{
				Singleton<GameManager>.instance.audioManager.SetPause(eventInstance, pause: true);
			}
			VideoPlayer.Pause();
			if (!Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEXTPANEL, new TextPanel.Param
			{
				texts = new string[1] { "是否跳过" },
				OnConfirm = SkipVideo,
				OnCancel = ResumeVideo,
				onlyClickOnce = true
			}).IsValid)
			{
				ResumeVideo();
			}
		}
	}

	public void SkipVideo()
	{
		if (!isPlaying)
		{
			return;
		}
		Func<bool> skipTimelineAction = arg.skipTimelineAction;
		if (skipTimelineAction != null)
		{
			int num = playVersion;
			bool flag = false;
			try
			{
				flag = skipTimelineAction();
				return;
			}
			finally
			{
				if (num == playVersion && isPlaying)
				{
					if (flag)
					{
						StopVideo();
					}
					else
					{
						ResumeVideo();
					}
				}
			}
		}
		StopVideo();
	}

	public void PauseVideo()
	{
		RequestSkipVideo();
	}

	public void StopVideo()
	{
		StopVideoInternal(closeView: true);
	}

	private void StopVideoInternal(bool closeView)
	{
		if (!isPlaying)
		{
			return;
		}
		if (eventInstance != 0)
		{
			Singleton<GameManager>.instance.audioManager.Stop(eventInstance);
			eventInstance = 0u;
		}
		Action action = videoCompleteAction;
		isPlaying = false;
		isUserPaused = false;
		isApplicationPaused = false;
		skipPanelOpened = false;
		CloseSkipPanel();
		ReleaseAll();
		ResumeVideoInput();
		if (closeView)
		{
			UIState state = UIController.State;
			if (state == UIState.Opening || state == UIState.Opened)
			{
				Close();
			}
		}
		action?.Invoke();
	}

	public void ResumeVideo()
	{
		skipPanelOpened = false;
		if (isPlaying)
		{
			isUserPaused = false;
			arg.resumeTimelineAction?.Invoke();
			if (eventInstance != 0)
			{
				Singleton<GameManager>.instance.audioManager.SetPause(eventInstance, pause: false);
			}
			VideoPlayer.Play();
		}
	}

	public void ConfirmSkipVideo()
	{
		SkipVideo();
	}

	public void CancelPauseVideo()
	{
		ResumeVideo();
	}

	public void CancelSkipVideo()
	{
		ResumeVideo();
	}

	public void ComfirmPauseVideo()
	{
		ConfirmSkipVideo();
	}

	private void PauseVideoInput()
	{
		if (!videoInputPaused && !(MonoECS.instance == null))
		{
			if (arg.showSkipButton)
			{
				MonoECS.instance.PushPauseInput();
			}
			else
			{
				MonoECS.instance.PushPauseAllInput();
			}
			videoInputPaused = true;
		}
	}

	private void ResumeVideoInput()
	{
		if (videoInputPaused && !(MonoECS.instance == null))
		{
			if (arg.showSkipButton)
			{
				MonoECS.instance.PopPauseInput();
			}
			else
			{
				MonoECS.instance.PopPauseAllInput();
			}
			videoInputPaused = false;
		}
	}

	private void OnApplicationPause(bool pauseStatus)
	{
		if (isPlaying)
		{
			isApplicationPaused = pauseStatus;
			if (!pauseStatus)
			{
				ResumeAfterApplicationPause();
			}
		}
	}

	private void OnApplicationFocus(bool hasFocus)
	{
		if (hasFocus && !isApplicationPaused)
		{
			ResumeAfterApplicationPause();
		}
	}

	private void ResumeAfterApplicationPause()
	{
		if (isPlaying && !isUserPaused && VideoPlayer != null && videoRt != null && VideoPlayer.targetTexture == videoRt && !VideoPlayer.isPlaying)
		{
			VideoPlayer.Play();
		}
	}

	private void ReleaseVideoRt()
	{
		if (!(videoRt == null))
		{
			if (VideoPlayer != null && VideoPlayer.targetTexture == videoRt)
			{
				VideoPlayer.targetTexture = null;
				VideoPlayer.Stop();
			}
			videoRt.Release();
			UnityEngine.Object.Destroy(videoRt);
			videoRt = null;
			if (rawImage != null)
			{
				rawImage.texture = null;
			}
		}
	}

	private void ReleaseConfig()
	{
		if (AssetLoadHandleExtensions.IsValid(videoConfigHandle))
		{
			AssetStationManager.Root.Release(videoConfigHandle);
			videoConfigHandle = default;
		}
	}

	private void ReleaseRawFile()
	{
		if (videoRawFileHandle != null)
		{
			videoRawFileHandle.Release();
			videoRawFileHandle = null;
		}
	}

	private void ReleaseAll(bool clearPlayer = true)
	{
		playVersion++;
		UnregisterPlaybackEvents();
		StopWaitingForFirstVideoFrame();
		ReleaseConfig();
		ReleaseRawFile();
		ReleaseVideoRt();
		if (clearPlayer && VideoPlayer != null)
		{
			VideoPlayer.url = string.Empty;
			VideoPlayer.source = VideoSource.Url;
			VideoPlayer.clip = null;
		}
		videoCompleteAction = null;
		ShowBlackScreen();
	}

	private void CloseSkipPanel()
	{
		(Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_TEXTPANEL) as TextPanel)?.Close();
	}

	public void SetSubtitle(int contentId)
	{
		if (!(subtitleText == null))
		{
			if (subtitleLocalize != null)
			{
				subtitleLocalize.StringReference.TableEntryReference = contentId;
			}
			ShowSubtitle(visible: true);
		}
	}

	public void SetSubtitleText(string text)
	{
		if (!(subtitleText == null))
		{
			subtitleText.text = text ?? string.Empty;
			ShowSubtitle(visible: true);
		}
	}

	public void ShowSubtitle(bool visible)
	{
		subtitleVisibleRequested = visible;
		if (subtitleText != null)
		{
			subtitleText.gameObject.SetActive(visible && videoFrameVisible);
		}
	}

	public void SetSubtitleAlpha(float alpha)
	{
		if (!(subtitleText == null))
		{
			Color color = subtitleText.color;
			subtitleText.color = new Color(color.r, color.g, color.b, alpha);
		}
	}

	public void ClearSubtitle()
	{
		if (!(subtitleText == null))
		{
			subtitleText.text = string.Empty;
			ShowSubtitle(visible: false);
		}
	}
}
