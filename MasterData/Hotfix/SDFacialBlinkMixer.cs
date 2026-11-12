using UnityEngine;
using UnityEngine.Playables;

public sealed class SDFacialBlinkMixer : PlayableBehaviour
{
	private SDFacialAnimator _boundAnimator;

	private float _lastBlinkWeight = -1f;

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		SDFacialAnimator sDFacialAnimator = playerData as SDFacialAnimator;
		if (sDFacialAnimator == null)
		{
			return;
		}
		_boundAnimator = sDFacialAnimator;
		int inputCount = playable.GetInputCount();
		float num = 0f;
		for (int i = 0; i < inputCount; i++)
		{
			float inputWeight = playable.GetInputWeight(i);
			if (!(inputWeight <= 0f))
			{
				num += inputWeight * ((ScriptPlayable<SDFacialBlinkBehaviour>)playable.GetInput(i)).GetBehaviour().closedWeight;
			}
		}
		ApplyBlink(Mathf.Clamp01(num));
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		ResetBlink();
	}

	public override void OnGraphStop(Playable playable)
	{
		ResetBlink();
	}

	public override void OnPlayableDestroy(Playable playable)
	{
		ResetBlink();
	}

	private void ApplyBlink(float blink)
	{
		if (!(_boundAnimator == null) && !Mathf.Approximately(blink, _lastBlinkWeight))
		{
			_boundAnimator.SetBlink(blink);
			_lastBlinkWeight = blink;
		}
	}

	private void ResetBlink()
	{
		if (_boundAnimator != null && !Mathf.Approximately(_lastBlinkWeight, 0f))
		{
			_boundAnimator.SetBlink(0f);
		}
		_lastBlinkWeight = -1f;
	}
}
