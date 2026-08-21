namespace DG.Tweening.Core;

public abstract class ABSSequentiable
{
	internal TweenType tweenType;

	internal float sequencedPosition;

	internal float sequencedEndPosition;

	internal TweenCallback onStart;
}
