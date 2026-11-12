using UnityEngine;
using UnityEngine.Rendering;

public class AdventureFXPlayer_PostProcess : AdventureFXPlayer_Component
{
	[Min(0f)]
	public float postprocessFXDelay;

	[Min(0f)]
	public float postprocessFXDuration = 1f;

	public bool postprocessFXLoop;

	public bool playReverseInRemain;

	[Space]
	public AnimationCurve weightCurve;

	protected Volume _volume;

	protected bool _postprocessFXPlayed;

	public override bool isLoop => postprocessFXLoop;

	public override bool isStoped
	{
		get
		{
			if (_volume != null && _fxPlayer.playbackTime <= postprocessFXDelay + postprocessFXDuration)
			{
				return false;
			}
			return true;
		}
	}

	public override void Initialize(AdventureFXPlayer fxPlayer)
	{
		base.Initialize(fxPlayer);
		_volume = gameObject.GetComponentInChildren<Volume>();
		if (_volume != null)
		{
			_volume.isGlobal = true;
			_volume.priority = 10f;
			_volume.weight = 0f;
		}
	}

	public override void Release()
	{
		if (_volume != null)
		{
			_volume.weight = 0f;
		}
		_postprocessFXPlayed = false;
	}

	public override void Play()
	{
		if (postprocessFXDelay <= float.Epsilon)
		{
			Play_Internal();
		}
	}

	protected void Play_Internal()
	{
		if (_volume != null)
		{
			_volume.gameObject.layer = 31;
			EvaluateVolumeWeight(0f);
			_postprocessFXPlayed = true;
		}
	}

	public override void Stop()
	{
		if (_volume != null)
		{
			EvaluateVolumeWeight(0f);
			_postprocessFXPlayed = false;
		}
	}

	public override void UpdatePlayback(float dt)
	{
		if (!(_volume != null))
		{
			return;
		}
		if (postprocessFXDelay > float.Epsilon && !_postprocessFXPlayed && _fxPlayer.playbackTime >= postprocessFXDelay)
		{
			Play_Internal();
		}
		else if (!postprocessFXLoop && _postprocessFXPlayed && _fxPlayer.playbackTime >= postprocessFXDelay + postprocessFXDuration)
		{
			Stop();
		}
		else if (_postprocessFXPlayed)
		{
			float t = 0f;
			if (postprocessFXDuration > 0f)
			{
				t = (_fxPlayer.playbackTime - postprocessFXDelay) / postprocessFXDuration;
			}
			EvaluateVolumeWeight(t);
		}
	}

	public override void UpdatePlaybackInRemain(float dt)
	{
		if (playReverseInRemain && _volume != null)
		{
			float t = 0f;
			if (_fxPlayer.remainTime > 0f)
			{
				t = _fxPlayer.remainTimer / _fxPlayer.remainTime;
			}
			EvaluateVolumeWeight(t);
		}
	}

	protected void EvaluateVolumeWeight(float t)
	{
		_volume.weight = Mathf.Clamp01(weightCurve.Evaluate(t));
	}

	public override void OnHide()
	{
		if (_volume != null)
		{
			_volume.gameObject.layer = 30;
		}
	}

	public override void OnVisible()
	{
		if (_volume != null)
		{
			_volume.gameObject.layer = 31;
		}
	}
}
