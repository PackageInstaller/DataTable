using System;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Drama.Video;
using ACT.Sound;
using ACT.Utility;
using Bamboo.AssetField;
using Bamboo.Chronos;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization.Components;
using UnityEngine.UI;
using UnityEngine.Video;
using YooAsset;

namespace ACT.UI;

public class FullScreenVideo : UIBehaviour
{
	public struct PlayVideoArgument
	{
		public bool showSkipButton;

		public Action skipTimelineAction;

		public Action pauseTimelineAction;

		public Action resumeTimelineAction;
	}

	[SerializeReference]
	private RawImage rawImage;

	[SerializeField]
	private Button btnSkip;

	[SerializeField]
	private GameObject pausePopup;

	[SerializeField]
	private ActButton btnResumeVideo;

	[SerializeField]
	private ActButton btnCloseSkipPopup;

	[SerializeField]
	private ActButton btnConfirmSkipVideo;

	public GameObject hangObject;

	private RenderTexture _videoRt;

	private AssetLoadHandle _videoConfigHandle;

	private RawFileHandle _videoRawFileHandle;

	private Delayer _videoCompleteDelayer;

	private PlayVideoArgument _arg;

	private bool _isPlaying;

	private uint _eventInstance;

	private Action _videoCompleteAction;

	private int _playVersion;

	private bool _isUserPaused;

	private bool _isApplicationPaused;

	private bool _videoInputPaused;

	[Header("字幕")]
	[SerializeField]
	private TextMeshProUGUI _subtitleText;

	[SerializeField]
	private LocalizeStringEvent _subtitleLocalize;

	private VideoPlayer _videoPlayer => GameUtility.mainVideoPlayer;

	public bool IsPlaying => _isPlaying;

	protected override void Awake()
	{
		base.Awake();
		btnSkip?.onClick.AddListener(RequestSkipVideo);
		btnResumeVideo?.SetBtnClick(ResumeVideo);
		btnCloseSkipPopup?.SetBtnClick(ResumeVideo);
		btnConfirmSkipVideo?.SetBtnClick(SkipVideo);
	}

	public void PlayVideo(int longVideoId, Action videoCompleteAction = null, PlayVideoArgument arg = default(PlayVideoArgument))
	{
		VideoData data = CoreUtils.GetData(longVideoId, RuntimeConfigs.data.videoDatas);
		if (data == null)
		{
			return;
		}
		if (_isPlaying)
		{
			ResumeVideoInput();
			ReleaseAll();
			_isPlaying = false;
		}
		_arg = arg;
		int playVersion = ++_playVersion;
		_isPlaying = true;
		_isUserPaused = false;
		_isApplicationPaused = false;
		PauseVideoInput();
		_videoCompleteAction = videoCompleteAction;
		btnSkip?.gameObject.SetActive(_arg.showSkipButton);
		HideSkipConfirmPopup();
		_videoConfigHandle = AssetStationManager.Root.LoadAsync<VideoContentConfig>(data.configPath, (AssetLoadHandle result) =>
		{
			if (playVersion == _playVersion && _isPlaying)
			{
				VideoContentConfig videoContentConfig = result.As<VideoContentConfig>();
				if (!TryResolveVideoUrl(videoContentConfig, out var url))
				{
					StopVideo();
				}
				else
				{
					PrepareVideoFromUrl(playVersion, url, 0.0);
					if (!videoContentConfig.audioSoundEvent.IsNull())
					{
						_eventInstance = Singleton<GameManager>.instance.audioManager.PlaySound(videoContentConfig.audioSoundEvent, new AudioPlayOptions
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
			return GameUtility.TryLoadRawFilePath(config.videoPath, out _videoRawFileHandle, out url);
		}
		return false;
	}

	public void PlayVideoFromUrl(string url, double startTimeSeconds = 0.0, Action videoCompleteAction = null, PlayVideoArgument arg = default(PlayVideoArgument))
	{
		if (!string.IsNullOrEmpty(url))
		{
			if (_isPlaying)
			{
				ResumeVideoInput();
				ReleaseAll();
				_isPlaying = false;
			}
			_arg = arg;
			int playVersion = ++_playVersion;
			_isPlaying = true;
			_isUserPaused = false;
			_isApplicationPaused = false;
			PauseVideoInput();
			_videoCompleteAction = videoCompleteAction;
			btnSkip?.gameObject.SetActive(_arg.showSkipButton);
			HideSkipConfirmPopup();
			PrepareVideoFromUrl(playVersion, url, startTimeSeconds);
		}
	}

	private void PrepareVideoFromUrl(int playVersion, string url, double startTimeSeconds)
	{
		GameUtility.PrepareVideoFromUrl(_videoPlayer, url, (VideoPlayer source, RenderTexture videoRt) =>
		{
			if (playVersion != _playVersion || !_isPlaying)
			{
				if (source.targetTexture == videoRt)
				{
					source.targetTexture = null;
					source.Stop();
				}
				videoRt.Release();
				UnityEngine.Object.Destroy(videoRt);
			}
			else
			{
				_videoRt = videoRt;
				rawImage.texture = _videoRt;
				float num = Mathf.Clamp((float)startTimeSeconds, 0f, (float)source.length);
				source.time = num;
				source.Play();
				gameObject.SetActive(value: true);
				int delayMs = (int)Mathf.Max(0f, (float)((source.length - (double)num) * 1000.0));
				_videoCompleteDelayer = UpdateTimer.Default.DelayMs(delayMs, OnComplete);
			}
		}, (string _) =>
		{
			if (playVersion == _playVersion && _isPlaying)
			{
				StopVideo();
			}
		});
	}

	public void RequestSkipVideo()
	{
		if (_isPlaying && _arg.showSkipButton)
		{
			_isUserPaused = true;
			_videoCompleteDelayer.Pause();
			_arg.pauseTimelineAction?.Invoke();
			if (_eventInstance != 0)
			{
				Singleton<GameManager>.instance.audioManager.SetPause(_eventInstance, pause: true);
			}
			_videoPlayer.Pause();
			if (pausePopup != null && !pausePopup.activeSelf)
			{
				pausePopup.SetActive(value: true);
				pausePopup.GetComponent<BetterAnimation>().GetSequence("Show").Play();
			}
		}
	}

	public void SkipVideo()
	{
		if (_isPlaying)
		{
			Action skipTimelineAction = _arg.skipTimelineAction;
			StopVideo();
			skipTimelineAction?.Invoke();
		}
	}

	public void PauseVideo()
	{
		RequestSkipVideo();
	}

	public void StopVideo()
	{
		HideSkipConfirmPopup();
		if (_eventInstance != 0)
		{
			Singleton<GameManager>.instance.audioManager.Stop(_eventInstance);
		}
		Action videoCompleteAction = _videoCompleteAction;
		_isUserPaused = false;
		_isApplicationPaused = false;
		ReleaseAll();
		gameObject.SetActive(value: false);
		ResumeVideoInput();
		_isPlaying = false;
		videoCompleteAction?.Invoke();
	}

	private void PauseVideoInput()
	{
		if (!_videoInputPaused && !(MonoECS.instance == null))
		{
			if (_arg.showSkipButton)
			{
				MonoECS.instance.PushPauseInput();
			}
			else
			{
				MonoECS.instance.PushPauseAllInput();
			}
			_videoInputPaused = true;
		}
	}

	private void ResumeVideoInput()
	{
		if (_videoInputPaused && !(MonoECS.instance == null))
		{
			if (_arg.showSkipButton)
			{
				MonoECS.instance.PopPauseInput();
			}
			else
			{
				MonoECS.instance.PopPauseAllInput();
			}
			_videoInputPaused = false;
		}
	}

	private void OnComplete()
	{
		StopVideo();
	}

	private void ReleaseVideoRt()
	{
		if (_videoRt != null)
		{
			if (_videoPlayer.targetTexture == _videoRt)
			{
				_videoPlayer.targetTexture = null;
				_videoPlayer.Stop();
			}
			_videoRt.Release();
			UnityEngine.Object.Destroy(_videoRt);
			_videoRt = null;
		}
	}

	private void ReleaseConfig()
	{
		if (AssetLoadHandleExtensions.IsValid(_videoConfigHandle))
		{
			AssetStationManager.Root.Release(_videoConfigHandle);
			_videoConfigHandle = default;
		}
	}

	private void ReleaseRawFile()
	{
		if (_videoRawFileHandle != null)
		{
			_videoRawFileHandle.Release();
			_videoRawFileHandle = null;
		}
	}

	private void ReleaseAll()
	{
		_playVersion++;
		ReleaseConfig();
		ReleaseRawFile();
		ReleaseVideoRt();
		_videoCompleteDelayer.Cancel();
		_videoPlayer.url = string.Empty;
		_videoPlayer.source = VideoSource.Url;
		_videoPlayer.clip = null;
		_videoCompleteAction = null;
		_videoCompleteDelayer = default;
	}

	public void ResumeVideo()
	{
		if (!_isPlaying)
		{
			HideSkipConfirmPopup();
			return;
		}
		_isUserPaused = false;
		_videoCompleteDelayer.Resume();
		_arg.resumeTimelineAction?.Invoke();
		if (_eventInstance != 0)
		{
			Singleton<GameManager>.instance.audioManager.SetPause(_eventInstance, pause: false);
		}
		_videoPlayer.Play();
		BetterAnimation betterAnimation = pausePopup?.GetComponent<BetterAnimation>();
		if (betterAnimation == null)
		{
			HideSkipConfirmPopup();
			return;
		}
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			pausePopup.SetActive(value: false);
		}).Play();
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

	private void HideSkipConfirmPopup()
	{
		if (pausePopup != null && pausePopup.activeSelf)
		{
			pausePopup.SetActive(value: false);
		}
	}

	private void OnApplicationPause(bool pauseStatus)
	{
		if (_isPlaying)
		{
			_isApplicationPaused = pauseStatus;
			if (pauseStatus)
			{
				_videoCompleteDelayer.Pause();
			}
			else
			{
				ResumeAfterApplicationPause();
			}
		}
	}

	private void OnApplicationFocus(bool hasFocus)
	{
		if (hasFocus && !_isApplicationPaused)
		{
			ResumeAfterApplicationPause();
		}
	}

	private void ResumeAfterApplicationPause()
	{
		if (_isPlaying && !_isUserPaused)
		{
			_videoCompleteDelayer.Resume();
			ResumeVideoPlayerIfNeeded();
		}
	}

	private void ResumeVideoPlayerIfNeeded()
	{
		VideoPlayer videoPlayer = _videoPlayer;
		if (!(videoPlayer == null) && !(_videoRt == null) && !(videoPlayer.targetTexture != _videoRt) && !videoPlayer.isPlaying)
		{
			videoPlayer.Play();
		}
	}

	public void SetSubtitle(int contentId)
	{
		if (!(_subtitleText == null))
		{
			if (_subtitleLocalize != null)
			{
				_subtitleLocalize.StringReference.TableEntryReference = contentId;
			}
			ShowSubtitle(visible: true);
		}
	}

	public void SetSubtitleText(string text)
	{
		if (!(_subtitleText == null))
		{
			_subtitleText.text = text ?? string.Empty;
			ShowSubtitle(visible: true);
		}
	}

	public void ShowSubtitle(bool visible)
	{
		if (!(_subtitleText == null))
		{
			_subtitleText.gameObject.SetActive(visible);
		}
	}

	public void SetSubtitleAlpha(float alpha)
	{
		if (!(_subtitleText == null))
		{
			Color color = _subtitleText.color;
			_subtitleText.color = new Color(color.r, color.g, color.b, alpha);
		}
	}

	public void ClearSubtitle()
	{
		if (!(_subtitleText == null))
		{
			_subtitleText.text = string.Empty;
			ShowSubtitle(visible: false);
		}
	}
}
