namespace DG.Tweening.Core;

internal class SequenceCallback : ABSSequentiable
{
	public SequenceCallback(float sequencedPosition, TweenCallback callback)
	{
		tweenType = TweenType.Callback;
		base.sequencedPosition = sequencedPosition;
		onStart = callback;
	}
}
