using UnityEngine.Playables;

public class AdventureFXPlayer_Timeline : AdventureFXPlayer_Component
{
	internal PlayableDirector playableDirector;

	public override bool isLoop
	{
		get
		{
			if (playableDirector != null)
			{
				if (playableDirector.extrapolationMode != DirectorWrapMode.Loop)
				{
					return playableDirector.extrapolationMode == DirectorWrapMode.Hold;
				}
				return true;
			}
			return false;
		}
	}

	public override bool isStoped
	{
		get
		{
			if (playableDirector != null && (double)_fxPlayer.playbackTime <= playableDirector.duration)
			{
				return false;
			}
			return true;
		}
	}

	public override void Release()
	{
		Stop();
	}

	public override void Play()
	{
		if (playableDirector != null)
		{
			if (playableDirector.state == PlayState.Paused)
			{
				playableDirector.time = 0.0;
				playableDirector.Resume();
			}
			else
			{
				playableDirector.Play();
			}
		}
	}

	public override void Stop()
	{
		if (playableDirector != null)
		{
			playableDirector.Pause();
		}
	}

	public override void Pause()
	{
		if (playableDirector != null)
		{
			playableDirector.Pause();
		}
	}

	public override void Resume()
	{
		if (playableDirector != null)
		{
			playableDirector.Resume();
		}
	}

	public override void OnUpdatePlaybackSpeed(float playbackSpeed, float timeScale)
	{
		if (playableDirector != null)
		{
			playableDirector.SetPlaySpeed(playbackSpeed * timeScale);
		}
	}

	public override void OnIndependentUpdateChanged(bool value)
	{
		if (playableDirector != null)
		{
			playableDirector.timeUpdateMode = ((!value) ? DirectorUpdateMode.GameTime : DirectorUpdateMode.UnscaledGameTime);
		}
	}
}
