using UnityEngine;
using UnityEngine.Playables;

public sealed class PlayFXPlayableBehaviour : PlayableBehaviour
{
	public PlayFXPlayableClip.Mode mode;

	public GameObject fxPrefab;

	public GameObject fxInstance;

	public bool playOnceInLoop;

	public bool stopFXOnFinish;

	public GameObject bindOwner;

	private AdventureFXPlayer _fxPlayer;

	private long _fxToken;

	private bool _playedOnce;

	public override void OnPlayableDestroy(Playable playable)
	{
		_fxPlayer = null;
		_fxToken = 0L;
		_playedOnce = false;
	}

	public override void OnGraphStop(Playable playable)
	{
		if (Application.isPlaying && stopFXOnFinish && _fxPlayer != null && _fxPlayer.token == _fxToken && _fxPlayer.isPlaying)
		{
			_fxPlayer.Stop();
			_fxPlayer = null;
			_fxToken = 0L;
		}
	}

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		if (!Application.isPlaying)
		{
			return;
		}
		if (mode == PlayFXPlayableClip.Mode.PlayFX)
		{
			if (fxPrefab == null)
			{
				return;
			}
			if (playOnceInLoop)
			{
				if (_playedOnce)
				{
					return;
				}
				_playedOnce = true;
			}
			if (bindOwner != null)
			{
				_fxPlayer = AdventureFXPlayer.PlayFX(fxPrefab, (float)playable.GetSpeed(), bindOwner.transform.position, bindOwner.transform.rotation);
				_fxToken = _fxPlayer.token;
				_fxPlayer.Bind(bindOwner);
				_fxPlayer.syncSlotRotation = true;
				_fxPlayer.syncSlotScale = true;
				_fxPlayer.syncNode = bindOwner.transform;
			}
		}
		else if (mode == PlayFXPlayableClip.Mode.PlaySelfFX)
		{
			if (fxInstance == null)
			{
				return;
			}
			_fxPlayer = AdventureFXPlayer.Setup(fxInstance);
			if (!_fxPlayer.isPlaying)
			{
				_fxPlayer.Play((float)playable.GetSpeed());
				_fxToken = _fxPlayer.token;
				if (bindOwner != null)
				{
					_fxPlayer.Bind(bindOwner);
					_fxPlayer.syncSlotRotation = true;
					_fxPlayer.syncSlotScale = true;
					_fxPlayer.syncNode = bindOwner.transform;
				}
				else
				{
					_fxPlayer.Bind(fxInstance);
				}
			}
		}
		else if (mode == PlayFXPlayableClip.Mode.StopSelfFX && !(fxInstance == null))
		{
			_fxPlayer = AdventureFXPlayer.Setup(fxInstance);
			if (_fxPlayer.isPlaying)
			{
				_fxPlayer.Stop();
			}
		}
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		OnGraphStop(playable);
	}
}
