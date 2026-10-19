using ACT.Config;
using ACT.Core;
using ACT.Utility;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;
using UnityEngine.Video;
using YooAsset;

namespace ACT.UI;

public class VideoPlayerRawImage : UIBehaviour
{
	[SerializeReference]
	private RawImage videoImage;

	[SerializeReference]
	private GameObject goLoading;

	private RenderTexture _renderTexture;

	private RawFileHandle _rawFileHandle;

	private int _playVersion;

	private const int MaxPrepareRetryCount = 2;

	private VideoPlayer _videoPlayer => GameUtility.mainVideoPlayer;

	public void PlayVideo(int id)
	{
		PlayVideoInternal(id, 0);
	}

	private void PlayVideoInternal(int id, int retryCount)
	{
		int playVersion = ++_playVersion;
		ReleaseRt();
		if ((bool)goLoading)
		{
			goLoading.SetActive(value: true);
		}
		videoImage.gameObject.SetActive(value: false);
		ShortVideo data = CoreUtils.GetData(id, RuntimeConfigs.data.shortVideos);
		if (data != null)
		{
			if (!GameUtility.TryLoadRawFilePath(data.Path, out _rawFileHandle, out var filePath))
			{
				if ((bool)goLoading)
				{
					goLoading.SetActive(value: false);
				}
				return;
			}
			GameUtility.PrepareVideoFromUrl(_videoPlayer, filePath, (VideoPlayer source, RenderTexture videoRt) =>
			{
				if (playVersion != _playVersion)
				{
					if (source.targetTexture == videoRt)
					{
						source.targetTexture = null;
						source.Stop();
					}
					videoRt.Release();
					Object.Destroy(videoRt);
				}
				else if (!gameObject.activeInHierarchy)
				{
					if (source.targetTexture == videoRt)
					{
						source.targetTexture = null;
						source.Stop();
					}
					videoRt.Release();
					Object.Destroy(videoRt);
					ReleaseRt();
				}
				else if (videoRt.width <= 1 || videoRt.height <= 1)
				{
					_ = LuminApplication.LogEnabled;
					if (source.targetTexture == videoRt)
					{
						source.targetTexture = null;
						source.Stop();
					}
					videoRt.Release();
					Object.Destroy(videoRt);
					if (retryCount < 2)
					{
						PlayVideoInternal(id, retryCount + 1);
					}
					else
					{
						if ((bool)goLoading)
						{
							goLoading.SetActive(value: false);
						}
						ReleaseRt();
					}
				}
				else
				{
					_renderTexture = videoRt;
					if ((bool)goLoading)
					{
						goLoading.SetActive(value: false);
					}
					videoImage.texture = _renderTexture;
					_videoPlayer.isLooping = true;
					videoImage.gameObject.SetActive(value: true);
					_videoPlayer.Stop();
					_videoPlayer.time = 0.0;
					_videoPlayer.Play();
				}
			}, (string message) =>
			{
				if (playVersion == _playVersion)
				{
					if (retryCount < 2)
					{
						PlayVideoInternal(id, retryCount + 1);
					}
					else
					{
						_ = LuminApplication.LogEnabled;
						if ((bool)goLoading)
						{
							goLoading.SetActive(value: false);
						}
						ReleaseRt();
					}
				}
			});
		}
		else
		{
			_ = LuminApplication.LogEnabled;
		}
	}

	private void ReleaseRt()
	{
		if (_videoPlayer.targetTexture == _renderTexture)
		{
			_videoPlayer.targetTexture = null;
			_videoPlayer.Stop();
		}
		if (_rawFileHandle != null)
		{
			_rawFileHandle.Release();
			_rawFileHandle = null;
		}
		if (null != _renderTexture)
		{
			_renderTexture.Release();
			Object.Destroy(_renderTexture);
			_renderTexture = null;
		}
		if (videoImage != null)
		{
			videoImage.texture = null;
		}
	}

	private void OnApplicationPause(bool pauseStatus)
	{
		if (!pauseStatus)
		{
			ResumeVideoPlayerIfNeeded();
		}
	}

	private void OnApplicationFocus(bool hasFocus)
	{
		if (hasFocus)
		{
			ResumeVideoPlayerIfNeeded();
		}
	}

	private void ResumeVideoPlayerIfNeeded()
	{
		if (!(_renderTexture == null) && !(_videoPlayer == null) && gameObject.activeInHierarchy && !(_videoPlayer.targetTexture != _renderTexture) && !_videoPlayer.isPlaying)
		{
			_videoPlayer.Play();
		}
	}

	protected override void OnDestroy()
	{
		base.OnDestroy();
		_playVersion++;
		ReleaseRt();
	}
}
