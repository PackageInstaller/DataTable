using Config;

public sealed class TipsAudio : AudioBase
{
	public enum PlayTiming
	{
		OnEnable,
		OnDisable,
		Manual
	}

	public PlayTiming playTiming;

	private CriAtomExPlayback curPlayback = new CriAtomExPlayback(uint.MaxValue);

	public bool IsPlaying
	{
		get
		{
			if (curPlayback.id != uint.MaxValue)
			{
				return curPlayback.status == CriAtomExPlayback.Status.Playing;
			}
			return false;
		}
	}

	private void OnEnable()
	{
		if (playTiming == PlayTiming.OnEnable)
		{
			Play();
		}
	}

	private void OnDisable()
	{
		if (playTiming == PlayTiming.OnDisable)
		{
			Play();
		}
	}

	private AudioManager TryGetAudioManagerInst()
	{
		if (playTiming != PlayTiming.OnDisable)
		{
			return AudioManager.Instance;
		}
		return AudioManager.mInstance;
	}

	public void Play()
	{
		AudioManager audioManager = TryGetAudioManagerInst();
		if ((bool)audioManager)
		{
			if (mUIAudioID != -1 && ConfigHelper.GetInstance().TryGetConfig<UIAudio>(mUIAudioID, out var config) && ConfigHelper.GetInstance().TryGetConfig<CommonAudio>(config.AudioID, out var config2))
			{
				audioManager.Play(config.SourceKey, config2.CueSheet, config2.CueName, config2.UseStream);
			}
			else if (!string.IsNullOrEmpty(mCueSheet) && !string.IsNullOrEmpty(mCueName))
			{
				audioManager.Play("effect", mCueSheet, mCueName, !string.IsNullOrEmpty(mCueAwb));
			}
		}
	}
}
