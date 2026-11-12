using UnityEngine.Playables;

public sealed class SDFacialExpressionMixer : PlayableBehaviour
{
	private const SDFacialExpression kIdleExpression = SDFacialExpression.Normal;

	private const SDFacialExpression kUnset = (SDFacialExpression)(-1);

	private SDFacialExpression _applied = (SDFacialExpression)(-1);

	private SDFacialAnimator _boundAnimator;

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
		SDFacialExpression sDFacialExpression = SDFacialExpression.Normal;
		for (int i = 0; i < inputCount; i++)
		{
			float inputWeight = playable.GetInputWeight(i);
			if (!(inputWeight <= num))
			{
				sDFacialExpression = ((ScriptPlayable<SDFacialExpressionBehaviour>)playable.GetInput(i)).GetBehaviour().expression;
				num = inputWeight;
			}
		}
		if (sDFacialExpression != _applied)
		{
			sDFacialAnimator.SetExpression(sDFacialExpression);
			_applied = sDFacialExpression;
		}
		sDFacialAnimator.SetExpressionWeight(num);
	}

	public override void OnGraphStart(Playable playable)
	{
		ResetToIdle();
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		ResetToIdle();
	}

	public override void OnGraphStop(Playable playable)
	{
		ResetToIdle();
	}

	public override void OnPlayableDestroy(Playable playable)
	{
		ResetToIdle();
	}

	private void ResetToIdle()
	{
		if (_boundAnimator != null)
		{
			if (_applied != SDFacialExpression.Normal)
			{
				_boundAnimator.SetExpression(SDFacialExpression.Normal);
			}
			_boundAnimator.SetExpressionWeight(0f);
		}
		_applied = (SDFacialExpression)(-1);
	}
}
