using UnityEngine;

public class AdventureFXPlayer_Animation : AdventureFXPlayer_Component
{
	private const string kStartStateName = "Default";

	private const string kLoopStateName = "Loop";

	private const string kEndStateName = "End";

	internal SimpleAnimation animationController;

	protected SimpleAnimation.State _startState;

	protected SimpleAnimation.State _loopState;

	protected SimpleAnimation.State _endState;

	protected bool _animationPlayed;

	protected SimpleAnimation.State _playingState;

	public override bool isLoop
	{
		get
		{
			if ((bool)animationController)
			{
				if (_loopState != null)
				{
					return true;
				}
				if (_startState != null)
				{
					return _startState.clip.isLooping;
				}
			}
			return false;
		}
	}

	public override bool isStoped
	{
		get
		{
			if (!_animationPlayed)
			{
				return false;
			}
			if (isLoop)
			{
				return false;
			}
			if (_fxPlayer.playbackTime <= _fxPlayer.animationDelay + _startState.length)
			{
				return false;
			}
			return true;
		}
	}

	public override void Initialize(AdventureFXPlayer fxPlayer)
	{
		base.Initialize(fxPlayer);
		animationController.Initialize();
		_startState = animationController.GetState("Default");
		_loopState = animationController.GetState("Loop");
		_endState = animationController.GetState("End");
		if (fxPlayer.animationDelay > float.Epsilon)
		{
			if (animationController.isPlaying)
			{
				animationController.Stop();
			}
			animationController.playAutomatically = false;
		}
		else
		{
			animationController.playAutomatically = true;
		}
		animationController.disableOnDone = false;
		animationController.cullingMode = AnimatorCullingMode.AlwaysAnimate;
	}

	public override void Release()
	{
		Stop();
	}

	public override void Play()
	{
		if (animationController != null && _fxPlayer.animationDelay <= float.Epsilon)
		{
			Play_Internal();
		}
	}

	protected void Play_Internal()
	{
		if (!_animationPlayed)
		{
			animationController.Play("Default");
			_playingState = _startState;
			_animationPlayed = true;
		}
	}

	public override void Stop()
	{
		if (animationController != null)
		{
			animationController.Stop();
			_animationPlayed = false;
			_playingState = null;
		}
	}

	public override void Pause()
	{
		if (animationController != null && _playingState != null)
		{
			_playingState.speed = 0f;
		}
	}

	public override void Resume()
	{
		if (animationController != null && _playingState != null)
		{
			_playingState.speed = _fxPlayer.playbackSpeed * _fxPlayer.finalTimeScale;
		}
	}

	public override void UpdatePlayback(float dt)
	{
		if (!(animationController != null))
		{
			return;
		}
		if (!_animationPlayed)
		{
			if (_fxPlayer.playbackTime >= _fxPlayer.animationDelay)
			{
				Play_Internal();
			}
		}
		else if (_playingState == _startState && _loopState != null && _fxPlayer.playbackTime > _fxPlayer.animationDelay + _startState.length - _fxPlayer.animationCrossFadeTime)
		{
			if (_fxPlayer.animationCrossFadeTime > float.Epsilon)
			{
				animationController.CrossFade("Loop", _fxPlayer.animationCrossFadeTime);
			}
			else
			{
				animationController.Play("Loop");
			}
			_loopState.speed = _playingState.speed;
			_playingState = _loopState;
		}
	}

	public override void PlayInRemain()
	{
		if (_endState != null)
		{
			if (_fxPlayer.animationCrossFadeTime > float.Epsilon)
			{
				animationController.CrossFade("End", _fxPlayer.animationCrossFadeTime);
			}
			else
			{
				animationController.Play("End");
			}
			_endState.speed = _playingState.speed;
			_playingState = _endState;
		}
	}

	public override void OnUpdatePlaybackSpeed(float playbackSpeed, float timeScale)
	{
		if (animationController != null && !_fxPlayer.paused && _playingState != null)
		{
			_playingState.speed = playbackSpeed * timeScale;
		}
	}

	public override void OnIndependentUpdateChanged(bool value)
	{
		if (animationController != null && animationController.animator != null)
		{
			animationController.animator.updateMode = (value ? AnimatorUpdateMode.UnscaledTime : AnimatorUpdateMode.Normal);
		}
	}
}
